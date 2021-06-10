#!/usr/bin/perl -w
# -*- perl -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 2016,2021 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://www.rezic.de/eserte/
#

use strict;

my @age_defs =
    ( # note: date regexps should work with %Y-%m-%d (fit file names) and %Y%m%d (standard gpsman file names)
     { rx => qr{^200[0-7]},          name => 'Old1', color => '#a0a030' },
     { rx => qr{^20(0[8-9]|1[0-3])}, name => 'Old2', color => '#b05078' },
     {                               name => '',     color => '#c000c0' },
    );

my @line_defs =
    (
     { rx => qr{\((?:car|bus|tram)},                           type => 'Car',   dash => '8,3' },
     { rx => qr{\((?:plane)},                                  type => 'Plane', dash => '1,4' },
     { rx => qr{\((?:ship|ferry|boat)},                        type => 'Ship',  dash => '2,8' },
     { rx => qr{\((?:train|s-bahn|u-bahn|draisine|funicular)}, type => 'Train', dash => '3,8' },
     { rx => qr{\((?:pedes)},                                  type => 'Pedes', dash => '8,3,8,6' },
     { rx => qr{\((?:swim)},                                   type => 'Swim',  dash => '8,3,8,6' },
     { rx => qr{\((?:bike)},                                   type => '' }, # usually explicitly only marked in fit files
     { rx => qr{\.trk\t},                                      type => 'Uncat', dash => '4,1' },
     {                                                         type => '' }, # usually "bike"
    );

my $def_color = (grep { $_->{name} eq '' } @age_defs)[0]->{color};
print "#: line_color: $def_color\n";
for my $age_def (@age_defs) {
    for my $line_def (@line_defs) {
	my($type, $dash) = @{$line_def}{qw(type dash)};
	if (defined $dash) {
	    print "#: line_dash.GPSs$type$age_def->{name}: $dash\n";
	}
    }
}
for my $age_def (@age_defs) {
    my $name = $age_def->{name};
    next if $name eq '';
    for my $line_def (@line_defs) {
	my $type = $line_def->{type};
	print "#: line_color.GPSs$type$name: $age_def->{color}\n";
    }
}
print "#:\n";

while(<STDIN>) {
    my $cat = '';
    for my $line_def (@line_defs) {
	my $rx = $line_def->{rx};
	if ($rx && $_ =~ $rx) {
	    $cat = $line_def->{type};
	    last;
	}
    }
    my $age_name = '';
    for my $age_def (@age_defs) {
	my $rx = $age_def->{rx};
	if ($rx && $_ =~ $rx) {
	    $age_name = $age_def->{name};
	    last;
	}
    }
    s{\tGPSs}{\tGPSs$cat$age_name};
    print $_;
}

__END__

=head1 NAME

categorize-gpstracks.pl - add color and dash pattern to bbd files containing GPS tracks

=head1 SYNOPSIS

    categorize-gpstracks.pl < in.bbd > out.bbd

=cut
