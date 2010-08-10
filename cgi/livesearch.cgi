#!/usr/bin/perl

use CGI;
use IO::File;

use strict;
use warnings;

my $logfile = '/var/log/lighttpd/bbbike.error.log';

my $q     = new CGI;
my $max   = 16;
my $debug = 1;

# extract URLs from web server error log
sub extract_route {
    my $file = shift;
    my $max  = shift;

    my @data;

    my $fh = new IO::File $file, "r" or die "open $file: $!\n";

    while (<$fh>) {
        next if !/ slippymap.cgi: /;
        my @list = split;
        push( @data, pop(@list) );

        shift @data if scalar(@data) > $max;
    }

    return @data;
}

print $q->header(
    -style => {
        'src' => [
            "../html/devbridge-jquery-autocomplete-1.1.2/styles.css",
            "../html/devbridge-jquery-autocomplete-1.1.2/styles.css",
            "../html/bbbike.css"
        ]
    },
    -script => {
        'src' => [
            "../html/jquery-1.4.2.min.js",
"../html/devbridge-jquery-autocomplete-1.1.2/jquery.autocomplete-min.js",
            "http://maps.google.com/maps/api/js?sensor=false&amp;language=de",
            "../html/maps3.js"
        ]
    }
);

my @d = &extract_route( $logfile, $max );

print $q->start_html;
print qq{<div id="routing"></div>\n};
print qq{<div id="BBBikeGooglemap" >\n<div id="map"></div>\n};

print "<pre>\n";

foreach my $url (@d) {
    my $qq = CGI->new($url);
    print $url, "\n" if $debug >= 2;
    my $data = "[";
    if ( my $coords = $qq->param('coords') ) {
        foreach my $c ( split /!/, $coords ) {
            $data .= qq{'$c', };
        }
    }
    $data =~ s/, $/]/;
    print $data, "\n";
}

print "</pre>\n";
print "</div>\n";

print $q->end_html;

