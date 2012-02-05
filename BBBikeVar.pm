# -*- perl -*-

#
# $Id: BBBikeVar.pm,v 1.62 2009/04/04 11:30:58 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 2000-2010 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://bbbike.sourceforge.net/
#

# BBBike variables and constants

package BBBike;

$VERSION	   = '3.17'; # remove "-DEVEL" for releases
$STABLE_VERSION	   = '3.17';
$WINDOWS_VERSION   = '3.17'; # Windows distribution
$DEBIAN_VERSION    = '3.17-1'; # including revision
$FREEBSD_VERSION   = '3.17'; # (used on download page and bbbikevar.t)

$EMAIL_OLD	   = 'eserte@cs.tu-berlin.de';
$EMAIL		   = 'slaven@rezic.de';
#$EMAIL_NEWSTREET   = 'newstreet@bbbike.de';
##XXX vorerst, bus Mail an bbbike.de wieder geht...
$EMAIL_NEWSTREET   = 'slaven@rezic.de';
# personal homepage
$HOMEPAGE	   = 'http://www.rezic.de/eserte/';
# pointer to WWW version
$BBBIKE_WWW	   = 'http://www.bbbike.de';
# list of additional WWW mirrors
@BBBIKE_WWW_MIRRORS = ('http://bbbike.sourceforge.net/cgi-bin/bbbike.cgi',
		       'http://bbbike.de/cgi-bin/bbbike.cgi',
		       'http://user.cs.tu-berlin.de/~eserte/bbbike/cgi/bbbike.cgi',
		      );
# WWW version, URL for direct access (sometimes www.bbbike.de does not work)
#$BBBIKE_DIRECT_WWW = 'http://user.cs.tu-berlin.de/~eserte/bbbike/cgi/bbbike.cgi';
$BBBIKE_DIRECT_WWW = 'http://bbbike.de/cgi-bin/bbbike.cgi';

# Homepage on Sourceforge
$BBBIKE_SF_WWW	   = 'http://bbbike.sourceforge.net';
# URLs for data update
#$BBBIKE_UPDATE_WWW = "http://bbbike.sourceforge.net/bbbike";
$BBBIKE_UPDATE_DIRECT_WWW = "http://bbbike.de/BBBike";
$BBBIKE_UPDATE_WWW = "http://www.bbbike.de/BBBike";
$BBBIKE_UPDATE_DATA_DIRECT_CGI = "http://bbbike.de/cgi-bin/bbbike-data.cgi";
$BBBIKE_UPDATE_DATA_CGI = "http://www.bbbike.de/cgi-bin/bbbike-data.cgi";
$BBBIKE_UPDATE_DIST_DIRECT_CGI = "http://bbbike.de/cgi-bin/bbbike-snapshot.cgi";
$BBBIKE_UPDATE_DIST_CGI = "http://www.bbbike.de/cgi-bin/bbbike-snapshot.cgi";
#$BBBIKE_UPDATE_RSYNC = 'rsync://bbbike.de/bbbike/'; # not yet XXX
#$BBBIKE_UPDATE_DATA_RSYNC = 'rsync://bbbike.de/bbbike_data/'; # XXX not yet

# WAP version
$BBBIKE_WAP	   = 'http://bbbike.de/wap';
$BBBIKE_DIRECT_WAP = 'http://bbbike.de/cgi-bin/wapbbbike.cgi';

# m
$BBBIKE_MOBILE	   = 'http://m.bbbike.de';

# Distribution directory for scripts. Unfortunately there's no directory
# index available anymore at sourceforge...
$DISTDIR	   = 'http://heanet.dl.sourceforge.net/project/bbbike';
$DISTFILE_SOURCE   = "$DISTDIR/BBBike/$STABLE_VERSION/BBBike-$STABLE_VERSION.tar.gz";
$DISTFILE_WINDOWS  = "$DISTDIR/BBBike/$WINDOWS_VERSION/BBBike-$WINDOWS_VERSION-Windows.exe";
# Distribution directory for humans (link to 'show files' at sourceforge, and restricted to BBBike)
$DISPLAY_DISTDIR   = 'http://sourceforge.net/projects/bbbike/files/BBBike/';
$LATEST_RELEASE_DISTDIR  = "http://sourceforge.net/projects/bbbike/files/BBBike/$STABLE_VERSION/";
# Contains all BBBike project releases:
$DISPLAY_BBBIKE_PROJECT_DISTDIR   = 'http://sourceforge.net/projects/bbbike/files/';
# These link to the intermediate SourceForge download page (only for humans)
$SF_DISTDIR	      = 'http://sourceforge.net/projects/bbbike/files/BBBike';
$SF_DISTFILE_SOURCE   = "$SF_DISTDIR/$STABLE_VERSION/BBBike-$STABLE_VERSION.tar.gz/download";
$SF_DISTFILE_WINDOWS  = "$SF_DISTDIR/$WINDOWS_VERSION/BBBike-$WINDOWS_VERSION-Windows.exe/download";
$SF_DISTFILE_DEBIAN   = "$SF_DISTDIR/" . join('', $DEBIAN_VERSION =~ m{(^[^-]+)}) . "/bbbike_${DEBIAN_VERSION}_i386.deb/download";
$DISTFILE_FREEBSD_I386 = "ftp://ftp.FreeBSD.org/pub/FreeBSD/ports/i386/packages-stable/All/de-BBBike-3.17.tbz";
*DISTFILE_FREEBSD = \$DISTFILE_FREEBSD_I386; # compatibility
$DISTFILE_FREEBSD_ALL  = "http://portsmon.freebsd.org/portoverview.py?category=german&portname=BBBike";

# URL auf die Diplomarbeit
$DIPLOM_URL        = 'http://user.cs.tu-berlin.de/~eserte/diplom/';

# The URL of the mapserver CGI
$BBBIKE_MAPSERVER_URL  = 'http://bbbike.de/cgi-bin/mapserv';
# Address form for mapserver
$BBBIKE_MAPSERVER_ADDRESS_DIRECT_URL = 'http://bbbike.de/cgi-bin/mapserver_address.cgi';
$BBBIKE_MAPSERVER_ADDRESS_URL = 'http://www.bbbike.de/cgi-bin/mapserver_address.cgi';
# The initial mapserver URL (direct)
$BBBIKE_MAPSERVER_DIRECT = 'http://bbbike.de/mapserver/brb/';
# The initial mapserver URL (indirect, from www.bbbike.de)
$BBBIKE_MAPSERVER_INDIRECT = "http://www.bbbike.de/mapserver/brb/";

# git
$BBBIKE_GIT_CLONE_URL = 'git://github.com/eserte/bbbike.git';
$BBBIKE_GIT_HTTP = 'http://github.com/eserte/bbbike';

# CVS (outdated!)
$BBBIKE_CVS_ANON_REPOSITORY = ":pserver:anonymous\@bbbike.cvs.sourceforge.net:/cvsroot/bbbike";
$BBBIKE_CVS_HTTP = 'http://bbbike.cvs.sourceforge.net/viewvc/bbbike/bbbike/';

$BBBIKE_GOOGLEMAP_URL = 'slippymap.cgi';

1;

__END__
