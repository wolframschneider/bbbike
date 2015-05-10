#!/usr/local/bin/perl
# Copyright (c) Sep 2012-2015 Wolfram Schneider, http://bbbike.org

BEGIN {
    if ( $ENV{BBBIKE_TEST_NO_NETWORK} ) {
        print "1..0 # skip due no network\n";
        exit;
    }
    if ( $ENV{BBBIKE_TEST_FAST} ) {
        print "1..0 # skip due fast test\n";
        exit;
    }
}

use utf8;
use Test::More;
use lib qw(./world/lib ../lib);
use BBBike::Test;

use strict;
use warnings;

my $test = BBBike::Test->new();

my @homepages = qw[
  http://download.bbbike.org
  http://download1.bbbike.org
  http://download2.bbbike.org
];

my $urls = [
    [ "/osm/planet/planet-latest.osm.bz2.md5", 55 ],
    [ "/osm/planet/planet-latest.osm.pbf.md5", 55 ],
    [ "/osm/planet/planet-latest.osm.bz2",     36_000_000_000 ],
    [ "/osm/planet/planet-latest.osm.pbf",     16_000_000_000 ],
    [ "/bbbike/BBBike-3.18-devel-Intel.dmg",   33_000 ],
    [ "/bbbike/data-osm/Ottawa.tbz",           32_000 ],
    [ "/favicon.ico",                          1_000 ],
    [ "/robots.txt",                           36 ],
    [ "/sitemap.xml.gz",                       1_000 ],
    [ "/index.html",                           800 ],
    [ "/osm/srtm/e40/planet-srtm-e40.osm.pbf", 14_000_000 ],
    [ "/osm/srtm/e40/CHECKSUM.txt",            50 ],
    [ "/osm/index.html",                       1_000 ],
    [ "/osm/extract/",                         1_000 ],
    [ "/osm/planet/HEADER.txt",                600 ],
];

# no need for latlon SRTM data
#[ "/osm/srtm/e40/latlon/Lat9Lon98Lat10Lon99.osm.pbf", 2_000_000 ],
#[ "/osm/srtm/e40/latlon/CHECKSUM.txt.gz",             1_000_000 ],

# ads only on production system
plan tests => scalar(@homepages) * $test->myget_counter * scalar(@$urls);

########################################################################
# main
#

foreach my $homepage (@homepages) {
    foreach my $u (@$urls) {
        $test->myget_head( $homepage . $u->[0], $u->[1] );
    }
}

__END__
