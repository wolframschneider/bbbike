#!/usr/local/bin/perl
# Copyright (c) Sep 2012-2015 Wolfram Schneider, http://bbbike.org

use Test::More;
use Data::Dumper;

use lib qw(world/lib);
use BBBike::Locale;
use Extract::Config;
use Extract::CGI;

use strict;
use warnings;

my $debug   = 1;
my $counter = 0;
our $option = {
    'homepage'            => 'http://download.bbbike.org/osm/extract/',
    'script_homepage'     => 'http://extract.bbbike.org',
    'max_extracts'        => 50,
    'default_format'      => 'osm.pbf',
    'enable_polygon'      => 1,
    'debug'               => "2",
    'request_method'      => "GET",
    'supported_languages' => $BBBike::Locale::option->{"supported_languages"},
    'language'            => $BBBike::Locale::option->{"language"},
};

$BBBike::Locale::option->{"message_path"} = "./world/etc/extract";

sub cgi {
    my $q = shift;
    my $obj =
      Extract::CGI->new( 'q' => $q, 'debug' => $debug, 'option' => $option );

    isnt( $obj, undef, "cgi" );

    cmp_ok( length( $obj->header($q) ),       ">", 600, "header" );
    cmp_ok( length( $obj->footer($q) ),       ">", 600, "footer" );
    cmp_ok( length( $obj->map() ),            ">", 200, "map" );
    cmp_ok( length( $obj->social_links() ),   ">", 350, "social_links" );
    cmp_ok( length( $obj->locate_message() ), ">", 230, "locate_message" );
    cmp_ok( length( $obj->export_osm() ),     ">", 400, "export_osm" );
    cmp_ok( length( $obj->message( $q, "de" ) ), ">", 1000, "message" );
    cmp_ok( length( $obj->layout($q) ), ">", 120, "layout" );

    #cmp_ok(length($obj->script_url($q)), ">", 600, "header");
    return 9;
}

########################################################################################
# stub
#
my $q = new CGI;
$counter += &cgi($q);

plan tests => $counter;

__END__
