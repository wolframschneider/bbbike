#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: bbbikedraw-loop.t,v 1.5 2005/04/05 22:52:52 eserte Exp $
# Author: Slaven Rezic
#

use strict;
use FindBin;

BEGIN {
    if (!eval q{
	use Test::More;
	1;
    }) {
	print "1..0 # skip: no Test::More module\n";
	exit;
    }
}

my @dists = qw(100 200 400 600 1000 2000 3000 5000
	       10000 15000 20000 40000 60000 120000
	       250000);
my @dists_region = grep { $_ <= 40000 } @dists;

my $tests = @dists + @dists_region;
plan tests => $tests;

use Getopt::Long;
my $doit = 0;
my %skip;
my $custom_center;
GetOptions("doit" => \$doit,
	   'skip=s' => sub { %skip = map {($_,1)} split /,/, $_[1] },
	   'dists=s' => sub { my @val = split /,/, $_[1];
			      @dists = @dists_region = @val;
			  },
	   'center=s' => \$custom_center,
	  ) or die $!;
SKIP: {
    skip("No -doit option specified on command line", $tests)
	if !$doit;

    my $bbbikedraw = "$FindBin::RealBin/../miscsrc/bbbikedraw.pl";
    skip("The executable $bbbikedraw is not available", $tests)
	if !-e $bbbikedraw;

    my $center = "9331,9668"; # Kreuzberg 61
    my $center_region = "53519,102604"; # Uckermark
    my $width = 550;
    my $dpi = 72;
    my $cm_per_in = 2.54;

    my $width_in_m = $width/$dpi*$cm_per_in*0.01;

    my $a_scope_loop = sub {
	my($centerx,$centery,$dist_ref,$scopelabel) = @_;

	for my $dist (@$dist_ref) {
	    my @bbox = ($centerx-$dist/2, $centery-$dist/2,
			$centerx+$dist/2, $centery+$dist/2);
	    my $scale = int($dist/$width_in_m);
	    my $o_file = sprintf "/tmp/bbbikedraw-mapserver-%s-%08d.png", $scopelabel, $scale;
	    system($bbbikedraw,
		   "-mapserver",
		   "-outline",
		   "-drawtypes", "ampel,berlin,wasser,faehren,flaechen,ubahn,sbahn,rbahn,str,ort,strname,ubahnname,sbahnname,blocked,radwege",
		   "-geometry" => $width."x".$width,
		   "-bbox", join(",",@bbox),
		   "-o", $o_file,
		  ) == 0 or die;
	    pass("scale 1:$scale -> $o_file");
	}
    };

    if (defined $custom_center) {
	$a_scope_loop->(split(/,/, $custom_center), \@dists, $custom_center)
    } else {
	$a_scope_loop->(split(/,/, $center_region), \@dists_region, "region")
	    unless $skip{"region"};
	$a_scope_loop->(split(/,/, $center), \@dists, "city")
	    unless $skip{"city"};
    }
}

__END__
