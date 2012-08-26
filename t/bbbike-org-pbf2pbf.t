#!/usr/local/bin/perl

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

use strict;
use warnings;

plan tests => 9;

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

my $pbf_file  = 't/data-osm/Cusco.osm.pbf';
my $pbf_file2 = 't/data-osm/Cusco2.osm.pbf';
my $pbf_md5   = "6dc9df64ddc42347bbb70bc134b4feda";
my $pbf2_md5  = "771752ab5a16e80720d5c5fb88d577ad";
my $osm_md5   = "72a3c123a5c3c348f518a55f2b5c1e39";
my ( $fh, $tempfile ) = tempfile;

is( $pbf_md5, md5_file($pbf_file), "md5 checksum matched: $pbf_file" );

system(
qq[world/bin/pbf2osm $pbf_file2 | perl -npe 's/timestamp=".*?"/timestamp="0"/' > $tempfile]
);
is( $?, 0, "pbf2osm converter" );
is( $osm_md5, md5_file($tempfile), "osm md5 checksum matched" );

system( "cp", $pbf_file, $pbf_file2 );
is( $?, 0, "copy" );
is( $pbf_md5, md5_file($pbf_file2), "md5 checksum matched: $pbf_file2" );

system( "world/bin/pbf2pbf", $pbf_file2 );
is( $?, 0, "pbf2pbf $pbf_file2" );
is( $pbf2_md5, md5_file($pbf_file2),
    "md5 checksum matched after running pbf2pbf: $pbf_file2" );

system(
qq[world/bin/pbf2osm $pbf_file2 | perl -npe 's/timestamp=".*?"/timestamp="0"/' > $tempfile]
);
is( $?, 0, "pbf2osm converter" );
is( $osm_md5, md5_file($tempfile), "osm md5 checksum matched" );

__END__
