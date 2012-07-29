#!/usr/local/bin/perl
# Copyright (c) June 2012 Wolfram Schneider, http://bbbike.org
#
# tile-size.cgi - compute size of an tile from planet.osm

use CGI;
use IO::File;
use lib '../world/bin';
use lib '../bin';
use TileSize;

use strict;
use warnings;

my $debug  = 2;
my %format = (
    "osm.pbf"            => "pbf",
    "pbf"                => "pbf",
    "osm.gz"             => "osm.gz",
    "osm"                => "osm.gz",
    "gz"                 => "osm.gz",
    "osm.xz"             => "osm.gz",
    "osm.bz2"            => "osm.gz",
    "osm.shp.zip"        => "shp.zip",
    "shp"                => "shp.zip",
    "osm.obf.zip"        => "obf.zip",
    "obf"                => "obf.zip",
    "garmin-cycle.zip"   => "garmin-cycle.zip",
    "garmin-osm.zip"     => "garmin-cycle.zip",
    "garmin-leisure.zip" => "garmin-cycle.zip"
);

######################################################################
# GET /w/api.php?namespace=1&q=berlin HTTP/1.1
#
# param alias: q: query, search
#              ns: namespace
#

binmode( \*STDERR, ":raw" );
binmode( \*STDOUT, ":raw" );

my $q = new CGI;

my $area = $q->param('area');
my $namespace = $q->param('namespace') || $q->param('ns') || '0';

if ( my $d = $q->param('debug') || $q->param('d') ) {
    $debug = $d if defined $d && $d >= 0 && $d <= 3;
}

my $expire = $debug >= 2 ? '+1s' : '+1h';
print $q->header(
    -type                        => 'text/javascript',
    -charset                     => 'utf-8',
    -expires                     => $expire,
    -access_control_allow_origin => '*',
);

my $lng_sw = $q->param("lng_sw");
my $lat_sw = $q->param("lat_sw");
my $lng_ne = $q->param("lng_ne");
my $lat_ne = $q->param("lat_ne");
my $factor = $q->param("factor") || 1;
my $format = $q->param("format") || "";

my $ext;
if ( $format && $format{$format} ) {
    $ext = $format{$format};

    # guess factor
    $factor *= 1.3  if $format eq 'garmin-leisure.zip';
    $factor *= 0.7  if $format eq 'osm.bz2';
    $factor *= 0.75 if $format eq 'osm.xz';
}
else {
    $ext = $format{"pbf"};
}

my $database_file = "../world/etc/tile/tile-$ext.csv";
my $tile = TileSize->new( 'database' => $database_file );

# short cut "area=lat,lng,lat,lng"
if ( defined $area ) {
    ( $lng_sw, $lat_sw, $lng_ne, $lat_ne ) = split /,/, $area;
}

if (   !defined $lng_sw
    || !defined $lat_sw
    || !defined $lng_ne
    || !defined $lat_ne )
{
    print "{}\n";
    warn "Missing lat,lng parameter\n";
    exit 0;
}
$factor = 1 if $factor < 0 || $factor > 100;

my $size = $factor * $tile->area_size( $lng_sw, $lat_sw, $lng_ne, $lat_ne, 2 );
$size = int( $size * 10 + 0.5 ) / 10;
warn "size: $size, factor $factor, area: $lng_sw,$lat_sw,$lng_ne,$lat_ne\n"
  if $debug >= 2;

# display JSON result
print qq|{"size": $size }\n|;

1;
