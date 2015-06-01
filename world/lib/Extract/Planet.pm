#!/usr/local/bin/perl
# Copyright (c) 2012-2015 Wolfram Schneider, http://bbbike.org
#
# planet helper functions

package Extract::Planet;

use JSON;
use File::stat;
use Math::Polygon;
use Data::Dumper;

use lib qw(world/lib);
use Extract::Poly;
use Extract::Utils;

use strict;
use warnings;

###########################################################################
# config
#

our $debug = 1;

#our $planet_osm     = '../osm/download/planet-latest-nometa.osm.pbf';

our $config = {
    'stale_time' => 6 * 3600,

    # offset relative to the main checkout directory
    'pwd' => '',

    'planet_osm' => '../osm/download/planet-latest-nometa.osm.pbf',

    'planet_sub_dir' => {

        # planet without meta data
        '../osm/download/planet-latest-nometa.osm.pbf' =>
          '../osm/download/sub-planet',

        # compatibility, planet without meta data and 1.1
        '../osm/download/planet-latest.osm.pbf' => '../osm/download/sub-planet',

        # SRTM planet
        '../osm/download/srtm/planet-srtm-e40.osm.pbf' =>
          '../osm/download/sub-srtm',
    }
};

##########################
# helper functions
#

# Extract::Planet::new->('debug'=> 2, 'option' => $option)
sub new {
    my $class = shift;
    my %args  = @_;

    my $self = {%args};

    bless $self, $class;

    $self->init;
    return $self;
}

#
# adjust directories, e.g. add a prefix "../" if in a sub-directory
# this is needed for CGI scripts running outside the bbbike root directory
#
sub normalize_dir {
    my $self = shift;
    my $dir  = shift;

    if ( $self->{'pwd'} ) {
        return $self->{'pwd'} . "/" . $dir;
    }
    else {
        return $dir;
    }
}

sub init {
    my $self = shift;

    # set global debug variable
    if ( $self->{'debug'} ) {
        $debug = $self->{'debug'};
    }

    $self->{'utils'} = new Extract::Utils;
}

# check if the inner polygon is inside the outer polygon
sub sub_polygon {
    my $self = shift;

    my %args  = @_;
    my $outer = $args{'outer'};
    my $inner = $args{'inner'};

    my $poly = Math::Polygon->new(@$outer);
    my $flag = 0;

    foreach my $point (@$inner) {
        if ( !$poly->contains($point) ) {
            return 0;
        }
    }

    return 1;
}

sub get_polygon {
    my $self = shift;
    my $poly = shift;
    my $name = shift;
    my $list = shift;

    my $obj = $poly->get_job_obj( $name, $list );
    my ( $data, $counter, $polygon ) = $poly->create_poly_data( 'job' => $obj );

    return $polygon;
}

# find the smallest matching sub-planet
sub get_smallest_planet {
    my $self = shift;
    my %args = @_;

    my $obj     = $args{'obj'};
    my $regions = $args{'regions'};

    my $poly = new Extract::Poly( 'debug' => $debug );
    my @regions = $regions ? @$regions : $poly->list_subplanets(1);

    my ( $data, $counter, $city_polygon ) =
      $poly->create_poly_data( 'job' => $obj );
    warn Dumper($city_polygon) if $debug >= 2;

    foreach my $outer (@regions) {
        my $inner = $self->sub_polygon(
            'inner' => $city_polygon,
            'outer' => $self->get_polygon( $poly, $outer )
        );

        if ($inner) {
            return $outer;
        }
    }

    # nothing found, fall back to full planet
    return "planet";
}

# find the smallest matching sub-planet
sub get_smallest_planet_file {
    my $self = shift;
    my %args = @_;

    my $obj                 = $args{'obj'};
    my $regions             = $args{'regions'};
    my $planet_osm          = $args{'planet_osm'};
    my $planet_osm_original = $planet_osm;
    $planet_osm = $self->normalize_dir($planet_osm);

    if ( !$planet_osm ) {
        warn "No planet.osm file given, ignored\n" if $debug >= 2;
        return "";
    }

    # time in seconds after we consider a sub-planet stale
    my $stale_time = $config->{'stale_time'};

    my $planet =
      $self->get_smallest_planet( 'obj' => $obj, 'regions' => $regions );

    my $sub_planet_dir =
      $self->normalize_dir(
        $config->{'planet_sub_dir'}->{$planet_osm_original} );

    if ( $planet eq 'planet' ) {
        warn "No sub-planet match, use full planet\n" if $debug >= 2;
        return "";
    }

    if ( !defined $sub_planet_dir ) {
        warn "No sub-planet exists, use full planet\n" if $debug >= 2;
        return "";
    }

    my $file = "$sub_planet_dir/$planet.osm.pbf";

    if ( !-e $file ) {
        warn "sub-planet file $file does not exists, ignored\n" if $debug >= 1;
        return "";
    }

    # a negative value means that the sub-planet is older than the planet
    my $time_diff = $self->{'utils'}->file_mtime_diff( $file, $planet_osm );

    # use the sub-planet if it is no older than 3 hours compared to the planet
    if ( ( -1 * $time_diff ) > $stale_time ) {
        warn
"sub-planet file $file <=> $planet_osm is stale: $time_diff seconds, ignored\n"
          if $debug >= 1;
        return "";
    }
    else {
        return $file;
    }
}

# planet.osm.pbf size in bytes
sub planet_size {
    my $self   = shift;
    my $planet = shift;

    $planet = $self->normalize_dir($planet);
    my $st = stat($planet);

    if ( !$st ) {
        warn "stat $planet: $!\n";
        return 0;
    }

    return $st->size;
}

1;

__DATA__;
