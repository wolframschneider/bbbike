#!/usr/bin/perl
# -*- mode:perl;coding:iso-8859-1; -*-
 
use strict;
use FindBin;
use lib (
	 $FindBin::RealBin,
	 "$FindBin::RealBin/..",
	);
use utf8;

use File::Basename qw(basename);
use File::Temp qw(tempfile);
use Getopt::Long;
use HTML::Entities ();

use Typ2Legend::XPM;

use BBBikeUtil qw(is_in_path);

sub usage (;$);

my $output_dir;
my $force;
my @ignore;
my @keep;
my $title;
my $encoding = 'utf-8';
my $debug_parser;
my $xpm2png_converter;
GetOptions("o=s"       => \$output_dir,
	   "f"         => \$force,
	   'ignore=s@' => sub { push @ignore, split /,/, $_[1] },
	   'keep=s@'   => sub { push @keep,   split /,/, $_[1] },
	   'encoding=s' => \$encoding,
	   'title=s'   => \$title,
	   'debug-parser' => \$debug_parser,
	   'xpm2png-converter=s' => \$xpm2png_converter,
	  )
    or usage;
$output_dir or usage "-o is mandatory";

my $in_file = shift;
@ARGV and usage;

if (defined $xpm2png_converter) {
    if ($xpm2png_converter eq 'Imager::Image::Xpm') {
	require Imager::Image::Xpm;
    } elsif ($xpm2png_converter eq 'convert') {
	is_in_path('convert')
	    or die "'convert' is not available";
    } else {
	die "Unknown --xpm2png-converter, please use either 'Imager::Image::Xpm' or 'convert'";
    }
} else {
    if ($^O ne 'MSWin32' # there's an unrelated tool named "convert" under Windows
	&& is_in_path('convert')
       ) {
	$xpm2png_converter = 'convert';
    } elsif (eval { require Imager::Image::Xpm; 1 }) {
	$xpm2png_converter = 'Imager::Image::Xpm';
    } else {
	die <<EOF;
Cannot find either the 'convert' tool from the 'imagemagick' package,
mode:perl;coding:iso-8859-1or the CPAN module Imager::Image::Xpm,
cannot proceed...
EOF
    }
}

my $ifh;
if (defined $in_file) {
    open $ifh, '<', $in_file
	or die "Can't open $in_file: $!";
} else {
    $ifh = \*STDIN;
}

my %ignore;
my %keep;
for my $def (
	     [\%ignore, \@ignore],
	     [\%keep, \@keep],
	    ) {
    %{$def->[0]} = map {
	my $type = $_;
	if ($type !~ m{^(polygon|line|point)/0x}) { die "Arguments to -ignore/-keep should be in the form polygon/0xabcd" }
	($type,1);
    } @{$def->[1]};
}

my $item_type_qr = qr{^(_polygon|_line|_point)$};

my @items;
{
    my $in_section;
    my $do_parse_xpm;
    my $current_xpm_key;
    my @parse_xpm_lines;
    my $item;
    my $debug_last_item;
    my $debug_item_counter = 0;
    my $finalize_xpm_object = sub {
	if ($item->{ItemType} eq 'point') {
	    Typ2Legend::XPM::_perform_alpha_hack(\@parse_xpm_lines);
	    $item->{$current_xpm_key} = join("\n", '/* XPM */', 'static char *image[] = {', @parse_xpm_lines);
	} else {
	    $item->{$current_xpm_key . "_object"} = Typ2Legend::XPM->new(\@parse_xpm_lines);
	}
	$do_parse_xpm = 0;
	@parse_xpm_lines = ();
    };
    while(<$ifh>) {
	s{\r}{};
	if ($debug_parser) {
	    if ($item && $item ne $debug_last_item) {
		$debug_item_counter++;
		$debug_last_item = $item;
	    }
	    my $state =
		($in_section ? 'S' : ' ') .
		    ($item ? sprintf("I%03d", $debug_item_counter) : '    ') .
			($do_parse_xpm
			 ? ('X ' .
			    ($current_xpm_key eq 'XPM' ? 'X' :
			     $current_xpm_key eq 'DayXPM' ? 'D' :
			     $current_xpm_key eq 'NightXPM' ? 'N' : '?'
			    ) .
			    sprintf("%02d", scalar @parse_xpm_lines)
			   )
			 : '    '
			);
	    print STDERR $state . " " . $_;
	}
	if ($do_parse_xpm) {
	    if (/^[}"]/) {
		chomp;
		push @parse_xpm_lines, $_;
	    } else {
		$finalize_xpm_object->();
		redo; # premature end of XPM data; with TYPViewer output XPM data always ends like this
	    }
	    if (/^};/) {
		$finalize_xpm_object->();
	    }
	} elsif (m{^\s*\[(.*)\]}) { # may have preceding spaces in TYPViewer output
	    my $tag = $1;
	    if ($tag =~ m{^end$}i) { # may be "End" in TYPViewer output
		undef $in_section;
	    } else {
		$in_section = $tag;
		if ($tag =~ $item_type_qr) {
		    (my $itemtype = $1) =~ s{^_}{};
		    $item = Typ2Legend::Item->new({ItemType => $itemtype});
		    push @items, $item;
		}
	    }
	} elsif ($in_section) {
	    if ($in_section =~ $item_type_qr) {
		if (m{^(XPM|DayXPM|NightXPM)=(.*)}i) {
		    $do_parse_xpm = 1;
		    $current_xpm_key = $1;
		    chomp(my $xpm_head = $2);
		    $current_xpm_key =~ s{xpm}{XPM}i; # normalize (TYPViewer has "Xpm", ati.land.cz had "XPM")
		    @parse_xpm_lines = $xpm_head;
		} elsif (m{^String\d+=([\dx]+),(.*)}) {
		    $item->{String}->{$1} = $2;
		} elsif (m{^Type=(.*)}) {
		    my $type = $1;
		    $type =~ s{^(0x)0(..)$}{$1$2}; # remove leading zero, found in the typdecomp files
		    $item->{Type} = $type;
		} elsif (m{^(SubType|LineWidth|BorderWidth)=(.*)}) {
		    $item->{$1} = $2;
		}
	    }
	}
    }
}

# xpm transformation
for my $item (@items) {
    my $itemkey     = $item->itemkey;
    my $itemlongkey = $item->itemlongkey;
    if ($item->{"XPM_object"}) { # XXX Can DayXPM_object/NightXPM_object happen at this point?
	my $ret;
	if ($item->{LineWidth}) {
	    $ret = $item->{"XPM_object"}->transform(linewidth => $item->{LineWidth}, borderwidth => $item->{BorderWidth});
	} else {
	    $ret = $item->{"XPM_object"}->transform;
	}
	if ($ret->{'day'}) {
	    $item->{DayXPM} = $ret->{'day'}->as_string;
	}
	if ($ret->{'night'}) {
	    $item->{NightXPM} = $ret->{'night'}->as_string;
	}
	if ($ret->{'day+night'}) {
	    $item->{XPM} = $ret->{'day+night'}->as_string;
	}
	delete $item->{"XPM_object"};
    }
}

{
    if (-d $output_dir && $force) {
	require File::Path;
	File::Path::rmtree($output_dir);
    }
    mkdir $output_dir or die "Can't create $output_dir: $!";

    my $png_i = 0;
    my $output_html = "$output_dir/index.html";
    open my $ofh, ">", $output_html
	or die "Can't write to $output_html: $!";
    binmode $ofh, ":encoding($encoding)";
    print $ofh <<EOF;
<html>
 <head>
  <title>Legende</title>
  <meta http-equiv="content-type" content="text/html; charset=$encoding" />
  <style type="text/css"><!--
  table		  { border-collapse:collapse; }
  th,td           { border:1px solid black; padding: 1px 5px 1px 5px; }
  body		  { font-family:sans-serif; }
  .sml            { font-size: x-small; }
  .daypng         { border:2px solid white; }
  .nightpng       { border:2px solid white; } /* the "black" experiment was confusing */
  --></style>
  </head>
 <body>
EOF
    if ($title) {
	print $ofh "<h1>"._htmlify($title)."</h1>\n";
    }
    print $ofh <<EOF;
  <table cellpadding="1" cellspacing="0">
   <tr>
    <th>Symbol</th>
    <th>deutsch</th>
    <th>english</th>
    <th class="sml">garmin item id</th>
   </tr>
EOF

    for my $item (@items) {
	my $itemkey     = $item->itemkey;
	my $itemlongkey = $item->itemlongkey;
	next if $ignore{$itemkey} || $ignore{$itemlongkey};
	if (%keep) {
	    next if !$keep{$itemkey} && !$keep{$itemlongkey};
	}
	for my $xpm_type (qw(XPM DayXPM NightXPM)) {
	    if ($item->{$xpm_type}) {
		my $out_image = $output_dir . "/" . sprintf("%04d.png", $png_i++);
		my($tmpfh,$tmpfile) = tempfile(SUFFIX => ".xpm", UNLINK => 1)
		    or die $!;

		my $xpm_data = $item->{$xpm_type};
		print $tmpfh $xpm_data;
		close $tmpfh or die $!;
		xpm2png($tmpfile, $out_image)
		    or die "Failure while converting $tmpfile to $out_image, item " . _item_name($item) . ', xpm: ' . $item->{$xpm_type};
		unlink $tmpfile;
		(my $png_type = $xpm_type) =~ s{XPM}{PNG};
		$item->{$png_type} = basename $out_image;
	    }
	}
	print $ofh "<tr><td>";
	if ($item->{PNG}) {
	    print $ofh qq{<img src="$item->{PNG}" />};
	} elsif ($item->{NightPNG}) {
	    print $ofh qq{<img title="day image" class="daypng" src="$item->{DayPNG}" /> <img title="night image" class="nightpng" src="$item->{NightPNG}" />};
	} elsif ($item->{DayPNG}) { # DayPNG without NightPNG, treat like single PNG (seen with TYPViewer, but not ati.land.cz)
	    print $ofh qq{<img src="$item->{DayPNG}" />};
	}
	print $ofh "</td><td>";
	my $de_label = $item->{String}->{'0x02'} || '';
	my $en_label = $item->{String}->{'0x00'} || '';
	print $ofh _htmlify($de_label);
	print $ofh "</td><td>";
	print $ofh _htmlify($en_label);
	print $ofh qq{</td><td class="sml">};
	print $ofh $item->{ItemType} . "/" . $item->{Type} . ($item->{SubType} ? "/" . $item->{SubType} : "");
	print $ofh "</td></tr>\n";
    }

    print $ofh <<EOF;
  </table>
 </body>
</html>
EOF
    close $ofh
	or die "Problem while closing: $!";
}

sub _htmlify {
    HTML::Entities::encode_entities_numeric($_[0], '<>&"\200-');
}

# for debugging
sub _item_name {
    my $item = shift;
    $item->{String}->{'0x02'} || $item->{String}->{'0x00'} || '???';
}

# for debugging
sub _item_id {
    my $item = shift;
    $item->{ItemType} . "/" . $item->{Type} . ($item->{SubType} ? "/" . $item->{SubType} : "");
}

sub xpm2png {
    my($xpm_file, $png_file) = @_;
    if ($xpm2png_converter eq 'convert') {
	system("convert", "-gamma", "2.2", $xpm_file, $png_file); # XXX why is setting the gamma value necessary? (seen with ImageMagick 6.8.0-7 on freebsd 9.2) --- and still 2.2 is not correct
	return($? == 0 ? 1 : 0);
    } else {
	if (!eval { Imager::Image::Xpm->new(file => $xpm_file)->write(file => $png_file, type => 'png'); 1 }) {
	    warn "Conversion failed: $@";
	    0;
	} else {
	    1;
	}
    }
}

sub usage (;$) {
    my $msg = shift;
    warn $msg, "\n" if $msg;
    die <<EOF;
usage: $0 -o outputdir [-encoding ...] [-igntype ...,...] < decompiled_typ_file.TXT
EOF
}

{
    package
	Typ2Legend::Item;

    sub new {
	my($class, $item) = @_;
	bless $item, $class;
    }

    sub itemkey {
	my $self = shift;
	$self->{ItemType}.'/'.$self->{Type};
    }

    sub itemlongkey {
	my $self = shift;
	$self->{ItemType}.'/'.$self->{Type}.($self->{SubType}?"/$self->{SubType}":"");
    }
}

__END__

=head1 NAME

typ2legend.pl - create a HTML legend from a decompiled .TYP file

=head1 DESCRIPTION

This script created a HTML page together with .png images for a .TYP
file. As input a decompiled .TYP file (usually with extension .TXT)
has to be provided. See L<https://sites.google.com/site/sherco40/> for
an offline .TYP file editor and decompiler.

=head1 EXAMPLES

Currently the legend for the bbbike/garmin map is best created as
such:

    perl ./miscsrc/typ2legend.pl < misc/mkgmap/typ/M000002a.TXT -f -o tmp/typ_legend -title "Legende f�r die BBBike-Garmin-Karte" -keep polygon/0x0a,polygon/0x0c,polygon/0x0d,polygon/0x16,polygon/0x19,polygon/0x1a,polygon/0x3c,polygon/0x4e,polygon/0x50,line/0x01,line/0x03,line/0x04,line/0x05,line/0x06,line/0x0f,line/0x13,line/0x14,line/0x1a,line/0x1c,line/0x1e,line/0x2c,line/0x2d,line/0x2e,line/0x2f,line/0x30,line/0x31,line/0x32,line/0x33,line/0x34,line/0x35,line/0x36,line/0x37,line/0x38,line/0x39,line/0x3a,line/0x3b,line/0x3c,line/0x3d,line/0x3e,line/0x3f,point/0x70,point/0x71,point/0x74/0x01,point/0x74/0x02

The generated html file may be found in C<tmp/typ_legend/index.html>.

"keep" lists only items which are actually used in the bbd data and
converted with bbd2osm.

For OSM data the "keep" list is not necessary. Here the legend may be
created with:

    perl ./miscsrc/typ2legend.pl < misc/mkgmap/typ/M000002a.TXT -f -o tmp/typ_osm_legend -title "Legende f�r die OSM-Garmin-Karte"

The generated html file may be found in C<tmp/typ_osm_legend/index.html>.

The generation commands are also in F<misc/Makefile>, look for the
C<typ-legend-all> target.

=head1 NOTES

In special layers of the bbbike/garmin map the following items are
also used:

=over

=item * line/0x040 (Ampelphasen)

=item * point/0x073* (categorized fragezeichen)

=back

=head1 HISTORY

This script was written around the decompiled output which was
produced by the TYP editor software found at
L<http://ati.land.cz/gps/typdecomp/editor.cgi>. This output had some
bugs which needed some helper options (-nopngheuristic, -noprefer15).
Since 2014 the site was shutdown, and this script now tries to handle
the decompiled output created by TYPViewer
(L<https://sites.google.com/site/sherco40/>).

Following historical notes applying to the old ati.land.cz output.

The decompiled .TXT file from
L<http://ati.land.cz/gps/typdecomp/editor.cgi> is ambiguous. The
following color style types cannot be distinguished and may be 

=over

=item polygon: 15 vs. 8 and bitmapped line: 7 vs. 0

By default polygon 8 resp. line 0 is used. With the option
C<-noprefer15> the other color style type may be chosen.

=item polygon: 13 vs. 11 and bitmapped line: 5 vs. 3

By default polygon 11 resp. line 3 is used. There's no cmdline option
yet (but Typ2Legend::XPM has internally the option C<prefer13>).

=back

=head1 BUGS

=over

=item * Does not handle alpha information for POIs. Currently there's
just a hack to convert full alpha transparency into a transparent
color.

=back

=head1 AUTHOR

Slaven Rezic

=head1 SEE ALSO

L<Typ2Legend::XPM>.

=cut
