#!/usr/bin/perl -w
# -*- perl -*-

#
# Author: Slaven Rezic
#

use strict;
use FindBin;
use lib (
	 "$FindBin::RealBin/..",
	 $FindBin::RealBin,
	);
use File::Basename;

BEGIN {
    if (!eval q{
	use Test::More;
	use LWP::UserAgent;
	1;
    }) {
	print "1..0 # skip no Test::More and/or LWP::UserAgent module\n";
	exit;
    }
}

use CGI;
use Getopt::Long;

use BBBikeTest qw(check_cgi_testing);

check_cgi_testing;

my $cgi_dir = $ENV{BBBIKE_TEST_CGIDIR} || "http://localhost/bbbike/cgi";
my $html_dir = $ENV{BBBIKE_TEST_HTMLDIR};

if (!GetOptions("cgidir=s" => \$cgi_dir,
		"htmldir=s" => \$html_dir,
	       )) {
    die "usage: $0 [-cgidir url] [-htmldir url]";
}

if (!defined $html_dir) {
    $html_dir = dirname $cgi_dir;
}

my @prog = qw(
	      bbbike.cgi
	      bbbike.en.cgi
	      wapbbbike.cgi
	      bbbikegooglemap.cgi
	     );
if (!$ENV{BBBIKE_TEST_NO_MAPSERVER}) {
    push @prog, qw(
	      mapserver_address.cgi
              mapserver_comment.cgi
	      bbbike-snapshot.cgi
	      bbbike2.cgi
	      bbbike2.en.cgi
	      bbbike-data.cgi
		);
}

if ($cgi_dir !~ m{(bbbike.hosteurope|radzeit)\Q.herceg.de}) {
    push @prog, "bbbikegooglemap2.cgi" if !$ENV{BBBIKE_TEST_NO_MAPSERVER};
}

my @static = qw(
		html/bbbike.css
		html/bbbikepod.css
		html/bbbikeprint.css
		html/bbbike_start.js
		html/bbbike_result.js
		html/pleasewait.html
		html/presse.html
		images/bg.jpg
		images/abc.gif
		images/ubahn.gif
	       );

use vars qw($mapserver_prog_url);
$mapserver_prog_url = $ENV{BBBIKE_TEST_MAPSERVERURL};
if (!defined $mapserver_prog_url) {
    do "$FindBin::RealBin/../cgi/bbbike.cgi.config";
}

$mapserver_prog_url = undef if $ENV{BBBIKE_TEST_NO_MAPSERVER};
if (defined $mapserver_prog_url) {
    push @prog, $mapserver_prog_url;
} else {
    diag("No URL for mapserv defined");
}

my $extra_tests = 3;
plan tests => scalar(@prog) + scalar(@static) + $extra_tests;

my $ua = LWP::UserAgent->new(keep_alive => 1);
$ua->agent('BBBike-Test/1.0');
$ua->env_proxy;
$ua->timeout(10);

delete $ENV{PERL5LIB}; # override Test::Harness setting
for my $prog (@prog) {
    my $qs = "";
    if ($prog =~ /mapserver_comment/) {
	$qs = "?" . CGI->new({comment=>"cgihead test",
			      subject=>"TEST IGNORE ���",
			     })->query_string;
    }
    my $absurl = ($prog =~ /^http:/ ? $prog : "$cgi_dir/$prog");
    check_url("$absurl$qs", $prog);
}

for my $static (@static) {
    my $url = "$html_dir/$static";
    check_url($url);
}

# Check for Bot traps
{
    my $java_ua = LWP::UserAgent->new(keep_alive => 1);
    $java_ua->agent('Java/1.6.0_06 BBBike-Test/1.0');
    $java_ua->env_proxy;
    $java_ua->requests_redirectable([]);
    { # Redirect on start page
	my $resp = $java_ua->get("$cgi_dir/bbbike.cgi");
	is($resp->code, 302, 'Found redirect for Java bot');
	like($resp->header('location'), qr{/html/bbbike_small});
    }
    { # But allow for direct access (which bots do not do)
	my $resp = $java_ua->get("$cgi_dir/bbbike.cgi?info=1");
	is($resp->code, 200);
    }
}

sub check_url {
    my($url, $prog) = @_;
    if (!defined $prog) {
	$prog = basename $url;
    }
    (my $safefile = $prog) =~ s/[^A-Za-z0-9._-]/_/g;
    my $resp = $ua->head($url);
    ok($resp->is_success, $url) or diag $resp->content;

    if ($url =~ /bbbike-data.cgi/) {
	is($resp->header('content-type'), "application/zip", "Expected mime-type for bbbike-data.cgi");
	like($resp->header("content-disposition"), qr{^attachment;\s*filename=bbbike_data.*\.zip$}, "Expected attachment marker");
    } elsif ($url =~ /bbbike-snapshot.cgi/) {
	is($resp->header('content-type'), "application/zip", "Expected mime-type for bbbike-shapshot.cgi");
	like($resp->header("content-disposition"), qr{^attachment;\s*filename=bbbike_snapshot_\d+\.zip$}, "Expected attachment marker");
    }
}

__END__
