#!/usr/local/bin/perl
# -*- perl -*-

#
# $Id: cgi2.pl,v 1.7 2005/03/09 23:49:52 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 1998 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: eserte@cs.tu-berlin.de
# WWW:  http://user.cs.tu-berlin.de/~eserte/
#

use LWP::UserAgent;
use URI::Escape;
use IO::Tee;
use Getopt::Long;
use strict;
use lib "$ENV{HOME}/lib/perl";
use CGI;

my $seek = 0;
my $verbose = 1;
my $firstdate;
my($today, $yesterday, $days);
my $netscape = 0;
my $cgi_type = "slow";
my $sgml_catalog = "/usr/www/informatik/hypermedia/html/html4.0/sgml/CATALOG";
my $sgml_check = is_in_path("nsgmls") && -r $sgml_catalog;
$sgml_check = 0; # XXX don't turn on on default --- there are too many errors...
my $errorfile = "/tmp/errors";
#my $cgiurl = "http://www/~eserte/bbbike/cgi/bbbike.cgi";
my $cgiurl = "http://www/bbbike/cgi/bbbike.cgi";
#my $logfile = "$ENV{HOME}/www/AccessLog";
my $logfile = "$ENV{HOME}/www/log/radzeit.combined_log";
my $filter;
my $only_result;
my %add_param;

GetOptions('seek=i'       => \$seek,
	   'v|verbose!'   => \$verbose,
	   'quiet'        => sub { $verbose = 0 },
	   'firstdate=s'  => \$firstdate,
	   'netscape!'    => \$netscape,
	   'today!'       => \$today,
	   'yesterday!'   => \$yesterday,
	   'days=i'       => \$days,
	   'slow'         => sub { $cgi_type = "slow" },
	   'fcgi'         => sub { $cgi_type = "fcgi" },
	   'minisvr'      => sub { $cgi_type = "minisvr" },
	   'sgml!'        => \$sgml_check,
	   'url=s'        => \$cgiurl,
	   "logfile=s"    => \$logfile,
	   "filter=s"     => \$filter,
	   "addparam=s"   => \%add_param,
	   "onlyresult!"  => \$only_result,
	  ) or die <<EOF;
usage: $0 [many options]
-addparam key=value: add a key-value CGI parameter to all requests, e.g. pref_fragezeichen=yes
-onlyresult: show only pages with the search result
EOF

if ($sgml_check) {
    open(ERR, "+>$errorfile"); close ERR;
}

if ($today || $yesterday || $days) {
    if ($today) { $days = 0 }
    elsif ($yesterday) { $days = 1 }

    require Date;
    my $d = Date->today - Date::Interval->new($days,0);
    $firstdate = sprintf("%02d/%3s/%04d",
			 $d->day, substr($d->monthname, 0, 3), $d->year);
}

my $cgigfxurl = $cgiurl;
if      ($cgi_type eq 'slow') {
} elsif ($cgi_type eq 'fcgi') {
    $cgiurl =~ s/\.cgi$/.fcgi/;
    # $cgigfxurl bleibt
    # XXX FCGI-Bug: Grafiken k�nnen nicht gezeichnet werden. Daf�r auf
    # das normale CGI umschalten.
} else {
    $cgiurl =~ s/\.cgi$/-fast.cgi/;
}

my $cgiinfourl = "http://www/~eserte/bbbike/t/cgiinfo.cgi";

if (!open(LOG, $logfile)) {
    die "Can't open $logfile: $!";
}
my @requests;
my @req_lines;
if ($seek) {
    seek LOG, $seek, 0;
}
if ($firstdate) {
    my $found;
    while(<LOG>) {
	if (/$firstdate/) {
	    $found = 1;
	    last;
	}
    }
    if (!$found) {
	die "Can't find date: $firstdate";
    }
    # XXX wenn diese Zeile eine bbbike.cgi-Zeile ist, wird diese ignoriert
}
while(<LOG>) {
    if (m{GET (?:/~eserte/bbbike/cgi/bbbike.cgi|/cgi-bin/bbbike.cgi)\?(\S+)}) {
	my $qs = $1;
	next if (defined $filter && !/$filter/o);
	next if m{\"BBBike-Test/\d+\.\d+\"}; # ignore my tests
	next if $only_result && (!has_params_for_search($qs) || $qs =~ /output_as=print/);
	push @requests, $qs; #XXX? uri_unescape($1);
	push @req_lines, $_ if $netscape;
    }
}
close LOG;

open(ERRLOG, ">/tmp/bbbike-cgi-error.log");

my $tee = IO::Tee->new(\*STDERR, \*ERRLOG);

my $ua = new LWP::UserAgent;

if ($netscape) {
    if (!-l "$ENV{HOME}/.netscape/lock") {
	system("netscape -no-install&");
	warn "Waiting for netscape to settle ... \n";
	sleep 10;
	for(1 .. 20) {
	    last if -l "$ENV{HOME}/.netscape/lock";
	    sleep 1;
	}
    }
#     if (open(TMP, ">/tmp/cgiinfourl.html")) {
# 	print TMP <<EOF;
# <html><head><script>
# window.open("$cgiinfourl", "cgiinfo", "width=400,height=200");
# </script></head>
# <body>
# </body></html>
# EOF
# 	close TMP;
# 	system("netscape -remote 'openURL(file:/tmp/cgiinfourl.html)' &");
#     }
}

for my $i (0 .. $#requests) {
    my $req_url_part = $requests[$i];
    if (keys %add_param) {
	my $q = CGI->new($req_url_part);
	while(my($k,$v) = each %add_param) {
	    $q->param($k, $v);
	}
	$req_url_part = $q->query_string;
    }
    my $full_url = ($req_url_part =~ /coords=/ ? $cgigfxurl : $cgiurl)
      . "?$req_url_part";
    my $check_text = "Check $full_url $req_url_part...\n";
    if ($verbose) {
	print $tee $check_text;
    }
    if ($netscape) {
	system("netscape -remote 'openURL($full_url, main)' &");
	my $q = new CGI {};
	$q->param('reqline', $req_lines[$i]);
#	system("netscape -remote 'openURL($cgiinfourl?" . $q->query_string .
#	       ", cgiinfo)' &");
	print STDERR "Continue ... ";
	<STDIN>;
    } else {
	my $req = new HTTP::Request('GET', $full_url);
	my $res = $ua->request($req);
	my $error_str = "";
	if (!$res->is_success) {
	    $error_str .= "*** ERROR: " . $res->as_string . "\n";
	} elsif ($res->content =~ /(Der Rechner ist �berlastet)/) {
	    die $1;
	} elsif ($res->content =~ /(Fehler.{1,40})/) {
	    $error_str .= "*** Programm error: $1\n";
	} elsif ($res->content =~ m|((<b>.*</b>).*nicht bekannt)|) {
	    $error_str .= "*** Warnung: $1\n";
	} elsif ($res->content =~ m|(.*nicht bekannt)|) {
	    $error_str .= "*** Warnung: $1\n";
	} elsif ($res->content =~ m|(Keine Route gefunden)|) {
	    $error_str .= "*** Warnung: $1\n";
	}			# else OK
	if ($error_str ne "") {
	    if (!$verbose) {
		print $tee $check_text;
	    }
	    print $tee $error_str;
	}

	if ($sgml_check &&
	    $res->content_type eq 'text/html' &&
	    $res->is_success
	   ) {
	    my $sgmlfile = "/tmp/bla.html";
	    if (open(ERR, ">>$errorfile")) {
		print ERR ("-"x70)."\n*** ".$req_url_part." ***\n";
		close ERR;
	    }
	    if (open(BLA, ">$sgmlfile")) {
		print BLA '<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML//EN">';
		print BLA "\n";
	        my($line, $rest) = split(/\n/, $res->content, 2);
		if ($line !~ /<!DOCTYPE/) {
		    print BLA "$line\n";
		}
		print BLA $rest;
		close BLA;

		local(%ENV) = %ENV;
		$ENV{SHELL} = "/bin/sh";
		system
		  ("nsgmls -m $sgml_catalog ".
		   "$sgmlfile 2>>$errorfile >/dev/null");

		print STDERR "Continue ... ";
		<STDIN>;
	    }
	}
    }
}

sub has_params_for_search {
    my($query_string) = @_;
    my %has;
    for my $type (qw(start via ziel)) {
	if ($query_string =~ /${type}c=([^&; ]+)/) {
	    my $coords = uri_unescape(uri_unescape($1));
	    next if $coords =~ /^\s*$/;
	    if ($type =~ /(?:start|ziel)/) {
		$has{$type}++;
	    }
	}
    }
    $has{start} && $has{ziel};
}

# REPO BEGIN
# REPO NAME is_in_path /home/e/eserte/src/repository 
# REPO MD5 1b42243230d92021e6c361e37c9771d1

=head2 is_in_path($prog)

=for category File

Return the pathname of $prog, if the program is in the PATH, or undef
otherwise.

DEPENDENCY: file_name_is_absolute

=cut

sub is_in_path {
    my($prog) = @_;
    return $prog if (file_name_is_absolute($prog) and -f $prog and -x $prog);
    require Config;
    my $sep = $Config::Config{'path_sep'} || ':';
    foreach (split(/$sep/o, $ENV{PATH})) {
	if ($^O eq 'MSWin32') {
	    return "$_\\$prog"
		if (-x "$_\\$prog.bat" ||
		    -x "$_\\$prog.com" ||
		    -x "$_\\$prog.exe");
	} else {
	    return "$_/$prog" if (-x "$_/$prog");
	}
    }
    undef;
}
# REPO END

# REPO BEGIN
# REPO NAME file_name_is_absolute /home/e/eserte/src/repository 
# REPO MD5 a77759517bc00f13c52bb91d861d07d0

=head2 file_name_is_absolute($file)

=for category File

Return true, if supplied file name is absolute. This is only necessary
for older perls where File::Spec is not part of the system.

=cut

sub file_name_is_absolute {
    my $file = shift;
    my $r;
    eval {
        require File::Spec;
        $r = File::Spec->file_name_is_absolute($file);
    };
    if ($@) {
	if ($^O eq 'MSWin32') {
	    $r = ($file =~ m;^([a-z]:(/|\\)|\\\\|//);i);
	} else {
	    $r = ($file =~ m|^/|);
	}
    }
    $r;
}
# REPO END

