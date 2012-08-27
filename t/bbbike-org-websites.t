#!/usr/local/bin/perl

use LWP::UserAgent;
use Encode;
use utf8;    # test contains unicode characters, see Test::More::UTF8;

use strict;
use warnings;

BEGIN {
    if (
        !eval q{
	use Test::More;
	1;
    }
      )
    {
        print "1..0 # skip no Test::More module\n";
        exit;
    }
    if ( $ENV{BBBIKE_TEST_NO_NETWORK} ) {
        print "1..0 # skip due no network\n";
        exit;
    }
}

binmode \*STDOUT, "utf8";
binmode \*STDERR, "utf8";

my @cities = qw/Berlin Cottbus Toronto/;

# unicode cities
my @cities_utf8 = ( "Київ", "‏بيروت", "新加坡共和国" );

my @list = (
    {
        'page'     => 'http://www.bbbike.org',
        'min_size' => 10_000,
        'match'    => [ "</html>", @cities, @cities_utf8 ]
    },
    {
        'page'     => 'http://m.bbbike.org',
        'min_size' => 1_000,
        'match'    => [ "</html>", @cities ]
    },
    {
        'page'     => 'http://www.bbbike.org/en/',
        'min_size' => 10_000,
        'match'    => [ "</html>", @cities ]
    },
    {
        'page'     => 'http://www.bbbike.org/de/',
        'min_size' => 10_000,
        'match'    => [ "</html>", @cities ]
    },
    {
        'page'     => 'http://extract.bbbike.org',
        'min_size' => 5_000,
        'match'    => [ "</html>", "It takes between" ]
    },
    {
        'page'     => 'http://download.bbbike.org/osm/',
        'min_size' => 2_000,
        'match' =>
          [ "</html>", "select your own region", "offers a database dump" ]
    },
    {
        'page'     => 'http://tile.bbbike.org/osm/',
        'min_size' => 1_500,
        'match'    => [ "</html>", qq/ id="map">/ ]
    },
    {
        'page'     => 'http://tile.bbbike.org/mc/',
        'min_size' => 5_000,
        'match'    => [ "</html>", "Choose map type", ' src="js/mc.js"' ]
    },
    {
        'page' => 'http://tile.bbbike.org/osm/mapnik-german/15/17602/10746.png',
        'min_size'  => 10_000,
        'match'     => [],
        'mime_type' => 'image/png'
    },
);

my $count = 3 * scalar(@list);
foreach my $obj (@list) {
    $count += scalar( @{ $obj->{'match'} } );
}

plan tests => $count;

my $ua = LWP::UserAgent->new;
$ua->agent('BBBike.org-Test/1.0');
$ua->env_proxy;

foreach my $obj (@list) {
    my $url = $obj->{'page'};

    my $resp = $ua->get($url);
    ok( $resp->is_success, $url );

    my $mime_type = exists $obj->{mime_type} ? $obj->{mime_type} : "text/html";
    is( $resp->content_type, $mime_type, "page $url is $mime_type" );
    cmp_ok( $resp->content_length, ">", $obj->{min_size},
            "page $url is greather than: "
          . $resp->content_length . " > "
          . $obj->{min_size} );

    my $content = $resp->decoded_content;

    next if !exists $obj->{'match'};
    foreach my $match ( @{ $obj->{'match'} } ) {
        like $content, qr{$match}, qq{Found string '$match'};
    }
}

__END__
