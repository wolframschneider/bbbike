#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: temp_blockings_dates.t,v 1.6 2004/09/30 22:23:54 eserte Exp eserte $
# Author: Slaven Rezic
#

use strict;

use FindBin;
use lib ("$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	);
require BBBikeEdit;
use Date::Calc qw(Mktime Today_and_Now);

BEGIN {
    if (!eval q{
	use Test::More qw(no_plan);
	1;
    }) {
	print "1..0 # skip: no Test module\n";
	exit;
    }
}

my @Today_and_Now = Today_and_Now;

for my $test_data
    (
     [<<EOF,
L 37; (Petershagen-Seelow); s�dl. Seelow Kno. Diedersdorf/    Friedersdorf    Bau OU B 1n/B167n    halbseitige Sperrung/Lichtsignalanl.    17.08.2004-unbekannt 
EOF
      Mktime(2004,8,17,0,0,0),
      undef,
     ],

     [<<EOF,
L 86; (Gro� Kreutz-Ketzin); OD Deetz/Havel    Kanalarbeiten    halbseitige Sperrung/Lichtsignalanl.    09.06.2004-30.10.2004 
EOF
      Mktime(2004,6,9,0,0,0),
      Mktime(2004,10,30,23,59,59),
     ],

     [<<EOF,
L90 Johannisthaler Chaussee In beiden Richtungen zwischen Rudower Str. und K�nigsheideweg Br�ckenarbeiten, gesperrt eine Umleitung ist eingerichtet (bis 30.09.04.) (05:53) 
EOF
      Mktime(@Today_and_Now),
      Mktime(2004,9,30,23,59,59),
      0
     ],

     [<<EOF,
Brunnenstr. (Mitte) in beiden Richtungen, zwischen Bernauer Str. und Anklamer Str. in H�he Rheinsberger Str. Baustelle, Fahrbahn auf einen Fahrstreifen verengt (Bis Ende 09/2005) (08:34) 
EOF
      Mktime(@Today_and_Now),
      Mktime(2005,9,30,23,59,59),
      0
     ],

     [<<EOF,
Blankenburger Weg - Blankenburger-Weg-Br�cke (Pankow) in beiden Richtungen zwischen Pasewalker Str. und Bahnhofsstra�e Baustelle, Stra�e vollst�ndig gesperrt (bis 12/2004) (11:02) 
EOF
      Mktime(@Today_and_Now),
      Mktime(2004,12,15,23,59,59),
      0
     ],

     [<<EOF,
Wilhelmstr. (Mitte) in beiden Richtungen zwischen Mohrenstr. und Leipziger Str. Baustelle, Fahrbahnverengung (bis Ende Juli 2005) (09:29) 
EOF
      Mktime(@Today_and_Now),
      Mktime(2005,7,31,23,59,59),
      0
     ],

     [<<EOF,
Einbecker Str. (Lichtenberg) in Richtung Bhf Lichtenberg, zwischen Robert-Uhrig-Str. und Rosenfelder Str. Einbahnstra�e in Richtung Bhf Lichtenberg (bis Ende 12/2004) (10:21) 
EOF
      Mktime(@Today_and_Now),
      Mktime(2004,12,31,23,59,59),
      0
     ],

     [<<EOF,
Malchower Chaussee (Pankow) Richtung stadteinw�rts zwischen Ortnitstr. und Nachtalbenweg Baustelle, ver�nderte Verkehrsf�hrung. F�r die Arbeiten im Abschnitt von Dar�er str. bis Nachtalbenweg wird der Verkehr �ber Dar�er Str. - Nachtalbenw. umgeleitet (bis Mitte 12.2004) (03:09) 
EOF
      Mktime(@Today_and_Now),
      Mktime(2004,12,15,23,59,59),
      0
     ],

     [<<EOF,
Global City (05.09.03 - 07.09.03): Kurf�rstendamm/Tauentzienstr. von Uhlandstr. bis Passauer Str. gesperrt
EOF
      Mktime(2003,9,5,0,0,0),
      Mktime(2003,9,8,0,0,0),
     ],

     [<<EOF,
Umfangreiche Bauarbeiten imBereich der AS Spandauer Damm
Sperrung der Einfahrt zur BAB in Richtung S�d sowie der Ausfahrt in Richtung Nord
Fahrstreifenverengung und -verschwenkungen auf dem Spandauer Damm
Umleitungen sind eingerichtet.
Dauer: voraussichtlich bis 27.07.2003
EOF
      Mktime(@Today_and_Now),
      Mktime(2003,7,28,0,0,0),
      0,
     ],

     [<<EOF,
Im Bereich Tauentzienstra�e, Kurf�rstendamm zwischen N�rnberger Stra�e
und Joachim-Friedrich-Stra�e, Droysenstra�e, Kantstra�e,
in beiden Richtungen Sportveranstaltung,Stra�e gesperrt.
Dauer: 09.08.2003, 14.00 Uhr bis 24.00 Uhr
EOF
      Mktime(2003,8,9,14,0,0),
      Mktime(2003,8,10,0,0,0),
     ],

     [<<EOF,
Kurf�rstendamm zwischen Joachimstaler Stra�e und Fasanenstra�e  in
Fahrtrichtung Westen gesperrt (Kranarbeiten).
Dauer: 27.07.2003 zwischen 05.30 Uhr und ca. 22.00 Uhr
EOF
      Mktime(2003,7,27,5,30,0),
      Mktime(2003,7,27,22,0,0),
     ],

     [<<EOF,
Stra�e des 17. Juni ist zwischen Entlastungstra�e und Klopstockstra�e gesperrt.
(X Race-Veranstaltung)
Dauer: 24.08.2003, von 14.00 Uhr bis 20.00 Uhr
EOF
      Mktime(2003,8,24,14,0,0),
      Mktime(2003,8,24,20,0,0),
     ],

     [<<EOF,
"Oberbaum Art-Br�ckenfest" am 10.08.2003
zwischen 07.00 Uhr bis 24.00 Uhr ist die Oberbaumbr�cke f�r den
Fahrzeugverkehr gesperrt.
EOF
      Mktime(2003,8,10,7,0,0),
      Mktime(2003,8,11,0,0,0),
     ],

     [<<EOF,
zwischen Rummelsburger Stra�e und Schlichtallee
Bauarbeiten, gesperrt. Dauer: bis 31.08.2003.
EOF
      Mktime(@Today_and_Now),
      Mktime(2003,9,1,0,0,0),
      0
     ],

     [<<EOF,
Alfred-Kowalke-Stra�e
zwischen AmTierpark und Kurze Stra�e
ver�nderte Verkehrsf�hrung im Baustellenbereich.
Dauer:28.04.2003, 07.00 Uhr bis 15.12.2003
EOF
      Mktime(2003,4,28,7,0,0),
      Mktime(2003,12,16,0,0,0),
     ],

     [<<EOF,
Alfred-Kowalke-Stra�e
Richtung Am Tierpark
wegen Stra�enarbeiten als Einbahnstra�e ausgewiesen.
Dauer: bis 31.12.2003
EOF
      Mktime(@Today_and_Now),
      Mktime(2004,1,1,0,0,0),
      0
     ],

     [<<EOF,
Die Br�ckenstra�e, Richtung Heinrich-Heine-Stra�e ist zwischen M�rkisches Ufer und K�penicker Stra�e wegen Bauarbeiten als Einbahnstra�e eingerichtet. Die n�rdliche Einm�ndung Rungestra�e/Br�ckenstra�e wird gesperrt.Zufahrt zu den Grundst�cken 6 - 11 und 28 - 30 ist nur �ber den K�llnischen Park m�glich.
Dauer: 23.04.2003, 04.00 Uhr bis ca. 29.08.2004
EOF
      Mktime(2003,4,23,4,0,0),
      Mktime(2004,8,30,0,0,0),
     ],

     [<<EOF,
Grenzallee
Bauarbeiten  in beiden Richtungen zwischen Neuk�llnische Allee und Karl-Marx-Stra�e
im Zusammenhang mit der Verkehrsf�hrung der A113, AS Grenzallee/Bergiusstra�e.
Fahrbahneinengungen durch Kanal- und Stra�enbauarbeiten. Es kann zu erheblichen Verkehrsbehinderungen kommen.
Dauer: 10.03.2003 bis Juli 2003
EOF
      Mktime(2003,3,10,0,0,0),
      Mktime(2003,8,1,0,0,0),
     ],

     [<<EOF,
Britzer Damm    (Kreuzungsbereich Tempelhofer Weg / Fulhamer Allee)
Umbau der Stra�enkreuzung ab 14.04.2003 bis 09.08.2003. Der Britzer Damm wird in beiden
Richtungen auf einen Fahrstreifen eingeschr�nkt, ein Linksabbiegen ist nicht m�glich.
EOF
      Mktime(2003,4,14,0,0,0),
      Mktime(2003,8,10,0,0,0),
     ],

     [<<EOF,
Schwarzelfenweg
zwischen Ortnitstra�e und Dar�er Stra�e,
Gefahrenstelle, Stra�e gesperrt bis voraussichtlich Dezember 2003.
EOF
      Mktime(@Today_and_Now),
      Mktime(2004,1,1,0,0,0),
      0
     ],

     [<<EOF,
Heerstra�e
zwischen Sandstra�e und G�rtnereiring
in beiden Richtungen Stra�enarbeiten,
Fahrbahn jeweils auf einen Fahrstreifen eingeengt
ab: 21.07.2003, 07.00 Uhr f�r ca. 4 Monate.
EOF
      Mktime(2003,7,21,7,0,0),
      Mktime(2003,11,21,7,0,0),
     ],

     [<<EOF,
Alt-Wittenau zwischen Eichborndamm und Triftstra�e B�rgerfest, Stra�e gesperrt, Dauer: 19.06.2004, 10.00 Uhr bis 20.06.2004, 02.00 Uhr.
EOF
      Mktime(2004,06,19,10,00,00),
      Mktime(2004,06,20,02,00,00),
     ],

    ) {
	my $btxt = shift @$test_data;
	my $errors = 0;
	my($start_date, $end_date, $prewarn_days, $rx_matched);
	eval {
	    ($start_date, $end_date, $prewarn_days, $rx_matched)
		= BBBikeEditUtil::parse_dates($btxt);
	    # Delta 1s for Today_and_Now tests
	    ok(abs($start_date - shift @$test_data) <= 1) or $errors++;
	    my $test_end_date = shift @$test_data;
	    if (!defined $test_end_date) {
		is($end_date, undef) or $errors++;
	    } else {
		ok(abs($end_date   - $test_end_date) <= 1) or $errors++;
	    }
	    is($prewarn_days, shift @$test_data) or $errors++;
	};
	if ($@) {
	    diag $@;
	    $errors++;
	}
	diag "$btxt\nParsed: " . scalar(localtime($start_date)) . " - " .
	    scalar(localtime($end_date)) . ", $prewarn_days prewarn days\n" .
	    "Regular expression match $rx_matched"
	    if $errors;
    }

__END__
