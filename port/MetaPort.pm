# -*- perl -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 1999,2000,2014 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: srezic@cpan.org
# WWW:  http://bbbike.de
#

use strict;
use Getopt::Long;

use Config;

use FindBin;
use lib "$FindBin::RealBin/../..";
use BBBikeVar;

use vars qw($bbbike_version $tmpdir $bbbike_dir $bbbike_mk);
use vars qw($bbbike_base $bbbike_archiv
	    $bbbike_archiv_dir $bbbike_archiv_path);
use vars qw($bbbike_comment $bbbike_descr);

Getopt::Long::Configure('pass_through', 'no_auto_abbrev');
GetOptions('version=s' => \$bbbike_version);
Getopt::Long::Configure('no_pass_through', 'auto_abbrev');

$tmpdir          = $ENV{TMPDIR} || "/tmp";
$bbbike_dir      = "$FindBin::RealBin/../..";
$bbbike_mk       = "$bbbike_dir/Makefile";

my $fbsdpkg = "$FindBin::RealBin/../freebsd";
if (!-d $fbsdpkg) {
    die "Can't find freebsd directory";
}
$bbbike_comment = `grep ^COMMENT= $fbsdpkg/Makefile.tmpl`;
$bbbike_comment =~ s{^COMMENT=\s*}{};
die "No comment found" if !$bbbike_comment;
$bbbike_descr   = "$fbsdpkg/pkg-descr";

if (!defined $bbbike_version) {
    $bbbike_version = $BBBike::STABLE_VERSION;
    if (!defined $bbbike_version) {
	die "Can't get BBBike's version";
    }
}

$bbbike_base        = "BBBike-$bbbike_version";
$bbbike_archiv      = "$bbbike_base.tar.gz";
$bbbike_archiv_dir  = $bbbike_dir;
$bbbike_archiv_path = "$bbbike_archiv_dir/$bbbike_archiv";
if (!-f $bbbike_archiv_path) {
    # try in distfiles:
    $bbbike_archiv_dir = "$bbbike_dir/distfiles";
    $bbbike_archiv_path = "$bbbike_archiv_dir/$bbbike_archiv";
    if (!-f $bbbike_archiv_path) {
	warn "Can't find $bbbike_archiv in $bbbike_archiv_dir";
    }
}

1;

__END__
