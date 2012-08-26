#!/usr/local/bin/perl

use LWP::UserAgent;

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

my @list = (
    {
        'page'     => 'http://www.bbbike.org',
        'min_size' => 10_000,
        'match'    => [qr{</html>}]
    },
    {
        'page'     => 'http://m.bbbike.org',
        'min_size' => 1_000,
        'match'    => [qr{</html>}]
    },
    {
        'page'     => 'http://www.bbbike.org/en/',
        'min_size' => 10_000,
        'match'    => [qr{</html>}]
    },
    {
        'page'     => 'http://www.bbbike.org/de/',
        'min_size' => 10_000,
        'match'    => [qr{</html>}]
    },
    {
        'page'     => 'http://extract.bbbike.org',
        'min_size' => 5_000,
        'match'    => [qr{</html>}]
    },
    {
        'page'     => 'http://download.bbbike.org/osm/',
        'min_size' => 2_000,
        'match'    => [qr{</html>}]
    },
);

plan tests => 4 * scalar(@list);
my $ua = LWP::UserAgent->new;
$ua->agent('BBBike.org-Test/1.0');
$ua->env_proxy;

foreach my $obj (@list) {
    my $url = $obj->{'page'};

    my $resp = $ua->get($url);
    ok( $resp->is_success, $url );

    ok( $resp->content_is_html, "page $url is HTML" );
    cmp_ok( $resp->content_length, ">", $obj->{min_size},
            "page $url is greather than: "
          . $resp->content_length . " > "
          . $obj->{min_size} );

    my $content = $resp->decoded_content;
    next if !exists $obj->{'match'};

    foreach my $match ( @{ $obj->{'match'} } ) {
        like $content, $match, qq{Found string $match};
    }
}

__END__
