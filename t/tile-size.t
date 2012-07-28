#!/usr/local/bin/perl 

use Test::More;
use lib 'world/bin';
use TileSize;

use strict;
use warnings;

plan tests => 2 + 18;

my $tile = new TileSize( 'debug' => 0 );

ok(1);

is( $tile->total, 64800 );

# count with 100% size of fractal tiles
is( $tile->area_size( 0,    0,    1,    1 ),   1 );
is( $tile->area_size( 0.2,  0.2,  1,    1 ),   1 );
is( $tile->area_size( 0.2,  0.2,  0.8,  0.8 ), 1 );
is( $tile->area_size( -180, -90,  -179, -89 ), 1 );
is( $tile->area_size( 0,    0,    2,    2 ),   4 );
is( $tile->area_size( -2,   -2,   0,    0 ),   4 );
is( $tile->area_size( -1,   -1,   1,    1 ),   4 );
is( $tile->area_size( -1.5, -1.5, 1.5,  1.5 ), 16 );
is( $tile->area_size( -1.5, -1.5, 1,    1 ),   9 );
is( $tile->area_size( 0,    50,   15,   54 ),  60 );
is( $tile->area_size( 0.1,  0,    3,    3 ),   9 );
is( $tile->area_size( 0.1,  0.1,  2.9,  2.9 ), 9 );

# count with 50% size of fractal tiles
is( $tile->area_size( 0.1, 0.1,  2.9,  2.9,  1 ), 5 );
is( $tile->area_size( 0,   50,   15,   54,   1 ), 60 );
is( $tile->area_size( 0.5, 50,   15,   54,   1 ), 58 );
is( $tile->area_size( 0.5, 50,   15.5, 54,   1 ), 60 );
is( $tile->area_size( 0.5, 49.5, 15.5, 54,   1 ), 68 );
is( $tile->area_size( 0.5, 49.5, 16.5, 54.1, 1 ), 81 );

__END__
