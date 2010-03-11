#!/usr/bin/perl

use CGI;

use strict;
use warnings;

my $q = new CGI;
print $q->redirect('http://bbbike.de/cgi-bin/bbbike2.cgi');

exit 0;

