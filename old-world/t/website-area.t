#!/usr/local/bin/perl
# Copyright (c) Sep 2012-2015 Wolfram Schneider, http://bbbike.org

BEGIN {
    if ( $ENV{BBBIKE_TEST_NO_NETWORK} ) {
        print "1..0 # skip due no network\n";
        exit;
    }
    if ( $ENV{BBBIKE_TEST_SLOW_NETWORK} ) {
        print "0..0 # skip some test due slow network\n";
    }
}

use Test::More;
use lib qw(./world/lib ../lib);
use BBBike::Test;

use strict;
use warnings;

my $test = BBBike::Test->new();

my $homepage = 'http://download.bbbike.org/osm/bbbike';
my @cities   = qw/Berlin Zuerich Toronto Moscow/;

my $garmin = 1;    # 0, 1

if ( !$ENV{BBBIKE_TEST_SLOW_NETWORK} ) {
    plan tests => scalar(@cities) *
      ( $test->myget_counter * 4 + 5 + 5 * $garmin );
}
else {
    plan 'no_plan';
}

sub cities {
    foreach my $city (@cities) {
        my $url = "$homepage/$city/";
        my $res = $test->myget($url);

        my $path = $homepage;
        $path =~ s,http://.*?/,/,;

        my $content = $res->decoded_content();

        like( $content, qr|Content-Type" content="text/html; charset=utf-8"|,
            "charset" );

        #like( $content, qr|rel="shortcut|, "icon" );
        like( $content, qr|src=".*/html/bbbike.js"|,   "bbbike.js" );
        like( $content, qr|href=".*/html/bbbike.css"|, "bbbike.css" );

        #like( $content, qr|href="http://twitter.com/BBBikeWorld"|, "twitter" );
        like( $content, qr|<div id="map"></div>|, "div#map" );
        like( $content, qr|bbbike_maps_init|,     "bbbike_maps_init" );
        like( $content, qr|city = ".+";|,         "city" );
        like( $content, qr|<div id="footer">|,    "footer" );
        like( $content, qr|id="more_cities"|,     "more cities" );
        like( $content, qr|</html>|,              "closing </html>" );

        like(
            $content,
qr|Start bicycle routing for .*?href="http://www.bbbike.org/$city/">|,
            "routing link"
        );

        foreach my $ext (qw/gz pbf/) {
            like( $content, qr|($path/$city)?/$city.osm.$ext"|,
                "$path/$city/$city.osm.$ext" );
        }

        if ($garmin) {
            foreach my $ext (
                qw/osm.garmin-cycle.zip osm.garmin-leisure.zip osm.garmin-osm.zip osm.shp.zip osm.navit.zip poly/
              )
            {
                like( $content, qr|($path/$city)?/$city.$ext"|,
                    "$path/$city/$city.$ext" );
            }
        }

        like( $content, qr|($path/$city)?/CHECKSUM.txt"|, "CHECKSUM.txt" );
    }
}

&cities;

__END__

