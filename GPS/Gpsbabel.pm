# -*- perl -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 2005,2008,2012,2013,2015,2016,2022 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://www.rezic.de/eserte/
#

package GPS::Gpsbabel;
require GPS;
push @ISA, 'GPS';

use strict;
use vars qw($VERSION $GPSBABEL $DEBUG);
$VERSION = '1.21';

use File::Basename qw(dirname);
use BBBikeUtil qw(is_in_path bbbike_root);

BEGIN {
    if (!eval '
use Msg qw(frommain);
1;
') {
	warn $@ if $@;
	eval 'sub M ($) { $_[0] }';
	eval 'sub Mfmt { sprintf(shift, @_) }';
	eval 'sub Msg::get_lang { "en" }';
    }
}

my %magics =
    ('pcx' => ['^H  SOFTWARE NAME & VERSION'],
     'gpx' => ['^('.$GPS::_UTF8_BOM.')?<\?xml\s+'],
    );

my $current_gpsbabel_version = '1.5.3'; # December 2016

sub magics {
    map { @$_ } values %magics;
}

sub convert_to_route {
    my($self, $file, %args) = @_;
    if (!$self->gpsbabel_available) {
	die M("gpsbabel ist nicht installiert");
    }

    my($fh, $lines_ref) = $self->overread_trash($file, %args);
    die "File $file does not match" unless $fh;

    my $input_format;
 GET_INPUT_FORMAT:
    for my $last_line (@$lines_ref) {
	while(my($test_input_format, $magics) = each %magics) {
	    for my $magic (@$magics) {
		if ($last_line =~ /$magic/) {
		    $input_format = $test_input_format;
		    last GET_INPUT_FORMAT;
		}
	    }
	}
    }
    if (!$input_format) {
	die "Strange: Cannot find magic in @$lines_ref";
    }

    require File::Temp;
    my($ofh, $ofilename) = File::Temp::tempfile(UNLINK => 1);
    while(<$fh>) {
	print $ofh $_;
    }
    close $fh;
    close $ofh;

    my $s = $self->convert_to_strassen_using_gpsbabel
	($ofilename,
	 title => undef, # XXX
	 input_format => $input_format,
	);
    unlink $ofilename unless $File::Temp::KEEP_ALL;

    my @coords;
    $s->init;
    while(1) {
	my $ret = $s->next;
	last if !@{ $ret->[Strassen::COORDS()] };
	push @coords, map { [ split /,/ ] } @{ $ret->[Strassen::COORDS()] };
    }

    @coords;
}

# Note: in the case of .gpx as input file gpsbabel is not used.
sub convert_to_strassen_using_gpsbabel {
    my($self, $file, %args) = @_;
    my $title = $args{title} || $file;
    my $input_format = $args{input_format} || die "input_format is missing";
    my($gpxfile, $tmpfile);
    if ($input_format ne 'gpx') {
	require File::Temp;
	(undef,$tmpfile) = File::Temp::tempfile(UNLINK => 1);
	my @cmd = ("-t",
		   "-i", $input_format, "-f", $file,
		   "-o", "gpx", "-F", $tmpfile,
		  );
	warn "Run\n    @cmd\n    ...\n" if $DEBUG;
	$self->run_gpsbabel([@cmd]);
	$gpxfile = $tmpfile;
    } else {
	$gpxfile = $file;
    }

    require Strassen::GPX;
    my $s = Strassen::GPX->new($gpxfile, cat => "#000080");
    $s->set_global_directives({title => [$title]});

    if (defined $tmpfile) {
	unlink $tmpfile unless $File::Temp::KEEP_ALL;
    }

    $s;
}

sub strassen_to_gpsbabel {
    my($self, $s, $otype, $ofile, %args) = @_;
    my $as = delete $args{'as'} || 'track';
    die "Unhandled arguments: " . join(" ", %args) if %args;

    require File::Temp;
    require Strassen::GPX;

    my $s_gpx = Strassen::GPX->new($s);
    my $xml_res = $s_gpx->Strassen::GPX::bbd2gpx(-as => $as);

    my($ifh,$ifile) = File::Temp::tempfile(SUFFIX => ".gpx",
					   UNLINK => 1);
    print $ifh $xml_res
	or die "While writing to $ifile: $!";
    close $ifh
	or die "While closing $ifile: $!";

    $self->run_gpsbabel([($as eq 'track' ? '-t' : '-r'),
			 "-i", "gpx", "-f", $ifile,
			 "-o", $otype, "-F", $ofile,
			]);
    unlink $ifile unless $File::Temp::KEEP_ALL;
}

# May be called also as a static method
sub gpsbabel_available {
    my($self, $new_gpsbabel) = @_;
    $new_gpsbabel = "gpsbabel" if !$new_gpsbabel && !$GPSBABEL;
    local $ENV{PATH} = $ENV{PATH};
    if ($^O eq 'MSWin32') {
	# Maybe bundled together with BBBike:
	$ENV{PATH} .= ";" . dirname(bbbike_root()) . "\\gpsbabel";
	# With 1.5.3 gpsman comes with a proper Windows installer
	$ENV{PATH} .= ";" . $self->gpsbabel_recommended_path;
    } else {
	$ENV{PATH} .= ";" . $self->gpsbabel_recommended_path;
    }
    if ($new_gpsbabel) {
	my $found_new_gpsbabel = is_in_path($new_gpsbabel);
	if ($found_new_gpsbabel) {
	    $GPSBABEL = $found_new_gpsbabel;
	    return $GPSBABEL;
	} else {
	    return undef;
	}
    } else {
	return is_in_path($GPSBABEL);
    }
}

sub gpsbabel_supports {
    my($self, $fileformat) = @_;
    die "gpsbabel_supports can currently only check if 'gpsman' support is built in.\n"
	if $fileformat ne 'gpsman';
    open my $ofh, '-|', 'gpsbabel', '-h' or die $!;
    while(<$ofh>) {
	if (/\b\Q$fileformat\E\b/) {
	    return 1;
	}
    }
    return 0;
}

# May be called also as a static method
sub gpsbabel_recommended_path {
    if ($^O eq 'MSWin32') {
	require Win32Util;
	Win32Util::get_program_folder() . "\\gpsbabel";
    } else {
	"$ENV{HOME}/.bbbike/external/gpsbabel-$current_gpsbabel_version";
    }
}

# May be called also as a static method
sub gpsbabel_download_location {
    'http://www.gpsbabel.org/download.html';
}

sub run_gpsbabel {
    my($self, $cmdargs) = @_;
    $self->gpsbabel_available; # make sure it is available
    my @cmd = ($GPSBABEL, @$cmdargs);
    warn "Run\n    @cmd\n    ...\n" if $DEBUG;
    my $stderr;
    if (eval { require IPC::Run; defined &IPC::Run::run }) {
	my($stdout,$stdin);
	my $disable_tk_stderr = defined &Tk::Exists && Tk::Exists($main::top) && $main::top->can("RedirectStderr") && Tk::Exists($main::top->StderrWindow);
	$main::top->RedirectStderr(0) if $disable_tk_stderr;
	IPC::Run::run(\@cmd, \$stdin, \$stdout, \$stderr);
	$main::top->RedirectStderr(1) if $disable_tk_stderr;
    } else {
	system @cmd;
    }
    if ($? != 0) {
	my $msg;
	if ($^O eq 'linux' && $stderr =~ m{could not claim interface}) {
	    if (Msg::get_lang() eq 'en') {
		$msg = <<EOF;
Cannot write to GPS device using gpsbabel. Maybe the problem can be solved by following instructions on:

    http://www.gpsbabel.org/os/Linux_Hotplug.html

Detail error message:
$stderr

Exit code: $?

Command: @cmd
EOF
	    } else {
		$msg = <<EOF;
Es konnte nicht mit gpsbabel auf das GPS-Ger�t geschrieben werden. M�glicherweise kann das Problem durch Befolgen der Anweisungen auf:

    http://www.gpsbabel.org/os/Linux_Hotplug.html

behoben werden.

Detaillierte Fehlermeldung:
$stderr

Exitcode: $?

Kommando: @cmd
EOF
	    }
	} else {
	    if (Msg::get_lang() eq 'en') {
		$msg = <<EOF;
A problem occurred:
$stderr

Exit code: $?

Command: @cmd
EOF
	    } else {
		$msg = <<EOF;
Ein Problem ist aufgetreten:
$stderr

Exitcode: $?

Kommando: @cmd
EOF
	    }
	}
	if (defined &main::status_message) {
	    main::status_message($msg, "die");
	} else {
	    die $msg;
	}
    }
}

1;

__END__
