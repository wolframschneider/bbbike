#!/usr/bin/perl

use CGI qw/-utf-8/;
use LWP::Simple;

use strict;
use warnings;

my $q     = new CGI;
my $debug = 1;

# $q = CGI->new('lat=53&lng=15&lang=de');
##############################################################################################
#
# main
#

print $q->header( -type => 'application/json;charset=UTF-8',
    -expire => '+30m' );

my $lat = $q->param('lat');
my $lng = $q->param('lng');
my $lang = $q->param('lang');

my $url = 'http://ws.geonames.org/findNearByWeatherJSON?lat=';

if ( $lat && $lng ) {
    $url .= $lat . '&lng=' . $lng;
    $url .= "&lang=$lang" if $lang && $lang ne "";

    my $content = get($url);

    print $content;
}

