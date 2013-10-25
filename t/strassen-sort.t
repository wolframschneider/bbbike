#!/usr/bin/perl -w
# -*- mode:perl;coding:latin1; -*-

#
# Author: Slaven Rezic
#

use strict;
use FindBin;
use lib (
	 "$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	);

BEGIN {
    if (!eval q{
	use Test::More;
	1;
    }) {
	print "1..0 # skip no Test::More module\n";
	exit;
    }
}

use Strassen::Core ();

plan 'no_plan';

{
    my $s = Strassen->new_from_data_string(<<EOF);
Z-Stra�e	NN 100,100 200,200 300,300
S-Stra�e	H 300,300 400,400 500,500
E-Stra�e	HH 300,300 400,400 500,500
A-Stra�e	N 300,300 400,400 500,500
EOF
    $s->sort_by_anything(sub ($$) { $_[0]->{data} cmp $_[1]->{data} });
    is_deeply $s->data,
	[
	 "A-Stra�e	N 300,300 400,400 500,500\n",
	 "E-Stra�e	HH 300,300 400,400 500,500\n",
	 "S-Stra�e	H 300,300 400,400 500,500\n",
	 "Z-Stra�e	NN 100,100 200,200 300,300\n",
	], 'simple sorting without map function';

    my %cat2prio = (
		    NN => -1,
		    N  => 0,
		    H  => 1,
		    HH => +1,
		   );

    $s->sort_by_anything(
			 sub ($$) { $_[1]->[1] <=> $_[0]->[1] },
			 sub {
			     my $r = Strassen::parse($_->{data});
			     $cat2prio{$r->[Strassen::CAT]};
			 },
			);
    is_deeply $s->data,
	[
	 "E-Stra�e	HH 300,300 400,400 500,500\n",
	 "S-Stra�e	H 300,300 400,400 500,500\n",
	 "A-Stra�e	N 300,300 400,400 500,500\n",
	 "Z-Stra�e	NN 100,100 200,200 300,300\n",
	], 'sorting without Schwartzian Transform';
}

__END__
