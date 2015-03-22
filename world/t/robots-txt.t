#!/usr/local/bin/perl
# Copyright (c) Sep 2012-2015 Wolfram Schneider, http://bbbike.org
#
# check map compare JS/images and external libs
#

BEGIN {
    if ( $ENV{BBBIKE_TEST_NO_NETWORK} || $ENV{BBBIKE_TEST_SLOW_NETWORK} ) {
        print "1..0 # skip due slow or no network\n";
        exit;
    }
}

use Test::More;
use Encode;
use lib qw(./world/lib ../lib);
use BBBikeTest;

use strict;
use warnings;

my $test = BBBikeTest->new();

my @list = ();

my @production = qw(
  www.bbbike.org
  download.bbbike.org
  extract.bbbike.org
  mc.bbbike.org
  a.tile.bbbike.org
  b.tile.bbbike.org
  c.tile.bbbike.org
  d.tile.bbbike.org
  api.bbbike.org
);

my @aliases = qw(
  cyclerouteplanner.org
  cyclerouteplanner.com
);

my @development = qw(
  www1.bbbike.org
  www2.bbbike.org
  dev.bbbike.org
  dev1.bbbike.org
  dev2.bbbike.org
  tile.bbbike.org
  extract1.bbbike.org
  extract2.bbbike.org
  download1.bbbike.org
  download2.bbbike.org
  api1.bbbike.org
  api2.bbbike.org
);

my @not_used = qw(
  dev3.bbbike.org
  devel3.bbbike.org
  www3.bbbike.org
  e.tile.bbbike.org
  f.tile.bbbike.org
  u.tile.bbbike.org
  v.tile.bbbike.org
  w.tile.bbbike.org
);

my @password = qw(
  x.tile.bbbike.org
  y.tile.bbbike.org
  z.tile.bbbike.org
);

foreach my $item ( @production, @aliases, @development ) {
    push @list,
      {
        'page'      => "http://$item/robots.txt",
        'min_size'  => 20,
        'match'     => ["User-agent:"],
        'mime_type' => 'text/plain'
      };
}

my $count = 3 * scalar(@list);
foreach my $obj (@list) {
    $count += scalar( @{ $obj->{'match'} } );
}
plan tests => $count;

############################################################################
my $ua = LWP::UserAgent->new;
$ua->agent('BBBike.org-Test/1.0');
$ua->env_proxy;

foreach my $obj (@list) {
    my $url = $obj->{'page'};

    my $resp = $ua->get($url);
    ok( $resp->is_success, $url );

    my $mime_type = exists $obj->{mime_type} ? $obj->{mime_type} : "text/plain";
    is( $resp->content_type, $mime_type, "page $url is $mime_type" );

    my $content = $resp->decoded_content;
    my $length =
      defined $resp->content_length ? $resp->content_length : length($content);
    cmp_ok( $length, ">", $obj->{min_size},
        "page $url is greather than: " . $length . " > " . $obj->{min_size} );

    next if !exists $obj->{'match'};
    foreach my $match ( @{ $obj->{'match'} } ) {
        like $content, qr{$match}, qq{Found string '$match'};
    }
}

__END__
