#!/usr/bin/perl -w
# -*- perl -*-

#
# Author: Slaven Rezic
#

use strict;

BEGIN {
    print "1..0 # skip test does not apply anymore, URLs have changed\n"; # now $DISTDIR is not using anymore a sf mirror
    exit;
}

use File::Basename;

use FindBin;
use lib "$FindBin::RealBin/..";
use BBBikeVar;

BEGIN {
    if (!eval q{
	use Test::More;
	1;
    }) {
	print "1..0 # skip no Test::More module\n";
	exit;
    }
}

BEGIN { plan tests => 1 }

my $ports_dir;
for my $try_ports_dir (
		       #"/home/e/eserte/work2/freebsd/ports", # private, usually more up-to-date # XXX not used anymore
		       "/usr/ports",
		      ) {
    if (-d $try_ports_dir) {
	$ports_dir = $try_ports_dir;
	last;
    }
}

SKIP: {
    skip("No BSD ports available on this system", 1)
	if !$ports_dir;
    my $bbbike_bsd_port = $ports_dir . "/german/BBBike";
    skip("No BSD port for BBBike available on this system", 1)
	if ! -d $bbbike_bsd_port;
    chdir $bbbike_bsd_port or die "Can't chdir to $bbbike_bsd_port: $!";
    my($out) = `make fetch-list DISTDIR=/`;
    my @url;
    while($out =~ m{((?:ftp|http)://\S+)}g) {
	push @url, $1;
    }
    my %dir_url = map { (dirname($_),1) } @url;
    my $bbbike_versioned_distdir = $BBBike::DISTDIR . '/BBBike/' . $BBBike::FREEBSD_VERSION;
    if (!exists $dir_url{$bbbike_versioned_distdir}) {
	fail("$bbbike_versioned_distdir not found in " . join(", ", keys %dir_url));
    } else {
	pass("$bbbike_versioned_distdir found");
    }
}

__END__
