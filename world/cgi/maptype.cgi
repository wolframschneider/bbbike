#!/usr/bin/perl
# Copyright (c) 2009-2011 Wolfram Schneider, http://bbbike.org
#
# api.cgi - suggestion service for street names

use MyCgiSimple;

# use warnings make the script 20% slower!
#use warnings;

use strict;

$ENV{LANG} = 'C';

######################################################################
# GET /w/api.php?namespace=1&q=berlin HTTP/1.1
#
# param alias: q: query, search
#              ns: namespace
#

my $q = new MyCgiSimple;

my $city    = $q->param('city')    || 'Berlin';
my $maptype = $q->param('maptype') || 'foo';

my $expire = '0s';
print $q->header(
    -type    => 'text/javascript',
    -charset => 'utf-8',
    -expires => $expire,
);

print "{}";
print "\n";

1;

