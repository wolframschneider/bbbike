#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: merge_overlapping_streets.pl,v 1.10 2005/02/25 07:55:26 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 2004 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://bbbike.sourceforge.net/
#

=head1 NAME

merge_overlapping_streets.pl - merge overlapping streets

=head1 DESCRIPTION

XXX

Beste Vorgehensweise fuer rbahn und sbahn:

- filter by cat R0, RA ... with grepstrassen

- for every filtered bit: merge_overlapping_streets.pl and
  combine_streets.pl

- cat everything again

=head1 AUTHOR

Slaven Rezic <slaven@rezic.de>

=head1 COPYRIGHT

Copyright (c) 2004 Slaven Rezic. All rights reserved.
This module is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

use FindBin;
use lib ("$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	 "$FindBin::RealBin/../data",
	 );
use Strassen::Core;
use Strassen::MultiStrassen;
use strict;
use Getopt::Long;

my $sep = ", ";
if (!GetOptions("sep=s" => \$sep)) {
    die <<EOF
usage: $0 [-sep sepchar] file ...
EOF
}

my @s = @ARGV;
if (!@s) {
    die "Please specify street file(s)";
}

my %points;

my $s = MultiStrassen->new(@s);
$s->init;
while(1) {
    my $r = $s->next;
    my $cs = $r->[Strassen::COORDS];
    last if !@$cs;
    for my $c_i (0 .. $#$cs - 1) {
	my $c1 = $cs->[$c_i];
	my $c2 = $cs->[$c_i+1];
	my $old_p = $points{$c1}{$c2} || $points{$c2}{$c1};
	if ($old_p) {
	    $old_p->[Strassen::NAME] .= "$sep$r->[Strassen::NAME]";
	} else {
	    $points{$c1}{$c2} = [$r->[Strassen::NAME],
				   [$c1,$c2],
				   $r->[Strassen::CAT],
				  ];
	}
    }
}

while(my($k,$v) = each %points) {
    while(my($k2,$v2) = each %$v) {
	print Strassen::arr2line2($v2), "\n";
    }
}
