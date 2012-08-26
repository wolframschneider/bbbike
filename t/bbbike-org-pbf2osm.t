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

plan tests => 13;

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

my $pbf_file = 't/data-osm/Cusco.osm.pbf';
my $pbf_md5 = "6dc9df64ddc42347bbb70bc134b4feda";
my $osm_md5 = "72a3c123a5c3c348f518a55f2b5c1e39";

is ($pbf_md5, md5_file($pbf_file), "md5 checksum matched");

my ($fh, $tempfile) = tempfile;

system(qq[world/bin/pbf2osm t/data-osm/Cusco.osm.pbf | perl -npe 's/timestamp=".*?"/timestamp="0"/' > $tempfile]);
is ($?, 0, "pbf2osm converter");
is ($osm_md5, md5_file($tempfile), "osm md5 checksum matched");

system(qq[world/bin/pbf2osm --gzip t/data-osm/Cusco.osm.pbf; zcat t/data-osm/Cusco.osm.gz | perl -npe 's/timestamp=".*?"/timestamp="0"/' > $tempfile]);
is ($?, 0, "pbf2osm --gzip converter");
is ($osm_md5, md5_file($tempfile), "osm md5 checksum matched");

system(qq[world/bin/pbf2osm --pgzip t/data-osm/Cusco.osm.pbf; zcat t/data-osm/Cusco.osm.gz | perl -npe 's/timestamp=".*?"/timestamp="0"/' > $tempfile]);
is ($?, 0, "pbf2osm --pgzip converter");
is ($osm_md5, md5_file($tempfile), "osm md5 checksum matched");

system(qq[world/bin/pbf2osm --bzip2 t/data-osm/Cusco.osm.pbf; bzcat t/data-osm/Cusco.osm.bz2 | perl -npe 's/timestamp=".*?"/timestamp="0"/' > $tempfile]);
is ($?, 0, "pbf2osm --bzip2 converter");
is ($osm_md5, md5_file($tempfile), "osm md5 checksum matched");

system(qq[world/bin/pbf2osm --pbzip2 t/data-osm/Cusco.osm.pbf; bzcat t/data-osm/Cusco.osm.bz2 | perl -npe 's/timestamp=".*?"/timestamp="0"/' > $tempfile]);
is ($?, 0, "pbf2osm --pbzip2 converter");
is ($osm_md5, md5_file($tempfile), "osm md5 checksum matched");

system(qq[world/bin/pbf2osm --xz t/data-osm/Cusco.osm.pbf; xzcat t/data-osm/Cusco.osm.xz | perl -npe 's/timestamp=".*?"/timestamp="0"/' > $tempfile]);
is ($?, 0, "pbf2osm --xz converter");
is ($osm_md5, md5_file($tempfile), "osm md5 checksum matched");

__END__
