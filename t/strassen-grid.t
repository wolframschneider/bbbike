#!/usr/bin/perl -w
# -*- perl -*-

#
# Author: Slaven Rezic
#

# This test may fail if new points are added in the tested area.
# If this is the case, then please find new points which fulfill these
# criterias:
# - the point should lay on a street but the nearest next point is *not*
#   on this street
# - the second and third tests should generate the same result for all
#   grid types

use strict;
use FindBin;
use lib ("$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	 "$FindBin::RealBin/../data");
use Strassen::Core;
use Strassen::Kreuzungen;
use Getopt::Long;

BEGIN {
    if (!eval q{
	use Test::More;
	1;
    }) {
	print "1..0 # skip no Test::More module\n";
	exit;
    }
}

plan tests => 36;

my %opt;
GetOptions(\%opt, "v!") or die "usage!";

Strassen::set_verbose($opt{v});

# Important: to avoid clashes with cached original data
# This is the same prefix as in cgi/bbbike-test.cgi.config
local $Strassen::Util::cacheprefix = $Strassen::Util::cacheprefix = "test_b_de";

my $test_strassen_file = "$FindBin::RealBin/data/strassen";

for my $use_cache (1, 0) {
    my $cache_text = $use_cache ? "with cache" : "no cache";
    my $s_fast = Strassen->new($test_strassen_file);
    $s_fast->make_grid(Exact => 0, UseCache => $use_cache);

    my $s_exact = Strassen->new($test_strassen_file);
    $s_exact->make_grid(Exact => 1, UseCache => $use_cache);

    my $kr = Kreuzungen->new(Strassen => $s_fast,
			     WantPos => 1,
			     Kurvenpunkte => 1,
			     UseCache => $use_cache);

    for my $p_def (
		   ## point to check, exact result, fast result, normal result

 		   # K�penicker Chaussee/Rummelsburg (with wrong $p_kr)
 		   ["16743,9200", "17072,8714", undef, "16449,9011"],
 		   # etwas s�dlich davon
 		   ["16912,8956", "17072,8714"],
 		   # etwas n�rdlich davon
 		   ["16587,9437", "16374,9760"],

		   # Puschkinallee
		   ["15079,9321", "14819,9462", undef, "15140,9566"],
		   # etwas n�rdlich davon
		   ["15042,9340", "14819,9462", undef, "15140,9566"],
		   # etwas s�dlich davon
		   ["15228,9250", "15383,9191"],
		  ) {
	my($p, $p_exact, $p_fast, $p_kr) = @$p_def;
	#diag("* $p " . "*"x50);
	if (!defined $p_fast) { $p_fast = $p_exact }
	if (!defined $p_kr)   { $p_kr   = $p_fast }
	is($s_exact->nearest_point($p), $p_exact, "Exact test for $p, $cache_text");
	is(($kr->nearest_loop(split /,/, $p))[0], $p_kr, "Nearest loop test for $p, $cache_text");
	is($s_fast->nearest_point($p), $p_fast, "Fast test for $p, $cache_text");
    }
}

__END__
