# -*- perl -*-

#
# $Id: UnixUtil.pm,v 1.3 2003/04/26 19:45:46 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 1999, 2003 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://bbbike.de
#

package UnixUtil;

use strict;
use vars qw($DEBUG);

$DEBUG=1;

#warn get_cdrom_drives();

# XXX evtl. getfsstat(2) verwenden, allerdings schwieriger ...
sub get_cdrom_drives {
    my @drives;
    my $cdrom_devs_regex;
    if ($^O =~ /linux/i) {
	my @cdrom_devs = (qw(cdrom scd[0-7] sonycd mcd mcdx cdu535 lmscd
			     sbpcd sbpcd[123] aztcd bpcd));
	$cdrom_devs_regex = "^/dev/(" . join("|", @cdrom_devs) . ")\$";
    } elsif ($^O =~ /freebsd/i) {
	my @cdrom_devs = (qw(cd acd mcd scd matcd wcd));
	$cdrom_devs_regex = "^/dev/(" . join("|", @cdrom_devs) . ")";
    }
    # XXX Solaris-Sparc �berpr�fen
    if (defined $cdrom_devs_regex && open(MOUNT, "mount |")) {
	while(<MOUNT>) {
	    my(@token) = split(/\s+/, $_);
	    if ($token[0] =~ /$cdrom_devs_regex/) {
		push @drives, $token[2];
	    }
	}
	close MOUNT;
    }
    @drives;
}

1;

__END__
