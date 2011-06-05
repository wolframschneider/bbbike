#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: strassennetz.t,v 1.23 2009/02/05 22:19:09 eserte Exp $
# Author: Slaven Rezic
#

BEGIN {
    my $city = "SanFrancisco";
    $ENV{BBBIKE_DATADIR} = $ENV{DATA_DIR} = "data-osm/$city";
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
    my $e = new BBBikeElevation;

    $e->init_elevation;
    my $h = $e->get_elevation;
    warn Dumper ( $e->elevation_net );
    warn Dumper ( $h);
}

__END__
