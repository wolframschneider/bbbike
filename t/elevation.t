#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: strassennetz.t,v 1.23 2009/02/05 22:19:09 eserte Exp $
# Author: Slaven Rezic
#

BEGIN {
    my $city = "SanFrancisco";

    #$ENV{BBBIKE_DATADIR} = $ENV{DATA_DIR} = "data-osm/$city";
}

use FindBin;
use lib (
    "$FindBin::RealBin/..",      "$FindBin::RealBin/../lib",
    "$FindBin::RealBin/../data", "$FindBin::RealBin",
);

use Getopt::Long;
use Data::Dumper qw(Dumper);
use Storable qw(dclone);
use Test::More;
use List::Util qw(sum);

use Strassen::Core;
use Strassen::Util;
use Strassen::Lazy;
use Strassen::StrassenNetz;
use Route;
use Route::Heavy;
use BBBikeElevation;

use BBBikeTest;
use strict;
use warnings;

#plan tests => 50;

print "# Tests may fail if data changes\n";

my $s     = Strassen::Lazy->new("strassen");
my $s_net = StrassenNetz->new($s);
$s_net->make_net();    # UseCache => 1 );

{
    my $e = new BBBikeElevation;

    $e->init;
    my $h = $e->get_elevation;
    $e->elevation_net;

    #warn Dumper ( $h);
}

{
    my $enable_dist = 1;

    my $e = new BBBikeElevation;
    $e->init;

    open OUT, "> /tmp/net.old" or die "$!\n";
    print OUT Dumper($s_net);

    my $extra_args = $e->elevation_net;
    open OUT, "> /tmp/net.hoehe" or die "$!\n";
    print OUT Dumper( $extra_args->{Steigung}{Net} );

    # data-osm/SanFrancisco
    pass("-- Marine Drive - Channel Street --");
    my $c1 = "-122.4715,37.80851";     # Marine Drive
    my $c2 = "-122.39178,37.77455";    # Channel Street

    #pass("-- Scharnweber - Lichtenrader Damm --");
    $c1 = "4695,17648";                # Scharnweberstr.
    $c2 = "10524,655";                 # Lichtenrader Damm

    my $net = $s_net;
    local $Data::Dumper::Indent = 0;
    foreach my $args ( {}, $extra_args ) {
        print "\nStart =>\n";
        for my $c ( $c1, $c2 ) {       # points may move ... fix it!
            $c = $net->fix_coords($c);
        }

        my ($path) = $net->search( $c1, $c2, %$args );
        my (@route) = $net->route_to_name($path);

        if ($enable_dist) {
            my $dist1 = int sum map { $_->[StrassenNetz::ROUTE_DIST] } @route;

#my (@compact_route) = $net->compact_route( \@route );
#my $dist2 = int sum map { $_->[StrassenNetz::ROUTE_DIST] } @compact_route;
#is( $dist1, $dist2, "Distance the same after compaction" );
#cmp_ok( scalar(@compact_route), "<", scalar(@route), "Actually less hops in compacted route" );

            print "dist1: $dist1 meters\n";
            print "hops: ", scalar(@route), "\n";
        }

        print Dumper( \@route ), "\n";
    }

    #print Dumper($path);
    #print Dumper( \@compact_route ), "\n";
}

__END__
