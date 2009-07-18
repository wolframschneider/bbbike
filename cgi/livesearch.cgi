#!/usr/bin/perl

use strict;
use warnings;

use CGI;

my $home = -e '/home/wosch' ? '/home/wosch' : '/Users/wosch';

my $q = new CGI;

my $bbbike_host = '';
my $max         = 16;

$bbbike_host = 'http://recv.de' if $q->param('host') && $q->param('host') eq 'recv.de';
if ( $q->param('max') && $q->param('max') && $bbbike_host ) {
    my $m = $q->param('max');
    $max = $m if $m > 0 && $m <= 512;
}

my $stat_file = "/tmp/log.html.$$";
system(
qq{env HOME=$home max_pictures="$max" log_html=$stat_file bbbike_host="$bbbike_host" ../world/bin/bbbike-log}
);

print $q->header();

open( STAT, $stat_file ) or die "open $stat_file: $!\n";
while (<STAT>) {
    print;
}

close STAT;

unlink($stat_file);

exit 0;

