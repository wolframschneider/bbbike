# -*- perl -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 2009 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://www.rezic.de/eserte/
#

# Hmmm... XXXX

package BBBikeCGIAPI;

use strict;
use vars qw($VERSION);
$VERSION = '0.01';

use JSON::XS qw();

require Karte::Polar;
require Karte::Standard;

sub action {
    my($action, $q) = @_;
    if ($action !~ m{^(revgeocode)$}) {
	die "Invalid action $action";
    }
    my $func = "action_$action";
    no strict 'refs';
    &{$func}($q);
}

sub action_revgeocode {
    my $q = shift;
    my($lon) = $q->param('lon');
    my($lat) = $q->param('lat');

    if (defined $q->param('latlon')) {
	($lat, $lon) = split /,/, $q->param('latlon');
    }
    elsif (defined $q->param('lonlat')) {
	($lon, $lat) = split /,/, $q->param('lonlat');
    }

    $lat eq '' and die "lat is missing";
    $lon eq '' and die "lon is missing";

    no warnings 'once';
    my($x,$y) = $main::data_is_wgs84 ? ($lon,$lat) : $Karte::Polar::obj->map2standard($lon,$lat);

    # XXX Die Verwendung von main::... bricht, wenn bbbike.cgi als
    # Apache::Registry-Skript ausgef�hrt wird, da das Package dann ein
    # anderes ist! -> beste L�sung: alle Funktionen von bbbike.cgi
    # m�ssen in ein Package �berf�hrt werden

    my $xy = main::get_nearest_crossing_coords($x,$y);
    my @cr = split m{/}, main::crossing_text($xy);
    @cr = @cr[0,1] if @cr > 2; # bbbike.cgi can deal only with A/B

    # first part of cross is empty, switch streetsnames of corner: /foo -> foo/
    if ($cr[0] eq '') {
	@cr = ( $cr[1], "" );
    }

    my $no_name = "NN";
    @cr = map { $_ eq "" ? $no_name : $_ } @cr;

    my $cr = join("/", @cr);
    print $q->header(-type => 'text/plain', -access_control_allow_origin => '*');
    print JSON::XS->new->ascii->encode({ crossing => $cr,
					 bbbikepos => $xy,
					 origlon => $lon,
					 origlat => $lat,
				       });
}

1;

__END__
