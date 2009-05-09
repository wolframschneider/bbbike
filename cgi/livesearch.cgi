#!/usr/bin/perl

use strict;
use warnings;

use CGI;

my $home = -e '/home/wosch' ? '/home/wosch' : '/Users/wosch';

my $q = new CGI;

my $stat_file = "/tmp/log.html.$$";
system("env HOME=$home max_pictures=16 log_html=$stat_file bbbike_host='' ../../bbbike-macos/bin/bbbike-log");

print $q->header();

open(STAT, $stat_file) or die "open $stat_file: $!\n";
while(<STAT>) {
	print
}

close STAT;

unlink($stat_file);

exit 0;

