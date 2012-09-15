#!/usr/local/bin/perl
# Copyright (c) Sep 2012 Wolfram Schneider, http://bbbike.org

BEGIN { }

use FindBin;
use lib ( "$FindBin::RealBin/..", "$FindBin::RealBin/../lib",
    "$FindBin::RealBin", );

use Getopt::Long;
use Data::Dumper qw(Dumper);
use Test::More;
use File::Temp qw(tempfile);
use IO::File;
use Digest::MD5 qw(md5_hex);
use File::stat;

use strict;
use warnings;

plan tests => 13;

my $pbf_file = 't/data-osm/Cusco.osm.pbf';
my $pbf_md5  = "6dc9df64ddc42347bbb70bc134b4feda";

# min size of garmin zip file
my $min_size = 200_000;

sub md5_file {
    my $file = shift;
    my $fh = new IO::File $file, "r";
    die "open file $file: $!\n" if !defined $fh;

    my $data;
    while (<$fh>) {
        $data .= $_;
    }

    $fh->close;

    my $md5 = md5_hex($data);
    return $md5;
}

######################################################################
is( $pbf_md5, md5_file($pbf_file), "md5 checksum matched" );

my $tempfile = File::Temp->new( SUFFIX => ".osm" );
my $prefix = $pbf_file;
$prefix =~ s/\.pbf$//;
my $st = 0;

# any style
system(qq[world/bin/pbf2osm --garmin $pbf_file osm]);
is( $?, 0, "pbf2osm --garmin converter" );
my $out = "$prefix.garmin-osm.zip";
$st = stat($out) or die "Cannot stat $out\n";

system(qq[unzip -t $out]);
is( $?, 0, "valid zip file" );

cmp_ok( $st->size, '>', $min_size, "$out greather than $min_size" );

# known styles
foreach my $style (qw/cycle leisure osm/) {
    system(qq[world/bin/pbf2osm --garmin-$style $pbf_file]);
    is( $?, 0, "pbf2osm --garmin-$style converter" );

    $out = "$prefix.garmin-$style.zip";
    system(qq[unzip -tqq $out]);
    is( $?, 0, "valid zip file" );
    $st = stat($out);
    my $size = $st->size;
    cmp_ok( $size, '>', $min_size, "$out: $size > $min_size" );
}

__END__
