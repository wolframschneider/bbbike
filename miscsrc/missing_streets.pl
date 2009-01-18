#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: missing_streets.pl,v 1.6 2009/01/18 21:53:15 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 2008 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://www.rezic.de/eserte/
#

use strict;
use FindBin;
use lib ("$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	);

use Getopt::Long;

use PLZ;
use Strassen::Core;

my $incl_fragezeichen = 1;
GetOptions("fz!" => \$incl_fragezeichen)
    or die "usage: $0 [-[no]fz]";

my %seen_street_with_bezirk;
my %seen_street;

my $s = Strassen->new("$FindBin::RealBin/../data/strassen"); # includes plaetze-orig
if ($incl_fragezeichen) {
    my $fz = Strassen->new("$FindBin::RealBin/../data/fragezeichen-orig"); # use -orig, because known unconnected streets are missing in non-orig
    $fz->init;
    while(1) {
	my $r = $fz->next;
	my $c = $r->[Strassen::COORDS];
	last if !@$c;
	$r->[Strassen::NAME] =~ s{:.*}{};
	$s->push($r);
    }
}

$s->init;
while(1) {
    my $r = $s->next;
    my $c = $r->[Strassen::COORDS];
    last if !@$c;
    my($name, $bezirk) = $r->[Strassen::NAME] =~ m{^(.*)\s+\((.*)\)$};
    if (defined $name) {
	my @bezirk = split /\s*,\s*/, $bezirk;
	for my $bezirk (@bezirk) {
	    $seen_street_with_bezirk{$name}->{$bezirk}++;
	}
    } else {
	$seen_street{$r->[Strassen::NAME]}++;
    }
}

my %missing_by_bezirk;

my $plz = PLZ->new;
$plz->load;
foreach my $rec (@{ $plz->{Data} }) {
    my($str, $bezirk) = ($rec->[PLZ::FILE_NAME],
			 $rec->[PLZ::FILE_CITYPART],
			);
    next if $str =~ m{^[SU]-Bhf\s}; # later XXX
    next if $str =~ m{^G�terbahnhof\s}; # later XXX
    next if $str =~ m{\(Gastst�tte\)}; # later XXX
    next if $str =~ m{\(Kolonie\)}; # later XXX
    next if $str =~ m{\(Siedlung\)}; # later XXX
    next if $str =~ m{^Kolonie\s}; # later XXX
    next if $str =~ m{^Siedlung\s}; # later XXX
    next if $str =~ m{^Wochenendsiedlung\s}; # later XXX
    next if $str =~ m{^KGA\s}; # later XXX
    next if $str =~ m{^(Modersohnbr�cke
		      |Heinrich-von-Kleist-Park # Sch�neberg
		      |Englischer[ ]Garten # Tiergarten
		      |Humboldthafen
		      |Schlo�[ ]Bellevue
		      |Westhafen
		      |Eichgestell # Obersch�neweide, exists as "(...)"
		      |Waldfriedhof[ ]Obersch�neweide # Obersch�neweide
		      |Wasserwerk[ ]an[ ]der[ ]Wuhlheide
		      |Abstellbahnhof # Grunewald
		      |Hundekehle
		      |Jagdschlo�[ ]Grunewald
		      |Lindwerder
		      |Wasserwerk[ ]Teufelssee
		      |Melli-Besse-Str. # Adlershof --- Ring oder Stra�e; Lage vollkommen unklar
		      |Ernst-Reuter-Siedlung # Wedding --- keine Stra�e hier zu erkennen
		      |Humboldthain # Wedding
		      |Albrechts[ ]Teerofen # Wannsee
		      |Landgut[ ]Eule # Ist das eine Stra�e?
		      |Glienicker[ ]Park
		      |Im[ ]Jagen # sieht uninteressant aus
		      |Moorlake
		      |Nikolskoe
		      |Pfaueninsel
		      |Sch�ferberg
		      |Siedlung[ ]10 # Baumschulenweg
		      |Am[ ]Sportplatz # Buch
		      |Britzer[ ]Hafen # Britz
		      |Am[ ]Bahnhof[ ]Grunewald[ ]Vorplatz[ ]II # Charlottenburg
                      |Avus[ ]Innenraum
		      |Avus[ ]Nordkurve
		      |DRK[ ]Kliniken
		      |Europa-Center
		      |Rudolf-Virchow-Krankenhaus
		      |Schleuse[ ]Charlottenburg
		      |Schleuse[ ]Pl�tzensee
		      |Schleuseninsel[ ]im[ ]Tiergarten
		      |Sportplatz[ ]Eichkamp
		      |Sportplatz[ ]K�hler[ ]Weg
		      |Sportplatz[ ]Maik�ferpfad
		      |Volkspark[ ]Jungfernheide
		      |Waldb�hne
		      |L�we-Siedlung
		      |Jagen[ ]59 # Gr�nau
		      |Waldfriedhof[ ]Gr�nau
		      |AEG[ ]Siedlung[ ]I,[ ]II # L�bars
		      |Karpfenteich-Wald
		      |Stadtrandsiedlung # Mariendfelde
		      |Anglerweg # Schm�ckwitz (auf der RV-Karte als "Schm�ckwitzwerder S�d (Anglerweg)" gekennzeichnet
		      |Schm�ckwitzwerder[ ]S�d # siehe Anglerweg
		      |Deutscher[ ]Camping[ ]Club[ ]Krossinsee
		      |Forstweg # keine eindeutige Referenzen
		      |Jagen[ ]17[ ]-[ ]20
		      |Jagen[ ]23
		      |Jagen[ ]25
		      |Jagen[ ]33
		      |Jagen[ ]37
		      |Schm�ckwitzwerder[ ]Nord
		      |Gutshof[ ]Glienicke # Kladow
		      |Habichtsgrund
		      |Habichtswald
		      |Havelfreunde # Wochenendsiedlungen
		      |Havelwiese # Kolonie
		      |Hottengrund # Kaserne
		      |Badewiese # Gatow
		      |Breitehorn
		      |Flugplatz[ ]Gatow
		      |Ruprecht
		      |Triftweg
		      )$}x; # decide later (non-strassen, e.g. brunnels or parks) XXX
    if (exists $seen_street_with_bezirk{$str}->{$bezirk}) {
    } elsif (exists $seen_street{$str}) {
    } else {
	push @{ $missing_by_bezirk{$bezirk} }, $str;
    }
}

#use YAML::Syck qw(Dump);
use YAML qw(Dump);
binmode STDOUT, ':encoding(iso-8859-1)';
#local $YAML::Syck::ImplicitUnicode = 1;
for my $key (sort { scalar(@{$missing_by_bezirk{$a}}) <=> scalar(@{$missing_by_bezirk{$b}}) } keys %missing_by_bezirk) {
    my %dump_hash = ("$key (" . scalar(@{$missing_by_bezirk{$key}}) . ")" => $missing_by_bezirk{$key});
    print Dump(\%dump_hash);
}
#print Dump(\%missing_by_bezirk);
#require Data::Dumper; print STDERR "Line " . __LINE__ . ", File: " . __FILE__ . "\n" . Data::Dumper->new([\%missing_by_bezirk],[qw()])->Indent(1)->Useqq(1)->Dump; # XXX

__END__

=pod

Show number of missing streets per bezirk:

     ./missing_streets.pl | grep '^[A-Z]' | sort

=cut
