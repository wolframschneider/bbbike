#!/usr/local/bin/perl 

use Test::More;
use lib 'world/bin';
use TileSize;

use strict;
use warnings;

plan tests => 1;

my $tile = new TileSize;
print $tile->total, "\n";

ok(1);

__END__
