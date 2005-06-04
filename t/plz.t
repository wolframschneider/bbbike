#!/usr/bin/env perl
# -*- perl -*-

#
# $Id: plz.t,v 1.21 2005/06/04 16:09:53 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 1998,2002,2003,2004 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://bbbike.sourceforge.net/
#

#
# Diese Tests k�nnen fehlschlagen, wenn "strassen" oder "plaetze" erweitert
# wurde. In diesem Fall muss die Testausgabe per Augenschein �berpr�ft und
# dann mit der Option -create aktualisiert werden.
#

package main;

use Test::More;
BEGIN { plan tests => 61 }

use FindBin;
use lib ("$FindBin::RealBin/..",
	 "$FindBin::RealBin/../data",
	 "$FindBin::RealBin/../lib",
	 "$FindBin::RealBin",
	);
use PLZ;
use PLZ::Multi;
use Strassen;
use File::Basename;
use Getopt::Long;
use Data::Dumper;
use BBBikeTest qw(eq_or_diff);

use strict;

my $tmpdir = "$FindBin::RealBin/tmp/plz";
my $create;
my $test_file = 0;
my $INTERACTIVE;
my $in_str;
my $goto_xxx;
my $extern = 1;

if (!GetOptions("create!" => \$create,
		"xxx!" => \$goto_xxx,
		"v" => \$PLZ::VERBOSE,
		"extern!" => \$extern,
	       )) {
    die "Usage: $0 [-create] [-xxx] [-v] [-[no]extern]";
}

# XXX auch Test mit ! -small

use constant STREET   => 0;
use constant MATCHINX => 1;
use constant NOMATCH  => 2;

my @in_str;
if (defined $in_str) {
    $INTERACTIVE = 1;
    @in_str = ([$in_str]);
} else {
    # Array-Definition:
    # 0: gesuchte Stra�e
    # 1: bei mehreren Matches: Index des Matches, der schlie�lich genommen wird
    # 2: 1, wenn f�r diese Stra�e nichts gefunden werden kann
    @in_str =
      (
       ['KURFUERSTENDAMM',0],
       ['duden'],
       ['methfesselstrasse'],
       ['garibaldi'],
       ['heerstr', 1],
       ['fwefwfiiojfewfew', undef, 1],
       ['mollstrasse',0],
      );
    if ($create) {
	print "# Test files are written to $tmpdir.\n";
    } else {
	print "# Test files read from $tmpdir.\n";
	print "# If there are non-fatal errors, try to re-run this script with -create\n";
    }
}

my $plz = new PLZ;
if (!defined $plz) {
    if ($INTERACTIVE) {
	die "Das PLZ-Objekt konnte nicht definiert werden";
    } else {
	fail("PLZ object");
	exit;
    }
}
pass("PLZ object");

my $plz_multi = PLZ::Multi->new("Berlin.coords.data",
				"Potsdam.coords.data",
				Strassen->new("plaetze"),
				-cache => 1,
			       );
isa_ok($plz_multi, "PLZ");

my $dump = sub {
    my $obj = shift;
    Data::Dumper->new([$obj],[])->Indent(1)->Useqq(1)->Dump;
};

my @standard_look_loop_args =
    (
     Max => 1,
     MultiZIP => 1, # introduced because of Hauptstr./Friedenau vs. Hauptstr./Sch�neberg problem
     MultiCitypart => 1, # works good with the new combine method
     Agrep => 'default',
     Noextern => !$extern,
    );

if ($goto_xxx) { goto XXX }

testplz();

if (0 && !$INTERACTIVE) { # XXX geht noch nicht
    my $f = "/tmp/" . basename($plz->{File}) . ".gz";
    system("gzip < $plz->{File} > $f");
    if (!-f $f) {
	ok(0);
	exit;
    }
    $plz = new PLZ $f;
    if (!defined $plz) {
	ok(0, "PLZ object by file");
	exit;
    }
    ok(1, "PLZ object by file");

    @in_str =
      (
       ['duden', <<EOF],
Columbiadamm
Dudenstr.
Friesenstr. (Kreuzberg, Tempelhof)
Gol�ener Str.
Gro�beerenstr. (Kreuzberg)
Heimstr.
J�terboger Str.
Katzbachstr.
Kreuzbergstr.
Mehringdamm
Methfesselstr.
Monumentenstr.
M�ckernstr.
Schwiebusser Str.
Yorckstr.
Z�llichauer Str.
EOF
      );
    testplz();
}

{
    my @res;
    
    @res = $plz->look("Hauptstr.", MultiZIP => 1);
    is(scalar @res, 8, "Hits for Hauptstr.")
	or diag $dump->(\@res);
    @res = map { $plz->combined_elem_to_string_form($_) } $plz->combine(@res);
    is(scalar @res, 7, "Combine hits")
	or diag $dump->(\@res);

    @res = $plz->look("Hauptstr.", MultiCitypart => 1, MultiZIP => 1);
    is(scalar @res, 9, "Hits for Hauptstr. with MultiCitypart")
	or diag $dump->(\@res);
    @res = map { $plz->combined_elem_to_string_form($_) } $plz->combine(@res);
    is(scalar @res, 7, "Combine hits")
	or diag $dump->(\@res);
    my($friedenau_schoeneberg) = grep { $_->[1] =~ /friedenau/i } @res;
    is($friedenau_schoeneberg->[PLZ::LOOK_NAME], "Hauptstr.");
    is($friedenau_schoeneberg->[PLZ::LOOK_CITYPART], "Friedenau, Sch\366neberg");
    is($friedenau_schoeneberg->[PLZ::LOOK_ZIP], "10827, 12159", "Check PLZ");

    @res = grep { defined $_->[PLZ::LOOK_COORD] } $plz->look("Am Nordgraben", MultiCitypart => 1, MultiZIP => 1);
    is(scalar @res, 2, "Hits for Am Nordgraben. with MultiCitypart")
	or diag $dump->(\@res);
    @res = map { $plz->combined_elem_to_string_form($_) } $plz->combine(@res);
    is(scalar @res, 1, "Combine hits")
	or diag $dump->(\@res);

    @res = $plz->look("friedrichstr", Citypart => "mitte");
    is(scalar @res, 1, "Lower case match, Citypart supplied")
	or diag $dump->(\@res);
    is($res[0]->[PLZ::LOOK_NAME], 'Friedrichstr.');
    is($res[0]->[PLZ::LOOK_CITYPART], 'Mitte');
    is($res[0]->[PLZ::LOOK_ZIP], 10117);

    @res = $plz->look("friedrichstr", Citypart => 10117);
    is(scalar @res, 1, "ZIP supplied as citypart")
	or diag $dump->(\@res);
    is($res[0]->[PLZ::LOOK_NAME], 'Friedrichstr.');
    is($res[0]->[PLZ::LOOK_CITYPART], 'Mitte');
    is($res[0]->[PLZ::LOOK_ZIP], 10117);

    @res = $plz->look_loop(PLZ::split_street("Heerstr. 1"),
			   @standard_look_loop_args);
    is(scalar @{$res[0]}, 7, "Hits for Heerstr.")
	or diag $dump->(\@res);
    ok(grep { $_->[PLZ::LOOK_NAME] eq 'Heerstr.' } @{$res[0]});

    @res = $plz->look_loop(PLZ::split_street("Stra�e des 17. Juni"),
			   @standard_look_loop_args);
    is(scalar @{$res[0]}, 2, "Hits for Stra�e des 17. Juni")
	or diag $dump->(\@res);

    @res = $plz->look_loop(PLZ::split_street("  Str. des 17. Juni 153  "),
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'Stra�e des 17. Juni' } @{$res[0]}), 1,
       "Hits for Stra�e des 17. Juni (hard one)")
	or diag $dump->(\@res);

    @res = $plz->look_loop(PLZ::split_street("gaertnerstrasse 22"),
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'G�rtnerstr.' } @{$res[0]}), 1)
	or diag $dump->(\@res);

## This is too hard: the algorithm can't strip "strasse" because of the missing
## "s". Well...
#      @res = $plz->look_loop(PLZ::split_street("KAnzowtrasse 1"),
#  			   @standard_look_loop_args);
#      ok(!!(grep { $_->[PLZ::LOOK_NAME] eq 'Kanzowstr.' } @{$res[0]}), 1,
#         $dump->(\@res));

    @res = $plz->look_loop(PLZ::split_street("Grossbeerenstr. 27a"),
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'Gro�beerenstr.' } @{$res[0]}), 1,
       "Missing sz")
	or diag $dump->(\@res);

    @res = $plz->look_loop(PLZ::split_street("Leibnizstrasse 3-4"),
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'Leibnizstr.' } @{$res[0]}), 1,
       "`strasse' instead of `str.', complex house number")
	or diag $dump->(\@res);

 XXX:
    @res = $plz_multi->look_loop(PLZ::split_street("M�hlenstra�e 24 - 26"),
				 @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'M�hlenstr.' } @{$res[0]}), 1,
       "`stra�e' instead of `str.', complex house number with whitespace")
	or diag $dump->(\@res);

    @res = $plz->look_loop(PLZ::split_street("Sanderstr. 29/30"),
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'Sanderstr.' } @{$res[0]}), 1,
       "Complex house number")
	or diag $dump->(\@res);

    @res = $plz->look_loop("Tierpark",
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'Am Tierpark' } @{$res[0]}), 1,
       "Tierpark => Am Tierpark")
	or diag $dump->(\@res);

    @res = $plz->look_loop("Schumacher",
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'Kurt-Schumacher-Damm' } @{$res[0]}), 1,
       "Schumacher => Kurt-Schumacher")
	or diag $dump->(\@res);

    @res = $plz->look_loop("karower chausee",
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'Karower Chaussee' } @{$res[0]}), 1,
       "Rechtschreibfehler")
	or diag $dump->(\@res);

    @res = $plz->look_loop("Augsburger Str. (Charlottenburg",
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'Augsburger Str.' } @{$res[0]}), 1,
       "Quoting regexp")
	or diag $dump->(\@res);

    @res = $plz->look_loop("Augsburger Str. (Charlottenburg",
			   @standard_look_loop_args, GrepType => "grep-umlaut");
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'Augsburger Str.' } @{$res[0]}), 1,
       "Quoting regexp for grep-umlaut search type")
	or diag $dump->(\@res);

    @res = $plz->look_loop("Augsburger Str. (Charlottenburg",
			   @standard_look_loop_args,
			   GrepType => "grep", Noextern => 1);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'Augsburger Str.' } @{$res[0]}), 1,
       "Quoting regexp for grep search type")
	or diag $dump->(\@res);

    @res = $plz->look_loop("U-Bhf Platz der Luftbr",
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'U-Bhf Platz der Luftbr�cke' } @{$res[0]}), 1,
       "U-Bahnhof")
	or diag $dump->(\@res);

    @res = $plz->look_loop("u weberwiese",
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'U-Bhf Weberwiese' } @{$res[0]}), 1,
       "U-Bahnhof, abbreviated")
	or diag $dump->(\@res);

    @res = $plz->look_loop("s-bahnhof heerstr",
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'S-Bhf Heerstr.' } @{$res[0]}), 1,
       "S-Bahnhof (Heerstr), long form")
	or diag $dump->(\@res);

    @res = $plz->look_loop("s-bahnhof grunewald",
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'S-Bhf Grunewald' } @{$res[0]}), 1,
       "S-Bahnhof (Grunewald), long form")
	or diag $dump->(\@res);

    # A complaint by alh:
    @res = $plz->look_loop("lehrter bahnhof",
			   @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'S-Bhf Lehrter Bahnhof (Hauptbahnhof)' } @{$res[0]}), 1,
       "U-Bahnhof")
	or diag $dump->(\@res);

    @res = $plz_multi->look("brandenburger tor");
    is(scalar(grep { $_->[PLZ::LOOK_CITYPART] eq 'Mitte' } @res), 1,
       "Should find Brandenburger Tor in Mitte")
	or diag $dump->(\@res);
    is(scalar(grep { $_->[PLZ::LOOK_CITYPART] eq 'Potsdam' } @res), 1,
       "Should find Brandenburger Tor in Potsdam")
	or diag $dump->(\@res);

    @res = $plz_multi->look_loop("brandenburger tor",
				 @standard_look_loop_args);
    is(scalar(grep { $_->[PLZ::LOOK_CITYPART] eq 'Mitte' } @{$res[0]}), 1,
       "Should find Brandenburger Tor in Mitte")
	or diag $dump->(\@res);
    is(scalar(grep { $_->[PLZ::LOOK_CITYPART] eq 'Potsdam' } @{$res[0]}), 1,
       "Should find Brandenburger Tor in Potsdam")
	or diag $dump->(\@res);

    @res = $plz_multi->look_loop("kl. pr�sidentenstr.");
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'Kleine Pr�sidentenstr.' } @{$res[0]}), 1,
       "Expanding kl.")
	or diag $dump->(\@res);
    @res = $plz_multi->look_loop("gr. seestr.");
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq 'Gro�e Seestr.' } @{$res[0]}), 1,
       "Expanding gr.")
	or diag $dump->(\@res);

    @res = $plz_multi->look_loop(PLZ::split_street("potsdam, schopenhauerstr."),
				 @standard_look_loop_args);
    is(!!(grep { $_->[PLZ::LOOK_NAME] eq "Schopenhauerstr." } @{$res[0]}), 1, 
       "split_street with city, street syntax, city part")
	or diag $dump->(\@res);
    is(!!(grep { $_->[PLZ::LOOK_CITYPART] eq "Potsdam" } @{$res[0]}), 1, 
       "split_street with city, street syntax, street part")
	or diag $dump->(\@res);

}


sub testplz {

    foreach my $noextern (0, 1) {
	foreach my $def (@in_str) {
	    $in_str = $def->[STREET];
	    my($str_ref) = $plz->look_loop($in_str,
					   Max => 20,
					   Agrep => 3,
					   Noextern => $noextern,
					  );
	    my(@str) = @$str_ref;
	    if ($def->[NOMATCH]) {
		is(scalar @str, 0, "Expected no match");
		next;
	    }
	    if (!@str) {
		if ($INTERACTIVE) {
		    die "Keine Stra�e in der PLZ gefunden"
		} else {
		    is(0, 1, "Keine Stra�e f�r $in_str gefunden");
		    next;
		}
	    }

	    my $str;
	    if (@str == 1) {
		$str = $str[0];
	    } else {
		if ($INTERACTIVE) {
		    my $i = 0;
		    foreach (@str) {
			print $i+1 . ": $_->[STREET] ($_->[NOMATCH])\n";
			$i++;
		    }
		    print "> ";
		    chomp(my $res = <STDIN>);
		    $str = $str[$res-1];
		} else {
		    $str = $str[$def->[MATCHINX]];
		}
	    }
	    my $plz_re = $plz->make_plz_re($str->[2]);
	    my @res1 = $plz->look($plz_re, Noextern => 0, Noquote => 1);
	    $str = new Strassen "strassen";

	    my @s = ();
	    foreach ($str->union(\@res1)) {
		push(@s, $str->get($_)->[0]);
	    }

	    my $printres = join("\n", sort @s) . "\n";

	    if ($INTERACTIVE) {
		print $printres;
	    } else {
		do_file($printres);
	    }
	}
    }

}

sub do_file {
    my $res = shift;
    my $file = ++$test_file;

    if ($create) {
	if (!-d $tmpdir) {
	    require File::Path;
	    File::Path::mkpath([$tmpdir]);
	}
	open(T, ">$tmpdir/$file") or die "Can't create $tmpdir/$file: $!";
	print T $res;
	close T;
	1;
    } else {
	if (open(T, "$tmpdir/$file")) {
	    my $buf = join '', <T>;
	    close T;

	    my $label = "Compare results with file $file";
	    eq_or_diff($buf, $res, $label);
	} else {
	    warn "Can't open $tmpdir/$file: $!. Please use the -create option first and check the results in $tmpdir!\n";
	    ok(0);
	}
    }
}
