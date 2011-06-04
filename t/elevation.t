#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: strassennetz.t,v 1.23 2009/02/05 22:19:09 eserte Exp $
# Author: Slaven Rezic
#

use strict;
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

#plan tests => 50;

print "# Tests may fail if data changes\n";

if ( !GetOptions( get_std_opts(qw(xxx)) ) ) {
    die "usage: $0 [-xxx]";
}

my $s     = Strassen::Lazy->new("strassen");
my $s_net = StrassenNetz->new($s);
$s_net->make_net( UseCache => 1 );

my $qs              = Strassen::Lazy->new("qualitaet_s");
my $comments_path   = Strassen::Lazy->new("comments_path");
my $comments_scenic = Strassen::Lazy->new("comments_scenic");

{

    # Melchiorstr.: m‰ﬂiger Asphalt	Q1; 11726,11265 11542,11342
    my $coords = "11542,11342 11726,11265";
    my $route = [ map { [ split /,/ ] } split /\s+/, $coords ];

    {
        pass("-- Melchiorstr.: einseitige Qualit‰tsangabe --");

        my $net = StrassenNetz->new($qs);
        $net->make_net_cat( -obeydir => 1, -net2name => 1 );
        my $route = dclone $route;
        is( $net->get_point_comment( $route, 0, undef ), 0,
            "Without multiple" );
        $route = [ reverse @$route ];
        like( ( $net->get_point_comment( $route, 0, undef ) )[0],
            qr/m‰ﬂiger Asphalt/i );
    }

    {
        pass("-- Melchiorstr.: einseitige Qualit‰tsangabe (dito) --");

        my $net = StrassenNetz->new($qs);
        $net->make_net_cat( -obeydir => 1, -net2name => 1, -multiple => 1 );
        my $route = dclone $route;
        is( scalar $net->get_point_comment( $route, 0, undef ),
            0, "With multiple" );
        $route = [ reverse @$route ];
        like( ( $net->get_point_comment( $route, 0, undef ) )[0],
            qr/m‰ﬂiger Asphalt/i );
    }
}

{
    my $e = new BBBikeElevation;
}

__END__
