#!/usr/local/bin/perl 
# Copyright (c) Sep 2012-2013 Wolfram Schneider, http://bbbike.org

#
# Author: Slaven Rezic
#

# NOTE: this test is controlled by three environment variables:
#
# - BBBIKE_TEST_NO_NETWORK: if set to a perl-true value,
#   then this test is completely skipped
#
# - BBBIKE_LONG_TESTS: if set to a perl-true value,
#   then a random city will be chosen for download (which may
#   result in loading big data files)
#
# - BBBIKE_TEST_SLOW_NETWORK: if set to a perl-true value,
#   then always a quite small city will be downloaded,
#   regardless of the BBBIKE_LONG_TESTS setting

use FindBin;
use lib ( "$FindBin::RealBin/..", "$FindBin::RealBin/../lib", );

use File::Temp qw(tempdir);
use Strassen::Core ();
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

plan 'no_plan';

my $download_script = "$FindBin::RealBin/../miscsrc/bbbike.org_download.pl";

ok -e $download_script, 'Download script exists';

my @listing;
{
    chomp( @listing = `$^X $download_script` );

    # 2012-03-16: there are 231 cities available + original bbbike data
    cmp_ok scalar(@listing), ">=", 235, 'More than 200 cities found';

    ok ((grep { $_ eq 'Wien' } @listing), 'Found Wien in listing');
}

{
    my $random =
      $ENV{BBBIKE_TEST_SLOW_NETWORK} ? 0 : $ENV{BBBIKE_LONG_TESTS} ? 1 : 0;

    my ($dir) =
      tempdir( "bbbike.org_download_XXXXXXXX", CLEANUP => 1, TMPDIR => 1 )
      or die "Cannot create temporary directory: $!";
    my $city = $random ? $listing[ rand(@listing) ] : 'Cusco';
    system( $^X, $download_script, "-city", $city, "-o", $dir, "-agentsuffix",
        " (testing)" );
    is $?, 0, "Downloading city '$city'";
    ok -d "$dir/$city",          "Directory $dir/$city exists";
    ok -f "$dir/$city/strassen", "strassen found for $city";
    ok -f "$dir/$city/meta.yml", "meta.yml found for $city";

    my $s = Strassen->new("$dir/$city/strassen");
    isa_ok $s, 'Strassen';
}

__END__
