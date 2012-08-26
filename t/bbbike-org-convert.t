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

plan tests => 1;
my $debug = 2;

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

is ($pbf_md5, md5_file($pbf_file), "md5 check sum matched");

__END__
