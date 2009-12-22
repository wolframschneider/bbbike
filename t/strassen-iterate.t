#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: strassen-iterate.t,v 1.3 2009/12/22 11:30:17 eserte Exp $
# Author: Slaven Rezic
#

use strict;

use FindBin;
use lib ("$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	 "$FindBin::RealBin/../data");
use Strassen::Core;

BEGIN {
    if (!eval q{
	use Test;
	use Object::Iterate 0.05 qw(iterate);
	1;
    }) {
	print "1..0 # skip no Test and/or Object::Iterate modules\n";
	exit;
    }
}

BEGIN { plan tests => 1 }

my @s1;
my @s2;

my $s = Strassen->new("strassen");
$s->init;
while(1) {
    my $r = $s->next;
    last if !@{ $r->[Strassen::COORDS] };
    push @s1, $r->[Strassen::NAME];
}

iterate { push @s2, $_->[Strassen::NAME] } $s;

ok(join("#", @s1), join("#", @s2));

__END__
