#!/usr/local/bin/perl
# Copyright (c) Sep 2012-2015 Wolfram Schneider, http://bbbike.org

BEGIN { }

use utf8;
use Test::More;
use lib qw(./world/lib ../lib);

#use BBBikeTest;

use strict;
use warnings;

my $prog           = './world/bin/bbbike-db';
my $min_city_count = 234;

my @cities       = map { chomp; $_ } (`$prog --list`);
my @cities_de    = map { chomp; $_ } (`$prog --area=de`);
my @cities_eu    = map { chomp; $_ } (`$prog --area=eu`);
my @cities_other = map { chomp; $_ } (`$prog --area=other`);

plan tests => 4;

########################################################################
# main
#

# program is running
system("$prog --help >/dev/null");
is( $?, 0, "$prog --help" );

is(
    scalar(@cities),
    scalar(@cities_de) + scalar(@cities_eu) + scalar(@cities_other),
    "number of cities matches"
);

# compare variables
my $city_string = join ",", sort @cities;
my $city_area = join ",", sort ( @cities_de, @cities_eu, @cities_other );
is( $city_string, $city_area, "cities are unique" );

cmp_ok( scalar(@cities), ">=", $min_city_count,
    "minimum $min_city_count cities" );

__END__
