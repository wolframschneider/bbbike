# -*- perl -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 2009,2013,2014 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://www.rezic.de/eserte/
#

# Hmmm... XXXX

package BBBikeCGI::API;

use strict;
use vars qw($VERSION);
$VERSION = '0.03';

use JSON::XS qw();

require Karte::Polar;
require Karte::Standard;

sub action {
    my($action, $q) = @_;
    if ($action !~ m{^(revgeocode|config)$}) {
	die "Invalid action $action";
    }
    my $func = "action_$action";
    no strict 'refs';
    &{$func}($q);
}

sub action_revgeocode {
    my $q = shift;
    my $lon = $q->param('lon');
    my $lat = $q->param('lat');

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

sub action_config {
    my $q = shift;
    print $q->header(-type => 'text/plain');
    no warnings 'once';
    my $json_bool = sub { $_[0] ? JSON::XS::true : JSON::XS::false };

    my %modules_info;
    for my $module_name (
			 'Geo::Distance::XS',
			 'Geo::SpaceManager',
			 'YAML::XS', # for BBBikeYAML
			) {
	$modules_info{$module_name} = _module_info($module_name);
    }

    print JSON::XS->new->ascii->encode
	(
	 {
	  use_apache_session         => $json_bool->($main::use_apache_session),
	  apache_session_module      => $main::apache_session_module,
	  detailmap_module           => $main::detailmap_module,
	  graphic_format             => $main::graphic_format,
	  can_gif                    => $json_bool->($main::can_gif),
	  can_jpeg                   => $json_bool->(!$main::cannot_jpeg),
	  can_pdf                    => $json_bool->(!$main::cannot_pdf),
	  bbbikedraw_pdf_module      => $main::bbbikedraw_pdf_module,
	  can_svg                    => $json_bool->(!$main::cannot_svg),
	  can_wbmp                   => $json_bool->($main::can_wbmp),
	  can_palmdoc                => $json_bool->($main::can_palmdoc),
	  can_gpx                    => $json_bool->($main::can_gpx),
	  can_kml                    => $json_bool->($main::can_kml),
	  can_mapserver              => $json_bool->($main::can_mapserver),
	  can_gpsies_link            => $json_bool->($main::can_gpsies_link),
	  show_start_ziel_url        => $json_bool->($main::show_start_ziel_url),
	  show_weather               => $json_bool->($main::show_weather),
	  use_select                 => $json_bool->($main::use_select),
	  use_berlinmap              => $json_bool->(!$main::no_berlinmap),
	  use_background_image       => $json_bool->($main::use_background_image),
	  with_comments              => $json_bool->($main::with_comments),
	  with_cat_display           => $json_bool->($main::with_cat_display),
	  use_coord_link             => $json_bool->($main::use_coord_link),
	  city                       => $main::city,
	  use_fragezeichen           => $json_bool->($main::use_fragezeichen),
	  use_fragezeichen_routelist => $json_bool->($main::use_fragezeichen_routelist),
	  search_algorithm           => $main::search_algorithm,
	  use_exact_streetchooser    => $json_bool->($main::use_exact_streetchooser),
	  use_utf8                   => $json_bool->($main::use_utf8),
	  data_is_wgs84              => $json_bool->($main::data_is_wgs84),
	  osm_data                   => $json_bool->($main::osm_data),
	  modules_info               => \%modules_info,
	 }
	);
}

# Module info can contain:
#  warning   => "...":  a warning, e.g. if Module::Metadata is not available
#  installed => bool:   module is installed or not installed
#  version   => string: module's stringified version
#  version   => false:  module's version is not available
sub _module_info {
    my $module_name = shift;
    if (eval { require Module::Metadata; 1 }) {
	my $mod = Module::Metadata->new_from_module($module_name, collect_pod => 0);
	if ($mod) {
	    my $ver = $mod->version;
	    if ($ver->can('stringify'))  {
		return { installed => JSON::XS::true, version => $ver->stringify }; # stringify for json
	    } else {
		warn "Unexpected: cannot get version for '$module_name' via Module::Metadata";
		return { installed => JSON::XS::true, version => JSON::XS::false };
	    }
	} else {
	    return { installed => JSON::XS::false }
	}
    } else {
	return { warning => 'Module::Metadata unavailable' };
    }
}

1;

__END__
