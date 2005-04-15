# -*- perl -*-

#
# $Id: GPS.pm,v 1.9 2004/12/30 13:32:33 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 2001,2004 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: eserte@users.sourceforge.net
# WWW:  http://bbbike.sourceforge.net
#

# XXX rename to BBBikeGPS, to avoid conflicts with GPS:: namespace
# XXX no --- BBBikeGPS is already taken...
package GPS;

use strict;
use vars qw(@gps);

@gps = qw(GpsmanData Unknown1 Unknown2 G7toWin_2 G7toWin_ASCII Ovl WaypointPlus MPS Gardown);

sub new { bless {}, shift }

sub all { @gps }

sub preload {
    my $self = shift;
    my $mod = shift;
    my $fullmod = 'GPS::' . $mod;
    eval "require $fullmod";
    die $@ if $@;
    $fullmod;
}

sub transfer_to_file { 1 }

sub transfer {
    my($self, %args) = @_;
    my $file = $args{-file} or die "-file argument is missing";
    my $res = $args{-res} or die "-res argument is missing";
    open(F, ">$file") or die $!;
    binmode F;
    print F $res;
    close F;
}

sub magics {
    my $self = shift;
    die "No magics for $self defined";
}

# check for magic
sub check {
    my $self = shift;
    my $file = shift;
    my(%args) = @_;

    my($fh, $lines_ref) = $self->overread_trash($file, %args);
    defined $fh;
}

# Return ($fh, \@lines)
# $fh is a filehandle or undef
# @lines is an array reference of the magic lines
sub overread_trash {
    my $self = shift;
    my $file = shift;
    my(%args) = @_;

    require Symbol;
    my $fh = Symbol::gensym();

    my(@magics) = $self->magics;

    my @last_lines;

    my $found = 0;

    open($fh, $file) or die "Die Datei $file kann nicht ge�ffnet werden: $!";
    binmode $fh;
 FILETRY: {
	while(<$fh>) {
	    if (@magics == 1) {
		if (/$magics[0]/) {
		    push @last_lines, $_;
		    $found = 1;
		    last FILETRY;
		}
		last FILETRY if (!$args{-fuzzy});
	    } else {
		if (@last_lines == @magics) {
		    shift @last_lines;
		}
		push @last_lines, $_;
		if (@last_lines == @magics) {
		TRY: {
			for(my $i = 0; $i<=$#last_lines; $i++) {
			    last TRY if ($last_lines[$i] !~ /$magics[$i]/);
			}
			$found = 1;
			last FILETRY;
		    }
		    last FILETRY if (!$args{-fuzzy});
		}
	    }
	}
    }

    if ($found) {
	($fh, \@last_lines);
    } else {
	close $fh;
	(undef, []);
    }
}

1;

__END__
