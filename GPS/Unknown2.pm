# -*- perl -*-

#
# $Id: Unknown2.pm,v 1.3 2002/02/10 21:26:50 eserte Exp eserte $
# Author: Slaven Rezic
#
# Copyright (C) 2001 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: eserte@cs.tu-berlin.de
# WWW:  http://user.cs.tu-berlin.de/~eserte/
#

package GPS::Unknown2;
require GPS;
push @ISA, 'GPS';

use strict;

sub magics { ('^\$(GPGSA|GPGSV|GPRMC|PGRMC|PGRME|PGRMI|PGRMO|PGRMT|PGRMV)') }

sub convert_to_route {
    my($self, $file, %args) = @_;

    my($fh, $lines_ref) = $self->overread_trash($file, %args);
    die "File $file does not match" unless $fh;

    require Karte::GPS;
    my $obj = $Karte::GPS::obj;
    $Karte::GPS::obj = $Karte::GPS::obj if 0; # peacify -w

# XXX noch nicht zufriedenstellend... ist es �berhaupt richtig? au�erdem
# zu ungenau....

    my @res;
    my $check = sub {
	my $line = shift;
	chomp;
	if (m|^\$GPRMC|) {
	    my(@l) = split(',', $_);
	    my $breite_raw = $l[3]; # N is positive
	    my $ns         = $l[4];
	    my $laenge_raw = $l[5]; # E is positive
	    my $ew         = $l[6];
	    $breite_raw *= -1 if ($ns eq 'S');
	    $laenge_raw *= -1 if ($ew eq 'W');

	    my($breite_min, $breite_dec) = split(/\./, $breite_raw);
	    my($laenge_min, $laenge_dec) = split(/\./, $laenge_raw);
	    my($breite, $laenge);
	    $breite_min =~ /^(.*)(..)$/;
	    ($breite, $breite_min) = ($1, $2);
	    $laenge_min =~ /^(.*)(..)$/;
	    ($laenge, $laenge_min) = ($1, $2);

	    $breite_min = $breite_min/60;
	    $laenge_min = $laenge_min/60;
	    $breite_dec = ("0.".$breite_dec)/60;
	    $laenge_dec = ("0.".$laenge_dec)/60;
	    $breite += $breite_min + $breite_dec;
	    $laenge += $laenge_min + $laenge_dec;

	    my($x,$y) = $obj->map2standard($laenge, $breite);
	    if (!@res || ($x != $res[-1]->[0] ||
			  $y != $res[-1]->[1])) {
		push @res, [$x, $y];
	    }
	}
    };

    $check->($_) foreach @$lines_ref;
    while(<$fh>) {
	$check->($_);
    }

    close $fh;

    @res;
}

1;

__END__
