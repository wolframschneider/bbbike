#!/usr/bin/perl -w
# -*- perl -*-

#
# Author: Slaven Rezic
#

use strict;
use FindBin;
use lib ("$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	 $FindBin::RealBin,
	);

BEGIN {
    if (!eval q{
	use Test::More;
	use LWP::ConnCache;
	use LWP::UserAgent;
	use Compress::Zlib;
	1;
    }) {
	print "1..0 # skip no Test::More, Compress::Zlib, LWP::ConnCache and/or LWP::UserAgent modules\n";
	exit;
    }

    if ($ENV{BBBIKE_TEST_ORG}) {
	print "1..0 # skip due bbbike.de test only\n";
	exit;
    }
    if ($ENV{BBBIKE_TEST_SLOW_NETWORK}) {
	print "1..0 # skip due slow network\n";
	exit;
    }
}

use Data::Dumper;
use Sys::Hostname;
use URI;

use Http;
use Strassen::Core;

use BBBikeTest qw(check_network_testing);

check_network_testing;

plan skip_all => "skip due to slow network" if $ENV{BBBIKE_TEST_SLOW_NETWORK};

my $bbbike_url               = "http://bbbike.de";
my $bbbike_data_url          = "http://bbbike.de/BBBike/data";
my $bbbike_pps_url           = "http://bbbike-pps-jessie";
my $bbbike_data_pps_url      = "http://bbbike-pps-jessie/BBBike/data";

my @urls;
if ($ENV{BBBIKE_TEST_HTMLDIR}) {
    push @urls, "$ENV{BBBIKE_TEST_HTMLDIR}/data";
} else {
    push @urls, $bbbike_data_url;
    push @urls, $bbbike_data_pps_url;
}

my $tests_per_url = 19;
plan tests => $tests_per_url * scalar(@urls);

my $ua_string = 'BBBike-Test/1.0';

my $conn_cache = LWP::ConnCache->new(total_capacity => 10);

my $ua = LWP::UserAgent->new(conn_cache => $conn_cache);
$ua->agent($ua_string);
$ua->env_proxy;

my $uagzip = LWP::UserAgent->new(conn_cache => $conn_cache);
$uagzip->agent($ua_string);
$uagzip->env_proxy;
$uagzip->default_headers->push_header('Accept-Encoding' => 'gzip');

$Http::user_agent .= " (BBBike-Test/1.0)";

for my $url (@urls) {
 SKIP: {
	skip("pps system not reachable", $tests_per_url)
	    if $url eq $bbbike_data_pps_url && !$ua->head($bbbike_pps_url)->is_success;

	{
	    my $resp = $ua->get("$url/temp_blockings/bbbike-temp-blockings-optimized.pl");
	    ok($resp->is_success, ".pl file which should be treated as text ($url)")
		or diag(Dumper $resp);
	    like($resp->content, qr{temp_blocking});
	}

	{
	    my $resp = $ua->get("$url/handicap_l");
	    ok($resp->is_success, "normal bbd file")
		or diag(Dumper $resp);
	    do_content_checks($resp->decoded_content, "LWP");
	}

	{
	    my $resp = $uagzip->get("$url/handicap_l");
	    ok($resp->is_success, "normal bbd file")
		or diag(Dumper $resp);
	    do_content_checks($resp->decoded_content, "LWP (gzip)");
	}

	{
	    my %res = Http::get(url => "$url/handicap_l");
	    is($res{'error'}, 200, "Got $url/handicap_l with Http.pm");
	    do_content_checks($res{'content'}, 'Http (SRT)');
	}

	my $root_url = URI->new($url);
	$root_url->path("/");

	{
	    my $robots_url = $root_url->clone;
	    $robots_url->path('/robots.txt');
	    my $resp = $ua->get("$robots_url");
	    ok($resp->is_success, 'robots.txt exists')
		or diag($resp->as_string);
	}

	{
	    my $favicon_url = $root_url->clone;
	    $favicon_url->path('/favicon.ico');
	    my $resp = $ua->get("$favicon_url");
	    ok($resp->is_success, 'favicon exists')
		or diag($resp->as_string);
	}
    }
}

sub do_content_checks {
    my($content, $wwwmod) = @_;

    ok($content =~ m{sonstige behinderungen}i, "Content check with $wwwmod");
    my $s = Strassen->new_from_data_string($content);
    isa_ok($s, "Strassen");
    cmp_ok($s->count, ">=", 50, "reasonable number of data lines");

    my $have_umlauts;
    $s->init;
    while() {
	my $r = $s->next;
	last if !@{ $r->[Strassen::COORDS] || [] };
	if ($r->[Strassen::NAME] =~ m{(?:Fu�g�nger|�ber|Spielstra�e)}i) {
	    $have_umlauts++;
	}
    }
    ok($have_umlauts, "Encoding seems to be OK");
}

__END__
