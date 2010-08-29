#!/usr/bin/perl

use CGI qw/-utf-8/;
use LWP::Simple;
use IO::File;

use strict;
use warnings;

my $q     = new CGI;
my $debug = 2;

sub cache_file {
    my $q = shift;

    my $server = $q->server_name;
    my $city   = $q->param('city');

    if ( $city !~ /^[A-Za-z_-]+$/ ) {
        warn "Illegal city name: '$city'!\n";
        return;
    }
    return "/var/cache/bbbike/$server/$city/wettermeldung-$<";
}

sub get_data_from_cache {
    my $file = shift;

    my (@stat) = stat($file);
    if ( !defined $stat[9] or $stat[9] + 30 * 60 < time() ) {
        return;
    }
    else {
        my $fh = new IO::File $file, "r"
          or do { warn "open $file: $!\n"; return; };
        warn "Read weather data from cache file: $file\n" if $debug >= 2;

        my $content;
        while (<$fh>) {
            $content .= $_;
        }

        return $content;
    }
}

sub write_to_cache {
    my $file    = shift;
    my $content = shift;

    my $fh = new IO::File $file, "w"
      or do { warn "open > $file: $!\n"; return; };
    warn "Write weather data to cache file: $file\n" if $debug >= 2;

    print $fh $content;
}

# $q = CGI->new('lat=53&lng=15&lang=de');
##############################################################################################
#
# main
#

print $q->header(
    -type   => 'application/json;charset=UTF-8',
    -expire => '+30m'
);

my $lat  = $q->param('lat');
my $lng  = $q->param('lng');
my $lang = $q->param('lang');

my $url = 'http://ws.geonames.org/findNearByWeatherJSON?lat=';

my $wettermeldung_file      = &cache_file($q);
my $wettermeldung_file_json = "$wettermeldung_file.$lang.json";

if ( my $content = get_data_from_cache($wettermeldung_file_json) ) {
    print $content;
    exit 0;
}

elsif ( $lat && $lng ) {
    $url .= $lat . '&lng=' . $lng;
    $url .= "&lang=$lang" if $lang && $lang ne "";

    my $content = get($url);

    if ($content) {
        print $content;
        write_to_cache( $wettermeldung_file_json, $content );
    }
    else {
        warn "No weather data for: $url\n" if $debug >= 1;
    }
}

