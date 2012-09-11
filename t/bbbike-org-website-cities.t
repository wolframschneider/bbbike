#!/usr/bin/perl
# Copyright (c) Sep 2012 Wolfram Schneider, http://bbbike.org

use Test::More;
use strict;
use warnings;

BEGIN {
    if ( $ENV{BBBIKE_TEST_NO_NETWORK} ) {
        print "1..0 # skip due no network\n";
        exit;
    }
    if ( $ENV{BBBIKE_TEST_SLOW_NETWORK} ) {
        print "0..0 # skip some test due slow network\n";
    }
}

use LWP;
use LWP::UserAgent;

my $homepage = 'http://www.bbbike.org';
my @cities   = qw/Berlin Zuerich Toronto Moscow/;
use constant MYGET => 3;

if ( !$ENV{BBBIKE_TEST_SLOW_NETWORK} ) {
    plan tests => scalar(@cities) * MYGET * 4 + MYGET * 11;
}
else {
    plan 'no_plan';
}

my $ua = LWP::UserAgent->new;
$ua->agent("BBBike.org-Test/1.0");

sub myget {
    my $url  = shift;
    my $size = shift;

    $size = 10_000 if !defined $size;

    my $req = HTTP::Request->new( GET => $url );
    my $res = $ua->request($req);

    isnt( $res->is_success, undef, "$url is success" );
    is( $res->status_line, "200 OK", "status code 200" );

    my $content = $res->decoded_content();
    cmp_ok( length($content), ">", $size, "greather than $size" );

    return $res;
}

sub cities {
    foreach my $city (@cities) {
        my $url = "$homepage/$city/";
        my $res = myget($url);

        # skip other tests on slow networks (e.g. on mobile phone links)
        next if $ENV{BBBIKE_TEST_SLOW_NETWORK};

        $url = "$homepage/en/$city/";
        myget($url);
        $url = "$homepage/ru/$city/";
        myget($url);
        $url = "$homepage/de/$city/";

        myget( "$homepage/osp/$city.xml", 100 );
    }
}

sub html {
    myget( "$homepage/osp/Zuerich.en.xml", 100 );
    myget( "$homepage/osp/Toronto.de.xml", 100 );
    myget( "$homepage/osp/Moscow.de.xml",  100 );
    myget( "$homepage/osp/Moscow.en.xml",  100 );

    myget( "$homepage/html/bbbike.css", 7_000 );
    myget( "$homepage/html/devbridge-jquery-autocomplete-1.1.2/shadow.png",
        1_000 );

    if ( !$ENV{BBBIKE_TEST_SLOW_NETWORK} ) {
        myget( "$homepage/html/bbbike-js.js", 100_000 );
        myget( "$homepage/html/streets.css",  2_000 );
        myget( "$homepage/html/luft.css",     3_000 );
        myget(
"$homepage/html/devbridge-jquery-autocomplete-1.1.2/jquery.autocomplete-min.js",
            1_000
        );
        myget( "$homepage/html/jquery-1.4.2.min.js", 20_000 );
    }
}

&cities;
&html;

__END__

