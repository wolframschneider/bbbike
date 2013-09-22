#!/usr/bin/perl -w
# -*- perl -*-

#
# Author: Slaven Rezic
#

use strict;

use FindBin;
use lib ("$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	 "$FindBin::RealBin/../data",
	 $FindBin::RealBin);
use Strassen;
use Benchmark;
use Getopt::Long;

BEGIN {
    if (!eval q{
	use Test::More;
	die "No data/Makefile" if !-e "$FindBin::RealBin/../data/Makefile";
	1;
    }) {
	print "# tests only work with installed Test::More and a Makefile in the data directory\n";
	print "1..1\n";
	print "ok 1\n";
	exit;
    }
}

use BBBikeTest qw(get_pmake);

## results with 5.8.0:
# normal: 0.078125
# Storable: 0.4375

plan tests => 4;

use vars qw($fast $bench $v);

if (!GetOptions("fast" => \$fast,
		"bench" => \$bench,
		"v" => \$v)) {
    die "usage!";
}

use vars qw($token %times $ext);

unless ($fast) {
    my $make = get_pmake;
    diag "Regenerating storable files in data, please be patient...\n";
    local $ENV{MAKEFLAGS}; # protect from gnu make brain damage (MAKEFLAGS is set to "w" in recursive calls)
    system("cd $FindBin::RealBin/../data && $make storable >/dev/null 2>&1");
}

my @list = (""); # ("", ".st")
for $ext (@list) {
    if ($bench) {
	my $t = timeit(1, 'do_tests()');
	$times{$token} += $t->[$_] for (1..4);
    } else {
	do_tests();
    }
}

if ($bench) {
    print STDERR join("\n",
		      map { "$_: $times{$_}" }
		      sort { $times{$a} <=> $times{$b} }
		      keys %times), "\n";
}

sub do_tests {
    $token = ($ext ? "Storable" : "normal");
    my $ss = new Strassen "strassen$ext";
    isa_ok $ss, "Strassen";
    my $sl = new Strassen "landstrassen$ext";
    isa_ok $sl, "Strassen";
    my $sm = new MultiStrassen($ss, $sl);
    isa_ok $sm, "MultiStrassen";
    isa_ok $sm, "Strassen";
}

__END__
