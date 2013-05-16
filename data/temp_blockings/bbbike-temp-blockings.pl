# -*- mode: bbbike; coding: iso-8859-1 -*-
# temp-blocking
# XXX undef old entries
# iso2epoch: date -j 2012MMDDhhmm +%s
#            date +%s
require Time::Local;
my $isodate2epoch = sub {
    my $isodate = shift;
    if (my($y,$m,$d,$H,$M,$S) = $isodate =~ /^(\d{4})\D*(\d{2})\D*(\d{2})\D*(\d{2})\D*(\d{2})\D*(\d{2})\D*$/) {
	Time::Local::timelocal($S,$M,$H,$d,$m-1,$y-1900);
    } else {
	require Carp;
	Carp::croak("Cannot parse ISO date <$isodate>");
    }
};

@temp_blocking =
    (
     { from  => Time::Local::timelocal(reverse(2003-1900,5-1,21,0,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,5-1,23,0,0,0)),
       file  => "richardplatz.bbd",
       text  => "Richardplatz - wegen eines Stra�enfestes f�r den gesamten Fahrzeugverkehr gesperrt",
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,5-1,26,0,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,6-1,2,0,0,0)),
       file  => "kirchentag-20030526.bbd",
       text  => "Gesperrte Stra�en w�hren des Kirchentages vom 26.5. bis zum 1.6. (Stra�e des 17. Juni)",
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,5-1,27,8,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,5-1,29,0,0,0)),
       file  => "kirchentag-20030528.bbd",
       text  => "Gesperrte Stra�en am 28.5. zwischen 14 Und 24 Uhr w�hrend des Kirchentages (im Bereich Pariser Platz - Unter den Linden - Friedrichstr. - Gendarmenmarkt)",
       type  => "handicap",
     },
     { from  => $isodate2epoch->("2013-05-16 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-05-20 23:59:59"),
       periodic => 1,
       text  => 'Stra�enfest rund um den Bl�cherplatz, 17.05.2013 bis 20.05.2013',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 9521,10010 9827,10051
userdel	2::temp 9521,10010 9448,10014
userdel	2::temp 9599,10175 9687,10180 9825,10206
userdel	2::temp 9416,10196 9599,10175
userdel	2::temp 9579,10122 9536,10064
userdel	2::temp 9579,10122 9631,10142 9702,10129
userdel	2::temp 9837,10117 9827,10051
userdel	2::temp 9837,10117 9858,10199
userdel	2::temp 9599,10175 9579,10122
userdel	2::temp 9702,10129 9827,10051
userdel	2::temp 9702,10129 9816,10119
userdel	2::temp 9599,10175 9631,10142 9687,10180
userdel	3 9922,10010 9827,10051 9837,9856
userdel	3 9837,9856 9827,10051 9922,10010
EOF
     },
     { from  => $isodate2epoch->("2013-05-18 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-05-19 23:59:59"),
       periodic => 1,
       text  => 'Karneval der Kulturen, 19.5.2013',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 11909,9155 11831,8989 11767,9026 11629,9086 11550,9104 11500,9116 11449,9125 11136,9183 11108,9187 10713,9260 10625,9259 10564,9292 10198,9405 10032,9456 9937,9484 9927,9487 9790,9528 9676,9564 9552,9602 9451,9634 9334,9670 9243,9696 9044,9753 9002,9731 8777,9601 8679,9544 8595,9495 8358,9568 8192,9619
userdel	2::temp 10713,9260 10670,9286 10639,9304 10564,9292
userdel	3 8774,9534 8777,9601 8779,9812
userdel	3 8779,9812 8777,9601 8774,9534
userdel	3 9000,9509 9044,9753 9073,9915
userdel	3 9073,9915 9044,9753 9000,9509
userdel	3 9280,9476 9334,9670 9387,9804
userdel	3 9387,9804 9334,9670 9280,9476
userdel	3 9524,9426 9552,9602 9588,9827
userdel	3 9588,9827 9552,9602 9524,9426
userdel	3 9650,9404 9676,9564 9705,9732
userdel	3 9705,9732 9676,9564 9650,9404
userdel	3 9767,9386 9790,9528 9820,9718
userdel	3 9820,9718 9790,9528 9767,9386
userdel	3 9892,9286 9927,9487 9957,9692
userdel	3 9957,9692 9927,9487 9892,9286
userdel	3 10004,9268 10032,9456 10067,9667
userdel	3 10067,9667 10032,9456 10004,9268
userdel	3 10123,9233 10198,9405 10306,9640
userdel	3 10306,9640 10198,9405 10123,9233
userdel	3 10547,9233 10564,9292 10580,9361
userdel	3 10580,9361 10564,9292 10547,9233
userdel	3 10705,9234 10713,9260 10747,9326
userdel	3 10747,9326 10713,9260 10705,9234
userdel	3 11141,9107 11136,9183 11208,9345 11274,9492
userdel	3 11274,9492 11208,9345 11136,9183 11141,9107
userdel	3 11998,8872 11880,8955 11831,8989 11830,8917 11845,8824 11879,8672 11882,8527
userdel	3 11882,8527 11879,8672 11845,8824 11830,8917 11831,8989 11880,8955 11998,8872
EOF
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,6-1,19,6,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,6-1,22,22,0,0)),
       file  => "richardplatz.bbd",
       text  => "Richardplatz - wegen eines Stra�enfestes f�r den gesamten Fahrzeugverkehr gesperrt. Dauer: 21.06.03, 06:00 Uhr bis 22.06.03, 22:00 Uhr",
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,6-1,26,10,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,6-1,29,18,0,0)),
       file  => "wiesenfest.bbd",
       text  => "Finsterwalder Stra�e zwischen Engelroder Weg und Calauer Stra�e Vollsperrung aufgrund des Wiesenfestes. Dauer:28.06.2003, 10.00 Uhr bis 29.06.2003, 18.00 Uhr",
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,6-1,20,4,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,6-1,22,23,59,59)),
       file  => "strassenfest-karl-marx-str.bbd",
       text  => "Karl-Marx-Stra�e zwischen Flughafenstra�e und Werbellinstra�e, Erkstra�e zwischen Karl-Marx-Stra�e und Donaustra�e: Stra�enfest, Stra�en gesperrt. Datum: 21.06.2003, 04.00 Uhr bis 22.06.2003, 24.00 Uhr",
     },
     { from  => Time::Local::timelocal(reverse(2007-1900,6-1,23,5,0,0)),
       until => Time::Local::timelocal(reverse(2007-1900,6-1,24,5,0,0)),
       file  => "csd.bbd",
       text  => "CSD am 23.6.",
     },
     { from  => 1119070200, # 2005-06-18 06:50
       until => 1119218400, # 2005-06-20 00:00
       text  => 'L71 Badstra�e Berlin-Wedding - Berlin-Mitte in beiden Richtungen Zwischen Pankstra�e und B�ttgerstra�e beidseitig Veranstaltung, Stra�e gesperrt bis 19.06.2005, 23:00 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8862,16208 8788,16264
userdel	2 8928,16158 8993,16100
userdel	2 8993,16100 9059,16038
userdel	2 9134,15953 9059,16038
EOF
     },
     { from  => $isodate2epoch->("2013-04-19 10:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-04-21 20:00:00"),
       periodic => 1, # erster Termin im Jahr
       text  => "Rheinstra�enfest in der Rheinstra�e zwischen Kaisereiche und Walther-Schreiber-Platz. Dauer: 20.04.2013 10:00 bis 21.04.2013 20:00",
       data  => <<EOF,
userdel	2::temp 5644,6936 5533,6753 5424,6584 5370,6486
EOF
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,7-1,8,6,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,7-1,12,23,59,59)),
       file  => "loveparade.bbd",
       text  => "Loveparade, Stra�en gesperrt. Dauer: 11.07.2003, 20.00 Uhr bis 13.07.2003, 14.00 Uhr",
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,7-1,7,6,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,7-1,12,20,00,00)),
       file  => "kranarbeiten.bbd",
       text  => "Charlottenstra�e zwischen Kochstra�e und Besselstra�e Kranarbeiten, Stra�e gesperrt. Dauer: 08.07.2003, 06.00 Uhr bis 12.07.2003, 20.00 Uhr",
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,7-1,10,20,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,7-1,14,4,00,00)),
       file  => "pankow-20030711.bbd",
       text  => "Berliner Stra�e zwischen Granitzstra�e und Hadlichstra�e sowie
Florastra�e zwischen Grunowstra�e und Berliner Stra�e, Baustelle, Stra�e in beiden Richtungen gesperrt. Dauer: 11.07.2003, 20.00 Uhr bis 14.07.2003, 04.00 Uhr",
       type  => "handicap",
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,7-1,19,8,00,00)),
       until => Time::Local::timelocal(reverse(2003-1900,7-1,20,20,00,00)),
       file  => "stauffenbergstr.bbd",
       text  => "Stauffenbergstr. und Umgebung wegen Veranstaltung gesperrt. Dauer: 20.07.2003, 08.00 Uhr bis 20.00 Uhr"
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,7-1,18,7,00,00)),
       until => Time::Local::timelocal(reverse(2003-1900,7-1,20,23,59,00)),
       file  => "oberbaumbruecke.bbd",
       text  => "Oberbaum-Br�ckenfest am 20.07.2003 zwischen 07.00 Uhr bis 24.00 Uhr f�r den Fahrzeugverkehr gesperrt."
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,8-1,8,7,00,00)),
       until => Time::Local::timelocal(reverse(2003-1900,8-1,10,23,59,00)),
       file  => "oberbaumbruecke.bbd",
       text  => "Oberbaum-Br�ckenfest am 10.08.2003 zwischen 07.00 Uhr bis 24.00 Uhr f�r den Fahrzeugverkehr gesperrt."
     },
     { from  => 1060257600, # 2003-08-07 14:00
       until => 1060466400, # 2003-08-10 00:00
       file  => '20030809.bbd',
       text  => 'Im Bereich Tauentzienstra�e, Kurf�rstendamm zwischen N�rnberger Stra�e und Joachim-Friedrich-Stra�e, Droysenstra�e, Kantstra�e, in beiden Richtungen Sportveranstaltung, Stra�e gesperrt. Dauer: 09.08.2003, 14.00 Uhr bis 24.00 Uhr'
     },
     { from  => 1061640000, # 2003-08-23 14:00
       until => 1061748000, # 2003-08-24 20:00
       file  => 'xrace.bbd',
       text  => 'Stra�e des 17. Juni ist zwischen Entlastungstra�e und Klopstockstra�e gesperrt. (X Race-Veranstaltung) Dauer: 24.08.2003, von 14.00 Uhr bis 20.00 Uhr'
     },
     { from  => 1059190200, # 2003-07-26 05:30
       until => 1059336000, # 2003-07-27 22:00
       file  => '20030727.bbd',
       text  => 'Kurf�rstendamm zwischen Joachimstaler Stra�e und Fasanenstra�e in Fahrtrichtung Westen gesperrt (Kranarbeiten). Dauer: 27.07.2003 zwischen 05.30 Uhr und ca. 22.00 Uhr',
       type  => "handicap",
     },
     { from  => 1061539200, # 2003-08-22 10:00
       until => 1061661600, # 2003-08-23 20:00
       file  => 'johnfosterdulles.bbd',
       text  => 'John-Foster-Dulles-Allee zwischen Spreeweg und Entlastungsstra�e, Sportveranstaltung, Stra�e in beiden Richtungen gesperrt. Dauer: 23.08.2003, 10.00 Uhr bis 20.00 Uhr',
       type  => 'gesperrt',
     },
     { from  => 1062136800, # 2003-08-29 08:00
       until => 1062280800, # 2003-08-31 00:00
       file  => 'maybachufer.bbd',
       text  => 'Maybachufer zwischen Kottbusser Tor und Hobrechtbr�cke wegen Stra�enfest f�r den Fahrzeugverkehr gesperrt. Dauer: 30.08.2003 zwischen 08.00 Uhr und 24.00 Uhr',
       type  => 'gesperrt',
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,8-1,9,10,00,00)),
       until => Time::Local::timelocal(reverse(2003-1900,8-1,10,20,00,00)),
       file  => 'johnfosterdulles.bbd',
       text  => 'John-Foster-Dulles-Allee zwischen Spreeweg und Entlastungsstra�e, Sportveranstaltung, Stra�e in beiden Richtungen gesperrt. Dauer: 10.08.2003, 10.00 Uhr bis 20.00 Uhr',
       type  => 'gesperrt',
     },
     { from  => 1061496000, # 2003-08-21 22:00
       until => 1061676000, # 2003-08-24 00:00
       file  => 'hanfparade.bbd',
       text  => 'Sperrungen zur Hafparade am 23.8.2003',
       type  => 'gesperrt',
     },
     { from  => 1061625600, # 2003-08-23 10:00
       until => 1061730000, # 2003-08-24 15:00
       file  => 'kudamm_rad.bbd',
       text  => 'Kurf�rstendamm (s�dl. Richtungsfahrbahn) zwischen Uhlandstra�e und Leibnizstra�e gesperrt. Grund: Radsportveranstaltung Dauer: 24.08.2003,10.00 Uhr bis 15.00 Uhr',
       type  => 'gesperrt',
     },
     { from  => 1062136800, # 2003-08-29 08:00
       until => 1062280800, # 2003-08-31 00:00
       file  => 'kudamm_rad.bbd',
       text  => 'Kurf�rstendamm (s�dl. Richtungsfahrbahn) zwischen Uhlandstra�e und Leibnizstra�e gesperrt. Grund: Radsportveranstaltung Dauer: 30.08.2003 zwischen 08.00 Uhr und 24.00 Uhr Uhr ',
       type  => 'gesperrt',
     },
     { from  => 1061503200, # 2003-08-22 00:00
       until => 1061762400, # 2003-08-25 00:00
       file  => 'muellerstr.bbd',
       text  => 'Stra�enfest in der M�llerstra�e bis 24.8.2003',
       type  => 'gesperrt',
     },
     { from  => 1061517600, # 2003-08-22 04:00
       until => 1061762400, # 2003-08-25 00:00
       file  => 'reichsstr.bbd',
       text  => 'Wegen eines Festes kann die Reichsstra�e am Sonnabend ab 4 Uhr bis Sonntag (24 Uhr) vom Steubenplatz bis zum Theodor-Heuss-Platz nicht passiert werden',
       type  => 'gesperrt',
     },
     { from  => 1062829800, # 2003-09-06 08:30
       until => 1062943200, # 2003-09-07 16:00
       file  => '20030907.bbd',
       text  => 'Rixdorfer Stra�e, Alt-Mariendorf, Mariendorfer Damm, Ullsteinstra�e wegen Rundkurs Sportveranstaltung gesperrt. Dauer: 07.09.2003 zwischen 08.30 Uhr und 16.00 Uhr',
       type  => 'gesperrt',
     },
     { from  => 1062540000, # 2003-09-03 00:00
       until => 1062972000, # 2003-09-08 00:00
       file  => 'globalcity.bbd',
       text  => 'Global City (05.09.03 - 07.09.03): Kurf�rstendamm/Tauentzienstr. von Uhlandstr. bis Passauer Str. gesperrt',
       type  => 'gesperrt',
     },
     { from  => 1062813600, # 2003-09-06 04:00
       until => 1064181600, # 2003-09-22 00:00
       file  => '20030907b.bbd',
       text  => 'F�rstenwalder Damm zwischen B�lschestra�e und Hartlebenstra�e Baustell stadtausw�rts, Stra�e gesperrt, eine Umleitung ist eingerichtet, Dauer: 07.09.2003,04.00 Uhr bis 21.09.2003',
       type  => 'gesperrt',
     },
     { from  => $isodate2epoch->("2013-09-06 11:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-09-08 21:00:00"),
       periodic => 1,
       data  => <<EOF,
userdel	2::temp 10310,-2136 10453,-2133 10509,-2131 10631,-2130 10747,-2129
EOF
       text  => 'Bahnhofstra�e, zwischen Goltzstra�e und Steinstra�e Wein- und Winzerfest, vom 7.9.2013 11:00 bis 8.9.2013 21:00',
       type  => 'gesperrt',
     },
     { from  => 1096596000, # 2004-10-01 04:00
       until => 1096927200, # 2004-10-05 00:00
       file  => 'karlmarx.bbd',
       text  => 'Karl-Marx-Stra�e, zwischen Flughafenstra�e und Uthmannstra�e gesperrt. Grund: Stra�enfest. Dauer: 02.10.2004 04:00 Uhr bis 04.10.2004',
       type  => 'handicap',
     },
     { from  => 1065758400, # 2003-10-10 06:00
       until => 1065996000, # 2003-10-13 00:00
       file  => 'hermannstr.bbd',
       text  => 'Hermannstra�e, zwischen Emserstra�e und Thomasstra�e gesperrt. Grund: Stra�enfest. Dauer: 11.10.2003, 06.00 Uhr bis 12.10.2003, 24.00 Uhr',
       type  => 'handicap',
     },
     { from  => 1135045277, # 2005-12-20 03:21
       until => 1135378800, # 2005-12-24 00:00
       text  => 'Schlichtallee zwischen Hauptstra�e und L�ckstra�e beidseitig wegen Bauarbeiten gesperrt bis 23.12.05 ',
       type  => 'gesperrt',
       source_id => 'LMS_1134638526559',
       data  => <<EOF,
userdel	2 15758,10578 15982,10765 16003,10797 16032,10842
userdel	2 15758,10578 15639,10469
EOF
     },
     undef, # fr�her:
     # { from  => undef, # note: periodisch, siehe unten
     #   until => Time::Local::timelocal(reverse(2006,12-1,9,23,59,59)),
     #   text  => 'Richardplatz Alt-Rixdorfer Weihnachtsmarkt, gesperrt. Dauer: bis 09.12.2006. ',
     #   type  => 'gesperrt',
     #   #file  => 'rixdorfer_weihnachtsmarkt.bbd', # XXX do not use anymore!!!
     #   data => '', # dummy
     # },
     { from  => 1353884400, # 2012-11-26 00:00, # 1290962654, # PERIODISCH! # fr�her: 1102672800, # 2004-12-10 11:00
       until => 1356303599, # 2012-12-23 23:59, # 1293145199, # PERIODISCH! # fr�her: 1102805999, # 2004-12-11 23:59
       text  => 'Spandauer Weihnachtsmarkt, vom 26. November 2012 bis 23. Dezember 2012',
       type  => 'gesperrt',
       source_id => 'http://partner-fuer-spandau.de/Weihnachtsmarkt-2012_479_0.html',
       data  => <<EOF,
userdel	2::temp -3275,14407 -3231,14383 -3204,14368 -3155,14340
userdel	2::temp -3275,14407 -3338,14333
userdel	2::temp -3150,14631 -3185,14556 -3205,14512 -3228,14468 -3275,14407
userdel	2::temp -3275,14407 -3350,14446 -3393,14470 -3410,14479 -3440,14498 -3481,14523
userdel	2::temp -3227,14260 -3155,14340
userdel	2::temp -3227,14260 -3293,14304 -3338,14333
userdel	2::temp -3552,14082 -3457,14189 -3409,14241 -3338,14333
userdel	2::temp -3039,14522 -3054,14498 -3089,14440 -3110,14408 -3142,14358 -3155,14340
userdel	2::temp -3110,14408 -3174,14438 -3228,14468
userdel	2::temp -3231,14383 -3293,14304
EOF
     },
     { from  => 1070600400, # 2003-12-05 06:00 # note: periodisch, siehe unten
       until => 1070838000, # 2003-12-08 00:00
       file  => 'sophienstr.bbd',
       text  => 'Sophienstra�e zwischen Rosenthaler Stra�e und Gro�e Hamburger Stra�e wegen 8. Umwelt - und Weihnachtsmarkt f�r den Fahrzeugverkehr gesperrt (keine Wendem�glichkeit f�r Lkw). Dauer : 6.12.2003 / 06.00 Uhr bis 7.12.2003 / 24.00 Uhr ',
       type  => 'gesperrt',
     },
     { from  => 1079046000, # 2004-03-12 00:00
       until => 1079319600, # 2004-03-15 04:00
       file  => 'sbhf_pankow.bbd',
       text  => 'Berliner Stra�e zwischen Florastra�e und Granitzstra�e in beiden Richtungen gesperrt (H�he S-Bhf. Pankow). Grund: Br�ckenarbeiten. Eine Umleitung ist ausgeschildert. Dauer: 13.03.2004, 00:00 Uhr bis 15.03.2004, 04:00 Uhr',
       type  => 'gesperrt',
     },
     { from  => 1079236800, # 2004-03-14 05:00
       until => 1080514800, # 2004-03-29 01:00
       file  => 'langhansstr.bbd',
       text  => 'Die Langhansstra�e ist zwischen Prenzlauer Promenade und Heinersdorfer Stra�e in beiden Richtungen gesperrt. Grund: Bauma�nahmen. Dauer:15.03.2004, 05:00 Uhr bis 28.03.2004, 17:00 Uhr. Eine Umleitung ist ausgeschildert.',
       type  => 'gesperrt',
     },
     { from  => 1079766000, # 2004-03-20 08:00
       until => 1079888400, # 2004-03-21 18:00
       file  => 'residenz_rad.bbd',
       text  => 'Residenzstra�e zwischen Lindauer Allee und Emmentaler Stra�e, Emmentaler Stra�e zwischen Residenzstra�e und Aroser Allee, Aroser Allee zwischen Emmentaler Stra�e und Lindauer Allee sowie Lindauer Allee zwischen Aroser Allee und Residenzstra�e. Stra�en gesperrt. Radrennen. Umleitung ist ausgeschildert. Dauer: 21.03.2004, 08.00 Uhr bis 18.00 Uhr',
       type  => 'gesperrt',
     },
     { from  => 1117404000, # 2005-05-30 00:00
       until => 1117620000, # 2005-06-01 12:00
       text  => 'Budapester Str. wegen Staatsbesuch gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 6606,11222 6582,11202
userdel	2 6447,11144 6168,11042
userdel	2 6447,11144 6582,11202
EOF
     },
     { from  => 1081476000, # 2004-04-09 04:00
       until => 1081807200, # 2004-04-13 00:00
       file  => 'artists_boulevard.bbd',
       text  => 'Potsdamer Stra�e zwischen Sch�neberger Ufer und Pohlstra�e in beiden Richtungen gesperrt, Veranstaltung (Boulevard des Artistes). Dauer: 10.04.2004, 04:00 Uhr bis 12.04.2004, 24:00 Uhr',
       type  => 'gesperrt',
     },
     { from  => 1082869200, # 2004-04-25 07:00
       until => 1083362400, # 2004-05-01 00:00
       file  => 'lueckstr.bbd',
       text  => 'L�ckstra�e zwischen Giselastra�e und Schlichtallee in Fahrtrichtung Schlichtallee Bauarbeiten, Stra�e gesperrt. Dauer: 26.04.2004, 07:00 Uhr bis voraussichtlich 30.04.2004 ',
       type  => 'handicap',
     },
     { from  => 1188506853, # 2007-08-30 22:47
       until => 1188770400, # 2007-09-03 00:00
       text  => 'Turmstr. (Moabit) in beiden Richtungen zwischen Stromstr. und Beusselstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 02.09.2007 nachts)',
       type  => 'gesperrt',
       source_id => 'IM_006461',
       data  => <<EOF,
userdel	2 6228,13324 6115,13328 6105,13328 6011,13330 5956,13330 5857,13342 5705,13359 5569,13381 5560,13382 5368,13406 5248,13434
EOF
     },
     { from  => $isodate2epoch->("2013-04-30 12:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-05-01 23:59:59"),
       periodic => 1,
       text  => 'MyFest 2013: Oranienstra�e, Mariannenplatz und umliegende Stra�en k�nnen schwer passierbar sein, 1. Mai 2013',
       type  => 'gesperrt',
       data  => <<EOF,
#: by: http://www.myfest36.de/
userdel	2::temp 11763,10635 11722,10533 11949,10414
userdel	2::temp 11556,10869 11770,10774 11760,10732 11781,10696 11763,10635 11505,10744 11556,10869 11589,10947 11640,11067
userdel	2::temp 11958,11045 11897,10887 11841,10747 11824,10708 11781,10696
userdel	2::temp 11805,10899 11803,10857
userdel	2::temp 11275,10723 11301,10783 11329,10785 11365,10791 11403,10782 11505,10744 11463,10642 11722,10533
userdel	2::temp 11841,10747 11770,10774 11799,10848
userdel	2::temp 11463,10642 11275,10723 11234,10739 11159,10769
userdel auto	3 11258,10682 11275,10723 11253,10778
userdel auto	3 11253,10778 11275,10723 11258,10682
EOF
     },
     { from  => 1083232800, # 2004-04-29 12:00
       until => 1083448800, # 2004-05-02 00:00
       file  => 'reinhardtstr.bbd',
       text  => 'Reinhardtstra�e zwischen Friedrichstra�e und Albrechtstra�e in beiden Richtungen gesperrt, Veranstaltung. Dauer: 30.04.2004, 12:00 Uhr bis 01.05.2004, 24:00 Uhr',
       type  => 'gesperrt',
     },
     { from  => 1083294000, # 2004-04-30 05:00
       until => 1083448800, # 2004-05-02 00:00
       file  => 'spandauer.bbd',
       text  => 'Spandauer Stra�e, zwischen Karl-Liebknecht-Stra�e und M�hlendamm, in beiden Richtungen Stra�e gesperrt. Veranstaltung. Dauer: 01.05.2004, 05.00 Uhr bis 24.00 Uhr',
       type  => 'gesperrt',
     },
     { from  => 1112241600, # 2005-03-31 06:00
       until => 1112562000, # 2005-04-03 23:00
       text  => 'M�llerstra�e, Zwischen Kreuzung Seestra�e und Kreuzung Leopoldplatz in beiden Richtungen Veranstaltung, Stra�e gesperrt, Dauer: 01.04.2005 06:00 Uhr bis 03.04.2005 23:00 Uhr (M�llerstra�enfest) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 7043,15793 7129,15717 7198,15656
userdel	2 7043,15793 6936,15888 6914,15908
userdel	2 7198,15656 7277,15586
userdel	2 6781,16026 6914,15908
EOF
     },
     { from  => 1083491594, # 2004-05-02 11:53
       until => 1083967200, # 2004-05-08 00:00
       file  => 'lueckstr.bbd',
       text  => 'L�ckstra�e Berlin-Friedrichsfelde Richtung Berlin-Friedrichshain; zwischen Rummelsburger Stra�e und Schlichtallee wegen Bauarbeiten gesperrt bis 7.05.2004. ',
       type  => 'handicap',
     },
     { from  => 1083708000, # 2004-05-05 00:00
       until => Time::Local::timelocal(reverse(2004-1900,5-1,19,23,59,59)),
       file  => 'karstaedt.bbd',
       text  => 'B 5; OD Karst�dt, Bahn�bergang; Gleisbauarbeiten; Vollsperrung; 06.05.2004-24.05.2004 ',
       type  => 'handicap',
     },
     { from  => 1083880800, # 2004-05-07 00:00
       until => 1084140000, # 2004-05-10 00:00
       file  => 'boelschefest.bbd',
       text  => 'B�lschestr. (K�penick) in beiden Richtungen, zwischen F�rstenwalder Damm und M�ggelseedamm Veranstaltung, Stra�enfest (bis 09.05. 24 Uhr) 14. B�lschefest (11:39) ',
       type  => 'gesperrt',
     },
     { from  => 1083880800, # 2004-05-07 00:00
       until => 1084125600, # 2004-05-09 20:00
       file  => 'florastr.bbd',
       text  => 'Florastr. (Pankow) in beiden Richtungen zwischen Florapromenade und Heystr. Stra�enfest, Stra�e vollst�ndig gesperrt (bis 09.05.2004 20:00 Uhr) (16:47) ',
       type  => 'gesperrt',
     },
     { from  => 1084464000, # 2004-05-13 18:00
       until => 1084658400, # 2004-05-16 00:00
       file  => '20040514.bbd',
       text  => 'Ebertstra�e, zwischen Behrenstra�e und Dorotheenstra�e, Stra�e des 17.Juni, zwischen Gro�en Stern und Entlastungsstra�e sowie zwischen Entlastungsstra�e und Platz des 18. M�rz Veranstaltung. Stra�en gesperrt. Dauer: 14.05.2004, 18.00 Uhr bis 15.04.2004, 24.00 Uhr ',
       type  => 'gesperrt',
     },
     { from  => 1116554400, # 2005-05-20 04:00
       until => 1116885600, # 2005-05-24 00:00
       text  => 'Hermannstra�e, Stra�enfest zwischen Flughafenstra�e und Thomasstra�e, Dauer: 21.05.2005 04:00 Uhr bis 23.05.2005',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 7043,15793 7129,15717 7198,15656
userdel	2 7043,15793 6936,15888 6914,15908
userdel	2 7198,15656 7277,15586
userdel	2 6781,16026 6914,15908
EOF
     },
     { from  => 1147522145, # 2006-05-13 14:09
       until => 1147651200, # 2006-05-15 02:00
       text  => 'Reichsstra�e (Charlottenburg) in beiden Richtungen zwischen Theodor-Heuss-Platz und Steubenplatz Veranstaltung, Stra�e vollst�ndig gesperrt (bis 15.05.2006 02:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_002775',
       file  => 'reichsstr.bbd',
     },
     { from  => 1084485600, # 2004-05-14 00:00
       until => 1084741200, # 2004-05-16 23:00
       file  => 'siegfriedstr.bbd',
       text  => 'Siegfriedstr. (Lichtenberg) in beiden Richtungen, zwischen Landsberger Allee und Herzbergstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 16.05. 23 Uhr) Siegfriedstra�enfest',
       type  => 'gesperrt',
     },
     { from  => 1085090400, # 2004-05-21 00:00
       until => 1085436000, # 2004-05-25 00:00
       file  => 'pillgram.bbd',
       text  => 'K 6733; Bahn�bergang zw. Pillgram u. Jacobsdorf Gleisbauarbeiten Vollsperrung 22.05.2004-24.05.2004 ',
       type  => 'gesperrt',
     },
     { from  => 1085123951, # 2004-05-21 09:19
       until => 1085335200, # 2004-05-23 20:00
       file  => 'hauptstr_pankow.bbd',
       text  => 'Hauptstr. (Pankow) in beiden Richtungen zwischen Gravensteinstr. und Blankenfelder Str. Veranstaltung, Verkehrsbehinderung erwartet (bis 23.05.2004 20:00 Uhr)',
       type  => 'handicap',
     },
     { from  => 1085205600, # 2004-05-22 08:00
       until => 1085349600, # 2004-05-24 00:00
       file  => 'dorotheenstr.bbd',
       text  => 'Dorotheenstra�e zwischen Eberetstra�e und Wilhelmstra�e sowie Ebertstra�e zwischen Stra�e des 17.Juni und Dorotheenstra�e Veranstaltung, gesperrt, Dauer: 23.05.2004, 08.00 Uhr bis 24.00 Uhr.',
       type  => 'gesperrt',
     },
     { from  => 1085124135, # 2004-05-21 09:22
       until => 1085342400, # 2004-05-23 22:00
       file  => 'marzahner_promenade.bbd',
       text  => 'Marzahner Promenade (Marzahn) in beiden Richtungen im Bereich des Freizeitforums Marzahn Veranstaltung, Stra�e vollst�ndig gesperrt (bis 23.05.2004 22:00 Uhr) "Marzahner Fr�hling"',
       type  => 'handicap',
     },
     { from  => 1085124182, # 2004-05-21 09:23
       until => 1085428800, # 2004-05-24 22:00
       file  => 'scheidemannstr.bbd',
       text  => 'Scheidemannstr., Ebertstr. (Mitte) in beiden Richtungen im Bereich des Reichstagsgeb�udes Veranstaltung, Stra�e vollst�ndig gesperrt (bis 24.05.2004 22:00 Uhr)',
       type  => 'gesperrt',
     },
     { from  => 1085133600, # 2004-05-21 12:00
       until => 1085248800, # 2004-05-22 20:00
       file  => 'radrennen_hindenburgdamm.bbd',
       text  => 'Auguststra�e zwischen Hindenburgdamm und Augustplatz Manteuffelstra�e zwischen Augustplatz und Hindenburgdamm Hindenburgdamm (westliche Fahrbahn) zwischen Manteuffelstra�e und Auguststra�e Radrennen, Stra�e gesperrt, Dauer: 22.05.2004, 12.00 Uhr bis 20.00 Uhr. ',
       type  => 'gesperrt',
     },
     { from  => Time::Local::timelocal(reverse(2007-1900,6-1,9,0,0,0)),
       until => Time::Local::timelocal(reverse(2007-1900,6-1,11,0,0,0)),
       file  => 'karlmarx.bbd',
       text  => 'Karl-Marx-Stra�e zwischen Flughafenstra�e und Uthmannstra�e sowie Erkstra�e zwischen Donaustra�e und Karl-Marx-Stra�e: Stra�enfest, Stra�en gesperrt, bis zum 10.6.2006 ',
       type  => 'gesperrt',
     },
     { from  => 1086041261, # 2004-06-01 00:07
       until => Time::Local::timelocal(reverse(2004-1900,6-1,16,23,59,59)),
       file  => 'liesenstr.bbd',
       text  => 'Liesenstr. (Mitte) Richtung S�den zwischen Gartenstr. und Chausseestr. Baustelle, Fahrtrichtung gesperrt (bis 11.06.2004)',
       type  => 'handicap',
     },
     { from  => 1119520800, # 2005-06-23 12:00
       until => 1119736799, # 2005-06-25 23:59
       text  => 'Oberbaumbr�ckenfest, Dauer: 25.06.2005 12:00 Uhr bis 24:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 13305,10789 13332,10832
userdel	2 13305,10789 13206,10651
userdel	2 13077,10747 13206,10651
userdel	2 13082,10634 13178,10623
userdel	2 13178,10623 13206,10651
EOF
     },
     { from  => Time::Local::timelocal(reverse(2008-1900,6-1,27,7,0,0)), #
       until => Time::Local::timelocal(reverse(2008-1900,6-1,30,0,0,0)), #
       text  => 'Bergmannstra�enfest, Bergmannstr. zwischen Mehringdamm und Zossener Str. gesperrt, 27.06.2007, 7.00 Uhr bis 29.06.2007, 24.00 Uhr ',
       type  => 'gesperrt',
       file  => 'bergmannstr.bbd',
     },
     { from  => 1087975800, # 2004-06-23 09:30
       until => 1088287200, # 2004-06-27 00:00
       file  => 'csd.bbd',
       text  => 'CSD am 26.06.2004 von 9.30 Uhr bis 24.00 Uhr',
       type  => 'gesperrt',
     },
     { from  => 1088892000, # 2004-07-04 00:00
       until => 1093903200, # 2004-08-31 00:00
       file  => 'herzfelde.bbd',
       text  => 'B 1; (Hauptstr.); OD Herzfelde Kanal- und Stra�enbau Vollsperrung 05.07.2004-30.08.2004 ',
       type  => 'handicap',
     },
     { from  => 1086865200, # 2004-06-10 13:00
       until => 1086998400, # 2004-06-12 02:00
       file  => 'sowj_ehrenmal.bbd',
       text  => 'Die Stra�e des 17.Juni zwischen Entlastungsstra�e und Ebertstra�e (Start- und Zielbereich) ist von 11.06.2004,13:00 Uhr bis 12.06.2004, ca. 02:00 Uhr gesperrt (Sportveranstaltung).',
       type  => 'handicap',
     },
     { from  => 1087545600, # 2004-06-18 10:00
       until => 1087689600, # 2004-06-20 02:00
       file  => 'altwittenau.bbd',
       text  => 'Alt-Wittenau zwischen Eichborndamm und Triftstra�e B�rgerfest, Stra�e gesperrt, Dauer: 19.06.2004, 10.00 Uhr bis 20.06.2004, 02.00 Uhr.',
       type  => 'handicap',
     },
     { from  => 1088114400, # 2004-06-25 00:00
       until => 1088352000, # 2004-06-27 18:00
       file  => 'wiesenfest.bbd',
       text  => 'Finsterwalder Stra�e zwischen Engelroder Weg und Calauer Stra�e Wiesenfest, Verkehrsbehinderung erwartet, Dauer: 26.06.2004, 10.00 UHr bis 27.06.2004, 18.00 Uhr.',
       type  => 'handicap',
     },
     { from  => 1087459757, # 2004-06-17 10:09
       until => 1089237600, # 2004-07-08 00:00
       file  => 'gleimstr.bbd',
       text  => 'Gleimstra�e zwischen Sch�nhauser Allee und Ystarder Stra�e in beiden Richtungen gesperrt, Bauarbeiten. Dauer: bis voraussichtlich 07.07.2004',
       type  => 'handicap',
     },
     { from  => 1276833600, # 2010-06-18 06:00
       until => 1277071140, # 2010-06-20 23:59
       text  => 'Badstra�e (Wedding): Veranstaltung, gesperrt (bis 21.06.10, 0 Uhr) in beiden Richtungen zwischen Pankstra�e und Behmstra�e, 19.06.2010 06:00 Uhr bis 20.06.2010 23:59 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_015896',
       file  => 'badstr.bbd',
     },
     { from  => $isodate2epoch->("2013-06-14 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-06-16 23:59:59"),
       periodic => 1,
       text  => 'Bereich Nollendorfplatz Veranstaltung (Lesbisch-schwules Stadtfest), m�glicherweise gesperrte Stra�en: Motzstra�e/Eisenacher Stra�e/Fuggerstra�e/Kalckreuthstra�e/Nollendorfplatz (15.6.2013 bis 16.6.2013',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 6514,10088 6609,10147 6626,10155 6729,10212
userdel	2::temp 6729,10212 6971,10346
userdel	2::temp 6628,10318 6626,10155
userdel	2::temp 6502,10273 6628,10318 6719,10347
userdel	2::temp 6719,10347 6729,10212 6739,10120
EOF
     },
     { from  => 1088807415, # 2004-07-03 00:30
       until => 1089147600, # 2004-07-06 23:00
       file  => 'gendarmenmarkt.bbd',
       text  => 'Gendarmenmarkt (Mitte) in allen Richtungen im Bereich Mohrenstr. Veranstaltung, Verkehrsbehinderung erwartet (bis 06.07.2004 23:00 Uhr) Classic Open Air am Gendarmenmarkt',
       type  => 'gesperrt',
     },
     { from  => 1088719200, # 2004-07-02 00:00
       until => 1089453600, # 2004-07-10 12:00
       file  => 'koenigsheideweg.bbd',
       text  => 'K�nigsheideweg (Treptow) Richtung Baumschulenstr. nach Sterndamm Baustelle, Fahrtrichtung gesperrt (bis Mitte 07.2004)',
       type  => 'handicap',
     },
     { from  => 1121462650, # 2005-07-15 23:24
       until => 1121637600, # 2005-07-18 00:00
       text  => 'M�llerstr. (Wedding) in beiden Richtungen zwischen Londoner Str. und Transvaalstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 17.07.2005 24 Uhr)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 6019,16712 5937,16784 5900,16817 5777,16924
userdel	2 6019,16712 6038,16694 6103,16635
userdel	2 6103,16635 6208,16546 6311,16457
EOF
     },
     { from  => 1090533600, # 2004-07-23 00:00
       until => 1091224800, # 2004-07-31 00:00
       file  => 'goerlsdorf.bbd',
       text  => 'L 239; (B198 n�.Angerm�nde-Joachimsthal); Bahn�bergang G�rlsdorf Gleis- u. Stra�enbau Vollsperrung 24.07.2004-30.07.2004 ',
       type  => 'gesperrt',
     },
     { from  => 1090913211, # 2004-07-27 09:26
       until => 1093736367, # bis Ende 08.2004
       file  => 'rathenower.bbd',
       text  => 'Berlin-Moabit, Kreuzung Rathenower Stra�e / Stephanstra�e, Baustelle, Kreuzung vollst�ndig gesperrt, Dauer: voraussichtlich bis Ende 08.2004',
       type  => 'handicap',
     },
     { from  => 1091055057, # 2004-07-29 00:50
       until => 1095112740, # 2004-09-13 23:59 removed
       file  => 'dietzgenstr.bbd',
       text  => 'Dietzgenstr. (Pankow) Richtung stadteinw�rts zwischen Schillerstr. und Uhlandstr. Baustelle, Richtungsfahrbahn komplett gesperrt (bis 13.09.2004) ',
       type  => 'gesperrt',
     },
     { from  => 1092240000, # 2004-08-11 18:00
       until => 1092600000, # 2004-08-15 22:00
       file  => 'kudamm_tauentzien.bbd',
       text  => 'Zwischen Kreuzung N�rnberger Stra�e und Kreuzung Joachimstaler Stra�e in beiden Richtungen Veranstaltung (Global-City), gesperrt, Dauer: 12.08.2004 18:00 Uhr bis 15.08.2004 22:00 Uhr ',
       type  => 'gesperrt',
     },
     { from  => undef,
       until => 1092439940,
       text  => 'Hellersdorfer Stra�e (Hellersdorf) in beiden Richtungen zwischen G�lzower Stra�e und Heinrich-Gr�ber-Stra�e Stra�e vollst�ndig gesperrt aufgrund eines Wasserrohrbruches.',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 22998,12453 22990,12493 22980,12545 22967,12647
userdel	2 22998,12453 23033,12367 23100,12269
EOF
     },
     { from  => undef,
       until => 1092439940,
       data => <<EOF,
userdel	2 9457,18612 9366,18669 9279,18724
userdel	2 9565,18555 9821,18392 9881,18354
EOF
       text  => 'Heinrich-Mann-Stra�e Berlin-Reinickendorf Richtung Berlin-Pankow Zwischen Heinrich-Mann-Stra�e und Grabbeallee St�rungen durch geplatzte Wasserleitung, Stra�e gesperrt',
       type  => 'gesperrt',
     },
     { from  => 1092520800, # 2004-08-15 00:00
       until => 1093298400, # 2004-08-24 00:00
       text  => 'OD Pritzwalk, zw. F.-Reuter-Str. und A.-Bartels-Weg; Br�ckenbauarbeiten; Vollsperrung: 16.08.2004-23.08.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -74489,80545 -74038,78181
EOF
     },
     { from  => undef, # 
       until => 1096151876, # removed (seen 2004-09-25)
       text  => 'Flottwellstr. (Tiergarten) in beiden Richtungen zwischen L�tzowstra�e und Am Karlsbad Verkehrsbehinderung durch Absenkung der Fahrbahn, Stra�e vollst�ndig gesperrt',
       type  => 'handicap',
      data  => <<EOF,
userdel	q4 8199,10634 8281,10791
EOF
     },
     { from  => 1092520800, # 2004-08-15 00:00
       until => 1094940000, # 2004-09-12 00:00
       text  => 'B 96A; (Sch�nflie�er Str.); OL Schildow; grundh. Stra�enbau Vollsperrung; 16.08.2004-11.09.2004 ',
       type  => 'handicap',
      data  => <<EOF,
userdel	q4 8187,25897 8182,25608
EOF
     },
     { from  => 1092520800, # 2004-08-15 00:00
       until => 1093644000, # 2004-08-28 00:00
       text  => 'L 222; (Gransee-Gro�woltersdorf); zw. Gransee und Abzw. Neul�gow Deckenerneuerung; Vollsperrung; 16.08.2004-27.08.2004 ',
       type  => 'gesperrt',
      data  => <<EOF,
userdel	2 -8697,68965 -8826,68471
EOF
     },
     { from  => 1095285600, # 2004-09-16 00:00
       until => 1095717600, # 2004-09-21 00:00
       text  => 'L 88; (Beelitz-Lehnin); Bahn�bergang zw. Beelitz u. AS Beelitz-Heilst�tten Einbau Hilfsbr�cke Vollsperrung 17.09.2004-20.09.2004 ',
       type  => 'gesperrt',
      data  => <<EOF,
userdel	2 -21587,-16648 -21341,-17172
EOF
     },
     { from  => 1095717600, # 2004-09-21 00:00
       until => 1096149600, # 2004-09-26 00:00
       text  => 'L 88; (Beelitz-Lehnin); Bahn�bergang zw. Beelitz u. AS Beelitz-Heilst�tten Einbau Hilfsbr�cke Vollsperrung 22.09.2004-25.09.2004 ',
       type  => 'gesperrt',
      data  => <<EOF,
userdel	2 -21587,-16648 -21341,-17172
EOF
     },
     { from  => 1092866435, # 2004-08-19 00:00
       until => 1093989600, # 2004-09-01 00:00
       text  => 'B96A Berlin-Pankow, Sch�nholzer Stra�e - M�hlenstra�e, Oranienburg Richtung Berlin-Mitte, Zwischen Kreuzung Grabbeallee und Kreuzung Breite Stra�e Baustelle, gro�er Zeitverlust, lange Staus bis 31.08.2004 , eine Umleitung ist eingerichtet (Sperrung nur zwischen Wollankstra�e und Kreuzstra�e)',
       type  => 'handicap',
      data  => <<EOF,
userdel	q4 9909,18333 10054,18210 10089,18180
EOF
     },
     { from  => 1093125600, # 2004-08-22 00:00
       until => 1093125600, # 2004-08-28 00:00 removed
       text  => 'L 792; (Gro� Schulzendorf-Blankenfelde); OD Blankenfelde, Dorfstr. Stra�enbauarbeiten Vollsperrung 23.08.2004-27.08.2004 ',
       type  => 'handicap',
      data  => <<EOF,
userdel	q4 9990,-8867 10115,-8276
EOF
     },
     { from  => 1099177200, # 2004-10-31 01:00
       until => 1099522800, # 2004-11-04 00:00
       text  => 'L 142; (Kyritzer Stra�e); Klempnitzbr�cke in Wusterhausen Br�ckensanierung Vollsperrung 01.11.2004-03.11.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -54776,53333 -55124,53446
EOF
     },
     { from  => 1093384800, # 2004-08-25 00:00
       until => 1097272800, # 2004-10-09 00:00
       text  => 'L 30; (Tasdorfer Str.); OL Vogelsdorf, zw. Heinestr. u. Seestr. Kanalarbeiten Vollsperrung 26.08.2004-08.10.2004 ',
       type  => 'handicap',
      data  => <<EOF,
userdel	q4 35338,12538 35676,11706
EOF
     },
     { from  => 1093297474, # 2004-08-23 23:44
       until => 1093816800, # 2004-08-30 00:00
       text  => 'L 73; (B246-Fresdorf-Wildenbruch-B2); OD Wildenbruch, zw. Potsdamer Str. u. Dorfstr.; Stra�enbauarbeiten; Vollsperrung; 23.08.2004-29.08.2004',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -12283,-13901 -12154,-13801
EOF
     },
     { from  => undef, # 
       until => 1093376850, # 2004-08-26 12:00 fr�her
       text  => 'Bachstra�e: In beiden Richtungen St�rungen durch Rohrbruch, gesperrt bis Do 12:00 ',
       type  => 'handicap',
      data  => <<EOF,
userdel	q4 6020,12492 5951,12353 5938,12281 5874,12165 5807,12070 5790,12026
userdel	q4 5758,11895 5775,11975 5790,12026
EOF
     },
     { from  => 1093125600, # 2004-08-22 00:00
       until => 1097618400, # 2004-10-13 00:00
       text  => 'L 435; (Grunow-M�llrose); OD Mixdorf, Hauptstr. grundhafter Ausbau Vollsperrung 23.08.2004-12.10.2004 ',
       type  => 'handicap',
      data  => <<EOF,
userdel	q4 79281,-22168 79255,-22467
EOF
     },
     { from  => 1093730400, # 2004-08-29 00:00
       until => 1094248800, # 2004-09-04 00:00
       text  => 'L 792; (Gro� Schulzendorf-Blankenfelde); OD Blankenfelde, Dorfstr. Stra�enbauarbeiten Vollsperrung 30.08.2004-03.09.2004 ',
       type  => 'handicap',
      data  => <<EOF,
userdel	q4 9990,-8867 10115,-8276
EOF
     },
     { from  => 1121292000, # 2005-07-14 00:00
       until => 1121637600, # 2005-07-18 00:00
       text  => 'B 103; (Havelberger Str.); OD Pritzwalk, Bahn�bergang Gleissanierung Vollsperrung 15.07.2005-17.07.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -74489,80545 -74653,81289
EOF
     },
     { from  => 1093471200, # 2004-08-26 00:00
       until => 1093903200, # 2004-08-31 00:00
       text  => 'OL Finsterwalde S�ngerfest Vollsperrung 27.08.2004-30.08.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 33240,-85187 33354,-85304
userdel	q4 33240,-85187 33060,-85292
userdel	q4 33481,-85428 33354,-85304
userdel	q4 33481,-85428 33488,-85803
userdel	q4 33103,-85728 33060,-85292
EOF
     },
     { from  => 1096840800, # 2004-10-04 00:00
       until => 1099520857, # siehe unten
       text  => 'B 167; zw. Bad Freienw. u. Falkenberg, H�he Papierfabrik Neubau von Durchl�ssen Vollsperrung 04.10.2004-unbekannt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 49039,44131 48924,44216 48724,44248 48523,44467
EOF
     },
     { from  => 1093496400, # 2004-08-26 07:00
       until => 1093716000, # 2004-08-28 20:00
       text  => 'Die Naumannstra�e ist zwischen Torgauer Stra�e und Tempelhofer Weg von 27.08.04, 07.00 Uhr bis 28.08.04, 20.00 Uhr gesperrt. Grund Bauarbeiten.',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 7733,8023 7713,8001 7717,7879 7717,7830 7696,7771
EOF
     },
     { from  => 1093730400, # 2004-08-29 00:00
       until => 1095397200, # 2004-09-17 07:00
       text  => 'Die Mohrenstra�e ist von der Charlottenstra�e in Richtung Friedrichstra�e wegen Kranarbeiten vom 30.08.2004 bis 17.09.2004 montags bis freitags jeweils in der Zeit von 07:00 Uhr bis 17:00 Uhr als Einbahnstra�e ausgewiesen.',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 9418,11804 9547,11819
EOF
     },
     { from  => 1093816800, # 2004-08-30 00:00
       until => 1098914400, # 2004-10-28 00:00
       text  => 'Oberwallstra�e, Baustelle, Stra�e gesperrt zwischen J�gerstra�e und Hausvogteiplatz, Dauer: 31.08.2004 bis 27.10.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9925,11947 9913,12068
EOF
     },
     { from  => 1093924800, # 2004-08-31 06:00
       until => 1098482400, # 2004-10-23 00:00
       text  => 'Gartenstra�e zwischen Invalidenstra�e und Bernauer Stra�e gesperrt, Baustelle, Einbahnstra�e in s�dlicher Richtung wird eingerichtet, zudem wird die Ackerstra�e zwischen Invalidenstra�e und Bernauer Stra�e gesperrt. Dauer: 01.09.2004, 06.00 Uhr bis 22.10.2004',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 9383,13978 9224,14169
userdel	1 9400,14400 9439,14368 9627,14229 9750,14132 9810,14066
EOF
     },
     { from  => 1093928400, # 2004-08-31 07:00
       until => 1094234400, # 2004-09-03 20:00
       text  => 'Dauer: 01.09.2004 07:00 Uhr bis 03.09.2004 20:00 Uhr. Rudower Chaussee, gesperrt von Agastra�e bis Gro�berliner Damm in Richtung Treptow',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 19732,3340 19603,3207 19581,3184 19501,3101
EOF
     },
     { from  => 1094083200, # 2004-09-02 02:00
       until => 1094428800, # 2004-09-06 02:00
       text  => 'Turmstra�e zwischen Kreuzung Beusselstra�e und Kreuzung Stromstra�e sowie Thusneldaallee: Stra�e gesperrt (Turmstra�enfest), Dauer: 03.09.2004 02:00 Uhr bis 06.09.2004 02:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 5248,13434 5368,13406 5560,13382 5569,13381 5705,13359 5857,13342 5956,13330 6011,13330 6105,13328 6115,13328 6228,13324
userdel	2 5975,13256 5956,13330
EOF
     },
     { from  => 1094097600, # 2004-09-02 06:00
       until => 1094248799, # 2004-09-03 23:59
       text  => 'Erkstra�e zwischen Kreuzung Karl-Marx-Stra�e und Kreuzung Sonnenallee Stra�e gesperrt (Spielfest), Dauer: 03.09.2004 06:00 Uhr bis 23:00 Uhr',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 12598,8390 12771,8439
userdel	2 12771,8439 12902,8470 12925,8494
EOF
     },
     { from  => undef, # 
       until => 1094407200, # 5.9.2004 20:00
       text  => 'Leibnizstra�e (Charlottenburg) zwischen Bismarckstr. und Otto-Suhr-Allee in Richtung Kantstr. Baustelle, Fahrtrichtung gesperrt bis 5.9.2004, 20:00 Uhr',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 4359,11979 4345,11710
EOF
     },
     { from  => 1094508000, # 2004-09-07 00:00
       until => 1094853600, # 2004-09-11 00:00
       text  => 'L 771; (Gr�ben-Saarmund); Autobahnbr�cke s�dl. Saarmund Br�ckenabriss u. -neubau Vollsperrung 08.09.2004-10.09.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -8879,-12309 -8433,-11290
EOF
     },
     { from  => 1094176800, # 2004-09-03 04:00
       until => 1094418000, # 2004-09-05 23:00
       text  => 'Hermannstra�enfest zwischen Flughafenstra�e und Thomasstra�e, Stra�e gesperrt, Dauer: 04.09.2004 04:00 Uhr bis 05.09.2004 23:00 Uhr',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 12180,7387 12158,7449 12122,7553
userdel	2 11920,8252 11931,8206 11933,8198
userdel	2 11920,8252 11898,8362
userdel	2 12041,7788 12055,7751 12075,7696
userdel	2 11979,8014 11963,8074
userdel	2 11979,8014 12001,7937 12025,7852
userdel	2 11933,8198 11963,8074
userdel	2 12075,7696 12081,7679 12090,7651 12122,7553
EOF
     },
     { from  => 1094187600, # 2004-09-03 07:00
       until => 1094407200, # 2004-09-05 20:00
       text  => 'Platz des 4. Juli zwischen Goerzallee und Osteweg gesperrt, Sportveranstaltung. Dauer: 04.09.2004 und 05.09.2004 jeweils von 07:00 Uhr bis 20:00 Uhr',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 2632,1706 2843,1281
EOF
     },
     { from  => 1314914400, # undef, # zweiter Termin im Jahr
       until => 1315173600, # 1094421599, # 2004-09-05 23:59
       text  => 'Alt-Rudow in beiden Richtungen, zwischen Krokusstr. und Neudecker Weg Veranstaltung, Stra�e vollst�ndig gesperrt (3. und 4. Septermber 2011), Rudower Septermbermeile',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 16610,1715 16805,1488 16849,1437
userdel	2 16975,1262 16849,1437
EOF
     },
     { from  => undef, # 
       until => 1097791200, # 2004-10-15 00:00
       text  => 'L�ckstr. Richtung stadteinw�rts zwischen Schlichtallee und W�nnichstr. Baustelle, Stra�e gesperrt (bis Mitte 10.2004) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 16699,10611 16647,10632 16601,10650 16588,10655 16468,10695 16313,10747 16300,10753 16153,10818 16085,10844 16032,10842
EOF
     },
     { from  => 1094627730, # 2004-09-08 09:15
       until => 1096668000, # 2004-10-02 00:00
       text  => 'Gleim-Tunnel: Baustelle, Stra�e vollst�ndig gesperrt (bis 01.10.2004)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9917,15613 9992,15625 10122,15647
EOF
     },
     { from  => 1094421600, # 2004-09-06 00:00
       until => 1103151600, # 2004-12-16 00:00
       text  => 'K 7318; (Pinnow-L 24-Ha�leben); OD Buchholz Kanal- und Stra�enbau Vollsperrung 07.09.2004-15.12.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 32377,89414 32246,89341 32001,89339
EOF
     },
     { from  => 1094940000, # 2004-09-12 00:00
       until => 1099781940, # 200411062359
       text  => 'L 961; (Rog�sen-LG Genthin); zw. Zitz und LG Karow Stra�enbauarbeiten Vollsperrung 13.09.2004-06.11.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -62793,-10268 -63668,-10212
userdel	2 -63668,-10212 -64600,-9931
EOF
     },
     { from  => 1094800133, # 2004-09-10 09:08
       until => 1095026400, # 2004-09-13 00:00
       text  => 'Stra�e des 17. Juni - Ebertstr. (Mitte) in beiden Richtungen zwischen Platz des 18. M�rz und Entlastungsstr. sowie zwischen Behrenstr. und Dorotheenstr. Veranstaltung, Stra�e gesperrt (bis 12.09.2004) Jesustag 2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8214,12205 8089,12190 8055,12186
userdel	2 8214,12205 8303,12216 8538,12245
userdel	2 8546,12279 8570,12302 8573,12325
userdel	2 8546,12279 8538,12245
userdel	2 8595,12066 8600,12165
userdel	2 8540,12420 8573,12325
userdel	2 8538,12245 8600,12165
EOF
     },
     { from  => 1094940000, # 2004-09-12 00:00
       until => 1097097435, # 2004-10-09 00:00, vorzeitig aufgehoben
       text  => 'B 102; zw. Krz. Kampehl und B�ckwitz Stra�enbauarbeiten Vollsperrung 13.09.2004-08.10.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -53139,50022 -54295,49682
EOF
     },
     { from  => 1095544800, # 2004-09-19 00:00
       until => 1104620400, # 2005-01-02 00:00
       text  => 'B 96a; (Bahnhofstr., Hauptstr.); OD Schildow Kanal- und Stra�enbau Vollsperrung 20.09.2004-01.01.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 8488,25390 8370,25539
userdel	q4 8370,25539 8182,25608
EOF
     },
     { from  => 1105830000, # 2005-01-16 00:00
       until => 1116363037, # aufgehoben 2005-05-28 00:00
       text  => 'K 6413; (Wriezener Stra�e); OL Buckow, zw. Weinbergsweg u. Ringstr. Kanal- u. Stra�enbau Vollsperrung 17.01.2005-27.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 55621,19338 55511,19881
EOF
     },
     { from  => 1096322400, # 2004-09-28 00:00
       until => 1097100000, # 2004-10-07 00:00
       text  => 'K 6422; (Petershagener Str.); OL Fredersdorf, Nr. 5 u. 6; SW-Hausanschlu�; Vollsperrung; 29.09.2004-06.10.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 34139,13113 34896,13562
EOF
     },
     { from  => 1095717600, # 2004-09-21 00:00
       until => 1101855600, # 2004-12-01 00:00
       text  => 'L 17; (K�nigshorst-Warsow); zw. Jahnberge und Warsow Stra�enbauarbeiten Vollsperrung 22.09.2004-30.11.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -40025,34118 -41261,33257
userdel	2 -40025,34118 -39143,34187
userdel	2 -38293,34081 -39143,34187
EOF
     },
     { from  => 1095890400, # 2004-09-23 00:00
       until => 1117576800, # 2005-06-01 00:00
       text  => 'L 40; (Gro�beeren-G�terfelde); zw. Gro�beeren u. Neubeeren Neubau Bauwerk Vollsperrung 24.09.2004-31.05.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 2423,-6303 2715,-6365
EOF
     },
     { from  => 1096754400, # 2004-10-03 00:00
       until => 1103929200, # 2004-12-25 00:00
       text  => 'K 6907; (B 2-AS Ferch); OD Neuseddin Stra�enbauarbeiten Vollsperrung 04.10.2004-24.12.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -18153,-12489 -17341,-13386
EOF
     },
     { from  => 1096754400, # 2004-10-03 00:00
       until => 1097704800, # 2004-10-14 00:00
       text  => 'L 90; (Potsdamer Str.); OD Werder, zw. A.-K�rger Str. u. Gr�ner Weg Schachtsanierung Vollsperrung 04.10.2004-13.10.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -21137,-4034 -21003,-4494
userdel	q4 -21003,-4494 -20851,-4878
EOF
     },
     { from  => 1113170400, # 2005-04-11 00:00
       until => 1119650400, # 2005-06-25 00:00
       text  => 'B 167; zw. Bad Freienw. u. Falkenberg, H�he Papierfabrik Neubau von Durchl�ssen Vollsperrung 12.04.2005-24.06.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 49039,44131 48924,44216 48724,44248 48523,44467
userdel	q4 49039,44131 49691,43812
EOF
     },
     { from  => 1096578452, # 2004-09-30 23:07
       until => 1096862400, # 2004-10-04 06:00
       text  => 'Str. des 17. Juni / Ebertstr. (Tiergarten) in beiden Richtungen zwischen Entlastungsstr. und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (Vorbereitung Tag der Deutschen Einheit) (bis 04.10.2004, 6 Uhr) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8055,12186 8089,12190 8214,12205
userdel	2 8214,12205 8303,12216 8538,12245
userdel	2 8546,12279 8538,12245
userdel	2 8600,12165 8538,12245
userdel	2 8538,12245 8610,12254
userdel	2 8546,12279 8570,12302 8573,12325 8540,12420 
EOF
     },
     { from  => 1096754400, # 2004-10-03 00:00
       until => 1112306400, # 2005-04-01 00:00
       text  => 'K 6904; (Gr�ben-Nudow); OD Fahlhorst, Dorfstr. Stra�enbauarbeiten Vollsperrung 04.10.2004-31.03.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -5452,-11456 -5709,-10987
EOF
     },
     { from  => 1096754400, # 2004-10-03 00:00
       until => 1100905200, # 2004-11-20 00:00
       text  => 'L 743; (Motzener Str.); OL Bestensee, zw. Eichhornstr. u. Fasanenstr. SW-Leitung Vollsperrung 04.10.2004-19.11.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 26650,-18150 26376,-18707 26356,-18748
EOF
     },
     { from  => 1096754400, # 2004-10-03 00:00
       until => 1097877600, # 2004-10-16 00:00
       text  => 'L 78; (Potsdamer Str.); OD Saarmund, Eisenbahnbr�cke Br�ckensanierung Vollsperrung 04.10.2004-15.10.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -9626,-6603 -9500,-6933 -9301,-7466 -8492,-9628 -8331,-9887
EOF
     },
     { from  => 1096754400, # 2004-10-03 00:00
       until => 1098050400, # 2004-10-18 00:00
       text  => 'L 171; (Hohen Neuendorf-Hennigsdorf); zw. Stolpe und AS Stolpe Stra�enbauarbeiten Vollsperrung 04.10.2004-17.10.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -25,27812 -250,27739
EOF
     },
     { from  => 1096927200, # 2004-10-05 00:00
       until => 1097877600, # 2004-10-16 00:00
       text  => 'K 6003; (Friedrichswalde-LG-L100 Gollin); OD Reiersdorf Deckenerneuerung Vollsperrung 06.10.2004-15.10.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 25097,72040 25875,71662
userdel	q4 28214,70120 27727,70536 26843,71276 26511,71453
userdel	q4 26511,71453 25875,71662
EOF
     },
     { from  => 1115503200, # 2005-05-08 00:00
       until => 1117576800, # 2005-06-01 00:00
       text  => 'L 34; (Philip-M�ller-Stra�e); OL Strausberg, zw. Feuerwehr und Nordkreuzung Fahrbahninstandsetzung halbseitig gesperrt; Einbahnstra�e 09.05.2005-31.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 43553,20466 43584,20871
userdel	q4 43553,20466 43131,19792
EOF
     },
     { from  => 1097177672, # 2004-10-07 21:34
       until => 1098050400, # 2004-10-18 00:00
       text  => 'Ruppiner Chaussee (Hennigsdorf) Kreuzung Hennigsdorfer Stra�e wegen Bauarbeiten gesperrt (bis 17.10.2004)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -1872,24336 -1790,24260 -1746,24219 -1627,24105 -1367,23853 -1286,23753 -1281,23746
userdel	q4 -1872,24336 -1896,24275 -1940,24176
userdel	q4 -1872,24336 -1953,24435
EOF
     },
     { from  => undef, # 
       until => 1097271072, # aufgehoben
       text  => 'Werner-Vo�-Damm (Tempelhof) in beidenRichtungen zwischen Boelckestra�e und B�umerplan Verkehrsbehinderung durch geplatzte Wasserleitung, Stra�e ind beiden Richtungen gesperrt.',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 8553,7795 8642,7876
userdel	q4 8553,7795 8512,7757
EOF
     },
     { from  => 1097359200, # 2004-10-10 00:00
       until => 1097877600, # 2004-10-16 00:00
       text  => 'L 30; (Sch�nower Chaussee); OD Bernau Baumf�llungen Vollsperrung 11.10.2004-15.10.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 21646,30961 21001,30933 20794,30899
userdel	q4 21646,30961 21955,30976
EOF
     },
     { from  => $isodate2epoch->("2013-09-13 10:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-09-15 20:00:00"),
       periodic => 1,
       text  => 'Hauptstra�e, zwischen Kreuzung Dominicusstr. und Kreuzung Kaiser-Wilhelm-Platz Veranstalung (Herbstfest auf der Hauptstra�e), Stra�e gesperrt (14.9.2013 10:00 - 15.9.2013 20:00)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 6687,8385 6765,8480 6912,8617 6989,8687 7009,8705 7105,8788 7201,8870 7275,8960
EOF
     },
     { from  => 1097618400, # 2004-10-13 00:00
       until => 1097964000, # 2004-10-17 00:00
       text  => 'L 33; (Berliner Str.); OL Altlandsberg Vollsp. Vollsperrung 14.10.2004-16.10.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 32100,18012 31887,17453
EOF
     },
     { from  => 1138133685, # 2006-01-24 21:14
       until => 1142463599, # 2006-03-15 23:59
       text  => 'Naumannstra�e in beiden Richtungen zwischen Torgauer Str. und Tempelhofer Weg Stra�e vollst�ndig gesperrt, f�r Radfahrer u.U. passierbar (bis Mitte M�rz 2006)',
       type  => 'handicap',
       source_id => 'IM_002432',
       data  => <<EOF,
userdel	q4 7696,7771 7717,7830 7717,7879 7713,8001 7733,8023
EOF
     },
     { from  => 1097964000, # 2004-10-17 00:00
       until => 1099000800, # 2004-10-29 00:00
       text  => 'L 171; (Hohen Neuendorf-Hennigsdorf); Bereich Anschlu�stelle; Ausbau AS Stolpe; Vollsperrung; 18.10.2004-28.10.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 375,28109 524,28171 938,28349
EOF
     },
     { from  => 1137804913, # 2006-01-21 01:55
       until => 1153739499, # 2006-08-31 23:59 1157061599
       text  => 'Blankenburger Weg (Pankow) von Bahnhofstr. bis Pasewalker Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 08.2006)',
       type  => 'gesperrt',
       source_id => 'INKO_82',
       data  => <<EOF,
userdel	1 12442,20805 12222,20637 12118,20557 12030,20490
EOF
     },
     { from  => 1098309600, # 2004-10-21 00:00
       until => 1099427095, # 1101596400, 2004-11-28 00:00 => undef
       text  => 'B 109; (Templin-Zehdenick); Bahn�bergang s�dwestl.Ortsausg.Hammelspring Gleisbauarbeiten Vollsperrung 22.10.2004-27.11.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 10148,73146 8656,71489
EOF
     },
     { from  => 1098568800, # 2004-10-24 00:00
       until => 1102719600, # 2004-12-11 00:00
       text  => 'L 16; (Siedl.Sch�nwalde-Pausin); Bahn�bergang Gleisbauarbeiten Vollsperrung; Umleitung 25.10.2004-10.12.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -10559,23255 -10737,23418
EOF
     },
     { from  => 1098741600, # 2004-10-26 00:00
       until => 1112306400, # 2005-04-01 00:00
       text  => 'B 101; (Luckenwalder-, Berliner Str.); OD Trebbin Stra�enbauarbeiten Vollsperrung 27.10.2004-31.03.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	q4 -1623,-21150 -1902,-21499
EOF
     },
     { from  => 1097964000, # 2004-10-17 00:00
       until => 1098828000, # 2004-10-27 00:00
       text  => 'L 43; (Dorfstra�e in Kobbeln); s�dl. vom Kieselwitzer Weg Durchla�bau Vollsperrung 18.10.2004-26.10.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 90062,-33160 90271,-33398
EOF
     },
     { from  => 1113170400, # 2005-04-11 00:00
       until => 1149026400, # 2006-05-31 00:00
       text  => 'L 302 Sch�neicher Str. OL Sch�neiche, Dorfaue und R�dersdorfer Str. Kanal- und Stra�enbau Vollsperrung 12.04.2005-30.05.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 31221,8312 30700,8462
EOF
     },
     { from  => 1098655200, # 2004-10-25 00:00
       until => 1103842800, # 2004-12-24 00:00
       text  => 'L 30; (Sch�nower Chaussee); OL Bernau,zw. Weinbergstra�e und Edelwei�stra�e Stra�en- u. Radwegebau Vollsperrung 26.10.2004-23.12.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 21646,30961 21001,30933 20794,30899
userdel	q4 21646,30961 21955,30976
EOF
     },
     { from  => 1098568800, # 2004-10-24 00:00
       until => 1101855600, # 2004-12-01 00:00
       text  => 'L 792; Trebbiner Str.-Glasower Damm: Stra�enbau, Vollsperrung, 25.10.2004-30.11.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 11165,-5318 11077,-5335 11054,-5341
EOF
     },
     { from  => 1098914007, # 2004-10-27 23:53
       until => 1101769140, # 200411292359
       text  => 'Gleimstr. (Mitte) in beiden Richtungen zwischen Gleimtunnel und Graunstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 29.11.2004)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9917,15613 9992,15625 10122,15647
EOF
     },
     { from  => 1098828000, # 2004-10-27 00:00
       until => 1103410800, # 2004-12-19 00:00
       text  => 'L 171; (Hohen Neuendorf-Hennigsdorf); Bereich Anschlu�stelle Stra�enbau Vollsperrung 28.10.2004-18.12.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -926,27132 -1941,26218 -2118,26060
EOF
     },
     { from  => 1099177200, # 2004-10-31 01:00
       until => 1101078000, # 2004-11-22 00:00
       text  => 'L 200; (Breite Str.); OD Eberswalde, zw. B� und Neue Str. Stra�enbauarbeiten, Vollsperrung 01.11.2004-21.11.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 38264,50086 38174,49717 38022,49097
userdel	q4 38264,50086 38476,50514 38845,51258
EOF
     },
     undef, # fr�her:
     # { from  => 1196895600, # 2007-12-06 00:00 # note: periodisch, siehe unten
     #   until => 1197154800, # 2007-12-09 00:00
     #   text  => 'Richardplatz Neuk�lln Stra�ensperrung Weihnachtsmarkt 7.12.2007-8.12.2007 ',
     #   type  => 'gesperrt',
     #   source_id => 'IM_007405',
     #   #file  => 'rixdorfer_weihnachtsmarkt.bbd', # XXX do not use anymore!!!
     #   data => '', # dummy
     # },
     { from  => 1100038749, # 2004-11-09 23:19
       until => 1100559600, # 2004-11-16 00:00
       text  => 'Lenn�str. zwischen Bellvuestr. und Eberstr. Baustelle, Stra�e gesperrt Richtung Ebertstr. (bis 15.11.2004) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8489,11782 8438,11753 8335,11718
userdel	2 8335,11718 8225,11692
EOF
     },
     { from  => 1092520800, # 2004-08-15 00:00
       until => 1104620400, # 2005-01-02 00:00
       text  => 'L 21; (M�hlenbecker Str.); OL Schildow grundh. Stra�enbau Vollsperrung 16.08.2004-01.01.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 8230,26610 8243,26462 8187,25897
EOF
     },
     { from  => 1099177200, # 2004-10-31 01:00
       until => 1123884000, # 2005-08-13 00:00
       text  => 'L 401; (Lindenallee, Fontaneallee); OL Zeuthen, zw. Forstweg und F�hrstr. grundhafter Stra�enbau Vollsperrung 01.11.2004-12.08.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 26609,-7136 26506,-6931 26146,-6218
EOF
     },
     { from  => 1089496800, # 2004-07-11 00:00
       until => 1114898400, # 2005-05-01 00:00
       text  => 'K 6740; (L 38 �stl. Berkenbr�ck-Steinh�fel); OL Demnitz Stra�enbauarbeiten Vollsperrung 12.07.2004-30.04.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 64469,-1532 64463,-1173
EOF
     },
     { from  => 1097359200, # 2004-10-10 00:00
       until => 1125525600, # 2005-09-01 00:00
       text  => 'L 19; (Zechlinerh�tte-Wesenberg (MVP)); zw. Abzw. Klein Zerlang u. LG (n�. Prebelowbr�cke) Br�ckenneubau Vollsperrung 11.10.2004-31.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -26403,85177 -26316,84900
EOF
     },
     { from  => 1100991600, # 2004-11-21 00:00
       until => 1102719600, # 2004-12-11 00:00
       text  => 'L 166; (B 5-Friesack-Garz); zw. B 5 u. Friesack u. KG n�rdl. Zootzen Stra�enbauarbeiten Vollsperrung 22.11.2004-10.12.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -45632,38429 -46170,36687
EOF
     },
     { from  => 1101078000, # 2004-11-22 00:00
       until => 1101596400, # 2004-11-28 00:00
       text  => 'L 201; (Nauener Chaussee); OD Falkensee, Bahn�bergang am Finkenkrug Gleisbauarbeiten Vollsperrung 23.11.2004-27.11.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -13756,20176 -13875,20548 -13897,20621
EOF
     },
     { from  => 1100559600, # 2004-11-16 00:00
       until => 1103583600, # 2004-12-21 00:00
       text  => 'L 23; (Templin-Lychen); OD Lychen Stra�enbau Vollsperrung 17.11.2004-20.12.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 3125,88753 2797,89387
EOF
     },
     { from  => 1116572111, # 2005-05-20 08:55
       until => 1116885600, # 2005-05-24 00:00
       text  => 'Volksradstr. (Friedrichsfelde) in beiden Richtungen Baustelle, Stra�e vollst�ndig gesperrt (bis 23.05.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 17475,10442 17511,10577 17527,10640 17569,10801 17621,10994
userdel	q4 17475,10442 17427,10259
EOF
     },
     { from  => 1100991600, # 2004-11-21 00:00
       until => 1101855600, # 2004-12-01 00:00
       text  => 'L 236; (Alberichstr. in OL B�rnicke); Alberichstr. zw. E.-Th�lmann-Str. und B�rnicker Chau Ausbau Stra�e, Radweg Vollsperrung 22.11.2004-30.11.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 26136,29466 25361,29596
EOF
     },
     { from  => 1101507035, # 2004-11-26 23:10
       until => 1102980501, # passierbar f�r Radfahrer!
       text  => 'Ebertstr. Richtung Potsdamer Platz zwischen Behrensstr. und Hannah-Ahrendt-Str. Baustelle, Fahrtrichtung gesperrt (bis April 2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 8595,12066 8577,11896 8571,11846
EOF
     },
     { from  => 1101337200, # 2004-11-25 00:00
       until => 1102374000, # 2004-12-07 00:00
       text  => 'B 167; (Zerpenschleuse-Liebenwalde); zw. OA Liebenwalde und Abzw. Hammer Erneuerung Durchlass Vollsperrung 26.11.2004-06.12.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 11095,52184 10103,52074 9686,52037
EOF
     },
     { from  => 1085263200, # 2004-05-23 00:00
       until => 1103583600, # 2004-12-21 00:00
       text  => 'L 75; (Karl-Marx-Stra�e); OD Gro�ziethen, von Dorfstra�e bis Friedhofsweg Stra�enbauarbeiten Vollsperrung 24.05.2004-20.12.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 13225,-681 13215,-570 13176,-161 13165,-34 13124,216 13165,-34 13176,-161 13215,-570 13225,-681 13230,-712 13300,-1252
EOF
     },
     { from  => 1356044400, # 2012-12-21 00:00 # 1354356000, # 1292626800, # PERIODISCH, an allen Advents-Wochenenden! # fr�her: 1102654800, # 2004-12-10 06:00
       until => 1356303599, # 2012-12-23 23:59 # 1354471200, # 1292799599, # PERIODISCH, an allen Advents-Wochenenden! # fr�her: 1102892400, # 2004-12-13 00:00
       text  => 'Umwelt- und Weihnachtsmarkt: Sophienstra�e zwischen Gro�e Hamburger Stra�e und Rosenthaler Stra�e gesperrt. 22.12. - 23.12.2012 ',
       type  => 'gesperrt',
       source_id => 'http://www.sophienstrasse-berlin.de/?y=2012',
       data  => <<EOF,
userdel	2::temp 9986,13412 10317,13248
EOF
     },
     { from  => 1102050000, # 2004-12-03 06:00 # note: periodisch, siehe unten
       until => 1102204800, # 2004-12-05 01:00
       text  => 'Bahnhofstr. zwischen Goltzstr. und Steinstra�e Weihnachstsmarkt, in beiden Richtungen gesperrt. Dauer: 04.12.2004, 06:00 Uhr bis 05.12.2004, 01:00 Uhr',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 10453,-2133 10509,-2131 10631,-2130 10747,-2129
EOF
     },
     { from  => 1101337200, # 2004-11-25 00:00
       until => 1101769200, # 2004-11-30 00:00
       text  => 'B 198; zw. Alth�ttendorf und Joachimsthal Einbau Deckschicht Vollsperrung 26.11.2004-29.11.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 34237,62950 34368,62531
EOF
     },
     { from  => 1101337200, # 2004-11-25 00:00
       until => 1103065200, # 2004-12-15 00:00
       text  => 'L 912; (P�wesin-Gortz); Br�cke �ber Seeverbindung bei P�wesin Br�ckenneubau Vollsperrung 26.11.2004-14.12.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -37026,11176 -36669,10926 -36435,10883
EOF
     },
     { from  => 1102981307, # 2004-12-14 00:41
       until => 1103324400, # 2004-12-18 00:00
       text  => 'Emmentaler Str. (Reinickendorf) Richtung Westen zwischen Residenzstr. und Gamsbartweg Baustelle, Stra�e Richtung Westen gesperrt, Einbahnstra�enregelung Richtung Osten (bis 17.12.2004)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	q4; 7676,18492 7594,18427 7510,18364 7335,18257
EOF
     },
     { from  => 1101934006, # 2004-12-01 21:46
       until => 1114976619, # aufgehoben 1117576800 2005-06-01 00:00
       text  => 'Akeleiweg, Tiefbauarbeiten, Stra�e von Eisenhutweg in Richtung Stubenrauchstra�e gesperrt, Dauer: bis 31.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 17894,2783 17631,3200 17603,3240 17388,3576
EOF
     },
     { from  => 1102538190, # 2004-12-08 21:36
       until => 1103929200, # 2004-12-25 00:00
       text  => 'D�sseldorfer Str. in beiden Richtungen zwischen Brandenburgische Str. und Konstanzer Str. Baustelle, Stra�e vollst�ndig gesperrt (bis 24.12.2004)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 4151,10026 3906,10035
EOF
     },
     { from  => undef, # 
       until => 1122058621, # nicht mehr
       text  => 'Johannisthaler Chaussee Zwischen Rudower Stra�e und K�nigsheideweg beidseitig Br�ckenarbeiten, gesperrt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15585,4139 15594,4152 15618,4189
userdel	2 15669,4266 15640,4222 15618,4189
EOF
     },
     { from  => 1102712612, # 2004-12-10 22:03
       until => 1102910400, # 2004-12-13 05:00
       text  => 'Schulze-Boysen-Str. (Lichtenberg) in beiden Richtungen zwischen Wiesenweg und Pfarrstr. Kranarbeiten, Stra�e vollst�ndig gesperrt (bis 13.12.2004 ca. 5:00 Uhr)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15477,11338 15498,11380
EOF
     },
     { from  => 1105225200, # 2005-01-09 00:00
       until => 1122406057, # 1122760800 2005-07-31 00:00
       text  => 'K 6938; (G�rzke-Hohenlobbese); zw. OL G�rzke und Abzw. Reppinichen, Br�cke Br�cken- und Stra�enbau Vollsperrung 10.01.2005-30.07.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -59612,-27488 -59438,-27447 -59410,-27340
EOF
     },
     { from  => 1102980646, # 2004-12-14 00:30 # note: periodisch, siehe unten
       until => 1104015600, # 2004-12-26 00:00
       text  => 'Weihnachtsmarkt am Opernpalais, bis 25.12.2004',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9890,12161 9875,12257 9869,12297 9852,12409
userdel	2 9801,12245 9795,12293 9780,12401
EOF
     },
     { from  => undef, # # note: gibt es nicht mehr
       until => 1135551600, # 2005-12-26 00:00
       text  => 'Weihnachtsmarkt am Schlo�platz, bis 25.12.2005',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 10174,12284 10063,12438
EOF
     },
     { from  => 1136837576, # 2006-01-09 21:12
       until => 1137016800, # 2006-01-11 23:00
       text  => 'F�hre (Ketzin) au�er Betrieb bis 11.01.2006 23:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -17728,-6975 -17643,-7028
EOF
     },
     { from  => 1104409481, # 2004-12-30 13:24
       until => 1104573600, # 2005-01-01 11:00
       text  => 'Str. des 17. Juni: Gro�er Stern - Brandenburger Tor (Mitte) in allen Richtungen sowie angrenzende Nebenstra�en Veranstaltung, Stra�e vollst�ndig gesperrt (bis 01.01.2005 ca. 11:00 Uhr)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 8214,12205 8089,12190 8055,12186
userdel	q4 8214,12205 8303,12216 8538,12245
userdel	q4 6653,12067 6642,12010
userdel	q4 6685,11954 6744,11936
userdel	q4 8610,12254 8538,12245
userdel	q4 7816,12150 8055,12186
userdel	q4 7816,12150 7383,12095
userdel	q4 6744,11936 6809,11979
userdel	q4 8861,12125 8743,12099 8737,12098
userdel	q4 6809,11979 6828,12031
userdel	q4 8546,12279 8570,12302 8573,12325
userdel	q4 8546,12279 8538,12245
userdel	q4 6828,12031 7383,12095
userdel	q4 6828,12031 6787,12099
userdel	q4 8775,12457 8540,12420
userdel	q4 8737,12098 8595,12066
userdel	q4 6642,12010 5900,11913
userdel	q4 6642,12010 6685,11954
userdel	q4 8595,12066 8600,12165
userdel	q4 8540,12420 8573,12325
userdel	q4 8538,12245 8600,12165
userdel	q4 6725,12113 6690,12104 6653,12067
userdel	q4 6787,12099 6754,12108 6725,12113
EOF
     },
     { from  => 1105311600, # 2005-01-10 00:00
       until => 1105830000, # 2005-01-16 00:00
       text  => 'K 6304; (Priorter Chaussee); OD Priort, Bahn�bergang Gleisbauarbeiten Vollsperrung 11.01.2005-15.01.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -19149,11495 -19058,11636
EOF
     },
     { from  => 1106434800, # 2005-01-23 00:00
       until => 1106780400, # 2005-01-27 00:00
       text  => 'L 62; (Elsterwerda-Hohenleipisch); Bahn�bergang bei Dreska Gleisbauarbeiten Vollsperrung 24.01.2005-26.01.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 22501,-102573 22382,-102254
EOF
     },
     { from  => 1112047200, # 2005-03-29 00:00
       until => 1112824800, # 2005-04-07 00:00
       text  => 'L 86; zw. Schmergow und Ketzin Stra�enbau Vollsperrung 30.03.2005-06.04.2005',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -27793,4863 -27127,5270
EOF
     },
     { from  => 1119996000, # 2005-06-29 00:00
       until => 1122415200, # 2005-07-27 00:00
       text  => 'K 6161; (Ernst-Th�lmann-Str.); OD Schulzendorf, Kanal- und Stra�enbau Vollsperrung 30.06.2005-30.11.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 25173,-3957 25056,-3989 24941,-4025 23408,-4513
EOF
     },
     { from  => 1107475200, # 2005-02-04 01:00
       until => 1107741600, # 2005-02-07 03:00
       text  => 'Berliner Stra�e, Zwischen Kreuzung Granitzstra�e und Florastr. in beiden Richtungen Br�ckenarbeiten, gesperrt, Dauer: 05.02.2005 01:00 Uhr bis 07.02.2005 03:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 10830,17985 10849,17848
EOF
     },
     { from  => 1075827600, # 2004-02-03 18:00
       until => 1107748800, # 2005-02-07 05:00
       text  => 'Blockdammweg in Richtung K�penicker Chaussee ab H�nower Wiesenweg gesperrt (Arbeiten an Gasleitung). Dauer: 04.02.2004 18:00 Uhr bis 07.02.2005 05:00 Uhr ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 17380,8858 17067,8725
EOF
     },
     { from  => 1107730800, # 2005-02-07 00:00
       until => 1108681200, # 2005-02-18 00:00
       text  => 'K 6148; (Brand-Halbe); Bahn�bergang in OL Teurow Arbeiten an Signaltechnik Vollsperrung 08.02.2005-17.02.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 32937,-34794 32829,-34732 32781,-34707
EOF
     },
     { from  => 1108854000, # 2005-02-20 00:00
       until => 1109199600, # 2005-02-24 00:00
       text  => 'L 62; (Elsterwerda-Hohenleipisch); Bahn�bergang bei Dreska Gleisbauarbeiten Vollsperrung 21.02.2005-23.02.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 22501,-102573 22382,-102254
EOF
     },
     { from  => 1108249200, # 2005-02-13 00:00
       until => 1110145553, # not anymore, was 1114898400 2005-05-01 00:00
       text  => 'Im Zeitraum vom 14.02.2005 bis 30.04.2005 besteht f�r die L 73 zwischen Langerwisch und Wildenbruch Vollsperrung auf Grund von Bauarbeiten. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -12104,-13586 -12221,-13124
userdel	2 -12104,-13586 -12154,-13801
userdel	2 -12344,-12547 -12221,-13124
userdel	2 -12344,-12547 -12373,-12221 -12373,-12118
userdel	2 -12305,-10732 -12369,-11903 -12373,-12118
EOF
     },
     { from  => 1108684644, # 2005-02-18 00:57
       until => 1122847199, # 2005-07-31 23:59
       text  => 'F�rstenwalder Damm zwischen B�lschestr. und Stillerzeile Baustelle, Stra�e stadteinw�rts gesperrt (bis Ende 07.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q3; 25579,5958 25179,5819 25121,5799
EOF
     },
     { from  => 1108681200, # 2005-02-18 00:00
       until => 1109372400, # 2005-02-26 00:00
       text  => 'L 791; (Luckenwalder Str.); Bahn�bergang in Zossen, Havarie, Vollsperrung, 19.02.2005-25.02.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 13557,-21831 13014,-22300
userdel	2 13557,-21831 13960,-21244
EOF
     },
     { from  => 1109280022, # 2005-02-24 22:20
       until => 1109631600, # 2005-03-01 00:00
       text  => 'Sp�thstra�e (Treptow) In beiden Richtungen zwischen A113 und K�nigsheideweg St�rungen durch geplatzte Wasserleitung, Stra�e gesperrt (bis 28.02.2005) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 14694,5230 14744,5211 14808,5202 14988,5214
userdel	2 14988,5214 15038,5235 15183,5480
userdel	2 15183,5480 15363,5668 15382,5687
EOF
     },
     { from  => 1113429600, # 2005-04-14 00:00
       until => 1113775200, # 2005-04-18 00:00
       text  => 'L 24; (AS Pfingstberg-Gerswalde); Bereich AS Pfingstberg, Br�cke A 11 Br�ckenabruch Vollsperrung 15.04.2005-17.04.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 41292,81052 41593,80703
EOF
     },
     { from  => 1109545200, # 2005-02-28 00:00
       until => 1128117600, # 2005-10-01 00:00
       text  => 'B 179; (Berliner Str.); OL K�nigs Wusterhausen, zw. Schlo�platz u. Funkerberg Kanalarbeiten halbseitig gesperrt (welche Richtung?); Einbahnstra�e 01.03.2005-30.09.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 25859,-11559 25640,-11357
EOF
     },
     { from  => 1109365909, # 2005-02-25 22:11
       until => 1125525599, # 2005-08-31 23:59
       text  => 'Hussitenstr. (Mitte) in Richtung Bernauer Str. zwischen Bernauer Str. und Usedomer Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 08.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 9112,14771 9250,14658 9338,14587 9472,14478
EOF
     },
     { from  => 1109628414, # 2005-02-28 23:06
       until => 1135591662, # was 1136069999 2005-12-31 23:59
       text  => 'Ringstr. (Steglitz) Richtung Finkensteinallee zwischen Drakestr. und Finckensteinallee Baustelle, Fahrtrichtung gesperrt (bis 12.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 3507,3635 3375,3544 3228,3455 3184,3427 3050,3333 3011,3303 2781,3122 2701,3064 2661,3021 2637,2973 2638,2843
EOF
     },
     { from  => 1110917391, # 2005-03-15 21:09
       until => 1111100400, # 2005-03-18 00:00
       text  => 'Augsburger Str. (Charlottenburg) in beiden Richtungen zwischen Joachimstaler Str. und Rankestr. Baustelle, Stra�e vollst�ndig gesperrt (Kranarbeiten) (bis 17.03.2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 5636,10626 5471,10719
EOF
     },
     { from  => 1110063600, # 2005-03-06 00:00
       until => 1122674400, # 2005-07-30 00:00
       text  => 'K 6738; (L 36 n�rdl. Steinh�fel-M�ncheberg); OD Tempelberg Stra�enausbau Vollsperrung 07.03.2005-29.07.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 62529,5578 62084,5754
userdel	q4 61809,5952 62084,5754
EOF
     },
     { from  => 1111960800, # 2005-03-28 00:00
       until => 1125525600, # 2005-09-01 00:00
       text  => 'K 6907; (B 1 Neuseddin-Ferch); OD Neuseddin, Kunersdorfer Str. Stra�enbauarbeiten Vollsperrung 29.03.2005-31.08.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -16479,-14389 -17341,-13386
userdel	q4 -18153,-12489 -17341,-13386
EOF
     },
     { from  => 1111437775, # 2005-03-21 21:42
       until => 1111705200, # 2005-03-25 00:00
       text  => 'Sterndamm (Treptow) in Richtung Rudow zwischen K�nigsheideweg und Winckelmannstr. Baustelle, Fahrtrichtung gesperrt, eine Umleitung ist eingerichtet (bis 24.03.2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 17520,4649 17471,4570 17428,4503
EOF
     },
     { from  => 1110235074, # 2005-03-07 23:37
       until => 1110317384, # from 2005-12-09 marked as removed, check!
       text  => 'Unter den Linden (Mitte) Richtung Westen zwischen Schadowstr. und Wilhelmstr. Baustelle, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 9028,12307 8804,12280
EOF
     },
     { from  => 1127503882, # 2005-09-23 21:31
       until => 1127772000, # 2005-09-27 00:00
       text  => 'Dahlwitzer Landstr. - B�lschestr. (K�penick) in beiden Richtungen an der Bahnbr�cke B�lschestr. Baustelle, Stra�e vollst�ndig gesperrt (Br�cken- und Stra�enarbeiten) (bis 26.09.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 25584,6029 25579,5958
EOF
     },
     { from  => 1110668400, # 2005-03-13 00:00
       until => 1111186800, # 2005-03-19 00:00
       text  => 'L 29; (Oderberg-Hohenfinow); OD Oderberg Baumf�llarb. Dammsicherung Vollsperrung 14.03.2005-18.03.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 52671,51846 51496,51542
EOF
     },
     { from  => 1110679200, # 2005-03-13 03:00
       until => 1116194400, # 2005-05-16 00:00
       text  => 'Wassersportallee - Regattastra�e, Zwischen Kreuzung Adlergestell und Kreuzung Wassersportallee in beiden Richtungen gesperrt, Baustelle, Dauer: 14.03.2005 03:00 Uhr bis 15.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 22453,1294 22367,1230 22287,1165 22217,1108
userdel	q4 22453,1294 22493,1325 22560,1377 22655,1450
userdel	q4 22217,1108 22162,1067
EOF
     },
     { from  => 1110862800, # 2005-03-15 06:00
       until => 1111013999, # 2005-03-16 23:59
       text  => 'Kantstra�e Richtung Spandau: Zwischen Kreuzung Hardenbergstra�e und Kreuzung Joachimstaler Stra�e gesperrt, Dauer: 16.03.2005 06:00 Uhr bis 16:00 Uhr (Filmarbeiten) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 5652,11004 5613,10963 5488,10978
EOF
     },
     { from  => 1110700800, # 2005-03-13 09:00
       until => 1111168800, # 2005-03-18 19:00
       text  => 'Die Stadthausstra�e ist zwischen T�rschmidtstra�e und Archibaldweg gesperrt. Grund Bauarbeiten. Dauer: 14.03.05, 09.00 Uhr bis 18.03.05, 19.00 Uhr. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15674,10851 15649,10922
EOF
     },
     { from  => 1112479200, # 2005-04-03 00:00
       until => 1113602400, # 2005-04-16 00:00
       text  => 'B 246; (Gerichtsstr.); OL Zossen, zw. Friedhofsweg u. Luchweg Stra�enbauarbeiten Vollsperrung 04.04.2005-15.04.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 15178,-20983 15072,-21175
EOF
     },
     { from  => 1110841200, # 2005-03-15 00:00
       until => 1117576800, # 2005-06-01 00:00
       text  => 'K 6501; (Bahnhofstr.); OD Schildow, zw. Hauptstr. u. F.-Schmidt-Str. grundhafter Stra�enbau Vollsperrung 16.03.2005-31.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 7975,25642 8182,25608
EOF
     },
     { from  => 1149623367, # 2006-06-06 21:49
       until => 1154383199, # 2006-07-31 23:59
       text  => 'Nennhauser Damm (Spandau) stadteinw�rts zwischen Heerstr. und D�beritzer Weg Baustelle, Fahrtrichtung gesperrt (bis Ende 07.2006)',
       type  => 'gesperrt',
       source_id => 'IM_002500',
       data  => <<EOF,
userdel	1 -8784,13321 -8756,13356 -8358,13340 -8296,13338 -8049,13332
EOF
     },
     { from  => 1111524913, # 2005-03-22 21:55
       until => 1120168800, # 2005-07-01 00:00
       text  => 'Pistoriusstr. (Weissensee) Richtung Berliner Allee zwischen Mirbachplatz und Parkstr. Baustelle, Fahrtrichtung gesperrt (bis 30.06.2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 13400,16395 13485,16362 13544,16339 13632,16305 13652,16297 13679,16286 13788,16240
EOF
     },
     { from  => 1111960800, # 2005-03-28 00:00
       until => 1119477600, # 2005-06-23 00:00
       text  => 'B 2; (Bernau-Biesenthal); B 2, OD R�dnitz grundh. Ausbau, Bau Kreisverk. Vollsperrung 29.03.2005-22.06.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 25069,35558 25007,35418 24930,35363
EOF
     },
     { from  => 1111960800, # 2005-03-28 00:00
       until => 1120428000, # 2005-07-04 00:00
       text  => 'L 23; (Joachimsthal-Templin); OD Joachimsthal Neubau Durchlass Vollsperrung 29.03.2005-03.07.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 32966,64019 33080,63939 33206,63582 33254,63446
EOF
     },
     { from  => 1111532400, # 2005-03-23 00:00
       until => 1114898400, # 2005-05-01 00:00
       text  => 'L 291; (Oderberger Str.); OD Eberswalde, Einm. Breite Str. Stra�enbauarbeiten Vollsperrung 24.03.2005-30.04.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 38022,49097 37914,48720 37906,48495 37898,48413 37900,48350 37909,48248
EOF
     },
     { from  => 1111960800, # 2005-03-28 00:00
       until => 1115157600, # 2005-05-04 00:00
       text  => 'L 23; (Templin-Lychen); OD Lychen, Kreuzungsber. Stra�enbau Vollsperrung 29.03.2005-03.05.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	q4 3125,88753 2797,89387
EOF
     },
     { from  => 1113084000, # 2005-04-10 00:00
       until => 1113602400, # 2005-04-16 00:00
       text  => 'L 622; (R�ckersdorf-Doberlug Kirchhain); s�dl. Doberlug-Kirchhain, H�he Hammerteich Baumf�llarbeiten Vollsperrung 11.04.2005-15.04.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 22507,-89430 22558,-89699
EOF
     },
     { from  => 1112072400, # 2005-03-29 07:00
       until => 1112810400, # 2005-04-06 20:00
       text  => 'die F�hre Ketzin ist vom 30.03.05 07.00 Uhr bis 06.04.2005 20.00 Uhr aufgrund Bauarbeiten gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -26784,5756 -26840,5684
EOF
     },
     { from  => 1112339478, # 2005-04-01 09:11
       until => 1112562000, # 2005-04-03 23:00
       text  => 'Wilhelmstra�e, Stra�e gesperrt bis 03.04.2005 23:00 Uhr (Fr�hlingsfest zwischen Pichelsdorfer Stra�e und Adamstra�e). ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -3913,13054 -3886,13120 -3824,13350
userdel	2 -3913,13054 -3962,12973 -3999,12912 -4043,12833
userdel	2 -4043,12833 -4099,12763 -4174,12683
EOF
     },
     { from  => 1111960800, # 2005-03-28 00:00
       until => 1133391600, # 2005-12-01 00:00
       text  => 'B 2; (Leipziger Str.); OD Treuenbrietzen, zw. Krz.Leipz.-/Belziger Str. u. Hinter d.Mauer Stra�enbau, KVK Vollsperrung 29.03.2005-30.11.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -25419,-35417 -25163,-35142 -24963,-35018
EOF
     },
     { from  => 1113256800, # 2005-04-12 00:00
       until => 1113602400, # 2005-04-16 00:00
       text  => 'L 23; (Britz-Joachimsthal); Bereich AS Chorin Br�ckenbauarbeiten Vollsperrung 13.04.2005-15.04.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 35962,59463 35405,59832
EOF
     },
     { from  => undef, # 
       until => 1133819018, # not anymore
       text  => 'L 711; (Krausnick-AS Stakow); zw. Krausnick u. Bahnhof Brand Einschr�nkung Tragf�higkeit Vollsperrung, Dauer unbekannt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 35214,-41158 35289,-41439 35915,-41259 36010,-41272 36387,-40961 36499,-41097 37581,-41158 37950,-41275 38512,-41000 40390,-41069
EOF
     },
     { from  => 1113256800, # 2005-04-12 00:00
       until => 1113688800, # 2005-04-17 00:00
       text  => 'L 30; (Bernauer Str.); OL Altlandsberg zw. Strausberger Str. u. Buchholzer Str. Kanalarbeiten Vollsperrung 13.04.2005-16.04.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 32665,17841 32933,17242 32945,17123 33016,17059 33589,15778
EOF
     },
     { from  => 1113084000, # 2005-04-10 00:00
       until => 1114812000, # 2005-04-30 00:00
       text  => 'L 59; (Bormannstr.); OL Bad Liebenwerda Kanalneubau Vollsperrung 11.04.2005-29.04.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 12571,-99519 12788,-100207
EOF
     },
     { from  => 1113336339, # 2005-04-12 22:05
       until => 1117490400, # 2005-05-31 00:00
       text  => 'Zimmermannstr. (Marzahn) Richtung Osten zwischen K�penicker Str. und Lindenstr. Baustelle, Fahrtrichtung gesperrt (bis 30.05.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 21088,9175 21206,9130 21314,9083 21351,9066
EOF
     },
     { from  => 1123452000, # 2005-08-08 00:00
       until => 1130623200, # 2005-10-30 00:00
       text  => 'B 101; (Berliner Str.); OD Trebbin, zw. Bahnhofstr. u. Luckenwalder Str., Stra�enbauarbeiten, Vollsperrung, 09.08.2005-29.10.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -1902,-21499 -1623,-21150
EOF
     },
     { from  => 1113688800, # 2005-04-17 00:00
       until => 1119045600, # 2005-06-18 00:00
       text  => 'L 141; (B 5-Neustadt); zw. B 5 und Dreetz Deckenerneuerung Vollsperrung 18.04.2005-17.06.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -50303,42160 -50198,42376
userdel	2 -50303,42160 -50496,42007
EOF
     },
     { from  => 1113775200, # 2005-04-18 00:00
       until => 1130536800, # 2005-10-29 00:00
       text  => 'L 14; (Gro�derschau- Bahnhof Zernitz); Br�cke �ber die Neue J�gelitz bei Zernitz Br�ckensanierung Vollsperrung 19.04.2005-28.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -63163,51264 -63375,50856
EOF
     },
     { from  => 1112652000, # 2005-04-05 00:00
       until => 1122242400, # 2005-07-25 00:00
       text  => 'B 273; (Potsdamer Str.); OD Potsdam, OT Bornim, zw. Florastr. u. R�ckertstr. Kanalarbeiten halbseitig gesperrt; Einbahnstra�e 06.04.2005-24.07.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -16640,1304 -16026,1044 -15938,1003 -15533,813 -15501,795
userdel	q4 -16640,1304 -16719,1369 -16742,1387 -16763,1402 -16905,1503
EOF
     },
     { from  => 1113775200, # 2005-04-18 00:00
       until => 1120168800, # 2005-07-01 00:00
       text  => 'L 691; (D�brichen-Wehrhain-B 87); Kreuzung zw. D�brichen u. Frankenhain Knotenausbau Vollsperrung 19.04.2005-30.06.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 11561,-75017 12171,-75229
EOF
     },
     { from  => 1113869983, # 2005-04-19 02:19
       until => 1114812000, # 2005-04-30 00:00
       text  => 'Kastanienallee (Prenzlauer Berg) Richtung stadtausw�rts zwischen Schwedter Str. und Oderberger Str. Baustelle, Fahrtrichtung gesperrt (bis 29.04.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 10530,14452 10723,14772
EOF
     },
     { from  => 1113714000, # 2005-04-17 07:00
       until => 1114034400, # 2005-04-21 00:00
       text  => 'Kronenstra�e (Mitte) in beiden Richtungen, zwischen Charlottenstra�e und Markgrafenstra�e Kranarbeiten, Stra�e gesperrt, Dauer: 18.04.2005, 07.00 Uhr bis 20.04.2005',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 9569,11631 9701,11656
EOF
     },
     { from  => 1113870146, # 2005-04-19 02:22
       until => 1114553274, # ich konnte aus der S-Bahn heraus nichts erkennen 2005-12-31 23:59
       text  => 'Rosa-Luxemburg-Str. (Mitte) Richtung stadtausw�rts, zwischen Memhardstr. und Torstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 2005) Umleitung �ber Karl-Liebknecht-Stra�e - Torstra�e',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 10755,13152 10846,13362 10852,13377 10825,13463 10790,13565 10777,13614 10746,13673
EOF
     },
     { from  => 1112220000, # 2005-03-31 00:00
       until => 1115244000, # 2005-05-05 00:00
       text  => 'B 101; (Luckenwalder-, Berliner Str.); OD Trebbin, Knoten Beelitzer Str. Stra�enbauarbeiten Vollsperrung 01.04.2005-04.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -1902,-21499 -1969,-21492
EOF
     },
     { from  => 1114468172, # 2005-04-26 00:29
       until => 1136069999, # 2005-12-31 23:59
       text  => 'Berliner Allee Richtung stadtauw�rts, zwischen Langhanstr. und Lindenallee Baustelle, Fahrtrichtung gesperrt (bis Ende 2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 13512,15909 13623,15954 13630,15956 13737,15994 13826,16026 14014,16106 14045,16120 14248,16202 14371,16252
EOF
     },
     { from  => 1138319749, # 2006-01-27 00:55
       until => 1146434399, # 2006-04-30 23:59
       text  => 'Vulkanstr. (Lichtenberg) von Landsberger Allee bis Herzbergstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 04.2006)',
       type  => 'handicap',
       source_id => 'INKO_77420',
       data  => <<EOF,
userdel	q4; 15838,14319 15855,14207 15871,14106 15897,13942 15896,13760 15896,13594 15896,13547
EOF
     },
     { from  => 1114466400, # 2005-04-26 00:00
       until => 1143756000, # 2006-03-31 00:00
       text  => 'B 001 Potsdamer Str. OD Gro� Kreutz Kanal- und Stra�enbau; Vollsperrung 27.04.2005-30.03.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4	-28793,-1618 -31991,-1024
EOF
     },
     { from  => 1115503200, # 2005-05-08 00:00
       until => 1116021600, # 2005-05-14 00:00
       text  => 'L 30; (Tiergartenstr.); OT Neue M�hle, Schleuse Stra�enbauarbeiten Vollsperrung 09.05.2005-13.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	2 27543,-11912 27544,-11856 27620,-11806 27657,-11741
EOF
     },
     { from  => 1122760800, # 2005-07-31 00:00
       until => 1124056800, # 2005-08-15 00:00
       text  => 'B 179; (Cottbuser-/ Fichtestr.); OL K�nigs Wusterhausen, Bahn�bergang Fichtestr. Umbau Bahn�bergang Vollsp * 01.08.2005-14.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26313,-13049 26205,-12769 26138,-12596 26028,-12312
EOF
     },
     { from  => 1114725600, # 2005-04-29 00:00
       until => 1114984800, # 2005-05-02 00:00
       text  => 'B 198; (Schwedter Str.); OD Prenzlau, Kno. Uckermarkkaserne Ausbau Knotenpunkt Vollsperrung 30.04.2005-01.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 40691,100865 40607,100911 40507,100965
EOF
     },
     { from  => 1114725600, # 2005-04-29 00:00
       until => 1114984800, # 2005-05-02 00:00
       text  => 'L 90; (Eisenbahnstr.); OD Werder, zw. B1 Berliner Str. u. Ph�bener Str. 126. Baumbl�tenfest Vollsperrung 30.04.2005-01.05.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -21137,-4034 -21112,-3787
EOF
     },
     { from  => 1114898400, # 2005-05-01 00:00
       until => 1133391600, # 2005-12-01 00:00
       text  => 'L 76; (Mahlower Str.); OL Teltow, zw. Ruhlsdorfer u. A.-Saefkow-Str. Kanal- und Stra�enbau Vollsperrung 02.05.2005-30.11.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 1453,-746 1550,-761 1684,-927
userdel	q4 1916,-1090 1684,-927
EOF
     },
     { from  => 1115589537, # 2005-05-08 23:58
       until => 1126821599, # 2005-09-15 23:59
       text  => 'Danziger Str. (Prenzlauer Berg) Richtung Osten zwischen Sch�nhauser Allee und Knaackstr. Baustelle Fahrtrichtung gesperrt, Umleitung: Sch�nhauser Allee - Sredzkistr. - Knaackstr. (bis Mitte 09.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 10881,15047 11056,15009
EOF
     },
     { from  => 1115535600, # 2005-05-08 09:00
       until => 1118354400, # 2005-06-10 00:00
       text  => 'Rosenfelder Stra�e Richtung Frankfurter Allee zwischen Skandinavische Stra�e und Frankfurter Allee Baustelle, Stra�e gesperrt, Dauer: 09.05.2005, 09.00 Uhr bis 09.06.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 17338,11969 17358,11943 17306,11866 17240,11791
EOF
     },
     { from  => 1116280800, # 2005-05-17 00:00
       until => 1152396000, # 2006-07-09 00:00
       text  => 'B 115 Forster Str. OD D�bern grundhafter Stra�enausbau Vollsperrung 18.05.2005-08.07.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 93524,-86350 93217,-85769
EOF
     },
     { from  => 1116280800, # 2005-05-17 00:00
       until => 1117663200, # 2005-06-02 00:00
       text  => 'K 6425; Zw. Neuenhagen und Altlandsberg Abriss Br�cke �. BAB Vollsperrung 18.05.2005-01.06.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 30768,15431 29743,14143
EOF
     },
     { from  => 1116367200, # 2005-05-18 00:00
       until => 1116885600, # 2005-05-24 00:00
       text  => 'L 30; (Friedrichstra�e); OL Erkner, zw. F�rstenwalder Str. u. Beuststr. 13.Heimatfest Erkner Vollsperrung 19.05.2005-23.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 34443,1951 34250,2546
EOF
     },
     { from  => 1117317600, # 2005-05-29 00:00
       until => 1133391600, # 2005-12-01 00:00
       text  => 'L 86; (Lehniner Str.); OD Damsdorf Kanal- und Stra�enbau Vollsperrung 30.05.2005-30.11.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -32682,-7140 -32645,-6220
EOF
     },
     { from  => 1117576800, # 2005-06-01 00:00
       until => 1118959200, # 2005-06-17 00:00
       text  => 'K 6422; (Sch�neicher Allee); Br�cke A 10 zw. B 1 und Fredersdorf Br�ckenabbruch Vollsperrung 02.06.2005-16.06.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 33128,11823 32535,11591
EOF
     },
     { from  => 1116194400, # 2005-05-16 00:00
       until => Time::Local::timelocal(reverse(2005-1900,8-1,31,23,59,59)),
       text  => 'L 15; (F�rstenberg-Rheinsberg); OD Menz Kanal-,Stra�en- u. Br�ckenbau Vollsperrung 17.05.2005-08.07.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -15062,76937 -14623,77426
EOF
     },
     { from  => 1116194400, # 2005-05-16 00:00
       until => Time::Local::timelocal(reverse(2005-1900,8-1,31,23,59,59)),
       text  => 'L 222; (Gransee-Menz); OD Menz Kanal-,Stra�en- u. Br�ckenbau Vollsperrung 17.05.2005-08.07.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -15062,76937 -14862,76637
EOF
     },
     { from  => 1116885600, # 2005-05-24 00:00
       until => 1117490400, # 2005-05-31 00:00
       text  => 'L 35; (Eisenbahnstr.); OL F�rstenwalde, zw. Wassergasse und Frankfurter Str. Fr�hlingsfest Vollsperrung 25.05.2005-30.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 55447,-4247 55447,-4432 55447,-4585 55536,-4725
EOF
     },
     { from  => 1117080000, # 2005-05-26 06:00
       until => 1117490400, # 2005-05-31 00:00
       text  => 'Luxemburger Stra�e - F�hrer Stra�e, Zwischen Kreuzung Leopoldplatz und Kreuzung Amrumer Stra�e Veranstaltung, Stra�e gesperrt, Dauer: 27.05.2005 06:00 Uhr bis 30.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 7138,15437 6996,15319
userdel	q4 7138,15437 7277,15586
userdel	q4 6626,15104 6715,15152
userdel	q4 6715,15152 6833,15215 6996,15319
EOF
     },
     { from  => 1117231200, # 2005-05-28 00:00
       until => 1117490400, # 2005-05-31 00:00
       text  => 'K 6910; (Geltower Chausse); Bahn�bergang im OT Caputh Gleisbauarbeiten Vollsperrung 29.05.2005-30.05.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -17811,-6820 -17811,-6691
EOF
     },
     { from  => 1117404000, # 2005-05-30 00:00
       until => 1117749600, # 2005-06-03 00:00
       text  => 'L 29; (Biesenthal-Wandlitz); Bahn�bergang bei Wandlitz Gleisbauarbeiten Vollsperrung 31.05.2005-02.06.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15403,40364 14698,40345
EOF
     },
     { from  => 1117317600, # 2005-05-29 00:00
       until => 1126821600, # 2005-09-16 00:00
       text  => 'K 7330; (L 23 n�rdl. Templin-Gandenitz); OD Gandenitz Kanal- und Stra�enbau Vollsperrung 30.05.2005-15.09.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 11445,85021 11487,85151
EOF
     },
     { from  => 1118091230, # 2005-06-06 22:53
       until => 1136069999, # 2005-12-31 23:59
       text  => 'Bouch�stra�e (Treptow) in beiden Richtungen zwischen Kiefholzstra�e und Am Treptower Park Fahrbahnerneuerung, Stra�e vollst�ndig gesperrt (bis Ende 2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 13867,9864 13645,9621 13601,9572
EOF
     },
     { from  => 1119391200, # 2005-06-22 00:00
       until => 1123365600, # 2005-08-07 00:00
       text  => 'B 246; zw. Christinendorf und Trebbin Anbind. neue Br�cke Vollsperrung 23.06.2005-06.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 1691,-21721 1271,-21606
EOF
     },
     { from  => 1119736800, # 2005-06-26 00:00
       until => 1130709600, # 2005-10-30 23:00
       text  => 'K 6152; (Gussower Str.); OD Gr�bendorf, ab B246 bis OA Kanal- und Stra�enbau Vollsperrung 27.06.2005-30.10.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 31863,-18000 32922,-16523
EOF
     },
     { from  => 1119477600, # 2005-06-23 00:00
       until => 1120168800, # 2005-07-01 00:00
       text  => 'K 7234; (Goethestr.); Bahn�bergang in Dabendorf Gleisbauarbeiten Vollsperrung 24.06.2005-30.06.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 13048,-18384 13282,-18250
userdel	2 14153,-17829 13282,-18250
EOF
     },
     { from  => 1118527200, # 2005-06-12 00:00
       until => 1135378800, # 2005-12-24 00:00
       text  => 'L 216; (Gollin-Templin); OD Vietmannsdorf, Br�cke �ber M�hlengraben Br�ckenneubau Vollsperrung 13.06.2005-23.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 17470,72358 17625,72041
EOF
     },
     { from  => 1118959200, # 2005-06-17 00:00
       until => 1119132000, # 2005-06-19 00:00
       text  => 'L 23; (M�hlenstr.); OD Templin, zw. Heinestr. und M.-Luther-Str. 16. Stadtfest Vollsperrung 18.06.2005-18.06.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 15317,79685 15527,79560 15654,79485 15751,79428 15800,79399 15840,79375
EOF
     },
     { from  => 1118527200, # 2005-06-12 00:00
       until => 1119650399, # 2005-06-24 23:59
       text  => 'Zimmerstra�e Richtung Charlottenstra�e zwischen Friedrichstra�e und Charlottenstra�e Kranarbeiten, gesperrt bis 24.06.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 9478,11317 9603,11328
EOF
     },
     { from  => 1119240000, # 2005-06-20 06:00
       until => 1119412800, # 2005-06-22 06:00
       text  => '"Bridge Partie", Modersohnbr�cke von 21.06.2005, 06.00 Uhr bis 22.06.2005, 06:00 Uhr gesperrt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 14026,10869 14043,10928 14076,11057 14096,11134 14134,11272
EOF
     },
     { from  => 1118949539, # 2005-06-16 21:18
       until => 1120068000, # 2005-06-29 20:00
       text  => 'Franz�sische Str. ab Markgrafenstr., Werderscher Markt, Breite Str. gesperrt. Dauer: bis 29.06.2005, 20:00 Uhr. (Beachvolleyball) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9643,12127 9756,12139 9812,12145
userdel	2 10091,12232 10035,12209 9972,12184
userdel	2 9812,12145 9890,12161
userdel	2 9890,12161 9972,12184
userdel	2 10174,12284 10109,12238
userdel	2 10174,12284 10199,12251 10285,12306
EOF
     },
     { from  => 1118988173, # 2005-06-17 08:02
       until => 1119218400, # 2005-06-20 00:00
       text  => '300 Jahre Charlottenburg, 17.06.2005 bis 19.06.2005',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 3072,12222 3060,12311 3050,12394 3034,12502
userdel	2 3072,12222 3091,12071
userdel	2 3034,12502 2786,12473 2745,12467 2717,12463 2643,12453
userdel	2 3034,12502 3189,12519 3280,12512
userdel	2 3103,11968 3091,12071
userdel auto	3 3358,12258 3217,12239 3072,12222 2899,12200 2895,12217
userdel auto	3 2895,12217 2899,12200 3072,12222 3217,12239 3358,12258
EOF
     },
     { from  => 1120180333, # undef 2005-07-07 00:00
       until => 1120180333, # undef 2005-07-10 00:00
       text  => 'L 30; (Woltersdorfer Landstr.); OD Erkner Grundhafter Stra�enbau Vollsperrung 08.07.2005-09.07.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 34271,3184 34486,4276
EOF
     },
     { from  => 1118872800, # 2005-06-16 00:00
       until => 1119132000, # 2005-06-19 00:00
       text  => 'L 77; (Saarmund-G�terfelde); OD Philippsthal, zw. Kreisel u. OE Dreharbeiten Vollsperrung 17.06.2005-18.06.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -6319,-7823 -6659,-8210
EOF
     },
     { from  => 1118993118, # 2005-06-17 09:25
       until => 1119240000, # 2005-06-20 06:00
       text  => '"K�penicker Sommer", im Bereich Altstadt Stra�en gesperrt bis 20.06.2005, 06:00 Uhr (Schlo�platz, Gr�nstra�e, Rosenstra�e, Alt-K�penick, Sch��lerplatz, J�gerstra�e, Luisenhain, Schlo�insel) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 22138,4661 22133,4644 22111,4562
userdel	2 22138,4661 22175,4730 22196,4847
userdel	2 22111,4562 22162,4546
userdel	2 22111,4562 22093,4499
userdel	2 22153,4840 22074,4664 22057,4618 22043,4562
userdel	2 22395,4678 22365,4676 22355,4660 22314,4604
userdel	2 22324,4586 22214,4548 22162,4546
userdel	2 22043,4562 22057,4531 22071,4501
EOF
     },
     { from  => 1119391200, # 2005-06-22 00:00
       until => 1123452000, # 2005-08-08 00:00
       text  => 'B 168; (Lieberose-Friedland); zw. Lieberose und Abzw. Mochlitz Stra�enbauarbeiten Vollsperrung 23.06.2005-07.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 73201,-43677 72887,-44704
EOF
     },
     { from  => 1119132000, # 2005-06-19 00:00
       until => 1132959600, # 2005-11-26 00:00
       text  => 'L 53; (Seestr.); OL Gro�r�schen, zw. B96 u. Ahornstr. Stra�enbauarbeiten Vollsperrung 20.06.2005-25.11.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 54020,-90746 53752,-90652 53510,-90531
userdel	q4 53144,-90435 53510,-90531
EOF
     },
     { from  => 1123365600, # 2005-08-07 00:00
       until => 1128376800, # 2005-10-04 00:00
       text  => 'L 17; (LG Berlin-Hennigsdorf); zw. Kreisverkehr und Hennigsdorf Stra�enbau Vollsperrung 08.08.2005-03.10.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	2 -2800,25478 -2446,25386
EOF
     },
     { from  => 1119736800, # 2005-06-26 00:00
       until => 1121117530, # 1121119200 2005-07-12 00:00
       text  => 'L 26; (L�cknitz MVP-LG-Br�ssow); zw. LG und Kno. Wollschow Deckeneinbau Vollsperrung 27.06.2005-11.07.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 61751,112656 61788,112769
EOF
     },
     { from  => 1119697095, # 2005-06-25 12:58
       until => 1136069999, # 2005-12-31 23:59
       text  => 'Dorotheenstr. Richtung Osten zwischen Wilhelmstr. und Schadowstr. sowie Schadowstr. Richtung Unter den Linden gesperrt (bis Ende 2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 8775,12457 8907,12472 9008,12485
userdel	q4; 9008,12485 9016,12416 9028,12307
EOF
     },
     { from  => 1119909600, # 2005-06-28 00:00
       until => 1125698400, # 2005-09-03 00:00
       text  => 'L 793; (Sch�nhagen-Ludwigsfelde); zw. Abzw. Gr�ben und Siethen Stra�enbauarbeiten Vollsperrung 29.06.2005-02.09.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -2542,-13926 -3842,-14180
EOF
     },
     { from  => 1119909600, # 2005-06-28 00:00
       until => 1125698400, # 2005-09-03 00:00
       text  => 'L 793; (Sch�nhagen-Ludwigsfelde); zw. OD J�tchendorf und Abzw. Gr�ben Stra�enbauarbeiten Vollsperrung 29.06.2005-02.09.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -3717,-14467 -4077,-14595
userdel	2 -4504,-14978 -4077,-14595
EOF
     },
     { from  => 1120085920, # 2005-06-30 00:58
       until => 1120413600, # 2005-07-03 20:00
       text  => 'Stra�e des 17. Juni in beiden Richtungen zwischen Gro�er Stern und Entlastungsstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 03.07.2005 ca. 20 Uhr)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 6828,12031 7383,12095
userdel	2 7383,12095 7816,12150
userdel	2 7816,12150 8055,12186
userdel auto	3 7663,11946 7460,12054 7383,12095 7039,12314
userdel auto	3 7039,12314 7383,12095 7460,12054 7663,11946
EOF
     },
     { from  => undef, # 
       until => 1148937435, # 
       text  => 'Rosa-Luxemburg-Str. Richtung Sch�nhauser Tor wegen Bauarbeiten gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 10755,13152 10846,13362 10852,13377 10825,13463 10790,13565 10777,13614 10746,13673
EOF
     },
     { from  => 1114293600, # 2005-04-24 00:00
       until => 1125957600, # 2005-09-06 00:00
       text  => 'L 70; (Karl-Fiedler-Str.); OD Sperenberg, zw. Goethestr. u. Am Niederflie� Kompletter Stra�enausbau Vollsperrung 25.04.2005-05.09.2005 ',
       type  => 'handicap',
       data  => <<EOF,
	q4 8576,-29378 8662,-29911
EOF
     },
     { from  => 1120088649, # 2005-06-30 01:44
       until => 1126796400, # 2005-09-15 17:00
       text  => 'Holzendorffstra�e zwischen R�nnestra�e und Gervinusstra�e Br�ckenarbeiten, Stra�e gesperrt. Dauer: bis 15.09.2005, 17.00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 3041,10732 3093,10594
EOF
     },
     { from  => 1121378400, # 2005-07-15 00:00
       until => 1121637600, # 2005-07-18 00:00
       text  => 'Einfahrt in die Kastanienallee wegen Bauarbeiten gesperrt, 16.07.2005-17.07.2005',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 10881,15047 10838,14962 10723,14772
EOF
     },
     { from  => 1121732314, # 2005-07-19 02:18
       until => 1123452000, # 2005-08-08 00:00
       text  => 'Pappelallee (Prenzlauer Berg) in beiden Richtungen zwischen Raumerstr. und Sch�nhauser Allee Baustelle, Stra�e vollst�ndig gesperrt (bis 07.08.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 11119,15385 10881,15047
EOF
     },
     { from  => 1120341600, # 2005-07-03 00:00
       until => 1123538400, # 2005-08-09 00:00
       text  => 'B 109; (Prenzlauer Str.); OD Basdorf, Kno. Dimitroff-/Waldheimstr. Stra�en-,Geh- u.Radwegbau Vollsperrung 04.07.2005-08.08.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 12160,34668 12224,34508 12635,32221
EOF
     },
     { from  => 1122415200, # 2005-07-27 00:00
       until => 1123020000, # 2005-08-03 00:00
       text  => 'B 158; (Freienwalder Chaussee); OD Blumberg, zw. Kietz u. Elisenauer Ch. Deckenerneuerung Vollsperrung 28.07.2005-02.08.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 24735,22556 24951,22681
EOF
     },
     { from  => 1130018400, # 2005-10-23 00:00
       until => 1130277600, # 2005-10-26 00:00
       text  => 'L 23; OD Spreenhagen, Br�cke �ber Oder-Spree-Kanal Sanierung Br�cke Vollsperrung 24.10.2005-25.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 42349,-5620 42486,-5743 42769,-6313
EOF
     },
     { from  => 1120946400, # 2005-07-10 00:00
       until => 1123970400, # 2005-08-14 00:00
       text  => 'L 74; (Kastanienallee); OL Teupitz, Durchlass Ersatzneubau Vollsperrung 11.07.2005-13.08.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 25240,-29746 25412,-29762
userdel	q4 25412,-29762 25541,-29875
EOF
     },
     { from  => 1151745684, # 2006-07-01 11:21
       until => 1151877600, # 2006-07-03 00:00
       text  => 'Pichelsdorfer Stra�e, zwischen Kreuzung Wilhelmstra�e und Kreuzung Wei�enburger Str. gesperrt bis 02.07.2006 (Sommerfest Wilhelmstadt) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -3667,12919 -3693,13012 -3783,13261 -3824,13350
userdel	2 -3667,12919 -3658,12854 -3650,12762
EOF
     },
     { from  => 1121032800, # 2005-07-11 00:00
       until => 1123106400, # 2005-08-04 00:00
       text  => 'B 96; OD Rangsdorf, Kno. Kienitzer Str. Stra�enverbreiterung Vollsperrung 12.07.2005-03.08.2005 ',
       type  => 'handicap',
       data  => <<EOF,
	q4 14123,-11199 14327,-11767
EOF
     },
     { from  => 1120341600, # 2005-07-03 00:00
       until => 1128117600, # 2005-10-01 00:00
       text  => 'K 6301; (B�tzow-Wansdorf-Pausin); OD Wansdorf Kanal- und Stra�enbau Vollsperrung 04.07.2005-30.09.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -11509,25591 -11337,25571
EOF
     },
     { from  => 1121117010, # 2005-07-11 23:23
       until => 1128117600, # 2005-10-01 00:00
       text  => 'Behrenstr. (Mitte) Richtung Gendarmenmarkt zwischen Glinkastr. und Charlottenstr. Baustelle, Fahrtrichtung gesperrt (bis 30.09.2005)',
       type  => 'handicap',
       source_id => 'IM_002045',
       data  => <<EOF,
userdel	q4; 9164,12172 9373,12197 9496,12215
EOF
     },
     { from  => 1121551200, # 2005-07-17 00:00
       until => 1122674400, # 2005-07-30 00:00
       text  => 'L 235; (Gielsdorf-Werneuchen); OD Wegendorf, Schulstr. Ersatzneubau Durchlass Vollsperrung 18.07.2005-29.07.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 34492,22176 34321,22151
userdel	q4 34125,22128 34321,22151
EOF
     },
     { from  => 1122588000, # 2005-07-29 00:00
       until => 1122760800, # 2005-07-31 00:00
       text  => 'B 168; zw. Abzw. Mochlitz und LG in Ri. Friedland Stra�enbauarbeiten Vollsperrung 30.07.2005-30.07.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 72781,-41234 71792,-39389
EOF
     },
     { from  => 1122501600, # 2005-07-28 00:00
       until => 1123365600, # 2005-08-07 00:00
       text  => 'B 87; zw. Hohenwalde und M�llrose Munitionsbergung Vollsperrung 29.07.2005-06.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 81697,-12826 81362,-13667 81274,-13843
EOF
     },
     { from  => 1121896800, # 2005-07-21 00:00
       until => 1122588000, # 2005-07-29 00:00
       text  => 'K 7234; (Goethestr.); B� in Dabendorf, zw.Kastanienallee u. Brandenburger Str. Gleisbauarbeiten Vollsperrung 22.07.2005-28.07.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 13048,-18384 13282,-18250
userdel	2 14153,-17829 13282,-18250
EOF
     },
     { from  => 1121205600, # 2005-07-13 00:00
       until => 1121464800, # 2005-07-16 00:00
       text  => 'L 382; (Gronenfelder Weg); zw. FFO, Birnbaumsm�hle und Boo�ener Kreisel Gefahrenabwehr Vollsperrung 14.07.2005-15.07.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 85173,-3363 84649,-3081
EOF
     },
     { from  => 1121724000, # 2005-07-19 00:00
       until => 1128204000, # 2005-10-02 00:00
       text  => 'B 96; (Clara-Zetkin-Str.); OD Birkenwerder, zw. Weimarer Str. u. E.-M�hsam-Str. grundh. Stra�enausbau Vollsperrung 20.07.2005-01.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 1762,31318 1918,31279 1931,31275 2042,31236 2126,31207
EOF
     },
     { from  => 1121724000, # 2005-07-19 00:00
       until => 1133391600, # 2005-12-01 00:00
       text  => 'K 7207; (KG s�dl. Rinow-Wei�en); Br�cke bei Rinow Br�ckenbauarbeiten Vollsperrung 20.07.2005-30.11.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 2362,-64075 3737,-64262
EOF
     },
     { from  => 1121801694, # 2005-07-19 21:34
       until => 1123884000, # 2005-08-13 00:00
       text  => 'H�nower Str. (Mahlsdorf) in Richtung Alt-Mahlsdorf zwischen Wilhelmsm�hlenweg und Alt-Mahlsdorf Baustelle, Fahrtrichtung gesperrt (bis 12.08.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 24623,11684 24591,11587 24603,11450 24624,11374 24654,11265
EOF
     },
     { from  => 1121724000, # 2005-07-19 00:00
       until => 1122156000, # 2005-07-24 00:00
       text  => 'B 112; (Kupferhammerstr.); Bahn�bergang in OL Guben Gleisinstandhaltungsarb. Vollsperrung 20.07.2005-23.07.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 99825,-46697 99765,-46542 99702,-46376
EOF
     },
     { from  => 1152309600, # 2006-07-08 00:00
       until => 1152482400, # 2006-07-10 00:00
       text  => 'B 112 OL Guben, Bahn�bergang OL Guben, Bahn�bergang zw. OT Gr. Breesen u. Bresinchen Arbeiten Deutsche Bahn Vollsperrung 09.07.2006-09.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 99245,-43974 99228,-44346
EOF
     },
     { from  => 1121892756, # 2005-07-20 22:52
       until => 1123279200, # 2005-08-06 00:00
       text  => 'Rudower Str. (Treptow) Richtung stadteinw�rts zwischen K�penicker Str. und Wegedornstr. Baustelle, Fahrtrichtung gesperrt, Einbahnstra�e in Richtung K�penicker Str. (bis 05.08.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 19771,1793 19743,1804 19564,1871 19266,1968 19181,1996 19164,2001 19055,2037 18985,2047 18881,2062
EOF
     },
     { from  => 1122415200, # 2005-07-27 00:00
       until => 1123365600, # 2005-08-07 00:00
       text  => 'B 1; (K�striner Str.); OD Seelow Deckenerneuerung Vollsperrung 28.07.2005-06.08.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 76771,15413 77393,15654
EOF
     },
     { from  => 1123884000, # 2005-08-13 00:00
       until => 1124229600, # 2005-08-17 00:00
       text  => 'B 169; (Elsterwerdaer Str.); Bahn�bergang zw. B101 und OE Pr�sen Reparaturarbeiten Vollsperrung 14.08.2005-16.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 19076,-108365 19683,-108408
EOF
     },
     { from  => 1122058524, # 2005-07-22 20:55
       until => 1122238800, # 2005-07-24 23:00
       text  => 'Eisenacher Str. (Sch�neberg) in beiden Richtungen, zwischen Grunwaldstr. und Hauptstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 24.07.2005 23:00 Uhr)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 6735,9103 6769,8996
userdel	2 6735,9103 6709,9234
userdel	2 7009,8705 6860,8878
userdel	2 6769,8996 6860,8878
EOF
     },
     { from  => 1122156000, # 2005-07-24 00:00
       until => 1122588000, # 2005-07-29 00:00
       text  => 'L 15; (Rosa-Luxemburg-Str.); OD Wittstock Stra�enbauarbeiten Vollsperrung 25.07.2005-28.07.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -53868,82504 -53648,82294
EOF
     },
     { from  => 1122242400, # 2005-07-25 00:00
       until => 1122674400, # 2005-07-30 00:00
       text  => 'K 6509; (Liebenberg-B 96 Teschendorf); zw. Gr�neberg und B 96 grundh. Stra�enbau Vollsperrung 26.07.2005-29.07.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -6201,51305 -5813,51200
userdel	2 -5813,51200 -3453,51255
EOF
     },
     { from  => 1123106400, # 2005-08-04 00:00
       until => 1123452000, # 2005-08-08 00:00
       text  => 'B 169; von OD Kahla bis OE Elsterwerda Deckschichteinbau Vollsperrung 05.08.2005-07.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 23805,-103848 22428,-103909
EOF
     },
     { from  => 1122501600, # 2005-07-28 00:00
       until => 1122847200, # 2005-08-01 00:00
       text  => 'B 169; zw. Plessa und Kahla Deckschichteinbau Vollsperrung 29.07.2005-31.07.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 24971,-104007 26625,-104401
EOF
     },
     { from  => 1122501600, # 2005-07-28 00:00
       until => 1122674400, # 2005-07-30 00:00
       text  => 'L 338; (Neuenhagener Chaussee); Zuf. Flora-Gel�nde bei Sch�neiche Umbau Knotenpunkt Vollsperrung 29.07.2005-29.07.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 30415,10023 30557,10626
EOF
     },
     { from  => 1125180000, # 2005-08-28 00:00
       until => 1125439200, # 2005-08-31 00:00
       text  => 'B 112; (OU Neuzelle-OU Guben); Ber. Steinsdorf Vorwerk Bau Oder-Lausitz-Trasse Vollsperrung 29.08.2005-30.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 98777,-43381 98337,-41604
EOF
     },
     { from  => 1123103274, # 2005-08-03 23:07
       until => 1125525600, # 2005-09-01 00:00
       text  => 'B96, Ortsdurchfahrt Altl�dersdorf gesperrt bis 31.08.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -5146,69565 -5209,70040
userdel	q4 -5209,70040 -4978,71109
EOF
     },
     { from  => 1122933600, # 2005-08-02 00:00
       until => 1128117600, # 2005-10-01 00:00
       text  => 'K 6718; von OL Schernsdorf u. Kupferhammer in 3 Abschn. Stra�enbauarbeiten Vollsperrung 03.08.2005-30.09.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 83059,-23016 81501,-23378
EOF
     },
     { from  => 1123365600, # 2005-08-07 00:00
       until => 1134774000, # 2005-12-17 00:00
       text  => 'K 6917; (B246 Borkheide-Kanin); OD Borkwalde Stra�enbauarbeiten Vollsperrung 08.08.2005-16.12.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -26809,-18383 -27757,-17707
EOF
     },
     { from  => 1124748000, # 2005-08-23 00:00
       until => 1126389600, # 2005-09-11 00:00
       text  => 'L 793; (Alfred-K�hne-Str.); OD Ludwigsfelde, am OA in Ri. A 10 Einbau Anschlussgleis Vollsperrung 24.08.2005-10.09.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 2629,-10301 2580,-11069 2423,-11316 2001,-11983 1709,-12428
EOF
     },
     { from  => 1161627703, # 2006-10-23 20:21
       until => 1166648093, # 1175378399 2007-03-31 23:59
       text  => 'Swinem�nder Br�cke: Baustelle Stra�e f�r Autos vollst�ndig gesperrt, Radfahrer und Fu�g�nger k�nnen passieren (bis Ende 03.2007) ',
       type  => 'handicap',
       source_id => 'IM_002360',
       data  => <<EOF,
userdel	q2::inwork 9494,15998 9623,15777 9646,15737
EOF
     },
     { from  => 1124137069, # 2005-08-15 22:17
       until => 1126303200, # 2005-09-10 00:00
       text  => 'Lauenburger Str. (Steglitz) in beiden Richtungen zwischen Lothar-Bucher-Str. und Lauenburger Platz Baustelle, Stra�e vollst�ndig gesperrt (bis 09.09.2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 6014,6160 6019,6087 6008,6067
EOF
     },
     { from  => 1123970400, # 2005-08-14 00:00
       until => 1128117600, # 2005-10-01 00:00
       text  => 'B 179; (Spreewaldstr.); OD Zeesen, Kno. Karl-Liebknecht-Str. Stra�enausbau Vollsperrung 15.08.2005-30.09.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26583,-15677 26572,-15618 26612,-15094
EOF
     },
     { from  => 1122760800, # 2005-07-31 00:00
       until => 1124307438, # vorzeitig beendet 1125525600 2005-09-01 00:00
       text  => 'B 96; (Gransee-F�rstenberg); zw. Gransee und Altl�dersdorf grundh. Ausbau Vollsperrung 01.08.2005-31.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -5575,69050 -5703,68140
EOF
     },
     { from  => 1128290400, # 2005-10-03 00:00
       until => 1129413600, # 2005-10-16 00:00
       text  => 'L 171; (Hohen Neuendorf-Hennigsdorf); zw. Kreisverkehr bei Hennigsd. und AS Stolpe Stra�enbau Vollsperrung 04.10.2005-15.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -2446,25386 -2118,26060
EOF
     },
     { from  => 1124486293, # 2005-08-19 23:18
       until => 1124679600, # 2005-08-22 05:00
       text  => 'Kurf�rstendamm / Tauentzienstr. in beiden Richtungen zwischen Passauer Str. und Uhlandstr. Veranstaltung, Stra�e vollst�ndig gesperrt, einschlie�lich der Seitenstra�en (bis 22.08.2005 05:00 Uhr)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 5229,10716 5351,10760
userdel	2 5229,10716 5076,10658
userdel	2 5656,10876 5475,10808
userdel	2 5656,10876 5725,10892
userdel	2 5725,10892 5782,10884
userdel	2 5942,10803 6025,10746
userdel	2 5942,10803 5907,10821 5782,10884
userdel	2 6025,10746 6133,10679
userdel	2 5475,10808 5351,10760
userdel auto	3 5829,10964 5782,10884 5681,10696
userdel auto	3 5247,10992 5242,10918 5229,10716 5207,10399
userdel auto	3 5207,10399 5229,10716 5242,10918 5247,10992
userdel auto	3 5471,10719 5475,10808 5488,10978
userdel auto	3 5877,10486 6025,10746 6131,10939 6145,10975
userdel auto	3 5488,10978 5475,10808 5471,10719
userdel auto	3 5681,10696 5782,10884 5829,10964
userdel auto	3 6145,10975 6131,10939 6025,10746 5877,10486
EOF
     },
     { from  => 1124575200, # 2005-08-21 00:00
       until => 1146261599, # 28.04.2006, was: 1139094000 2006-02-05 00:00
       text  => 'B 101; (Herzberg-J�terbog); Br�cke �ber Kremnitzbach u. �ber Rad-u.Gehweg bei Bernsdorf Br�ckenbau Vollsperrung 22.08.2005-28.04.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -1307,-73252 -1245,-72696
EOF
     },
     { from  => 1124486820, # 2005-08-19 23:27
       until => 1125698400, # 2005-09-03 00:00
       text  => 'Luckauer Str. (Kreuzberg) in beiden Richtungen zwischen Oranienstr. und Waldemarstr. Baustelle, Stra�e vollst�ndig gesperrt (bis02.09.2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 11150,11030 11110,10946
userdel	2 11110,10946 11049,10816
EOF
     },
     { from  => 1124742735, # 2005-08-22 22:32
       until => 1127512800, # 2005-09-24 00:00
       text  => 'Buschallee (Wei�ensee) in Richtung Berliner Allee zwischen Elsastr. und Hansastr. Baustelle, Fahrtrichtung gesperrt (bis 23.09.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 15918,16383 15871,16399 15845,16405 15432,16500
EOF
     },
     { from  => 1124575200, # 2005-08-21 00:00
       until => 1125871200, # 2005-09-05 00:00
       text  => 'K 7237; (L 40 Klein Kienitz-Rangsdorf); zw. S�dringcenter Rangsdorf u. Klein Kienitz Stra�enbauarbeiten Vollsperrung 22.08.2005-04.09.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26583,-15677 26572,-15618 26612,-15094
userdel	2 14327,-11767 15962,-10958
EOF
     },
     { from  => 1125612000, # 2005-09-02 00:00
       until => 1125784800, # 2005-09-04 00:00
       text  => 'B 167; (Frankfurter Str.); OD Seelow, zw. Breite Str. u. Berliner Str. Stadtfest Vollsperrung 03.09.2005-03.09.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 76771,15413 76986,14860
EOF
     },
     { from  => 1125698400, # 2005-09-03 00:00
       until => 1126044000, # 2005-09-07 00:00
       text  => 'K 6422; (Eggersdorfer Str.); OL Petershagen, unbeschrankter Bahn�bergang Instandsetzungsarb. Vollsperrung 04.09.2005-06.09.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 35900,13643 36654,13977
EOF
     },
     { from  => 1124920800, # 2005-08-25 00:00
       until => 1125093600, # 2005-08-27 00:00
       text  => 'K 6907; zw. Ferch und L 90 Glindow Dreharbeiten Vollsperrung 26.08.2005-26.08.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -22803,-9880 -23295,-9711
EOF
     },
     { from  => 1125350749, # 2005-08-29 23:25
       until => 1129413600, # 2005-10-16 00:00
       text  => 'Glienicker Stra�e zwischen Gr�nauer Stra�e und Nipkowstra�e Richtung Adlergestell wegen Bauarbeiten gesperrt bis 15.10.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 21823,4210 21679,4059 21496,3849 21489,3841 21411,3760 21357,3705 21324,3691 21308,3644 21275,3607 21244,3571 21198,3522 21153,3484 21055,3415 20967,3343 20927,3292 20832,3170
EOF
     },
     { from  => 1125351382, # 2005-08-29 23:36
       until => 1125698400, # 2005-09-03 00:00
       text  => 'F�hre Cauth K 6910 Stra�e der Einheit bis 02.09.2005 au�er Betrieb ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -17728,-6975 -17643,-7028
EOF
     },
     { from  => 1125460800, # 2005-08-31 06:00
       until => 1125864000, # 2005-09-04 22:00
       text  => 'Weitlingstra�e zwischen Sophienstra�e und Frankfurter Allee in beiden Richtungen gesperrt, Veranstaltung, Dauer: 01.09.2005. 06.00 Uhr bis 04.09.2005, 22.00 Uhr ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 16653,11251 16730,11480 16759,11582 16766,11603 16786,11668
userdel	q4 16958,11778 16815,11729
userdel	q4 16815,11729 16786,11668
EOF
     },
     { from  => 1174341828, # 2007-03-19 23:03
       until => 1174604400, # 2007-03-23 00:00
       text  => 'Florastr. (Pankow) in beiden Richtungen, zwischen Berliner Str. und M�hlenstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 22.03.07)',
       type  => 'gesperrt',
       source_id => 'IM_005006',
       data  => <<EOF,
userdel	2 10459,17754 10548,17817 10705,17931 10830,17985
EOF
     },
     { from  => 1127508095, # 2005-09-23 22:41
       until => 1136069999, # 2005-12-31 23:59
       text  => 'Wegedornstra�e (Adlershof) Richtung Rudow, zwischen Rudower Chaussee und Ernst-Ruska-Ufer Baustelle, Fahrtrichtung gesperrt (bis Ende 2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 18929,2454 18941,2609 18934,2703
EOF
     },
     { from  => 1125957600, # 2005-09-06 00:00
       until => 1131750000, # 2005-11-12 00:00
       text  => 'B 102; zw. Kampehl und B 5, B�ckwitz Bau Kreisverkehrsplatz Vollsperrung 07.09.2005-11.11.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -53139,50022 -54295,49682
EOF
     },
     { from  => 1126648800, # 2005-09-14 00:00
       until => 1134601627, # aufgehoben, was 1204326000 2008-03-01 00:00
       text  => 'B 103; (Kyritzer Chaussee); OD Pritzwalk, zw. Fritz-Reuter-Str. u. Havelberger Str. Bau OU B189n halbseitig gesperrt; Einbahnstra�e 15.09.2005-29.02.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -74489,80545 -74038,78181
EOF
     },
     { from  => 1127772000, # 2005-09-27 00:00
       until => 1128031200, # 2005-09-30 00:00
       text  => 'B 112; (Beeskower Str.); OD Eisenh�ttenstadt Asphaltarbeiten halbseitig gesperrt; Einbahnstra�e 28.09.2005-29.09.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 94350,-26678 94796,-26727
EOF
     },
     { from  => 1128290400, # 2005-10-03 00:00
       until => 1129413600, # 2005-10-16 00:00
       text  => 'B 112; (Guben-Eisenh�ttenstadt); OD Neuzelle Deckenerneurung Vollsperrung 04.10.2005-15.10.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 96492,-34347 95945,-34062
EOF
     },
     { from  => 1132873200, # 2005-11-25 00:00
       until => 1135292400, # 2005-12-23 00:00
       text  => 'B 166 Zichow-Gramzow OD Gramzow Kanal- und Stra�enbau Vollsperrung 26.11.2005-22.12.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 50107,89717 49930,89857
EOF
     },
     { from  => 1126994400, # 2005-09-18 00:00
       until => 1130191200, # 2005-10-25 00:00
       text  => 'B 179; (Karl-Liebknecht-Str.); OD Zeesen, zw. Spreewaldstr. u. Weidendamm Stra�enausbau Vollsperrung 19.09.2005-24.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26473,-14543 26567,-14915 26612,-15094
EOF
     },
     { from  => 1126994400, # 2005-09-18 00:00
       until => 1128722400, # 2005-10-08 00:00
       text  => 'B 188; westl. Rathenow, zw. Kreisel u. Abzw. Gro�wudicke Stra�enanbindung B188n Vollsperrung 19.09.2005-07.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -67681,19301 -67871,19214
EOF
     },
     { from  => 1126648800, # 2005-09-14 00:00
       until => 1142463600, # 2006-03-16 00:00
       text  => 'B 198 G�nterberg-Gramzow bei Schmiedeberg, Br�cke �ber M�hlengraben Br�ckenersatzneubau Vollsperrung 15.09.2005-15.03.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 46661,82722 46743,82844 47081,83093
userdel	2 47081,83093 47089,83300 47137,83456
EOF
     },
     { from  => 1128808800, # 2005-10-09 00:00
       until => 1130623200, # 2005-10-30 00:00
       text  => 'B 198; zw. Prenzlau und Bietikow grundh.Stra�enbau Vollsperrung 10.10.2005-29.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 42775,98487 43126,98186
EOF
     },
     { from  => 1122156000, # 2005-07-24 00:00
       until => 1127599200, # 2005-09-25 00:00
       text  => 'B 273; (Potsdamer Str.); OD Bornim, zw. Amundsenstr. u. Lindstedter Weg Kanalarbeiten halbseitig gesperrt; Einbahnstra�e 25.07.2005-24.09.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -15501,795 -15533,813 -15938,1003 -16026,1044 -16640,1304
EOF
     },
     { from  => 1126994400, # 2005-09-18 00:00
       until => 1128204000, # 2005-10-02 00:00
       text  => 'B 87; OD Mittweide Stra�enbauarbeiten Vollsperrung 19.09.2005-01.10.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 60430,-38587 62112,-36752
EOF
     },
     { from  => 1130364000, # 2005-10-27 00:00
       until => 1130886000, # 2005-11-02 00:00
       text  => 'B 96; (Neuhof-W�nsdorf); Bahn�bergang in OL Neuhof Gleisbauarbeiten Vollsperrung 28.10.2005-01.11.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 16407,-29400 16379,-29446
EOF
     },
     { from  => 1126389600, # 2005-09-11 00:00
       until => 1136070000, # 2006-01-01 00:00
       text  => 'K 6424; (Dahlwitzer Landstr.-M�nchehofe-B 1); OD M�nchehofe Stra�enausbau Vollsperrung 12.09.2005-31.12.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 28619,9588 26851,9005
EOF
     },
     { from  => 1127772000, # 2005-09-27 00:00
       until => 1128031200, # 2005-09-30 00:00
       text  => 'K 7226; zw. Neuhof und Sperenberg Stra�enbauarbeiten Vollsperrung 28.09.2005-29.09.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 12690,-30392 14671,-30092
EOF
     },
     { from  => 1125525600, # 2005-09-01 00:00
       until => 1130799600, # 2005-11-01 00:00
       text  => 'L 19; (Zechlinerh�tte-Wesenberg (MVP)); zw. Abzw. Klein Zerlang u. LG (n�. Prebelowbr�cke) Ersatzneubau Br�cke Prebelow Vollsperrung 02.09.2005-31.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -26403,85177 -26316,84900
EOF
     },
     { from  => 1126562400, # 2005-09-13 00:00
       until => 1128117600, # 2005-10-01 00:00
       text  => 'L 201; (Nauener Chaussee); OD Falkensee, zw. F.-Ludwig-Jahn-Str. u. Innstr. Stra�enbauarbeiten halbseitig gesperrt; Einbahnstra�e 14.09.2005-30.09.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -12601,19517 -12161,19075
EOF
     },
     { from  => 1126994400, # 2005-09-18 00:00
       until => 1134687600, # 2005-12-16 00:00
       text  => 'L 22; (Oranienburger Str.); OD Gransee grundh. Stra�enbau Vollsperrung 19.09.2005-15.12.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -7696,66033 -7851,66418
userdel	q4 -7873,66589 -7851,66418
EOF
     },
     { from  => 1128290400, # 2005-10-03 00:00
       until => 1129932000, # 2005-10-22 00:00
       text  => 'L 39; (Kolberg-Friedersdorf); OD Blossin, Haupstr. Stra�enbauarbeiten Vollsperrung 04.10.2005-21.10.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 37885,-16100 37888,-15635
EOF
     },
     { from  => 1129068000, # 2005-10-12 00:00
       until => 1129240800, # 2005-10-14 00:00
       text  => 'L 513; (Ringchaussee); Krz. Burg Kolonie/ Naundorf Deckenerneuerung Vollsperrung 13.10.2005-13.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 59792,-61720 60404,-61710
EOF
     },
     { from  => 1129240800, # 2005-10-14 00:00
       until => 1129413600, # 2005-10-16 00:00
       text  => 'L 541; (Suschow-Burg Kolonie); Krz. Burg Kolonie/ Naundorf Deckenerneuerung Vollsperrung 15.10.2005-15.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 59792,-61720 60404,-61710
EOF
     },
     { from  => 1125871200, # 2005-09-05 00:00
       until => 1133391600, # 2005-12-01 00:00
       text  => 'L 75; (Karl-Marx-Str.); OD Gro�ziethen Stra�enbauarbeiten Vollsperrung 06.09.2005-30.11.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 13225,-681 13215,-570 13176,-161 13165,-34 13124,216 12984,1011
EOF
     },
     { from  => 1128290400, # 2005-10-03 00:00
       until => 1132095600, # 2005-11-16 00:00
       text  => 'B 112; zw. Abzw. Ziltendorf und Abzw. Pohlitz Deckenerneurung Vollsperrung 04.10.2005-15.11.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 93494,-21221 93192,-21578
EOF
     },
     { from  => 1127772000, # 2005-09-27 00:00
       until => 1151704800, # 2006-07-01 00:00
       text  => 'L 382; (Birnbaumsm�hle); OD Frankfurt (O), Bereich unter den Br�cken DB grundh. Stra�enbau Vollsperrung 28.09.2005-30.06.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 85403,-4497 85622,-3937
EOF
     },
     { from  => 1128117600, # 2005-10-01 00:00
       until => 1128398400, # 2005-10-04 06:00
       text  => 'Ebertstra�e, Pariser Platz: Veranstaltung, Stra�e gesperrt bis Di 06:00 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8577,11896 8595,12066
userdel	2 8577,11896 8571,11846
userdel	2 8595,12066 8600,12165
userdel	2 8546,12279 8538,12245
userdel	2 8546,12279 8570,12302 8573,12325
userdel	2 8540,12420 8573,12325
userdel	2 8600,12165 8538,12245
userdel	2 8538,12245 8610,12254
EOF
     },
     { from  => 1128808800, # 2005-10-09 00:00
       until => 1131404400, # 2005-11-08 00:00
       text  => 'B 87; (Beeskow-L�bben); zw. Abzw. Wittmannsdorf und Abzw. Dollgen Stra�enbauarbeiten Vollsperrung 10.10.2005-07.11.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 58111,-41188 60430,-38587
EOF
     },
     { from  => 1128290400, # 2005-10-03 00:00
       until => 1128981600, # 2005-10-11 00:00
       text  => 'B 87; (Beeskow-L�bben); zw. Trebatsch und Abzw. Wittmannsdorf Stra�enbauarbeiten Vollsperrung 04.10.2005-10.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 62112,-36752 60430,-38587
EOF
     },
     { from  => 1128808800, # 2005-10-09 00:00
       until => 1131836400, # 2005-11-13 00:00
       text  => 'B 198; OD Prenzlau, Dr.-Wilhelm-K�lz-Str. grundh. Stra�enbau Vollsperrung 10.10.2005-12.11.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 39715,101866 39574,101863 39451,101893 39322,101924
EOF
     },
     { from  => 1128376800, # 2005-10-04 00:00
       until => 1128722400, # 2005-10-08 00:00
       text  => 'B 273; zw. Kremmen und Schwante Stra�enbauarbeiten Vollsperrung 05.10.2005-07.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -14038,37008 -13513,36825 -12791,36632
EOF
     },
     { from  => 1128549600, # 2005-10-06 00:00
       until => 1128895200, # 2005-10-10 00:00
       text  => 'B 87; zw. Schlieben und Kolochau Deckeneinbau Vollsperrung 07.10.2005-09.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 7711,-74770 8300,-74790
EOF
     },
     { from  => 1120341600, # 2005-07-03 00:00
       until => 1130018400, # 2005-10-23 00:00
       text  => 'K 6301; (B�tzow-Wansdorf-Pausin); OD Wansdorf Kanal- und Stra�enbau Vollsperrung 04.07.2005-22.10.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -11337,25571 -11509,25591
EOF
     },
     { from  => 1126562400, # 2005-09-13 00:00
       until => 1130709600, # 2005-10-30 23:00
       text  => 'L 201; (Nauener Chaussee); OD Falkensee, zw. F.-Ludwig-Jahn-Str. u. Innstr. Stra�enbauarbeiten halbseitig gesperrt; Einbahnstra�e 14.09.2005-30.10.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -12601,19517 -12161,19075
EOF
     },
     { from  => 1128549600, # 2005-10-06 00:00
       until => 1128808800, # 2005-10-09 00:00
       text  => 'L 96; (B 1 Neubensdorf-Rathenow); zw. Milow und B�tzer Stra�enbauarbeiten Vollsperrung 07.10.2005-08.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -64341,12416 -64162,11951
EOF
     },
     { from  => 1128808800, # 2005-10-09 00:00
       until => 1129500000, # 2005-10-17 00:00
       text  => 'B 2; (Bernau-Biesenthal); B 2, OD R�dnitz, Kreisverkehr grundh. Ausbau, Bau Kreisverk. Vollsperrung 10.10.2005-16.10.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 25069,35558 25007,35418 24930,35363
EOF
     },
     { from  => 1128988800, # 2005-10-11 02:00
       until => 1129298400, # 2005-10-14 16:00
       text  => 'Drakestra�e zwischen Hans-Sachs-Stra�e und Knesebeckstra�e in beiden Richtungen Br�ckenabriss, Stra�e gesperrt, Dauer: 12.10.2005 02:00 Uhr bis 14.10.2005 16:00 Uhr',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 3259,4002 3228,4046 3214,4066 3151,4160 3142,4173
EOF
     },
     { from  => 1128808800, # 2005-10-09 00:00
       until => 1134774000, # 2005-12-17 00:00
       text  => 'K 7228; (Zossener Allee); OL Sperenberg Stra�enbau Vollsperrung 10.10.2005-16.12.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 8576,-29378 8647,-26861
EOF
     },
     { from  => 1128754834, # 2005-10-08 09:00 (by polizeifax und Tagesspiegel)
       until => 1130104800, # 2005-10-24 00:00
       text  => 'Ehrlichstr. (Lichtenberg) zwischen Wildensteiner Str. und Treskowallee Baustelle, gesperrt (bis 23.10.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 18151,8589 18228,8537 18322,8470 18391,8425 18461,8377 18528,8331 18615,8269 18676,8236
EOF
     },
     { from  => undef, # 
       until => 1128891600, # 2005-10-09 23:00
       text  => 'Hermannstra�e zwischen Flughafenstra�e und Thomasstra�e Veranstaltung, Stra�e gesperrt bis So 23:00 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 12090,7651 12081,7679 12075,7696
userdel	2 12090,7651 12122,7553
userdel	2 12180,7387 12158,7449 12122,7553
userdel	2 11920,8252 11931,8206 11933,8198
userdel	2 11920,8252 11898,8362
userdel	2 12041,7788 12055,7751
userdel	2 12041,7788 12025,7852
userdel	2 12001,7937 12025,7852
userdel	2 12001,7937 11979,8014
userdel	2 11979,8014 11963,8074
userdel	2 11933,8198 11963,8074
userdel	2 12055,7751 12075,7696
EOF
     },
     { from  => 1128985496, # 2005-10-11 01:04
       until => 1130104800, # 2005-10-24 00:00
       text  => 'Josef-Orlopp-Str. (Lichtenberg) in Richtung Storkower Str. zwischen Siegfriedstr. und Vulkanstr. Fahrbahnerneuerung, Fahrtrichtung gesperrt (bis 23.10.2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 16863,13138 16426,13145 15912,13153
EOF
     },
     { from  => 1128899379, # 2005-10-10 01:09 (by Tagesspiegel)
       until => 1131667773, # 2005-11-11 01:09
       text  => 'Prenzlauer Berg: Richtung Prenzlauer Allee gesperrt (Kopfsteinpflaster wird durch Asphalt ersetzt)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 11706,13635 11545,13690 11250,13655
EOF
     },
     { from  => undef, # 
       until => 1129413599, # 2005-10-15 23:59
       text  => 'Mahlsdorfer Str. (K�penick) Richtung K�penick, zwischen Hultischiner Damm und Genovevastr. Baustelle, Fahrtrichtung gesperrt (bis 15.10.)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 23792,7861 23764,7815 23701,7772 23223,7493 23145,7429 23066,7355
EOF
     },
     { from  => 1129327200, # 2005-10-15 00:00
       until => 1129759200, # 2005-10-20 00:00
       text  => 'L 15; (B109-Boitzenburg); zw. Abzw. Klein Sperrenwalde u. OL Gollmitz, Prenzlauer Str. Stra�enbauarbeiten Vollsperrung 16.10.2005-19.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 31946,98379 30789,99365
EOF
     },
     { from  => 1128981600, # 2005-10-11 00:00
       until => 1129413600, # 2005-10-16 00:00
       text  => 'L 165; (Manker-Garz); bei Garz, Bereich Br�cke �ber Temnitz Asphaltsanierung Vollsperrung 12.10.2005-15.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -43343,47590 -42999,47684
EOF
     },
     { from  => 1129413600, # 2005-10-16 00:00
       until => 1131145200, # 2005-11-05 00:00
       text  => 'L 70; (Sperenberg-Trebbin); zw. Abzw.Chrisinend. u. Abzw.Kl.Schulzend.Ber.Br�cke B101n Stra�en- und Br�ckenbau Vollsperrung 17.10.2005-04.11.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 1740,-23380 1079,-23181
EOF
     },
     { from  => 1128967200, # 2005-10-10 20:00
       until => 1143227474, # 1143756000 2006-03-31 00:00
       text  => 'Rosenthaler Stra�e zwischen Hackescher Markt und Neue Sch�nhauser Stra�e Baustelle, als Einbahnstra�e eingerichtet in Richtung Rosenthaler Platz, Dauer: 11.10.2005, 20.00 Uhr bis 30.03.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 10310,13227 10264,13097
EOF
     },
     { from  => 1119996000, # 2005-06-29 00:00
       until => 1133391600, # 2005-12-01 00:00
       text  => 'L 401; (Lindenallee); OD Zeuthen, zw. OE und An der Eisenbahn grundhafter Stra�enbau Vollsperrung 30.06.2005-30.11.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 26790,-7918 26700,-7334 26609,-7136
EOF
     },
     { from  => undef, # 
       until => 1168462241, # 2010-12-31 23:59 1293836399
       text  => 'Universit�tsstr., Richtung Dorotheenstr. gesperrt (bis 2010) ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 9601,12380 9580,12581
EOF
     },
     { from  => undef, # 
       until => 1168462241, # 2010-12-31 23:59 1293836399
       text  => 'Universit�tsstr., Richtung Dorotheenstr. gesperrt (bis 2010)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 9568,12688 9580,12581
EOF
     },
     { from  => 1129413600, # 2005-10-16 00:00
       until => 1132959600, # 2005-11-26 00:00
       text  => 'B 109; (Zehdenick-Templin); zw. Hammelspring und Hindenburg Stra�en-, Durchlass- u.Radweg. Vollsperrung 17.10.2005-25.11.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 12311,76014 11771,74993
EOF
     },
     { from  => 1129705762, # 2005-10-19 09:09
       until => 1130191200, # 2005-10-25 00:00
       text  => 'Zeltinger Str. Richtung Oranienburger Chaussee zwischen Zernsdorfer Weg und Zeltinger Platz Stra�enarbeiten, Fahrtrichtung gesperrt (bis 24.10.2005)',
       type  => 'gesperrt',
       source_id => 'IM_002297',
       data  => <<EOF,
userdel	1 2446,25265 2510,25350 2531,25368 2657,25486 2721,25576
EOF
     },
     { from  => 1129879314, # 2005-10-21 09:21
       until => 1130623200, # 2005-10-30 00:00
       text  => 'Scheidemannstr. Richtung Ebertstr. von Entlastungsstr. bis Ebertstr. Veranstaltung, Fahrtrichtung gesperrt (bis 29.10.2005)',
       type  => 'handicap',
       source_id => 'IM_002305',
       data  => <<EOF,
userdel	q4 8119,12414 8354,12416
userdel	q4 8400,12417 8540,12420
userdel	q4 8400,12417 8354,12416
EOF
     },
     { from  => 1129878000, # 2005-10-21 09:00
       until => 1129996800, # 2005-10-22 18:00
       text  => 'Stadtgebiet Potsdam: auf Grund einer Bombenentsch�rfung sind folgende Strassen innerhalb folgender Begrenzung gesperrt: Am Kanal -- Kurf�rstenstr. -- Berliner Strasse -- Friedrich-Ebert-Str., Dauer: 22.10.2005 09:00 Uhr bis 18:00 Uhr, ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -12306,-496 -12262,-612
userdel	2 -12529,-789 -12515,-889 -12512,-911 -12575,-1031
userdel	2 -12529,-789 -12219,-726
userdel	2 -12529,-789 -12677,-823
userdel	2 -12045,-757 -12168,-965
userdel	2 -12168,-965 -12248,-1107
userdel	2 -12168,-965 -12100,-962
userdel	2 -11910,-945 -12100,-962
userdel	2 -12285,-1174 -12248,-1107
userdel	2 -12285,-1174 -12359,-1096 -12488,-999
userdel	2 -12488,-999 -12553,-1025
userdel	2 -12262,-612 -12223,-713 -12219,-726
userdel	2 -12262,-612 -12545,-698
userdel	2 -12575,-1031 -12774,-1065
userdel	2 -12575,-1031 -12553,-1025
userdel	2 -12553,-1025 -12552,-1096 -12552,-1233 -12549,-1277
userdel	2 -12078,-1068 -12070,-1153
userdel	2 -12078,-1068 -11960,-1041
userdel	2 -12078,-1068 -12248,-1107
userdel	2 -12078,-1068 -12100,-962
userdel	2 -12774,-1065 -12801,-960
userdel	2 -12571,-581 -12545,-698
userdel	2 -12219,-726
userdel	2 -12801,-960 -12823,-857
userdel	2 -12545,-698 -12697,-729
userdel	2 -12677,-823 -12823,-857
userdel	2 -12697,-729 -12884,-769
userdel	2 -12719,-630 -12697,-729
userdel	2 -12823,-857 -12886,-869
userdel	2 -12718,-1327 -12741,-1197 -12756,-1131 -12774,-1065
EOF
     },
     { from  => 1130277600, # 2005-10-26 00:00
       until => 1130972400, # 2005-11-03 00:00
       text  => 'B 112; (Karl-Marx-Str.); OD Eisenh�ttenstadt Deckenerneuerung Vollsperrung 27.10.2005-02.11.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 94863,-27943 94983,-28457
EOF
     },
     { from  => 1130277600, # 2005-10-26 00:00
       until => 1130972400, # 2005-11-03 00:00
       text  => 'B 112; zw. Lawitz und Eisenh�ttenstadt Deckenerneuerung Vollsperrung 27.10.2005-02.11.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 95829,-31753 95494,-29935
EOF
     },
     { from  => 1130536800, # 2005-10-29 00:00
       until => 1130972400, # 2005-11-03 00:00
       text  => 'B 246; (Bauptstr.); Bahn�bergang in OL Bestensee Gleisbauarbeiten Vollsperrung 30.10.2005-02.11.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26639,-17861 26706,-17867
userdel	2 26832,-17882 26718,-17867 26706,-17867
EOF
     },
     { from  => 1130277600, # 2005-10-26 00:00
       until => 1134774000, # 2005-12-17 00:00
       text  => 'L 15; (B109 s�dl. Prenzlau-Boitzenburg); OD Gollmitz Leitungsverlegung Vollsperrung 27.10.2005-16.12.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 30789,99365 30482,99609
EOF
     },
     { from  => 1130450400, # 2005-10-28 00:00
       until => 1130972400, # 2005-11-03 00:00
       text  => 'L 402; (Forstweg); Bahn�bergang in OL Zeuthen Gleisbauarbeiten Vollsperrung 29.10.2005-02.11.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26001,-6257 26057,-6241 26146,-6218
EOF
     },
     { from  => 1130715720, # 2005-10-31 00:42
       until => 1132354800, # 2005-11-19 00:00
       text  => 'Naumannstra�e zwischen Torgauer Str. und Kolonnenstra�e in Richtung Kolonnenstra�e wegen Bauarbeiten gesperrt bis 18.11.2005 ',
       type  => 'handicap',
       source_id => 'LMS_1129024102795',
       data  => <<EOF,
userdel	q4; 7713,8600 7709,8777
userdel	q4; 7710,8051 7715,8308 7716,8356
EOF
     },
     { from  => 1130792769, # 2005-10-31 22:06
       until => 1131231600, # 2005-11-06 00:00
       text  => 'Br�ckensperrung zwischen Seehausen und Potzlow Die Br�cke ist ab dem 5.9.2005 bis zum 5.11.2005 auch f�r Radfahrer nicht passierbar ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 40230,90006 40583,90157 40865,90202 40938,90213
EOF
     },
     { from  => 1130831377, # 2005-11-01 08:49
       until => 1132354800, # 2005-11-19 00:00
       text  => 'Eldenaer Str. zwischen Thaerstr. und Proskauer Str. Baustelle, wegen Bauarbeiten gesperrt. Dauer: bis 18.11.2005',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 14355,12752
userdel	q4 13960,12866 13979,12861 14066,12836 14096,12827
userdel	q4 13960,12866 13844,12900
EOF
     },
     { from  => 1131050267, # 2005-11-03 21:37
       until => 1132095599, # 2005-11-15 23:59
       text  => 'Romain-Rolland-Stra�e (Weissensee) zwischen Stra�e 16 und Berliner Stra�e Stra�enarbeiten, gesperrt (bis Mitte November 2005) ',
       type  => 'handicap',
       source_id => 'IM_002329',
       data  => <<EOF,
userdel	q4 13300,17726 13245,17737 13125,17758 13031,17775 12908,17807 12856,17825
userdel	q4 12856,17825 12825,17870 12736,17998
EOF
     },
     { from  => undef, # 
       until => 1144438894, # Time::Local::timelocal(reverse(2006,7-1,31,0,0,0)) 2006-07-31 00:00
       text  => 'K�thener Br�cke in beiden Richtungen Baustelle, Stra�e vollst�ndig gesperrt (bis Mitte 2006)',
       type  => 'gesperrt',
       source_id => 'INKO_81917',
       data  => <<EOF,
userdel	2 8443,10777 8430,10710
EOF
     },
     { from  => 1131534000, # 2005-11-09 12:00
       until => 1131793200, # 2005-11-12 12:00
       text  => 'Behrenstra�e, zwischen Kreuzung Ebertstra�e und Kreuzung Glinkastra�e in beiden Richtungen Veranstaltung, Stra�e gesperrt, Dauer: 10.11.2005 12:00 Uhr bis 12.11.2005 12:00 Uhr ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 8861,12125 9054,12154 9064,12156
userdel	q4 8861,12125 8743,12099 8737,12098
userdel	q4 8595,12066 8737,12098
userdel	q4 9164,12172 9064,12156
EOF
     },
     { from  => undef, # 
       until => 1149803999, # 2006-06-08 23:59
       text  => 'Siemensstr. (Treptow-K�penick) in Richtung Nalepastr. zwischen Edisonstr. Einbahnstra�e in Richtung Nalepastr. (bis 08.06.) (17:00) ',
       type  => 'gesperrt',
       source_id => 'IM_002866',
       data  => <<EOF,
userdel	q4; 17766,6616 17860,6644 17962,6674
EOF
     },
     { from  => 1132097451, # 2005-11-16 00:30
       until => 1142397192, # 1146434400 2006-05-01 00:00
       text  => 'Stahnsdorf, Lindenstra�e, Baustelle bis 30.04.2006, Der Verkehr wird an der Baustelle durch eine Lichtzeichenanlage halbseitig vorbeigef�hrt. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 -1668,-1709 -1715,-1767 -1921,-1931 -2049,-2165
EOF
     },
     { from  => 1353798000, # 2012-11-25 00:00 # 1321743600, # 2011-11-20 00:00 # PERIODISCH!
       until => 1357513199, # 2013-01-06 23:59 # 1325458800, # 2012-01-02 00:00 # PERIODISCH!
       text  => 'Weihnachtsmarkt an der Ged�chtniskirche, vom 26. November 2012 bis 06. Januar 2013',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/orte/weihnachtsmaerkte/weihnachtsmarkt-gedaechtniskirche/index.php?y=2012',
       data  => <<EOF,
# sowieso schon mit q4 markiert, deshalb -> 2
userdel	2::temp 5829,10964 5782,10884
userdel	2::temp 5656,10876 5652,11004
EOF
     },
     { from  => 1132606608, # 2005-11-21 21:56
       until => 1143842399, # 2006-03-31 23:59
       text  => 'Pistoriusstr. (Pankow) Richtung Wei�ensee, zwischen Hamburger Platz und Roelckestr. Baustelle, Fahrtrichtung gesperrt (bis 03/2006)',
       type  => 'gesperrt',
       source_id => 'INKO_77722',
       data  => <<EOF,
userdel	1 12713,16682 12857,16627 13104,16522
EOF
     },
     { from  => 1138319651, # 2006-01-27 00:54
       until => 1149199199, # 2006-06-01 23:59
       text  => 'Siemensstr. (Treptow) Richtung Edisonstr. zwischen Wilhelminenhofstr. und Edisonstr. Baustelle, Fahrtrichtung gesperrt (bis Anfang 06.2006)',
       type  => 'gesperrt',
       source_id => 'IM_002441',
       data  => <<EOF,
userdel	1 17614,6571 17766,6616 17860,6644 17962,6674
EOF
     },
     { from  => 1130799600, # 2005-11-01 00:00
       until => 1134601200, # 2005-12-15 00:00
       text  => 'B 2 (Angerm�nde-OU Pinnow) OD Dobberzin grundh. Stra�enbau Vollsperrung 02.11.2005-14.12.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 52044,69176 52738,69563
userdel	q4 52044,69176 50891,68557
EOF
     },
     { from  => 1136502000, # 2006-01-06 00:00
       until => 1136847600, # 2006-01-10 00:00
       text  => 'B 96 Neuhof-W�nsdorf Bahn�bergang in OL Neuhof Gleisbauarbeiten Vollsperrung; Umleitung 07.01.2006-09.01.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 16360,-29489 16379,-29446
EOF
     },
     { from  => 1134082800, # 2005-12-09 00:00
       until => 1134428400, # 2005-12-13 00:00
       text  => 'B 96 Neuhof-W�nsdorf Bahn�bergang in OL Neuhof Gleisbauarbeiten Vollsperrung; Umleitung 10.12.2005-12.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 16360,-29489 16379,-29446
EOF
     },
     { from  => 1136847600, # 2006-01-10 00:00
       until => 1137020400, # 2006-01-12 00:00
       text  => 'B 96 Neuhof-W�nsdorf Bahn�bergang in OL Neuhof Gleisbauarbeiten Vollsperrung; Umleitung 11.01.2006-11.01.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 16360,-29489 16379,-29446
EOF
     },
     { from  => 1135033200, # 2005-12-20 00:00
       until => 1135292400, # 2005-12-23 00:00
       text  => 'B 96 Neuhof-W�nsdorf Bahn�bergang in OL Neuhof Gleisbauarbeiten Vollsperrung; Umleitung 21.12.2005-22.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 16360,-29489 16379,-29446
EOF
     },
     { from  => 1078095600, # 2004-03-01 00:00
       until => 1136070000, # 2006-01-01 00:00
       text  => 'B 167 (Herzberg-Neuruppin) OL Alt Ruppin, Rhinbr�cke Br�ckenneubau Vollsperrung 02.03.2004-31.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -28866,59954 -28641,59609 -28477,59467
EOF
     },
     { from  => 1067986800, # 2003-11-05 00:00
       until => 1149026400, # 2006-05-31 00:00
       text  => 'B 169 OU Senftenberg Bau Ortsumfahrung Vollsperrung 06.11.2003-30.05.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 54286,-96624 54755,-96239
userdel	q4 54755,-96239
EOF
     },
     { from  => 1129413600, # 2005-10-16 00:00
       until => 1135983600, # 2005-12-31 00:00
       text  => 'B 198 Greiffenberger Str. OD Kerkow grundhafter Stra�enbau Vollsperrung * 17.10.2005-30.12.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 48929,70947 48982,71121 48996,71176
EOF
     },
     { from  => 1127599200, # 2005-09-25 00:00
       until => 1135378800, # 2005-12-24 00:00
       text  => 'K 6419 zw. Rehfelde, R.-Luxemburg-Str. u. OE Strausberg Stra�en-,Geh- u. Radwegbau Vollsperrung 26.09.2005-23.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 42578,15750 42300,15756
EOF
     },
     { from  => 1131490800, # 2005-11-09 00:00
       until => 1135378800, # 2005-12-24 00:00
       text  => 'K 6753 von OL Braunsdorf bis OL Markgrafpieske grundhafter Ausbau Vollsp. 10.11.2005-23.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 47692,-6364 47767,-6214
userdel	2 47692,-6364 47514,-6402
userdel	2 48136,-5051 48131,-4175
userdel	2 48136,-5051 47885,-5561
userdel	2 47885,-5561 47794,-6060
userdel	2 47514,-6402 47354,-6584
userdel	2 47767,-6214 47794,-6060
EOF
     },
     { from  => 1135983600, # 2005-12-31 00:00
       until => 1143842400, # 2006-04-01 00:00
       text  => 'K 6950 Gohlitzstr. OL Lehnin, zw. Belziger Str. u. Lindenstr. Stra�enbau; Herst.Umleit.stre. Vollsperrung 11.10.2005-31.03.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -34655,-11263 -34337,-11047
userdel	q4 -34232,-10832 -34337,-11047
EOF
     },
     { from  => 1131836400, # 2005-11-13 00:00
       until => 1135378800, # 2005-12-24 00:00
       text  => 'K 7220 Luckenwalde-Lieb�tz zw. Ruhlsdorf und Lieb�tz Stra�en- und Radwegbau Vollsperrung 14.11.2005-23.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -4686,-30955 -4311,-30322
userdel	2 -3607,-29164 -3733,-29501
userdel	2 -4031,-30164 -3733,-29501
userdel	2 -4031,-30164 -4311,-30322
EOF
     },
     { from  => 1133218800, # 2005-11-29 00:00
       until => 1135292400, # 2005-12-23 00:00
       text  => 'L 15 F�rstenberg-Menz OD F�rstenberg, Rheinsberger Str. grundhafter Stra�enbau Vollsperrung; Umleitung 30.11.2005-22.12.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -8775,85947 -8893,85743
userdel	q4 -8893,85743 -9850,84800
EOF
     },
     { from  => 1133650800, # 2005-12-04 00:00
       until => 1133996400, # 2005-12-08 00:00
       text  => 'L 16 Bahn�bergang bei Siedlung Sch�nwalde Gleisbauarbeiten Vollsperrung 05.12.2005-07.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -10559,23255 -10737,23418
EOF
     },
     { from  => 1134082800, # 2005-12-09 00:00
       until => 1134342000, # 2005-12-12 00:00
       text  => 'L 16 Bahn�bergang bei Siedlung Sch�nwalde Gleisbauarbeiten Vollsperrung 10.12.2005-11.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -10559,23255 -10737,23418
EOF
     },
     { from  => 1130713200, # 2005-10-31 00:00
       until => 1134687600, # 2005-12-16 00:00
       text  => 'L 23 T�pferstr. OD Joachimsthal, Kno. Angerm�nder Str. Ausbau Kreisverkehrsplatz Vollsperrung 01.11.2005-15.12.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 33080,63939 33206,63582 33254,63446
EOF
     },
     { from  => 1133823600, # 2005-12-06 00:00
       until => 1134082800, # 2005-12-09 00:00
       text  => 'L 74 Chausseestr. Eisenbahnbr�cke in der OD W�nsdorf Br�ckenbauarbeiten Vollsperrung; Umleitung 07.12.2005-08.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15682,-26971 15229,-27157
userdel	2 15682,-26971 15960,-26906
EOF
     },
     { from  => 1134169200, # 2005-12-10 00:00
       until => 1134601200, # 2005-12-15 00:00
       text  => 'L 201 Nauener Chaussee Bahn�begang bei Falkensee Gleisbauarbeiten Vollsperrung 11.12.2005-14.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -13897,20621 -13875,20548 -13756,20176
EOF
     },
     { from  => 1133996400, # 2005-12-08 00:00
       until => 1134255600, # 2005-12-11 00:00
       text  => 'L 201 Nauener Chaussee Bahn�bergang bei Falkensee Gleisbauarbeiten Vollsperrung 09.12.2005-10.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -13897,20621 -13875,20548 -13756,20176
EOF
     },
     { from  => 1131231600, # 2005-11-06 00:00
       until => 1157061600, # 2006-09-01 00:00
       text  => 'L 202 Wustermark-Brieselang Br�cke �ber Havelkanal bei Zeestow Br�ckenneubau Vollsperrung 07.11.2005-31.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -19908,17940 -18793,18169
EOF
     },
     { from  => 1356044400, # 2012-12-21 00:00 # 1354356000, # 1324076400, # 2011-11-26 11:00, PERIODISCH! an allen Adventssamstagen
       until => 1356217199, # 2012-12-22 23:59 # 1354390200, # 1324150200, # 2011-11-26 20:30, PERIODISCH! an allen Adventssamstagen
       text  => 'Lichtenrader Weihnachtsmarkt: Bahnhofstr. (Lichtenrade) in beiden Richtungen zwischen Steinstr. und Goltzstr gesperrt (alle Adventssamstage von 11:00 bis 20:30) ',
       type  => 'gesperrt',
       source_id => 'http://www.weihnachtsmarkt-deutschland.de/weihnachtsmarkt-berlin-lichtenrade.html?y=2012',
       data  => <<EOF,
userdel	q4 10310,-2136 10453,-2133 10509,-2131 10631,-2130 10747,-2129 10983,-2116
EOF
     },
     { from  => 1134255600, # 2005-12-11 00:00
       until => 1137776400, # 2006-01-20 18:00
       text  => 'Tietzenweg zwischen Margaretenstra�e und Unter den Eichen, Baustelle, Stra�e gesperrt. Dauer: 12.12.2005 bis 20.01.2006,18.00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 3501,4435 3425,4541
EOF
     },
     { from  => 1134428400, # 2005-12-13 00:00
       until => 1134774000, # 2005-12-17 00:00
       text  => 'B 167 Eisenbahn- u. Heegerm�hler Str. OD Eberswalde, Eisenbahnbr�cke Ersatzneubau Br�cke Vollsperrung; Umleitung 14.12.2005-16.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 36937,48074 36750,48064 36581,48125 36406,48181
EOF
     },
     { from  => 1136242800, # 2006-01-03 00:00
       until => 1136588400, # 2006-01-07 00:00
       text  => 'L 074 Chausseestr. Eisenbahnbr�cke in der OD W�nsdorf Br�ckenbauarbeiten Vollsperrung; Umleitung 04.01.2006-06.01.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15682,-26971 15960,-26906
EOF
     },
     { from  => 1138143600, # 2006-01-25 00:00
       until => 1138402800, # 2006-01-28 00:00
       text  => 'L 074 Chausseestr. Eisenbahnbr�cke in der OD W�nsdorf Br�ckenbauarbeiten Vollsperrung 26.01.2006-27.01.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15682,-26971 15960,-26906
EOF
     },
     { from  => 1130799600, # 2005-11-01 00:00
       until => 1151704800, # 2006-07-01 00:00
       text  => 'B 122 Schlo�str. OD Rheinsberg, zw. K�nigstr. und Lange Str. Kanalarbeiten halbseitige Sperrung; 02.11.2005-30.06.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -25801,76494 -25728,76368 -25728,76256
EOF
     },
     { from  => 1134702000, # 2005-12-16 04:00
       until => 1135105200, # 2005-12-20 20:00
       text  => 'S�ntisstra�e zwischen Daimlerstra�e und Nahmitzer Damm Bahn�bergang gesperrt bzw. halbseitig gesperrt, Dauer: 17.12.05 04:00 Uhr bis 20.12.05 20:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9024,906 9129,986 9165,1014 9241,1073
EOF
     },
     { from  => 1136070000, # 2006-01-01 00:00
       until => 1138057200, # 2006-01-24 00:00
       text  => 'B 179 Cottbuser-/ Fichtestr. OL K�nigs Wusterhausen, Bahn�bergang Fichtestr. Umbau Bahn�bergang Vollsperrung 02.01.2006-23.01.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26313,-13049 26205,-12769 26138,-12596 26028,-12312
EOF
     },
     { from  => 1134860400, # 2005-12-18 00:00
       until => 1135206000, # 2005-12-22 00:00
       text  => 'L 030 Karl-Marx-Str. OD Niederlehme, Autobahnbr�cke A 10 Br�ckenneubau Vollsperrung; Umleitung 19.12.2005-21.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 27535,-10033 27485,-10246
EOF
     },
     { from  => 1137088800, # 2006-01-12 19:00
       until => 1137301200, # 2006-01-15 06:00
       text  => 'Bellevuestra�e, Presseball, Stra�e in beide Richtungen gesperrt, Dauer: 13.01.2006 19:00 Uhr bis 15.01.2006 06:00 Uhr ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 8442,11555 8209,11671 8203,11686
EOF
     },
     { from  => 1137548634, # 2006-01-18 02:43
       until => 1148759509, # 1149112799 2006-05-31 23:59
       text  => 'Vo�str. (Mitte) in Richtung Wilhelmstr. zwischen Ebertstr. und Gertrud-Kolmar-Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 05.2006)',
       type  => 'handicap',
       source_id => 'IM_002419',
       data  => <<EOF,
userdel	q4; 8553,11638 8743,11663 8837,11676
EOF
     },
     { from  => 1137279600, # 2006-01-15 00:00
       until => 1142636400, # 2006-03-18 00:00
       text  => 'L 088 Bahnhofstr. OD Lehnin, H�he Marktplatz Umgestaltung Marktplatz Vollsperrung 16.01.2006-17.03.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -34063,-10552 -34488,-10578
EOF
     },
     { from  => undef, # 
       until => 1152221087, # undef
       text  => 'Pistoriusstr. (Wei�ensee) in Richtung Mirbachplatz zwischen Berliner Allee und Parkstr. Baustelle, Fahrtrichtung gesperrt',
       type  => 'handicap',
       source_id => 'IM_002437',
       data  => <<EOF,
userdel	q4; 14045,16120 13788,16240
EOF
     },
     { from  => 1138319443, # 2006-01-27 00:50
       until => 1141167599, # 2006-02-28 23:59
       text  => 'Rosa-Luxemburg-Str. (Mitte) in Richtung Memhardtstr. zwischen Karl-Liebknecht-Str. und Memhardtstr. Baustelle, Fahrtrichtung gesperrt, eine Umleitung ist eingerichtet (bis Ende Februar 2006)',
       type  => 'handicap',
       source_id => 'INKO_75621',
       data  => <<EOF,
userdel	q4; 10706,13043 10755,13152
EOF
     },
     { from  => 1138402800, # 2006-01-28 00:00
       until => 1138575600, # 2006-01-30 00:00
       text  => 'B 096 a Br�cke �ber DB AG zw. Glasower Str. u. Wa�mannsdorfer Ch. Br�ckenneubau Vollsperrung * 29.01.2006-29.01.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
	2 13237,-4511 13677,-4801
EOF
     },
     { from  => 1141340400, # 2006-03-03 00:00
       until => 1141599600, # 2006-03-06 00:00
       text  => 'B 096 Neuhof-W�nsdorf Bahn�bergang in OL Neuhof Gleisbauarbeiten Vollsperrung; Umleitung 04.03.2006-05.03.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 16407,-29400 16379,-29446
userdel	2 16360,-29489 16379,-29446
EOF
     },
     { from  => 1144015200, # 2006-04-03 00:00
       until => 1150668000, # 2006-06-19 00:00
       text  => 'B 112 Guben-Frankfurt (O) Kreuz. L 45/B 112/K6702 in Steinsdorf Bau der Kreuzung Vollsperrung 04.04.2006-18.06.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	2 91858,-18170 90615,-16871
EOF
     },
     { from  => undef, # 
       until => 1139428054, #
       text  => 'Elsenstr. (Kaulsdorf) in beiden Richtungen zwischen Kressenweg und Hornungsweg Wasser auf der Fahrbahn, Stra�e vollst�ndig gesperrt ',
       type  => 'gesperrt',
       source_id => 'LMS_1138607956237',
       data  => <<EOF,
userdel	2 23575,10972 23792,10926
EOF
     },
     { from  => 1150092737, # 2006-06-12 08:12
       until => 1150737175, # 1167605999 2006-12-31 23:59, jetzt nur noch "Engstellensignalisierung"
       text  => 'Schlichtallee (Rummelsburg) in Richtung Nord, auf der s�dlichen Bahnbr�cke Baustelle; Fahrtrichtung gesperrt (bis Ende 12/2006) ',
       type  => 'handicap',
       source_id => 'IM_002885',
       data  => <<EOF,
userdel	q4; 15639,10469 15758,10578 15982,10765 16003,10797 16032,10842
EOF
     },
     { from  => undef, # 
       until => 1139470769, #
       text  => 'Berlin-L�bars: Am Freibad in beiden Richtungen Wasser auf der Fahrbahn, gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 5727,23485 5297,23633
EOF
     },
     { from  => undef, # 
       until => 1140727101, #
       text  => 'Tempelhofer Weg (Tempelhof) von Gottlieb-Dunkel-Str. bis Hattenheimer Str. Baustelle, Fahrtrichtung gesperrt',
       type  => 'handicap',
       source_id => 'IM_002431',
       data  => <<EOF,
userdel	q4; 11456,6103 11590,6026
EOF
     },
     { from  => 1140303600, # 2006-02-19 00:00
       until => 1164927600, # 2006-12-01 00:00
       text  => 'B 096 Gransee-F�rstenberg Br�cke �ber Wentowkanal bei Dannenwalde Br�ckenabri�- u. -neubau Vollsperrung 20.02.2006-30.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -5962,74421 -6037,73865
EOF
     },
     { from  => 1140994800, # 2006-02-27 00:00
       until => 1141426800, # 2006-03-04 00:00
       text  => 'B 122 Alt Ruppin-Dierberg Bahn�bergang bei Dierberg Gleisbauarbeiten Vollsperrrung 28.02.2006-03.03.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -22477,67059 -21066,67757
userdel	2 -21066,67757 -20469,68007
EOF
     },
     { from  => 1139871600, # 2006-02-14 00:00
       until => 1141426800, # 2006-03-04 00:00
       text  => 'B 179 Berliner Str. OL K�nigs Wusterhausen, zw. Schlo�platz u. Gartenweg Havarie SW-Schacht Vollsperrung 15.02.2006-03.03.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 25859,-11559 25640,-11357
EOF
     },
     { from  => undef, # 
       until => 1140120150, #
       text  => 'S�ntisstra�e zwischen Daimlerstra�e und Albanstra�e St�rung am Bahn�bergang, Stra�e gesperrt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8971,864 9024,906
userdel	2 9241,1073 9165,1014 9129,986 9024,906
EOF
     },
     { from  => 1140303600, # 2006-02-19 00:00
       until => 1153807245, # 2006-08-05 00:00 1154728800
       text  => 'B 246 Trebbin-Beelitz OD L�wendorf, zw. Ahrensdorfer Str. u. Schillerstr. Stra�en- und Kanalbau Vollsperrung 20.02.2006-04.08.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -2643,-21212 -2815,-20920
EOF
     },
     { from  => 1140509431, # 2006-02-21 09:10
       until => 1140560993, # expired ... 2006-03-11 00:00
       text  => 'Peschkestra�e zwischen Rheinstra�e und Holsteinische Stra�e wegen Tiefbauarbeiten bis voraussichtlich 10.03.06 gesperrt. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 5533,6517 5424,6584
EOF
     },
     { from  => 1140908400, # 2006-02-26 00:00
       until => 1156716000, # 2006-08-28 00:00
       text  => 'L 029 Eberswalder Chaussee OD Oderberg, von Berliner Str. in Ri. Eberswalde Beseit. Tragf�higkeitssch�den Vollsperrung 27.02.2006-27.08.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 52671,51846 51496,51542
EOF
     },
     { from  => 1141499777, # 1141426800 2006-03-04 00:00
       until => 1141499852, # 1142031600 2006-03-11 00:00
       text  => 'L 401 Richard-Sorge-Str./ Bergstr. OL Wildau, Bahn�bergang Bergstr. Gleisbauarbeiten Einm�nd. gesp. 05.03.2006-10.03.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26432,-10043 26285,-10054 26262,-10015 26262,-9880 26174,-9760 26093,-9701 25991,-9671 25805,-9553
EOF
     },
     { from  => 1141254000, # 2006-03-02 00:00
       until => 1141686000, # 2006-03-07 00:00
       text  => 'L 090 Ph�bener Str. Bahn�bergang in OL Werder Gleisbauarbeiten Vollsperrung; Umleitung 03.03.2006-06.03.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -22206,-1693 -22146,-1832 -22042,-2060
EOF
     },
     { from  => 1142118000, # 2006-03-12 00:00
       until => 1144965600, # 2006-04-14 00:00
       text  => 'B 101 Trebbiner Str. OL Luckenwalde, zw. Beelitzer Str. u. Potsdamer Str. Anschlu� Gewerbehof Vollsperrung; Umleitung 13.03.2006-13.04.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -4299,-35198 -4204,-35072
EOF
     },
     { from  => 1142809200, # 2006-03-20 00:00
       until => 1144187940, # 2006-04-04 23:59
       text  => 'L 070 Sperenberg-Trebbin zw. Abzw.Chrisinend. u. Abzw.Kl.Schulzend.Ber.Br�cke B101n Br�ckenbau Vollsperrung 21.03.2006-04.04.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 1740,-23380 1079,-23181
EOF
     },
     { from  => 1141561135, # 2006-03-05 13:18
       until => 1168462192, # 2007-10-31 23:59 1193871599
       text  => 'Die Kaulsdorfer Br�cke ist ab Montag 06.03.2006, 6.00 Uhr bis voraussichtlich Herbst 2007 gesperrt.',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 22688,12007 22684,12016 22669,12049
userdel	2::inwork 22669,12049 22693,12084
EOF
     },
     { from  => 1141765672, # 2006-03-07 22:07
       until => 1150408799, # 2006-06-15 23:59
       text  => 'Niedstr. (Friedenau) in beiden Richtungen zwischen Lauterstr. und Handjerystr. Baustelle Stra�e vollst�ndig gesperrt (bis Mitte 06.2006)',
       type  => 'gesperrt',
       source_id => 'IM_002505',
       data  => <<EOF,
userdel	2 5810,7337 5641,7332
EOF
     },
     { from  => 1141765814, # 2006-03-07 22:10
       until => 1150408799, # 2006-06-15 23:59
       text  => 'Niedstr. (Friedenau) von Handjerystr. bis Friedrich-Wilhelmplatz Einbahnstr. (bis Mitte 06.2006)',
       type  => 'gesperrt',
       source_id => 'IM_002505',
       data  => <<EOF,
userdel	1 5364,7330 5641,7332
EOF
     },
     { from  => 1142118000, # 2006-03-12 00:00
       until => 1142632779, # 1157061600 2006-09-01 00:00
       text  => 'L 745 Motzen-B246 Gallun zw. OA Motzen und OE Gallun Stra�enbauarbeiten Vollsperrung 13.03.2006-31.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 22476,-19219 22338,-19081
userdel	2 22476,-19219 22599,-19785
userdel	2 22324,-18950 22338,-19081
userdel	2 23356,-20982 22928,-20347 22599,-19785
EOF
     },
     { from  => 1161627812, # 2006-10-23 20:23
       until => 1175458876, # Time::Local::timelocal(reverse(2007-1900,7-1,1,0,0,0)),
       text  => 'Wiesbadener Str. (Wilmersdorf) Richtung Bundesallee zwischen Geisenheimer Str. und S�dwestkorso Baustelle, Fahrtrichtung gesperrt (bis Mitte 2007)',
       type  => 'gesperrt',
       source_id => 'IM_003889',
       data  => <<EOF,
userdel	q4::inwork; 4391,7258 4571,7239 4743,7212
userdel	q4::inwork; 4530,7021 4462,7137 4391,7258
EOF
     },
     { from  => 1143068400, # 2006-03-23 00:00
       until => 1149120177, # 1151704800 2006-07-01 00:00
       text  => 'K 7219 Z�lichendorf-Dobbrikow OD Nettgendorf, zw. OE und Klinkenm�hler Str. Kanal- und Stra�enbau Vollsperrung 24.03.2006-30.06.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -12904,-28790 -12925,-29046
userdel	q4 -12904,-28790 -12713,-28704
EOF
     },
     { from  => 1146002400, # 2006-04-26 00:00
       until => 1147471200, # 2006-05-13 00:00
       text  => 'B 087 Beeskow-L�bben OD Ranzig Stra�enbauarbeiten Vollsperrung 27.04.2006-12.05.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 64853,-30986 65386,-29479
EOF
     },
     { from  => undef, # 
       until => 1148166908, # nur noch Fahrstreifeneinschr�nkung...
       text  => 'B�tzowstr. (Prenzlauer Berg) in beiden Richtungen, zwischen Danziger Str. und Hufelandstr. Baustelle, Stra�e vollst�ndig gesperrt',
       type  => 'handicap',
       source_id => 'IM_002530',
       data  => <<EOF,
userdel	q4 12423,14066 12486,14143
userdel	q4 12423,14066 12361,13985
userdel	q4 12556,14230 12621,14313
userdel	q4 12556,14230 12486,14143
EOF
     },
     { from  => 1142632575, # 2006-03-17 22:56
       until => 1142895600, # 2006-03-21 00:00
       text  => 'Charlottenstr. (Mitte) in Richtung Unter den Linden zwischen Mittelstr. und Unter den Linden Baustelle, Stra�e vollst�ndig gesperrt (bis 20.03.2006)',
       type  => 'handicap',
       source_id => 'IM_002531',
       data  => <<EOF,
userdel	q4; 9462,12481 9475,12365
EOF
     },
     { from  => 1143410400, # 2006-03-27 00:00
       until => 1143842400, # 2006-04-01 00:00
       text  => 'B 122 Alt Ruppin-Dierberg Bahn�bergang bei Dierberg Gleisbauarbeiten Vollsperrrung 28.03.2006-31.03.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -28116,60092 -27347,60616
EOF
     },
     { from  => 1146434400, # 2006-05-01 00:00
       until => 1146607200, # 2006-05-03 00:00
       text  => 'L 074 Chausseestra�e OL W�nsdorf, Bahnbr�cke Br�ckenbauarbeiten Vollsperrung 02.05.2006-02.05.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15682,-26971 15229,-27157
userdel	2 15682,-26971 15960,-26906
EOF
     },
     { from  => 1143583200, # 2006-03-29 00:00
       until => 1143756000, # 2006-03-31 00:00
       text  => 'L 074 Chausseestra�e OL W�nsdorf, Bahnbr�cke Br�ckenbauarbeiten Vollsperrung 30.03.2006-30.03.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15682,-26971 15229,-27157
userdel	2 15682,-26971 15960,-26906
EOF
     },
     { from  => 1143154477, # 2006-03-23 23:54
       until => 1143227432, # 1155679200 2006-08-16 00:00
       text  => 'F�rstenwalder Damm in beiden Richtungen zwischen Dahlwitzer Landstra�e und M�ggelseedamm (West) beidseitig Baustelle, gesperrt bis 15.08.2006',
       type  => 'handicap',
       source_id => 'LMS_1142967727545',
       data  => <<EOF,
userdel	q4 25012,5754 24871,5699 24700,5633 24471,5544 24366,5504 24285,5472 24162,5424 24049,5380 23950,5342
userdel	q4 25012,5754 25018,5756 25121,5799
userdel	q4 25579,5958 25179,5819 25121,5799
EOF
     },
     { from  => 1146520800, # 2006-05-02 00:00
       until => 1146693600, # 2006-05-04 00:00
       text  => 'B 096 OD Neuhof B� Neuhof Gleisbau Vollsperrung 03.05.2006-03.05.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 16407,-29400 16379,-29446
userdel	2 16360,-29489 16379,-29446
EOF
     },
     { from  => 1146693600, # 2006-05-04 00:00
       until => 1147471200, # 2006-05-13 00:00
       text  => 'B 096 OD Neuhof B� Neuhof Gleisbau Vollsperrung 05.05.2006-12.05.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 16407,-29400 16379,-29446
userdel	2 16360,-29489 16379,-29446
EOF
     },
     { from  => 1144262992, # 1144965600 2006-04-14 00:00
       until => 1144263001, # Cancelled 1145138400 2006-04-16 00:00
       text  => 'B 096 OD Neuhof B� Neuhof Gleisbau Vollsperrung 15.04.2006-15.04.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 16407,-29400 16379,-29446
userdel	2 16360,-29489 16379,-29446
EOF
     },
     { from  => 1142895600, # 2006-03-21 00:00
       until => 1149112800, # 2006-06-01 00:00
       text  => 'B 198 OD Kerkow Greiffenbg.Str. Kerkow Neubau Stra�e Vollsperrung 22.03.2006-31.05.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 48929,70947 48982,71121 48996,71176
EOF
     },
     { from  => 1143575024, # 2006-03-28 21:43
       until => 1143820800, # 2006-03-31 18:00
       text  => 'Hirtenstr. Arbeiten an Wasserleitungen, Stra�e in beiden Richtungen gesperrt. (zwischen Rosa-Luxemburg-Str. und Kleine Alexanderstr.) bis 31.03.06, 18:00 Uhr ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 10846,13362 10925,13322
EOF
     },
     { from  => undef, # 
       until => 1144438933, #
       text  => 'Zoppoter Str. (Wilmersdorf) in beiden Richtungen zwischen Heiligendammer Str. und Breitestr. Tiefbauarbeiten, Stra�e vollst�ndig gesperrt',
       type  => 'handicap',
       source_id => 'IM_002552',
       data  => <<EOF,
userdel	q4 3346,7369 3314,7269
EOF
     },
     { from  => 1143928800, # 2006-04-02 00:00
       until => 1147471200, # 2006-05-13 00:00
       text  => 'B 087 OL Ranzig Deckenerneuerung Vollsperrung 03.04.2006-12.05.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 63609,-34428 64853,-30986
EOF
     },
     { from  => 1143324000, # 2006-03-25 23:00
       until => 1144263353, # 1152914400 2006-07-15 00:00
       text  => 'L 019 Kremmen, Schlo�damm, Ruppiner Str. Kremmen Neubau Fahrbahn Vollsperrung 27.03.2006-14.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -15344,43220 -15262,42754
userdel	2 -14917,42525 -15262,42754
EOF
     },
     { from  => 1143928800, # 2006-04-02 00:00
       until => 1157148000, # 2006-09-02 00:00
       text  => 'B 198 Dr. Wilhelm K�lz Str. Stra�enbau Vollsperrung 03.04.2006-01.09.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 39322,101924 39451,101893 39574,101863
userdel	q4::inwork 39715,101866 39574,101863
EOF
     },
     { from  => 1142377200, # 2006-03-15 00:00
       until => 1151704800, # 2006-07-01 00:00
       text  => 'B 198 bei Schmiedeberg Neubau Br�cke Vollsperrung 16.03.2006-30.06.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 46661,82722 46743,82844 47081,83093
EOF
     },
     { from  => 1133046000, # 2005-11-27 00:00
       until => 1151704800, # 2006-07-01 00:00
       text  => 'K 6422 Ernst-Th�lmann-Str. OL Fredersdorf, Kno.. Bollensdorfer Allee u. Kno. Flie�str. Errichtung Lichtsignalanlage Vollsperrung 28.11.2005-30.06.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 34139,13113 33644,12458
EOF
     },
     { from  => 1143410400, # 2006-03-27 00:00
       until => 1159653600, # 2006-10-01 00:00
       text  => 'L 220 OD Joachimsthal Bau Kreisverkehr Vollsperrung 28.03.2006-30.09.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 33787,63026 33254,63446
EOF
     },
     { from  => 1144792800, # 2006-04-12 00:00
       until => 1147298400, # 2006-05-11 00:00
       text  => 'L 745 Motzen- Gallun zw. OA Motzen und OE Gallun Stra�enbau Vollsperrung 13.04.2006-10.05.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 22476,-19219 22338,-19081
userdel	2::inwork 22476,-19219 22599,-19785
EOF
     },
     { from  => 1144015200, # 2006-04-03 00:00
       until => 1148162400, # 2006-05-21 00:00
       text  => 'B 112 Steinsdorf, Einm�ndung L45/B112 Herstellung Anbindung L45 Vollsperrung 04.04.2006-20.05.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 98052,-40791 98091,-41089
EOF
     },
     { from  => 1144176662, # 2006-04-04 20:51
       until => 1144263062, # 2006-04-05 20:51
       text  => '<leer>', # intentionally not empty string, because the check_bbbike_temp_blockings script does not like it
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 16407,-29400 16379,-29446
userdel	2 16360,-29489 16379,-29446
EOF
     },
     { from  => 1144015200, # 2006-04-03 00:00
       until => 1151704800, # 2006-07-01 00:00
       text  => 'K 6419 zw. Rehfelde, R.-Luxemburg-Str. u. OE Strausberg Stra�en-,Geh- u. Radwegbau Vollsperrung 04.04.2006-30.06.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 42996,14793 42578,15750
userdel	2::inwork 42578,15750 42300,15756
userdel	2::inwork 41681,15915 42300,15756
EOF
     },
     { from  => 1143324000, # 2006-03-25 23:00
       until => 1152914400, # 2006-07-15 00:00
       text  => 'L 019 Schlo�damm, Ruppiner Str. OD Kremmen grundhafter Stra�enbau Vollsperrung 27.03.2006-14.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -15961,38892 -16160,38503
EOF
     },
     { from  => 1163800186, # 2006-11-17 22:49
       until => 1164151926, # 2006-11-30 23:59 1164927599, falsche Koordinaten!
       text  => 'Zossener Damm (Blankenfelde) Ortsdurchfahrt Blankenfelde in beiden Richtungen Baustelle, Stra�e vollst�ndig gesperrt, eine Umleitung ist eingerichtet (bis Ende 11.2006)',
       type  => 'handicap',
       source_id => 'IM_003887',
       data  => <<EOF,
userdel	q4 13225,-681 13215,-570 13176,-161 13165,-34 13124,216 12984,1011
EOF
     },
     { from  => 1143928800, # 2006-04-02 00:00
       until => 1155938400, # 2006-08-19 00:00
       text  => 'L 077 Lindenstr. OD Stahnsdorf, zw. Streuobsthang u. Ruhlsdorfer Str. Geh- und Radwegbau halbseitig gesperrt; Einbahnstra�e 03.04.2006-18.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 -2049,-2165 -1921,-1931 -1715,-1767
EOF
     },
     { from  => 1144706400, # 2006-04-11 00:00
       until => 1145829600, # 2006-04-24 00:00
       text  => 'L 079 Ludwigsfelde-Ahrensdorf zw. Ludwigsfelde und Ahrensdorf Stra�enbauarbeiten Vollsperrung 12.04.2006-23.04.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -2086,-9891 -1245,-9999
EOF
     },
     { from  => 1145570400, # 2006-04-21 00:00
       until => 1145916000, # 2006-04-25 00:00
       text  => 'B 001 zw. Abzw. Hennickendorf und Tasdorf Deckeneinbau Vollsperrung 22.04.2006-24.04.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 36874,10046 37154,10022
userdel	2 37154,10022 37670,9871
EOF
     },
     { from  => 1144274400, # 2006-04-06 00:00
       until => 1144620000, # 2006-04-10 00:00
       text  => 'B 112 Ziltendorf-Brieskow Finkenheerd OD Wiesenau Stra�enbauarbeiten Vollsperrung; Umleitung 07.04.2006-09.04.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 91858,-18170 90615,-16871
EOF
     },
     { from  => 1145743200, # 2006-04-23 00:00
       until => 1146261600, # 2006-04-29 00:00
       text  => 'L 216 Gollin-Templin OD Vietmannsdorf, Br�cke �ber M�hlengraben Einbau Decke Vollsperrung 24.04.2006-28.04.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 17470,72358 17625,72041
EOF
     },
     { from  => 1144438665, # 2006-04-07 21:37
       until => 1146434400, # 2006-05-01 00:00
       text  => 'Br�cke �ber den Nordgraben (Reinickendorf) in beiden Richtungen, in H�he Schorfheidestr. Baustelle, Stra�e vollst�ndig gesperrt (bis 30.04.06)',
       type  => 'gesperrt',
       source_id => 'INKO_82299',
       data  => <<EOF,
userdel	2 6281,20369 6275,20412 6267,20476
EOF
     },
     { from  => 1144438729, # 2006-04-07 21:38
       until => 1144706400, # 2006-04-11 00:00
       text  => 'Charlottenstr. (Mitte) in beiden Richtungen, in H�he Mittelstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 10.04.06)',
       type  => 'gesperrt',
       source_id => 'IM_002607',
       data  => <<EOF,
userdel	2 9454,12558 9462,12481
userdel	2 9475,12365 9462,12481
EOF
     },
     { from  => 1144438828, # 2006-04-07 21:40
       until => 1151704800, # 2006-07-01 00:00
       text  => 'Roelckestr. (Weissensee) in beiden Richtungen zwischen Charlottenburger Str. und Pistoriusstr. Baustelle, Stra�e bis 30.06.2006 vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_002598',
       data  => <<EOF,
userdel	2 13104,16522 13033,16387
EOF
     },
     { from  => 1144339200, # 2006-04-06 18:00
       until => 1148745600, # 2006-05-27 18:00
       text  => 'Herzbergstra�e, zwischen Siegfriedstra�e und Vulkanstra�e gesperrt, die Gegenrichtung ist als Einbahnstra�e ausgeschildert, Stra�e am Wasserwerk, zwischen Herzbergstra�e und Landsberger Allee gesperrt, Baustelle. Dauer: 07.04.2006 , 18:00 Uhr bis 27.05.2006, 18:00 Uhr. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 16866,13532 16629,13532 15896,13547
EOF
     },
     { from  => 1144483509, # 2006-04-08 10:05
       until => 1144706400, # 2006-04-11 00:00
       text  => 'M�llendorffstr. (Lichtenberg) in Richtung S�den, zwischen Am Containerbahnhof und Frankfurter Allee Baustelle, Stra�e vollst�ndig gesperrt, Radweg wom�glich noch nutzbar (bis 10.04.06)',
       type  => 'handicap',
       source_id => 'IM_002605',
       data  => <<EOF,
userdel	q4; 15361,12071
EOF
     },
     { from  => 1305237600, # undef, # 
       until => 1305496800, # 1144619999, # 2006-04-09 23:59
       text  => 'Scharnweberstr. (Reinickendorf) in beiden Richtungen zwischen Eichborndamm und Hechelstr. Stra�enfest, Stra�e vollst�ndig gesperrt (14. und 15. Mai 2011)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 4392,17777 4429,17763 4584,17704
userdel	q4::temp 4392,17777 4326,17801
userdel	q4::temp 4584,17704 4683,17669
userdel	q4::temp 4326,17801 4200,17848 4096,17890 4015,17912
EOF
     },
     { from  => 1144706400, # 2006-04-11 00:00
       until => 1147298400, # 2006-05-11 00:00
       text  => 'B 096 Hauptstr. OD Baruth Einbau Spundw�nde Vollsperrung 12.04.2006-10.05.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 18433,-38781 18272,-39512 18138,-39957
EOF
     },
     { from  => 1144792800, # 2006-04-12 00:00
       until => 1144965600, # 2006-04-14 00:00
       text  => 'B 320 Birkenhainichener Str. zw. OL Gro� Leine und Birkenhainichen Deckenerneuerung Vollsperrung 13.04.2006-13.04.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 55628,-43569 56193,-44322
userdel	2 56193,-44322 56510,-44474
EOF
     },
     { from  => 1145224800, # 2006-04-17 00:00
       until => 1145743200, # 2006-04-23 00:00
       text  => 'K 7220 Potsdamer Str. OL Luckenwalde, zw. Buchtstr. u. Feldstr. Abbrucharbeiten Vollsperrung 18.04.2006-22.04.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -4173,-34910 -4129,-34535
EOF
     },
     { from  => 1145743200, # 2006-04-23 00:00
       until => 1146175200, # 2006-04-28 00:00
       text  => 'L 030 Tiergartenstr. OL K�nigs Wusterhausen, Schleusenbr�cke Br�ckenreparatur Vollsperrung 24.04.2006-27.04.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 27543,-11912 27544,-11856 27620,-11806 27657,-11741
EOF
     },
     { from  => 1144959197, # 2006-04-13 22:13
       until => 1147557600, # 2006-05-14 00:00
       text  => 'J�terborger Str. (Kreuzberg) in Richtung Gol�ener Str., zwischen Friesenstr. und Heimstr. Baustelle, Fahrtrichtung gesperrt (bis 13.05.06)',
       type  => 'handicap',
       source_id => 'IM_002632',
       data  => <<EOF,
userdel	q4; 9799,8962 9958,8966
EOF
     },
     { from  => 1145649600, # 2006-04-21 22:00
       until => 1145844000, # 2006-04-24 04:00
       text  => '21.04.2006, 22.00 Uhr bis 24.04.2006, 4.00 Uhr Vollsperrung der Ottomar-Geschke-Stra�e ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 21174,4250
userdel	2 21053,4162 21146,4229 21174,4250
EOF
     },
     { from  => 1151002800, # 2006-06-22 21:00
       until => 1151168400, # 2006-06-24 19:00
       text  => '23.06.2006, 21.00 Uhr bis 24.06.2006, 19.00 Uhr Vollsperrung der Ottomar-Geschke-Stra�e ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 21174,4250
userdel	2 21053,4162 21146,4229 21174,4250
EOF
     },
     { from  => 1145209261, # 2006-04-16 19:41
       until => 1145311200, # 2006-04-18 00:00
       text  => 'Adamstr. (Spandau) in beiden Richtungen zwischen Wilhelmstr. und Pichelsdorfer Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 17.04.2006)',
       type  => 'gesperrt',
       source_id => 'IM_002648',
       data  => <<EOF,
userdel	2 -4167,12554 -4239,12626
userdel	2 -4167,12554 -4084,12557
userdel	2 -3635,12572 -3753,12563
userdel	2 -3753,12563 -3892,12560
userdel	2 -3892,12560 -3942,12559 -4084,12557
EOF
     },
     { from  => 1145397600, # 2006-04-19 00:00
       until => 1149112800, # 2006-06-01 00:00
       text  => 'L 010 Havelberger Str. OD Bad Wilsnack, vom OE bis An der Trift Kanal- und Stra�enbau Vollsperrung 20.04.2006-31.05.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -89568,59293 -89549,58784
EOF
     },
     { from  => 1145224800, # 2006-04-17 00:00
       until => 1147557600, # 2006-05-14 00:00
       text  => 'L 080 Brandenburger Str. OL Luckenwalde, Kreuz. Dessauer Str. Kanalarbeiten Vollsperrung 18.04.2006-13.05.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -5036,-34940 -4888,-34952
EOF
     },
     { from  => 1145392820, # 2006-04-18 22:40
       until => 1146348000, # 2006-04-30 00:00
       text  => 'Kreuzstr. (Pankow) in beiden Richtungen, zwischen Grabbeallee und Wollankstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 29.04.2006)',
       type  => 'gesperrt',
       source_id => 'IM_002650',
       data  => <<EOF,
userdel	2 9902,18180 9909,18333
userdel	2 9902,18180 9832,17925
EOF
     },
     { from  => 1145311200, # 2006-04-18 00:00
       until => 1155679200, # 2006-08-16 00:00
       text  => 'L 034 Philipp-M�ller-Str./ Wriezener Str. OD Strausberg, Nordkreuzung Kreiselneubau Vollsperrung 19.04.2006-15.08.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 43553,20466 43584,20871
userdel	q4 43584,20871 43498,21028
userdel	q4 43584,20871 43209,20665
userdel	q4 43584,20871 44596,21287
EOF
     },
     { from  => 1145336400, # 2006-04-18 07:00
       until => 1145642400, # 2006-04-21 20:00
       text  => 'Karlsruher Stra�e zwischen Kurf�rstendamm und Heilbronner Stra�e, Baustelle, Stra�e gesperrt. Dauer: 19.04.2006 bis 21.04.2006 jeweils zwischen 07.00 Uhr und 20.00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 2985,10534 2963,10078
EOF
     },
     { from  => 1145343600, # 2006-04-18 09:00
       until => 1145451600, # 2006-04-19 15:00
       text  => 'Invalidenstra�e, Prenzlauer Berg Richtung Tiergarten Zwischen Kreuzung Gartenstra�e und Kreuzung Chausseestra�e Baustelle, gesperrt, Dauer: 19.04.2006 09:00 Uhr bis 15:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9383,13978 9274,13963 9203,13953
userdel	2 9151,13941 9203,13953
userdel	2 9151,13941 9085,13919
userdel	2 9085,13919 8935,13844
EOF
     },
     { from  => 1145430358, # 2006-04-19 09:05
       until => 1146866400, # 2006-05-06 00:00
       text  => 'Prenzlauer Promenade (Prenzlauer Berg) im Kreuzungsbereich Ostseestr. und Wisbyer Str Baustelle, in Richtung stadteinw�rts Stra�e gesperrt (Radfahrer k�nnen m�glicherweise den Gehweg benutzen) (bis 05.05.06)',
       type  => 'handicap',
       source_id => 'IM_002644',
       data  => <<EOF,
userdel	q4; 12097,16263 12090,16199
EOF
     },
     { from  => 1145562106, # 2006-04-20 21:41
       until => 1150495200, # 2006-06-17 00:00
       text  => 'Ruschstr. (Lichtenberg) in Richtung S�d, in H�he Normannenstr. Einbahnstra�e in Richtung Nord, Einfahrt in Normannenstr. gesperrt (bis 16.06.06)',
       type  => 'handicap',
       source_id => 'IM_002668',
       data  => <<EOF,
userdel	q4; 15904,12340 15896,12273 15879,12131 15863,11992
EOF
     },
     { from  => 1146175200, # 2006-04-28 00:00
       until => 1146348000, # 2006-04-30 00:00
       text  => 'L 090 Eisenbahnstr OL Werder Festumzug 127. Baumbl�tenfest Vollsperrung 29.04.2006-29.04.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -21220,-3831 -21284,-3767
userdel	2 -21284,-3767 -21266,-3604
EOF
     },
     { from  => 1145916000, # 2006-04-25 00:00
       until => 1146175200, # 2006-04-28 00:00
       text  => 'K 6216 Zinsdorf-Beutersitz Br�cke �ber Schwarze Elster bei Neum�hl Arbeiten an Wehranlage, Vollsperrung 26.04.2006-27.04.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8987,-92875 9450,-92307
EOF
     },
     { from  => 1146251142, # 2006-05-01 00:00
       until => 1146251563, # 2006-07-29 00:00
       text  => 'B 168 F�rstenwalde-M�ncheberg zw. Beerfelde und Sch�nfelde Stra�enbauarbeiten Vollsperrung 02.05.2006-28.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 54428,4464 54602,4910
userdel	2 54602,4910 54157,5895
EOF
     },
     { from  => 1147298400, # 2006-05-11 00:00
       until => 1147471200, # 2006-05-13 00:00
       text  => 'L 074 Chausseestra�e OL W�nsdorf, Bahnbr�cke Br�ckenbauarbeiten Vollsperrung 12.05.2006-12.05.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15682,-26971 15229,-27157
userdel	2 15682,-26971 15960,-26906
EOF
     },
     { from  => 1145916000, # 2006-04-25 00:00
       until => 1146175200, # 2006-04-28 00:00
       text  => 'K 6216 Zinsdorf-Beutersitz Br�cke �ber Schwarze Elster bei Neum�hl Arbeiten an Wehranlage Vollsperrung * 26.04.2006-27.04.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8987,-92875 9450,-92307
EOF
     },
     { from  => 1146088800, # 2006-04-27 00:00
       until => 1146348000, # 2006-04-30 00:00
       text  => 'Seifenkisten auf dem Mehringdamm, 28.4.2006-29.4.2006',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 9248,9350 9225,9111 9224,9053 9225,9038 9227,8890 9229,8785
EOF
     },
     { from  => 1162325129, # 2006-10-31 21:05
       until => 1162821600, # 2006-11-06 15:00
       text  => 'Schulzendorfer Stra�e - Am Dachsbau (zwischen Ruppiner Chaussee und Blisenkrautstr.) in beiden Richtungen gesperrt, Baustelle bis 06.11.2006 15:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -915,22935 -1103,22889 -1251,22853 -1299,22842
EOF
     },
     { from  => 1146701434, # 2006-05-04 02:10
       until => 1146834000, # 2006-05-05 15:00
       text  => 'Holtzendorffstr. zwischen R�nnestr. und Gervinusstr. in beiden Richtungen Br�ckenarbeiten gesperrt bis 05.05.06, 15:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 3093,10594 3041,10732
EOF
     },
     { from  => 1146768809, # 2006-05-04 20:53
       until => 1167606000, # 2007-01-01 00:00
       text  => 'Weinmeisterstr. (Mitte) in Richtung Alexanderplatz Baustelle, Stra�e vollst�ndig gesperrt, Einbahnstra�enreglung in Richtung Rosenthaler Str. (bis 31.12.06)',
       type  => 'gesperrt',
       source_id => 'IM_002733',
       data  => <<EOF,
userdel	1::inwork 10350,13376 10527,13257
EOF
     },
     { from  => 1147557600, # 2006-05-14 00:00
       until => 1159653600, # 2006-10-01 00:00
       text  => 'L 037 Petersdorfer Str. OD Petershagen Kanal- und Stra�enbauarbeiten Vollsperrung 15.05.2006-30.09.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 74107,450 74197,607
EOF
     },
     { from  => undef, # 
       until => 1147121258, #
       text  => 'M�hlenstr. (Pankow) in Richtung Norden zwischen Florastr und Dolomitenstr. Einbahnstra�e in Richtung S�den',
       type  => 'gesperrt',
       source_id => 'IM_002743',
       data  => <<EOF,
userdel	1 10572,17573 10510,17649 10459,17754
EOF
     },
     { from  => undef, # 
       until => 1147067585, #
       text  => 'Reichstagufer (Mitte) zwischen Neust�dter Kirchstr. und Friedrichsstr. Gefahr durch Uferuntersp�hlung, Stra�e gesperrt.',
       type  => 'gesperrt',
       source_id => 'LMS_1146113785841',
       data  => <<EOF,
userdel	2 9098,12687 9117,12705 9171,12758 9209,12795
userdel	2 9280,12883 9209,12795
EOF
     },
     { from  => 1146693600, # 2006-05-04 00:00
       until => 1147471200, # 2006-05-13 00:00
       text  => 'B 158 zw. OL Seefeld, L�hmer Ch. und Bahn�bergang Gleis- u. Stra�enbauarbeiten Vollsperrung 05.05.2006-12.05.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26936,23104 27283,23503
userdel	2 28246,24272 27608,23776
userdel	2 27283,23503 27608,23776
EOF
     },
     { from  => 1146866400, # 2006-05-06 00:00
       until => 1147471200, # 2006-05-13 00:00
       text  => 'L 401 R.-Sorge-/ Bergstr. Bahn�bergang Bergstra�e Gleisbauarbeiten Zufahrt gesperrt 07.05.2006-12.05.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26432,-10043 26285,-10054 26262,-10015 26262,-9880 26174,-9760 26093,-9701 25991,-9671 25805,-9553
EOF
     },
     { from  => 1146897090, # 2006-05-06 08:31
       until => 1147086000, # 2006-05-08 13:00
       text  => 'Wilhelmstra�e Richtung Pichelsdorf zwischen Einm�ndung Pichelsdorfer Stra�e und Einm�ndung Gatower Stra�e Baustelle, gesperrt bis 08.05.2006 13:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 -3824,13350 -3886,13120 -3913,13054 -3962,12973 -3999,12912 -4043,12833 -4099,12763 -4174,12683 -4239,12626 -4300,12571 -4351,12460
EOF
     },
     { from  => 1146801600, # 2006-05-05 06:00
       until => 1147039140, # 2006-05-07 23:59
       text  => ' Sonnenallee Zwischen Kreuzung Wildenbruchstra�e und Pannierstra�e in beiden Richtungen gesperrt, Veranstaltung, Dauer: 06.05.2006 06:00 Uhr bis 07.05.2006 23:59 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 12438,8859 12320,8927
userdel	2 12438,8859 12483,8834
userdel	2 12925,8494 12772,8612
userdel	2 12483,8834 12630,8722
userdel	2 12742,8635 12630,8722
userdel	2 12242,8972 12320,8927
EOF
     },
     { from  => undef, # 
       until => 1148166862, # tritt nirgendwo mehr auf
       text  => 'Riemenschneiderweg zwischen Vorarlberger Damm und Grazer Platz, Baustelle, in beiden Richtungen gesperrt.',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 6793,6814 6770,7027 6762,7109
EOF
     },
     { from  => 1147816800, # 2006-05-17 00:00
       until => 1148335200, # 2006-05-23 00:00
       text  => 'L 030 Friedrichstr. OL Erkner, zw. f�rstenwalder Str. u. Beuststr. 14. Heimatfest Vollsperrung 18.05.2006-22.05.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 34443,1951 34250,2546
EOF
     },
     { from  => 1147212000, # 2006-05-10 00:00
       until => 1147471200, # 2006-05-13 00:00
       text  => 'K 6503 KG Lubowsee-L211 n�rdl. Summt Kreuzung Z�hlslake Vorber. Kreiselneubau Vollsperrung 11.05.2006-12.05.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 7431,34989 7073,34715
EOF
     },
     { from  => 1147384800, # 2006-05-12 00:00
       until => 1147557600, # 2006-05-14 00:00
       text  => 'L 015 F�rstenberger Str. OL Lychen, ab Vogelsangstr. bis Am Markt Einbau Deckschicht Vollsperrung 13.05.2006-13.05.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 2797,89387 2480,89399 2111,89378
EOF
     },
     { from  => 1147522037, # 2006-05-13 14:07
       until => 1148940000, # 2006-05-30 00:00
       text  => 'Buschallee (Wei�ensee) in Richtung Berliner Allee, zwischen Hansastr. und Berliner Allee Baustelle Stra�e vollst�ndig gesperrt (bis 29.05.06)',
       type  => 'gesperrt',
       source_id => 'IM_002776',
       data  => <<EOF,
userdel	1 15388,16502 15142,16499 15134,16499 14809,16525 14621,16563
EOF
     },
     { from  => 1147721063, # 2006-05-15 21:24
       until => 1172778049, # was 2006-05-17 00:00, but continuing undef
       text  => 'Linienstr. (Mitte) in Richtung Tucholskystr., ab Oranienburger Str. Stra�enarbeiten, Einbahnstra�e',
       type  => 'handicap',
       source_id => 'IM_002765',
       data  => <<EOF,
userdel	q4; 9607,13507 9296,13397 9281,13374
EOF
     },
     { from  => 1147989600, # 2006-05-19 00:00
       until => 1148248800, # 2006-05-22 00:00
       text  => 'L 079 Ludwigsfelde-Ahrensdorf zw. Ludwigsfelde und Ahrensdorf Stra�enbauarbeiten Vollsperrung 20.05.2006-21.05.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -2086,-9891 -1245,-9999 -862,-9933
EOF
     },
     { from  => 1147845153, # 2006-05-17 07:52
       until => 1147888800, # 2006-05-17 20:00
       text  => 'Anklamer Str. (Mitte) in beiden Richtungen, zwischen Ackerstra�e und Strelitzer Stra�e Veranstaltung, Stra�e vollst�ndig gesperrt (bis 17.5.2006, 20.00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_002793',
       data  => <<EOF,
userdel	2 9627,14229 9800,14306
EOF
     },
     { from  => 1147838400, # 2006-05-17 06:00
       until => 1148205600, # 2006-05-21 12:00
       text  => 'Stra�e am Nordbahnhof zwischen Invalidenstra�e und Zinnowitzer Veranstaltung, Stra�e gesperrt. Dauer: 18.05.2006, 06:00 Uhr bis 21.05.2006 12:00 Uhr. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9085,13919 9015,14014
EOF
     },
     { from  => 1148162400, # 2006-05-21 00:00
       until => 1159653600, # 2006-10-01 00:00
       text  => 'L 011 Perleberger Chaussee zw. Weisen, Walhausstr. u. Wittenberge, Kyritzer Str. Stra�enausbau Vollsperrung 22.05.2006-30.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -102339,65009 -102432,65890
EOF
     },
     { from  => 1131836400, # 2005-11-13 00:00
       until => 1151012746, # 2006-07-01 00:00 1151704800
       text  => 'L 372 Gubener Str. s�dl. Eisenh�ttenstadt, Kreuzung Schrabisch M�hle Bau Kreisverkehr Vollsperrung 14.11.2005-30.06.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 95351,-29486 95494,-29935 95829,-31753
EOF
     },
     { from  => 1147989600, # 2006-05-19 00:00
       until => 1148162400, # 2006-05-21 00:00
       text  => 'B 246 Trebbin-Beelitz OD L�wendorf, zw. Ahrensdorfer Str. u. Schillerstr. Deckeneinbau Vollsperrung 20.05.2006-20.05.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -2643,-21212 -2815,-20920
EOF
     },
     { from  => 1178961276, # 2007-05-12 11:14
       until => 1179093600, # 2007-05-14 00:00
       text  => 'Hermannstr. (Neuk�lln) in beiden Richtungen zwischen Flughafenstr. und Thomasstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 13.05.2007 nachts)',
       type  => 'gesperrt',
       source_id => 'IM_005438',
       data  => <<EOF,
userdel	2 11979,8014 12001,7937 12025,7852 12041,7788 12055,7751 12075,7696 12081,7679 12090,7651 12122,7553 12158,7449 12180,7387
EOF
     },
     { from  => 1148565600, # 2006-05-25 16:00
       until => 1153087200, # 2006-07-17 00:00
       text  => 'Vom 26.05.2006, 16:00 Uhr bis 16.07.2006 wird die Stra�e des 17. Juni zwischen Siegess�ule und Brandenburger Tor komplett gesperrt. Grund sind die geplante WM-Fanmeile sowie mehrere Festveranstaltungen (u.a. Love Parade).',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8538,12245 8303,12216 8214,12205 8089,12190
userdel	2 8055,12186 7816,12150 7383,12095 6828,12031
userdel auto	3 7460,12054 7383,12095 7039,12314
userdel auto	3 7039,12314 7383,12095 7460,12054
userdel	3 8119,12414 8055,12186 8048,12135 8034,12093
userdel	3 8034,12093 8048,12135 8055,12186 8119,12414
EOF
     },
     { from  => 1148623200, # 2006-05-26 08:00
       until => 1148767200, # 2006-05-28 00:00
       text  => 'M�gliche Behinderungen wegen eines Flugspektakels am Flughafen Tempelhof, 27.5. von 8 bis 24 Uhr ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 10209,8661 9801,8683 9570,8715 9395,8726 9364,8640 9321,8607 9233,8597
userdel	q4 9395,8726 9272,8781 9229,8785 9229,8718 9233,8597 9238,8410 9238,8253 9239,8099 9240,8028 9240,7991 9240,7811 9242,7658 9242,7325 9242,7286 9242,7218 9242,7145
userdel auto	3 9227,8890 9229,8785 9076,8783
userdel auto	3 9076,8783 9229,8785 9227,8890
EOF
     },
     { from  => 1148767200, # 2006-05-28 00:00
       until => 1150754400, # 2006-06-20 00:00
       text  => 'B 179 Spreewaldstr. OD Zeesen, Einm�nd. zur K.-Liebknecht-Str. Umbau Knotenpunkt Vollsperrung 29.05.2006-19.06.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 26758,-15727 26650,-15695 26583,-15677
EOF
     },
     { from  => 1148853600, # 2006-05-29 00:00
       until => 1154383200, # 2006-08-01 00:00
       text  => 'L 074 M�rkisch Buchholz-Halbe-Teupitz OD M�rkisch Buchholz, Sch�tzenst. Stra�enbau Vollsperrung 30.05.2006-31.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 35518,-32837 35641,-32578
EOF
     },
     { from  => 1148759377, # 2006-05-27 21:49
       until => 1153087200, # 2006-07-17 00:00
       text  => 'Heinrich-von-Gagern-Str. (Tiergarten) in beiden Richtungen Veranstaltung, Stra�e vollst�ndig gesperrt (im Zuge der Fu�ball-WM) (bis 16.07.2006)',
       type  => 'gesperrt',
       source_id => 'IM_002823',
       data  => <<EOF,
userdel	2 8119,12414 8122,12608
EOF
     },
     { from  => 1148937489, # 2006-05-29 23:18
       until => 1149372000, # 2006-06-04 00:00
       text  => 'Jannowitzbr�cke (Mitte) in beiden Richtungen vollst�ndig gesperrt (bis 03.06.2006)',
       type  => 'gesperrt',
       source_id => 'IM_002820',
       data  => <<EOF,
userdel	2 11347,12181 11325,12021
EOF
     },
     { from  => 1149058136, # 2006-05-31 08:48
       until => 1149285600, # 2006-06-03 00:00
       text  => 'Ebertstr. (Mitte) in beiden Richtungen zwischen Len�str. und Behrenstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 02.06.06. 6 Uhr)',
       type  => 'handicap',
       source_id => 'IM_002840',
       data  => <<EOF,
userdel	q4 8595,12066 8577,11896 8571,11846
EOF
     },
     { from  => 1149230977, # 2006-06-02 08:49
       until => 1149544800, # 2006-06-06 00:00
       text  => 'Bl�cherstr., Zossnerstr., Waterlooufer rund um den Bl�cherplatz Veranstaltung, Stra�en vollst�ndig gesperrt (bis 05.06.06)',
       type  => 'gesperrt',
       source_id => 'IM_002848',
       data  => <<EOF,
userdel	2 9521,10010 9448,10014
userdel	2 9827,10051 9521,10010 9536,10064 9579,10122 9599,10175 9687,10180 9825,10206 9865,10227
userdel	2 9416,10196 9599,10175
userdel	2 9579,10122 9631,10142 9702,10129
userdel	2 9827,10051 9837,10117 9858,10199 9865,10227
EOF
     },
     { from  => 1149229271, # 2006-06-02 08:21
       until => 1151704800, # 2006-07-01 00:00
       text  => 'Hindenburgdamm (Steglitz) in beiden Richtungen, in H�he Wolfensteindamm Baustelle, Stra�e vollst�ndig gesperrt (bis 30.06.06)',
       type  => 'gesperrt',
       source_id => 'IM_002804',
       data  => <<EOF,
userdel	2 4517,4853 4515,4966
EOF
     },
     { from  => 1149458400, # 2006-06-05 00:00
       until => 1152914400, # 2006-07-15 00:00
       text  => 'B 167 Neust�dter Str. OD Neuruppin, zw. Damaschkeweg u. Zufahrt Lidl Stra�en-u.Kanalbau,Mittelinsel Vollsperrung 06.06.2006-14.07.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -32062,56731 -33038,55844
EOF
     },
     { from  => 1149631200, # 2006-06-07 00:00
       until => 1150063200, # 2006-06-12 00:00
       text  => 'B 246 F�nfeichen-Grunow OL Bremsdorf, Str. der Jugend Einbau Deckschicht Vollsperrung 08.06.2006-11.06.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 84903,-28417 83882,-28424
EOF
     },
     { from  => 1149544800, # 2006-06-06 00:00
       until => 1164927600, # 2006-12-01 00:00
       text  => 'L 338 Rahnsdorfer Str. OD Sch�neiche, Br�cke �ber J�gergraben Br�ckenneubau Vollsperrung 07.06.2006-30.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30274,7380 30118,8128
EOF
     },
     { from  => 1150581600, # 2006-06-18 00:00
       until => 1155333600, # 2006-08-12 00:00
       text  => 'L 074 Chausseestra�e OL W�nsdorf, zw. Cottbusser/Berliner Str. u. Seestr. Kanalverlegung Vollsperrung 19.06.2006-11.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 15960,-26906 15682,-26971 15229,-27157
EOF
     },
     { from  => 1149623437, # 2006-06-06 21:50
       until => 1151100000, # 2006-06-24 00:00
       text  => 'Londoner Str. (Wedding) Richtung Holl�nderstr. zwischen M�llerstr. und Holl�nderstr. Baustelle, Fahrtrichtung gesperrt (bis 23.06.2006)',
       type  => 'gesperrt',
       source_id => 'INKO_83663',
       data  => <<EOF,
userdel	2::inwork 5777,16924 5847,17018 5953,17131 6051,17269 6091,17346 6126,17448
EOF
     },
     { from  => 1149976800, # 2006-06-11 00:00
       until => 1151186400, # 2006-06-25 00:00
       text  => 'B 156 OL Spremberg, Muskauer Stra�e OL Spremberg, Muskauer Str., Bahn�bergang Sanierung B� u. Tiefbau Vollsperrung 12.06.2006-24.06.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 80783,-91972 80236,-92007
EOF
     },
     { from  => 1146898800, # 2006-05-06 09:00
       until => 1152913500, # 2006-07-14 23:45
       text  => 'Reinhardtstra�e - Otto-von-Bismarck-Allee: zwischen Kreuzung Kapelleufer und Kreuzung Willy-Brandt-Stra�e in beiden Richtungen Veranstaltung, gesperrt, Dauer: 07.05.2006 09:00 Uhr bis 14.07.2006 23:45 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8120,12756 8206,12757 8301,12758 8309,12758 8417,12846 8503,12895
EOF
     },
     { from  => 1149703449, # 2006-06-07 20:04
       until => 1152914400, # 2006-07-15 00:00
       text  => 'Regierungsviertel: im Zuge der Fu�ball-WM mehrere Stra�en gesperrt (bis 14.07.2006)',
       type  => 'gesperrt',
       source_id => 'IM_002870',
       data  => <<EOF,
userdel	2::temp 8168,12848 8204,12816 8206,12757 8207,12608
userdel	2::temp 8775,12457 8540,12420 8400,12417 8354,12416 8119,12414
userdel	2::temp 8032,12817 8124,12840
userdel	2::temp 8306,12609 8309,12758
userdel	2::temp 8032,12817 8017,12826
EOF
     },
     { from  => 1149703543, # 2006-06-07 20:05
       until => 1152914400, # 2006-07-15 00:00
       text  => 'John-Foster-Dulles-Allee (Tiergarten) in beiden Richtungen zwischen Yitzhak-Rabin-Str. und Spreeweg Stra�e vollst�ndig gesperrt, Veranstaltung (im Zuge der WM 2006 bis 14.07.06)',
       type  => 'gesperrt',
       source_id => 'IM_002839',
       data  => <<EOF,
userdel	2::temp 8119,12414 8070,12409 8017,12359 7875,12363 7821,12367 7627,12380 7514,12387 7437,12368 7215,12295 7039,12314
EOF
     },
     { from  => 1149976800, # 2006-06-11 00:00
       until => 1151100000, # 2006-06-24 00:00
       text  => 'B 101 OL Luckenwalde, Zinnaer Stra�e OL Luckenwalde, Zinnaer Str. zw. M�hlenweg u. Am Nuth: Vollsperrung 12.06.2006-23.06.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -4630,-36012 -4603,-35730
EOF
     },
     { from  => 1150581600, # 2006-06-18 00:00
       until => 1151791200, # 2006-07-02 00:00
       text  => 'L 099 Barnewitz - Marzahne zw. Abzw. Gortz (L911) in OL Barnewitz u. L98 in OL Marzahne Stra�enbau Vollsperrung 19.06.2006-01.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -46651,12935 -45980,13284
EOF
     },
     { from  => 1152568800, # 2006-07-11 00:00
       until => 1157138787, # 1164927600 2006-12-01 00:00
       text  => 'L 601 Leipziger Str. OD Finsterwalde, Kno. Hain-/ Sch�tzenstr. Kanalarbeiten Vollsperrung 12.07.2006-30.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 32963,-85912 32865,-86269 32870,-86323 32478,-86374
EOF
     },
     { from  => 1149544800, # 2006-06-06 00:00
       until => 1152482399, # 2006-07-09 23:59
       text  => 'Fan-Fest der FIFA im Tiergarten, 7. Juni 2006 - 9. Juli 2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8021,11636 8016,11770 8172,11679
userdel	2::temp 7816,12150 7875,12363
userdel	2::temp 7504,11512 7382,11588 7163,11738 7287,11763 7535,11677 7606,11629 7621,11620 7669,11586 7696,11621 7735,11656 7796,11681 7901,11684 8016,11770
userdel	2::temp 7669,11586 7711,11558
userdel	2::temp 8022,12016 8016,11770 7801,11875 7717,11918 7663,11946 7570,11855 7223,11897 7182,11870 7173,11864 7073,11798 7163,11738 6980,11583 6809,11570
userdel	2::temp 7039,12314 7383,12095
userdel	2::temp 7073,11798 6778,11742
userdel	2::temp 8354,12416 8546,12279
userdel	2::temp 7382,11588 7356,11517
userdel	2::temp 6809,11979 7073,11798
userdel	2::temp 8203,11686 8210,11775 8222,11881 8215,12156 8214,12205
userdel	2::temp 8119,12414 8055,12186
userdel	2::temp 8055,12186 8048,12135 8034,12093 8004,12074 7999,12040 8022,12016 8052,12033 8057,12065 8034,12093
userdel	2::temp 8540,12420 8573,12325 8570,12302 8546,12279 8538,12245 8600,12165 8595,12066
userdel	2::temp 8595,12066 8577,11896 8571,11846
EOF
     },
     { from  => undef, # 
       until => 1149833870, # undef
       text  => 'Veitstr. (Tegel) in beiden Richtungen zwischen Medebacher Weg und Treskowstr. Wasserrohrbruch, Baustelle, Stra�e vollst�ndig gesperrt (Dauer: mehrere Tage)',
       type  => 'gesperrt',
       source_id => 'IM_002880',
       data  => <<EOF,
userdel	2 2064,19874 1886,19835
EOF
     },
     { from  => 1149834073, # 2006-06-09 08:21
       until => 1150063200, # 2006-06-12 00:00
       text  => 'M�llerstr. (Wedding) in beiden Richtungen zwischen Seestr. und Leopoldplatz Veranstaltung, Stra�e vollst�ndig gesperrt (bis 11.06.06)',
       type  => 'gesperrt',
       source_id => 'IM_002867',
       data  => <<EOF,
userdel	2 6781,16026 6914,15908 6936,15888 7043,15793 7129,15717 7198,15656 7277,15586
EOF
     },
     { from  => 1150581600, # 2006-06-18 00:00
       until => 1151704800, # 2006-07-01 00:00
       text  => 'K 6162 OL Waltersdorf, Siedlung Kienberg, Bau der BAB 113n, Vollsperrung 19.06.2006-30.06.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 20367,-3844 20265,-3849
EOF
     },
     { from  => 1339711200, # 1150395890, # 2006-06-15 20:24
       until => 1339970400, # 1150754400, # 2006-06-20 00:00
       text  => 'Altstadt K�penick: 51. K�penicker Sommer vom 15. bis 17. Juni 2012',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-treptow-koepenick/aktuelles/koepenickersommerbuehnen.html',
       data  => <<EOF,
userdel	q4::temp 22196,4847 22175,4730 22138,4661 22133,4644 22111,4562 22093,4499
userdel	q4::temp 22196,4847 22153,4840 22074,4664 22057,4618 22043,4562 22057,4531 22071,4501
userdel	q4::temp 22111,4562 22162,4546 22214,4548 22324,4586 22314,4604 22355,4660
userdel	q4::temp 22138,4661 22212,4655 22284,4653 22355,4660
userdel	q4::temp 22214,4548 22212,4655
userdel	q4::temp 22175,4730 22246,4711
userdel	q4::temp 22314,4604 22284,4653 22246,4711 22240,4768 22196,4847
EOF
     },
     { from  => 1151532000, # 2006-06-29 00:00
       until => 1152050400, # 2006-07-05 00:00
       text  => 'B 246 OL Bestensee, Hauptstra�e OL Bestensee, Hauptstra�e, Bahn�bergang Bauarbeiten am Gleisk�rper Vollsperrung 30.06.2006-04.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 26639,-17861 26706,-17867 26718,-17867 26832,-17882
EOF
     },
     { from  => 1150840800, # 2006-06-21 00:00
       until => 1160949600, # 2006-10-16 00:00
       text  => 'K 6828 L 164 Altfriesack-Wuthenow OT Seehof, Dorfstr. Kanalarbeiten Vollsperrung 22.06.2006-15.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -28368,51517 -28736,52387
EOF
     },
     { from  => 1151618400, # 2006-06-30 00:00
       until => 1151877600, # 2006-07-03 00:00
       text  => 'K 7221 Woltersdorf-Lieb�tz Einm�ndung zur K7220 (Ruhldorf-Lieb�tz) Stra�en- u. Radwegebau Vollsperrung 01.07.2006-02.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -3584,-29888 -3733,-29501
EOF
     },
     { from  => 1151609302, # 2006-06-29 21:28
       until => 1156977391, # 1157061600 2006-09-01 00:00
       text  => 'Bis 31.08.2006 Vollsperrung der L 862 zwischen Falkenrehde und Ketzin. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -22215,9500 -22510,9372 -23467,9217 -23807,9279 -24319,9296 -24594,9168 -25265,9000 -25456,8850 -25658,8777 -26243,8485 -26774,7951 -27468,7711
EOF
     },
     { from  => 1150916248, # 2006-06-21 20:57
       until => 1159207739, # 1159653599 2006-09-30 23:59, superseded
       text  => 'Schulzendorfer Str. (Reinickendorf) in beiden Richtungen zwischen Damkitzstr. und Ruppiner Chaussee Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 09.2006)',
       type  => 'gesperrt',
       source_id => 'INKO_82301_COPY_1',
       data  => <<EOF,
userdel	2::inwork -915,22935 -774,22977 -728,22990 -700,22998 -656,23011
EOF
     },
     { from  => 1149976800, # 2006-06-11 00:00
       until => 1151618400, # 2006-06-30 00:00
       text  => 'B 156 Muskauer Stra�e Bahn�bergang in der OL Spremberg Sanierung B� u. Tiefbau Vollsperrung 12.06.2006-29.06.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 80783,-91972 80236,-92007
EOF
     },
     { from  => 1150840800, # 2006-06-21 00:00
       until => 1151013600, # 2006-06-23 00:00
       text  => 'B 158 bei Schiffm�hle, Br�cke �ber Alte Oder R�ckbauarb., Herstell. M.insel Vollsperrung * 22.06.2006-22.06.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 53350,45087 53293,45400
EOF
     },
     { from  => 1152050400, # 2006-07-05 00:00
       until => 1156024800, # 2006-08-20 00:00
       text  => 'K 6503 B273-Z�hlsdorf-L211 (Summt-Lehnitz) Kreuzung. Summter Chaussee bei Z�hlslake Neubau Kreisverkehr Vollsperrung 06.07.2006-19.08.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 7346,32257 7431,34989 8115,35387
userdel	q4::inwork 7073,34715 7431,34989 7456,36042 7454,36156
EOF
     },
     { from  => 1149026400, # 2006-05-31 00:00
       until => 1157061600, # 2006-09-01 00:00
       text  => 'L 010 Havelberger Str. OD Bad Wilsnack, vom OE bis An der Trift Kanal- und Stra�enbau Vollsperrung 01.06.2006-31.08.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -89549,58784 -89568,59293
EOF
     },
     { from  => 1150754400, # 2006-06-20 00:00
       until => 1157061600, # 2006-09-01 00:00
       text  => 'L 011 Gro�e Str. OD Bad Wilsnack, Einm�nd. zur Havelberger Str. Kanal- und Stra�enbau Vollsperrung 21.06.2006-31.08.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -89568,59293
EOF
     },
     { from  => 1151013248, # 2006-06-22 23:54
       until => 1168462143, # 2007-08-31 23:59 1188597599
       text  => 'Askanierring (Spandau) in Richtung Hohenzollernring, zwischen Eckschanze und Fehrbelliner Tor Baustelle, Fahrtrichtung gesperrt (bis Ende 08/2007)',
       type  => 'gesperrt',
       source_id => 'INKO_82715',
       data  => <<EOF,
userdel	1::inwork -3997,15664 -4012,15780 -3995,15832 -3942,15926 -3896,15999 -3828,16118 -3735,16205 -3631,16224
EOF
     },
     { from  => 1150840800, # 2006-06-21 00:00
       until => 1151704800, # 2006-07-01 00:00
       text  => 'L 211 Lehnitzer Str. OD Oanienburg, zw. Lindenring u. Dr.-H.-Byk-Str. Munitionssuche u.-bergung halbseitig gesperrt; Einbahnstra�e 22.06.2006-30.06.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -896,38348 -856,38306 -793,38240 -770,38215 -612,38051
EOF
     },
     { from  => 1151042079, # 2006-06-23 07:54
       until => 1151272800, # 2006-06-26 00:00
       text  => 'Turmstr. zwischen Stromstr. und Waldstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 25.06.06, 24:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_002950',
       data  => <<EOF,
userdel	2 6228,13324 6115,13328 6105,13328 6011,13330 5956,13330 5857,13342 5705,13359 5569,13381 5560,13382 5368,13406
EOF
     },
     { from  => 1151099435, # 2006-06-23 23:50
       until => 1151290800, # 2006-06-26 05:00
       text  => 'D�rpfeldstr., Ottomar-Geschke-Str. (Treptow) in beiden Richtungen,zwischen Waldstr. und Oberspreestr. Baustelle, Stra�e vollst�ndig gesperrt (bis 26.06.06, 05.00 Uhr)',
       type  => 'gesperrt',
       source_id => 'INKO_64281_COPY_1',
       data  => <<EOF,
userdel	2 20692,3951 20772,3999 20788,4008 20834,4035 21053,4162 21146,4229 21174,4250 21184,4293 21206,4387 21289,4563 21332,4655
EOF
     },
     { from  => 1151101431, # 2006-06-24 00:23
       until => 1155679199, # 2006-08-15 23:59
       text  => 'Corinthstr. - Markgrafendamm: wegen einer Baustelle kann nur der Gehweg genutzt werden (bis Mitte 08.2006)',
       type  => 'handicap',
       source_id => 'INKO_77040_COPY_1',
       data  => <<EOF,
userdel	q4::inwork 14447,10491 14608,10409
EOF
     },
     { from  => 1150754400, # 2006-06-20 00:00
       until => 1151359200, # 2006-06-27 00:00
       text  => 'B 002 Eberswalder Str. Bahn�bergang in OL Melchow Umbau Bahn�bergang Vollsperrung 21.06.2006-26.06.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30143,41500 29553,41441 29468,41438
EOF
     },
     { from  => 1152050400, # 2006-07-05 00:00
       until => 1156024800, # 2006-08-20 00:00
       text  => 'L 235 Gielsdorf-Werneuchen Schulstr. in der OL Wegendorf Stra�en- u. Durchlassbau Vollsperrung; 06.07.2006-19.08.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 34492,22176 34321,22151 34125,22128
EOF
     },
     { from  => 1151791200, # 2006-07-02 00:00
       until => 1151964000, # 2006-07-04 00:00
       text  => 'B 183 Dresdner Str. OL Bad Liebenwerda, zw. Querspange u. Hainsche Str. Untersuchung Lubwartturm Vollsperrung 03.07.2006-03.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 12194,-98944 12593,-99029
EOF
     },
     { from  => 1152050400, # 2006-07-05 00:00
       until => 1152655200, # 2006-07-12 00:00
       text  => 'L 711 Buckow-Wahlsdorf zw. Wahlsdorf und Liepe Deckenerneuerung Vollsperrung 06.07.2006-11.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8810,-50414 6695,-50057
EOF
     },
     { from  => 1153432800, # 2006-07-21 00:00
       until => 1153692000, # 2006-07-24 00:00
       text  => 'L 060 Marktplatz (Zentrum) OL Uebigau, zw. Elsterstr. u. Kreuzstr. Altstadtfest Vollsperrung 22.07.2006-23.07.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 5798,-90075 5358,-90502
EOF
     },
     { from  => 1151877600, # 2006-07-03 00:00
       until => 1152050400, # 2006-07-05 00:00
       text  => 'L 220 B167 Finowfurt-Joachimsthal zw. Eichhorst und Elsenau Baumf�llungen Vollsperrung 04.07.2006-04.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 29884,58862 30384,59443
EOF
     },
     { from  => 1151618400, # 2006-06-30 00:00
       until => 1151877600, # 2006-07-03 00:00
       text  => 'K 7220 Luckenwalde-Lieb�tz zw. Ruhlsdorf und Lieb�tz Deckeneinbau Vollsperrung 01.07.2006-02.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -3607,-29164 -3733,-29501
EOF
     },
     { from  => 1152050400, # 2006-07-05 00:00
       until => 1156024800, # 2006-08-20 00:00
       text  => 'L 079 Ludwigsfelde-Potsdam H�he Ahrensdorf bis Kreisverk. Nudow Stra�enbauarbeiten Vollsperrung 06.07.2006-19.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -3618,-9791 -4050,-9464 -4422,-9151 -4649,-8996
EOF
     },
     { from  => 1151917200, # 2006-07-03 11:00
       until => 1152061200, # 2006-07-05 03:00
       text  => 'Der gro�e Stern wird zu den Halbfinalspielen am 4.7.2006 von 11.00 Uhr bis zum 5.7.2006 03.00 Uhr gesperrt. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 6653,12067 6642,12010 6685,11954 6744,11936 6809,11979 6828,12031 6787,12099 6754,12108 6725,12113 6690,12104
EOF
     },
     { from  => 1152234000, # 2006-07-07 03:00
       until => 1152504000, # 2006-07-10 06:00
       text  => 'Der gro�e Stern wird zu den Finalspielen am 8.7.2006 von 03.00 Uhr bis zum 10.7.2006 06.00 Uhr gesperrt. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 6653,12067 6642,12010 6685,11954 6744,11936 6809,11979 6828,12031 6787,12099 6754,12108 6725,12113 6690,12104
userdel	2::temp 6540,11754 6685,11954
userdel	2::temp 6825,11486 6809,11570 6778,11742 6744,11936
userdel	2::temp 6653,12067 6348,12272 6178,12387
userdel	2::temp 5900,11913 6642,12010
userdel	2::temp 7039,12314 6787,12099
EOF
     },
     { from  => 1151965861, # 2006-07-04 00:31
       until => 1153346400, # 2006-07-20 00:00
       text  => 'B�kestr. (Steglitz) in beiden Richtungen, zwischen Ostpreu�endamm und Hindenburgdamm Baustelle, Stra�e vollst�ndig gesperrt (bis 19.07.06)',
       type  => 'gesperrt',
       source_id => 'IM_003018',
       data  => <<EOF,
userdel	2::inwork 4409,3173 4591,3089 4655,3060 4832,2975
EOF
     },
     { from  => 1152396000, # 2006-07-09 00:00
       until => 1153740281, # 2006-08-20 00:00 1156024800
       text  => 'L 362 Bergmannstr. OD M�ncheberg, zw. Seelower Str. u. Marienfeld Instandsetzung Durchlass Vollsperrung 10.07.2006-19.08.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 61026,13354 61181,12075
EOF
     },
     { from  => 1168462016, # 2007-01-10 21:46
       until => 1175378399, # 2007-03-31 23:59
       text  => 'Pistoriusstr. (Pankow) in Richtung Berliner Allee, zwischen Roelckestr. und Mirbachplatz Baustelle, Fahrtrichtung gesperrt (bis 03.2007)',
       type  => 'handicap',
       source_id => 'IM_004456',
       data  => <<EOF,
userdel	q4::inwork; 13104,16522 13331,16424
EOF
     },
     { from  => 1153000800, # 2006-07-16 00:00
       until => 1167606000, # 2007-01-01 00:00
       text  => 'K 6413 Berliner Str. OL Buckow, zw. Hauptstr. und OA grundhafter Stra�enbau Vollsperrung 17.07.2006-31.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 55882,18301 55853,18228 55700,18101 55623,17923 55524,17754 55164,17565
EOF
     },
     { from  => 1152568800, # 2006-07-11 00:00
       until => 1152914400, # 2006-07-15 00:00
       text  => 'K 6413 Berliner Str. OL Buckow, zw. Nr. 60 und Waldweg grundhafter Stra�enbau Vollsperrung; Umleitung 12.07.2006-14.07.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 55882,18301 55853,18228 55700,18101 55623,17923 55524,17754 55164,17565
EOF
     },
     { from  => 1152568800, # 2006-07-11 00:00
       until => 1156975200, # 2006-08-31 00:00
       text  => 'L 029 Bahnhofstr. Bahn�bergang in Biesenthal Umbau Bahn�bergang Vollsperrung 12.07.2006-30.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 28967,38692 28199,39134 26237,40190
EOF
     },
     { from  => 1152223200, # 2006-07-07 00:00
       until => 1152655200, # 2006-07-12 00:00
       text  => 'L 171 Karl-Marx-Str. OD Hohen Neuendorf, Kno.K.-Tucholsky-Str. Stra�ensanierung halbseitig gesperrt; Einbahnstra�e 08.07.2006-11.07.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 1366,29416 1492,29386 1596,29362
EOF
     },
     { from  => 1152828000, # 2006-07-14 00:00
       until => 1153000800, # 2006-07-16 00:00
       text  => 'B 102 Gro�e Milower Str. OD Rathenow, zw. Eigendorfstr. u. Gr�nauer Weg Neub. B188n, Mont. Stahltr�ger Vollsperrung 15.07.2006-15.07.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -62333,20390 -62290,19904 -62217,19221
EOF
     },
     { from  => 1152396000, # 2006-07-09 00:00
       until => 1160949600, # 2006-10-16 00:00
       text  => 'L 019 Ruppiner Chaussee OD Kremmen grundhafter Stra�enbau Vollsperrung 10.07.2006-15.10.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -15770,39361 -15556,39597 -15198,39722 -15063,39954 -14975,40027 -14856,40112
EOF
     },
     { from  => 1152396000, # 2006-07-09 00:00
       until => 1153000800, # 2006-07-16 00:00
       text  => 'L 099 zw. Abzw. Gortz (L911) in OL Barnewitz u. Marzahne Stra�enbau Vollsperrung 10.07.2006-15.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -48613,11191 -48394,11401 -48110,11569 -48043,11687 -47696,12224 -47031,12527 -46651,12935 -45980,13284 -45617,13395 -44599,14084 -44292,14733 -44020,15116 -43321,16508
EOF
     },
     { from  => 1152396000, # 2006-07-09 00:00
       until => 1155938400, # 2006-08-19 00:00
       text  => 'L 743 Motzener Str. OD Bestensee, Durchlass Ersatzneubau Durchlass Vollsperrung 10.07.2006-18.08.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 26639,-17861 26650,-18150 26376,-18707 26356,-18748 26312,-18789 25453,-19255
EOF
     },
     { from  => 1161366511, # 2006-10-20 19:48
       until => 1161554400, # 2006-10-23 00:00
       text  => 'G�rtelstr., Neue Bahnhofstr. in beiden Richtungen zwischen Boxhagener Str. und Oderstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 22.10.2006) ',
       type  => 'handicap',
       source_id => 'INKO_83811',
       data  => <<EOF,
userdel	q4::inwork 14918,11249 15016,11431 15055,11505 15106,11598
EOF
     },
     { from  => 1152228595, # 2006-07-07 01:29
       until => 1167606000, # 2007-01-01 00:00
       text  => 'Luisenhain ist gesperrt, Umgestaltung bis 2007',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 22196,4847 22153,4840 22074,4664 22057,4618 22043,4562 22057,4531 22071,4501
EOF
     },
     { from  => 1152363677, # 2006-07-08 15:01
       until => 1158357599, # 2006-09-15 23:59
       text  => 'Simon-Dach-Str.: Bauarbeiten an der W�hlischstr., Einbahnstra�e, bis 2006-09-15 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 13888,11405 13954,11647
EOF
     },
     { from  => 1152363870, # 2006-07-08 15:04
       until => 1167605999, # 2006-12-31 23:59
       text  => 'Neubau der Treptower Stra�e in Neuk�lln, Sperrung zwischen Kiefholzstra�e und Heidelberger Stra�e (Anliegerverkehr ist frei) (bis Ende 2006) ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 13860,8599 14015,8798 14151,8967
EOF
     },
     { from  => 1153955394, # 2006-07-27 01:09
       until => 1154124000, # 2006-07-29 00:00
       text  => 'Buschallee (Wei�ensee) in Richtung Hansastr., zwischen Berliner Allee und Hansastr. Baustelle, Stra�e vollst�ndig gesperrt (bis 28.07.06)',
       type  => 'gesperrt',
       source_id => 'INKO_84063',
       data  => <<EOF,
userdel	1::inwork 14621,16563 14809,16525 15134,16499 15142,16499 15388,16502
EOF
     },
     { from  => 1152566231, # 2006-07-10 23:17
       until => 1153860384, # 2006-07-31 23:59 1154383199
       text  => 'Wilhelminenhofstr. (Treptow) Richtung Rathenaustr. zwischen Edisonstr. und Schillerpromenade Baustelle, Fahrtrichtung gesperrt (bis Ende 07.2006)',
       type  => 'handicap',
       source_id => 'INKO_84075',
       data  => <<EOF,
userdel	q4::inwork; 18191,6363 18343,6318 18423,6285 18473,6265 18574,6197 18670,6132 18766,6067 18843,6013 18861,6000
EOF
     },
     { from  => 1154642400, # 2006-08-04 00:00
       until => 1154901600, # 2006-08-07 00:00
       text  => 'L 023 Storkow-Gr�nheide Br�cke �ber die M�ggelspree bei Neuhartmannsdorf Asphaltarbeiten Vollsperrung 05.08.2006-06.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 40333,-4484 40503,-4571 40652,-4743
EOF
     },
     { from  => 1153738184, # 2006-07-24 12:49
       until => 1156893323, # 1159653599 2006-09-30 23:59
       text  => 'Bergstr. (Steglitz) Richtung Bismarckstr. zwischen Menckenstr. und K�rnerstr. Baustelle, Fahrtrichtung gesperrt, eine Umleitung ist eingerichtet (bis Ende 09.2006)',
       type  => 'gesperrt',
       source_id => 'INKO_84234_COPY_14',
       data  => <<EOF,
userdel	1::inwork 5464,5731 5581,5741
EOF
     },
     { from  => 1153738269, # 2006-07-24 12:51
       until => 1156197600, # 2006-08-22 00:00
       text  => 'Gartenstr. (Wedding) in Richtung Invalidenstr., zwischen Bernauer Str. und Invalidenstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 21.08.06)',
       type  => 'gesperrt',
       source_id => 'INKO_83906_COPY_1',
       data  => <<EOF,
userdel	1::inwork 9224,14169 9383,13978
EOF
     },
     { from  => 1159397648, # 2006-09-28 00:54
       until => 1159739999, # 2006-10-01 23:59
       text  => 'L�tzowplatz (Mitte) in beiden Richtungen zwischen Einemstr. und L�tzowufer Baustelle, Stra�e vollst�ndig gesperrt (bis Anfang 10.2006)',
       type  => 'gesperrt',
       source_id => 'IM_003395',
       data  => <<EOF,
userdel	2::inwork 7002,11034 7010,11002 6966,10931 6918,10854
EOF
     },
     { from  => 1153739453, # 2006-07-24 13:10
       until => 1154383199, # 2006-07-31 23:59
       text  => 'Rosestr., Germanenstr. (Treptow) An der Kreuzung Baustelle, Rosestra�e vollst�ndig gesperrt, Germaenstr. teilweise gesperrt (bis Ende 07.2006)',
       type  => 'gesperrt',
       source_id => 'INKO_84204',
       data  => <<EOF,
userdel	2::inwork 21329,832 21202,727 21164,697 21089,639
EOF
     },
     { from  => 1153346400, # 2006-07-20 00:00
       until => 1159653600, # 2006-10-01 00:00
       text  => 'B 096 Gransee-F�rstenberg OD Dannenwalde grundhafter Stra�enbau Vollsperrung 21.07.2006-30.09.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -5962,74421 -5737,74650
EOF
     },
     { from  => 1153000800, # 2006-07-16 00:00
       until => 1155333600, # 2006-08-12 00:00
       text  => 'B 167 Eisenbahnstr./ Wilhelmstr. OL Eberswalde, Wilhelmbr�cke Fahrbahnsanierung 17.07.2006-11.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 37909,48248 37731,48228 37474,48123
EOF
     },
     { from  => 1153000800, # 2006-07-16 00:00
       until => 1164927600, # 2006-12-01 00:00
       text  => 'K 6425 Rudolf-Breitscheid-Allee OD Neuenhagen, zw. Am Friedhof u. Krz. H�nower Chaussee Stra�en- uned Gehwegbau halbseitig gesperrt; Einbahnstra�e 17.07.2006-30.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 29743,14143 29093,13456
EOF
     },
     { from  => 1152482400, # 2006-07-10 00:00
       until => 1160172000, # 2006-10-07 00:00
       text  => 'L 098 Marzahne-Rathenow Brandenburger Str. in OL M�tzlitz Kanal- und Stra�enbau Vollsperrung 11.07.2006-06.10.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -50268,15901 -50493,15837 -50578,15920
EOF
     },
     { from  => 1153173600, # 2006-07-18 00:00
       until => 1154296800, # 2006-07-31 00:00
       text  => 'L 362 M�ncheberg-Wulkow OD Obersdorf Kanal- u. Stra�enbau Vollsperrung 19.07.2006-30.07.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 62416,15883 62294,16249 62099,16389
EOF
     },
     { from  => 1156370400, # 2006-08-24 00:00
       until => 1156802400, # 2006-08-29 00:00
       text  => 'L 601 Berliner Str. OL Finsterwalde S�ngerfest Vollsperrung 25.08.2006-28.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 33060,-85292 33103,-85728
EOF
     },
     { from  => 1153805975, # 2006-07-25 07:39
       until => 1162238095, # 2006-10-31 23:59 1162335599
       text  => 'Quitzowstr. (Tiergarten) Richtung Putlitzstr. zwischen Rathenower Str. und Havelberger Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 10.2006)',
       type  => 'handicap',
       source_id => 'INKO_82304',
       data  => <<EOF,
userdel	q4::inwork; 6656,14311 6481,14277
EOF
     },
     { from  => 1158185618, # 2006-09-14 00:13
       until => 1159394400, # 2006-09-28 00:00
       text  => 'Ringstr. (Lichterfelde) Richtung Carstennstr. zwischen Lotzestr. und Finckensteinallee Baustelle, Fahrtrichtung gesperrt (bis 27.09.2006)',
       type  => 'gesperrt',
       source_id => 'IM_003129',
       data  => <<EOF,
userdel	1::inwork 2661,3021 2637,2973 2638,2843
EOF
     },
     { from  => 1160591740, # 2006-10-11 20:35
       until => 1161208800, # 2006-10-19 00:00
       text  => 'Ruschestr. (Lichtenberg) in Richtung Frankfurter Allee, zwischen Normannenstr. und Frankfurter Allee Baustelle, Fartrichtung gesperrt (bis 18.10.06)',
       type  => 'gesperrt',
       source_id => 'IM_003134',
       data  => <<EOF,
userdel	1::inwork 15904,12340 15896,12273 15879,12131 15863,11992
EOF
     },
     { from  => 1154210400, # 2006-07-30 00:00
       until => 1155333600, # 2006-08-12 00:00
       text  => 'L 015 B109 s�dl. Prenzlau-Boitzenburg OD Gollmitz Einbau Deckschicht Vollsperrung 31.07.2006-11.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30789,99365 30482,99609
EOF
     },
     { from  => 1163442022, # 2006-11-13 19:20
       until => 1167675622, # 2007-01-01 19:20
       text  => 'Josef-Orlopp-Str. (Lichtenberg) in Richtung Siegfriedstr., zwischen Vulkanstr. und Siegfriedstr. Baustelle, Fahrtrichtung gesperrt (bis 2007)',
       type  => 'gesperrt',
       source_id => 'IM_004084',
       data  => <<EOF,
userdel	1::inwork 16863,13138 16426,13145 15912,13153
EOF
     },
     { from  => 1154210400, # 2006-07-30 00:00
       until => 1157234400, # 2006-09-03 00:00
       text  => 'L 035 Eisenbahnstr.-August-Bebel-Str. Br�cke �ber die Spree in F�rstenwalde Deckenerneuerung halbseitig gesperrt; Einbahnstra�e 31.07.2006-02.09.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 55506,-4975 55536,-4725
EOF
     },
     { from  => 1154642400, # 2006-08-04 00:00
       until => 1156629600, # 2006-08-27 00:00
       text  => 'L 063 Berliner Str. OL Lauchhammer, H�he Bahn�bergang Neugestaltung SG� Vollsperrung 05.08.2006-26.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 35482,-103562 35379,-103141 35072,-102150
EOF
     },
     { from  => 1154296800, # 2006-07-31 00:00
       until => 1160258400, # 2006-10-08 00:00
       text  => 'L 074 Kehrigk-M�rkisch Buchholz OD M�rkisch Buchholz, Friedrichstr. Stra�enbau Vollsperrung 01.08.2006-07.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 36004,-32198 35916,-32601
EOF
     },
     { from  => 1154165181, # 2006-07-29 11:26
       until => 1154296800, # 2006-07-31 00:00
       text  => 'Rheinstr. (Sch�neberg) in beiden Richtungen zwischen Saarstr. und Walter-Schreiber-Platz Veranstaltung, Stra�e vollst�ndig gesperrt (bis 30.07.2006 nachts) ',
       type  => 'gesperrt',
       source_id => 'IM_003088',
       data  => <<EOF,
userdel	2::temp 5370,6486 5424,6584 5533,6753 5644,6936
EOF
     },
     { from  => 1154203576, # 2006-07-29 22:06
       until => Time::Local::timelocal(reverse(2007-1900,5-1,13,0,0,0)), # 1183240800, # 2007-07-01 00:00 # nicht mehr in VMZ vorhanden!
       text  => 'Karl-Liebknecht-Str. (Mitte) in Richtung Spandauer Str., zwischen Memhardstr.. und Dircksenstr. Baustelle, Stra�e vollst�ndig gesperrt. Ebenfalls Einbahnstra�e: Teile der Dircksenstr. Die Ausfahrt aus der Memhardstra�e in Richtung Ost (Alexanderstra�e) ist nicht m�glich. (bis 2007-05-13) ',
       type  => 'gesperrt',
       source_id => 'IM_003157',
       data  => <<EOF,
userdel	1::inwork 10923,13156 10776,13005
userdel	1::inwork 10776,13005 10706,13043
userdel	3::inwork 10755,13152 10923,13156 11033,13086 11139,13008
EOF
     },
     { from  => 1154203576, # 2006-07-29 22:06
       until => Time::Local::timelocal(reverse(2006-1900,9-1,23,23,59,59)), # nicht mehr in VMZ vorhanden!
       text  => 'Memhardstr. ist Einbahnstra�e Richtung Westen (bis 23. September 2006) ',
       type  => 'gesperrt',
       source_id => 'IM_003157',
       data  => <<EOF,
userdel	1::inwork 10755,13152 10923,13156
EOF
     },
     { from  => 1152568800, # 2006-07-11 00:00
       until => 1156024800, # 2006-08-20 00:00
       text  => ' L 601 Leipziger Str. OD Finsterwalde, Kno. Hain-/ Sch�tzenstr. Kanalarbeiten Vollsperrung 12.07.2006-19.08.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 32963,-85912 32865,-86269 32870,-86323 32478,-86374
EOF
     },
     { from  => 1154556000, # 2006-08-03 00:00
       until => 1154815200, # 2006-08-06 00:00
       text  => 'B 107 zw. T�chen und Mesendorf Vollsperrung 04.08.2006-05.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -79120,73107 -78454,74544
EOF
     },
     { from  => 1152396000, # 2006-07-09 00:00
       until => 1167606000, # 2007-01-01 00:00
       text  => 'K 6308 KG n�rdl. Bagow-L 91 westl.Nauen zw. OL Klein Behnitz und Gro� Behnitz Stra�enbauarbeiten Vollsperrung 10.07.2006-31.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -37075,16831 -37025,17462 -36787,18125
EOF
     },
     { from  => 1155420000, # 2006-08-13 00:00
       until => 1155938400, # 2006-08-19 00:00
       text  => 'L 059 Bormannstr. OL Bad Liebenwerda, zw. F.-Engels-Str. u. Stangeng�rtenstr. Kanalarbeiten Vollsperrung 14.08.2006-18.08.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 12571,-99519 12383,-99327 12173,-99115
EOF
     },
     { from  => 1160591665, # 2006-10-11 20:34
       until => 1161366670, # 1160949599 2006-10-15 23:59
       text  => 'Grunerstr. (Mitte) stadtausw�rts neben Tunnel Alexanderplatz Baustelle, Fahrtrichtung gesperrt (bis Mitte 10.2006)',
       type  => 'gesperrt',
       source_id => 'IM_003144',
       data  => <<EOF,
userdel	1::inwork 11329,12497 11209,12430 11092,12375 11084,12395 11059,12450 10954,12635
userdel	1::inwork 10954,12635 11057,12715 11105,12764 11134,12793
EOF
     },
     { from  => 1154786970, # 2006-08-05 16:09
       until => 1154988000, # 2006-08-08 00:00
       text  => 'Rixdorfer Str. (Treptow) in beiden Richtungen zwischen S�dostallee und Schnellerstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 07.08.2006 5 Uhr)',
       type  => 'handicap',
       source_id => 'INKO_84352',
       data  => <<EOF,
userdel	q4::inwork 16868,5938 17056,6133 17156,6235 17239,6182 17290,6228
EOF
     },
     { from  => 1154876732, # 2006-08-06 17:05
       until => 1156360698, # 1157061599 2006-08-31 23:59
       text  => 'Invalidenstr. in Richtung Tiergartentunnel, zwischen Ackerstr. und Bergstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 08.2006)',
       type  => 'gesperrt',
       source_id => 'INKO_70880',
       data  => <<EOF,
userdel	1::inwork 9810,14066 9679,14039
EOF
     },
     { from  => 1154815200, # 2006-08-06 00:00
       until => 1164927600, # 2006-12-01 00:00
       text  => 'B 109 B167-Zehdenick OD Falkenthal grundhafter Stra�enbau Vollsperrung 07.08.2006-30.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 2775,56089 2034,55227
EOF
     },
     { from  => 1155420000, # 2006-08-13 00:00
       until => 1159478501, # 1170284400 2007-02-01 00:00
       text  => 'B 167 Friedrich-Engels-Str. OD Alt Ruppin, zw. Rhinbr�cke u. Br�ckenstr. Stra�enbauarbeiten Vollsperrung 14.08.2006-31.01.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -28866,59954 -28641,59609
EOF
     },
     { from  => 1156975200, # 2006-08-31 00:00
       until => 1157320800, # 2006-09-04 00:00
       text  => 'B 167 Frankfurter Str. OL Seelow, zw. breite Str. u. K�striner Str. Stadtfest Vollsperrung 01.09.2006-03.09.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 76771,15413 76986,14860
EOF
     },
     { from  => 1155765600, # 2006-08-17 00:00
       until => 1156197600, # 2006-08-22 00:00
       text  => 'B 005 Abzw. Gro� Gottschow-OU Perleberg Bahn�bergang bei Perleberg Gleissanierung Vollsperrung 18.08.2006-21.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -94722,72190 -94274,71791 -93406,71227
EOF
     },
     { from  => 1156111200, # 2006-08-21 00:00
       until => 1156370400, # 2006-08-24 00:00
       text  => 'B 005 Abzw. Gro� Gottschow-OU Perleberg Bahn�bergang bei Perleberg Gleissanierung Vollsperrung 22.08.2006-23.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -94722,72190 -94274,71791 -93406,71227
EOF
     },
     { from  => 1155664127, # 2006-08-15 19:48
       until => 1159035253, # 2006-09-30 23:59 1159653599
       text  => 'Gr�nbergallee (Treptow) in beiden Richtungen zwischen Am Seegraben und Rosenweg Baustelle, Verkehr wird wechselseitig vorbeigef�hrt (bis Ende 09.2006)',
       type  => 'handicap',
       source_id => 'IM_003258',
       data  => <<EOF,
userdel	q4::inwork 20205,-548 20252,-571 20354,-569 20362,-511
EOF
     },
     { from  => undef, # 
       until => 1157843821, # undef
       text  => 'Havemannstr. (Marzahn) in beiden Richtungen zwischen M�rkische Allee und Borkheider Str. Baustelle, Stra�e vollst�ndig gesperrt',
       type  => 'handicap',
       source_id => 'IM_003255',
       data  => <<EOF,
userdel	q4::inwork 21251,18508 21446,18405 21520,18367 21684,18283 21843,18198
EOF
     },
     { from  => 1155664247, # 2006-08-15 19:50
       until => 1155938400, # 2006-08-19 00:00
       text  => 'Sch�nerlinder Str. (Buchholz) stadteinw�rts zwischen Triftstr. und Bucher Str. Baustelle, Fahrtrichtung gesperrt, eine Umleitung ist eingerichtet (bis 18.08.2006)',
       type  => 'gesperrt',
       source_id => 'IM_003250',
       data  => <<EOF,
userdel	1::inwork 12067,23241 12129,23117 12185,23021
EOF
     },
     { from  => 1155592800, # 2006-08-15 00:00
       until => 1159653600, # 2006-10-01 00:00
       text  => 'B 005 Berliner Str. OD Petershagen, zw. Betonstr. und Ortsausgang Kanal- und Stra�enbauarbeiten Vollsperrung 16.08.2006-30.09.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 73775,831 74197,607
EOF
     },
     { from  => 1155506400, # 2006-08-14 00:00
       until => 1159653600, # 2006-10-01 00:00
       text  => 'K 6411 Neulewin- L 33 Wriezen OL Neulewin, zw. KAP-Stra�e und Dorfstr. Stra�enbau Vollsperrung 15.08.2006-30.09.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 69095,37169 69283,37114
EOF
     },
     { from  => 1155420000, # 2006-08-13 00:00
       until => 1167606000, # 2007-01-01 00:00
       text  => 'K 6418 Garzau-Hohenstein zw. Garzau und Gladowsh�he Stra�enbau Vollsperrung 14.08.2006-31.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 46389,15079 46564,15609 46717,15970 46852,16883
EOF
     },
     { from  => 1155506400, # 2006-08-14 00:00
       until => 1159480800, # 2006-09-29 00:00
       text  => 'K 7239 Diedersdorf-Birkholz OD Diedersdorf, Kno. Birkholzer Str./ Chausseestr. Bau Kreisverkehrsplatz Vollsperrung 15.08.2006-28.09.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 7547,-5739 7399,-7001
EOF
     },
     { from  => 1156024800, # 2006-08-20 00:00
       until => 1159653600, # 2006-10-01 00:00
       text  => 'L 038 zw. Briesen und Petersdorf grundhafter Stra�enbau Vollsperrung 26.09.2006-31.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 70549,-5215 71331,-5118 73292,-4598 74238,-3970 74606,-3837
EOF
     },
     { from  => 1155420000, # 2006-08-13 00:00
       until => 1180648800, # 2007-06-01 00:00
       text  => 'L 141 Neustadt-Bahnhof Zernitz Dossebr�cke in der OL Neustadt Br�ckenneubau Vollsperrung 14.08.2006-31.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -56556,49662 -56487,49318 -56325,49162
EOF
     },
     { from  => 1163530090, # 2006-11-14 19:48
       until => 1164927599, # 2006-11-30 23:59
       text  => 'Rixdorfer Str. (Treptow) Richtung S�dostallee zwischen Schnellerstr. und Kiefholzstr. Baustelle, Fahrtrichtung gesperrt Richtung A113 Auffahrt Sp�thstr. �ber Schnellerstr. - K�penicker Landstr. - Baumschulenstr. (bis Ende 11.2006)',
       type  => 'gesperrt',
       source_id => 'IM_004079',
       data  => <<EOF,
userdel	1::inwork 17290,6228 17239,6182 17156,6235 17056,6133 16868,5938
EOF
     },
     { from  => 1155836502, # 2006-08-17 19:41
       until => 1156129200, # 2006-08-21 05:00
       text  => 'Kurf�rstendamm/Tauentzienstr. (Charlottenburg) in beiden Richtungen zwischen Uhlandstr. und Passauer Str. Stra�enfest (Global City), Stra�e gesperrt (bis 21.08.2006, 5:00 Uhr) (18:00) ',
       type  => 'gesperrt',
       source_id => 'IM_003267',
       data  => <<EOF,
userdel	2::temp 6133,10679 6025,10746 5942,10803 5907,10821 5782,10884 5725,10892 5656,10876 5475,10808 5351,10760 5229,10716 5076,10658
EOF
     },
     { from  => 1156888800, # 2006-08-30 00:00
       until => 1157148000, # 2006-09-02 00:00
       text  => 'L 401 K�nigs Wusterhausen-Wildau OL K�nigs Wusterhausen, H�he Neue Ziegelei Deckeneinbau Vollsperrung 31.08.2006-01.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 26466,-10409 26442,-10452 26429,-10647 26407,-10986
EOF
     },
     { from  => 1156024800, # 2006-08-20 00:00
       until => 1161986400, # 2006-10-28 00:00
       text  => 'B 096 Strelitzer Str. OD Gransee, vom KVK in Ri Altl�dersdorf grundhafter Stra�enbau Vollsperrung 21.08.2006-27.10.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -6382,67186 -7071,66471
EOF
     },
     { from  => 1156024800, # 2006-08-20 00:00
       until => 1160258400, # 2006-10-08 00:00
       text  => 'L 017 K�nigshorst-Warsow zw. Lobeofsund und KG bei Wiesenaue Stra�enbauarbeiten Vollsperrung 21.08.2006-07.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -36125,34218 -34868,34062
EOF
     },
     { from  => 1156456800, # 2006-08-25 00:00
       until => 1156716000, # 2006-08-28 00:00
       text  => 'L 023 Joachimsthal-Britz Br�cke �ber A 11, AS Chorin,westliche Seite Br�ckenabbruch Vollsperrung 26.08.2006-27.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 35962,59463 35405,59832
EOF
     },
     { from  => 1152050400, # 2006-07-05 00:00
       until => 1158013313, # 1159653600 2006-10-01 00:00
       text  => 'L 235 Gielsdorf-Werneuchen Schulstr. in der OL Wegendorf Stra�en- u. Durchlassbau Vollsperrung 06.07.2006-30.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 34492,22176 34321,22151 34125,22128
EOF
     },
     { from  => 1156541009, # 2006-08-25 23:23
       until => 1156820400, # 2006-08-29 05:00
       text  => 'Stra�e des 17. Juni (Tiergarten) in beiden Richtungen zwischen Gro�er Stern und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (einschlie�lich Ebertstr. und Yitzhak-Rabin-Str. (bis 29.08.2006 05:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_003324',
       data  => <<EOF,
userdel	2::temp 8595,12066 8600,12165 8538,12245
userdel	2::temp 8119,12414 8055,12186
EOF
     },
     { from  => 1156358040, # 2006-08-23 20:34
       until => 1158336000, # 2006-09-15 18:00
       text  => 'Berlin Wei�ensee, Buschallee, Wei�ensee Richtung Ahrensfelde Zwischen Einm�ndung Berliner Allee und Kreuzung Hansastra�e Baustelle, gesperrt bis 15.09.2006 18:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 14621,16563 14809,16525 15134,16499 15142,16499 15388,16502 15432,16500
EOF
     },
     { from  => 1156478400, # 2006-08-25 06:00
       until => 1156716000, # 2006-08-28 00:00
       text  => 'Stra�enfest am Kaiserdamm. Die Fahrbahn Richtung Theodor-Heuss-Platz ist vom 26.08.2006, 6.00 Uhr, von der Sophie-Charlotten- bis zur K�nigin-Elisabeth-Stra�e bis zum 28.08.2006, 0.00 Uhr gesperrt.',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::temp 2609,11503 2391,11478 2282,11463 2191,11451 2109,11441
EOF
     },
     { from  => 1156454823, # 2006-08-24 23:27
       until => 1156802399, # 2006-08-28 23:59
       text  => 'Vom 26. August 2006, 13 Uhr bis zum 28. August 2006, 4 Uhr ist der Verkehr in der M�llendorffstra�e im Abschnitt zwischen der Stra�e Am Containerbahnhof und der Frankfurter Allee gesperrt.',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 15361,12071
EOF
     },
     { from  => 1154815200, # 2006-08-06 00:00
       until => 1164927599, # 2006-11-30 23:59
       text  => 'Hegemeisterweg ist vom 7. August 2006 bis zum 30. November 2006 nicht benutzbar. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 17771,7880 17987,7973 18287,7815 18325,7778 18382,7724
EOF
     },
     { from  => 1156975200, # 2006-08-31 00:00
       until => 1157320799, # 2006-09-03 23:59
       text  => 'Turmstra�enfest vom 01.09. bis 03.09.2006 (zwischen Strom- und Waldstra�e) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 5368,13406 5560,13382 5569,13381 5705,13359 5857,13342 5956,13330 6011,13330 6105,13328 6115,13328 6228,13324
EOF
     },
     { from  => 1156456800, # 2006-08-25 00:00
       until => 1156716000, # 2006-08-28 00:00
       text  => 'B 112 Guben, OT Bresinchen Guben, OT Bresinchen, Bahn�bergang Gleisbauarbeiten Vollsperrung 26.08.2006-27.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 99176,-43536 99245,-43974 99228,-44346
EOF
     },
     { from  => 1156629600, # 2006-08-27 00:00
       until => 1164927600, # 2006-12-01 00:00
       text  => 'L 030 R�dersdorfer Str. OD Woltersdorf Stra�enbau, Entw�sserung Vollsperrung 28.08.2006-30.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 34535,5319 34579,5745
EOF
     },
     { from  => 1156629600, # 2006-08-27 00:00
       until => 1156975200, # 2006-08-31 00:00
       text  => 'L 073 OD Luckenwalde OD Luckenwalde, Beelitzer Str., Gewerbehof Aufstellung Autodrehkran Halbseitige Sperrung 28.08.2006-30.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork -4725,-34957 -4299,-35198
EOF
     },
     { from  => 1156629600, # 2006-08-27 00:00
       until => 1164927600, # 2006-12-01 00:00
       text  => 'L 811 OA Oehna - Landesgrenze Sachsen-A. OA Oehna - Landesgrenze Sachsen-A. Stra�enausbau Vollsperrung 28.08.2006-30.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -13946,-56116 -13817,-54938
EOF
     },
     { from  => 1156792939, # 2006-08-28 21:22
       until => 1159653599, # 2006-09-30 23:59
       text  => 'Leibnizstr. (Charlottenburg) Richtung Kantstr. zwischen Otto-Suhr-Allee und Bismarckstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 09/2006)',
       type  => 'gesperrt',
       source_id => 'IM_003108',
       data  => <<EOF,
userdel	1::inwork 4359,11979 4345,11710
EOF
     },
     { from  => 1156793020, # 2006-08-28 21:23
       until => 1158012000, # 2006-09-12 00:00
       text  => 'Wilhelminenhofstr. (Obersch�neweide) Richtung Edisonstr. zwischen Rathenaustr. und Edisonstr. Baustelle, Fahrtrichtung gesperrt (bis 11.09.2006)',
       type  => 'gesperrt',
       source_id => 'IM_003370',
       data  => <<EOF,
userdel	1::inwork 18861,6000 18843,6013 18766,6067 18670,6132 18574,6197 18473,6265 18423,6285 18343,6318 18191,6363 17992,6436
EOF
     },
     { from  => 1160949600, # 2006-10-16 00:00
       until => 1191189600, # 2007-10-01 00:00
       text  => 'B 097 Dresdener Str. Br�cke ober DB im OT Schwarze Pumpe Br�ckenneubau Vollsperrung 17.10.2006-30.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 75459,-98456 75933,-97371
EOF
     },
     { from  => 1156975200, # 2006-08-31 00:00
       until => 1157234400, # 2006-09-03 00:00
       text  => 'L 071 B179-Krausnick zw. Hauptstr., OL Leibsch u. Gro� Wasserburg Deckenerneuerung Vollsperrung 01.09.2006-02.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 42023,-37573 42768,-36320 43112,-36134 43262,-35804
EOF
     },
     { from  => 1164236400, # 2006-11-23 00:00
       until => 1166828400, # 2006-12-23 00:00
       text  => 'L 075 Karl-Marx-Str. OD Gro�ziehten Stra�enbauarbeiten Vollsperrung 24.11.2006-22.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 13225,-681 13215,-570 13176,-161 13165,-34 13124,216 12984,1011
EOF
     },
     { from  => 1156629600, # 2006-08-27 00:00
       until => 1185919200, # 2007-08-01 00:00
       text  => 'L 201 OD Falkensee OD Falkensee, Falkenhagener Str. Stra�enbau Vollsperrung 28.08.2006-31.07.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -10661,17873 -10806,17958 -10926,17992
EOF
     },
     { from  => 1156976097, # 2006-08-31 00:14
       until => 1167605999, # 2006-12-31 23:59
       text  => 'Hauptstr. (Pankow) in beiden Richtungen, in H�he Edelwei�str., zwischen Goethestr. und Garibaldistr. Baustelle, Verkehr wird wechselseitig vorbeigef�hrt (bis Ende 2006)',
       type  => 'handicap',
       source_id => 'INKO_84070',
       data  => <<EOF,
userdel	q4::inwork 7832,20219 7790,20132 7748,20040 7711,19956
EOF
     },
     { from  => undef, # 
       until => Time::Local::timelocal(reverse(2007-1900,7-1,9,0,0,0)), # 1185833757, # 2007-07-31 00:15
       text  => 'Pistoriusstr. (Pankow) Richtung Berliner Allee zwischen Hamburger Platz und Roelckstr. Baustelle, Fahrtrichtung gesperrt, eine Umleitung ist eingerichtet (bis Mitte 2007) (10:34) ',
       type  => 'gesperrt',
       source_id => 'INKO_77722',
       data  => <<EOF,
userdel	1::inwork 12713,16682 12857,16627 13104,16522
EOF
     },
     { from  => 1156976256, # 2006-08-31 00:17
       until => 1157580000, # 2006-09-07 00:00
       text  => 'Regattastr. (K�penick) in beiden Richtungen zwischen Rabindranath-Tagore-Str. und Steinbindeweg Baustelle, Stra�e vollst�ndig gesperrt (bis 06.09.2006)',
       type  => 'gesperrt',
       source_id => 'IM_003411',
       data  => <<EOF,
userdel	2::inwork 23252,792 23085,898
EOF
     },
     { from  => 1157493600, # 2006-09-06 00:00
       until => 1157752800, # 2006-09-09 00:00
       text  => 'B 096 Bahn�bergang Neuhof Gleisbauarbeiten Vollsperrung 07.09.2006-08.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 16407,-29400 16379,-29446 16360,-29489
EOF
     },
     { from  => 1156975200, # 2006-08-31 00:00
       until => 1157320800, # 2006-09-04 00:00
       text  => 'B 112 Spremberger Str. OD Forst Brandenburgtag Vollsperrung 01.09.2006-03.09.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 96181,-72790
EOF
     },
     { from  => 1156888800, # 2006-08-30 00:00
       until => 1157320800, # 2006-09-04 00:00
       text  => 'L 049 Triebeler Str. OD Forst Brandenburgtag Vollsperrung 31.08.2006-03.09.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 96181,-72790 96424,-73412
EOF
     },
     { from  => 1157061600, # 2006-09-01 00:00
       until => 1157234400, # 2006-09-03 00:00
       text  => 'B 102 Gro�e Milower Str. OD Rathenow, zw. Eigendorfstr. u. Gr�nauer Weg Neub. B188n, Mont. Stahltr�ger Vollsperrung 02.09.2006-02.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -62217,19221 -62290,19904 -62333,20390
EOF
     },
     { from  => 1156975200, # 2006-08-31 00:00
       until => 1157320800, # 2006-09-04 00:00
       text  => 'L 015 B109 s�dl. Prenzlau-Boitzenburg OD Gollmitz Einbau Deckschicht Vollsperrung 01.09.2006-03.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30789,99365 30482,99609
EOF
     },
     { from  => 1157138648, # 2006-09-01 21:24
       until => 1157335200, # 2006-09-04 04:00
       text  => 'Landsberger Allee (Friedrichshain - Kreuzberg) in Richtung stadteinw�rts zwischen Virchowstr. und Friedensstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 04.09.2006 4.00 Uhr)',
       type  => 'handicap',
       source_id => 'INKO_83350',
       data  => <<EOF,
userdel	q4::inwork; 12979,13280 12878,13229 12786,13185 12685,13135 12585,13118 12382,13097
EOF
     },
     { from  => 1158618023, # 2006-09-19 00:20
       until => 1158870956, # 1175378399 2007-03-31 23:59
       text  => 'Br�ckenstr. (Mitte) Richtung Heinrich-Heine-Str. zwischen Holzmarktstr. und K�penicker Str. Baustelle Fahrtrichtung gesperrt: Holzmarktstr. - Michaelkirchstr. - K�penicker Str. (bis 03.2007) (Radfahrer haben eine separate Spur laut http://www.stadtentwicklung.berlin.de/aktuell/pressebox/archiv_volltext.shtml?arch_0608/nachricht2411.html)',
       type  => 'gesperrt',
       source_id => 'IM_003436',
       data  => <<EOF,
userdel	1::inwork 11351,12221 11347,12181 11325,12021 11283,11876 11242,11720
EOF
     },
     { from  => 1159826400, # 2006-10-03 00:00
       until => 1167519600, # 2006-12-31 00:00
       text  => 'B 096 a zw. OL Schildow, Hauptstr. u. Sch�nflie�, Dorfstr. Deckenerneuerung Vollsperrung 04.10.2006-30.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 8021,26285 7395,26862
EOF
     },
     { from  => 1157234400, # 2006-09-03 00:00
       until => 1159567200, # 2006-09-30 00:00
       text  => 'L 010 Havelberger Str. OD Bad Wilsnack Kanal- und Stra�enbau halbseitig gesperrt; Einbahnstra�e 04.09.2006-29.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork -89549,58784 -89568,59293
EOF
     },
     { from  => 1157234400, # 2006-09-03 00:00
       until => 1157580000, # 2006-09-07 00:00
       text  => 'L 401 R.-Sorge-Str./ Bergstr. Bahn�bergang Bergstr. in OL Wildau Arbeiten am B� Vollsperrung; Umleitung 04.09.2006-06.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 26432,-10043 26285,-10054 26262,-10015 26262,-9880 26174,-9760 26093,-9701 25991,-9671 25805,-9553
EOF
     },
     { from  => 1157576473, # 2006-09-06 23:01
       until => 1167605999, # 2006-12-31 23:59
       text  => 'Uhlandstr. (Charlottenburg) in Richtung S�den, zwischen Steinplatz und Kantstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 2006)',
       type  => 'gesperrt',
       source_id => 'IM_003491',
       data  => <<EOF,
userdel	1::inwork 5122,11300 5102,11006
EOF
     },
     { from  => 1157666400, # 2006-09-08 00:00
       until => 1164927600, # 2006-12-01 00:00
       text  => 'L 861 Damsdorf-B 1 Plessow OD G�hlsdorf, Hauptstr., Pl�tziner Str. Kanal- und Stra�enbau Vollsperrung 09.09.2006-30.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -29624,-5855 -29900,-5879 -30199,-5774
EOF
     },
     { from  => 1158876000, # 2006-09-22 00:00
       until => 1159308000, # 2006-09-27 00:00
       text  => 'B 246 N�chst Neuendorfer Chaussee Bahn�bergang in der OL Zossen Gleisbauarbeiten Vollsperrung 23.09.2006-26.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 13526,-20548 13412,-20513 13326,-20518
EOF
     },
     { from  => 1159999200, # 2006-10-05 00:00
       until => 1160344800, # 2006-10-09 00:00
       text  => 'L 030 Spreebordstra�e OL Neu Zittau Deckeneinbau Vollsperrung 06.10.2006-08.10.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 33839,-1057 33773,-1116 33628,-1509
EOF
     },
     { from  => 1140303600, # 2006-02-19 00:00
       until => 1164927600, # 2006-12-01 00:00
       text  => 'B 096 Gransee-F�rstenberg Br�cke �ber Wentowkanal bei Dannenwalde Br�ckenabri�- u. -neubau Vollsperrung 20.02.2006-30.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -5962,74421 -6037,73865
EOF
     },
     { from  => 1152482400, # 2006-07-10 00:00
       until => 1166742000, # 2006-12-22 00:00
       text  => 'L 014 Gro�derschau-Kyritz Br�cke �ber den Graben bei Babe Br�ckenneubau Vollsperrung 11.07.2006-21.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -64545,43296 -63700,42146
EOF
     },
     { from  => 1157695483, # 2006-09-08 08:04
       until => 1158012000, # 2006-09-12 00:00
       text  => 'Pablo-Neruda-Str. (K�penick) in beiden Richtungen, zwischen M�ggelheimer Damm und Salvador-Allende-Str. Baustelle, Stra�e vollst�ndig gesperrt (bis 11.09.06)',
       type  => 'gesperrt',
       source_id => 'IM_003518',
       data  => <<EOF,
userdel	2::inwork 22965,4124 23435,4179
EOF
     },
     { from  => 1157839200, # 2006-09-10 00:00
       until => 1167606000, # 2007-01-01 00:00
       text  => 'K 6722 B246 Bornow-Gro� Rietz OD Birkholz Stra�enneubau Vollsperrung 11.09.2006-31.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 64924,-23029 65076,-22519
EOF
     },
     { from  => 1158444000, # 2006-09-17 00:00
       until => 1164927600, # 2006-12-01 00:00
       text  => 'K 6801 Berliner Str. OL Fehrbellin, zw. Brunner Str. u. Ruppiner Str. Stra�ensanierung Vollsperrung 18.09.2006-30.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -33790,44573 -33927,44655
EOF
     },
     { from  => 1158618096, # 2006-09-19 00:21
       until => 1164927599, # 2006-11-30 23:59
       text  => 'Lindenberger Str. (Hohensch�nhausen) in beiden Richtungen zwischen Fennpfuhlweg und Birkholzer Weg F�r beide Richtungen nur ein Fahrstreifen abwechselnd frei (bis Ende 11.2006)',
       type  => 'handicap',
       source_id => 'IM_003182',
       data  => <<EOF,
userdel	q4::inwork 18061,19097 18066,19143 18074,19227 18109,19352
EOF
     },
     { from  => 1159826400, # 2006-10-03 00:00
       until => 1165618800, # 2006-12-09 00:00
       text  => 'B 002 Eberswalde-Angerm�nde zw. Abzw. Britz und B� Chorin Deckenerneuerung Vollsperrung 04.10.2006-08.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 38845,51258 39131,51605 39815,52159 40945,53204 41075,53327 41587,53787 41654,53939 41706,54055 41777,54435 41847,54619 42231,54671 42595,54932 42742,54938 42749,55043 42452,55538 42451,55679 42840,56726 42981,57104 43462,57600 43581,57725
EOF
     },
     { from  => 1136674800, # 2006-01-08 00:00
       until => 1160001773, # 1167519600 2006-12-31 00:00 MISMATCHED COORDS!
       text  => 'B 096 Hauptstr., Zossener Str. OD Baruth Kanal- und Stra�enbau Vollsperrung 09.01.2006-30.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -4134,38068 -4009,38126
EOF
     },
     { from  => 1158876000, # 2006-09-22 00:00
       until => 1159135200, # 2006-09-25 00:00
       text  => 'L 238 Eberswalde-Joachimsthal Br�cke der A 11 zw. Lichterfelde u. Altenhof Br�ckenabbruch Vollsperrung 23.09.2006-24.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30773,54731 31065,54239
EOF
     },
     { from  => 1158865257, # 2006-09-21 21:00
       until => 1159156800, # 2006-09-25 06:00
       text  => 'Stra�e des 17. Juni und Yitzak-Rabin-Str. wegen Marathonvorbereitungen gesperrt (bis 25.09.06, 06.00 Uhr)',
       type  => 'handicap',
       source_id => 'IM_003565',
       data  => <<EOF,
userdel	q4::temp 8538,12245 8303,12216 8214,12205 8089,12190
userdel	q4::temp 8119,12414 8055,12186 7816,12150 7383,12095 6828,12031
EOF
     },
     { from  => 1157234400, # 2006-09-03 00:00
       until => 1166828400, # 2006-12-23 00:00
       text  => 'K 6947 Dorfstra�e OT Gr�ningen Stra�enbau Vollsperrung 04.09.2006-22.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -53945,-12911 -54243,-12956
EOF
     },
     { from  => 1159207426, # 2006-09-25 20:03
       until => 1164656966, # 2006-12-02 00:00 1165014000
       text  => 'Hohensch�nhauser Str. (Hohensch�nhausen), zwischen Nordring und Bitterfelder Str. Baustelle, Fahrtrichtung gesperrt (bis 01.12.06)',
       type  => 'gesperrt',
       source_id => 'IM_003679',
       data  => <<EOF,
userdel	1::inwork 19524,17896 19152,17405 18738,16957
EOF
     },
     { from  => 1159207506, # 2006-09-25 20:05
       until => 1160414935, # 1160949599 2006-10-15 23:59 (nichts zu erkennen)
       text  => 'Maybachufer (Neuk�lln) in beiden Richtungen zwischen Pannierstr. und Harzer Str. Baustelle, Stra�e vollst�ndig gesperrt (bis Mitte 10.2006)',
       type  => 'gesperrt',
       source_id => 'IM_003672',
       data  => <<EOF,
userdel	2::inwork 12844,9351 12764,9433 12563,9536
EOF
     },
     { from  => 1160172484, # 2006-10-07 00:08
       until => 1160604000, # 2006-10-12 00:00
       text  => 'Stargarder Str. (Prenzlauer Berg) Richtung Sch�nhauser Allee zwischen Pappelallee und Greifenhagener Str. Baustelle, Fahrtrichtung gesperrt (bis 11.10.2006)',
       type  => 'gesperrt',
       source_id => 'IM_003670',
       data  => <<EOF,
userdel	1::inwork 11301,15668 11158,15739 11086,15772
EOF
     },
     { from  => 1166569200, # 2006-12-20 00:00
       until => 1166742000, # 2006-12-22 00:00
       text  => 'B 096 Baruth-W�nsdorf Bahn�bergang in deer OD Neuhof Stra�enbauarbeiten Vollsperrung 21.12.2006-21.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 16407,-29400 16379,-29446 16360,-29489
EOF
     },
     { from  => 1160414834, # 2006-10-09 19:27
       until => 1162335600, # 2006-11-01 00:00
       text  => 'Rixdorfer Str. (Treptow ) in Richtung Kiefholzstr., zwischen S�dostallee und Schnellerstr. Baustelle, Fahrtrichtung gesperrt (bis 31.10.06)',
       type  => 'gesperrt',
       source_id => 'IM_003692',
       data  => <<EOF,
userdel	1::inwork 17156,6235 17056,6133 16868,5938
EOF
     },
     { from  => 1159221600, # 2006-09-26 00:00
       until => 1161208800, # 2006-10-19 00:00
       text  => 'B 168 zw. Trampe und Eberswalde Deckenerneuerung Vollsperrung 27.09.2006-18.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 38504,47638 38653,47410 38683,47327 38746,46954 39350,42740 39361,42665 39355,42506
EOF
     },
     { from  => 1159426800, # 2006-09-28 09:00
       until => 1159934400, # 2006-10-04 06:00
       text  => 'Stra�e des 17. Juni zwischen Yitzhak-Rabin-Str.(ausschl.) und Ebertstr.(einschl.), Platz des 18. M�rz und Pariser Platz, Ebertstr. zwischen Behrenstr. und Scheidemannstr. sowie Scheidemannstr./Dorotheenstr. zwischen Yitzhak-Rabin-Str. und Wilhelmstr. gesperrt f�r das Deutschlandfest. Dauer: 29.09.2006 09:00 Uhr bis 04.10.2006 06:00 Uhr. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8055,12186 8089,12190 8214,12205 8303,12216 8538,12245 8546,12279 8570,12302 8573,12325 8540,12420
userdel	2::temp 8610,12254 8538,12245 8600,12165 8595,12066
EOF
     },
     { from  => 1159653600, # 2006-10-01 00:00
       until => 1166648768, # 1167606000 2007-01-01 00:00
       text  => 'B 109 C.-Zetkin-Stra�e OL Zehdenick, zw. Liebknechtstr. u. Falkenthaler Ch. Kanal-/Stra�enbau halbseitig gesperrt; Einbahnstra�e 02.10.2006-31.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 4478,63369 4801,63458 4948,63424
EOF
     },
     { from  => 1159999200, # 2006-10-05 00:00
       until => 1160431200, # 2006-10-10 00:00
       text  => 'K 6425 Rudolf-Breitscheid-Allee OD Neuenhagen, zw. Hohe Allee u. Virchowstra�e Stra�enbauarbeiten Vollsperrung 06.10.2006-09.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 29093,13456 28575,12975
EOF
     },
     { from  => 1159912800, # 2006-10-04 00:00
       until => 1163804400, # 2006-11-18 00:00
       text  => 'L 040 Zossener Damm OD Blankenfelde Stra�enausbau Vollsperrung 05.10.2006-28.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 11115,-8466 11247,-8513 11555,-8625
EOF
     },
     { from  => 1159308000, # 2006-09-27 00:00
       until => 1165952561, # 1166828400 2006-12-23 00:00
       text  => 'L 304 AS Bernau Nord - B273 AS Bernau Nord - B273 Stra�enbau Vollsperrung 28.09.2006-22.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 18242,34708 18717,34274 19290,33278
EOF
     },
     { from  => 1159653600, # 2006-10-01 00:00
       until => 1160258400, # 2006-10-08 00:00
       text  => 'L 362 M�ncheberg-Wulkow OD Obersdorf Kanal- u. Str.bau,Deckeneibau Vollsperrung 02.10.2006-07.10.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 62099,16389 62294,16249
EOF
     },
     { from  => 1161295200, # 2006-10-20 00:00
       until => 1162508400, # 2006-11-03 00:00
       text  => 'L 020 R.-Luxemburg-Str. OD Velten, Bahn�bergang Arbeiten am Gleisk�rper Vollsperrung 21.10.2006-02.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -5368,30480 -5417,30402 -5496,30288
EOF
     },
     { from  => 1159693063, # 2006-10-01 10:57
       until => 1159916400, # 2006-10-04 01:00
       text  => 'Residenzstr. (Wedding) in beiden Richtungen, zwischen Lindauer Allee und Pankower Allee Veranstaltung, Stra�e vollst�ndig gesperrt (bis 04.10.06, 01.00 Uhr) ',
       type  => 'gesperrt',
       source_id => 'IM_003701',
       data  => <<EOF,
userdel	2::temp 7579,17532 7572,17558 7540,17675 7491,17793 7477,17832 7453,17899 7432,17964 7426,17981 7405,18047 7335,18257 7291,18392 7269,18460 7233,18562 7198,18575
EOF
     },
     { from  => 1221024854, #  undef
       until => 1221024859, # Time::Local::timelocal(reverse(2008-1900,9-1,13,0,0,0)), # laut Tsp vom 2008-01-22
       text  => 'Bau der O2-World, bis 13. September 2008',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 13056,11329 13240,11279 13150,11101
EOF
     },
     { from  => 1159135200, # 2006-09-25 00:00
       until => 1166655600, # 2006-12-21 00:00
       text  => 'B 101 zw. Wiederau und Krz. Friedrichsluga Stra�enbau Richtungsverkehr 26.09.2006-20.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 5339,-84725 4072,-82982 2952,-81725
EOF
     },
     { from  => 1159480800, # 2006-09-29 00:00
       until => 1161036000, # 2006-10-17 00:00
       text  => 'B 002 Stettiner Str. OD Gartz, Knotenpunkt Stettiner-/Scheunenstra�e Ausbau Knotenpunkt Vollsperrung 30.09.2006-16.10.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 76131,90452 76075,90647 76243,92954
EOF
     },
     { from  => 1159826400, # 2006-10-03 00:00
       until => 1160604000, # 2006-10-12 00:00
       text  => 'B 101 Promenade zw. Einmdg. Hauptstra�e u. Elsterstra�e Arbeit an Gashauptleitung Vollsperrung 04.10.2006-11.10.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 20952,-105585 21037,-105607
EOF
     },
     { from  => 1159048800, # 2006-09-24 00:00
       until => 1161640800, # 2006-10-24 00:00
       text  => 'B 169 Elsterwerdaer Str. OD Pr�sen, Bahn�bergang Stra�enbau Vollsperrung 25.09.2006-23.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 19076,-108365 19683,-108408
EOF
     },
     { from  => 1160344800, # 2006-10-09 00:00
       until => 1160604000, # 2006-10-12 00:00
       text  => 'B 096 Luckau - Gie�mannssdorf zw. OU Luckau u. Zickauer Chaussee (Gie�mannsdorf) Deckeneinbau Vollsperrung 10.10.2006-11.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 32029,-59469 31903,-59042 31588,-58443 31525,-58272
EOF
     },
     { from  => 1159999200, # 2006-10-05 00:00
       until => 1160431200, # 2006-10-10 00:00
       text  => 'K 6417 Garzin - Garzau Abzwg. Agrargenossenschaft Deckenschluss Vollsperrung 06.10.2006-09.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 47968,14759 49278,15634
EOF
     },
     { from  => 1159135200, # 2006-09-25 00:00
       until => 1167606000, # 2007-01-01 00:00
       text  => 'L 038 zw. Briesen und Petersdorf grundhafter Stra�enbau Vollsperrung 26.09.2006-31.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 70549,-5215 71331,-5118 73292,-4598 74238,-3970 74606,-3837
EOF
     },
     { from  => 1155938400, # 2006-08-19 00:00
       until => 1162249200, # 2006-10-31 00:00
       text  => 'L 021 Z�hlslake-Wensickendorf Kreuzung. Summter Chaussee bei Z�hlslake Neubau Kreisverkehr Vollsperrung 20.08.2006-30.10.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 7431,34989 7456,36042 7454,36156
EOF
     },
     { from  => 1159653600, # 2006-10-01 00:00
       until => 1160863200, # 2006-10-15 00:00
       text  => 'L 015 Linow - Dorf Zechlin Linow - Dorf Zechlin, n�rdl. OE/OA Linow Ersatzneubau Durchlass Vollsperrung 02.10.2006-14.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -30855,77227 -30302,77196
EOF
     },
     { from  => 1159999200, # 2006-10-05 00:00
       until => 1160258400, # 2006-10-08 00:00
       text  => 'B 101 Dresdener Stra�e Bahn�bergang Gleisbauarbeiten Vollsperrung 06.10.2006-07.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 9220,-90110 9342,-90771 9366,-90900
EOF
     },
     { from  => 1159826400, # 2006-10-03 00:00
       until => 1161381600, # 2006-10-21 00:00
       text  => 'B 096 R�dingsdorf - Abzweig Jetsch 1km n�rdl. R�dingsdorf - Einmdg. Jetsch Fahrbahnsanierung Vollsperrung 04.10.2006-20.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 29918,-54610 29514,-52871
EOF
     },
     { from  => 1153605600, # 2006-07-23 00:00
       until => 1175292000, # 2007-03-31 00:00
       text  => 'K 6904 Gr�ben-KG-K6903 Nudow zw. Abzw. Nudow und Fahlhorst Bau Eisenbahn�berf�hrung Vollsperrung 24.07.2006-30.03.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -6631,-9207 -6223,-10366
EOF
     },
     { from  => 1159826400, # 2006-10-03 00:00
       until => 1160863200, # 2006-10-15 00:00
       text  => 'L 018 L 16 n�rdl. Neuruppin-AS Herzsprung gesamte OD Rossow bis H�he Fretzdorf Deckenerneuerung Vollsperrung 04.10.2006-14.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -48354,72564 -48057,70618
EOF
     },
     { from  => 1159912800, # 2006-10-04 00:00
       until => 1160863200, # 2006-10-15 00:00
       text  => 'L 037 Frankfurter Stra�e Br�cke, Oder-Spree-Kanal Br�ckensanierungsarbeiten Vollsperrung 05.10.2006-14.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 80122,-15845 80061,-15988 79932,-16207 79861,-16543
EOF
     },
     { from  => 1164916572, # 2006-11-30 20:56
       until => 1165618800, # 2006-12-09 00:00
       text  => 'Leibnizstr. (Charlottenburg ) in Richtung S�d,, zwischen Otto-Suhr-Allee und Bismarckstr. Baustelle, Fahrtrichtung gesperrt (bis 08.12.2006)',
       type  => 'gesperrt',
       source_id => 'IM_003744',
       data  => <<EOF,
userdel	1::inwork 4359,11979 4345,11710
EOF
     },
     { from  => $isodate2epoch->("2013-05-31 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-06-02 23:59:59"),
       periodic => 1,
       text  => 'Akazienstr. zwischen Apostel-Paulus-Str. und Grunewaldstr. Veranstaltung (Primavera), Stra�e vollst�ndig gesperrt (1.6.2013 und 2.6.2013)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 7110,9024 7044,9163 7022,9211 7006,9282
EOF
     },
     { from  => 1160214244, # 2006-10-07 11:44
       until => 1160258400, # 2006-10-08 00:00
       text  => 'Hermannstr. (Neuk�lln) in beiden Richtungen, zwischen Werbellinstr. und Thomasstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 08.10.06, 00.00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_003771',
       data  => <<EOF,
userdel	2::temp 11979,8014 12001,7937 12025,7852 12041,7788 12055,7751 12075,7696 12081,7679 12090,7651 12122,7553 12158,7449 12180,7387
EOF
     },
     { from  => 1160107200, # 2006-10-06 06:00
       until => 1161360000, # 2006-10-20 18:00
       text  => 'Ehrlichstra�e zwischen Trautenauerstra�e und Blockdammweg gesperrt. Dauer 07.10.2006 06:00 Uhr bis 20.10.2006 18:00 Uhr. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 17729,8850 17879,8773 17929,8742 17997,8695 18009,8687 18086,8634 18151,8589
EOF
     },
     { from  => $isodate2epoch->("2013-10-04 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-10-06 23:59:59"),
       periodic => 1,
       text  => 'Sch�neberger K�rbisfest, Akazienstra�e gesperrt, 5. und 6.10.2013',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 7006,9282 7022,9211 7044,9163 7110,9024
EOF
     },
     { from  => 1160517600, # 2006-10-11 00:00
       until => 1160776800, # 2006-10-14 00:00
       text  => 'B 087 Luckau - Duben zwischen OA Duben u. Abzweig Freiimfelde (Altenoer Str.) Fahrbahnsanierung Vollsperrung 12.10.2006-13.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 39767,-55820 39355,-56021 39151,-56024 37549,-57430 36050,-58754
EOF
     },
     { from  => 1160431200, # 2006-10-10 00:00
       until => 1164927600, # 2006-12-01 00:00
       text  => 'L 017 Schwante-Staffelde OD Gro� Ziethen Kanalarbeiten Vollsperrung 11.10.2006-30.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -17150,35462 -16293,35362 -16087,35343 -15837,35537
EOF
     },
     { from  => 1159826400, # 2006-10-03 00:00
       until => 1166655600, # 2006-12-21 00:00
       text  => 'L 029 Oderberg-Niederfinow OD Liepe grundhafter Stra�enbau Vollsperrung 04.10.2006-20.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 48662,51337 49039,51453 49211,51421 49875,51562
EOF
     },
     { from  => 1159826400, # 2006-10-03 00:00
       until => 1165014000, # 2006-12-02 00:00
       text  => 'L 040 Chausseestra�e OD Diedersdorf, zw. Bhf.- u. Mahlower Str. Grundhafter Ausbau Vollsperrung 04.10.2006-01.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 7558,-7093 7981,-7165 9170,-7708
EOF
     },
     { from  => 1160863200, # 2006-10-15 00:00
       until => 1163631600, # 2006-11-16 00:00
       text  => 'L 863 B 5 Wustermark-L 86 Ketzin OD Wernitz Stra�en- u. Radwegbau Vollsperrung 16.10.2006-15.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -22149,16586 -22959,16242 -24275,15746
EOF
     },
     { from  => 1161295200, # 2006-10-20 00:00
       until => 1161468000, # 2006-10-22 00:00
       text  => 'B 102 Milower Landstra�e Bahn�bergang in der OD Rathenow Gleisbauarbeiten Vollsperrung 21.10.2006-21.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -62217,19221 -62290,19904
EOF
     },
     { from  => 1160431200, # 2006-10-10 00:00
       until => 1166828400, # 2006-12-23 00:00
       text  => 'L 011 Wittenberger Str. OD Bad Wilsnack, zw. Karthanebr�cke u. Wedenstr. Kanal- und Stra�enbau Vollsperrung 11.10.2006-22.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -91452,59580 -89568,59293
EOF
     },
     { from  => 1160517600, # 2006-10-11 00:00
       until => 1160690400, # 2006-10-13 00:00
       text  => 'L 027 Woltersdorfer Str. Bahn�bergang in der OL Casekow Gleisbauarbeiten Vollsperrung 12.10.2006-12.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 63363,90636 63491,90572
EOF
     },
     { from  => 1160949600, # 2006-10-16 00:00
       until => 1162594800, # 2006-11-04 00:00
       text  => 'L 281 Neureetz-Altranft zw. Croustillier und Br�cke �ber Alte Oder Deckenerneuerung Vollsperrung 17.10.2006-03.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 56925,41800 58564,43539
EOF
     },
     { from  => 1160708400, # 2006-10-13 05:00
       until => 1160949600, # 2006-10-16 00:00
       text  => 'Karl-Marx-Stra�e, Stra�enfest zwischen Flughafenstr. und Thomasstr, gesperrt, Dauer: 14.10.2006 05:00 Uhr bis 16.10.2006 00:00 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 12500,8504 12540,8458 12562,8432 12582,8408 12598,8390 12639,8344 12689,8289 12714,8249 12753,8187 12794,8103 12830,8031 12865,7923 12898,7832 12914,7785 12974,7598
EOF
     },
     { from  => 1161032658, # 2006-10-16 23:04
       until => 1175378400, # 2007-04-01 00:00
       text  => 'Glinkastr. (Mitte) in Richtung Leipziger Str., zwischen J�gerstr. und Taubenstr. Baustelle, Fahrtrichtung gesperrt (bis 31.03.2007)',
       type  => 'gesperrt',
       source_id => 'IM_003833',
       data  => <<EOF,
userdel	1::inwork 9201,11968 9208,11872
EOF
     },
     { from  => 1161032728, # 2006-10-16 23:05
       until => 1162421999, # 2006-11-01 23:59
       text  => 'Lichterfelder Ring (Steglitz ) in beiden Richtungen, zwischen Sch�tte-Lanz-Str. - Sarntaler Weg Baustelle, Stra�e vollst�ndig gesperrt (bis Anfang November 2006)',
       type  => 'gesperrt',
       source_id => 'IM_003834',
       data  => <<EOF,
userdel	2::inwork 5907,519 5836,509 5584,475
EOF
     },
     { from  => 1157234400, # 2006-09-03 00:00
       until => 1164927600, # 2006-12-01 00:00
       text  => 'K 6003 Friedrichswalde-L100 Gollin zw. Friedrichswalde und Kreisgrenze Stra�enbau Vollsperrung 04.09.2006-30.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 28795,69970 28214,70120 27727,70536 26843,71276 26511,71453
EOF
     },
     { from  => 1152050400, # 2006-07-05 00:00
       until => 1173999600, # 2007-03-16 00:00
       text  => 'L 029 Wandlitz-Schmachtenhagen OD Zehlendorf grundhafter Stra�enbau Vollsperrung 06.07.2006-15.03.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 8332,41982 8439,41992 8504,41998 8521,41998 8600,42004 8696,42028
EOF
     },
     { from  => 1161381600, # 2006-10-21 00:00
       until => 1161467999, # 2006-10-21 23:59
       text  => '21.10.2006 (Samstag): Vollsperrung der Jannowitzbr�cke (Demontage von Stahlbetonteilen)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 11347,12181 11325,12021
EOF
     },
     { from  => 1159826400, # 2006-10-03 00:00
       until => 1185914821, # 2007-09-01 00:00 1188597600
       text  => 'Vollsperrung der Springbornstra�e. Dauer: 04.10.2006 bis 31.08.2007. ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 16942,3579 17034,3517 17142,3393
EOF
     },
     { from  => 1161197339, # 2006-10-18 20:48
       until => 1161995611, # 2006-11-01 00:00 1162335600
       text  => 'Ringbahnstra�e zwischen Manteuffelstra�e und Sch�neberger Stra�e gesperrt, Fahrbahnarbeiten bis 31.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 8717,6965 8447,6964
EOF
     },
     { from  => 1161036000, # 2006-10-17 00:00
       until => 1161381600, # 2006-10-21 00:00
       text  => 'L 033 Altlandsberger Chaussee zw. Abzw. Strausberg Stadt und Kno. Garzauer Chausse Deckenschluss Vollsperrung 18.10.2006-20.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 41193,17512 40712,16743
EOF
     },
     { from  => 1161036000, # 2006-10-17 00:00
       until => 1162422000, # 2006-11-02 00:00
       text  => 'B 096 zw. Dannenwalde und F�rstenberg Deckenerneuerung Vollsperrung 18.10.2006-01.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -8278,82431 -7484,80215
EOF
     },
     { from  => 1160863200, # 2006-10-15 00:00
       until => 1167606000, # 2007-01-01 00:00
       text  => 'B 198 Pol�en-Gramzow OD Gramzow Vollsperrung 16.10.2006-31.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 49930,89857 49757,90015 49779,90206
EOF
     },
     { from  => 1161295200, # 2006-10-20 00:00
       until => 1161813600, # 2006-10-26 00:00
       text  => 'K 6304 Fahrland-Priort Bahn�bergang in der OL Priort Gleisbauarbeiten Vollsperrung 21.10.2006-25.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -19058,11636 -19029,11660 -18750,11919
EOF
     },
     { from  => 1161900000, # 2006-10-27 00:00
       until => 1162422000, # 2006-11-02 00:00
       text  => 'K 6304 Fahrland-Priort Bahn�bergang in der OL Priort Gleisbauarbeiten Vollsperrung 28.10.2006-01.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -19058,11636 -19029,11660 -18750,11919
EOF
     },
     { from  => 1160863200, # 2006-10-15 00:00
       until => 1162335600, # 2006-11-01 00:00
       text  => 'L 272 Vierraden-Woltersdorf OD Blumenhagen Kanalbau Vollsperrung 16.10.2006-31.10.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 69341,80383 69356,80336 69431,80070 69388,79825
EOF
     },
     { from  => 1161036000, # 2006-10-17 00:00
       until => 1161381600, # 2006-10-21 00:00
       text  => 'L 303 Eggersdorfer Weg zw. Abzw. Altlandsberg und OE Eggersdorf Deckenerneuerung Vollsperrung 18.10.2006-20.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 40540,16584 39400,15803
EOF
     },
     { from  => 1161208800, # 2006-10-19 00:00
       until => 1161468000, # 2006-10-22 00:00
       text  => 'B 198 Grundm�hlenweg OD Angerm�nde, zw. R.-Breitscheid-Str. u. Jahnstr. Kranarbeiten Vollsperrung 20.10.2006-21.10.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 49258,68818 49503,68415 49566,68311
EOF
     },
     { from  => 1160863200, # 2006-10-15 00:00
       until => 1161381600, # 2006-10-21 00:00
       text  => 'B 198 Pol�en-Gramzow zw. Meichow und Neumeichow Stra�eninstandsetzung Vollsperrung 16.10.2006-20.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 48624,87416 48772,87442 48856,87456 49112,87743 49525,88337
EOF
     },
     { from  => 1161468000, # 2006-10-22 00:00
       until => 1167519600, # 2006-12-31 00:00
       text  => 'B 198 Pol�en-Gramzow zw. Neimeichow und B166 OL Gramzow grundhafter Ausbau Vollsperrung 23.10.2006-30.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 49525,88337 49743,88576 49939,88985 49935,89343 49930,89857
EOF
     },
     { from  => 1162249200, # 2006-10-31 00:00
       until => 1175378400, # 2007-04-01 00:00
       text  => 'L 073 Beelitzer Str. OD Luckenwalde, zw. B101 und Puschkinstr. Stra�enausbau Vollsperrung 01.11.2006-31.03.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -4299,-35198 -4725,-34957
EOF
     },
     { from  => 1161326798, # 2006-10-20 08:46
       until => 1161554400, # 2006-10-23 00:00
       text  => 'Pankstr. - Sch�nstedtstr. - Thurneysserstr. (Wedding) Richtung Reinickendorfer Str., zwischen Sch�nstedtstr. und Badstr. Veranstaltung Fahrtrichtung gesperrt, einschl. Sch�nstedtstr. zwischen Pankstr. und Brunnenplatz sowie Thurneysserstr. zwischen Badstr. und Buttmannstr. (bis 22.10.2006 nachts)',
       type  => 'handicap',
       source_id => 'IM_003850',
       data  => <<EOF,
userdel	q4::temp 8481,16136 8582,16052 8437,15894 8271,15734
userdel	q4::temp 8437,15894 8338,15987 8270,16047 8236,16071
EOF
     },
     { from  => 1161326842, # 2006-10-20 08:47
       until => 1161468000, # 2006-10-22 00:00
       text  => 'Str. des 17. Juni (Tiergarten) in beiden Richtungen zwischen Y.-Rabin-Str. und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (bis 21.10.2006 nachts)',
       type  => 'handicap',
       source_id => 'IM_003841',
       data  => <<EOF,
userdel	q4::temp 8538,12245 8303,12216 8214,12205 8089,12190
EOF
     },
     { from  => 1161366455, # 2006-10-20 19:47
       until => 1161468000, # 2006-10-22 00:00
       text  => 'Ebertstr. (Tiergarten) Richtung Potsdamer Platz zwischen Scheidemannstr. und Behrenstr. Veranstaltung, Fahrtrichtung gesperrt (bis 21.10.2006 nachts)',
       type  => 'handicap',
       source_id => 'IM_003842',
       data  => <<EOF,
userdel	q4::temp 8595,12066 8600,12165 8538,12245 8546,12279 8570,12302 8573,12325 8540,12420
userdel	q4::temp 8542,11502 8548,11571
EOF
     },
     { from  => undef, # 
       until => 1161442800, # 2006-10-21 17:00
       text  => 'Spandauer Str. (Mitte) in beiden Richtungen zwischen Karl-Liebknecht-Str. und Grunerstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis ca. 17:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_003844',
       data  => <<EOF,
userdel	2::temp 10738,12364 10673,12434 10644,12469 10601,12521 10431,12709
EOF
     },
     { from  => 1161542089, # 2006-10-22 20:34
       until => 1161986400, # 2006-10-28 00:00
       text  => 'Lankestr. gesperrt bis 27.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -9965,-105 -9942,21
EOF
     },
     { from  => 1161712875, # 2006-10-24 20:01
       until => 1162335599, # 2006-10-31 23:59
       text  => 'Loewenhardtdamm (Tempelhof) Richtung Manfred-von-Richthofen-Str. zwischen General-Pape-Str. und Bayernring Baustelle, Fahrtrichtung gesperrt (bis Ende 10.2006)',
       type  => 'gesperrt',
       source_id => 'IM_003899',
       data  => <<EOF,
userdel	1::inwork 8306,8722 8334,8655 8380,8545
EOF
     },
     { from  => 1162681200, # 2006-11-05 00:00
       until => 1163804400, # 2006-11-18 00:00
       text  => 'B 246 Bahn�bergang in der OD Bestensee Umbauarbeiten Vollsperrung 06.11.2006-17.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 26639,-17861 26706,-17867 26718,-17867 26832,-17882
EOF
     },
     { from  => 1160604000, # 2006-10-12 00:00
       until => 1163199600, # 2006-11-11 00:00
       text  => 'L 033 Odervorstadt Bahn�bergang in der OD Wriezen Fahrbahninstandsetzung Vollsperrung 13.10.2006-10.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 60086,36267 60053,36267 59990,36267 59937,36197 59876,36115
EOF
     },
     { from  => 1156024800, # 2006-08-20 00:00
       until => 1162767600, # 2006-11-06 00:00
       text  => 'B 096 Strelitzer Str. OD Gransee, vom KVK in Ri Altl�dersdorf grundhafter Stra�enbau Vollsperrung 21.08.2006-05.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -6382,67186 -7071,66471
EOF
     },
     { from  => 1162249200, # 2006-10-31 00:00
       until => 1163286000, # 2006-11-12 00:00
       text  => 'B 096 zw. OA Gransee und L�wenberg Deckeneinbau Vollsperrung 01.11.2006-11.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -7974,62020 -7906,61543 -7781,60550
EOF
     },
     { from  => 1162249200, # 2006-10-31 00:00
       until => 1164841200, # 2006-11-30 00:00
       text  => 'B 101 Haag OD Luckenwalde, Kno. Beelitzer Str. Stra�enausbau Vollsperrung 01.11.2006-29.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -4609,-35650 -4299,-35198
EOF
     },
     { from  => 1162249200, # 2006-10-31 00:00
       until => 1167896319, # 1177970400 2007-05-01 00:00 nur noch "Wintersicherung"
       text  => 'K 6411 Neulewin-Wriezen zw. OL Neulewin und Kerstenbruch Stra�enbauarbeiten Vollsperrung 01.11.2006-30.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 68583,37906 68973,37547 69095,37169 69283,37114
EOF
     },
     { from  => 1162508400, # 2006-11-03 00:00
       until => 1162853999, # 2006-11-06 23:59
       text  => 'Vollsperrung der Oberspreestra�e zwischen Freystadter Weg und Ottomar-Geschke-Stra�e und Spindlersfelder Stra�e vom Sonnabend, den 04.11.2006, 5:00 Uhr bis Montag, den 06.11.2006, 5:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 20949,4775 20994,4761 21089,4731 21170,4706 21332,4655
EOF
     },
     { from  => 1163800165, # 2006-11-17 22:49
       until => 1165618800, # 2006-12-09 00:00
       text  => 'Kynaststr (Lichtenberg) in Richtung Marktstr., zwischen Haupstr. und Markstr. Baustelle, Fahrtrichtung gesperrt (bis 08.12.06)',
       type  => 'handicap',
       source_id => 'IM_003935',
       data  => <<EOF,
userdel	q4::inwork; 14902,10859 14928,10970 14950,11049 14988,11130
EOF
     },
     { from  => 1155592800, # 2006-08-15 00:00
       until => 1166570964, # 1166828400 2006-12-23 00:00
       text  => 'B 005 Berliner Str. OD Petershagen, zw. Betonstr. und Ortsausgang Kanal- und Stra�enbauarbeiten Vollsperrung 16.08.2006-22.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 74197,607 73775,831 73479,1000
EOF
     },
     { from  => 1162422000, # 2006-11-02 00:00
       until => 1162767600, # 2006-11-06 00:00
       text  => 'B 109 Prenzlauer Allee OD Templin, ab A.-Bebel-Str. bis OA Einbau Deckschicht Vollsperrung 03.11.2006-05.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 16331,79764 16904,79746 17094,79875 17455,80199
EOF
     },
     { from  => 1159221600, # 2006-09-26 00:00
       until => 1162681200, # 2006-11-05 00:00
       text  => 'L 033 Altlandsberger Chaussee zw. Abzw. Strausberg Stadt und Kno. Garzauer Chausse Deckenerneuerung Richtungsverkehr 27.09.2006-04.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 41193,17512 40712,16743
EOF
     },
     { from  => 1162454215, # 2006-11-02 08:56
       until => 1167606000, # 2007-01-01 00:00
       text  => 'Dunckerstr. (Prenzlauer Berg) in beiden Richtungen, Kreuzung Stargarder Str. Baustelle, Stra�e vollst�ndig gesperrt (bis Anfang 2007)',
       type  => 'handicap',
       source_id => 'IM_003972',
       data  => <<EOF,
userdel	q4::inwork 11595,15460 11632,15530
EOF
     },
     { from  => 1162508400, # 2006-11-03 00:00
       until => 1162767600, # 2006-11-06 00:00
       text  => 'L 745 Motzener Str. OD Gallun Deckenerneuerung Vollsperrung 04.11.2006-05.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 21970,-18337 22226,-18793 22324,-18950
EOF
     },
     { from  => 1162443600, # 2006-11-02 06:00
       until => 1162594799, # 2006-11-03 23:59
       text  => 'Auguststr. zwischen der Joachimstr. und der Gipsstr. gesperrt. Dauer: 03.11.2006 in der Zeit von 06:00 Uhr bis 20:00 Uhr Grund: Kraneinsatz',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10142,13556 10049,13528 10026,13521
EOF
     },
     { from  => 1163100276, # 2006-11-09 20:24
       until => 1163199600, # 2006-11-11 00:00
       text  => 'Kolonnenstr. ( Sch�neberg) in beiden Richtungen, in H�he Kaiser-Wilhelm-Platz Baustelle, Stra�e vollst�ndig gesperrt (bis 10.11.06)',
       type  => 'handicap',
       source_id => 'IM_003984',
       data  => <<EOF,
userdel	q4::inwork 7360,8918 7315,8941 7307,8945 7275,8960
EOF
     },
     { from  => 1162681200, # 2006-11-05 00:00
       until => 1166223600, # 2006-12-16 00:00
       text  => 'K 6728 zw. Abzw. Ra�mannsdorf und G�rzig Stra�enneubau Vollsperrung 06.11.2006-15.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 65591,-17536 65909,-18312 65936,-18973 66290,-19612
EOF
     },
     { from  => 1162681200, # 2006-11-05 00:00
       until => 1163199600, # 2006-11-11 00:00
       text  => 'K 7234 Dabendor-Glienick Bahn�bergang in der OL Dabendorf Gleisbauarbeiten Vollsperrung 06.11.2006-10.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 14153,-17829 13282,-18250 13048,-18384
EOF
     },
     { from  => 1163286000, # 2006-11-12 00:00
       until => 1165618800, # 2006-12-09 00:00
       text  => 'L 030 zw. Ortsumgehung Altlandsberg und OE Altlandsberg Deckenerneuerung Vollsperrung 13.11.2006-08.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 33589,15778 33016,17059 32945,17123 32933,17242 32665,17841
EOF
     },
     { from  => 1162767600, # 2006-11-06 00:00
       until => 1163026800, # 2006-11-09 00:00
       text  => 'L 745 Motzener-, Mittenwalder Str. OD Gallun Deckschichteinbau Vollsperrung 07.11.2006-08.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 21828,-18016 21813,-17700 21811,-17649
EOF
     },
     { from  => 1162767600, # 2006-11-06 00:00
       until => 1163804400, # 2006-11-18 00:00
       text  => 'K 7237 Klein Kienitzer Str. OD Rangsdorf, Einm�nd. zur B 96 Deckenerneuerung halbseitig gesperrt; Einbahnstra�e 07.11.2006-17.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 14327,-11767 15962,-10958
EOF
     },
     { from  => 1163194202, # 2006-11-10 22:30
       until => 1166168794, # 1166223599 2006-12-15 23:59
       text  => 'Oberbaumbr�cke Richtung Falckensteinstr. Baustelle, unbequemes Passieren (bis Mitte Dezember 2006)',
       type  => 'gesperrt',
       source_id => 'IM_003947',
       data  => <<EOF,
userdel	3::inwork 13206,10651 13178,10623 13136,10535
EOF
     },
     { from  => 1163286000, # 2006-11-12 00:00
       until => 1163545200, # 2006-11-15 00:00
       text  => 'L 745 Mittenwalder Str. OD Gallun, zw. Storkower Str. u. Galluner Chaussee Deckenerneuerung Vollsperrung 13.11.2006-14.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 21886,-17280 21820,-17524 21811,-17649
EOF
     },
     { from  => 1163446417, # 2006-11-13 20:33
       until => 1163804400, # 2006-11-18 00:00
       text  => 'Sch�neicher Str./Sch�neicher Landstr. (K�penick) in beiden Richtungen, zwischen Dahlwitzer Landstr. und Friedrichshagener Str. Stra�e vollst�ndig gesperrt (bis 17.11.06)',
       type  => 'gesperrt',
       source_id => 'IM_004066',
       data  => <<EOF,
userdel	2::inwork 25584,6029 25776,6054 25967,6125 26139,6188 26247,6228 28586,7139 29168,7350 29192,7368
EOF
     },
     { from  => 1163286000, # 2006-11-12 00:00
       until => 1163545200, # 2006-11-15 00:00
       text  => 'L 086 Gro� Kreutz-Schmergow Bahn�bergang in der OL Gro� Kreutz Instandsetzungsarbeiten Vollsperrung 13.11.2006-14.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -31993,-726 -32143,-211 -32153,-176
EOF
     },
     { from  => 1353884400, # 1321916400, # 2011-11-22 00:00 # PERIODISCH! # fr�her: 1163480400, # 2006-11-14 06:00
       until => 1356562740, # 1324940399, # 2011-12-26 23:59 # PERIODISCH! # fr�her: 1167433200, # 2006-12-30 00:00
       text  => 'Nostalgischer Weihnachtsmarkt rund um das Opernpalais: Schinkelplatz teilweise gesperrt, vom 26.11.-26.12.2012',
       type  => 'gesperrt',
       source_id => 'http://www.berliner-weihnacht.de/',
       data  => <<EOF,
userdel	2::temp 10008,12274 9994,12368
# REMOVED (passierbar!) --- userdel	2::temp 9943,12364 9961,12273 9972,12184
userdel	2::temp 10010,12259 10035,12209
# REMOVED (2012 nicht gesperrt) --- userdel	2::temp 9852,12409 9869,12297 9875,12257 9890,12161
userdel	2::temp 10008,12274 10058,12290
userdel	2::temp 10091,12232 10058,12290 9996,12401
# REMOVED (2012 nicht gesperrt) --- userdel	2::temp 9961,12273 9875,12257
userdel	q4::temp 9994,12368 9996,12401 9984,12426
EOF
     },
     { from  => 1163718000, # 2006-11-17 00:00
       until => 1164150000, # 2006-11-22 00:00
       text  => 'L 338 Rosa-Luxemburg-Damm/ Hauptstr. Bahn�bergang in der OL Neuenhagen Erneu. Gleisanlagen Vollsperrung 18.11.2006-21.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30179,13667 30795,13191 30815,13170 30910,13101 30982,12947
EOF
     },
     { from  => undef, # 
       until => 1167678155, # 2007-01-01 20:02
       text  => 'Bauarbeiten am Maybachufer zwischen Pannierstr. und Weichselstr., Behinderungen m�glich',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 12844,9351 12764,9433 12563,9536
EOF
     },
     { from  => 1164322800, # 2006-11-24 00:00
       until => 1164582000, # 2006-11-27 00:00
       text  => 'L 023 Joachimsthal-Britz ab AS Chorin, westl. Seite in Ri. Joachimsthal Br�ckenbauarbeiten Vollsperrung 25.11.2006-26.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 35962,59463 35405,59832
EOF
     },
     { from  => 1163631600, # 2006-11-16 00:00
       until => 1163977200, # 2006-11-20 00:00
       text  => 'L 281 Neureetz-Altranft bei Neureetz Deckeneinbau Vollsperrung 17.11.2006-19.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 59730,42362 58564,43539
EOF
     },
     { from  => 1160949600, # 2006-10-16 00:00
       until => 1163804400, # 2006-11-18 00:00
       text  => 'L 281 Neureetz-Altranft zw. Croustillier und Br�cke �ber Alte Oder Deckenerneuerung Vollsperrung 17.10.2006-17.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 56925,41800 58564,43539
EOF
     },
     { from  => 1191532790, # 2007-10-04 23:19
       until => 1196463599, # 2007-11-30 23:59
       text  => 'G�rtelstr. (Friedrichshain) Richtung Boxhagener Str. zwischen Frankfurter Allee und Oderstr. Baustelle, Fahrtrichtung gesperrt (bis 11.2007)',
       type  => 'handicap',
       source_id => 'IM_004587',
       data  => <<EOF,
userdel	q4::inwork; 15361,12071 15294,11964 15248,11880 15202,11789 15106,11598
EOF
     },
     { from  => undef, # 
       until => 1166139296, # 2006-12-15 00:34
       text  => 'Einemstr. (Sch�neberg) in Richtung Nollendorfplatz, hinter Kurf�rstenstr. Baustelle, Fahrtrichtung gesperrt (bis Mitte Dezember)',
       type  => 'handicap',
       source_id => 'IM_004168',
       data  => <<EOF,
userdel	q4::inwork; 6972,10665 6985,10597 7003,10513 7033,10396
EOF
     },
     { from  => 1163977200, # 2006-11-20 00:00
       until => 1164754800, # 2006-11-29 00:00
       text  => 'B 166 Berliner Str., Lindenallee OD Schwedt Deckenerneuerung Vollsperrung 21.11.2006-28.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 69480,73471 69302,73357 69238,73315
EOF
     },
     { from  => 1164612153, # 2006-11-27 08:22
       until => 1164656874, # 2006-12-15 23:59 1166223599
       text  => 'Oranienburger Str. (Reinickendorf) in Richtung stadteinw�rts, zwischen Jansenstr. und Tessenowstr. Baustelle, Fahrtrichtung gesperrt (bis Mitte Dezember 2006)',
       type  => 'gesperrt',
       source_id => 'IM_004175',
       data  => <<EOF,
userdel	1::inwork 5533,19811 5495,19571 5476,19450
EOF
     },
     { from  => 1156629600, # 2006-08-27 00:00
       until => 1180648800, # 2007-06-01 00:00
       text  => 'B 198 Stra�e des Friedens OD Angerm�nde, zw. Am Kamp u. Krz. Berliner-/Gartenstr. Kanal- und Stra�enbau Vollsperrung 28.08.2006-31.05.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 49728,68465 49875,68362
EOF
     },
     { from  => 1173816689, # 2007-03-13 21:11
       until => 1183240799, # 2007-06-30 23:59
       text  => 'Pankower Allee (Reinickendorf) in Richtung Markstr., zwischen Reginhardstr. und Residenzstr. Baustelle, Fahrtrichtung gesperrt (bis 06.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004242',
       data  => <<EOF,
userdel	1::inwork 8211,17585 8095,17574 7998,17564 7915,17557 7841,17551 7828,17550 7675,17538 7579,17532
EOF
     },
     { from  => 1165266184, # 2006-12-04 22:03
       until => 1165610763, # 1165705200 2006-12-10 00:00
       text  => 'Am Falkenberg (Treptow) in Richtung Buntzelstr., zwischen Bruno-Taut-Str. und Kirchsteig Baustelle, Fahrtrichtung gesperrt (bis 09.12.06)',
       type  => 'gesperrt',
       source_id => 'IM_004266',
       data  => <<EOF,
userdel	2::inwork 21861,802 22007,711
EOF
     },
     { from  => 1165266208, # 2006-12-04 22:03
       until => 1166223599, # 2006-12-15 23:59
       text  => 'Chemnitzer Str. (Marzahn) in Richtung Nord, zwischen Am Niederfeld und Alt-Kausldorf Baustelle, Fahrtrichtung gesperrt (bis Mitte 12/2006)',
       type  => 'gesperrt',
       source_id => 'IM_004267',
       data  => <<EOF,
userdel	1::inwork 22436,11054 22484,11270
EOF
     },
     { from  => 1165532400, # 2006-12-08 00:00
       until => 1165705200, # 2006-12-10 00:00
       text  => 'B 102 Gro�e Milower Str. OD Rathenow, zw. Eigendorfstr. u. Gr�nauer Weg Neub. B188n, Br�ckenbauarb. Vollsperrung 09.12.2006-09.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -62290,19904 -62333,20390
EOF
     },
     { from  => 1165100400, # 2006-12-03 00:00
       until => 1185832800, # 2007-07-31 00:00
       text  => 'L 016 Paaren-B�rnicke OD Gr�nefeld Kanal- und Stra�enbau Vollsperrung 04.12.2006-30.07.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -19282,29433 -19608,29389 -19798,29399
EOF
     },
     { from  => 1165389396, # 2006-12-06 08:16
       until => 1165618800, # 2006-12-09 00:00
       text  => 'Rosenthaler Str. (Mitte) Richtung Hackescher Markt zwischen Neue Sch�nhauser Str. und Hackescher Markt Baustelle, Fahrtrichtung gesperrt (bis 08.12.2006)',
       type  => 'gesperrt',
       source_id => 'IM_004277',
       data  => <<EOF,
userdel	1::inwork 10310,13227 10264,13097
EOF
     },
     { from  => 1156629600, # 2006-08-27 00:00
       until => 1170198000, # 2007-01-31 00:00
       text  => 'L 030 R�dersdorfer Str. OD Woltersdorf, zw. R.-Breitschei-Str. u. Interlakenstr. Stra�enbau, Entw�sserung Vollsperrung 28.08.2006-30.01.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 34579,5745 34535,5319
EOF
     },
     { from  => 1153346400, # 2006-07-20 00:00
       until => 1166482800, # 2006-12-19 00:00
       text  => 'L 285 G�nterberg-Sch�nermark OD G�nterberg Kanal- und Stra�enbau Vollsperrung 21.07.2006-18.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 48203,79315 47091,77570
EOF
     },
     { from  => 1165952495, # 2006-12-12 20:41
       until => 1166310000, # 2006-12-17 00:00
       text  => 'L20 Sch�nwalder Str. in beiden Richtungen zwischen Sch�nwalde und B�tzow Baustelle, Stra�e vollst�ndig gesperrt: Sch�nwalde - Pausin - Wansdorf - B�tzow (bis 16.12.2006)',
       type  => 'gesperrt',
       source_id => 'IM_004322',
       data  => <<EOF,
userdel	2::inwork -7640,26928 -7309,26146 -7243,25847 -7230,25622 -7260,25515 -7421,24956 -7603,24696
EOF
     },
     { from  => 1165705200, # 2006-12-10 00:00
       until => 1166828400, # 2006-12-23 00:00
       text  => 'B 246 N�chst Neuendorfer Chaussee OD Zossen, Bahn�bergang Kanalarbeiten Vollsperrung 11.12.2006-22.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 13526,-20548 13412,-20513 13326,-20518
EOF
     },
     { from  => 1166050800, # 2006-12-14 00:00
       until => 1166569200, # 2006-12-20 00:00
       text  => 'K 6161 Friedensstr. Bahn�bergang in der OD Eichwalde Gleisbauarbeiten Vollsperrung 15.12.2006-19.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 25173,-3957 25212,-4025 25269,-4041 25320,-4049
EOF
     },
     { from  => 1166050800, # 2006-12-14 00:00
       until => 1166482800, # 2006-12-19 00:00
       text  => 'B 168 Frankfurter Chaussee Bahn�bergang Bahnhof Oegeln Gleisbauarbeiten Vollsperrung 15.12.2006-18.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 70924,-23663 70065,-24817
EOF
     },
     { from  => 1166310000, # 2006-12-17 00:00
       until => 1166828400, # 2006-12-23 00:00
       text  => 'L 025 Sch�nermark-LG-Woldegk Br�cke �ber den Dammseegraben am OA F�rstenwerder Br�ckenneubau Vollsperrung 18.12.2006-22.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 20336,110197 20035,110983
EOF
     },
     { from  => 1167692400, # 2007-01-02 00:00
       until => 1199142000, # 2008-01-01 00:00
       text  => 'L 060 Schipkau-Lichterfeld zw. Lichterfeld und Lauchhammer-Nord grundhafter Stra�enbau Vollsperrung 03.01.2007-31.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 37419,-91709 37675,-92038 37809,-92300 37918,-93202
EOF
     },
     { from  => 1166648042, # 2006-12-20 21:54
       until => 1167001200, # 2006-12-25 00:00
       text  => 'Stra�e des 17. Juni (Tiergarten) in beiden Richtungen zwischen Y.-Rabin-Str. und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (bis 24.12.2006 16 Uhr)',
       type  => 'handicap',
       source_id => 'IM_004369',
       data  => <<EOF,
userdel	q4::temp 8089,12190 8214,12205 8303,12216 8538,12245
EOF
     },
     { from  => undef, # 
       until => 1168288741, # 2007-07-01 00:00 1183240800
       text  => 'Treptower Str. (Treptow) in beiden Richtungen zwischen Kiefholzstr. und Harzer Str. Baustelle Stra�e vollst�ndig gesperrt (f�r Anlieger aber befahrbar!) (bis Mitte 2007) (16:10) ',
       type  => 'gesperrt',
       source_id => 'IM_004418',
       data  => <<EOF,
userdel	2::inwork 14151,8967 14015,8798 13860,8599
EOF
     },
     { from  => 1171050907, # 2007-02-09 20:55
       until => 1183240799, # 2007-06-30 23:59
       text  => 'Nennhauser Damm (Spandau) Richtung Brunsb�tteler Damm nach Heerstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 06.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004443',
       data  => <<EOF,
userdel	1::inwork -8784,13321 -8756,13356 -8358,13340 -8296,13338 -8049,13332 -8022,13332 -7693,13330
EOF
     },
     { from  => 1178865859, # 2007-05-11 08:44
       until => 1180648799, # 2007-05-31 23:59
       text  => 'Oranienstr. und Lobeckstr. (Kreuzberg) in beiden Richtungen an der Kreuzung Baustelle, Oranienstr. auf einen Fahrstreifen je Richtung verengt, Lobeckstr. Einbahnstr. Richtung Ritterstr. (bis Ende 05.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004447',
       data  => <<EOF,
userdel	1::inwork 10585,10766 10684,10975
EOF
     },
     { from  => 1168462111, # 2007-01-10 21:48
       until => 1168556400, # 2007-01-12 00:00
       text  => 'Schiffbauerdamm (Mitte) in beiden Richtungen zwischen Luisenstr. und Albrechtstr. Kraneinsatz, Stra�e vollst�ndig gesperrt (bis 11.01.2007 abends)',
       type  => 'gesperrt',
       source_id => 'IM_004454',
       data  => <<EOF,
userdel	2::temp 9106,12795 9056,12743 8870,12647
EOF
     },
     { from  => 1168898272, # 2007-01-15 22:57
       until => 1169215200, # 2007-01-19 15:00
       text  => 'Hultschiner Damm zwischen Alt-Mahlsdorf und Elsenstr. gesperrt, geplatzte Wasserleitung bis 19.01.2007 15:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 24639,10766 24653,10831 24740,10992 24693,11141 24654,11265
EOF
     },
     { from  => 1182281811, # 2007-06-19 21:36
       until => 1184018400, # 2007-07-10 00:00
       text  => 'Kaulsdorfer Br�cke (Hellersdorf) in beiden Richtungen Baustelle, Br�cke gesperrt (bis 09.07.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004489',
       data  => <<EOF,
userdel	2::inwork 22688,12007 22684,12016 22669,12049 22693,12084
EOF
     },
     { from  => undef, # 2007-01-15 22:59 1168898369
       until => 1185227672 , # 2008-06-30 23:59 1178221318 1214863199 undef
       text  => 'Weinmeisterstr. (Mitte) in Richtung M�nzstr. Baustelle, Fahrtrichtung gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_004491',
       data  => <<EOF,
userdel	1::inwork 10350,13376 10527,13257
EOF
     },
     { from  => 1169074800, # 2007-01-18 00:00
       until => 1169506800, # 2007-01-23 00:00
       text  => 'B 183 Dresdener Str. Bahn�bergang in der OL Bad Liebenwerda Gleis- u. Tiefbauarbeiten Vollsperrung 19.01.2007-22.01.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 13828,-98986 13053,-99051 12593,-99029
EOF
     },
     { from  => 1169506800, # 2007-01-23 00:00
       until => 1169679600, # 2007-01-25 00:00
       text  => 'B 183 Hainsche Str. Burgplatz in der OL Bad Liebenwerda Gesch�ftser�ffnung Vollsperrung 24.01.2007-24.01.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 12194,-98944 11974,-99110
EOF
     },
     { from  => 1169495904, # 2007-01-22 20:58
       until => 1169679600, # 2007-01-25 00:00
       text  => 'Ehrlichstr. (Lichtenberg) Richtung Treskowallee vor Treskowallee Baustelle, Fahrtrichtung gesperrt, bis 24.01.2007',
       type  => 'gesperrt',
       source_id => 'IM_004560',
       data  => <<EOF,
userdel	1::inwork 18528,8331 18615,8269 18676,8236
EOF
     },
     { from  => 1169496024, # 2007-01-22 21:00
       until => 1169938800, # 2007-01-28 00:00
       text  => 'H�nower Str. (Hellersdorf) Richtung Ridbacher Str. zwischen Fritz-Reuter-Str. und Wilhelmsm�henweg Baustelle, Fahrtrichtung gesperrt (bis 27.01.2007)',
       type  => 'handicap',
       source_id => 'IM_004559',
       data  => <<EOF,
userdel	q4::inwork; 24623,11684 24657,11762 24652,11794 24578,11928
EOF
     },
     { from  => 1190067630, # 2007-09-18 00:20
       until => 1190498400, # 2007-09-23 00:00
       text  => 'G�rtelstr. (Friedrichshain) in beiden Richtungen zwischen Scharnweberstr. und Dossestr. Baustelle, Stra�e vollst�ndig gesperrt (bis 22.09.2007)',
       type  => 'handicap',
       source_id => 'IM_006669',
       data  => <<EOF,
userdel	q4::inwork 15202,11789 15248,11880
EOF
     },
     { from  => 1170370800, # 2007-02-02 00:00
       until => 1170630000, # 2007-02-05 00:00
       text  => 'L 023 Britz-Joachimsthal Br�cke �ber A 11, AS Chorin Br�ckenabbruch Vollsperrung 03.02.2007-04.02.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 35962,59463 35405,59832
EOF
     },
     { from  => 1169839000, # 2007-01-26 20:16
       until => 1170370799, # 2007-02-01 23:59
       text  => 'Dunckerstr. (Prenzlauer Berg) in beiden Richtungen, Kreuzung Stargarder Str. Baustelle, Stra�e vollst�ndig gesperrt (bis Anfang 02/2007)',
       type  => 'gesperrt',
       source_id => 'IM_003972',
       data  => <<EOF,
userdel	2::inwork 11595,15460 11632,15530
EOF
     },
     { from  => 1169839019, # 2007-01-26 20:16
       until => 1170370799, # 2007-02-01 23:59
       text  => 'Hultschiner Damm (Mahlsdorf) in beiden Richtungen zwischen Alt Mahlsdorf und Elsenstr. Stra�e vollst�ndig gesperrt, Rohrbruch (bis Anfang 02/2007)',
       type  => 'gesperrt',
       source_id => 'IM_004452',
       data  => <<EOF,
userdel	2::inwork 24639,10766 24653,10831 24740,10992 24693,11141 24654,11265
EOF
     },
     { from  => 1170098849, # 2007-01-29 20:27
       until => 1171062000, # 2007-02-10 00:00
       text  => 'Hauptstr. (Pankow) in Richtung stadteinw�rts, zwischen Bucherstr. und Blankenfelder Str. Baustelle, Fahrtrichtung gesperrt (bis 09.02.07)',
       type  => 'gesperrt',
       source_id => 'IM_004638',
       data  => <<EOF,
userdel	1::inwork 12185,23021 12214,22918 12187,22486
EOF
     },
     { from  => 1170802800, # 2007-02-07 00:00
       until => 1171148400, # 2007-02-11 00:00
       text  => 'B 112 zw. Abzw. W�ste Kunersdorf und Lebus Gr�ndungsarb. f�r Radwegbau Vollsperrung 08.02.2007-10.02.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 86420,913 86769,1414
EOF
     },
     { from  => 1170543600, # 2007-02-04 00:00
       until => 1170889200, # 2007-02-08 00:00
       text  => 'B 273 Germendorf-Schwante Bahn�bergang in der OD Schwante Gleisbauarbeiten Vollsperrung 05.02.2007-07.02.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -11541,36139 -11386,36243 -10833,36580
EOF
     },
     { from  => 1170716400, # 2007-02-06 00:00
       until => 1171148400, # 2007-02-11 00:00
       text  => 'K 6506 L172- B�renklau-Vehlefanz Bahn�bergang in der OD Vehlefanz Gleisbauarbeiten Vollsperrung 07.02.2007-10.02.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -10057,34800 -9783,34896 -9159,34997
EOF
     },
     { from  => 1170802800, # 2007-02-07 00:00
       until => 1171062000, # 2007-02-10 00:00
       text  => 'B 112 Bereich Kunersdorfer Grund Errichtung Radwegbr�cke Vollsperrung 08.02.2007-09.02.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 86769,1414 87344,3693
EOF
     },
     { from  => 1173515301, # 2007-03-10 09:28
       until => 1177970399, # 2007-04-30 23:59
       text  => 'Dunckerstr. (Prenzlauer Berg) in beiden Richtungen, Kreuzung Stargarder Str. Baustelle, Stra�e vollst�ndig gesperrt (bis 04.2007)',
       type  => 'gesperrt',
       source_id => 'IM_003972',
       data  => <<EOF,
userdel	2::inwork 11595,15460 11632,15530
EOF
     },
     { from  => 1181426400, # 2007-06-10 00:00
       until => 1195308700, # 2008-01-01 00:00 1199142000
       text  => 'L 090 Dr.-K�lz-Str. OD Glindow, zw. Alte Str. und Alpenstr. Kanal- und Stra�enbau Vollsperrung 11.06.2007-31.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -22862,-5171 -22867,-5778
EOF
     },
     { from  => 1171051156, # 2007-02-09 20:59
       until => 1171148400, # 2007-02-11 00:00
       text  => 'Bellevuestr. (K�penick) in beiden Richtungen zwischen F�rstenwalder Damm und Seelenbinderstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 10.02.2007 22 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_004721',
       data  => <<EOF,
userdel	2::inwork 23402,5483 23333,5710
EOF
     },
     { from  => 1171580400, # 2007-02-16 00:00
       until => 1171753200, # 2007-02-18 00:00
       text  => 'B 169 OD Plessa, zw. Waldstr. und Bahnhofstr. Karnevalsumzug Vollsperrung 17.02.2007-17.02.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 28006,-104431 27775,-104430 27420,-104513
EOF
     },
     { from  => 1171148400, # 2007-02-11 00:00
       until => 1171580400, # 2007-02-16 00:00
       text  => 'L 025 F�rstenwerder-Woldegk Br�cke �ber den Dammseegraben am OA F�rstenwerder �nderung Wasserf�hrung Vollsperrung 12.02.2007-15.02.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 20035,110983 20336,110197 20631,109980
EOF
     },
     { from  => 1172790000, # 2007-03-02 00:00
       until => 1173049200, # 2007-03-05 00:00
       text  => 'L 238 Eberswalde-Joachimsthal Br�cke der A 11 zw. Lichterfelde u. Altenhof Br�ckenbauarbeiten Vollsperrung 03.03.2007-04.03.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 31065,54239 30773,54731
EOF
     },
     { from  => 1171580400, # 2007-02-16 00:00
       until => 1171753200, # 2007-02-18 00:00
       text  => 'L 621 D�llinger Str. OD Plessa, zw. Hauptstr. und Von-Delius-Str. Karnevalsumzug Vollsperrung 17.02.2007-17.02.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 27420,-104513 26667,-103869
EOF
     },
     { from  => 1151618400, # 2006-06-30 00:00
       until => 1180648800, # 2007-06-01 00:00
       text  => 'L 211 Lehnitzstr. OL Oranienburg, zw. A.-Pican-Str. und Dr.-H.-Byk-Str. Munitionssuche u. -bergung Vollsperrung 01.07.2006-31.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -612,38051 -234,37510
EOF
     },
     { from  => undef, # 
       until => 1183500687, # aufgehoben von steini
       text  => 'Paul-Schwarz-Promenade zwischen Krahmerstr. und Klinikum bis auf weiteres wegen Bauarbeiten gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 4835,3415 4921,3593 4970,3684 5093,3912 5145,3984 5225,4095
EOF
     },
     { from  => 1175726892, # 1176069600 2007-04-09 00:00
       until => 1175726893, # 1177192800 2007-04-22 00:00
       text  => 'L 063 Berliner Str. Bahn�bergang in der OD Lauchhammer Gleiserneuerung Vollsperrung 10.04.2007-21.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 35482,-103562 35379,-103141 35072,-102150
EOF
     },
     { from  => 1172530568, # 2007-02-26 23:56
       until => 1175292000, # 2007-03-31 00:00
       text  => 'F�rstenwalder Damm, f�r beide Richtungen nur ein Fahrstreifen abwechselnd frei, Baustelle bis 30.03.2007 (im Bereich Einm�ndung M�hlweg) ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 25012,5754 24871,5699 24700,5633 24471,5544 24366,5504 24285,5472 24162,5424 24049,5380 23950,5342
EOF
     },
     { from  => 1172530621, # 2007-02-26 23:57
       until => 1173999599, # 2007-03-15 23:59
       text  => 'Hildburghauser Str. (Steglitz) in beiden Richtungen zwischen Oberhofer Weg und Geraer Str. Baustelle, Fahrbahn auf einen Fahrstreifen verengt, Verkehr wird wechselseitig vorbeigef�hrt (bis Mitte 03.2007)',
       type  => 'handicap',
       source_id => 'IM_004793',
       data  => <<EOF,
userdel	q4::inwork 5414,1304 5585,1275 5740,1227
EOF
     },
     { from  => 1172646005, # 2007-02-28 08:00
       until => 1175032135, # 1175378399 2007-03-31 23:59
       text  => 'Kastanienallee (Pankow) Richtung Sch�nhauser Str. zwischen Friedrich-Engels-Str. und Eschenallee Baustelle, Fahrtrichtung gesperrt (bis Ende 03.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004803',
       data  => <<EOF,
userdel	1::inwork 8900,20601 9025,20611 9161,20622 9174,20623 9295,20632 9460,20644 9551,20662 9622,20677 9676,20700 9737,20728 9848,20764
EOF
     },
     { from  => 1172642400, # 2007-02-28 07:00
       until => 1172777980, # 2007-03-02 18:00 1172854800
       text  => 'Linienstr. zwischen Tucholskystr. und Kleine Hamburger Str. gesperrt wegen Stra�enbauarbeiten. Dauer: 01.03.2007 07.00 Uhr bis 02.03.2007 18:00 Uhr. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 9752,13575 9607,13507
EOF
     },
     { from  => 1172962800, # 2007-03-04 00:00
       until => 1182376800, # 2007-06-21 00:00
       text  => 'L 075 Karl-Marx-Str. OD Gro�ziethen, n�rdl. Attilastr.- Landesgrenze Berlin, Buckower Damm Stra�en- und Kanalbau Vollsperrung 05.03.2007-20.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 12984,1011 13124,216
EOF
     },
     { from  => 1173308400, # 2007-03-08 00:00
       until => 1173654000, # 2007-03-12 00:00
       text  => 'B 112 zw. W�ste Kunersdorf und Lebus Gr�ndungsarb. f�r Radwegbau Vollsperrung 09.03.2007-11.03.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 86420,913 86769,1414
EOF
     },
     { from  => 1173049200, # 2007-03-05 00:00
       until => 1173567600, # 2007-03-11 00:00
       text  => 'B 113 B 2-Damitzow Bahn�bergang in der OD Tantow Gleisbauarbeiten Vollsperrung 06.03.2007-10.03.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 73204,97424 73031,97443 73017,97449 72960,97477 72583,97595
EOF
     },
     { from  => 1172962800, # 2007-03-04 00:00
       until => 1188165600, # 2007-08-27 00:00
       text  => 'B 198 Neubrandenburger Str. OD Prenzlau Grundhafter Stra�enbau Vollsperrung 05.03.2007-26.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 38439,102279 37547,102663
EOF
     },
     { from  => 1173222000, # 2007-03-07 00:00
       until => 1173481200, # 2007-03-10 00:00
       text  => 'K 6905 Langerwisch-B 2 Potsdam Bahn�bergang in der OD Wilhelmshorst Markierungsarbeiten Vollsperrung 08.03.2007-09.03.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -12401,-9721 -12751,-8997 -12835,-8819
EOF
     },
     { from  => 1173567600, # 2007-03-11 00:00
       until => 1184104800, # 2007-07-11 00:00
       text  => 'B 096 Finsterwalde-Luckau Br�cke �ber das Bersteflie� n�rdl. Riedebeck Abbruch u. Neubau Br�cke Vollsperrung 12.03.2007-10.07.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30491,-65399 30577,-65764
EOF
     },
     { from  => 1176488048, # undef
       until => 1176488053, # undef
       text  => 'Kietzer Str. (K�penick) in beiden Richtungen, zwischen Gr�nstr. und Rosenstr. geplatzte Wasserleitung',
       type  => 'gesperrt',
       source_id => 'IM_004874',
       data  => <<EOF,
userdel	2::inwork 22314,4604 22284,4653
EOF
     },
     { from  => 1173135600, # 2007-03-06 00:00
       until => 1178575200, # 2007-05-08 00:00
       text  => 'L 040 Zossener Damm OD Blankenfelde, zw. Kreisverkehr u. K.-Liebknecht-Str. Stra�enausbau Vollsperrung 07.03.2007-07.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10115,-8276 11115,-8466
EOF
     },
     { from  => 1173135600, # 2007-03-06 00:00
       until => 1183240800, # 2007-07-01 00:00
       text  => 'B 101 zw. Wiederau und Krz. Friedrichsluga Stra�enbau Richtungsverkehr 07.03.2007-30.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 5339,-84725 4072,-82982
EOF
     },
     { from  => 1176588000, # 2007-04-15 00:00
       until => 1179790690, # 2007-06-03 00:00 1180821600
       text  => 'L 037 Petersdorfer Str. OD Petershagen Kanal- und Stra�enbauarbeiten Vollsperrung 16.04.2007-02.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 74107,450 74197,607
EOF
     },
     { from  => 1173308400, # 2007-03-08 00:00
       until => 1173740400, # 2007-03-13 00:00
       text  => 'L 742 Klein K�ris-Teupitz Bahn�bergang in der OD Gro� K�ris Gleisumbauarbeiten Vollsperrung 09.03.2007-12.03.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 28494,-27010 27995,-27157 27824,-27205
EOF
     },
     { from  => 1173913200, # 2007-03-15 00:00
       until => 1174345200, # 2007-03-20 00:00
       text  => 'L 023 Storkow-Herzfelde Bahn�bergang Fangschleuse Gleisbauarbeiten Vollsperrung 16.03.2007-19.03.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 39250,1024 39259,612 39264,-832
EOF
     },
     { from  => 1174172400, # 2007-03-18 00:00
       until => 1183240800, # 2007-07-01 00:00
       text  => 'L 035 Pieskower Chaussee OD Bad Saarow, zw. R.-Koch-Str. und Einfahrt Klinikum Stra�enbauarbeiten Vollsperrung 19.03.2007-30.06.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 55904,-13109 55800,-12487 55750,-12045 55729,-11868
EOF
     },
     { from  => 1173567600, # 2007-03-11 00:00
       until => 1174258800, # 2007-03-19 00:00
       text  => 'L 070 Luckenwalder Str. OD Dahme, Kno. Hauptstr. B102 Abrissarbeiten Vollsperrung 12.03.2007-18.03.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 13308,-59619 13008,-59164
EOF
     },
     { from  => 1173682113, # 2007-03-12 07:48
       until => 1174086000, # 2007-03-17 00:00
       text  => 'General-Pape-Str. (Tempelhof) in beiden Richtungen Baustelle, Stra�e vollst�ndig gesperrt (bis 16.03.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004915',
       data  => <<EOF,
userdel	2::inwork 8306,8722 8237,8685 8215,8631 8100,8288 8088,8254 7955,7840
EOF
     },
     { from  => 1173913200, # 2007-03-15 00:00
       until => 1174345200, # 2007-03-20 00:00
       text  => 'B 113 B 2-Damitzow Bahn�bergang in der OD Tantow Gleisbauarbeiten Vollsperrung 16.03.2007-19.03.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 73204,97424 73031,97443 73017,97449 72960,97477 72583,97595
EOF
     },
     { from  => undef, # 
       until => 1191189599, # 2007-09-30 23:59
       text  => 'Manteuffelstr. zwischen Skalitzer Str. und Naunynstr. sowie Skalitzer Str. und Paul-Lincke-Ufer: Einbahnstra�enregelung bis Ende 09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 12000,10531 12052,10644
userdel	1::inwork 11949,10414 11829,10192 11735,10022
EOF
     },
     { from  => 1178564445, # 2007-05-07 21:00
       until => 1180460014, # 2007-05-31 23:59 1180648799
       text  => 'geplatzte Wasserleitung, Schulze-Boysen-Str. gesperrt (bis Ende 05.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004953',
       data  => <<EOF,
userdel	2::inwork 15836,11840 15863,11992
EOF
     },
     { from  => undef, # 
       until => 1174068889, #
       text  => 'Bethaniendamm (Mitte) Kreuzung Leuschnerdamm Baustelle, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'INKO_86548_COPY_1',
       data  => <<EOF,
userdel	2::inwork 11458,11136 11421,11073
EOF
     },
     { from  => 1174172400, # 2007-03-18 00:00
       until => 1185141600, # 2007-07-23 00:00
       text  => 'B 273 Breite Str. OD Oranienburg, zw. Berliner Str. u. Havelstr. Stra�enbauarbeiten Vollsperrung 19.03.2007-22.07.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -1571,38406 -1553,38501 -1515,38500 -1487,38509
EOF
     },
     { from  => 1195945200, # 2007-11-25 00:00
       until => 1197068400, # 2007-12-08 00:00
       text  => 'B 273 Breite Str., Havelstr. OD Oranienburg, zw. Berliner Str. und Gartenstr. Deckschichteinbau Vollsperrung 26.11.2007-07.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -1618,38293 -1504,38289 -1353,38301
EOF
     },
     { from  => 1185055200, # 2007-07-22 00:00
       until => 1196463600, # 2007-12-01 00:00
       text  => 'B 273 Havelstr. OD Oranienburg, zw. Breite Str. und Gartenstr. Stra�enbauarbeiten Vollsperrung 23.07.2007-30.11.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -1618,38293 -1709,38275 -1720,38268 -1764,38237 -1796,38203 -1832,38148
EOF
     },
     { from  => 1174172400, # 2007-03-18 00:00
       until => 1183672800, # 2007-07-06 00:00
       text  => 'K 7320 Potzlow-Prenzlau Br�cke �ber M�hlgraben in der OL Potzlow Br�ckenneubau Vollsperrung 19.03.2007-05.07.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 38475,90762 38555,91126 38614,91197 38637,91275 38612,91950
EOF
     },
     { from  => 1249152327, # 
       until => 1249152331, # XXX -> handicap_s-orig
       text  => 'Reichstagufer (Mitte) in beiden Richtungen Baustelle, Stra�e vollst�ndig gesperrt, Fu�g�nger k�nnen passieren',
       type  => 'handicap',
       data  => <<EOF,
#: last_checked: 2009-08-29
userdel	q4::inwork 9209,12795 9280,12883
EOF
     },
     { from  => 1174068872, # 2007-03-16 19:14
       until => 1174172400, # 2007-03-18 00:00
       text  => 'Stra�e des 17. Juni (Tiergarten) in beiden Richtungen zwischen Gro�er Stern und Y.-Rabin-Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 17.03.2007 24.00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_004977',
       data  => <<EOF,
userdel	2::temp 8055,12186 7816,12150 7383,12095 6828,12031
EOF
     },
     { from  => 1174115692, # 2007-03-17 08:14
       until => 1174287358, # 1174345200 2007-03-20 00:00
       text  => 'Bahnhofstr. (K�penick) in beiden Richtungen in H�he der Bahnhofsbr�cke Br�ckenarbeiten, Stra�e vollst�ndig gesperrt, eine Umleitung ist eingerichtet (bis 19.03.2007 04 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_004990',
       data  => <<EOF,
userdel	2::inwork 22428,6063 22467,6135
EOF
     },
     { from  => 1174518000, # 2007-03-22 00:00
       until => 1174946400, # 2007-03-27 00:00
       text  => 'B 113 B 2-Damitzow Bahn�bergang in der OD Tantow Gleisbauarbeiten Vollsperrung 23.03.2007-26.03.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 73204,97424 73031,97443 73017,97449 72960,97477 72583,97595
EOF
     },
     { from  => 1174258800, # 2007-03-19 00:00
       until => 1174777200, # 2007-03-25 00:00
       text  => 'B 167 Marienwerderstr. OD Finowfurt, zw. Zum Krugacker u. Werbelliner Str. Fahrbahnsanierung Vollsperrung 20.03.2007-24.03.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 28575,49756 27822,49878 27566,49942
EOF
     },
     { from  => 1174773600, # 2007-03-24 23:00
       until => 1175032800, # 2007-03-28 00:00
       text  => 'L 059 Stolzenhainer Str. Bahn�bergang in der OD Pr�sen Gleisbauarbeiten Vollsperrung 26.03.2007-27.03.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 17465,-109257 17298,-109023
EOF
     },
     { from  => 1174515627, # 2007-03-21 23:20
       until => 1174968000, # 2007-03-27 06:00
       text  => 'Ebertstr. zwischen Behrenstr. und Dorotheenstr. und Stra�e des 17. Juni zwischen Brandenburger Tor und Y.-Rabin-Str.: Veranstaltung, Stra�e vollst�ndig gesperrt (Europafest) (bis 27.03.2007 morgens)',
       type  => 'gesperrt',
       source_id => 'IM_005018',
       data  => <<EOF,
userdel	2::temp 8540,12420 8573,12325 8570,12302 8546,12279 8538,12245 8303,12216 8214,12205 8089,12190 8055,12186
userdel	2::temp 8595,12066 8600,12165 8538,12245
EOF
     },
     { from  => 1169247600, # 2007-01-20 00:00
       until => 1175810400, # 2007-04-06 00:00
       text  => 'B 246 Br�cker Str. OL Beelitz, zw. Bahn�bergang u. Karl-Marx-Str. Ausbau Kreisverkehr Vollsperrung 21.01.2007-05.04.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -17930,-19476 -18615,-19264
EOF
     },
     { from  => 1176069600, # 2007-04-09 00:00
       until => 1179525600, # 2007-05-19 00:00
       text  => 'B 246 Br�cker Str. OL Beelitz, zw. Eckenerstr. u. Karl-Marx-Str. Ausbau Kreisverkehr Vollsperrung 10.04.2007-18.05.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -19026,-19156 -19076,-19148 -19825,-19350
EOF
     },
     { from  => 1176069600, # 2007-04-09 00:00
       until => 1176242400, # 2007-04-11 00:00
       text  => 'B 320 Guben-Lieberose OD Jamlitz, Eisenbahnbr�cke R�ckbauarbeiten Vollsperrung 10.04.2007-10.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 77708,-45180 77263,-45193
EOF
     },
     { from  => 1174518000, # 2007-03-22 00:00
       until => 1174863600, # 2007-03-26 01:00
       text  => 'L 063 Finsterwalder Str. OD Lauchhammer, zw. Schehlenstr. und F.-Mehring-Str. Einbau Deckschicht Vollsperrung 23.03.2007-25.03.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 35072,-102150 35379,-103141
EOF
     },
     { from  => 1174593295, # 2007-03-22 20:54
       until => 1174863600, # 2007-03-26 01:00
       text  => 'Bahnhofstr. (K�penick) in beiden Richtungen in H�he der Bahnhofsbr�cke Br�ckenarbeiten, Stra�e vollst�ndig gesperrt, eine Umleitung ist eingerichtet (bis 25.03.2007 04 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_004990',
       data  => <<EOF,
userdel	2::inwork 22428,6063 22467,6135
EOF
     },
     { from  => 1176328800, # 2007-04-12 00:00
       until => 1176760800, # 2007-04-17 00:00
       text  => 'B 112 Forster Str. Bahnunterf�hrung in der OD Guben Gleis- u. Br�ckensanierung Vollsperrung 13.04.2007-16.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 100158,-50079 100201,-50335
EOF
     },
     { from  => 1187215200, # 2007-08-16 00:00
       until => 1187647200, # 2007-08-21 00:00
       text  => 'B 112 Forster Str. Bahnunterf�hrung in der OD Guben Gleis- u. Br�ckensanierung Vollsperrung 17.08.2007-20.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 100158,-50079 100201,-50335
EOF
     },
     { from  => 1174599531, # 2007-03-22 22:38
       until => 1177970399, # 2007-04-30 23:59
       text  => 'Vom 20.03. bis voraussichtlich zum 30.04.2007 wird die Fahrbahndecke der Namslaustra�e zwischen Berliner Stra�e und Sterkrader Stra�e erneuert. W�hrend der Bauzeit wird die Namslaustra�e in Richtung Berliner Stra�e als Einbahnstra�e ausgewiesen. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 2698,19099 2585,19091 2460,19083 2098,19058
EOF
     },
     { from  => 1175292000, # 2007-03-31 00:00
       until => 1175551200, # 2007-04-03 00:00
       text  => 'Fr�hlingsfest auf der Sonnenallee Neuk�lln, Vollsperrung zw. Pannierstr. und Wildenbruchstr. von 31.03.2007 07:00 bis 02.04.2007 01:00 ',
       type  => 'gesperrt',
       source_id => 'IM_005045',
       data  => <<EOF,
userdel	2::temp 12925,8494 12772,8612 12742,8635 12630,8722 12483,8834 12438,8859 12320,8927 12242,8972
EOF
     },
     { from  => 1174640400, # 2007-03-23 10:00
       until => 1174755600, # 2007-03-24 18:00
       text  => 'Stra�enfest in der Dom�ne Dahlem Dahlem, K�nigin-Luise-Str. Sperrungen von Sa 10:00 bis Sa 18:00 ',
       type  => 'gesperrt',
       source_id => 'IM_005044',
       data  => <<EOF,
userdel	2::temp 2823,5672 2771,5678 2654,5678
EOF
     },
     { from  => 1174773600, # 2007-03-24 23:00
       until => 1182117600, # 2007-06-18 00:00
       text  => 'L 023 Britz-Joachimsthal zw. AS Chorin und Britz Deckenerneuerung Vollsperrung 26.03.2007-17.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 35962,59463 35809,59122 35755,58845 35950,58308 36151,57931 36230,57632 36686,57106 36621,56807
EOF
     },
     { from  => undef, # 
       until => 1174777200, # 2007-03-25 00:00
       text  => 'Behrenstr. (Mitte) in beiden Richtungen zwischen Wilhelmstr. und Ebertstr. Veranstaltung, Stra�e vollst�ndig gesperrt (Europafest) (bis nachts) (06:50) ',
       type  => 'gesperrt',
       source_id => 'IM_005020',
       data  => <<EOF,
userdel	2::temp 8861,12125 8743,12099 8737,12098 8595,12066
EOF
     },
     { from  => undef, # 
       until => 1174788000, # 2007-03-25 04:00
       text  => 'Kurf�rstendamm Charlottenburg, von Uhlandstra�e bis Wittenbergplatz Veranstaltung; Stra�e gesperrt Lange Nacht des Shoppings',
       type  => 'gesperrt',
       source_id => 'IM_005040',
       data  => <<EOF,
userdel	2::temp 6133,10679 6025,10746 5942,10803 5907,10821 5782,10884 5725,10892 5656,10876 5475,10808 5351,10760 5229,10716 5076,10658
EOF
     },
     { from  => undef, # 
       until => 1187989815, # Time::Local::timelocal(reverse(2007-1900,10-1,1,0,0,0)), # 1188597600, # 2007-09-01 00:00
       text  => 'Berliner Allee (Wei�ensee) in Richtung stadteinw�rts, in H�he Rennbahnstr. Baustelle, Fahrtrichtung gesperrt (bis Ende September 2007)',
       type  => 'gesperrt',
       source_id => 'IM_005060',
       data  => <<EOF,
userdel	1::inwork 14535,17003 14559,16912
EOF
     },
     { from  => 1175031936, # 2007-03-27 23:45
       until => 1180033051, # 2007-10-01 00:00 1191189600
       text  => 'Florastr. (Pankow) M�hlenstr. in Richtung Berliner Str. Baustelle, Fahrtrichtung gesperrt (bis September 2007)',
       type  => 'gesperrt',
       source_id => 'IM_004035',
       data  => <<EOF,
userdel	1::inwork 10459,17754 10548,17817 10705,17931 10830,17985
EOF
     },
     { from  => undef, # 
       until => 1183154400, # 2007-06-30 00:00
       text  => 'Rathausstr. (Tempelhof) in beiden Richtungen, zwischen Kurf�rstenstr. und Kaiserstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 06/07) (07:34) ',
       type  => 'gesperrt',
       source_id => 'IM_005053',
       data  => <<EOF,
userdel	2::inwork 8868,4498 8877,4356
EOF
     },
     { from  => undef, # 
       until => 1191189599, # 2007-09-30 23:59
       text  => 'Transvaalstr. (Wedding) in Richtung M�llerstr., zwischen Guineastr. und L�deritzstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 09/07)',
       type  => 'handicap',
       source_id => 'IM_005069',
       data  => <<EOF,
userdel	q4::inwork; 5988,16099 6104,16223 6215,16340
EOF
     },
     { from  => 1176674400, # 2007-04-16 00:00
       until => 1177192800, # 2007-04-22 00:00
       text  => 'B 096 H�he Krz..Buberow/ Meseberg grundhafter Stra�enbau Vollsperrung 17.04.2007-21.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -7906,61543 -7974,62020 -7693,63274
EOF
     },
     { from  => 1176069600, # 2007-04-09 00:00
       until => 1183154400, # 2007-06-30 00:00
       text  => 'L 030 Ethel-und-Julius-Rosenberg-Str. OD Woltersdorf Stra�enbau, Entw�sserung Vollsperrung 10.04.2007-29.06.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 34535,5319 34511,4787 34574,4552
EOF
     },
     { from  => 1156629600, # 2006-08-27 00:00
       until => 1176156000, # 2007-04-10 00:00
       text  => 'L 030 R�dersdorfer Str. OD Woltersdorf, zw. R.-Breitschei-Str. u. Interlakenstr. Stra�enbau, Entw�sserung Vollsperrung 28.08.2006-09.04.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 34579,5745 34535,5319
EOF
     },
     { from  => 1175378400, # 2007-04-01 00:00
       until => 1175637600, # 2007-04-04 00:00
       text  => 'B 096 Sonnewalde-Luckau zw. Dabern und Wei�ack De- und Montage Trafostation Vollsperrung 02.04.2007-03.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30832,-72209 30767,-72806
EOF
     },
     { from  => 1175378400, # 2007-04-01 00:00
       until => 1180648800, # 2007-06-01 00:00
       text  => 'L 015 M�hlenstr. OD Rheinsberg, zw. Schlo�str. u. Rhinstr. Kanalarbeiten Vollsperrung 02.04.2007-31.05.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -25801,76494 -25728,76368 -25728,76256
EOF
     },
     { from  => 1176069600, # 2007-04-09 00:00
       until => 1182549600, # 2007-06-23 00:00
       text  => 'L 015 zw. Gollmitz u. Berkholz u. Boitzenburg Deckensanierung Vollsperrung 10.04.2007-22.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 29760,99768 27416,98865 26759,98614 26304,98234 26128,97916 25974,97619 24828,97295 24216,96897 23278,96396
EOF
     },
     { from  => undef, # 
       until => 1191189600, # 2007-10-01 00:00
       text  => 'Glinkastr. (Mitte) in Richtung Leipziger Str., zwischen J�gerstr. und Taubenstr. Baustelle, Fahrtrichtung gesperrt (bis Herbst 2007) (16:40) ',
       type  => 'gesperrt',
       source_id => 'IM_003833',
       data  => <<EOF,
userdel	1::inwork 9201,11968 9208,11872
EOF
     },
     { from  => 1190671200, # 2007-09-25 00:00
       until => 1194649200, # 2007-11-10 00:00
       text  => 'L 040 Blankenfelde-Gro�beeren OD Diedersdorf, Mahlower Str.bis Kreisverkehr grundhafter Stra�enausbau Vollsperrung 26.09.2007-09.11.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	2::inwork 7981,-7165 7558,-7093
EOF
     },
     { from  => 1176242400, # 2007-04-11 00:00
       until => 1176415200, # 2007-04-13 00:00
       text  => 'K 6617 zw. B169 und Ressen Deckeneinbau auf B169 Vollsperrung 12.04.2007-12.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 63128,-86845 62491,-87561 61763,-88249
EOF
     },
     { from  => 1176760800, # 2007-04-17 00:00
       until => 1176933600, # 2007-04-19 00:00
       text  => 'L 049 L�bbenau-L�bben Bahn�bergang nach OA L�bben Gleisbauarbeiten Vollsperrung 18.04.2007-18.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 45171,-52848 45152,-53482 45088,-55645
EOF
     },
     { from  => 1177020000, # 2007-04-20 00:00
       until => 1177365600, # 2007-04-24 00:00
       text  => 'L 049 L�bbenau-L�bben Bahn�bergang nach OA L�bben Gleisbauarbeiten Vollsperrung 21.04.2007-23.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 45088,-55645 45152,-53482 45171,-52848
EOF
     },
     { from  => 1177452000, # 2007-04-25 00:00
       until => 1177711200, # 2007-04-28 00:00
       text  => 'L 049 L�bbenau-L�bben Bahn�bergang nach OA L�bben Gleisbauarbeiten Vollsperrung 26.04.2007-27.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 45088,-55645 45152,-53482 45171,-52848
EOF
     },
     { from  => 1175726673, # 2007-04-05 00:44
       until => 1176674399, # 2007-04-15 23:59
       text  => 'Gustav-Meyer-Allee (Wedding) Richtung Scheringstr. zwischen Brunnenstr. und Hussitenstr. Baustelle, Fahrtrichtung gesperrt (bis Mitte 04.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005138',
       data  => <<EOF,
userdel	1::inwork 9443,15430 8900,15146
EOF
     },
     { from  => 1176069600, # 2007-04-09 00:00
       until => 1196463600, # 2007-12-01 00:00
       text  => 'L 024 AS Pfingstberg-Gerswalde OD Suckow grundhafter Stra�enbau Vollsperrung 10.04.2007-30.11.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 39125,83492 38986,84365
EOF
     },
     { from  => 1176069600, # 2007-04-09 00:00
       until => 1184881131, # 2007-07-27 00:00 1185487200
       text  => 'L 033 Eggersdorf-Altlandsberg Br�cke �ber den Graben in der OD Radebr�ck Br�ckenneubau Vollsperrung 10.04.2007-26.07.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 36768,17309 35728,17428 35618,17440 35225,17557
EOF
     },
     { from  => 1175810400, # 2007-04-06 00:00
       until => 1176156000, # 2007-04-10 00:00
       text  => 'L 056 Klein Meh�ow-Crinitz OD F�rstlich Drehna Moto-Cross-Meisterschaft Vollsperrung 07.04.2007-09.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 39208,-72065 39419,-72066 39608,-71896 39966,-71985
EOF
     },
     { from  => 1176069600, # 2007-04-09 00:00
       until => 1188597600, # 2007-09-01 00:00
       text  => 'L 171 Sch�nflie�er Str. OD Hohen Neuendorf grundhafter Stra�enbau Vollsperrung 10.04.2007-31.08.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 1596,29362 1810,29283 2033,29198
EOF
     },
     { from  => 1176069600, # 2007-04-09 00:00
       until => 1177103835, # 1177452000 2007-04-25 00:00
       text  => 'B 167 Eberswalder Str. OD Eberswalde, zw. Spechthausener Str. u. Sch�nholzer Str. Deckenerneuerung Vollsperrung 10.04.2007-24.04.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 32139,48523 33163,48487 34334,48750
EOF
     },
     { from  => 1176069600, # 2007-04-09 00:00
       until => 1176588000, # 2007-04-15 00:00
       text  => 'L 021 Wensickendorf-Liebenwalde OD Zehlendorf Einbau Deckschicht Vollsperrung 10.04.2007-14.04.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 9043,42165 9032,42153 8925,42114 8696,42028
EOF
     },
     { from  => 1176069600, # 2007-04-09 00:00
       until => 1176588000, # 2007-04-15 00:00
       text  => 'L 029 Wandlitz-Schmachtenhagen OD Zehlendorf Einbau Deckschicht Vollsperrung 10.04.2007-14.04.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 8332,41982 8439,41992 8504,41998 8521,41998 8600,42004 8696,42028
EOF
     },
     { from  => 1176328800, # 2007-04-12 00:00
       until => 1177192800, # 2007-04-22 00:00
       text  => 'L 064 Riesaer Str. OL Bad Liebenwerda Deckenerneuerung Vollsperrung 13.04.2007-21.04.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 11862,-99775 11974,-99110
EOF
     },
     { from  => undef, # 
       until => 1177364867, # 1177970399 2007-04-30 23:59
       text  => 'Wiltbergstr. (Pankow) in beiden Richtungen, zwischen R�ntgentaler Weg - R�bellweg Baustelle, Verkehr wird wechselseitig vorbeigef�hrt (bis Ende 04.07)',
       type  => 'handicap',
       source_id => 'IM_005169',
       data  => <<EOF,
userdel	q4::inwork 16045,25907 16114,25827 16166,25767
EOF
     },
     { from  => 1176243783, # 2007-04-11 00:23
       until => 1191018892, # 2007-12-31 23:59 1199141999
       text  => 'Schlichtallee (Lichtenberg) in beiden Richtungen, zwischen L�ckstr. und Hauptstr. Baustelle, Verkehr wird wechselseitig vorbeigef�hrt (bis Ende 2007)',
       type  => 'handicap',
       source_id => 'IM_004349',
       data  => <<EOF,
userdel	q4::inwork 15758,10578 15639,10469
EOF
     },
     { from  => 1176243818, # 2007-04-11 00:23
       until => 1176488154, # 2007-04-14 00:00 1176501600
       text  => 'Finkenkruger Weg (Spandau) in beiden Richtungen, zwischen Seegefelder Weg und Torweg Baustelle, Verkehr wird wechselseitig vorbeigef�hrt (bis 13.04.07)',
       type  => 'handicap',
       source_id => 'IM_005170',
       data  => <<EOF,
userdel	q4::inwork -7413,14561 -7391,14857 -7390,14881 -7387,14951 -7373,15154 -7371,15201 -7365,15306
EOF
     },
     { from  => 1172617200, # 2007-02-28 00:00
       until => 1185919200, # 2007-08-01 00:00
       text  => 'L 073 Beelitzer Str. OD Luckenwalde, zw. B101 und Neue Beelitzer Str. Stra�enausbau Vollsperrung 01.03.2007-31.07.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -4299,-35198 -4725,-34957
EOF
     },
     { from  => 1176488131, # 2007-04-13 20:15
       until => 1177106400, # 2007-04-21 00:00
       text  => 'S�ntisstr. (Tempelhof) in beiden Richtungen, zwischen Zehrensdorfer Str. und Alt-Marienfelde Baustelle, Stra�e vollst�ndig gesperrt (bis 20.04.07)',
       type  => 'gesperrt',
       source_id => 'IM_005211',
       data  => <<EOF,
userdel	2::inwork 9695,1563 9391,1235 9241,1073 9165,1014 9129,986 9024,906
EOF
     },
     { from  => 1176674400, # 2007-04-16 00:00
       until => 1177106400, # 2007-04-21 00:00
       text  => 'B 109 zw. Stadtgrenze Berliin und Sch�nerlinde, Dorfstr. Deckeneinbau Vollsperrung 17.04.2007-20.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 13376,27572 13348,27204
EOF
     },
     { from  => 1178402400, # 2007-05-06 00:00
       until => 1178834400, # 2007-05-11 00:00
       text  => 'L 038 zw. Briesen und Petersdorf Einbau Deckschicht Vollsperrung 07.05.2007-10.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 74238,-3970 73292,-4598
EOF
     },
     { from  => 1179957600, # 2007-05-24 00:00
       until => 1180130400, # 2007-05-26 00:00
       text  => 'L 049 AS Bademeusel-Forst zw. Forst und Gro� Bademeusel 32. Forster Duathlon zeitw. Vollsperrung 25.05.2007-25.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 101469,-77761 98851,-76089
EOF
     },
     { from  => 1178316000, # 2007-05-05 00:00
       until => 1178488800, # 2007-05-07 00:00
       text  => 'L 049 AS Bademeusel-Forst zw. Forst und Gro� Bademeusel 5. Forster Run & Bike zeitw. Vollsperrung 06.05.2007-06.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 101469,-77761 98851,-76089
EOF
     },
     { from  => 1178402400, # 2007-05-06 00:00
       until => 1179352800, # 2007-05-17 00:00
       text  => 'L 220 B167 AS Finowfurt-Joachimsthal zw. Eichhorst und Elsenau Bau Otterdurchlass Vollsperrung 07.05.2007-16.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 29812,57628 29056,57503
EOF
     },
     { from  => 1177102974, # 2007-04-20 23:02
       until => 1179266399, # 2007-05-15 23:59
       text  => 'Hosemannstra�e (Prenzlauer Berg) in beiden Richtungen, zwischen Erich-Weinert-Stra�e und Schieritzstr. geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt (bis Mitte 05.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005213',
       data  => <<EOF,
userdel	2::inwork 12721,15807 12642,15668 12559,15524
EOF
     },
     { from  => 1177103024, # 2007-04-20 23:03
       until => 1177308746, # 1177365600 2007-04-24 00:00
       text  => 'Ebertstr. (Mitte) in beiden Richtungen, zwischen Behrenstr. und Scheidemannstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 23.04.07, 05:00)',
       type  => 'gesperrt',
       source_id => 'IM_005269',
       data  => <<EOF,
userdel	2::temp 8595,12066 8600,12165 8538,12245 8546,12279 8570,12302 8573,12325 8540,12420
EOF
     },
     { from  => 1177103052, # 2007-04-20 23:04
       until => 1177297200, # 2007-04-23 05:00
       text  => 'Str. des 17, Juni (Tiergarten) in beiden Richtungen, zwischen Gro�er Stern und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (bis 23.04.07, 05:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005268',
       data  => <<EOF,
userdel	2::temp 6828,12031 7383,12095 7816,12150 8055,12186 8089,12190 8214,12205 8303,12216 8538,12245
EOF
     },
     { from  => 1177192800, # 2007-04-22 00:00
       until => 1184536800, # 2007-07-16 00:00
       text  => 'B 167 zw. Dolgelin und Friedersdorf Inbetriebnahme OU Vollsperrung 23.04.2007-15.07.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 78805,11331 78637,11458 78240,11748 77991,12506 77759,12767
EOF
     },
     { from  => 1177538400, # 2007-04-26 00:00
       until => 1177970400, # 2007-05-01 00:00
       text  => 'B 246 Bahn�bergang in der OD Storkow Gleisbauarbeiten Vollsperrung 27.04.2007-30.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 46737,-16548 47038,-17056 47112,-17150
EOF
     },
     { from  => 1177192800, # 2007-04-22 00:00
       until => 1178229600, # 2007-05-04 00:00
       text  => 'L 030 Luckenwalder Str. OD K�nigs Wusterhausen, H�he ALDI Bau einer Zufahrt halbseitig gesperrt; Einbahnstra�e 23.04.2007-03.05.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 25543,-12403 25912,-11956
EOF
     },
     { from  => 1177061612, # 2007-04-20 11:33
       until => 1177171200, # 2007-04-21 18:00
       text  => 'Ordensmeisterstr. (Tempelhof) in beiden Richtungen zwischen Tempelhofer Damm und Lorenzweg Baustelle, Stra�e vollst�ndig gesperrt (bis 18 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005266',
       data  => <<EOF,
userdel	2::inwork 9668,5733 9457,5641 9368,5608 9147,5534
EOF
     },
     { from  => undef, # 
       until => 1214463306, # undef # war, ist nicht mehr: Abbiegen in Kleine Auguststr. und Joachimstr. nicht m�glich;	3 9996,13678 10085,13684 10142,13556; 	3 10142,13556 10085,13684 10220,13691
       text  => 'Linienstr.: Baustelle zwischen Koppenplatz (�stliche Stra�e) und Rosenthaler Str., Einbahnstra�e',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 10220,13691 10085,13684 9996,13678 9945,13669
EOF
     },
     { from  => 1177625221, # 
       until => 1177625224, #
       text  => 'Wittestra�e (Reinickendorf) in beiden Richtungen, zwischen Otisstra�e und Antonienstra�e Arbeiten an Gasleitungen, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005307',
       data  => <<EOF,
userdel	2::inwork 3726,18962 3883,18944 4162,18891
EOF
     },
     { from  => 1178143200, # 2007-05-03 00:00
       until => 1178488800, # 2007-05-07 00:00
       text  => 'B 101 Herzberg-J�terbog zw. Brandis und Abzw. Schweinitz ( Sa.-Anhalt) Deckeneinbau Vollsperrung 04.05.2007-06.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -4418,-65798 -4189,-65380
EOF
     },
     { from  => 1177538400, # 2007-04-26 00:00
       until => 1177884000, # 2007-04-30 00:00
       text  => 'B 101 Herzberg-J�terbog zw. Brandis und Abzw. Schweinitz ( Sa.-Anhalt) Deckeneinbau Vollsperrung 27.04.2007-29.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -4418,-65798 -4189,-65380
EOF
     },
     { from  => 1178488800, # 2007-05-07 00:00
       until => 1178661600, # 2007-05-09 00:00
       text  => 'L 792 Berliner Damm OD Blankenfelde, H�he Hausnummer 4 Kranarbeiten Vollsperrung 08.05.2007-08.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10448,-7582
EOF
     },
     { from  => 1177970400, # 2007-05-01 00:00
       until => 1178748000, # 2007-05-10 00:00
       text  => 'L 034 Philipp-M�ller-Str. OD Strausberg, H�he Feuerwehr Instandsetzung TW-Schieber halbseitig gesperrt; Einbahnstra�e 02.05.2007-09.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 43584,20871 43553,20466 43131,19792
EOF
     },
     { from  => 1314309600, # 1177739838, # 2007-04-28 07:57
       until => 1314568740, # 1177884000, # 2007-04-30 00:00
       text  => 'Reichsstr. (Charlottenburg) in beiden Richtungen zwischen Theodor-Heuss-Platz und Steubenplatz Veranstaltung, Stra�e vollst�ndig gesperrt (27. und 28. August 2011)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 653,12109 738,12025 818,11954 881,11893 1033,11754 1133,11664 1215,11587 1220,11583 1308,11506 1403,11428
EOF
     },
     { from  => undef, # 
       until => 1177884000, # 2007-04-30 00:00
       text  => 'Rheinstr. (Sch�neberg) in beiden Richtungen zwischen Walter-Schreiber-Platz und Saarstr. Stra�enfest, Stra�e gesperrt (16:03) ',
       type  => 'gesperrt',
       source_id => 'IM_005341',
       data  => <<EOF,
userdel	2::temp 5370,6486 5424,6584 5533,6753 5644,6936
EOF
     },
     { from  => 1177739901, # 2007-04-28 07:58
       until => 1178056800, # 2007-05-02 00:00
       text  => 'Stendaler Str. (Hellersdorf) in beiden Richtungen zwischen Hellersdorfer Str. und Janusz-Korczak-Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 01.05.2007 nachts)',
       type  => 'gesperrt',
       source_id => 'IM_005327',
       data  => <<EOF,
userdel	2::temp 23952,15086 23960,15021 23993,14797
EOF
     },
     { from  => 1215543240, # 2008-07-08 20:54
       until => 1219523631, # 2008-08-31 23:59 1220219999
       text  => 'Bernauer Str. (Reinickendorf) in Richtung Spandau, zwischen Seidelstr. und Neheimer Str. Baustelle, Fahrtrichtung gesperrt (bis Ende August 2008)',
       type  => 'gesperrt',
       source_id => 'IM_005465',
       data  => <<EOF,
userdel	1::inwork 2821,18831 2643,18738 2602,18737 2175,18740 1967,18743 1659,18747 1405,18749 1229,18750
EOF
     },
     { from  => undef, # 
       until => 1188597600, # 2007-09-01 00:00
       text  => 'Burgfrauenstr. (Reinickendorf) in beiden Richtungen, zwischen Zeltlinger Pl. und Im Fischgrund Baustelle, Stra�e vollst�ndig gesperrt (bis 09/07)',
       type  => 'gesperrt',
       source_id => 'IM_005369',
       data  => <<EOF,
userdel	2::inwork 2951,24389 2849,24530 2779,24628 2690,24751 2542,24945 2438,25082
EOF
     },
     { from  => undef, # 
       until => 1178221293, # undef
       text  => 'Tiergartenstr. - H. v. Karajan-Str- (Tiergarten) in beiden Richtungen zwischen Stauffenbergstr. und Kemperplatz Veranstaltung Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005359',
       data  => <<EOF,
userdel	2::temp 8172,11679 8094,11657 8021,11636 7816,11571 7717,11540
EOF
     },
     { from  => 1178221257, # 2007-05-03 21:40
       until => 1178575200, # 2007-05-08 00:00
       text  => 'Alt-K�penick (K�penick) gesamter Bereich Alt-K�penick, Schlossplatz, Rosentr., Gr�nstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 07.05.2007 16 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005385',
       data  => <<EOF,
userdel	2::temp 22284,4653 22212,4655 22138,4661 22133,4644 22111,4562 22162,4546 22214,4548 22324,4586
userdel	2::temp 22093,4499 22111,4562
userdel	2::temp 22196,4847 22175,4730 22138,4661
EOF
     },
     { from  => 1178402400, # 2007-05-06 00:00
       until => 1178661600, # 2007-05-09 00:00
       text  => 'B 246 N�chst Neuendorfer Chaussee Bahn�bergang in OL Zossen Bauarbeiten am Bahn�bergang Vollsperrung 07.05.2007-08.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 13326,-20518 13412,-20513 13526,-20548
EOF
     },
     { from  => 1115157600, # 2005-05-04 00:00
       until => 1178402400, # 2007-05-06 00:00
       text  => 'L 015 Berliner Str. OD Lychen, zw. Hohe Stegstr. u. Nesselpfuhlflie� Einbau Asphaltdecke Vollsperrung 05.05.2005-05.05.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 2480,89399 2111,89378 1907,89597
EOF
     },
     { from  => 1178402400, # 2007-05-06 00:00
       until => 1178744977, # 1179698400 2007-05-21 00:00 see also below
       text  => 'L 040 Zossener Damm OD Blankenfelde, zw. Tankstelle u. Garagentrakt. Ausbau Landesstra�e Vollsperrung 07.05.2007-20.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10115,-8276 11115,-8466
EOF
     },
     { from  => undef, # 
       until => 1178488800, # 2007-05-07 00:00
       text  => 'Turmstra�e (Wedding) in beiden Richtungen, zwischen Stromstra�e und Oldenburger Str. Veranstaltung, Stra�e gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005384',
       data  => <<EOF,
userdel	2::temp 6228,13324 6115,13328 6105,13328 6011,13330 5956,13330 5857,13342 5705,13359
EOF
     },
     { from  => 1304632800, # 1178379282, # 2007-05-05 17:34 # erster Termin im Jahr
       until => 1304892000, # 1178488800, # 2007-05-07 00:00
       text  => 'Alt-Rudow (Rudow) in beiden Richtungen zwischen K�penicker Str. und Krokusstr. Veranstaltung, Stra�e vollst�ndig gesperrt (7. und 8. Mai 2011)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 16849,1437 16805,1488 16610,1715
EOF
     },
     { from  => 1178564497, # 2007-05-07 21:01
       until => 1178920800, # 2007-05-12 00:00
       text  => 'Gleimstr. (Prenzlauer Berg) Richtung Brunnenstr. zwischen Sch�nhauser Allee und Ystader Str. Baustelle, Fahrtrichtung gesperrt (bis 11.05.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005412',
       data  => <<EOF,
userdel	1::inwork 10953,15787 10713,15746 10564,15721 10427,15699 10423,15698
EOF
     },
     { from  => 1178402400, # 2007-05-06 00:00
       until => 1181944800, # 2007-06-16 00:00
       text  => 'K 6419 Garzauer Str. zw. Strausberg, E.-Th�lmann-Str. u. Eggersd.Weg (Umgehungs.) Deckenerneuerung Vollsperrung 07.05.2007-15.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 40540,16584 40793,16343 41168,16281
EOF
     },
     { from  => 1176069600, # 2007-04-09 00:00
       until => 1191189600, # 2007-10-01 00:00
       text  => 'L 029 Gr�ntal-B 2 Biesenthal OD Biesenthal Deckenerneuerung mit Entw�ss. Vollsperrung 10.04.2007-30.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 28967,38692 28199,39134 26237,40190
EOF
     },
     { from  => 1178402400, # 2007-05-06 00:00
       until => 1178920800, # 2007-05-12 00:00
       text  => 'L 234 Landsberger Str. OD Bruchm�hle, H�he Fichtestr. Havarie TW-Netz Vollsperrung 07.05.2007-11.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 36087,16319 35807,16563
EOF
     },
     { from  => 1178402400, # 2007-05-06 00:00
       until => 1179698400, # 2007-05-21 00:00
       text  => 'L 040 Zossener Damm OD Blankenfelde Ausbau Landesstr. Vollsperrung 07.05.2007-20.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10115,-8276 11115,-8466
EOF
     },
     { from  => 1180648800, # 2007-06-01 00:00
       until => 1180994400, # 2007-06-05 00:00
       text  => 'B 273 Wensickendorf-Oranienburg Schleusenbr�cke Lehnitz am OA Oranienburg Instandsetzungsarbeiten Vollsperrung 02.06.2007-04.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 1284,39885 1406,39868
EOF
     },
     { from  => 1178834400, # 2007-05-11 00:00
       until => 1179180000, # 2007-05-15 00:00
       text  => 'B 273 Wensickendorf-Oranienburg Schleusenbr�cke Lehnitz am OA Oranienburg Instandsetzungsarbeiten Vollsperrung 12.05.2007-14.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 1284,39885 1406,39868
EOF
     },
     { from  => 1179439200, # 2007-05-18 00:00
       until => 1179784800, # 2007-05-22 00:00
       text  => 'B 273 Wensickendorf-Oranienburg Schleusenbr�cke Lehnitz am OA Oranienburg Instandsetzungsarbeiten Vollsperrung 19.05.2007-21.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 1284,39885 1406,39868
EOF
     },
     { from  => 1179439200, # 2007-05-18 00:00
       until => 1179698400, # 2007-05-21 00:00
       text  => 'B 183 Dresdener Str. OL Bad Liebenwerda, zw. Querspange u. Ro�markt Kleines Stadtfest Vollsperrung 19.05.2007-20.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 12194,-98944 12593,-99029
EOF
     },
     { from  => 1179266400, # 2007-05-16 00:00
       until => 1179612000, # 2007-05-20 00:00
       text  => 'K 6908 Ferch-B 1 Geltow zw. B 1 und Fercher Str. in Petzow G 8 - Gipfel Vollsperrung 17.05.2007-19.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp -20281,-6915 -20051,-6631 -19760,-6450
EOF
     },
     { from  => undef, # 
       until => 1179010800, # 2007-05-13 01:00
       text  => 'Bartningallee (Tiergarten) in beiden Richtungen zwischen Altonaer Str. und Hanseatenweg Veranstaltung, Stra�e vollst�ndig gesperrt (bis 01:00 Uhr) ',
       type  => 'handicap',
       source_id => 'IM_005439',
       data  => <<EOF,
userdel	q4::temp 6178,12387 6276,12506 6314,12518 6444,12536
EOF
     },
     { from  => $isodate2epoch->("2013-05-10 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-05-12 23:59:59"),
       periodic => 1,
       text  => 'B�lschestr. (K�penick): Veranstaltung (Fest auf der "B�lsche"), Stra�e vollst�ndig gesperrt (11. und 12. Mai 2013)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 25519,4830 25524,5011 25539,5237 25544,5326 25546,5359 25548,5398 25553,5486 25567,5749 25571,5829 25579,5958
EOF
     },
     { from  => 1178874938, # 2007-05-11 11:15
       until => 1179007200, # 2007-05-13 00:00
       text  => 'Stra�e des 17.Juni (Tiergarten) in beiden Richtungen, zwischen Yitzhak-Rabin-Str. und Gro�er Stern Veranstaltung, Stra�e vollst�ndig gesperrt (bis 24:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005469',
       data  => <<EOF,
userdel	2::temp 8055,12186 7816,12150 7383,12095 6828,12031
EOF
     },
     { from  => 1179185929, # 2007-05-15 01:38
       until => 1180420736, # 2007-05-31 23:59 1180648799
       text  => 'Wilhelminenhofstr. (Obersch�neweide) Richtung An der Wuhlheide zwischen Rathenaustr. und Ostendstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 05.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005487',
       data  => <<EOF,
userdel	1::inwork 18861,6000 18932,5926 19024,5830
EOF
     },
     { from  => 1178402400, # 2007-05-06 00:00
       until => 1179525600, # 2007-05-19 00:00
       text  => 'L 234 Landsberger Str. OD Bruchm�hle, H�he Fichtestr. Havarie TW-Netz Vollsperrung 07.05.2007-18.05.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 36087,16319 35807,16563
EOF
     },
     { from  => 1179352800, # 2007-05-17 00:00
       until => 1179612000, # 2007-05-20 00:00
       text  => 'B 112 Bahnhofstr., Frankfurter Str. OD Neuzelle 6. Run & Bike Veranstaltung halbseitig gesperrt; Einbahnstra�e 18.05.2007-19.05.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 96017,-33547 96014,-33803
EOF
     },
     { from  => 1179341723, # 2007-05-16 20:55
       until => 1179957600, # 2007-05-24 00:00
       text  => 'Sylter Str. (Wedding) in Richtung Seestr. Fahrtrichtung gesperrt (bis 23.05.07)',
       type  => 'gesperrt',
       source_id => 'IM_005513',
       data  => <<EOF,
userdel	1::inwork 6334,14756 5972,14820 5753,15096
EOF
     },
     { from  => 1179648093, # 2007-05-20 10:01
       until => 1180735199, # 2007-06-01 23:59
       text  => 'Flottwellstr. (Tiergarten) Richtung Potsdamer Str. Baustelle, Fahrtrichtung gesperrt (bis Anfang 06.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005532',
       data  => <<EOF,
userdel	1::inwork 8336,10829 8300,10823 8281,10791 8199,10634
EOF
     },
     { from  => 1180476000, # 2007-05-30 00:00
       until => 1180735200, # 2007-06-02 00:00
       text  => 'L 037 M�llrose-Petersdorf Bahn�bergang in der OL Jacobsdorf Gleisbauarbeiten Vollsperrung 31.05.2007-01.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 75402,-6910 75394,-6991 75272,-7514
EOF
     },
     { from  => 1179900343, # 2007-05-23 08:05
       until => 1180421086, # 2007-05-30 00:00 1180476000
       text  => 'Str. des 17. Juni (Tiergarten) in beiden Richtungen zwischen Brandenburger Tor und Y.-Rabin-Str. Veranstaltung, Stra�e vollst�ndig gesperrt (Pokalmeile zum Pokalendspiel) (bis 29.05.2007 morgens)',
       type  => 'gesperrt',
       source_id => 'IM_005565',
       data  => <<EOF,
userdel	2::temp 8089,12190 8214,12205 8303,12216 8538,12245
EOF
     },
     { from  => 1179862554, # 2007-05-22 21:35
       until => 1180420718, # 2007-05-31 23:59 1180648799
       text  => 'Wa�mannsdorfer Chaussee (Rudow) in beiden Richtungen, zwischen Gefl�gelsteig und Rhodel�nderweg geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt (bis Ende 05/2007)',
       type  => 'gesperrt',
       source_id => 'IM_005511',
       data  => <<EOF,
userdel	2::inwork 16373,-496 16400,-409 16431,-311 16536,26
EOF
     },
     { from  => 1179698400, # 2007-05-21 00:00
       until => 1188597600, # 2007-09-01 00:00
       text  => 'L 040 Ragow-Dahlewitz OD Dahlewitz, Kno. Th�lmannstr./ Dorfstr. Bau Kreisverkehr Vollsperrung 22.05.2007-31.08.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 13228,-9606 13576,-9738 13878,-9818
userdel	q4::inwork 13772,-10251 13576,-9738 13503,-9528
EOF
     },
     { from  => 1152482400, # 2006-07-10 00:00
       until => 1189842302, # Time::Local::timelocal(reverse(2007-1900,9-1,20,23,59,59)), # was: 1189807200, # 2007-09-15 00:00
       text  => 'L 040 Blankenfelde-Gro�beeren OD Diedersdorf grundhafter Stra�enausbau Vollsperrung 11.07.2006-20.09.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 7981,-7165 7558,-7093
EOF
     },
     { from  => 1180130400, # 2007-05-26 00:00
       until => 1180303200, # 2007-05-28 00:00
       text  => 'L 071 Wiepersdorf-Brandis OL Sch�newalde, Markt Heimat- u. Sch�tzenfest zeitw. Vollsperrung 27.05.2007-27.05.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp -575,-65978 60,-66035
EOF
     },
     { from  => 1180303200, # 2007-05-28 00:00
       until => 1181672690, # 2007-06-24 00:00 1182636000
       text  => 'B 158 von OD Neuendorf bis OE Oderberg Deckenerneuerung Vollsperrung 29.05.2007-23.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 53948,53269 53937,54875
EOF
     },
     { from  => 1181340000, # 2007-06-09 00:00
       until => 1181512800, # 2007-06-11 00:00
       text  => 'L 023 zw. KVK Seespitze Strausberg u. B168 (Pr�tzel-Tiefensee) und L 033 Gielsdorfer Chaussee OL Strausberg, zw. Badstr. u. KVK Seespitze; 18. Teamtriathlon Behinderungen 10.06.2007-10.06.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 41887,22959 41553,23243
userdel	q4::temp 43343,21459 43406,21325 43498,21028 43584,20871
EOF
     },
     { from  => 1179871200, # 2007-05-23 00:00
       until => 1191189600, # 2007-10-01 00:00
       text  => 'L 040 Zossener Damm OD Blankenfelde, zw. J�hnsdorfer Weg u. A.-D�rer-Str. Kanal- und Stra�enbau Vollsperrung 24.05.2007-30.09.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 10115,-8276 11115,-8466
EOF
     },
     { from  => 1180032862, # 2007-05-24 20:54
       until => 1180411200, # 2007-05-29 06:00
       text  => 'Ebertstr. (Tiergarten) In beiden Richtungen zwischen Behrenstr. und Scheidemannstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 29.05.2007 morgens)',
       type  => 'gesperrt',
       source_id => 'IM_005563',
       data  => <<EOF,
userdel	2::temp 8595,12066 8600,12165 8538,12245 8546,12279 8570,12302 8573,12325 8540,12420
EOF
     },
     { from  => 1180476000, # 2007-05-30 00:00
       until => 1180994400, # 2007-06-05 00:00
       text  => 'L 030 Friedrichstr. OD Erkner, zw. Kreiverkehr und Beuststr. 14. Heimatfest Vollsperrung 31.05.2007-04.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 34443,1951 34250,2546
EOF
     },
     { from  => undef, # 
       until => 1181428648, # undef
       text  => 'Friedrichstr. (Kreuzberg) zwischen Kochstr. und Zimmerstr. Baustelle, Radfahrer k�nnen aber langsam passieren',
       type  => 'handicap',
       source_id => 'IM_005616',
       data  => <<EOF,
userdel	q4::inwork 9492,11209 9478,11317
EOF
     },
     { from  => 1180459975, # 2007-05-29 19:32
       until => 1180519200, # 2007-05-30 12:00
       text  => 'Friedrich-List-Ufer (Tiergarten) in beiden Richtungen bei Hauptbahnhof Veranstaltung, Stra�e vollst�ndig gesperrt (bis 30.05.2007 ca. 12 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005623',
       data  => <<EOF,
userdel	2::temp 8098,13419 8102,13304 8106,13130 8110,13042
EOF
     },
     { from  => undef, # 
       until => 1180730929, # undef
       text  => 'L�ckstr. (Lichtenberg) in beiden Richtungen zwischen Weitlingstr. und Emanuelstr. Einsturzgefahr eines Hauses, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005633',
       data  => <<EOF,
userdel	2::inwork 16468,10695 16313,10747
EOF
     },
     { from  => 1180506105, # 2007-05-30 08:21
       until => 1180562399, # 2007-05-30 23:59
       text  => 'Sperrungen im Neuen Garten wegen des G8-Vorbereitungstreffens, bis 2007-05-30 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp -12139,1325 -12094,1273 -12081,1168
userdel	2::temp -12166,1384 -12141,1357 -12139,1325 -12148,1245 -12186,1118 -12154,963 -12182,816
userdel	2::temp -11818,993 -11871,1087 -12081,1168
userdel	2::temp -11887,837 -11856,950
userdel	2::temp -11581,559 -11650,590 -11603,721 -11615,853 -11715,959
userdel	2::temp -11990,1214 -11871,1185 -11580,1281 -11544,1262 -11537,1206 -11575,1031 -11562,918 -11510,810 -11412,784 -11392,762
EOF
     },
     { from  => 1180567260, # 2007-05-31 01:21
       until => 1186005599, # 2007-08-01 23:59
       text  => 'Birkenstr. (Wedding) zwischen L�becker Str. und Stromstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Anfang 08.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005464',
       data  => <<EOF,
userdel	2::inwork 6365,13879 6227,13938
EOF
     },
     { from  => 1181672436, # 
       until => 1181672441, #
       text  => 'Blankenfelder Chaussee in beiden Richtungen, zwischen Alt-L�bars und Bahnhofstra�e Baustelle, Stra�e vollst�ndig gesperrt ',
       type  => 'gesperrt',
       source_id => 'IM_005637',
       data  => <<EOF,
userdel	2::inwork 8141,23477 7185,23749
EOF
     },
     { from  => 1180821600, # 2007-06-03 00:00
       until => 1181944800, # 2007-06-16 00:00
       text  => 'L 038 zw. Treplin und Sieversdorf Sicherung Hohlr�ume Vollsperrung 04.06.2007-15.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 77833,-697 78103,-165
EOF
     },
     { from  => 1181599200, # 2007-06-12 00:00
       until => 1182117600, # 2007-06-18 00:00
       text  => 'K 6503 Wandlitzer Chaussee Bahn�bergang in der OT Lubowsee Gleisbauarbeiten Vollsperrung 13.06.2007-17.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 9059,36323 9282,36780 9439,36963 10209,37661
EOF
     },
     { from  => 1180562400, # 2007-05-31 00:00
       until => 1180908000, # 2007-06-04 00:00
       text  => 'K 6747 Gro� Schauen-Alt Stahnsdorf Bahn�bergang bei Philadelphia Gleisbauarbeiten Vollsperrung 01.06.2007-03.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 44269,-15317 44343,-15112 44369,-14650
EOF
     },
     { from  => 1181426400, # 2007-06-10 00:00
       until => 1181685600, # 2007-06-13 00:00
       text  => 'K 6747 Gro� Schauen-Alt Stahnsdorf Bahn�bergang bei Philadelphia Gleisbauarbeiten Vollsperrung 11.06.2007-12.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 44269,-15317 44343,-15112 44369,-14650
EOF
     },
     { from  => 1181858400, # 2007-06-15 00:00
       until => 1182376800, # 2007-06-21 00:00
       text  => 'K 6747 Gro� Schauen-Alt Stahnsdorf Bahn�bergang bei Philadelphia Gleisbauarbeiten Vollsperrung 16.06.2007-20.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 44269,-15317 44343,-15112 44369,-14650
EOF
     },
     { from  => 1180562400, # 2007-05-31 00:00
       until => 1181944800, # 2007-06-16 00:00
       text  => 'K 6748 Kummersdorf-Alt Stahnsdorf Bahn�bergang in Kummersdorf Gleisbauarbeiten Vollsperrung 01.06.2007-15.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 43279,-13594 42804,-13910 42430,-14398
EOF
     },
     { from  => 1180821600, # 2007-06-03 00:00
       until => 1181340000, # 2007-06-09 00:00
       text  => 'L 030 Luckenwalder Str. OD K�nigs Wusterhausen, zw. Cottbuser Str. und ALDI Kanalarbeiten Vollsperrung 04.06.2007-08.06.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 25543,-12403 25912,-11956
EOF
     },
     { from  => 1182031200, # 2007-06-17 00:00
       until => 1182549600, # 2007-06-23 00:00
       text  => 'L 040 L 23 Storkow-L 39 Friedersdorf Bahn�bergang bei Kummersdorf Gleisbauarbeiten Vollsperrung 18.06.2007-22.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 44261,-14205 43456,-14384 42430,-14398
EOF
     },
     { from  => undef, # 
       until => 1180901636, # undef
       text  => 'Alt-M�ggelheim (K�penick) in beiden Richtungen Veranstaltung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005660',
       data  => <<EOF,
userdel	2::temp 28188,962 28317,891 28225,1009 28094,1090
userdel	2::temp 28094,1090 28188,962
EOF
     },
     { from  => 1180783143, # 2007-06-02 13:19
       until => 1180908000, # 2007-06-04 00:00
       text  => 'M�llerstr. (Wedding) in beiden Richtungen, zwischen Transvaalstr. und Liverpooler Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 03.06.2007, 24 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005655',
       data  => <<EOF,
userdel	2::temp 6311,16457 6208,16546 6103,16635 6038,16694 6019,16712 5937,16784 5900,16817 5777,16924
EOF
     },
     { from  => 1180783165, # 2007-06-02 13:19
       until => 1183327199, # 2007-07-01 23:59
       text  => 'Vo�str. (Mitte) Richtung Ebertstr. zwischen Wilhelmstr. und Ebertstr. Baustelle, Fahrtrichtung gesperrt (bis Anfang 07.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005661',
       data  => <<EOF,
userdel	1::inwork 9000,11727 8837,11676 8743,11663 8553,11638
EOF
     },
     { from  => 1195515804, #  undef
       until => 1195515809, #
       text  => 'Simon-Dach-Str./W�hlischstr.: Bauarbeiten, Ausweichen auf Gehweg',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 13981,11746 13954,11647
EOF
     },
     { from  => 1180991094, # 2007-06-04 23:04
       until => 1192223607, # 2007-11-30 23:59 1196463599
       text  => 'Bernstorffstr. (Reinickendorf) Richtung A111 zwischen Berliner Str. und Buddestr. Baustelle, Fahrtrichtung gesperrt (bis 11.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005680',
       data  => <<EOF,
userdel	1::inwork 2020,20327 2131,20406 2241,20487
EOF
     },
     { from  => 1181165074, # undef
       until => 1181165075, # undef (nur noch "Verkehrsst�rung erwartet)
       text  => 'Budapester Str. (Tiergarten) in beiden Richtungen zwischen L�tzowufer und Kurf�rstenstr. Stra�e vollst�ndig gesperrt, Staatsbesuch',
       type  => 'gesperrt',
       source_id => 'IM_005699',
       data  => <<EOF,
userdel	2::temp 6145,10975 6168,11042 6447,11144 6582,11202
EOF
     },
     { from  => 1181024556, # 2007-06-05 08:22
       until => 1181138400, # 2007-06-06 16:00
       text  => 'Drakestr. (Steglitz) in beiden Richtungen zwischen Knesebeckstr. und Hans-Sachs-Str. Baustelle, Stra�e vollst�ndig gesperrt (bis 16.00 Uhr)',
       type  => 'gesperrt',
       source_id => 'INKO_86792',
       data  => <<EOF,
userdel	2::inwork 3048,4305 3142,4173 3151,4160 3214,4066 3228,4046 3259,4002
EOF
     },
     { from  => 1181253600, # 2007-06-08 00:00
       until => 1181512800, # 2007-06-11 00:00
       text  => 'L 054 Calau-Vetschau Bahn�bergang in der OD Sa�leben Gleisbauarbeiten Vollsperrung 09.06.2007-10.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 50732,-71705 51374,-71361 51440,-71337
EOF
     },
     { from  => 1181512800, # 2007-06-11 00:00
       until => 1181772000, # 2007-06-14 00:00
       text  => 'L 054 Calau-Vetschau Bahn�bergang in der OD Sa�leben Gleisbauarbeiten Vollsperrung 12.06.2007-13.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 50732,-71705 51374,-71361 51440,-71337
EOF
     },
     { from  => 1181240753, # 2007-06-07 20:25
       until => 1202597127, # 2008-02-29 23:59 1204325999
       text  => 'Hultschiner Damm (Mahlsdorf) Richtung Alt-Mahlsdorf zwischen R�sternallee und Levensauer Str. Baustelle, Fahrtrichtung gesperrt (bis 02.2008)',
       type  => 'gesperrt',
       source_id => 'IM_004688',
       data  => <<EOF,
userdel	1::inwork 23891,8780 23927,8864 23933,8879 23946,8909 23982,8994 24001,9037 24032,9111 24051,9156 24085,9237 24143,9371 24190,9484 24205,9520 24227,9574 24250,9629 24291,9727 24299,9746 24337,9835
EOF
     },
     { from  => 1182636000, # 2007-06-24 00:00
       until => 1220220000, # 2008-09-01 00:00
       text  => 'B 168 zw. F�rstenwalde und Trebus Grundhafter Stra�enbau Vollsperrung 25.06.2007-31.08.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 54195,309 54279,10 54341,-331 54632,-1291
EOF
     },
     { from  => 1181167200, # 2007-06-07 00:00
       until => 1181340000, # 2007-06-09 00:00
       text  => 'L 256 B109 (Pasewalk)-B104 (Strasburg) Bahn�bergang Nechlin Gleisbauarbeiten Vollsperrung 08.06.2007-08.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 42222,115929 42250,115925 42905,115846
EOF
     },
     { from  => 1181426400, # 2007-06-10 00:00
       until => 1182636000, # 2007-06-24 00:00
       text  => 'L 362 Frankfurter Chaussee OL M�ncheberg, H�he Behlendorfer Weg Stra�enbauarbeiten Vollsperrung 11.06.2007-23.06.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 61140,11287 61156,11478
EOF
     },
     { from  => 1181587527, # 
       until => 1181587530, #
       text  => 'Hosemannstr. (Prenzlauer Berg) in beiden Richtungen, zwischen Grellstr. und Ostseeplatz Baustelle, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005738',
       data  => <<EOF,
userdel	2::inwork 12721,15807 12642,15668 12559,15524 12472,15356 12428,15275
EOF
     },
     { from  => $isodate2epoch->("2013-08-08 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-08-11 23:59:59"),
       periodic => 1,
       text  => 'Treptower Hafenfest 9.8.2013 - 11.8.2013',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 14464,9927 14465,9900 14500,9856 14674,9764 14697,9726 14910,9643
userdel	2::temp 14500,9856 14483,9843
EOF
     },
     { from  => 1189968907, # 
       until => 1189968910, #
       text  => 'Holteistra�e: Bauarbeiten, Fahrbahn ist nicht benutzbar',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 14535,11327 14506,11275 14465,11195
EOF
     },
     { from  => 1181768521, # 
       until => 1181768526, #
       text  => 'Glienicker Weg (Adlershof) Richtung Adlergestell zwischen Nipkowstr. und Adlergestell Fahrbahnuntersp�lung, Fahrtrichtung gesperrt',
       type  => 'handicap',
       source_id => 'IM_005746',
       data  => <<EOF,
userdel	q4::inwork; 20832,3170 20779,3046 20704,2939 20565,2754
EOF
     },
     { from  => 1181685600, # 2007-06-13 00:00
       until => 1181858400, # 2007-06-15 00:00
       text  => 'B 115 Berliner Chaussee Bahn�bergang in der OD L�bben Gleisbauarbeiten Vollsperrung 14.06.2007-14.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 43540,-50369 43031,-50423 40079,-50702
EOF
     },
     { from  => 1181426400, # 2007-06-10 00:00
       until => 1182376800, # 2007-06-21 00:00
       text  => 'B 168 Breite Str. OD Eberswalde, zw. Heine-Str.u. Krz. Freienwalder Str. Deckenerneuerung halbseitig gesperrt; Einbahnstra�e 11.06.2007-20.06.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 38653,47410 38504,47638
EOF
     },
     { from  => 1181426400, # 2007-06-10 00:00
       until => 1185919200, # 2007-08-01 00:00
       text  => 'K 6422 Eggersdorfer Str./ Lessingstr. OL Petershagen, Knoten Lessingstr. u. B� Stra�enausbau Vollsperrung 11.06.2007-31.07.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 36677,14087 36666,14172 36656,14204
EOF
     },
     { from  => 1182031200, # 2007-06-17 00:00
       until => 1188165600, # 2007-08-27 00:00
       text  => 'K 6512 B 96 n�rdl.L�wenberg-B167 Grieben zw. Abzw. Vielitz und Grieben Stra�enbau Vollsperrung 18.06.2007-26.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -14640,54609 -14619,54872 -14667,54977 -14759,55179 -14847,55938 -14966,56468
EOF
     },
     { from  => 1188079200, # 2007-08-26 00:00
       until => 1193871600, # 2007-11-01 00:00
       text  => 'K 6512 B 96 n�rdl.L�wenberg-B167 Grieben zw. Abzw. Vielitz und Grieben Stra�enbau halbseitig^^^^ 27.08.2007-31.10.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -14640,54609 -14619,54872 -14667,54977 -14759,55179 -14847,55938 -14966,56468
EOF
     },
     { from  => 1181426400, # 2007-06-10 00:00
       until => 1188597600, # 2007-09-01 00:00
       text  => 'K 6515 Blumenow-B 96 Dannenwalde zw. Blumenow und Dannenwalde Stra�enbauarbeiten Vollsperrung 11.06.2007-31.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -5737,74650 -5525,74800 -4412,75987 -3920,76368 -1232,77061
EOF
     },
     { from  => 1182204000, # 2007-06-19 00:00
       until => 1182463200, # 2007-06-22 00:00
       text  => 'B 112 Guben-Eisenh�ttenstadt Bahn�bergang bei Gro� Breesen Gleisbauarbeiten Vollsperrung 20.06.2007-21.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 99176,-43536 99245,-43974 99228,-44346
EOF
     },
     { from  => 1181768451, # 2007-06-13 23:00
       until => 1182116704, # 2007-06-18 00:00 1182117600
       text  => 'D�rpfeldstr. (Adlershof) in beiden Richtungen bei Adlergestell Baustelle, Stra�e vollst�ndig gesperrt (bis 17.06.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005786',
       data  => <<EOF,
userdel	2::inwork 20012,3532 19904,3464
EOF
     },
     { from  => 1181768486, # 2007-06-13 23:01
       until => 1185919199, # 2007-07-31 23:59
       text  => 'Flottwellstr. (Tiergarten) Richtung Potsdamer Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 07.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005532',
       data  => <<EOF,
userdel	1::inwork 8336,10829 8300,10823 8281,10791 8199,10634
EOF
     },
     { from  => 1181772000, # 2007-06-14 00:00
       until => 1182031200, # 2007-06-17 00:00
       text  => 'L 070 zw. Pro�marke und Hohenbucko Deckenerneuerung Vollsperrung 15.06.2007-16.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 16701,-71358 17029,-71672 17461,-72373 17827,-72696 17998,-73555
EOF
     },
     { from  => 1188424800, # 2007-08-30 00:00
       until => 1188856800, # 2007-09-04 00:00
       text  => 'L 074 Am Markt OD Teupitz 700-Jahr-Feier Vollsperrung 31.08.2007-03.09.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 25190,-30385 25240,-29746 25412,-29762 25541,-29875
EOF
     },
     { from  => 1339797751, # 2012-06-16 00:02
       until => 1340056800, # 2012-06-19 00:00
       text  => 'Eisenacher Str. Bereich Winterfeldtstr. - Fuggerstr. und Motzstr. zwischen M.-Luther-Str. und Nollendorfplatz gesperrt, Veranstaltung (bis 18.06.12, 06:00)',
       type  => 'gesperrt',
       source_id => 'LMS_1766426574',
       data  => <<EOF,
userdel	2::temp 6628,10318 6626,10155 6729,10212 6739,10120
userdel	2::temp 6609,10147 6514,10088
userdel	2::temp 6971,10346 6729,10212 6719,10347
EOF
     },
     { from  => 1182031200, # 2007-06-17 00:00
       until => 1192485600, # 2007-10-16 00:00
       text  => 'B 005 Treplin-Petershagen OD Petershagen, zw. KVK und Ortsausgang Kanal- und Stra�enbau Vollsperrung 18.06.2007-15.10.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 74197,607 74683,385
EOF
     },
     { from  => 1182031200, # 2007-06-17 00:00
       until => 1182549600, # 2007-06-23 00:00
       text  => 'K 6419 Garzauer Str. zw. Strausberg, E.-Th�lmann-Str. u. SVA Deckenerneuerung Vollsperrung 18.06.2007-22.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 41356,16225 41168,16281
EOF
     },
     { from  => 1182376800, # 2007-06-21 00:00
       until => 1183672800, # 2007-07-06 00:00
       text  => 'L 020 Rosa-Luxemburg-Str. Bahn�bergang in der OL Velten Gleisbauarbeiten Vollsperrung 22.06.2007-05.07.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -5368,30480 -5417,30402 -5496,30288
EOF
     },
     { from  => 1182031200, # 2007-06-17 00:00
       until => 1182722400, # 2007-06-25 00:00
       text  => 'L 020 Veltener Str. OD B�tzow, zw. Marwitzer Str. u. Gr�nstr. Einbau Deckschicht Vollsperrung 18.06.2007-24.06.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -7681,27096 -7250,28021
EOF
     },
     { from  => 1182031200, # 2007-06-17 00:00
       until => 1195308659, # 2007-11-24 00:00 1195858800
       text  => 'L 023 B 2 - Britz Br�cke �ber das kalte Wasser am OE Britz Br�ckenneubau Vollsperrung 18.06.2007-23.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 38357,51575 38170,51708 38089,51876
EOF
     },
     { from  => 1186170676, # 
       until => 1215120478, # (reported by: thuki@...) (Haus wird gebaut, kann eine Weile dauern) (Die Baustelle ist jetzt aufgehoben!)
       text  => 'Homburger Str.: Einbahnstra�e wegen Baustelle zw. Ahrweiler Str. und Assmannshauser Str., Durchfahrt Richtung Osten m�glich',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 4599,7474 4400,7508
EOF
     },
     { from  => undef, # 
       until => 1186170465, # (reported by: thuki@...), auch die Aufhebung
       text  => 'Sarrazinstr.: zurzeit Einbahnstra�e (Elsastr. bis Bundesallee; Durchfahrt in dieser Richtung) wegen Baustelle',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 5352,7428 5422,7461 5452,7493 5492,7543
EOF
     },
     { from  => 1181999685, # 2007-06-16 15:14
       until => 1182110400, # 2007-06-17 22:00
       text  => 'Alt-K�penick (K�penick) in beiden Richtungen, sowie umgebende Stra�en Veranstaltung, Stra�e vollst�ndig gesperrt (bis 17.06.07 22:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005778',
       data  => <<EOF,
userdel	2::temp 22284,4653 22212,4655 22138,4661 22133,4644 22111,4562 22093,4499
userdel	2::temp 22111,4562 22162,4546
userdel	2::temp 22196,4847 22175,4730 22138,4661
EOF
     },
     { from  => 1182000409, # 2007-06-16 15:26
       until => 1182363070, # 1184536799 2007-07-15 23:59
       text  => 'Kastanienallee (Prenzlauer Berg) in Richtung Danziger Str., ab Schwedter Str. Baustelle, Fahrtrichtung gesperrt bis 15.07. ',
       type  => 'gesperrt',
       source_id => 'IM_005800',
       data  => <<EOF,
userdel	1::inwork 10530,14452 10723,14772 10838,14962 10881,15047
EOF
     },
     { from  => undef, # 
       until => 1185227622, # undef
       text  => 'Drakestr. (Lichterfelde) in beiden Richtungen, zwischen Curtiusstr. und Unter den Eichen Fahrbahnuntersp�lung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005823',
       data  => <<EOF,
userdel	2::inwork 3048,4305 3142,4173 3151,4160 3214,4066 3228,4046 3259,4002
EOF
     },
     { from  => undef, # 
       until => 1183280362, # undef
       text  => 'F�rstenbrunner Weg (Charlottenburg) in beiden Richtungen, zwischen Spandauer Damm und Rohrdamm Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005810',
       data  => <<EOF,
userdel	2::inwork 1971,12368 1935,12761 1901,13061
userdel	2::inwork 1858,13231 1610,13380 1545,13418
userdel	2::inwork 931,14268 984,14086 1053,13790 1124,13599
userdel	2::inwork 1159,13541 1175,13513 1193,13485 1488,13454
EOF
     },
     { from  => undef, # 
       until => 1182281918, # undef
       text  => 'Hauptstr. (Blankenfelde) in beiden Richtungen, zwischen Berliner Str. und M�llersfelder Weg Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005809',
       data  => <<EOF,
userdel	2::inwork 9794,23980 9774,23936 9625,23781 9415,23699 9228,23643
EOF
     },
     { from  => undef, # 
       until => 1182281931, # undef
       text  => 'H�ttenweg (Zehlendorf) in beiden Richtungen zwischen Clayallee und Onkel-Tom-Str. Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005827',
       data  => <<EOF,
userdel	2::inwork 297,6541 441,6435
userdel	2::inwork 1514,5163 1443,5193 1385,5214 1333,5246 1212,5353 1086,5491 1051,5525 990,5581 910,5654 894,5829 884,5974 869,6085 736,6217
userdel	2::inwork 486,6404 605,6345
userdel	2::inwork -130,6694 218,6571
EOF
     },
     { from  => 1182201647, # 2007-06-18 23:20
       until => 1183327200, # 2007-07-02 00:00
       text  => 'Invalidenstr. (Mitte) in Richtung Brunnenstr., zwischen Ackerstr und Brunnenstr. Baustelle, Fahrtrichtung gesperrt (bis 01.07.07)',
       type  => 'gesperrt',
       source_id => 'IM_005812',
       data  => <<EOF,
userdel	1::inwork 9810,14066 9822,14067 9937,14080 10003,14088
EOF
     },
     { from  => 1182722400, # 2007-06-25 00:00
       until => 1183413600, # 2007-07-03 00:00
       text  => 'B 087 Luckau-Herzberg OD Schlieben, zw. Horstweg u. Am M�hlberg Moienmarkt Vollsperrung 26.06.2007-02.07.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 10891,-76066 11354,-75979
EOF
     },
     { from  => 1188252000, # 2007-08-28 00:00
       until => 1198191600, # 2007-12-21 00:00
       text  => 'L 235 Gielsdorf-Werneuchen OD Werneuchen Stra�enausbau Vollsperrung 29.08.2007-20.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 32715,25292 32826,25218 33510,24304
EOF
     },
     { from  => 1182281851, # 2007-06-19 21:37
       until => 1182492000, # 2007-06-22 08:00
       text  => 'Ebertstr. (Tiergarten) in beiden Richtungen zwischen Behrenstr. und Lenn�str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 22.06. morgens)',
       type  => 'handicap',
       source_id => 'IM_005839',
       data  => <<EOF,
userdel	q4::temp 8595,12066 8577,11896 8571,11846
EOF
     },
     { from  => 1183068000, # 2007-06-29 00:00
       until => 1183240800, # 2007-07-01 00:00
       text  => 'L 015 Boitzenburg-F�rstenberg OD Lychen, Berliner Str. Kanal- und Stra�enbau Vollsperrung 30.06.2007-30.06.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 2480,89399 2111,89378 1907,89597
EOF
     },
     { from  => 1182636000, # 2007-06-24 00:00
       until => 1182981600, # 2007-06-28 00:00
       text  => 'B 179 Leibsch-M�rkisch-Buchholz OD M�rkisch Buchholz Einbau Schwarzdecke Vollsperrung 25.06.2007-27.06.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 37813,-33029 35916,-32601
EOF
     },
     { from  => 1182538248, # 2007-06-22 20:50
       until => 1190143134, # 2007-10-01 00:00 1191189600
       text  => 'Buchholzer Str. (Pankow) in Richtung Grumbkowstr. ab Charlottenstr. Baustelle, Fahrtrichtung gesperrt (bis 30.09.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005877',
       data  => <<EOF,
userdel	1::inwork 10802,20240 10843,20301 11004,20526 11269,20667
EOF
     },
     { from  => 1184191200, # 2007-07-12 00:00
       until => 1187388000, # 2007-08-18 00:00
       text  => 'L 088 Karl-Marx-Str. OL Beelitz, zw. R.-Koch-Str. u. Zeppelinstr. Ausbau Kreisverkehr Vollsperrung 13.07.2007-17.08.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -19105,-19043 -19058,-19120
EOF
     },
     { from  => undef, # 
       until => 1246831200, # 2009-07-06 00:00
       text  => 'Badstra�e (Wedding) in beiden Richtungen zwischen Pankstr. und Behmstr. Veranstaltung, Stra�e gesperrt bis Mo 00:00 ',
       type  => 'gesperrt',
       source_id => 'IM_013416',
       data  => <<EOF,
userdel	2::temp 8788,16264 8862,16208 8928,16158 8993,16100 9059,16038 9134,15953
EOF
     },
     { from  => 1183280005, # 2007-07-01 10:53
       until => 1188428089, # 2007-08-31 23:59 1188597599
       text  => 'Nennhauser Damm (Spandau) Richtung Brunsb�tteler Damm nach Heerstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 08.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004443',
       data  => <<EOF,
userdel	1::inwork -8784,13321 -8756,13356 -8358,13340 -8296,13338 -8049,13332
EOF
     },
     { from  => 1183280053, # 2007-07-01 10:54
       until => 1183413600, # 2007-07-03 00:00
       text  => 'Altstadt K�penick Stra�e Alt-K�penick und umliegende Stra�en Veranstaltung, Stra�e vollst�ndig gesperrt (bis 02.07.07 16 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005925',
       data  => <<EOF,
userdel	2::temp 22284,4653 22212,4655 22138,4661 22133,4644 22111,4562 22093,4499
userdel	2::temp 22324,4586 22214,4548 22162,4546 22111,4562
userdel	2::temp 22196,4847 22175,4730 22138,4661
EOF
     },
     { from  => 1183193708, # 2007-06-30 10:55
       until => 1183323600, # 2007-07-01 23:00
       text  => 'Brunnenstr. (Wedding) in beiden Richtungen, zwischen Stralsunder Str. und Demminer Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 23 Uhr) ',
       type  => 'gesperrt',
       source_id => 'IM_005922',
       data  => <<EOF,
userdel	2::temp 9642,15038 9718,14888
EOF
     },
     { from  => $isodate2epoch->("2013-06-24 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-06-26 23:59:59"),
       periodic => 1,
       text  => 'Mehringdamm (Kreuzberg) in Richtung Tempelhof, zwischen Kreuzbergstr. und Dudenstr. Veranstaltung (Seifenkistenrennen am 25. und 26 Juni 2013), Fahrtrichtung gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005931',
       data  => <<EOF,
userdel	1::temp 9248,9350 9225,9111 9224,9053 9225,9038 9227,8890 9229,8785
EOF
     },
     { from  => 1183280291, # 2007-07-01 10:58
       until => 1184536799, # 2007-07-15 23:59
       text  => 'Stubenrauchstr. (Treptow ) in Richtung Segelfliegerdamm, ab Akeleiweg Baustelle, Fahrtrichtung gesperrt und Akeleiweg gesperrt (bis Mitte Juli 2007)',
       type  => 'handicap',
       source_id => 'IM_005905',
       data  => <<EOF,
userdel	q4::inwork; 17388,3576 17491,3627 17522,3653 17593,3748
EOF
     },
     { from  => 1184191200, # 2007-07-12 00:00
       until => 1184536800, # 2007-07-16 00:00
       text  => 'B 156 Tschernitz-Spremberg zw. Abzw. Friedrichshain und Abzw. Reuthen Deckeneinbau Vollsperrung 13.07.2007-15.07.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 89821,-90648 91975,-90138
EOF
     },
     { from  => 1183672800, # 2007-07-06 00:00
       until => 1183932000, # 2007-07-09 00:00
       text  => 'L 030 Puschkinstr. OL K�nigs Wusterhausen Open-Air Konzert Vollsperrung 07.07.2007-08.07.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 25859,-11559 26177,-11648
EOF
     },
     { from  => 1184450400, # 2007-07-15 00:00
       until => 1188597600, # 2007-09-01 00:00
       text  => 'L 339 Neuer H�nower Weg Bahn�bergang in der OD Birkenstein Erneuerung Bahn�bergang halbseitig gesperrt; Einbahnstra�e 16.07.2007-31.08.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 27067,12608 27094,12535 27101,12515 27117,12466
EOF
     },
     { from  => 1183412527, # 2007-07-02 23:42
       until => 1186773173, # 2007-08-15 23:59 1187215199
       text  => 'Treptower Str. (Treptow) in beiden Richtungen zwischen Kiefholzstr. und Harzer Str. Baustelle Stra�e vollst�ndig gesperrt (bis Mitte 08/2007)',
       type  => 'handicap',
       source_id => 'IM_004418',
       data  => <<EOF,
userdel	2::inwork 13860,8599 14015,8798 14151,8967
EOF
     },
     { from  => 1183412580, # 2007-07-02 23:43
       until => 1185833983, # 2007-08-31 23:59 1188597599
       text  => 'Pankower Allee (Reinickendorf) in Richtung Markstr., zwischen Reginhardstr. und Residenzstr. Baustelle, Fahrtrichtung gesperrt (bis 08.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004242',
       data  => <<EOF,
userdel	1::inwork 8211,17585 8095,17574 7998,17564 7915,17557 7841,17551 7828,17550 7675,17538 7579,17532
EOF
     },
     { from  => undef, # 
       until => 1183798449, # undef
       text  => 'Hauptstr. (Wilhelmsruh) in beiden Richtungen zwischen Schillerstr. und Edelwei�str. Baustelle, Stra�e vollst�ndig gesperrt (bis auf weiteres)',
       type  => 'handicap',
       source_id => 'IM_005953',
       data  => <<EOF,
userdel	q4::inwork 7748,20040 7790,20132 7832,20219
EOF
     },
     { from  => 1184104800, # 2007-07-11 00:00
       until => 1188079200, # 2007-08-26 00:00
       text  => 'B 112 zw. Frankfurt (O) und Lebus Gr�ndungsarb. f�r Radwegbau Vollsperrung 12.07.2007-25.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 86392,-776 86307,581
EOF
     },
     { from  => 1184623200, # 2007-07-17 00:00
       until => 1185834152, # 2007-08-01 00:00 1185919200
       text  => 'L 063 Berliner Str., Finsterwalder Str. Bahn�bergang in der OD Lauchhammer Gleiserneuerung Vollsperrung 18.07.2007-31.07.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 35482,-103562 35379,-103141 35072,-102150
EOF
     },
     { from  => 1184018400, # 2007-07-10 00:00
       until => 1185746400, # 2007-07-30 00:00
       text  => 'L 075 Knoten mit B 96a bei Wa�mannsdorf Umbau Knotenpunkt Vollsperrung 11.07.2007-29.07.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 14993,-4196 15053,-4328
EOF
     },
     { from  => 1183327200, # 2007-07-02 00:00
       until => 1184006715, # 2007-07-13 00:00 1184277600
       text  => 'B 002 Raumerstr. OD Eberswalde, zw. Brunnenstr. und R.-Breitscheid-Str. Stra�enbauarbeiten Vollsperrung 03.07.2007-12.07.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 37245,47419 37153,47300
EOF
     },
     { from  => 1183495734, # 2007-07-03 22:48
       until => Time::Local::timelocal(reverse(2008-1900,1-1,1,0,0,0)),
       text  => 'Stra�en- und Leitungsbauarbeiten in der Pistoriusstra�e zwischen Hamburger Platz (Gustav-Adolf-Stra�e) und Am Steinberg, Einbahnstra�e Richtung Hamburger Platz (09.07.2007 bis Anfang 2008) ', # VMZ meint: NEW	Pistoriusstr. (Wei�ensee) RIchtung Berliner Str. zwischen Gustav-Adolf-Str. und Berliner Str. Baustelle, Fahrtrichtung gesperrt (bis Anfang 2008) (08:30) 	IM_006024
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-pankow/presse/archiv/20070703.1505.81257.html',
       data  => <<EOF,
userdel	1::inwork 12667,16699 12602,16727 12472,16783 12257,16876 12230,16915
EOF
     },
     { from  => 1183704492, # 2007-07-06 08:48
       until => 1183798472, # 2007-07-08 00:00 1183845600
       text  => 'Str. des 17. Juni und Ebertstr. (Tiergarten) in beiden Richtungen zwischen Y.-Rabin-Str. und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (bis 07.07.2007 morgens)',
       type  => 'gesperrt',
       source_id => 'IM_006009',
       data  => <<EOF,
userdel	2::temp 8538,12245 8303,12216 8214,12205 8089,12190
EOF
     },
     { from  => 1183798422, # 2007-07-07 10:53
       until => 1183932000, # 2007-07-09 00:00
       text  => 'Finsterwalder Str. (Reinickendorf) in beiden Richtungen zwischen Eichhorster Weg und Bruchst�ckgraben Veranstaltung, Stra�e vollst�ndig gesperrt (bis 08.07.2007 abends)',
       type  => 'gesperrt',
       source_id => 'IM_006015',
       data  => <<EOF,
userdel	2::temp 6434,22244 6484,22098 6480,22053 6473,21969 6436,21897 6373,21810 6320,21777 6269,21748 6093,21648 5923,21522
EOF
     },
     { from  => 1184018400, # 2007-07-10 00:00
       until => 1188079200, # 2007-08-26 00:00
       text  => 'L 020 Velten-Borgsdorf zw. OL Pinnow, Havelweg und Berliner Ch., Borgsdorf Grundhafter Stra�enbau Vollsperrung 11.07.2007-25.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -736,32837 -579,33145 -529,33240 -503,33339 -454,33489 -440,33503 -406,33512
EOF
     },
     { from  => 1183845600, # 2007-07-08 00:00
       until => 1194044400, # 2007-11-03 00:00
       text  => 'L 171 Karl-Marx-Str. OD Hohen Neuendorf, Krz. K.-Tucholsky-Str. grundh.Stra�enbau, Kreisverk. Vollsperrung 09.07.2007-02.11.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 1366,29416 1492,29386 1596,29362
EOF
     },
     { from  => 1186264800, # 2007-08-05 00:00
       until => 1187388000, # 2007-08-18 00:00
       text  => 'L 033 zw. Kreuz. H�now und Krz. Landsberger Ch./ Stendaler Str. Deckeninstandsetzung Vollsperrung 06.08.2007-17.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 25506,15585 25955,15531 26071,15470
EOF
     },
     { from  => 1184709600, # 2007-07-18 00:00
       until => 1184882400, # 2007-07-20 00:00
       text  => 'B 246 Ernst-Th�lmann-Str. OL Belzig, H�he Gymnasium Kanalarbeiten Vollsperrung 19.07.2007-19.07.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -44441,-30214 -44189,-30306
EOF
     },
     { from  => 1184222221, # 2007-07-12 08:37
       until => 1184299200, # 2007-07-13 06:00
       text  => 'Stra�e des 17. Juni (Tiergarten) Zwischen Yitzhak-Rabin-Str. und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (bis 13.07.07 6:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006033',
       data  => <<EOF,
userdel	2::temp 8538,12245 8303,12216 8214,12205 8089,12190
EOF
     },
     { from  => undef, # 
       until => 1184610940, #
       text  => 'Str. nach Fichtenau (K�penick) in beiden Richtungen bei S Rahnsdorf geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006066',
       data  => <<EOF,
userdel	2::inwork 30090,5436 30074,5402 30041,5329
EOF
     },
     { from  => 1184450400, # 2007-07-15 00:00
       until => 1184611295, # 2007-08-16 00:00 1187215200
       text  => 'B 002 Stettiner Str. OD Gartz, Knotenpunkt Stettiner-/Scheunenstra�e Ausbau Knotenpunkt Vollsperrung 16.07.2007-15.08.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 76243,92954 76075,90647
EOF
     },
     { from  => 1184450400, # 2007-07-15 00:00
       until => 1187647200, # 2007-08-21 00:00
       text  => 'L 023 Templin-Lychen von OL Densow bis OE Lychen Stra�enbauarbeiten Vollsperrung 16.07.2007-20.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 4239,85382 5194,83184
EOF
     },
     { from  => 1184450400, # 2007-07-15 00:00
       until => 1184790078, # 2007-07-21 00:00 1184968800
       text  => 'L 281 Neureetz-Altranft zw. Croustillier und Altreetz Deckeneinbau Vollsperrung 16.07.2007-20.07.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 59730,42362 58564,43539
EOF
     },
     { from  => 1184610917, # 2007-07-16 20:35
       until => 1191189599, # 2007-09-30 23:59
       text  => 'Simon-Bolivar-Str. (Hohensch�nhausen) in beiden Richtungen zwischen Konrad-Wolf-Str. und K�striner Str. Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 09.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006088',
       data  => <<EOF,
userdel	2::inwork 15774,14992 15856,14915 15941,14834 16035,14748
EOF
     },
     { from  => 1184450400, # 2007-07-15 00:00
       until => 1188079200, # 2007-08-26 00:00
       text  => 'B 002 Pommernstr., Stettiner Str. OD Gartz, Kno. Pommern-/Scheunenstr. u. Stettiner-/Scheu Ausbau Knotenpunkte Vollsperrung 16.07.2007-25.08.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 75502,90490 75956,90435
EOF
     },
     { from  => 1184450400, # 2007-07-15 00:00
       until => 1188597600, # 2007-09-01 00:00
       text  => 'L 338 R.-Luxemburg-Damm, Hauptstr. Bahn�bergang in der OL Neuenhagen Erneuerung Bahn�bergang halbseitig gesperrt; Einbahnstra�e 16.07.2007-31.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30795,13191 30815,13170 30910,13101 30982,12947
EOF
     },
     { from  => 1185055200, # 2007-07-22 00:00
       until => 1185228255, # 2007-08-04 00:00 1186178400
       text  => 'B 005 Kieler Str. OL Frankfurt (O), zw. Lebuser Ch. u. Goepelstr. Bergsicherungsarbeiten Vollsperrung 23.07.2007-03.08.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 87406,-3541 87292,-3434
EOF
     },
     { from  => 1184709600, # 2007-07-18 00:00
       until => 1186178400, # 2007-08-04 00:00
       text  => 'L 086 B 1 Gro� Kreutz-Schmergow OD Gro� Kreutz Kanal- und Stra�enbau Vollsperrung 19.07.2007-03.08.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -32153,-176 -32143,-211 -31993,-726 -31991,-1024
EOF
     },
     { from  => 1319138777, # 2011-10-20 21:26
       until => 1322599270, # 1322694000, # 2011-12-01 00:00
       text  => 'Rudower Chaussee (Treptow - K�penick) in beiden Richtungen H�he S-Bahn Br�cke Adlershof Baustelle, Stra�e vollst�ndig gesperrt, als Fu�g�nger kann man passieren',
       type  => 'handicap',
       source_id => 'INKO_096853',
       data  => <<EOF,
userdel	q4::inwork 19904,3464 19842,3419 19732,3340
EOF
     },
     { from  => 1185055200, # 2007-07-22 00:00
       until => 1198278000, # 2007-12-22 00:00
       text  => 'L 023 Herzfelde-Strausberg OD Hennickendorf, unterhalb Wachtelberg Instandsetzung St�tzwand Vollsperrung 23.07.2007-21.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 40565,12409 40362,12087
EOF
     },
     { from  => 1186264800, # 2007-08-05 00:00
       until => 1187388000, # 2007-08-18 00:00
       text  => 'L 033 zw. Kreuz. H�now und Krz. Landsberger Ch./ Stendaler Str. Deckeninstandsetzung Vollsperrung 06.08.2007-17.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 26333,15481 26175,15461 26071,15470 25955,15531 25506,15585 25342,15609 25007,15650 23893,15893
EOF
     },
     { from  => 1186092000, # 2007-08-03 00:00
       until => 1186437600, # 2007-08-07 00:00
       text  => 'L 040 Friedersdorf-Bindow Bahn�bergang in der OD Friedersdorf Gleisbauarbeiten Vollsperrung 04.08.2007-06.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 36895,-12039 36087,-12087 35496,-12280
EOF
     },
     { from  => 1184913352, # 2007-07-20 08:35
       until => 1185141600, # 2007-07-23 00:00
       text  => 'Stendaler Str. (Hellersdorf) Richtung S�den zwischen Janusz-Korczak-Str. und Hellersdorfer Str. Veranstaltung, Fahrtrichtung gesperrt (bis 22.07.07)',
       type  => 'gesperrt',
       source_id => 'IM_006131',
       data  => <<EOF,
userdel	1::temp 23960,15021 23993,14797
EOF
     },
     { from  => 1195686296, # 2007-11-22 00:04
       until => 1197759599, # 2007-12-15 23:59
       text  => 'Persiusstr. (Friedrichshain) in beiden Richtungen bei Markgrafendamm Baustelle, Stra�e vollst�ndig gesperrt, Radfahrer k�nnen aber passieren (bis Mitte 12.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006159',
       data  => <<EOF,
userdel	2::inwork 14641,10552 14490,10610
EOF
     },
     { from  => 1186696800, # 2007-08-10 00:00
       until => 1187042400, # 2007-08-14 00:00
       text  => 'K 6153 AS Friedersdorf-K�nigs Wusterhausen Bahn�bergang in der OL Kablow Gleisbauarbeiten Vollsperrung 11.08.2007-13.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 33120,-10967 32827,-11406 32725,-11546
EOF
     },
     { from  => 1189720800, # 2007-09-14 00:00
       until => 1189893600, # 2007-09-16 00:00
       text  => 'L 016 Perwenitz-B�rnicke OD Gr�nefeld 4. Brandenb.Dorf- u. Erntefest Vollsperrung 15.09.2007-15.09.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp -19882,29552 -19833,29510 -19798,29399
EOF
     },
     { from  => undef, # 
       until => 1185577821, #
       text  => 'Marktstr. (Lichtenberg) Richtung Karlshorster Str. zwischen Kynaststr. und Schreiberhauer Str. geplatzte Wasserleitung, Fahrtrichtung gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006151',
       data  => <<EOF,
userdel	1::inwork 14988,11130 15060,11006 15085,10956 15113,10916 15144,10905
EOF
     },
     { from  => 1185055200, # 2007-07-22 00:00
       until => 1189893600, # 2007-09-16 00:00
       text  => 'L 079 Ludwigsfelde-Potsdam zw. Kreisverkehr Nudow und Kreisverkehr Philippsthal Stra�enbau Vollsperrung 23.07.2007-15.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -5673,-8130 -5271,-8290 -4971,-8420 -4878,-8656
EOF
     },
     { from  => 1185660000, # 2007-07-29 00:00
       until => 1186178400, # 2007-08-04 00:00
       text  => 'L 621 D�llinger Str. OL Plessa Kanalarbeiten Vollsperrung 30.07.2007-03.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 27420,-104513 26667,-103869
EOF
     },
     { from  => 1185660000, # 2007-07-29 00:00
       until => 1186869600, # 2007-08-12 00:00
       text  => 'L 220 B167 AS Finowfurt-Joachimsthal zw. Eichhorst und Elsenau Bau Otterdurchlass Vollsperrung 30.07.2007-11.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 29812,57628 29056,57503
EOF
     },
     { from  => 1189797888, # 2007-09-14 21:24
       until => 1192310079, # 2007-10-15 23:59 1192485599
       text  => 'Dietzgenstr. (Pankow) stadteinw�rts zwischen Kastanienallee und Schillerstr. Baustelle, Fahrtrichtung gesperrt (bis Mitte 10.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006194',
       data  => <<EOF,
userdel	1::inwork 10138,20840 10119,20731 10115,20714 10063,20493
EOF
     },
     { from  => 1185833817, # 2007-07-31 00:16
       until => 1187989170, # 2007-08-31 23:59 1188597599
       text  => 'Drakestr. (Lichterfelde) in beiden Richtungen, zwischen Curtiusstr. und Unter den Eichen Fahrbahnuntersp�lung, Stra�e vollst�ndig gesperrt (bis Ende 08.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005823',
       data  => <<EOF,
userdel	2::inwork 3048,4305 3142,4173 3151,4160 3214,4066 3228,4046 3259,4002
EOF
     },
     { from  => 1185833871, # 2007-07-31 00:17
       until => 1186168147, # 2007-08-04 00:00 1186178400
       text  => 'Gr�nbergallee (Bohnsdorf) in beiden Richtungen zwischen Am Seegraben und Rosenweg Baustelle, Stra�e vollst�ndig gesperrt, Zufahrt zum Baumarkt von Bohnsdorf kommend frei (bis 03.08.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006195',
       data  => <<EOF,
userdel	2::inwork 20362,-511 20354,-569 20252,-571 20205,-548
EOF
     },
     { from  => 1188428040, # 2007-08-30 00:54
       until => 1188683999, # 2007-09-01 23:59
       text  => 'Joachimstaler Str. (Charlottenburg) Richtung Kantstr. zwischen Lietzenburger Str. und Kurf�rstendamm Baustelle Fahrtrichtung gesperrt (bis Anfang 09.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006190',
       data  => <<EOF,
userdel	1::inwork 5458,10443 5471,10719 5475,10808
EOF
     },
     { from  => 1185833959, # 2007-07-31 00:19
       until => 1186937842, # 2007-08-15 23:59 1187215199
       text  => 'Oranienburger Str. (Wittenau) stadtausw�rts zwischen L�barser Str. und Wittenauer Str. Baustelle, Fahrtrichtung gesperrt (bis Mitte 08.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006189',
       data  => <<EOF,
userdel	1::inwork 5320,21432 5311,21495 5210,21636 5136,21738
EOF
     },
     { from  => 1187647200, # 2007-08-21 00:00
       until => 1187820000, # 2007-08-23 00:00
       text  => 'L 017 Bahnbr�cke zw. Flatow und Staffelde Br�ckendemontage Vollsperrung 22.08.2007-22.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -20450,35368 -19737,35362 -19481,35481
EOF
     },
     { from  => 1186005600, # 2007-08-02 00:00
       until => 1186351200, # 2007-08-06 00:00
       text  => 'L 062 Bahn�bergang zw. Elsterwerda und Hohenleipisch Gleisbauarbeiten Vollsperrung 03.08.2007-05.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 22382,-102254 22501,-102573 22654,-103425
EOF
     },
     { from  => 1185828321, # 2007-07-30 22:45
       until => 1186168129, # 2007-08-10 00:00 1186696800
       text  => 'D�rpfeldstr. (Treptow) in Richtung Oberspreestr. zwischen Anna-Seghers-Str. und Gellertstr. Baustelle, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006201',
       data  => <<EOF,
userdel	2::inwork 20012,3532 20082,3578
EOF
     },
     { from  => 1193957531, # 2007-11-01 23:52
       until => 1194217200, # 2007-11-05 00:00
       text  => 'Ordensmeisterstr. (Tempelhof) in beiden Richtungen zwischen Wenckebachstr. und Tempelhofer Damm Fahrbahnabsenkung, Stra�e vollst�ndig gesperrt (bis 4.11.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006204',
       data  => <<EOF,
userdel	2::inwork 9368,5608 9147,5534
EOF
     },
     { from  => 1186869600, # 2007-08-12 00:00
       until => 1188856800, # 2007-09-04 00:00
       text  => 'B 102 Br�cken �ber den M�hlenrhin u. B�ttgraben n�rdl.Rhinow Br�ckenbauarbeiten Vollsperrung 13.08.2007-03.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -62502,27066 -62531,27427
EOF
     },
     { from  => 1185832800, # 2007-07-31 00:00
       until => 1186696800, # 2007-08-10 00:00
       text  => 'B 169 zw. Cottbus und Klein Gaglow Deckenerneuerung halbseitig gesperrt; Einbahnstra�e 01.08.2007-09.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 73977,-74037 73211,-74836 72657,-75488
EOF
     },
     { from  => 1186869600, # 2007-08-12 00:00
       until => 1187301600, # 2007-08-17 00:00
       text  => 'B 169 zw. Cottbus und Klein Gaglow Deckenerneuerung halbseitig gesperrt; Einbahnstra�e 13.08.2007-16.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 73977,-74037 73211,-74836 72657,-75488
EOF
     },
     { from  => 1186264800, # 2007-08-05 00:00
       until => 1188079200, # 2007-08-26 00:00
       text  => 'L 071 B 96 (Luckau-Baruth) - Dahme zw. Jetsch und Krossen Durchlassneubau Vollsperrung 06.08.2007-25.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 24639,-53978 25777,-53225 26126,-53177
EOF
     },
     { from  => 1186167826, # 2007-08-03 21:03
       until => 1186773145, # 2007-08-14 00:00 1187042400
       text  => 'Adlergestell (Gr�nau) stadteinw�rts zwischen Wassersportallee und Kablower Weg Baustelle, Fahrtrichtung gesperrt (bis 13.08.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006085',
       data  => <<EOF,
userdel	1::inwork 23206,206 22547,651 22351,862 22162,1067
EOF
     },
     { from  => undef, # 
       until => 1187560800, # 2007-08-20 00:00
       text  => 'N�ldnerstr.. (Lichtenberg) in Richtung Karlshorster Str. ab Schlichtalllee geplatzte Wasserleitung, Fahrtrichtung gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006236',
       data  => <<EOF,
userdel	1::inwork 16032,10842 15983,10836 15681,10801 15433,10765 15388,10758 15272,10790
EOF
     },
     { from  => 1186081587, # 2007-08-02 21:06
       until => 1186351200, # 2007-08-06 00:00
       text  => 'Str. der Pariser Kommune (Friedrichshain) in beiden Richtungen zwischen Weidenweg und Karl-Marx-Allee Veranstaltung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006219',
       data  => <<EOF,
userdel	2::temp 12891,12549 12869,12425
EOF
     },
     { from  => $isodate2epoch->("2013-06-01 10:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-06-02 21:00:00"),
       periodic => 1, # erster Termin im Sommer
       text  => 'Open Air Gallery am 2. Juni 2013 auf der Oberbaumbr�cke (10:00 - 21:00)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 13178,10623 13206,10651 13305,10789 13332,10832
EOF
     },
     { from  => 1186264800, # 2007-08-05 00:00
       until => 1196463600, # 2007-12-01 00:00
       text  => 'L 029 Oderberg-Liepe OD Oderberg Stra�enbauarbeiten Vollsperrung 06.08.2007-30.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 52671,51846 51496,51542
EOF
     },
     { from  => 1186264800, # 2007-08-05 00:00
       until => 1210370400, # 2008-05-10 00:00
       text  => 'L 171 Sch�nflie�er Str. Br�cke �ber die DB in der OD Hohen Neuendorf Br�ckenersatzneubau Vollsperrung 06.08.2007-09.05.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 2033,29198 2176,29143
EOF
     },
     { from  => 1186869600, # 2007-08-12 00:00
       until => 1187991012, # 2007-08-26 00:00 1188079200
       text  => 'B 102 Br�cken �ber den M�hlenrhin u. B�ttgraben n�rdl.Rhinow Br�ckenbauarbeiten Vollsperrung 13.08.2007-25.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -60904,38644 -60907,38811
EOF
     },
     { from  => 1188246966, # 
       until => 1188246970, # laut Cord nur bis 2007-08-17
       text  => 'der Fu�weg von der Buchberger Str. zum S-Bahnhof N�ldnerplatz ist z.Zt. voll gesperrt (Bauzaun)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 15805,10949 15752,11115 15708,11193 15730,11279
EOF
     },
     { from  => 1248386400, # 2009-07-24 00:00 PERIODISCH!
       until => 1249250399, # 2009-08-02 23:59
       text  => 'Berliner Gauklerfest vom 24. Juli 2009 bis 2. August 2009, einige Stra�en am Opernpalais sind vollst�ndig gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 9890,12161 9875,12257 9869,12297 9795,12293 9780,12401
userdel	2::temp 9869,12297 9852,12409
userdel	2::temp 9943,12364 9961,12273 9972,12184
userdel	2::temp 9934,12420 9943,12364
EOF
     },
     { from  => 1186524000, # 2007-08-08 00:00
       until => 1190239200, # 2007-09-20 00:00
       text  => 'B 246 N�chst Neuendorfer Chaussee OL Zossen, zw. Bahnhofstr. und OA Kanalarbeiten halbseitig gesperrt; Einbahnstra�e 09.08.2007-19.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 13412,-20513 13526,-20548
EOF
     },
     { from  => 1186610400, # 2007-08-09 00:00
       until => 1186869600, # 2007-08-12 00:00
       text  => 'L 060 Friedrich-List-Str. OD Falkenberg, zw. H.-Zille-Str. und Lindenstr. Einbau D�nnschichtbelag halbseitig gesperrt; Einbahnstra�e 10.08.2007-11.08.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 2001,-91126 1142,-91254
EOF
     },
     { from  => 1186437600, # 2007-08-07 00:00
       until => 1186696800, # 2007-08-10 00:00
       text  => 'L 603 Tr�bitz-Drasdo zw. Drasdo und Schilda Einbau D�nnschichtbelag Vollsperrung 08.08.2007-09.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 11403,-88614 10459,-88231 9578,-87785
EOF
     },
     { from  => 1188165600, # 2007-08-27 00:00
       until => 1188597600, # 2007-09-01 00:00
       text  => 'L 052 Ogrosen-Calau Bahn�bergang in der OD Calau Gleisbauarbeiten Vollsperrung 28.08.2007-31.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 51046,-73683 51081,-73709 51147,-73755
EOF
     },
     { from  => 1186869600, # 2007-08-12 00:00
       until => 1188338400, # 2007-08-29 00:00
       text  => 'B 246 Bahn�bergang Wendisch Rietz Siedlung, OT Neue M�hle Gleiserneuerung Vollsperrung 13.08.2007-28.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 52964,-21786 52927,-21822
EOF
     },
     { from  => 1187301600, # 2007-08-17 00:00
       until => 1187647200, # 2007-08-21 00:00
       text  => 'L 040 Friedersdorf-Bindow Bahn�bergang in der OD Friedersdorf Gleisbauarbeiten Vollsperrung 18.08.2007-20.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 36895,-12039 36087,-12087 35496,-12280
EOF
     },
     { from  => 1190757600, # 2007-09-26 00:00
       until => 1196463600, # 2007-12-01 00:00
       text  => 'B 167 Lebus-Seelow OD Dolgelin Kanal-,Stra�en- u. Radwegbau Vollsperrung 27.09.2007-30.11.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 78240,11748 78637,11458 78805,11331
EOF
     },
     { from  => 1186610400, # 2007-08-09 00:00
       until => 1186956000, # 2007-08-13 00:00
       text  => 'B 169 zw. Cottbus und Klein Gaglow Deckenerneuerung Vollsperrung 10.08.2007-12.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 72657,-75488 73211,-74836 73977,-74037
EOF
     },
     { from  => 1186819867, # 2007-08-11 10:11
       until => 1186898400, # 2007-08-12 08:00
       text  => 'Stra�e des 17. Juni (Mitte) Zwischen Gro�er Stern und Yitzhak-Rabin-Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 12.08. ca. 8 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006277',
       data  => <<EOF,
userdel	2::temp 8055,12186 7816,12150 7383,12095 6828,12031
EOF
     },
     { from  => 1194897338, # 2007-11-12 20:55
       until => 1195686392, # 2007-11-30 23:59 1196463599
       text  => 'Gitschiner Str. (Kreuzberg) in Richtung Kottbusser Tor zwischen Lobeckstr. und Prinzenstr. wegen einer geplatzten Wasserleitung gesperrt, Radfahrer k�nnen auf dem Gehweg passieren (bis Ende 11.2007)',
       type  => 'handicap',
       source_id => 'IM_006274',
       data  => <<EOF,
userdel	q4::inwork; 10363,10303 10605,10312
EOF
     },
     { from  => 1188059338, # 
       until => 1188059341, #
       text  => 'Alt-Moabit (Tiergarten) Kreuzung Thomasiusstra�e Fahrbahnabsenkung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006429',
       data  => <<EOF,
userdel	2::inwork 6860,13093 6757,13112 6661,13130
EOF
     },
     { from  => 1187989093, # 2007-08-24 22:58
       until => 1188136800, # 2007-08-26 16:00
       text  => 'Behrenstr. (Mitte) in beiden Richtungen, zwischen Ebertstr. und Cora-Berliner-Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 26.08.07 16 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006366',
       data  => <<EOF,
userdel	2::temp 8737,12098 8595,12066
EOF
     },
     { from  => 1187989206, # 2007-08-24 23:00
       until => 1191967870, # 2008-01-01 00:00 1199142000
       text  => 'Drakestr. (Lichterfelde) in beiden Richtungen bei der Bahnunterf�hrung geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt (bis Anfang 2008)',
       type  => 'handicap',
       source_id => 'IM_006754', # IM_005516
       data  => <<EOF,
userdel	q4::inwork 3048,4305 3142,4173 3151,4160 3214,4066 3228,4046
EOF
     },
     { from  => 1187989232, # 2007-08-24 23:00
       until => 1188230400, # 2007-08-27 18:00
       text  => 'Ebertstr. (Mitte) in beiden Richtungen zwischen Dorotheenstr. und Hanna-Ahrendt-Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 27.08.07 18 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006365',
       data  => <<EOF,
userdel	2::temp 8577,11896 8595,12066 8600,12165 8538,12245 8546,12279 8570,12302 8573,12325 8540,12420
EOF
     },
     { from  => 1188059356, # 
       until => 1188059359, #
       text  => 'Falkenhagener Str. (Spandau) zwischen Bismarckplatz und Elisabethstr. Fahrbahnabsenkung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006400',
       data  => <<EOF,
userdel	2::inwork -3507,15341 -3492,15331 -3349,15229 -3241,15118
EOF
     },
     { from  => 1189353413, # undef
       until => 1189353419, # undef
       text  => 'Oranienburger Str. (Reinickendorf) stadtausw�rts, zwischen L�barser Str. und WIttenauer Str. Baustelle, Fahrtrichtung gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006352',
       data  => <<EOF,
userdel	1::inwork 5320,21432 5311,21495 5210,21636 5136,21738
EOF
     },
     { from  => 1188240671, # 
       until => 1188240674, #
       text  => 'Str. des 17. Juni (Tiergarten) in beiden Richtungen zwischen Brandenburger Tor und Yitzhak-Rabin-Str. Veranstaltung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006364',
       data  => <<EOF,
userdel	2::temp 8610,12254 8538,12245 8303,12216 8214,12205 8089,12190 8055,12186
EOF
     },
     { from  => 1188684000, # 2007-09-02 00:00
       until => 1198278000, # 2007-12-22 00:00
       text  => 'B 096 Br�cke �ber den Seichgraben zw. Z�tzen u. Gol�en Br�ckenbauarbeiten Vollsperrung 03.09.2007-21.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 27428,-49936 26648,-49177
EOF
     },
     { from  => 1187474400, # 2007-08-19 00:00
       until => 1188252000, # 2007-08-28 00:00
       text  => 'B 112 Beeskower Str. OL Eisenh�ttenstadt, zw. K.-Marx-Str. u. Fr.-Heckert-Str. Stadtfest Vollsperrung 20.08.2007-27.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 94796,-26727 95218,-26861
EOF
     },
     { from  => 1188165600, # 2007-08-27 00:00
       until => 1189893600, # 2007-09-16 00:00
       text  => 'B 112 Eisenh�ttenstadt-Frankfurt (O) zw. G�ldendorf und Frankfurt (O) Deckenerneuerung Richtungsverkehr 28.08.2007-15.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 87207,-9278 86762,-8601
EOF
     },
     { from  => 1188079200, # 2007-08-26 00:00
       until => 1191189600, # 2007-10-01 00:00
       text  => 'B 122 zw. Abzw. Klausheide und Zippelsf�rde Deckenerneuerung Vollsperrung 27.08.2007-30.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -25490,64009 -26733,61993
EOF
     },
     { from  => 1189288800, # 2007-09-09 00:00
       until => 1190068315, # 2008-01-01 00:00 1199142000
       text  => 'B 168 zw. Friedland und Beeskow Stra�enbauarbeiten Vollsperrung 10.09.2007-31.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 69461,-27572 69234,-26113 69227,-25669
EOF
     },
     { from  => 1187560800, # 2007-08-20 00:00
       until => 1190325600, # 2007-09-21 00:00
       text  => 'K 6402 Ernst-Th�lmann-Str. OD Dolgelin, Krz. Hauptstr. Kanal-,Stra�en- u. Radwegbau Vollsperrung 21.08.2007-20.09.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 78637,11458
EOF
     },
     { from  => 1187474400, # 2007-08-19 00:00
       until => 1189807200, # 2007-09-15 00:00
       text  => 'K 6747 Alt Stahnsdorf - L 23, AS Storkow zw. Neu Stahnsdorf und Alt Stahnsdorf Stra�enbauarbeiten Vollsperrung 20.08.2007-14.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 44592,-9998 44336,-9931 44273,-10358 43912,-10589 43744,-11591 43467,-12187 43278,-12804
EOF
     },
     { from  => 1188079200, # 2007-08-26 00:00
       until => 1198278000, # 2007-12-22 00:00
       text  => 'K 7302 zwischen Dobberzin und Stolpe Stra�enneubau Vollsperrung 27.08.2007-21.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 56852,65453 56837,65747 56479,66257
EOF
     },
     { from  => 1187042400, # 2007-08-14 00:00
       until => 1187992800, # 2007-08-25 00:00
       text  => 'L 030 Ethel-und-Julius-Rosenberg-Str. OD Woltersdorf, Kno. A.-Bebel-Str. Stra�enbau, Entw�sserung Vollsperrung 15.08.2007-24.08.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 34511,4787 34535,5319
EOF
     },
     { from  => 1187647200, # 2007-08-21 00:00
       until => 1189288800, # 2007-09-09 00:00
       text  => 'L 070 Wernzhain-Trebbus zw. Hauptstr. in OL Werenzhain und OE Arenzhain Deckenerneuerung Vollsperrung 22.08.2007-08.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 19820,-81831 20862,-83214
EOF
     },
     { from  => 1184623200, # 2007-07-17 00:00
       until => 1192485600, # 2007-10-16 00:00
       text  => 'L 073 Beelitzer Str. OD Luckenwalde, zw. B101 und Neue Beelitzer Str. Stra�enausbau Vollsperrung 18.07.2007-15.10.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -4299,-35198 -4725,-34957
EOF
     },
     { from  => 1188424800, # 2007-08-30 00:00
       until => 1188770400, # 2007-09-03 00:00
       text  => 'L 073 Luckenwalde-St�lpe OD J�nickendorf 7. Kreiserntefest Vollsperrung 31.08.2007-02.09.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -521,-39003 -757,-38862
EOF
     },
     { from  => 1188079200, # 2007-08-26 00:00
       until => 1191708000, # 2007-10-07 00:00
       text  => 'L 172 Hennigsdorf-Velten zw. Kreisverkehr Hennigsdorf und Abzw. AS Hennigsdorf grundhafter Stra�enbau Vollsperrung 27.08.2007-06.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -3470,27651 -3571,28529
EOF
     },
     { from  => 1187042400, # 2007-08-14 00:00
       until => 1195308726, # 2007-12-01 00:00 1196463600
       text  => 'L 213 B167 Liebenwalde-Nassenheide zw. B167 �ber Neuholland nach Freienhagen Deckenerneuerung Vollsperrung 15.08.2007-30.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 4412,49281 4701,49782 4701,49975 4646,50318 4690,50532 4693,50925
EOF
     },
     { from  => 1187906400, # 2007-08-24 00:00
       until => 1188165600, # 2007-08-27 00:00
       text  => 'L 238 Eberswalde-Joachimsthal Br�cke der A 11 zw. Lichterfelde u. Altenhof Br�ckenabbruch Vollsperrung 25.08.2007-26.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 31065,54239 30773,54731
EOF
     },
     { from  => 1188079200, # 2007-08-26 00:00
       until => 1189714708, # 2007-12-16 00:00
       text  => 'L 381 zw. Lossow und Frankfurt (O) Fahrbahninstandsetzung Vollsperrung 27.08.2007-15.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 89183,-10469 89181,-9996 89241,-9948 89290,-9875 89344,-9868 89408,-9920 89478,-9917
EOF
     },
     { from  => 1188059206, # 2007-08-25 18:26
       until => 1188165599, # 2007-08-26 23:59
       text  => 'Edisonstr. (K�penick) in Richtung Lichtenberg zwischen Br�ckenstr. und Wilhelminenhofstr. Baustelle, Fahrtrichtung gesperrt (bis 26.08. ca. 24 Uhr)',
       type  => 'handicap',
       source_id => 'IM_006436',
       data  => <<EOF,
userdel	q4::inwork; 17900,6072 17930,6175 17952,6246 17992,6436
EOF
     },
     { from  => 1188059298, # 2007-08-25 18:28
       until => 1188183600, # 2007-08-27 05:00
       text  => 'Siegfriedstr. (Lichtenberg) in beiden Richtungen vor Kreuzung Landsberger Allee Bauarbeiten, Stra�e vollst�ndig gesperrt (bis 27.8. 5 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006391',
       data  => <<EOF,
userdel	2::inwork 16843,14420 16864,14226 16881,14063
EOF
     },
     { from  => 1188424800, # 2007-08-30 00:00
       until => 1189807200, # 2007-09-15 00:00
       text  => 'K 6907 BAB A10, AS-Ferch bis Ferch Bahn�bergang am Bhf Lienewitz Gleisbau am Bahn�bergang Vollsperrung 31.08.2007-14.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -18640,-11826 -19043,-11944 -19150,-11976
EOF
     },
     { from  => 1188588424, # 2007-08-31 21:27
       until => 1193871599, # 2007-10-31 23:59
       text  => 'Askanierring (Spandau) in Richtung Falkenhagener Tor, zwischen Fehrbelliner Tor und Eckschanze Baustelle, Einbahnstra�enregelung das Befahren ist nur in s�dliche Richtung m�glich.(bis Ende 10/2007) ',
       type  => 'gesperrt',
       source_id => 'IM_002956',
       data  => <<EOF,
userdel	1::inwork -3942,15926 -3896,15999 -3828,16118 -3735,16205 -3631,16224
EOF
     },
     { from  => 1188588635, # 2007-08-31 21:30
       until => 1188770399, # 2007-09-02 23:59
       text  => 'Alt-Blankenburg und Priesterstege Richtung Krugstege Veranstaltung, Stra�e vollst�ndig gesperrt (bis 02.09. nachts)',
       type  => 'gesperrt',
       source_id => 'IM_006462',
       data  => <<EOF,
userdel	2::temp 13909,20928 13562,20913 13576,20849
EOF
     },
     { from  => undef, # 
       until => 1188741600, # 2007-09-02 16:00
       text  => 'Kurf�rstendamm (Charlottenburg) in beiden Richtungen zwischen Knesebeckstr. und Breitscheidplatz Veranstaltung, Stra�e vollst�ndig gesperrt (bis ca. 16 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006499',
       data  => <<EOF,
userdel	2::temp 5782,10884 5725,10892 5656,10876 5475,10808 5351,10760 5229,10716 5076,10658 4847,10589
EOF
     },
     { from  => 1189288800, # 2007-09-09 00:00
       until => 1190412000, # 2007-09-22 00:00
       text  => 'L 074 Poststra�e OD Teupitz, Poststr. Tiefbauarbeiten Vollsperrung 10.09.2007-21.09.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 25412,-29762 25240,-29746
EOF
     },
     { from  => 1189288800, # 2007-09-09 00:00
       until => 1217541600, # 2008-08-01 00:00
       text  => 'K 7305 Bahnunterf�hrung bis Welsow Br�ckenbau u. Stra�enneubau Vollsperrung 10.09.2007-31.07.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 48437,74675 49075,74662 49734,74527
EOF
     },
     { from  => 1189543409, # 2007-09-11 22:43
       until => 1189633841, # 2007-09-15 00:00 1189807200
       text  => 'Alexanderstr. (Mitte) Richtung Jannowitzbr�cke, zwischen Grunerstr. und Holzmarktstr. Baustelle, Fahrtrichtung gesperrt (bis 14.09.07)',
       type  => 'gesperrt',
       source_id => 'IM_006622',
       data  => <<EOF,
userdel	1::inwork 11134,12793 11207,12706 11252,12644 11329,12497
EOF
     },
     { from  => 1189893600, # 2007-09-16 00:00
       until => 1190584800, # 2007-09-24 00:00
       text  => 'B 087 Ortsumgehung M�llrose - Ragow Ortsausg.M�llrose bis hinter Ragow Stra�enbauarbeiten Vollsperrung 17.09.2007-23.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 74920,-18929 76631,-18359
userdel	2::inwork 71815,-22343 72808,-20985 73222,-20567 74707,-18991
EOF
     },
     { from  => 1189714564, # 2007-09-16 00:00 FALSCH!
       until => 1189714567, # 2007-09-24 00:00 FALSCH!
       text  => 'FALSCH! B 087 Ortsumgehung M�llrose - Ragow Ortsausg.M�llrose bis hinter Ragow Stra�enbauarbeiten Vollsperrung 17.09.2007-23.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 33060,-85292 33021,-85257
EOF
     },
     { from  => 1189461600, # 2007-09-11 00:00
       until => 1209592800, # 2008-05-01 00:00
       text  => 'K 6422 Eggersdorfer Str. Petershagen, zw.Trift- u. Lessingstr.,Bahn Stra�enbau Vollsperrung 12.09.2007-30.04.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 36666,14172 36677,14087 36654,13977 35900,13643
EOF
     },
     { from  => 1189461600, # 2007-09-11 00:00
       until => 1190068132, # 2008-05-01 00:00 1209592800 WRONG COORDS!
       text  => 'K 6422 Eggersdorfer Str. Petershagen, zw.Trift- u. Lessingstr.,BahnLandsbg.Str. Stra�enbau Vollsperrung 12.09.2007-30.04.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -579,33145 -529,33240 -503,33339 -454,33489 -440,33503 -406,33512 -377,33538 -316,33596 81,33971
EOF
     },
     { from  => 1208210400, # 2008-04-15 00:00
       until => 1209247200, # 2008-04-27 00:00
       text  => 'L 026 Landesgrenze - AS Prenzlau-Ost (BAB A11) zw. OA Wollschow u. OE Br�ssow Stra�en-/Radwegebau Vollsperrung 16.04.2008-26.04.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 61502,112547 60639,112544 58357,111700 57995,111657
EOF
     },
     { from  => 1174172400, # 2007-03-18 00:00
       until => 1190664710, # 2007-10-06 00:00 1191621600
       text  => 'L 191 L172 Abzw. Germendorf-Sommerfeld OD Sommerfeld grundhafter Ausbau Vollsperrung 19.03.2007-05.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -15397,43682 -14950,43712
EOF
     },
     { from  => 1189288800, # 2007-09-09 00:00
       until => 1194562800, # 2007-11-09 00:00
       text  => 'L 214 OD Blumenow OD Blumenow Stra�enbau+Kanalisationsbau Vollsperrung 10.09.2007-08.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -1406,77488 -1232,77061 -1123,76677
EOF
     },
     { from  => 1188424800, # 2007-08-30 00:00
       until => 1198278000, # 2007-12-22 00:00
       text  => 'B2 zw. Spechthausen u.Eberswalde Br�cke Leuenberger Wiesengraben Br�ckenneubau Vollsperrung, Radfahrer k�nnen wahrscheinlich passieren 31.08.2007-21.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 36000,45950 35743,45915
EOF
     },
     { from  => 1188684000, # 2007-09-02 00:00
       until => 1209592800, # 2008-05-01 00:00
       text  => 'L 035 Dr. W.-K�lz-Str. OL F�.-walde zw. Sembritzki- u. Eisenbahnstr. Abwasserkanalbau Vollsperrung 03.09.2007-30.04.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 55447,-4585 55447,-4432 55447,-4247
EOF
     },
     { from  => 1189548000, # 2007-09-12 00:00
       until => 1190066400, # 2007-09-18 00:00
       text  => 'B 107 Jeserig-Wiesenburg Bahn�bergang zw. Kreisverkehr u. Wiesenburg Gleisbauarbeiten Vollsperrung 13.09.2007-17.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -54890,-35286 -54891,-35326 -54881,-35591
EOF
     },
     { from  => 1189288800, # 2007-09-09 00:00
       until => 1218265600, # 1603753200 FALSCH! 2020-10-27 00:00
       text  => 'B 096 Bahnhofstra�e OD Finsterwalde, Kreuzung mit Berliner Str. (L601) Stra�enbau Sperrung B96 Ri. Luckau 10.09.2007-26.10.2020 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 33060,-85292 33021,-85257
EOF
     },
     { from  => 1189842208, # 2007-09-15 09:43
       until => 1189980000, # 2007-09-17 00:00
       text  => 'Potsdamer Str. (Tiergarten) zwischen Potsdamer Platz und Eichhornstr. Veranstaltung, Potsdamer Str. und umliegende Nebenstra�en vollst�ndig gesperrt (bis 16.09.2007 ca. 24 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006666',
       data  => <<EOF,
userdel	2::temp 8374,11479 8479,11493 8542,11502
userdel	2::temp 8226,11458 8301,11469 8358,11477
EOF
     },
     { from  => 1189842239, # 2007-09-15 09:43
       until => 1189979999, # 2007-09-16 23:59
       text  => 'Sonnenallee (Neuk�lln) beide Richtungen, zwischen Pannierstr. und Wildenbruchstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bs 16.09.2007 24 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006665',
       data  => <<EOF,
userdel	2::temp 12925,8494 12772,8612 12742,8635 12630,8722 12483,8834 12438,8859 12320,8927 12242,8972
EOF
     },
     { from  => 1190067574, # 2007-09-18 00:19
       until => 1198881671, # 2007-12-31 23:59 1199141999
       text  => 'Sterndamm (Treptow) Richtung Michael-Br�ckner-Str. zwischen Lindhorstweg und Winckelmannstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 2007)',
       type  => 'gesperrt',
       source_id => 'IM_006663',
       data  => <<EOF,
userdel	1::inwork 17053,3971 17108,4049 17244,4242 17261,4267 17290,4308 17387,4446 17428,4503
EOF
     },
     { from  => 1190067732, # 2007-09-18 00:22
       until => 1190498400, # 2007-09-23 00:00
       text  => 'Ostendstr. (Niedersch�neweide) Richtung An der Wuhlheide zwischen Slabystr. und An der Wuhlheide Baustelle, Fahrtrichtung gesperrt (bis 22.09.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006673',
       data  => <<EOF,
userdel	1::inwork 19273,5866 19388,5883 19403,5885 19650,5920 19681,5924 19958,5950
EOF
     },
     { from  => 1187992800, # 2007-08-25 00:00
       until => 1192658400, # 2007-10-18 00:00
       text  => 'L 020 Velten-Borgsdorf zw. OL Pinnow, Havelweg und Berliner Ch., Borgsdorf Grundhafter Stra�enbau Vollsperrung 26.08.2007-17.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -579,33145 -529,33240 -503,33339 -454,33489 -440,33503 -406,33512
EOF
     },
     { from  => 1231707233, # 2009-01-11 21:53
       until => Time::Local::timelocal(reverse(2009-1900,6-1,15,0,0,0)), # 1243807199 2009-05-31 23:59
       text  => 'Glinkastr. (Mitte) in beiden Richtungen zwischen J�gerstr. und Taubenstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Mitte 06.2009)',
       type  => 'handicap',
       source_id => 'IM_009496',
       data  => <<EOF,
#: last_checked: 2009-05-27
userdel	q4::inwork; 9201,11968 9208,11872
userdel	q4::inwork; 9208,11872 9218,11793
EOF
     },
     { from  => 1190237300, # 2007-09-19 23:28
       until => 1193090292, # 2007-10-29 23:59 1193698799
       text  => 'L�ckstra�e (Lichtenberg) Richtung Ostkreuz ab Weitlingstra�e Baustelle, Fahrtrichtung gesperrt (bis 29.10.)',
       type  => 'gesperrt',
       source_id => 'IM_006691',
       data  => <<EOF,
userdel	1::inwork 16468,10695 16313,10747 16300,10753 16153,10818 16085,10844 16032,10842
EOF
     },
     { from  => 1192399200, # 2007-10-15 00:00
       until => 1192658400, # 2007-10-18 00:00
       text  => 'B 101 Herzberg-J�terbog zw. Welsickendorf und Landesgrenze Deckeneinbau Vollsperrung 16.10.2007-17.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -5503,-62012 -6079,-56811
EOF
     },
     { from  => 1190498400, # 2007-09-23 00:00
       until => 1193871600, # 2007-11-01 00:00
       text  => 'L 073 Beelitzer Str. OL Luckenwalde, zw. Puschkinstr. u. Woltersdorfer Str. Stra�enausbau Vollsperrung 24.09.2007-31.10.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -4725,-34957 -5019,-34814
EOF
     },
     { from  => 1190498400, # 2007-09-23 00:00
       until => 1193871600, # 2007-11-01 00:00
       text  => 'L 080 Bahnhofstr. OL Luckenwalde, Einm�nd. Beelitzer Str. Stra�enausbau Vollsperrung 24.09.2007-31.10.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -4725,-34957 -4888,-34952
EOF
     },
     { from  => 1191708000, # 2007-10-07 00:00
       until => 1199142000, # 2008-01-01 00:00
       text  => 'K 6947 Wenzlow-Mahlenzien OD Wenzlow Stra�enbauarbeiten Vollsperrung 08.10.2007-31.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -53700,-13146 -53945,-12911 -54243,-12956
EOF
     },
     { from  => 1317333600, # 1191018682, # 2007-09-29 00:31
       until => 1317679200, # 1191520800, # 2007-10-04 20:00
       text  => 'Stra�e des 17. Juni, Y.-Rabin-Str. und Ebertstr. (Tiergarten) In beiden Richtungen zwischen Brandenburger Tor und Gro�er Stern Veranstaltung, Stra�e vollst�ndig gesperrt (Y.-Rabin-Str. zwischen Str. des 17. Juni und Scheidemannstr., Ebertstr. zwischen Behrenstr. und Dorotheenstr.) (1. bis 3. Oktober 2011)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8055,12186 8089,12190 8214,12205
userdel	2::temp 8214,12205 8303,12216 8538,12245
userdel	2::temp 8546,12279 8538,12245
userdel	2::temp 8600,12165 8538,12245
userdel	2::temp 8538,12245 8610,12254
userdel	2::temp 8546,12279 8570,12302 8573,12325 8540,12420
userdel	2::temp 6828,12031 7383,12095 7816,12150 8055,12186
userdel	2::temp 8600,12165 8595,12066
userdel	2::temp 8119,12414 8055,12186
EOF
     },
     { from  => 1191103200, # 2007-09-30 00:00
       until => 1196463600, # 2007-12-01 00:00
       text  => 'B 122 zw. Dierberg und Zippelsf�rde Deckenerneuerung Vollsperrung 01.10.2007-30.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -22589,66989 -24436,65301
EOF
     },
     { from  => 1190966681, # 2007-09-28 10:04
       until => 1191211200, # 2007-10-01 06:00
       text  => 'Scheidemannstr. (Mitte) in beiden Richtungen zw. Ebertstr. und Gro�e Querallee Marathon, Stra�e vollst�ndig gesperrt (bis 01.10.2007 - 6 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006771',
       data  => <<EOF,
userdel	2::temp 7875,12363 8017,12359 8070,12409 8119,12414 8354,12416 8400,12417 8540,12420
EOF
     },
     { from  => 1191269068, # 2007-10-01 22:04
       until => 1191621600, # 2007-10-06 00:00
       text  => 'Wartenberger Str. (Hohensch�nhausen) in beiden Richtungen zwischen Paul-Koenig-Str. und Arnimstr. Baustelle Stra�e tags�ber gesperrt (bis 05.10.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006787',
       data  => <<EOF,
userdel	2::inwork 17900,17068 17839,16987 17788,16916 17634,16681 17446,16393
EOF
     },
     { from  => 1186524000, # 2007-08-08 00:00
       until => 1195254000, # 2007-11-17 00:00
       text  => 'B 246 N�chst Neuendorfer Chaussee OL Zossen, zw. Bahnhofstr. und OA Kanalarbeiten halbseitig gesperrt; Einbahnstra�e 09.08.2007-16.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 13412,-20513 13526,-20548
EOF
     },
     { from  => 1191103200, # 2007-09-30 00:00
       until => 1191794400, # 2007-10-08 00:00
       text  => 'L 031 zw. Bernau, hinter Zuf. Toom Baumarkt und B� Blumberg Deckensanierung Vollsperrung 01.10.2007-07.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 24186,26271 24204,25870 24244,25405 24242,25066 24281,24622 24235,24035 24697,23369 24761,23151 24718,22731
EOF
     },
     { from  => 1191103200, # 2007-09-30 00:00
       until => 1198364400, # 2007-12-23 00:00
       text  => 'L 040 Zossener Damm OD Blankenfelde, zw. J�hnsdorfer Weg u. A.-D�rer-Str. Kanal- und Stra�enbau Vollsperrung 01.10.2007-22.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10115,-8276 11115,-8466
EOF
     },
     { from  => 1191708000, # 2007-10-07 00:00
       until => 1193608800, # 2007-10-28 23:00
       text  => 'L 073 Baruth-St�lpe zw. Paplitz und Lynow Deckeninstandsetzung Vollsperrung 08.10.2007-28.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10970,-39919 11561,-39875 11814,-39896 12751,-39434 13114,-39180 13618,-39476 13914,-39770 15361,-39713
EOF
     },
     { from  => 1193776679, # 2007-10-30 21:37
       until => 1196463599, # 2007-11-30 23:59
       text  => 'Simon-Bolivar-Str. (Hohensch�nhausen) in beiden Richtungen zwischen Konrad-Wolf-Str. und K�striner Str. Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 11.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006088',
       data  => <<EOF,
userdel	2::inwork 15774,14992 15856,14915 15941,14834 16035,14748
EOF
     },
     { from  => 1191532907, # 2007-10-04 23:21
       until => 1191707999, # 2007-10-06 23:59
       text  => 'Ullsteinstr. (Tempelhof) in beiden Richtungen zwischen Rathausstr. und Mariendorfer Damm Baustelle, Stra�e vollst�ndig gesperrt (bis 06.10.)',
       type  => 'gesperrt',
       source_id => 'IM_006795',
       data  => <<EOF,
userdel	2::inwork 9207,5185 8934,5095 8813,5004
EOF
     },
     { from  => 1192312800, # 2007-10-14 00:00
       until => 1192917600, # 2007-10-21 00:00
       text  => 'L 095 abschnittsweise zw. Belzig und G�rzke Stra�enbauarbeiten Vollsperrung 15.10.2007-20.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -50335,-28686 -51740,-27889 -52270,-27702 -52679,-27853 -53505,-27647
EOF
     },
     { from  => 1191362400, # 2007-10-03 00:00
       until => 1198191600, # 2007-12-21 00:00
       text  => 'L 141 Havelberger Str. OD Breddin Kanal- u. Stra�enbauarbeiten Vollsperrung 04.10.2007-20.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -70922,51604 -70980,51154 -71053,49770
EOF
     },
     { from  => 1191362400, # 2007-10-03 00:00
       until => 1198278000, # 2007-12-22 00:00
       text  => 'L 314 Zepernicker Chaussee OD Bernau grundhafter Stra�enbau Vollsperrung 04.10.2007-21.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 22178,30343 21872,30139 21561,30131 21117,29968
EOF
     },
     { from  => 1191362400, # 2007-10-03 00:00
       until => 1214863200, # 2008-07-01 00:00
       text  => 'L 315 Prenden-Klosterfelde OD Klosterfelde grundhafter Stra�enbau Vollsperrung 04.10.2007-30.06.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 14941,42957 15632,43100 15783,43227 16258,43457
EOF
     },
     { from  => 1194082880, # 2007-10-07 00:00 1191708000
       until => 1194082885, # 2007-11-18 00:00 1195340400
       text  => 'B 109 Zehdenick-Templin zw. Zehdenick und Hammelspring Stra�enbauarbeiten Vollsperrung 08.10.2007-17.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 8656,71489 7906,70007 7983,69794 7945,69489 7693,69244 7068,68100 6538,67236
EOF
     },
     { from  => 1191708000, # 2007-10-07 00:00
       until => 1194044400, # 2007-11-03 00:00
       text  => 'L 030 Altlandsberg-B158 Seefeld zw. Krummensee und Seefeld Neubau Radweg Vollsperrung 08.10.2007-02.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 29835,21516 29573,21750 29537,21850 28936,23307 28753,23756 28614,23943
EOF
     },
     { from  => 1191880800, # 2007-10-09 00:00
       until => 1193176800, # 2007-10-24 00:00
       text  => 'L 164 zw. Herzberg und Radensleben Stra�enbauarbeiten Vollsperrung 10.10.2007-23.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -20021,54750 -20798,54347 -21553,54152 -22376,53427 -23839,52751
EOF
     },
     { from  => 1231707121, # 2009-01-11 21:52
       until => 1233866355, # 2009-05-15 23:59 1242424799
       text  => 'Glinkastr. (Mitte) Richtung Leipziger Str. zwischen Mohrenstr. und Leipziger Str. Baustelle, Fahrtrichtung gesperrt (bis Mitte 05.2009)',
       type  => 'gesperrt',
       source_id => 'IM_006819',
       data  => <<EOF,
userdel	1::inwork 9220,11781 9234,11683 9268,11590
EOF
     },
     { from  => 1191967853, # 2007-10-10 00:10
       until => 1193482895, # 2007-10-31 23:59 1193871599
       text  => 'S�dostallee (K�nigsheide) Richtung Sterndamm zwischen Rixdorfer Str. und Sterndamm Baustelle, Fahrtrichtung gesperrt (bis Ende 10.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006820',
       data  => <<EOF,
userdel	1::inwork 16868,5938 16993,5841 17337,5574 17366,5551 17471,5469 17599,5371
EOF
     },
     { from  => 1191708000, # 2007-10-07 00:00
       until => 1197325825, # 2007-12-15 00:00 1197673200
       text  => 'L 238 AS Werbellin-Joachimsthal OD Altenhof Kanal- und Stra�enbau Vollsperrung 08.10.2007-14.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 30762,56847 30488,56704 30396,56665 30158,56695 30049,56674 30146,56367
EOF
     },
     { from  => 1192140000, # 2007-10-12 00:00
       until => 1192917600, # 2007-10-21 00:00
       text  => 'L 402 Schulzendorf-Dahlewitz zw. Abzw. Waltersdorf und Dahlewitz Fahrbahninstandsetzung Vollsperrung 13.10.2007-20.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 17910,-6981 17480,-7498 17278,-7925 16437,-8257
EOF
     },
     { from  => 1199434005, # 2008-01-04 09:06
       until => 1201820399, # 2008-01-31 23:59
       text  => 'Drakestr. (Lichterfelde) in beiden Richtungen bei der Bahnunterf�hrung geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt (bis 01/2008)',
       type  => 'gesperrt',
       source_id => 'IM_006754',
       data  => <<EOF,
userdel	2::inwork 3228,4046 3214,4066 3151,4160 3142,4173
EOF
     },
     { from  => 1192140000, # 2007-10-12 00:00
       until => 1192399200, # 2007-10-15 00:00
       text  => 'B 096 Br�cke zw. Gro�r�schen und Freienhufen Br�ckenabbruch Vollsperrung 13.10.2007-14.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 50891,-90838 51083,-90805 51535,-90752 52531,-90608 52580,-90602
EOF
     },
     { from  => 1192312800, # 2007-10-14 00:00
       until => 1193263200, # 2007-10-25 00:00
       text  => 'B 109 August-Bebel-Str. OD Templin, zw. Jahnstr. und Krz. Prenzlauer Allee Kanalarbeiten Vollsperrung 15.10.2007-24.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 16331,79764 16200,79437
EOF
     },
     { from  => 1192399200, # 2007-10-15 00:00
       until => 1198193318, # 2007-12-31 00:00 1199055600
       text  => 'L 030 B�rnicker Chaussee OD Bernau, zw. Gernotstr. und Eberswalder Str. grundhater Stra�enbau Vollsperrung 16.10.2007-30.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 23113,30450 23368,30409 23631,30262
EOF
     },
     { from  => 1192312800, # 2007-10-14 00:00
       until => 1193004000, # 2007-10-22 00:00
       text  => 'L 037 zw. OL Dubrow und OU M�llrose Stra�ensanierungsarbeiten Vollsperrung 15.10.2007-21.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 78364,-14355 78029,-13837 77866,-13279
EOF
     },
     { from  => 1192312800, # 2007-10-14 00:00
       until => 1192572000, # 2007-10-17 00:00
       text  => 'L 037 zw. Schernsdorf und M�llrose Stra�ensanierungsarbeiten Vollsperrung 15.10.2007-16.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 80307,-17691 80679,-17994 82000,-19505
EOF
     },
     { from  => 1192399200, # 2007-10-15 00:00
       until => 1194562800, # 2007-11-09 00:00
       text  => 'L 161 B 5 Bredow - Paaren Kreisverkehr westl. AS Falkensee in Ri. Paaren Straa�enbau, Umbau KVK Vollsperrung 16.10.2007-08.11.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -18577,24383 -19282,23081
EOF
     },
     { from  => 1192310001, # 2007-10-13 23:13
       until => 1192399200, # 2007-10-15 00:00
       text  => 'Pichelsdorfer Str. (Wilhelmstadt) in beiden Richtungen zwischen Wei�enburger Str. und Wilhelmstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 14.10.2007 nachts)',
       type  => 'gesperrt',
       source_id => 'IM_006856',
       data  => <<EOF,
userdel	2::temp -3650,12762 -3658,12854 -3667,12919 -3693,13012 -3783,13261 -3824,13350
EOF
     },
     { from  => 1192310039, # 2007-10-13 23:13
       until => 1192402800, # 2007-10-15 01:00
       text  => 'Residenzstr. (Reinikendorf) in beiden Richtungen zwischen Emmentaler Str. und Franz-Neumann-Platz Veranstaltung, Stra�e vollst�ndig gesperrt (bis 15.10. - 01 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006852',
       data  => <<EOF,
userdel	2::temp 7335,18257 7405,18047 7426,17981 7432,17964 7453,17899 7477,17832 7491,17793 7540,17675 7572,17558 7579,17532
EOF
     },
     { from  => 1192489272, # 2007-10-16 01:01
       until => 1192831200, # 2007-10-20 00:00
       text  => 'Erkstr. (Neuk�lln) in beiden Richtungen bei Karl-Marx-Str. Baustelle, Stra�e vollst�ndig gesperrt (bis 19.10.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006886',
       data  => <<EOF,
userdel	2::inwork 12598,8390 12771,8439
EOF
     },
     { from  => 1192489295, # 2007-10-16 01:01
       until => 1192744800, # 2007-10-19 00:00
       text  => 'Rauchstr. (Hakenfelde) in beiden Richtungen auf der Wasserstadtbr�cke Baustelle, Br�cke vollst�ndig gesperrt (bis 18.10.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006875',
       data  => <<EOF,
userdel	2::inwork -2149,16921 -1832,16858
EOF
     },
     { from  => 1192489357, # 2007-10-16 01:02
       until => 1192831200, # 2007-10-20 00:00
       text  => 'Suermondtstr. (Hohensch�nhausen) Richtung Hauptstr. zwischen Augustastr. und Sabinensteig Baustelle, Fahrtrichtung gesperrt (bis 19.10.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006873',
       data  => <<EOF,
userdel	1::inwork 15918,16383 16095,16331 16260,16282 16416,16236 16522,16206
EOF
     },
     { from  => 1182031200, # 2007-06-17 00:00
       until => 1193436000, # 2007-10-27 00:00
       text  => 'B 005 Treplin-Petershagen OD Petershagen, zw. KVK und Ortsausgang Kanal- und Stra�enbau Vollsperrung 18.06.2007-26.10.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 74197,607 74683,385
EOF
     },
     { from  => 1193090400, # 2007-10-23 00:00
       until => 1193608800, # 2007-10-28 23:00
       text  => 'B 096 Baruth-W�nsdorf Br�cke �ber das M�hlenflie� in der OD Neuhof Br�ckenbauarbeiten Vollsperrung 24.10.2007-28.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 16407,-29400 16434,-29189
EOF
     },
     { from  => 1194562800, # 2007-11-09 00:00
       until => 1194908400, # 2007-11-13 00:00
       text  => 'B 096 Hauptstr., Zossener Str. OD Baruth Einbau Deckschicht Vollsperrung 10.11.2007-12.11.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 18272,-39512 18433,-38781
EOF
     },
     { from  => 1192744800, # 2007-10-19 00:00
       until => 1192917600, # 2007-10-21 00:00
       text  => 'L 068 Drasdo-Oelsig zw. Oelsig und Abzw. D�brichen D�nnschichtbelag aufbringen Vollsperrung 20.10.2007-20.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10229,-82398 10315,-83509 10187,-84995
EOF
     },
     { from  => 1192658400, # 2007-10-18 00:00
       until => 1192831200, # 2007-10-20 00:00
       text  => 'L 072 Kolochau-Wildenau zw. Kolochau und Je�nick D�nnschichtbelag aufbringen Vollsperrung 19.10.2007-19.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 4483,-73538 5356,-74776 5988,-75608
EOF
     },
     { from  => 1192917600, # 2007-10-21 00:00
       until => 1220474145, # 2009-01-01 00:00 1230764400
       text  => 'L 232 M�llensee-Lichtenow OD Kagel Stra�enbauarbeiten Vollsperrung 22.10.2007-31.12.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 44634,7400 44774,6962 44914,6791 44933,6625 44835,6310
EOF
     },
     { from  => 1192917600, # 2007-10-21 00:00
       until => 1194130800, # 2007-11-04 00:00
       text  => 'B 112 Beeskower Str. OD Eisenh�ttenstadt, zw. F.-Heckert-Str. und K.-Marx-Str. Stra�enbauarbeiten Vollsperrung 22.10.2007-03.11.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 94796,-26727 95218,-26861
EOF
     },
     { from  => 1193526000, # 2007-10-28 01:00
       until => 1197673200, # 2007-12-15 00:00
       text  => 'L 037 Eisenh�ttenstadt-M�llrose Durchlass in der OD Pohlitz Ersatzneubau Vollsperrung 29.10.2007-14.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 90982,-23216 91107,-23410
EOF
     },
     { from  => 1193349600, # 2007-10-26 00:00
       until => 1193608800, # 2007-10-28 23:00
       text  => 'B 189 Pritzwalk-Wittstock OD Kemnitz, Dorfstr. Deckeneinbau Vollsperrung 27.10.2007-28.10.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -69972,80090 -70343,80256 -70779,80378 -71104,80353
EOF
     },
     { from  => 1193349600, # 2007-10-26 00:00
       until => 1193698800, # 2007-10-30 00:00
       text  => 'L 063 Finsterwalder Str. OD Lauchhammer, zw. F.-Mehring-Str. u. Grundhofstr. Stra�en-, Durchlassbau, KVP Vollsperrung 27.10.2007-29.10.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 35072,-102150 35032,-101702 34848,-101127
EOF
     },
     { from  => 1193090400, # 2007-10-23 00:00
       until => 1193871600, # 2007-11-01 00:00
       text  => 'L 243 Wegguner Str. OL Boitzenburg, zw. Puschkinstr. und Goethestr. Reparatur Rohrleitung Vollsperrung 24.10.2007-31.10.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 22507,95722 22471,95721 22233,95712
EOF
     },
     { from  => 1193526000, # 2007-10-28 01:00
       until => 1209496734, # 2008-07-01 00:00 1214863200
       text  => 'L 793 Alfred-K�hne-Str. Ludwigsfelde, Kreuzung Am Birkengrund/ Ludwigsfelder Str. Bau Kreisverkehr Vollsperrung 29.10.2007-30.06.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 3257,-10374 2629,-10301 2580,-11069
userdel	q4::inwork 1867,-10228 2629,-10301
EOF
     },
     { from  => 1193482575, # 2007-10-27 12:56
       until => 1194735600, # 2007-11-11 00:00
       text  => 'Lahnstr. (Neuk�lln) in beiden Richtungen zwischen Naumburger Str. und Karl-Marx-Str. Baustelle, Stra�e vollst�ndig gesperrt (bis 10.11.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006967',
       data  => <<EOF,
userdel	2::inwork 13085,6925 13278,6967
EOF
     },
     { from  => 1193482816, # 2007-10-27 13:00
       until => 1193957647, # 2007-11-10 00:00 1194649200
       text  => 'Mahlsdorfer Str. (Uhlenhorst) Richtung K�penick zwischen Eitelsdorfer Str. und Gehsener Str. Baustelle, Fahrtrichtung gesperrt (bis 09.11.2007)',
       type  => 'handicap',
       source_id => 'IM_006985',
       data  => <<EOF,
userdel	q4::inwork; 22960,7215 22869,7095 22785,6984 22758,6944 22748,6714 22745,6657 22724,6608
EOF
     },
     { from  => 1193482855, # 2007-10-27 13:00
       until => 1194735600, # 2007-11-11 00:00
       text  => 'Silbersteinstr. (Neuk�lln) in beiden Richtungen zwischen Walterstr. und Karl-Marx-Str. Baustelle, Stra�e vollst�ndig gesperrt (bis 10.11.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006966',
       data  => <<EOF,
userdel	2::inwork 12973,6902 13085,6925
EOF
     },
     { from  => 1194044400, # 2007-11-03 00:00
       until => 1195858800, # 2007-11-24 00:00
       text  => 'B 112 Beeskower Str. OD Eisenh�ttenstadt, zw. F.-Heckert-Str. und K.-Marx-Str. Stra�enbauarbeiten Vollsperrung 04.11.2007-23.11.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 94796,-26727 95218,-26861
EOF
     },
     { from  => 1193526000, # 2007-10-28 01:00
       until => 1194649200, # 2007-11-10 00:00
       text  => 'L 022 Sch�nermark-Lindow zw. Sch�nermark und Keller Deckenerneuerung Vollsperrung 29.10.2007-09.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -15344,63638 -14811,64192 -13924,65015 -13695,65213 -13104,65432 -12824,65746 -12440,66011 -12209,66099 -10423,66477
EOF
     },
     { from  => undef, # 
       until => 1207493624, # Time::Local::timelocal(reverse(2010-1900,1-1,1,0,0,0))
       text  => 'Bauarbeiten am Ostkreuz, Verbindungsstra�e k�nnte f�r die Durchfahrt gesperrt sein',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 14688,10167 14752,10246 14794,10336 14820,10473 14832,10512 14843,10621 14882,10732
EOF
     },
     { from  => undef, # 
       until => 1210598963, # Time::Local::timelocal(reverse(2010-1900,1-1,1,0,0,0))
       text  => 'Bauarbeiten am Ostkreuz, Durchfahrt nicht mehr m�glich',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 14911,10587 14843,10621
EOF
     },
     { from  => 1193776707, # 2007-10-30 21:38
       until => 1198881635, # 2007-12-31 23:59 1199141999
       text  => 'Birkenstr. (Tiergarten) beide Richtungen, zwischen Stromstr. und L�becker Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 12.2007)',
       type  => 'handicap',
       source_id => 'IM_006788',
       data  => <<EOF,
userdel	q4::inwork 6227,13938 6365,13879
EOF
     },
     { from  => 1193776759, # 2007-10-30 21:39
       until => 1194130800, # 2007-11-04 00:00
       text  => 'Zabel-Kr�ger-Damm (Waidmannslust) Richtung L�bars bei Schonacher Str. Baustelle, Fahrtrichtung gesperrt (bis 03.11.2007)',
       type  => 'gesperrt',
       source_id => 'IM_007006',
       data  => <<EOF,
userdel	1::inwork 4898,22459 5006,22507 5142,22581
EOF
     },
     { from  => 1194390000, # 2007-11-07 00:00
       until => 1196463600, # 2007-12-01 00:00
       text  => 'L 088 Klaistow-Lehnin OD Emstal Stra�enbauarbeiten Vollsperrung 08.11.2007-30.11.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -32394,-12207 -32010,-12375 -31776,-12438 -31585,-12330
EOF
     },
     { from  => 1193957489, # 2007-11-01 23:51
       until => 1197837567, # 2007-12-31 23:59 1199141999
       text  => 'Askanierring (Spandau) in Richtung Fehrbelliner Tor ab Eckschanze Baustelle, Fahrtrichtung gesperrt (bis Ende 2007)',
       type  => 'gesperrt',
       source_id => 'IM_002956',
       data  => <<EOF,
userdel	1::inwork -3997,15664 -4012,15780 -3995,15832 -3942,15926 -3896,15999 -3828,16118 -3735,16205 -3631,16224
EOF
     },
     { from  => 1215381132, # 
       until => 1215381137, # 2008-07-15 00:00 undef
       text  => 'Holl�nderstr. (Reinickendorf) Richtung Markstr., zwischen Aroser Allee und Markstr. Baustelle, Fahrtrichtung gesperrt (bis Mitte 2008) ',
       type  => 'gesperrt',
       source_id => 'IM_007023',
       data  => <<EOF,
userdel	1::inwork 6878,17315 6995,17322 7031,17323 7104,17326 7288,17308 7379,17295 7602,17399
EOF
     },
     { from  => 1194130800, # 2007-11-04 00:00
       until => 1225407600, # 2008-10-31 00:00
       text  => 'B 167 OD Alt Ruppin, zw. Br�ckenstr. und Neum�hler Weg Stra�en- u. Br�ckenbauarbeiten Vollsperrung 05.11.2007-30.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -28641,59609 -28866,59954 -29211,60036
EOF
     },
     { from  => 1194130800, # 2007-11-04 00:00
       until => 1194735600, # 2007-11-11 00:00
       text  => 'L 025 Prenzlau-Sch�nermark zw. OA G�stow und OE Wilhelmshof Deckenerneuerung Vollsperrung 05.11.2007-10.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 34336,102545 33123,102859 32251,103225
EOF
     },
     { from  => 1194301150, # 2007-11-05 23:19
       until => 1197759599, # 2007-12-15 23:59
       text  => 'Schlichtallee (Lichtenberg) in beiden Richtungen zwischen Hauptstr. und L�ckstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Mitte 12.2007)',
       type  => 'gesperrt',
       source_id => 'IM_007063',
       data  => <<EOF,
userdel	2::inwork 15758,10578 15639,10469
EOF
     },
     { from  => 1194897448, # 2007-11-12 20:57
       until => 1198277999, # 2007-12-21 23:59
       text  => 'L�ckstr. (Lichtenberg) Richtung N�ldnerplatz zwischen Emanuelstr.und Schlichtallee Baustelle, Fahrtrichtung gesperrt (bis 21.12.)',
       type  => 'gesperrt',
       source_id => 'IM_007093',
       data  => <<EOF,
userdel	1::inwork 16313,10747 16300,10753 16153,10818 16085,10844 16032,10842
EOF
     },
     { from  => 1195308223, # 
       until => 1195308227, #
       text  => 'Siegfriedstr. (Lichtenberg) in beiden Richtungen zwischen Josef-Orlopp-Str. und Herzbergstr. Beeintr�chtigung durch Sicherungsma�nahmen, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_007154',
       data  => <<EOF,
userdel	2::inwork 16866,13532 16863,13138
EOF
     },
     { from  => 1195081200, # 2007-11-15 00:00
       until => 1195254000, # 2007-11-17 00:00
       text  => 'L 023 OU Strausberg, zw. Kreisel Seespitze u. Abzw. Stadt Treibjagd Vollsperrung 16.11.2007-16.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 41683,19794 41882,20643
EOF
     },
     { from  => 1194822000, # 2007-11-12 00:00
       until => 1196204400, # 2007-11-28 00:00
       text  => 'L 216 Gollin-Templin zw. Vietmannsdorf und Templin Stra�enbauarbeiten Vollsperrung 13.11.2007-27.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 16089,76059 16012,75080 16653,73857 16637,73599
EOF
     },
     { from  => 1195515878, # 2007-11-20 00:44
       until => 1196549999, # 2007-12-01 23:59
       text  => 'Bahnhofstr. (Blankenfelde) in beiden Richtungen Baustelle, Stra�e vollst�ndig gesperrt (bis Anfang 12.2007)',
       type  => 'gesperrt',
       source_id => 'IM_007189',
       data  => <<EOF,
userdel	2::inwork 8909,23506 8803,23478 8632,23442 8619,23438 8562,23421 8141,23477
EOF
     },
     { from  => 1195308071, # 2007-11-17 15:01
       until => 1195444800, # 2007-11-19 05:00
       text  => 'Baumschulenstr. (Treptow) in beiden Richtungen H�he S-Bahnbr�cke Baustelle, Stra�e vollst�ndig gesperrt (bis 19.11. 05 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_007201',
       data  => <<EOF,
userdel	2::inwork 16286,6946 16323,6998
EOF
     },
     { from  => 1195308150, # 2007-11-17 15:02
       until => 1195858800, # 2007-11-24 00:00
       text  => 'Buchholzer Str. (Niedersch�nhausen) in Richtung Nord, zwischen Charlottenstr. und Grumbkowstr. Baustelle, Fahrtrichtung gesperrt (bis 23.11.07)',
       type  => 'gesperrt',
       source_id => 'IM_007190',
       data  => <<EOF,
userdel	1::inwork 10802,20240 10843,20301 11004,20526 11269,20667
EOF
     },
     { from  => 1194994800, # 2007-11-14 00:00
       until => 1195513200, # 2007-11-20 00:00
       text  => 'B 096 Hauptstr., Zossener Str. OD Baruth Einbau Deckschicht Vollsperrung 15.11.2007-19.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 18272,-39512 18433,-38781
EOF
     },
     { from  => 1201734000, # 2008-01-31 00:00
       until => 1209160800, # 2008-04-26 00:00
       text  => 'L 015 Hardenbeck - F�rstenberg OD Lychen, Prenzlauer Str. Kanal- und Stra�enbau Vollsperrung 01.02.2008-25.04.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 2940,90332 2565,89990 2745,89716
EOF
     },
     { from  => undef, # # note: verlegt (Opernpalais)
       until => 1199141999, # 2007-12-31 23:59
       text  => 'Weihnachtsmarkt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 9708,12235 9702,12307 9695,12390
EOF
     },
     { from  => undef, # # note: existiert nicht mehr
       until => 1199141999, # 2007-12-31 23:59
       text  => 'Weihnachtsmarkt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10174,12284 10063,12438
EOF
     },
     { from  => 1195515915, # 2007-11-20 00:45
       until => 1196031600, # 2007-11-26 00:00
       text  => 'Chausseestr. (Mitte) Richtung M�llerstr. zwischen Invalidenstr. und Zinnowitzer Str. Baustelle, Fahrtrichtung gesperrt (bis 25.11.2007) ',
       type  => 'gesperrt',
       source_id => 'IM_007211',
       data  => <<EOF,
userdel	1::inwork 8935,13844 8879,13913
EOF
     },
     { from  => 1195513200, # 2007-11-20 00:00
       until => 1196204400, # 2007-11-28 00:00
       text  => 'B 167 Liebenberg - L�wenberg Bahn�bergang in Neul�wenberg Gleisbauarbeiten Vollsperrung 21.11.2007-27.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -6342,54585 -5122,54564 -4424,54552 -4176,54548
EOF
     },
     { from  => 1195772400, # 2007-11-23 00:00
       until => 1196118000, # 2007-11-27 00:00
       text  => 'B 107 Jeserig-Wiesenburg Bahn�bergang in der OD Wiesenburg Gleisbauarbeiten Vollsperrung 24.11.2007-26.11.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -54890,-35286 -54891,-35326 -54881,-35591
EOF
     },
     { from  => 1196118000, # 2007-11-27 00:00
       until => 1196809200, # 2007-12-05 00:00
       text  => 'B 273 Breite Str. OD Oranienburg, zw. Berliner Str. und Havelstr. Deckschichteinbau Vollsperrung 28.11.2007-04.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -1595,38315 -1571,38406 -1553,38501 -1515,38500
EOF
     },
     { from  => 1195513200, # 2007-11-20 00:00
       until => 1196463600, # 2007-12-01 00:00
       text  => 'L 233 Bahnhofstr. OD Rehfelde, zw. Bahn�bergang und E.-Th�lmann-Str. Deckenschluss halbseitig gesperrt; Einbahnstra�e 21.11.2007-30.11.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 45732,14245 45740,14260 45856,14437
EOF
     },
     { from  => 1196377200, # 2007-11-30 00:00
       until => 1196809200, # 2007-12-05 00:00
       text  => 'B 087 Luckauer Str. Bahn�bergang in der OD Langengrassau Sanierung Bahn�bergang Vollsperrung 01.12.2007-04.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 28150,-63424 27995,-63503 27033,-64026
EOF
     },
     { from  => 1196636400, # 2007-12-03 00:00
       until => 1198278000, # 2007-12-22 00:00
       text  => 'K 6419 Ernst-Th�lmann-Str. OD Rehfelde, zw. Bahnhofstr. und Lindenstr. Stra�enbauarbeiten Vollsperrung 04.12.2007-21.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 45856,14437 44121,14615
EOF
     },
     { from  => 1210543200, # 2008-05-12 00:00
       until => 1221861600, # 2008-09-20 00:00
       text  => 'L 073 Neue Beelitzer Str. OL Luckenwalde, zw. Triftstr. und Kleiststr. Stra�enausbau Vollsperrung 13.05.2008-19.09.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -4725,-34957 -5019,-34814
EOF
     },
     { from  => 1190498400, # 2007-09-23 00:00
       until => 1210485588, # 2008-11-01 00:00 1225494000
       text  => 'L 080 Bahnhofstr. OL Luckenwalde, Einm�nd. Beelitzer Str. Stra�enausbau Vollsperrung 24.09.2007-31.10.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -4725,-34957 -4888,-34952
EOF
     },
     { from  => 1196636400, # 2007-12-03 00:00
       until => 1198278000, # 2007-12-22 00:00
       text  => 'L 090 Potsdamer Str. OL Werder (Havel), zw. Berliner Str. und Gr�ner Weg Kanalarbeiten halbseitig gesperrt; Einbahnstra�e 04.12.2007-21.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -20851,-4878 -20696,-5198
EOF
     },
     { from  => 1196636400, # 2007-12-03 00:00
       until => 1196809200, # 2007-12-05 00:00
       text  => 'L 096 Milow - Rathenow zw. Eisenbahnbr�cke und B188 Rathenow Stra�enbauarbeiten Vollsperrung 04.12.2007-04.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -65141,19165 -65165,19674 -65134,20143
EOF
     },
     { from  => 1197062386, # 2007-12-07 22:19
       until => 1197673199, # 2007-12-14 23:59
       text  => 'Leuthener Str. (Sch�neberg) in beiden Richtungen zwischen Leberstr. und Gotenstr. geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt (bis 14.12.)',
       type  => 'gesperrt',
       source_id => 'IM_007404',
       data  => <<EOF,
userdel	2::inwork 7578,8358 7494,8364
EOF
     },
     { from  => 1197062453, # 2007-12-07 22:20
       until => 1197219600, # 2007-12-09 18:00
       text  => 'Torstr. (Mitte) Richtung Rosenthaler Platz zwischen Stra�burger Str. und Sch�nhauser Allee Baustelle, Fahrtrichtung gesperrt (bis 09.12. 18 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_007387',
       data  => <<EOF,
userdel	1::inwork 10898,13632 10746,13673
EOF
     },
     { from  => 1197500400, # 2007-12-13 00:00
       until => 1198105200, # 2007-12-20 00:00
       text  => 'K 6907 Bahn�bergang Ferch-Lienewitz Gleisbauarbeiten Vollsperrung 14.12.2007-19.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -18640,-11826 -19043,-11944 -19150,-11976
EOF
     },
     { from  => 1197154800, # 2007-12-09 00:00
       until => 1197838145, # 2007-12-22 00:00 1198278000
       text  => 'L 029 Hohenfinow - Heckelberg zw. Heckelberg und Kruge Fahrbahninstandsetzung Vollsperrung 10.12.2007-21.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 39917,38037 40666,38512 41864,39489 42062,39651
EOF
     },
     { from  => 1197154800, # 2007-12-09 00:00
       until => 1197759600, # 2007-12-16 00:00
       text  => 'L 030 Lindenstr. Bahn�bergang zur Bahnhof- u. Bruchm�hler Str. in Petershagen Gleisbauarbeiten Vollsperrung 10.12.2007-15.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 35386,13954 35427,13624
EOF
     },
     { from  => 1197154800, # 2007-12-09 00:00
       until => 1198278000, # 2007-12-22 00:00
       text  => 'L 238 Eberswalde-ASWerbellin Br�cke der A 11 zw. Lichterfelde u. Altenhof Stra�enanbindung Vollsperrung 10.12.2007-21.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 31065,54239 30773,54731
EOF
     },
     { from  => 1196982000, # 2007-12-07 00:00
       until => 1197759600, # 2007-12-16 00:00
       text  => 'L 792 Gro� Schulzendorf-Mahlow OD Blankenfelde, Kno. Zossener-/Potsdamer Damm Deckeneinbau Vollsperrung 08.12.2007-15.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 9990,-8867 10115,-8276
EOF
     },
     { from  => 1197233736, # 
       until => 1199903161, #
       text  => 'Holteistra�e: Bauarbeiten zwischen Sonntagstr. und W�hlischstr., Fahrbahn ist nicht benutzbar',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 14535,11327 14575,11407
EOF
     },
     { from  => 1197327600, # 2007-12-11 00:00
       until => 1197673200, # 2007-12-15 00:00
       text  => 'L 233 Bahnhofstr. OD Rehfelde, zw. Friedrich-Engels-Str. und Bahn�bergang Stra�enbauarbeiten Vollsperrung 12.12.2007-14.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 45732,14245 45740,14260 45856,14437
EOF
     },
     { from  => 1188165600, # 2007-08-27 00:00
       until => 1197838127, # 2007-12-21 00:00 1198191600
       text  => 'B 168 zw. Friedland und Beeskow Stra�enbauarbeiten Vollsperrung 28.08.2007-20.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 69461,-27572 69234,-26113 69227,-25669
EOF
     },
     { from  => 1197327600, # 2007-12-11 00:00
       until => 1197932400, # 2007-12-18 00:00
       text  => 'B 189 Wittstocker Chaussee Bahn�bergang in der OD Pritzwalk Gleissanierungsarbeiten Vollsperrung 12.12.2007-17.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -73222,81222 -72939,81204
EOF
     },
     { from  => 1197759600, # 2007-12-16 00:00
       until => 1198105200, # 2007-12-20 00:00
       text  => 'L 283 Parstein - B 2 Schmargendorf Bahn�bergang in der OD Herzsprung Bauarbeiten am B� Vollsperrung 17.12.2007-19.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 49004,64047 48516,64085 48151,64245
EOF
     },
     { from  => 1197933378, # 2007-12-18 00:16
       until => 1198278000, # 2007-12-22 00:00
       text  => 'F�rstenwalder Damm (K�penick) Richtung Salvador-Allende-Str. zwischen B�lschestr. und Ahornallee Baustelle, Fahrtrichtung gesperrt (bis 21.12.2007)',
       type  => 'gesperrt',
       source_id => 'IM_007457',
       data  => <<EOF,
userdel	1::inwork 25579,5958 25179,5819 25121,5799
EOF
     },
     { from  => 1200178800, # 2008-01-13 00:00
       until => 1201561200, # 2008-01-29 00:00
       text  => 'L 023 Herzfelde-Strausberg OD Hennickendorf, unterhalb Wachtelberg Instandsetzung St�tzwand Vollsperrung 14.01.2008-28.01.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 40565,12409 40362,12087
EOF
     },
     { from  => 1211234400, # 2008-05-20 00:00
       until => 1211828204, # 2008-07-01 00:00 1214863200
       text  => 'L 030 Ethel-und-Julius-Rosenberg-Str. OD Woltersdorf, zw. A.-Bebel-Str. und R.-Breitscheid Stra�enbau, Entw�sserung Vollsperrung 21.05.2008-30.06.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 34511,4787 34535,5319
EOF
     },
     { from  => 1197932400, # 2007-12-18 00:00
       until => 1198278000, # 2007-12-22 00:00
       text  => 'L 085 Br�ck-Golzow zw. OA Golzow und OE Cammer Stra�enbau Vollsperrung 19.12.2007-21.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -42483,-15134 -41439,-15493 -41352,-15664 -39523,-16953
EOF
     },
     { from  => 1198328869, # 2007-12-22 14:07
       until => 1210356689, # 2008-06-01 00:00 1212271200
       text  => 'K�rtestr. (Kreuzberg) in beiden Richtungen zwischen S�dstern und Urbanstr. Baustelle, Stra�e vollst�ndig gesperrt, Gehweg ist passierbar (bis Mai 2008)',
       type  => 'handicap',
       source_id => 'IM_007458',
       data  => <<EOF,
userdel	q4::inwork 10747,9326 10713,9260
EOF
     },
     { from  => 1198881536, # 2007-12-28 23:38
       until => 1199314800, # 2008-01-03 00:00
       text  => 'Stra�e des 17. Juni Mitte, zwischen Gro�er Stern und Brandenburger Tor, Ebertstr., Y.-Rabin-Str.: Silvesterparty am Brandenburger Tor, Stra�en vollst�ndig gesperrt (bis 03.01.2008 morgens)',
       type  => 'gesperrt',
       source_id => 'IM_007479',
       data  => <<EOF,
userdel	2::inwork 8600,12165 8538,12245 8303,12216 8214,12205 8089,12190
userdel	2::inwork 6828,12031 7383,12095 7816,12150 8055,12186 8119,12414
EOF
     },
     { from  => 1211228504, # 2008-05-19 22:21
       until => 1214588413, # 2008-06-30 23:59 1214863199
       text  => 'Sterndamm (Treptow) Richtung Sch�neweide zwischen J.-Werner.Str und Lindhorstweg Baustelle, Fahrtrichtung gesperrt (bis Ende Juni 2008)',
       type  => 'gesperrt',
       source_id => 'IM_007543',
       data  => <<EOF,
userdel	1::inwork 17053,3971 17108,4049 17244,4242 17261,4267 17290,4308 17387,4446
EOF
     },
     { from  => undef, # 
       until => 1204239599, # 2008-02-28 23:59
       text  => 'Einbahnstra�e Richtung Westen wegen Bauarbeiten',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 5149,7012 5251,6949 5357,6932
EOF
     },
     { from  => 1200438000, # 2008-01-16 00:00
       until => 1200697200, # 2008-01-19 00:00
       text  => 'B 246 Beelitz - Br�ck Bahn�bergang Br�ck-Ausbau Gleisbauarbeiten Vollsperrung 17.01.2008-18.01.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -29244,-23127 -30149,-22937 -30811,-22899
EOF
     },
     { from  => undef, # 
       until => 1204239600, # 2008-02-29 00:00
       text  => 'Anna-Louisa-Karsch Str. (Mitte) in Richtung Friedrichsbr�cke zwischen An der Spandauer Br�cke und Burgstr. Bauarbeiten, Fahrtrichtung gesperrt (bis Ende Feb 2008)',
       type  => 'gesperrt',
       source_id => 'IM_007651',
       data  => <<EOF,
userdel	1::inwork 10309,12854 10264,12826 10166,12777
EOF
     },
     { from  => 1198018800, # 2007-12-19 00:00
       until => 1209592800, # 2008-05-01 00:00
       text  => 'L 030 B�rnicker Chaussee OD Bernau, zw. Gernotstr. und Sch�nfelder Weg Stra�enbau Vollsperrung 20.12.2007-30.04.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 23113,30450 23368,30409 23631,30262
EOF
     },
     { from  => 1216405512, # 2008-07-18 20:25
       until => 1222811999, # 2008-09-30 23:59
       text  => 'Pistoriusstr. (Wei�ensee) Richtung Am Steinberg zwischen Gustav-Adolf-Str. und Am Steinberg Baustelle, Fahrtrichtung gesperrt (bis Ende 09.2008)',
       type  => 'gesperrt',
       source_id => 'IM_006024',
       data  => <<EOF,
userdel	1::inwork 12257,16876 12472,16783 12602,16727 12667,16699
EOF
     },
     { from  => 1201647600, # 2008-01-30 00:00
       until => 1208556000, # 2008-04-19 00:00
       text  => 'L 314 Zepernicker Chaussee OD Bernau grundhafter Stra�enbau Vollsperrung 31.01.2008-18.04.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 22178,30343 21872,30139 21561,30131 21117,29968
EOF
     },
     { from  => 1207420756, # 2008-04-05 20:39
       until => 1210801866, # 2008-05-15 23:59 1210888799
       text  => 'Behrenstr. (Mitte) Richtung Bebelplatz zwischen Glinkastr. und Friedrichstr. Baustelle, Fahrtrichtung gesperrt (bis Mitte 05.2008)',
       type  => 'gesperrt',
       source_id => 'IM_007843',
       data  => <<EOF,
userdel	1::inwork 9164,12172 9373,12197
EOF
     },
     { from  => 1204328757, # 2008-03-01 00:45
       until => 1204758000, # 2008-03-06 00:00
       text  => 'Hultschiner Damm (Mahlsdorf) Richtung K�penick zwischen Alt-Mahlsdorf und Elsenstr. Baustelle, Fahrtrichtung gesperrt, eine Umleitung ist eingerichtet (bis 05.03.2008)',
       type  => 'gesperrt',
       source_id => 'IM_007852',
       data  => <<EOF,
userdel	1::inwork 24654,11265 24693,11141 24740,10992 24653,10831 24639,10766
EOF
     },
     { from  => 1203374120, # 2008-02-18 23:35
       until => 1209496368, # 2008-04-30 23:59 1209592799
       text  => 'Oranienburger Str. (Mitte) Richtung Friedrichstr. zwischen Linienstr. und Friedrichstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 04.2008)',
       type  => 'handicap',
       source_id => 'IM_007850',
       data  => <<EOF,
userdel	q4::inwork; 9281,13374 9225,13389
EOF
     },
     { from  => 1203202800, # 2008-02-17 00:00
       until => 1220220000, # 2008-09-01 00:00
       text  => 'B 001 Brandenburger Str. OD Jeserig Stra�enbau Vollsperrung 18.02.2008-31.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -36720,-272 -37086,-305 -37725,-398 -38151,-616
EOF
     },
     { from  => 1203289200, # 2008-02-18 00:00
       until => 1209592800, # 2008-05-01 00:00
       text  => 'B 103 Kyritz - Pritzwalk OD Buchholz, zw. Eggersdorfer Damm und OA Kanal- und Stra�enbau Vollsperrung 19.02.2008-30.04.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -73678,77438 -73946,77861 -74038,78181
EOF
     },
     { from  => 1204585200, # 2008-03-04 00:00
       until => 1210716000, # 2008-05-14 00:00
       text  => 'B 168 Pr�tzel - Tiefensee zw. Pr�tzel und Abzw. Gielsdorf Deckenerneuerung Vollsperrung 05.03.2008-13.05.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 48953,26802 48260,27132 46629,27232 44331,27632 44164,27738 44003,27939 41532,28941
EOF
     },
     { from  => 1203462000, # 2008-02-20 00:00
       until => 1203721200, # 2008-02-23 00:00
       text  => 'B 246 Beelitz - Br�ck Bahn�bergang Br�ck-Ausbau Gleisbauarbeiten Vollsperrung 21.02.2008-22.02.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -30811,-22899 -30149,-22937 -29244,-23127
EOF
     },
     { from  => 1203202800, # 2008-02-17 00:00
       until => 1220133600, # 2008-08-31 00:00
       text  => 'L 029 Zehlendorf - Schmachtenhagen Br�cke �ber die B�ke in der OD Schmachtenhagen Br�ckenneubau Vollsperrung 18.02.2008-30.08.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 4659,40821 4562,40526
EOF
     },
     { from  => 1202598000, # 2008-02-10 00:00
       until => 1212271200, # 2008-06-01 00:00
       text  => 'L 141 Havelberger Str. OD Breddin Kanal- u. Stra�enbauarbeiten Vollsperrung * 11.02.2008-31.05.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -70922,51604 -70980,51154 -71053,49770
EOF
     },
     { from  => 1204412400, # 2008-03-02 00:00
       until => 1213737746, # 2008-07-01 00:00 1214863200
       text  => 'B 122 Berliner Str. OD Rheinsberg, zw. Schlo�str. und Paulshorster Str. Kanalarbeiten Vollsperrung 03.03.2008-30.06.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -25508,76444 -25411,76258
EOF
     },
     { from  => 1204328798, # 2008-03-01 00:46
       until => 1204513200, # 2008-03-03 04:00
       text  => 'Karlshorster Str. (Lichtenberg) Richtung Hauptstr. nach Marktstr. Baustelle, Fahrtrichtung gesperrt (bis 03.03., 04 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_007944',
       data  => <<EOF,
userdel	1::inwork 15279,10862 15272,10790 15261,10738
EOF
     },
     { from  => 1204412400, # 2008-03-02 00:00
       until => 1215208800, # 2008-07-05 00:00
       text  => 'B 168 zw. Abzw. Zeust und Beeskow Stra�enbauarbeiten Vollsperrung 03.03.2008-04.07.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 69461,-27572 69234,-26113 69227,-25669
EOF
     },
     { from  => 1205622000, # 2008-03-16 00:00
       until => 1206572400, # 2008-03-27 00:00
       text  => 'L 256 B109 - LG - Milow - B104 Bahn�bergang bei Nechlin Gleisbauarbeiten Vollsperrung 17.03.2008-26.03.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 42905,115846 42250,115925 42222,115929
EOF
     },
     { from  => 1203202800, # 2008-02-17 00:00
       until => 1219096799, # 2008-08-18 23:59
       text  => 'Neubau der B�kebr�cke',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 4659,40821 4562,40526
EOF
     },
     { from  => 1204758000, # 2008-03-06 00:00
       until => 1205276400, # 2008-03-12 00:00
       text  => 'L 066 M�glenz - Burxdorf Bahn�bergang in der OD Neuburxdorf Gleisbauarbeiten Vollsperrung 07.03.2008-11.03.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 5491,-104300 5180,-104502
EOF
     },
     { from  => 1205190000, # 2008-03-11 00:00
       until => 1205535600, # 2008-03-15 00:00
       text  => 'L 066 M�hlberg-B182 (Torgau-Riesa) zw. M�hlberg und F�hre Br�ckenschluss Vollsperrung 12.03.2008-14.03.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -1224,-107827 -1061,-107847
EOF
     },
     { from  => undef, # this entry is by Lutz Epperlein
       until => 1208806827, # end guessed! Time::Local::timelocal(reverse(2008-1900,6-1,1,0,0,0))
       text  => 'Das letzte Ende (zur Sch�nhauser Allee) der Saarbr�cker Str. ist momentan wg. Baustelle gesperrt. Es ist zu vermuten, dass dort das Kopfsteinpflaster entfernt wird.',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 10969,13914 10924,13940
EOF
     },
     { from  => undef, # 
       until => 1205673255, #
       text  => 'Sophienstr. (Mitte) in beiden Richtungen zwischen Gro�e Hamburger Str. und Rosenthaler Str. Bauarbeiten, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_008076',
       data  => <<EOF,
userdel	2::inwork 9986,13412 10317,13248
EOF
     },
     { from  => 1205622000, # 2008-03-16 00:00
       until => 1212184800, # 2008-05-31 00:00
       text  => 'B 087 Leipziger Str. OD FFO, zw. Biegener- u. Krz.Kopernikus-/M�llroser-/EHS Str. Stra�enausbau halbseitig gesperrt; Einbahnstra�e 17.03.2008-30.05.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 87846,-6398 87671,-6669
EOF
     },
     { from  => 1206486000, # 2008-03-26 00:00
       until => 1206831600, # 2008-03-30 00:00
       text  => 'K 6160 Friedensstr. Bahn�bergang in der OD Eichwalde Gleisbauarbeiten Vollsperrung 27.03.2008-29.03.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 25187,-8934 25140,-9125
EOF
     },
     { from  => 1207087200, # 2008-04-02 00:00
       until => 1207346400, # 2008-04-05 00:00
       text  => 'L 054 Calau - Vetschau Bahn�bergang Calauer Str. in der OD Sa�leben Gleisumbauarbeiten Vollsperrung 03.04.2008-04.04.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 50732,-71705 51374,-71361 51440,-71337
EOF
     },
     { from  => 1207519200, # 2008-04-07 00:00
       until => 1207864800, # 2008-04-11 00:00
       text  => 'L 054 Calau - Vetschau Bahn�bergang Calauer Str. in der OD Sa�leben Gleisumbauarbeiten Vollsperrung 08.04.2008-10.04.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 50732,-71705 51374,-71361 51440,-71337
EOF
     },
     { from  => 1207778400, # 2008-04-10 00:00
       until => 1208210400, # 2008-04-15 00:00
       text  => 'L 055 Calau - L�bbenau Bahn�bergang in der OD Bischdorf Instandsetzung B� Vollsperrung 11.04.2008-14.04.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 49836,-67419 50153,-67024 50318,-65825
EOF
     },
     { from  => 1206313200, # 2008-03-24 00:00
       until => 1213737777, # 2008-07-02 00:00 1214949600
       text  => 'L 075 Tollkrug - Selchow - Wa�mannsdorf OD Selchow Stra�enbauarbeiten Vollsperrung 25.03.2008-01.07.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 15355,-5280 15568,-5323 15771,-5575 15867,-5823 15889,-5898
#XXX del wegen BBI: userdel	q4::inwork 15889,-5898 15987,-6248 16190,-6406
EOF
     },
     { from  => 1205017200, # 2008-03-09 00:00
       until => 1220220000, # 2008-09-01 00:00
       text  => 'L 232 M�llensee-Lichtenow Br�cke �ber den Verbindungsgraben in der OD Kagel Br�ckenbauarbeiten Vollsperrung 10.03.2008-31.08.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 44914,6791 44933,6625
EOF
     },
     { from  => 1205017200, # 2008-03-09 00:00
       until => 1210456800, # 2008-05-11 00:00
       text  => 'L 235 Gielsdorf-Werneuchen OD Werneuchen Stra�enausbau Vollsperrung 10.03.2008-10.05.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 32715,25292 32826,25218 33510,24304
EOF
     },
     { from  => 1205622000, # 2008-03-16 00:00
       until => 1214863200, # 2008-07-01 00:00
       text  => 'L 029 Oderberg-Liepe OD Oderberg Stra�enbauarbeiten Vollsperrung 17.03.2008-30.06.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 52671,51846 51496,51542
EOF
     },
     { from  => 1206313200, # 2008-03-24 00:00
       until => 1206831600, # 2008-03-30 00:00
       text  => 'L 062 Elsterwerda - Hohenleipisch Bahn�bergang bei Elsterwerda Gleisbauarbeiten Vollsperrung 25.03.2008-29.03.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 22654,-103425 22256,-103785
EOF
     },
     { from  => 1206832625, # 2008-03-30 00:17
       until => 1207346400, # 2008-04-05 00:00
       text  => 'Stresowstr. (Spandau) in beiden Richtungen am Stresowplatz Baustelle, Stra�e vollst�ndig gesperrt (bis 04.04.2008)',
       type  => 'gesperrt',
       source_id => 'IM_008131',
       data  => <<EOF,
userdel	2::inwork -3001,13877 -3049,13959 -3068,14033
EOF
     },
     { from  => 1205967600, # 2008-03-20 00:00
       until => 1206399600, # 2008-03-25 00:00
       text  => 'B 113 B 2 - Damitzow - BG Bahn�bergang in der OD Tantow Gleisbauarbeiten Vollsperrung 21.03.2008-24.03.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 72960,97477 73017,97449 73031,97443
EOF
     },
     { from  => 1207432800, # 2008-04-06 00:00
       until => 1210370400, # 2008-05-10 00:00
       text  => 'L 222 Gransee - Menz zw. Menz und Kreuz. Zernickow Stra�eninstandsetzung Vollsperrung 07.04.2008-09.05.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -13537,75287 -13950,75662 -14862,76637
EOF
     },
     { from  => 1205708400, # 2008-03-17 00:00
       until => 1206918000, # 2008-03-31 01:00
       text  => 'L 222 Gransee - Menz zw. OA Gro�woltersdorf und Kreuz. Zernickow Stra�eninstandsetzung Vollsperrung 18.03.2008-30.03.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -12250,73762 -12381,74147 -12575,74512 -13537,75287
EOF
     },
     { from  => 1205966138, # 2008-03-19 23:35
       until => 1206039600, # 2008-03-20 20:00
       text  => 'Sophienstr. (Mitte) zwischen Rosenthaler Str. und Gro�e Hamburger Str. Kraneinsatz, Stra�e vollst�ndig gesperrt (bis 20.03.2008 ca. 20 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_008152',
       data  => <<EOF,
userdel	2::inwork 9986,13412 10317,13248
EOF
     },
     { from  => 1206313200, # 2008-03-24 00:00
       until => 1206831600, # 2008-03-30 00:00
       text  => 'L 098 Brandenburg - Rathenow zw. Siedlung Radewege und Marzahne Neubau Durchlass Vollsperrung 25.03.2008-29.03.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -48765,8671 -48756,8604
EOF
     },
     { from  => 1215868573, # 2008-03-23 21:45 1206305145 -> now in gesperrt-orig
       until => 1215868579, # 2009-12-31 23:59 1262300399
       text  => 'R�ckbau der Fr.-Ebert-Str. zwischen Breite Str. und Platz der Einheit, Bauarbeiten bis Ende 2009. Unter Umst�nden Umfahrung �ber Alten Markt notwendig. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -12758,-1654 -12772,-1577 -12780,-1544
EOF
     },
     { from  => 1211228399, # 2008-05-19 22:19
       until => 1211579999, # 2008-05-23 23:59
       text  => 'Gormannstr. (Mitte) Kreuzung Linienstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 23.05.)',
       type  => 'handicap',
       source_id => 'IM_008182',
       data  => <<EOF,
userdel	q4::inwork 10406,13543 10445,13675 10463,13747
EOF
     },
     { from  => 1207000800, # 2008-04-01 00:00
       until => 1208988000, # 2008-04-24 00:00
       text  => 'B 101 zw. J�terbog und Hohenahlsdorf Deckenerneuerung Vollsperrung 02.04.2008-23.04.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -7465,-53204 -7643,-51997 -8071,-50478 -8349,-49427 -8616,-48813 -8768,-48324 -8931,-47810
EOF
     },
     { from  => 1206828000, # 2008-03-29 23:00
       until => 1213480800, # 2008-06-15 00:00
       text  => 'K 6814 OD Zechlinerh�tte ,Luhmer Str. zw. Zechlinerstr.u.B 122 Ersatzneubau Jagowbr�cke Vollsperrung 31.03.2008-14.06.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -27053,82717 -27141,82696 -27184,82772 -27346,82842
EOF
     },
     { from  => 1199574000, # 2008-01-06 00:00
       until => 1244381355, # Time::Local::timelocal(reverse(2009-1900,7-1,1,23,59,59)), # 1222811999, # 2008-09-30 23:59
       text  => 'Bauarbeiten am nordwestlichen Bereich der Elsenbr�cke bis Mitte 2009; kein Zugang zum Spreeufer. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 14383,10036 14405,10027
EOF
     },
     { from  => 1206914400, # 2008-03-31 00:00
       until => 1212271200, # 2008-06-01 00:00
       text  => 'B 096 Br�cke �ber den Seichgraben zw. Z�tzen u. Gol�en Br�ckenbauarbeiten Vollsperrung 01.04.2008-31.05.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 27428,-49936 26648,-49177
EOF
     },
     { from  => 1206313200, # 2008-03-24 00:00
       until => 1208728800, # 2008-04-21 00:00
       text  => 'B 109 Sch�nwalde - Wandlitz OD Wandlitz, zw. Kreisel und Berliner Weg Kanalarbeiten Vollsperrung 25.03.2008-20.04.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 13546,37474 12887,36543
EOF
     },
     { from  => 1207173600, # 2008-04-03 00:00
       until => 1207432800, # 2008-04-06 00:00
       text  => 'L 040 Potsdamer Damm OD Blankenfelde, zw. H.-von-H�lsen-Weg und Dorfstr. Deckeneinbau Vollsperrung 04.04.2008-05.04.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 9828,-8106 10115,-8276
EOF
     },
     { from  => 1206914400, # 2008-03-31 00:00
       until => 1207346400, # 2008-04-05 00:00
       text  => 'L 233 Bahnhofstra�e Bahn�bergang OD Rehfelde Arbeiten Bahn�bergang Vollsperrung 01.04.2008-04.04.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 45856,14437 45740,14260
EOF
     },
     { from  => 1207346400, # 2008-04-05 00:00
       until => 1207519200, # 2008-04-07 00:00
       text  => 'L 601 Berliner Str. OL Finsterwalde, zw. Leipziger Str. und Friedensstr. Tr�delmarkt Vollsperrung 06.04.2008-06.04.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 33060,-85292 33103,-85728
EOF
     },
     { from  => 1207432800, # 2008-04-06 00:00
       until => 1208556000, # 2008-04-19 00:00
       text  => 'L 026 zw. OA Wollschow u. OE Br�ssow Einbau Deckschicht Vollsperrung 07.04.2008-18.04.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 61502,112547 60639,112544 58357,111700 57995,111657
EOF
     },
     { from  => 1207432800, # 2008-04-06 00:00
       until => 1207605600, # 2008-04-08 00:00
       text  => 'B 158 Berliner Str. OD Leuenberg Einbau Trag- und Binderschicht Vollsperrung 07.04.2008-07.04.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 42781,33687 43093,33781
EOF
     },
     { from  => 1211148000, # 2008-05-19 00:00
       until => 1220220000, # 2008-09-01 00:00
       text  => 'L 233 Berliner Str. OD Hennickendorf B�schungssanierung Vollsperrung 20.05.2008-31.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 38574,10226 39548,11243 39824,11264
EOF
     },
     { from  => 1207421155, # 2008-04-05 20:45
       until => 1207519200, # 2008-04-07 00:00
       text  => 'M�llerstr. (Wedding) in beiden Richtungen zwischen Leopoldplatz und Seestr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 06.04.2008 nachts)',
       type  => 'gesperrt',
       source_id => 'IM_008238',
       data  => <<EOF,
userdel	2::temp 7277,15586 7198,15656 7129,15717 7043,15793
EOF
     },
     { from  => 1209506400, # 2008-04-30 00:00
       until => 1209679200, # 2008-05-02 00:00
       text  => 'B 112 Frankfurter Str., Bahnhofstr. OD Neuzelle 15. Bibulibustag Vollsperrung 01.05.2008-01.05.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 96003,-33078 96017,-33547 96014,-33803
EOF
     },
     { from  => 1207692000, # 2008-04-09 00:00
       until => 1210370400, # 2008-05-10 00:00
       text  => 'K 6206 B101, Elsterwerda - Stolzenhain OD Elsterwerda, H�he Abzw. Kotschka Stra�enbauarbeiten Vollsperrung 10.04.2008-09.05.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 20510,-106314 20444,-106435 20435,-106770
EOF
     },
     { from  => 1207864800, # 2008-04-11 00:00
       until => 1208037600, # 2008-04-13 00:00
       text  => 'L 040 Potsdamer Damm OD Blankenfelde, am OA Ri. Diedersdorf Deckeneinbau Vollsperrung 12.04.2008-12.04.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 10115,-8276 9828,-8106
EOF
     },
     { from  => 1208462457, # 2008-04-17 22:00
       until => 1208815200, # 2008-04-22 00:00
       text  => 'R�blingstr. (Tempelhof) in beiden Richtungen zwischen Arnulfstr. und Attilastr. geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt (bis ca. 21.04.2008)',
       type  => 'handicap',
       source_id => 'IM_008378',
       data  => <<EOF,
userdel	q4::inwork 7497,5610 7599,5553 7669,5536 7816,5519 7857,5519 8038,5521
EOF
     },
     { from  => 1208546801, # 2008-04-18 21:26
       until => 1208750400, # 2008-04-21 06:00
       text  => 'Str. des 17. Juni (Tiergarten) in beiden Richtungen zwischen Brandenburger Tor und Y.-Rabin-Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 21.04. ca. 6 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_008397',
       data  => <<EOF,
userdel	2::temp 8610,12254 8538,12245 8303,12216 8214,12205 8089,12190 8055,12186
EOF
     },
     { from  => 1209160800, # 2008-04-26 00:00
       until => 1209333600, # 2008-04-28 00:00
       text  => 'L 086 Golzow - Damsdorf OD Lehnin Fl�ming-Fr�hlingsfest Vollsperrung 27.04.2008-27.04.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp -34063,-10552 -33914,-10466 -33873,-10337
EOF
     },
     { from  => 1209160800, # 2008-04-26 00:00
       until => 1209333600, # 2008-04-28 00:00
       text  => 'L 088 Emstal - Netzen OD Lehnin Fl�ming-Fr�hlingsfest Vollsperrung 27.04.2008-27.04.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp -34063,-10552 -34488,-10578
EOF
     },
     { from  => 1208546772, # 2008-04-18 21:26
       until => 1208750400, # 2008-04-21 06:00
       text  => 'Ebertstr. (MItte) in beiden Richtungen zwischen Behrenstr. und Dorotheenstr. Veranstaltung,Stra�e vollst�ndig gesperrt (bis 21.04. ca. 6 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_008398',
       data  => <<EOF,
userdel	2::temp 8595,12066 8600,12165 8538,12245 8546,12279 8570,12302 8573,12325 8540,12420
EOF
     },
     { from  => 1208460517, # 2008-04-17 21:28
       until => 1208728800, # 2008-04-21 00:00
       text  => 'Turmstra�e (Wedding) in beiden Richtungen, zwischen Stromstra�e und Oldenburger Str. Veranstaltung, Stra�e gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_008375',
       data  => <<EOF,
userdel	2::temp 5705,13359 5857,13342 5956,13330 6011,13330 6105,13328 6115,13328 6228,13324
EOF
     },
     { from  => 1223933558, # 2008-10-13 23:32
       until => 1225493999, # 2008-10-31 23:59
       text  => 'Schillerstr. (Wilhelmsruh) Richtung Sch�nholzer Weg zwischen Hauptstr. und Sch�nholzer Weg Baustelle, Fahrtrichtung gesperrt (bis Ende 10.2008)',
       type  => 'gesperrt',
       source_id => 'IM_008423',
       data  => <<EOF,
userdel	1::inwork 7832,20219 7937,20175 8040,20124 8196,20096
EOF
     },
     { from  => 1209496288, # 2008-04-29 21:11
       until => 1210313401, # 2008-05-09 23:59 1210370399
       text  => 'Malchower Weg (Hohensch�nhausen) in beiden Richtungen zwischen Degnerstr. und Gembitzer Str. Baustelle, Stra�e vollst�ndig gesperrt (bis 09. Mai 2008)',
       type  => 'gesperrt',
       source_id => 'IM_008483',
       data  => <<EOF,
userdel	2::inwork 17014,16724 17059,16560
EOF
     },
     { from  => 1215811936, # 2008-07-11 23:32
       until => 1217541599, # 2008-07-31 23:59
       text  => 'Siemensstr. (Obersch�neweide) Richtung Edisonstr. zwischen Wilhelminenhofstr. und Edisonstr. Baustelle, Fahrbahn auf einen Fahrstreifen verengt bzw. gesperrt, eine Umleitung ist eingerichtet (bis Ende 07.2008)',
       type  => 'handicap',
       source_id => 'IM_008562',
       data  => <<EOF,
userdel	q4::inwork; 17614,6571 17766,6616 17860,6644 17962,6674
EOF
     },
     { from  => undef, # 2008-05-12 00:00 1210543200
       until => 1210485554, # 2008-08-01 00:00 1217541600
       text  => 'B 168 Pr�tzel - Tiefensee zw. Pr�tzel, Stadtstelle und KG, H�he Gamensee Deckenerneuerung Vollsperrung 13.05.2008-31.07.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 41299,28974 40339,28934 40135,28824 39921,28733 39155,29093
EOF
     },
     { from  => 1209852000, # 2008-05-04 00:00
       until => 1215900000, # 2008-07-13 00:00
       text  => 'K 7318 Blankenburg - Potzlow zw. Potzlow und Seehausen Stra�enbauarbeiten Vollsperrung 05.05.2008-12.07.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 39375,90456 39609,90247 40122,90048 40230,90006 40583,90157 40865,90202 40938,90213 40938,90342 41087,90547
EOF
     },
     { from  => 1210716000, # 2008-05-14 00:00
       until => 1211234400, # 2008-05-20 00:00
       text  => 'L 030 Friedrichstr. OD Erkner, zw. Kreisverkehr und Beuststr. 16. Heimatfest Vollsperrung 15.05.2008-19.05.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 34443,1951 34250,2546
EOF
     },
     { from  => 1209852000, # 2008-05-04 00:00
       until => 1210197600, # 2008-05-08 00:00
       text  => 'L 256 B109 - Werbelow Bahn�bergang Nechlin Gleisbauarbeiten Vollsperrung 05.05.2008-07.05.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 42905,115846 42250,115925 42222,115929
EOF
     },
     { from  => 1211407200, # 2008-05-22 00:00
       until => 1211752800, # 2008-05-26 00:00
       text  => 'L 055 Calau - Boblitz Bahn�bergang in der OD Bischdorf Instandsetzungsarbeiten Vollsperrung 23.05.2008-25.05.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 49836,-67419 50153,-67024 50318,-65825
EOF
     },
     { from  => 1209754023, # 2008-05-02 20:47
       until => 1230764399, # 2008-12-31 23:59 Ende geraten
       text  => 'Mohrenstr. zwischen Mauerstr. und Glinkastr. gesperrt ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 9220,11781 9171,11777
EOF
     },
     { from  => 1209754154, # 2008-05-02 20:49
       until => 1230764399, # 2008-12-31 23:59 Ende geraten
       text  => 'Oberwallstr. Einbahnstra�e zum Hausvogteiplatz',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 9925,11947 9913,12068
EOF
     },
     { from  => 1209667815, # 2008-05-01 20:50
       until => 1230764399, # 2008-12-31 23:59 Ende geraten
       text  => 'Mohrenstr. am Gendarmenmarkt: Einbahnstra�e Richtung Osten',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 9679,11834 9547,11819
EOF
     },
     { from  => 1209754240, # 2008-05-02 20:50
       until => 1230764399, # 2008-12-31 23:59 Ende geraten
       text  => 'Markgrafenstr. am Gendarmenmarkt: Einbahnstra�e Richtung Norden',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 9668,11928 9679,11834
EOF
     },
     { from  => 1209754714, # 2008-05-02 20:58
       until => 1230764399, # 2008-12-31 23:59
       text  => 'Kleine Gertraudenstr. - Gertraudenstr.: Bauarbeiten, gesperrt ',
       type  => 'gesperrt',
       data  => <<EOF,
# REMOVED (Weg gibt es in strassen-orig nicht mehr) --- userdel	2::inwork 10391,11898 10364,11896
EOF
     },
     { from  => 1210019166, # 2008-05-05 22:26
       until => 1229381999, # 2008-12-15 23:59
       text  => 'K�nigsheideweg (Treptow) Richtung Sterndamm zwischen Haushoferstr. und Sterndamm Baustelle, Fahrtrichtung gesperrt, Radfahrer k�nnen langsam passieren (eng!) (bis Mitte 12.2008)',
       type  => 'handicap',
       source_id => 'IM_008688',
       data  => <<EOF,
userdel	q4; 17115,4757 17266,4720 17520,4649
EOF
     },
     { from  => 1211580000, # 2008-05-24 00:00
       until => 1211925600, # 2008-05-28 00:00
       text  => 'L 054 Calau - Vetschau Bahn�bergang bei Sa�leben Gleisumbauarbeiten Vollsperrung 25.05.2008-27.05.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 50732,-71705 51374,-71361 51440,-71337
EOF
     },
     { from  => 1209852000, # 2008-05-04 00:00
       until => 1241384472, # undef (keine Referenzen mehr bei vmz)
       text  => 'Alt-Rudow: von Krokusstra�e bis K�penicker Stra�e Einbahnstra�e in Richtung Neudecker Weg',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 16849,1437 16805,1488 16610,1715
EOF
     },
     { from  => 1205622000, # 2008-03-16 00:00
       until => 1220220000, # 2008-09-01 00:00
       text  => 'L 793 Alfred-K�hne-Str. Ludwigsfelde, Kreuzung Am Birkengrund/ Ludwigsfelder Str. Bau Kreisverkehr Vollsperrung 17.03.2008-31.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 3257,-10374 2629,-10301 2580,-11069
userdel	q4::inwork 1867,-10228 2629,-10301
EOF
     },
     { from  => 1337887258, # 1307570400, # 1243578210, # 2009-05-29 08:23
       until => Time::Local::timelocal(reverse(2012-1900,5-1,29,6,0,0)), # 1180753200, # 2007-06-02 05:00
       text  => 'Stra�en um den Bl�cherplatz Kreuzberg Bl�cherplatz, Waterlooufer: Mehringdamm - Zossener Str., Bl�cherstr.: Mehringdamm - Zossener Str., Zossener Str.: Waterlooufer-Bl�cherstr. gesperrt (24. - 29.05.2011)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 9521,10010 9448,10014
userdel	2::temp 9858,10199 9837,10117 9827,10051 9521,10010 9536,10064 9579,10122 9599,10175 9687,10180 9825,10206 9865,10227
userdel	2::temp 9416,10196 9599,10175
userdel	2::temp 9579,10122 9631,10142 9702,10129 9827,10051
EOF
     },
     { from  => undef, # 
       until => 1210484837, # undef
       text  => 'Vo�str. (Mitte) in beiden Richtungen zwischen Wilhelmstr. und Gertrud-Kolmar-Str. Fahrbahnuntersp�lung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_008707',
       data  => <<EOF,
userdel	2::inwork 9000,11727 8837,11676
EOF
     },
     { from  => 1186264800, # 2007-08-05 00:00
       until => 1225494000, # 2008-11-01 00:00
       text  => 'L 171 Sch�nflie�er Str. Br�cke �ber die DB in der OD Hohen Neuendorf Br�ckenersatzneubau Vollsperrung 06.08.2007-31.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 2033,29198 2176,29143
EOF
     },
     { from  => 1211061600, # 2008-05-18 00:00
       until => 1225407600, # 2008-10-31 00:00
       text  => 'B 168 F�rstenwalde - M�ncheberg zw. Sch�nfelde und Kreisgrenze Deckenerneuerung Vollsperrung 19.05.2008-30.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 54299,7265 55908,9038
EOF
     },
     { from  => 1210543200, # 2008-05-12 00:00
       until => 1215030582, # 2008-08-01 00:00 1217541600
       text  => 'L 023 Strausberg - B168 - Eberswalde Abzw. Tiefensee-Pr�tzel aus Ri. Gielsdorf Deckenerneuerung Vollsperrung 13.05.2008-31.07.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 41274,28075 41299,28974
EOF
     },
     { from  => 1210543200, # 2008-05-12 00:00
       until => 1212789600, # 2008-06-07 00:00
       text  => 'L 082 Marzahna - Niemegk zw. Marzahna und Zeuden Stra�enbauarbeiten Vollsperrung 13.05.2008-06.06.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -31201,-45781 -32661,-44144 -33582,-43378 -33576,-43159
EOF
     },
     { from  => undef, # 
       until => 1213716727, # undef -> offen
       text  => 'Untere Kynaststr.: Restbauarbeiten, Stra�e k�nnte u.U. bis zum 2.6.2008 gesperrt sein',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 14688,10167 14752,10246 14794,10336 14820,10473 14832,10512 14843,10621 14882,10732 14906,10820
EOF
     },
     { from  => undef, # 
       until => Time::Local::timelocal(reverse(2008-1900,5-1,14+2,0,0,0)), # endtime guessed
       text  => 'Papierlager brennt, K�penicker Str. ist zwischen Manteuffelstr. und Engeldamm gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 12060,11323 12124,11280 12302,11160
EOF
     },
     { from  => 1211828060, # 
       until => 1211828064, #
       text  => 'Gersdorfstra�e (Tempelhof) Richtung Lichtenrade zwischen Kaiserstra�e und Ringstra�e Baustelle, Fahrtrichtung gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_008845',
       data  => <<EOF,
userdel	1::inwork 8496,4331 8618,4187 8605,4138
EOF
     },
     { from  => 1212098400, # 2008-05-30 00:00
       until => 1213716709, # undef -> nach gesperrt-orig gewandert
       text  => 'Kynaststra�e wird ab 2.6.2008 gesperrt. Unter Umst�nden wird dann die Untere Kynaststra�e befahrbar sein.',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 14988,11130 14950,11049 14928,10970 14902,10859 14880,10808 14828,10628 14805,10518
EOF
     },
     { from  => 1211493600, # 2008-05-23 00:00
       until => 1211752800, # 2008-05-26 00:00
       text  => 'L 023 Hennickendorfer Chaussee OL Strausberg, Bahn�bergang Gleisarbeiten Vollsperrung 24.05.2008-25.05.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 39721,13668 40248,14503 40266,14531
EOF
     },
     { from  => 1238277600, # 2009-03-28 23:00
       until => 1243288800, # 2009-05-26 00:00
       text  => 'B 246 R.-Breitscheid-, E.-Th�lmann-, Schauener Str. OD Storkow Deckenerneuerung Vollsperrung 30.03.2009-25.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 46518,-16240 46409,-16251 46004,-16440
EOF
     },
     { from  => 1211234400, # 2008-05-20 00:00
       until => 1214863200, # 2008-07-01 00:00
       text  => 'L 030 Ethel-und-Julius-Rosenberg-Str. OD Woltersdorf, ab A.-Bebel-Str. in Ri. Erkner Stra�enbau, Entw�sserung Vollsperrung 21.05.2008-30.06.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 34511,4787 34574,4552
EOF
     },
     { from  => 1213736980, # 2008-06-17 23:09
       until => 1214690400, # 2008-06-29 00:00
       text  => 'B1 Frankfurter Chaussee (Vogelsdorf) in beiden Richtungen zwischen Gr�nerlinde und Anschlussstelle Berlin-Hellersdorf Baustelle, Stra�e vollst�ndig gesperrt (bis 28.06.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009124',
       data  => <<EOF,
userdel	2::inwork 58237,11268 58056,11318
userdel	2::inwork 33475,10842 32900,10962 31871,10926 30678,10923
EOF
     },
     { from  => 1215030350, # 
       until => 1215030354, #
       text  => 'Gersdorfstr. (Tempelhof) in beiden Richtungen zwischen Kurf�rstenstr. und Kaiserstr. Baustelle, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_009134',
       data  => <<EOF,
userdel	2::inwork 8318,4558 8418,4432 8496,4331
EOF
     },
     { from  => 1215452791, # 
       until => 1215452799, # -> now in gesperrt-orig
       text  => 'Hauptstr. (Friedrichshain-Kreuzberg) in beiden Richtungen zwischen Markgrafendamm und untere Kynaststr. Baustelle, Stra�e vollst�ndig gesperrt, Radfahrer k�nnen schiebend passieren',
       type  => 'handicap',
       source_id => 'IM_009127',
       data  => <<EOF,
userdel	q4::inwork 14906,10820 14794,10844
EOF
     },
     { from  => 1213737230, # 2008-06-17 23:13
       until => 1220306399, # 2008-09-01 23:59
       text  => 'Ritterstr. (Kreuzberg) Richtung Kottbusser Tor zwischen Lobeckstr. und Prinzenstr. Baustelle, Fahrtrichtung gesperrt (bis 01.09.)',
       type  => 'gesperrt',
       source_id => 'IM_008984',
       data  => <<EOF,
userdel	1::inwork 10585,10766 10776,10682
EOF
     },
     { from  => 1214588431, # undef
       until => 1214588437, # undef
       text  => 'Zeltinger Str. (Reinickendorf) in beiden Richtungen, zwischen Weislingenstr. und Sch�nflie�er Str. Fahrbahnuntersp�lung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_009042',
       data  => <<EOF,
userdel	2::inwork 2985,25883 3045,26078 3112,26253 3124,26288
EOF
     },
     { from  => 1213480800, # 2008-06-15 00:00
       until => 1214863200, # 2008-07-01 00:00
       text  => 'B 112 Lebus - Manschnow OD Rathstock Erneuerung Durchlass Vollsperrung 16.06.2008-30.06.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 87942,14273
EOF
     },
     { from  => 1213480800, # 2008-06-15 00:00
       until => 1213999200, # 2008-06-21 00:00
       text  => 'B 188 Berliner Str. OD Rathenow, zw. Goethestr. und F.-Ebert-Ring Sanierung Fahrbahndecke halbseitig gesperrt; Einbahnstra�e 16.06.2008-20.06.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -61212,20700 -61627,20789 -62285,21020
EOF
     },
     { from  => 1212962400, # 2008-06-09 00:00
       until => 1229727600, # 2008-12-20 00:00
       text  => 'K 6425 Lindenallee OD Hoppegarten, zw. Kreisverkehr und An der Zoche Br�cken-, Stra�en-, Gehwegbau Vollsperrung 10.06.2008-19.12.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 28510,12507 28287,12471 27490,11678
EOF
     },
     { from  => 1215295200, # 2008-07-06 00:00
       until => 1220220000, # 2008-09-01 00:00
       text  => 'L 016 Br�cke �.d. A 10 zw. Perwenitz u. Paaren, sowie AS Falkensee Br�ckenbauarbeiten Vollsperrung 07.07.2008-31.08.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -17102,26468 -17545,26647
EOF
     },
     { from  => 1212876000, # 2008-06-08 00:00
       until => 1249077600, # 2009-08-01 00:00
       text  => 'L 030 Bahnhofstr. Eisenbahnbr�cke in der OD Erkner Br�ckenerneuerung Vollsperrung 09.06.2008-31.07.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 34326,2915 34142,2742
EOF
     },
     { from  => 1212962400, # 2008-06-09 00:00
       until => 1214085600, # 2008-06-22 00:00
       text  => 'L 033 Wriezen - Pr�tzel zw. Wriezen und Schulzendorf Deckenerneuerung Vollsperrung 10.06.2008-21.06.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 59114,34559 58750,34221
EOF
     },
     { from  => 1214085600, # 2008-06-22 00:00
       until => 1215640800, # 2008-07-10 00:00
       text  => 'L 037 M�llrose - B 5, Petershagen Bahn�bergang in der OD Jacobsdorf Gleisbauarbeiten Vollsperrung 23.06.2008-09.07.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 75272,-7514 75394,-6991 75402,-6910
EOF
     },
     { from  => 1213653600, # 2008-06-17 00:00
       until => 1215208800, # 2008-07-05 00:00
       text  => 'L 070 Herzberger Chaussee OD Dahme, zw. Mehlsdorfer Weg und OA Stra�enbauarbeiten Vollsperrung 18.06.2008-04.07.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 12928,-59868 12708,-60813
EOF
     },
     { from  => 1213567200, # 2008-06-16 00:00
       until => 1213912800, # 2008-06-20 00:00
       text  => 'L 145 B 103, Kolrep - Wittstock Bahn�bergang in der OD Blumenthal Gleisbauarbeiten Vollsperrung 17.06.2008-19.06.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -63533,72983 -63431,73201 -63417,73223 -63329,73307 -63286,73362
EOF
     },
     { from  => 1214690400, # 2008-06-29 00:00
       until => 1216936800, # 2008-07-25 00:00
       text  => 'L 338 Sch�neiche - H�now OD Neuenhagen, zw. B� und Eisenbahnstr. Stra�enbau Vollsperrung 30.06.2008-24.07.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 30795,13191 30179,13667
EOF
     },
     { from  => 1213826400, # 2008-06-19 00:00
       until => 1213999200, # 2008-06-21 00:00
       text  => 'L 601 Leipziger Str. OL Finsterwalde, Nr. 76-78 Grundsteinlegung Vollsperrung 20.06.2008-20.06.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 32865,-86269 32963,-85912
EOF
     },
     { from  => 1211925600, # 2008-05-28 00:00
       until => 1223321324, # 2008-12-20 00:00 1229727600
       text  => 'L 794 Ruhlsdorfer Str. OD Teltow. zw. Schenkendorfer Weg und Ruhlsdorfer Platz Kanalarbeiten Vollsperrung 29.05.2008-19.12.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 1335,-1472 1370,-1295
EOF
     },
     { from  => 1214257294, # 2008-06-23 23:41
       until => 1215208799, # 2008-07-04 23:59
       text  => 'Grumbkowstr. (Pankow) stadtausw�rts zwischen Blankenburger Str. und Buchholzer Str. Baustelle, Fahrtrichtung gesperrt (bis 04.07.)',
       type  => 'gesperrt',
       source_id => 'IM_009192',
       data  => <<EOF,
userdel	1::inwork 11563,20048 11419,20327 11269,20667
EOF
     },
     { from  => 1214257459, # 2008-06-23 23:44
       until => 1214430604, # 2008-07-02 23:59 1215035999, see below
       text  => 'Stra�e des 17. Juni (Tiergarten) in beiden Richtungen zwischen Gro�er Stern und Brandenburger Tor und Eberststr. zwischen Scheidemannstr. und Behrenstr. Veranstaltung, Stra�en vollst�ndig gesperrt (bis 02.07. 22 Uhr)',
       type  => 'handicap',
       source_id => 'IM_009181',
       data  => <<EOF,
userdel	q4::temp 6828,12031 7383,12095 7816,12150 8055,12186 8089,12190 8214,12205 8303,12216 8538,12245 8546,12279 8570,12302 8573,12325 8540,12420
userdel	q4::temp 8595,12066 8600,12165 8538,12245
userdel	q4::temp 8542,11502 8548,11571
EOF
     },
     { from  => 1215036000, # 2008-07-03 00:00
       until => 1215468000, # 2008-07-08 00:00
       text  => 'B 087 Herzberger Str. OD Schlieben, zw. Lindenstr. u. Abzw. Oelsig 415. Moienmarkt Vollsperrung 04.07.2008-07.07.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 10533,-76130 10891,-76066 11354,-75979
EOF
     },
     { from  => 1214430640, # 
       until => Time::Local::timelocal(reverse(2008-1900,7-1,2,22,0,0)), # 1214812800, # 2008-06-30 10:00
       text  => 'Fanmeile, Stra�e des 17. Juni gesperrt, bis 2.7.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8055,12186 8089,12190 8214,12205 8215,12156 8222,11881
userdel	2::temp 8214,12205 8303,12216 8538,12245 8522,12187
userdel	2::temp 7383,12095 7816,12150 8055,12186 8048,12135 8034,12093
userdel	2::temp 8538,12245 8522,12239 8466,12197 8215,12156 8107,12145 8048,12135 8018,12131 7827,12105 7777,12098 7460,12054
userdel	2::temp 8089,12041 8107,12145
userdel	2::temp 8595,12066 8600,12165 8538,12245 8546,12279 8570,12302 8573,12325 8540,12420
userdel auto	3 8546,12279 8538,12245 8600,12165
userdel auto	3 8546,12279 8538,12245 8610,12254
userdel auto	3 8600,12165 8538,12245 8546,12279
userdel auto	3 8600,12165 8538,12245 8610,12254
userdel auto	3 8610,12254 8538,12245 8546,12279
userdel auto	3 8610,12254 8538,12245 8600,12165
EOF
     },
     { from  => 1214517600, # 2008-06-27 00:00 # DO NOT REUSE DATA!
       until => 1214690399, # 2008-06-28 23:59
       text  => 'CSD am 28.6.2008',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8358,11477 8301,11469 8226,11458 8145,11438 8083,11381 8065,11349 8031,11249 8000,11137 7980,11070 7968,11048 7912,10945 7820,10768 7689,10514 7633,10394 7579,10183 7413,10244 7245,10297 7131,10331 7033,10328 6971,10346 6937,10363 6851,10416 6753,10446 6636,10492 6532,10529 6685,10690 6740,10755 6824,10904 6873,11011 6882,11061 6880,11110 6851,11346 6825,11486 6809,11570 6778,11742 6744,11936
userdel	2::temp 8553,11630 8548,11571 8542,11502 8479,11493 8374,11479
userdel	2::temp 9984,12426 9934,12420 9852,12409 9780,12401 9771,12400 9734,12395 9695,12390 9656,12386 9601,12380 9475,12365 9358,12351 9141,12320 9164,12172 9064,12156
userdel	2::temp 8553,11638 8567,11799 8571,11846 8577,11896 8595,12066 8737,12098 8743,12099 8861,12125 9054,12154
userdel auto	3 6972,10665 6818,10725 6740,10755 6607,10801
userdel auto	3 8901,12008 8861,12125 8804,12280
userdel auto	3 9183,12076 9164,12172 9373,12197
userdel auto	3 6540,11754 6778,11742 7073,11798
userdel auto	3 7281,10418 7245,10297 7215,10203
userdel auto	3 9489,12263 9475,12365 9462,12481
userdel auto	3 7534,10850 7820,10768 7963,10716
userdel auto	3 6681,10959 6824,10904 6918,10854
userdel auto	3 6980,11583 6809,11570 6524,11583
userdel auto	3 7215,10203 7245,10297 7281,10418
userdel auto	3 7963,10716 7820,10768 7534,10850
userdel auto	3 7828,11133 8000,11137 8102,11099
userdel auto	3 6732,11106 6873,11011 7002,11034
userdel auto	3 6607,10801 6740,10755 6818,10725 6972,10665
userdel auto	3 8596,11508 8542,11502 8573,11404
userdel auto	3 8596,11508 8542,11502 8442,11555
userdel auto	3 6692,11365 6851,11346 7103,11247 7160,11225
userdel auto	3 8573,11404 8542,11502 8442,11555
userdel auto	3 8573,11404 8542,11502 8596,11508
userdel auto	3 7478,10612 7689,10514 7849,10488
userdel auto	3 8442,11555 8542,11502 8573,11404
userdel auto	3 8442,11555 8542,11502 8596,11508
userdel auto	3 6524,11583 6809,11570 6980,11583
userdel auto	3 7429,10366 7413,10244 7384,10127
userdel auto	3 6719,10347 6753,10446 6745,10619
userdel auto	3 8172,11679 8226,11458 8232,11414
userdel auto	3 7444,10479 7633,10394 7744,10372
userdel auto	3 9028,12307 9141,12320 9130,12433
userdel auto	3 7744,10372 7633,10394 7444,10479
userdel auto	3 7293,11519 7171,11510 6915,11492 6825,11486 6716,11439
userdel auto	3 9869,12297 9852,12409 9842,12506
userdel auto	3 7849,10488 7689,10514 7478,10612
userdel auto	3 7160,11225 7103,11247 6851,11346 6692,11365
userdel auto	3 8102,11099 8000,11137 7828,11133
userdel auto	3 7073,11798 6778,11742 6540,11754
userdel auto	3 7539,9970 7579,10183 7698,10147
userdel auto	3 6745,10619 6753,10446 6719,10347
userdel auto	3 9373,12197 9164,12172 9183,12076
userdel auto	3 6468,10550 6532,10529 6494,10440
userdel auto	3 7747,11075 7980,11070 8104,11037 8205,10979
userdel auto	3 6918,10854 6824,10904 6681,10959
userdel auto	3 9462,12481 9475,12365 9489,12263
userdel auto	3 7115,11220 6880,11110 6841,11114
userdel auto	3 6841,11114 6880,11110 7115,11220
userdel auto	3 7698,10147 7579,10183 7539,9970
userdel auto	3 7384,10127 7413,10244 7429,10366
userdel auto	3 7003,10513 7033,10396 7245,10499 7291,10506
userdel auto	3 8232,11414 8226,11458 8172,11679
userdel auto	3 9369,12253 9358,12351 9343,12464
userdel auto	3 9842,12506 9852,12409 9869,12297
userdel auto	3 8205,10979 8104,11037 7980,11070 7747,11075
userdel auto	3 6494,10440 6532,10529 6468,10550
userdel auto	3 9343,12464 9358,12351 9369,12253
userdel auto	3 7002,11034 6873,11011 6732,11106
userdel auto	3 9130,12433 9141,12320 9028,12307
userdel auto	3 6716,11439 6825,11486 6915,11492 7171,11510 7293,11519
userdel auto	3 8804,12280 8861,12125 8901,12008
userdel auto	3 7291,10506 7245,10499 7033,10396 7003,10513
EOF
     },
     { from  => 1217625647, # 2008-08-01 23:20
       until => 1219879178, # 2008-09-01 23:59 1220306399 --- war vor Ort, es gibt nur eine "Gegenrichtung hat Vorrang"-Stelle
       text  => 'An der Spandauer Br�cke (Mitte) Richtung Spandauer Str. zwischen Rosenthaler Str. und Spandauer Str. Baustelle, Fahrtrichtung gesperrt, eine Umleitung ist eingerichtet (bis Anfang 09.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009262',
       data  => <<EOF,
userdel	1::inwork 10298,13076 10349,13043 10371,13006 10418,12922 10395,12908 10348,12879 10309,12854
EOF
     },
     { from  => 1215112739, # 
       until => 1215112742, #
       text  => 'Tempelhofer Damm (Tempelhof) stadtausw�rts zwischen AS Tempelhofer Damm und Ringbahnstr. Stra�ensch�den, Fahrtrichtung gesperrt, Radfahrer k�nnen unter Umst�nden passieren',
       type  => 'handicap',
       source_id => 'IM_009276',
       data  => <<EOF,
userdel	q4::inwork; 9242,7145 9242,7044 9242,6962
EOF
     },
     { from  => 1216159200, # 2008-07-16 00:00
       until => 1216850400, # 2008-07-24 00:00
       text  => 'B 101 Weststr. OD Elsterwerda, zw. Thiemigstr. und Netto Umverlegung Versorgungsleit. Vollsperrung 17.07.2008-23.07.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 20504,-105143 20635,-105714
EOF
     },
     { from  => 1215900000, # 2008-07-13 00:00
       until => 1219442400, # 2008-08-23 00:00
       text  => 'K 6160 Chausseestr. OD Wildau, zw. KVK und Am Kleingewerbegebiet Bau Kreisverkehr halbseitig gesperrt; Einbahnstra�e 14.07.2008-22.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 25140,-9125 24478,-9578
EOF
     },
     { from  => 1216332000, # 2008-07-18 00:00
       until => 1216591200, # 2008-07-21 00:00
       text  => 'L 060 Langennaundorf - Falkenberg OD Uebigau, Marktbereich Historische Nacht Vollsperrung 19.07.2008-20.07.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 5148,-90524 5358,-90502 5798,-90075
EOF
     },
     { from  => 1215067855, # 2008-07-03 08:50
       until => 1215208800, # 2008-07-05 00:00
       text  => 'Er�ffnung der US-Botschaft am Pariser Platz; Sperrungen rund um das Brandenburger Tor (4.7.2008) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8546,12279 8538,12245 8303,12216 8214,12205 8089,12190
userdel	2::temp 8610,12254 8538,12245 8600,12165 8595,12066 8737,12098 8743,12099 8861,12125
EOF
     },
     { from  => 1215900000, # 2008-07-13 00:00
       until => 1238194800, # 2009-03-28 00:00
       text  => 'B 002 Wittenberg - LG - Treuenbrietzen OD Marzahna Kanal- und Stra�enbau Vollsperrung 14.07.2008-27.03.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -31201,-45781 -30976,-45652
EOF
     },
     { from  => 1215554400, # 2008-07-09 00:00
       until => 1215727200, # 2008-07-11 00:00
       text  => 'L 051 Burg - Straupitz zw. Byhleguhre und Burg Montage von Br�ckenelementen Vollsperrung 10.07.2008-10.07.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 62695,-60612 63083,-59893
EOF
     },
     { from  => 1215900000, # 2008-07-13 00:00
       until => 1238194800, # 2009-03-28 00:00
       text  => 'L 082 Marzahna - Zeuden OD Marzahna Kanal- und Stra�enbau Vollsperrung 14.07.2008-27.03.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -32661,-44144 -31201,-45781
EOF
     },
     { from  => 1230475253, # 2008-12-17 00:00 1229468400
       until => 1230475258, # 2009-05-01 00:00 1241128800
       text  => 'L 141 Breddin - K�mmernitz OD Breddin Stra�enneubau Wintersicherung 18.12.2008-30.04.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -70100,51862 -70753,51862 -70922,51604
EOF
     },
     { from  => 1216405440, # 2008-07-18 20:24
       until => 1217625988, # 2008-08-01 23:59 1217627999
       text  => 'Heinrich-Mann-Str. (Pankow) in Richtung Kreuzstr. zwischen Hermann-Hesse-Str. und Heinrich-Mann-Platz Baustelle, Fahrtrichtung gesperrt (bis Anfang 08.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009340',
       data  => <<EOF,
userdel	1::inwork 9279,18724 9366,18669 9457,18612
EOF
     },
     { from  => 1216159200, # 2008-07-16 00:00
       until => 1219880595, # 2008-08-31 00:00 1220133600
       text  => 'L 793 Sch�nhagen - Ludwigsfelde Br�cke �ber den Faulen Graben bei Blankensee Br�ckenneubau Vollsperrung 17.07.2008-30.08.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -7219,-19011 -7172,-19223
EOF
     },
     { from  => 1215900000, # 2008-07-13 00:00
       until => 1221343200, # 2008-09-14 00:00
       text  => 'B 320 Lieberose - Lamsfeld OD Lamsfeld Grundhafter Ausbau Vollsperrung 14.07.2008-13.09.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 66964,-46059 67237,-46233
EOF
     },
     { from  => 1216504800, # 2008-07-20 00:00
       until => 1217628000, # 2008-08-02 00:00
       text  => 'L 014 Kyritz - Wittstock Br�cke �ber die A 24 zw. Herzsprung und Wittstock Br�ckenteilsanierung Vollsperrung 21.07.2008-01.08.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -53403,76884 -53483,76327
EOF
     },
     { from  => 1216159200, # 2008-07-16 00:00
       until => 1219523960, # 2008-08-29 00:00 1219960800
       text  => 'L 064 Riesaer Str. OD Bad Liebenwerda, zw. Baumschulenweg u. S�dring Neubau Durchlass Vollsperrung 17.07.2008-28.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 11862,-99775 11974,-99110
EOF
     },
     { from  => 1218837600, # 2008-08-16 00:00
       until => 1230764400, # 2009-01-01 00:00
       text  => 'L 029 Lanke - Zehlendorf n�rdl. Wandlitz, ab B109 in Ri. Stolzenhagen Bau Kreisverkehr Vollsperrung 17.08.2008-31.12.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 15403,40364 14698,40345
EOF
     },
     { from  => 1216674352, # 2008-07-21 23:05
       until => 1216839957, # 2008-07-31 23:59 1217541599
       text  => 'Freiheit (Spandau) stadtausw�rts zwischen Kl�rwerkstr. und Am Schlangengraben Baustelle, Fahrtrichtung gesperrt (bis Ende 07.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009378',
       data  => <<EOF,
userdel	1::inwork -1258,13552 -2410,13746
EOF
     },
     { from  => 1215295200, # 2008-07-06 00:00
       until => 1218232800, # 2008-08-09 00:00
       text  => 'B 002 zw. Bernau und Stadtgrenze Berlin Deckenerneuerung, Radwegbau Richtungsverkehr 07.07.2008-08.08.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 19658,24589 19602,24153 19565,24028 19393,23690
EOF
     },
     { from  => 1216321760, # 
       until => 1216321765, #
       text  => 'Bereich Mecklenburgische Str. (Wilmersdorf) Rund um den Volkspark Bombenfund, Bereich vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_009394',
       data  => <<EOF,
userdel	2::inwork 4280,8188 4325,8229 4423,8315 4473,8351 4623,8457 4783,8557
userdel	2::inwork 4772,8599 4456,8598
userdel	2::inwork 4473,8351 4457,8372 4457,8484
EOF
     },
     { from  => 1218739579, # 
       until => 1218739581, #
       text  => 'Swinem�nder Br�cke (Wedding) in beiden Richtungen Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_009388',
       data  => <<EOF,
userdel	2::temp 9494,15998 9623,15777 9646,15737
EOF
     },
     { from  => 1220035493, # 2008-08-29 20:44
       until => 1220306399, # 2008-09-01 23:59
       text  => 'Friedrich-Karl-Str., Ordensmeisterstr. (Tempelhof) in beiden Richtungen zwischen Ottokarstr. und Wenckebachstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Anfang 09.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009406',
       data  => <<EOF,
userdel	2::inwork 9368,5608 9147,5534 8955,5549 8870,5557 8767,5571
EOF
     },
     { from  => 1216504800, # 2008-07-20 00:00
       until => 1218232800, # 2008-08-09 00:00
       text  => 'B 087 Luckauer Str. OD Schlieben, Durchlass Instandsetzungsarb. Vollsperrung 21.07.2008-08.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 11880,-76020 11354,-75979 10891,-76066
EOF
     },
     { from  => 1216159200, # 2008-07-16 00:00
       until => 1220133600, # 2008-08-31 00:00
       text  => 'K 6518 Liebenberg - Bergsdorf OD Liebenberg, zw. B167 und OA Kanal- und Stra�enbau Vollsperrung 17.07.2008-30.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -386,54165 -588,54317 -667,54494
EOF
     },
     { from  => 1216159200, # 2008-07-16 00:00
       until => 1220133600, # 2008-08-31 00:00
       text  => 'K 7221 Bahnhofstr. Br�cke �ber Kreuzfeldgraben in der OD Woltersdorf Br�ckenneubau Vollsperrung 17.07.2008-30.08.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -2854,-32632 -2701,-32785
EOF
     },
     { from  => 1219879480, # undef
       until => 1219879485, # undef
       text  => 'Stendaler Str. (Hellersdorf) stadteinw�rts zwischen Janusz-Korczak-Str. und Hellersdorfer Str. Veranstaltung, Fahrtrichtung gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_009398',
       data  => <<EOF,
userdel	1::temp 23960,15021 23993,14797
EOF
     },
     { from  => 1216504800, # 2008-07-20 00:00
       until => 1229727600, # 2008-12-20 00:00
       text  => 'B 102 Umgehungsstr. Br�cke �ber die Nieplitz in der OD Treuenbrietzen Br�ckenneubau Vollsperrung 21.07.2008-19.12.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -25419,-35417 -24932,-35664
EOF
     },
     { from  => 1216504800, # 2008-07-20 00:00
       until => 1220037184, # 2008-11-01 00:00 1225494000
       text  => 'L 016 Fehrbellin - AS Neuruppin Br�cke �ber den Schleusengraben zw. Fehrbellin u. Dammkrug Br�ckenbauarbeiten Vollsperrung 21.07.2008-31.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -32778,47235 -33506,45278
EOF
     },
     { from  => 1216504800, # 2008-07-20 00:00
       until => 1222812000, # 2008-10-01 00:00
       text  => 'L 243 Wegguner Str. OD Boitzenburg, zw. Goethestr. und Puschkinstr. Kanal- und Stra�enbau Vollsperrung 21.07.2008-30.09.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 22455,95876 22471,95721
EOF
     },
     { from  => 1216495649, # 2008-07-19 21:27
       until => 1216677600, # 2008-07-22 00:00
       text  => 'Bellevuestr. (K�penick) in beiden Richtungen zwischen Seelenbinderstr. und F�rstenwalder Damm Baustelle, Stra�e vollst�ndig gesperrt (bis 21.07.08)',
       type  => 'gesperrt',
       source_id => 'IM_009421',
       data  => <<EOF,
userdel	2::inwork 23402,5483 23333,5710
EOF
     },
     { from  => 1216461600, # 2008-07-19 12:00
       until => 1216584000, # 2008-07-20 22:00
       text  => 'Stra�e des 17. Juni, John-Foster-Dulles-Allee und andere Stra�en im Regierungsviertel am Sonntag von 12 bis 22 Uhr gesperrt (Feierliches Gel�bnis der Bundeswehr)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8417,12846 8503,12895
userdel	2::temp 7936,12906 8017,12826
userdel	2::temp 8737,12757 8596,12760 8545,12760
userdel	2::temp 7514,12387 7627,12380 7821,12367 7875,12363 8017,12359 8070,12409 8119,12414
userdel	2::temp 8514,12877 8545,12760
userdel	2::temp 8775,12457 8540,12420 8573,12325 8570,12302 8546,12279 8538,12245 8303,12216 8214,12205 8089,12190 8055,12186 7816,12150 7383,12095 6828,12031
userdel	2::temp 8595,12066 8600,12165 8538,12245
EOF
     },
     { from  => 1217625690, # 2008-08-01 23:21
       until => 1220473350, # 1217887200, # 2008-08-05 00:00 Time::Local::timelocal(reverse(2008-1900,9-1,15,0,0,0))
       text  => 'Greifswalder Str. (Prenzlauer Berg) stadteinw�rts zwischen Ostseestr. und Erich-Weinert-Str. Baustelle, Fahrtrichtung gesperrt (bis Mitte September 2009)',
       type  => 'gesperrt',
       source_id => 'IM_009449',
       data  => <<EOF,
userdel	1::inwork 13072,15590 12966,15478 12870,15342
EOF
     },
     { from  => 1216591200, # 2008-07-21 00:00
       until => 1220133600, # 2008-08-31 00:00
       text  => 'B 115 Baruth - J�terbog OD Baruth, Kreisverkehr Sanierungsarbeiten Vollsperrung 22.07.2008-30.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 18138,-39957 18103,-40046 18129,-40122 18110,-40310
EOF
     },
     { from  => 1216755974, # 2008-07-22 21:46
       until => 1219878814, # 2008-08-31 23:59 1220219999
       text  => 'Am Friedrichshain (Friedrichshain) Richtung Greifswalder Str. zwischen Einm�ndung Am Friedrichshain und Friedenstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 08.2008)',
       type  => 'handicap',
       source_id => 'IM_009457',
       data  => <<EOF,
userdel	q4::inwork; 11785,13625 11762,13619 11706,13635
EOF
     },
     { from  => undef, # 
       until => 1216958400, # 2008-07-25 06:00
       text  => 'Stra�e des 17. Juni (Tiergarten) und Gro�er Stern Veranstaltung, gesperrt (bis 25.07.2008 6 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_009465',
       data  => <<EOF,
userdel	2::temp 6787,12099 6754,12108 6725,12113 6690,12104 6653,12067
userdel	2::temp 6178,12387 6348,12272 6653,12067 6642,12010 5900,11913
userdel	2::temp 6642,12010 6685,11954 6744,11936 6809,11979 6828,12031 7383,12095 7816,12150 8055,12186 8089,12190 8214,12205 8303,12216 8538,12245
userdel	2::temp 6744,11936 6778,11742
userdel	2::temp 6828,12031 6787,12099 7039,12314
userdel auto	3 8048,12135 8055,12186 8119,12414
userdel auto	3 8119,12414 8055,12186 8048,12135
userdel auto	3 7460,12054 7383,12095 7039,12314
userdel auto	3 7039,12314 7383,12095 7460,12054
EOF
     },
     { from  => 1216159200, # 2008-07-16 00:00
       until => 1229900400, # 2008-12-22 00:00
       text  => 'L 172 Velten -Germendorf Kreuzung bei B�renklau-Leegebruch Neubau Kreisverkehr Vollsperrung 17.07.2008-21.12.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -5375,35118 -5373,35134
EOF
     },
     { from  => 1216764000, # 2008-07-23 00:00
       until => 1217455200, # 2008-07-31 00:00
       text  => 'L 338 Sch�neiche - H�now OD Neuenhagen, zw. B� und Jahnstr. Deckeneinbau, Restarb. Vollsperrung 24.07.2008-30.07.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 30815,13170 30795,13191 30179,13667
EOF
     },
     { from  => 1216936800, # 2008-07-25 00:00
       until => 1217628000, # 2008-08-02 00:00
       text  => 'L 283 Parstein - B 2, Schmargendorf Bahn�bergang Herzsprung Gleisbauarbeiten Vollsperrung 26.07.2008-01.08.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 49004,64047 48516,64085 48151,64245
EOF
     },
     { from  => 1217625788, # 2008-08-01 23:23
       until => 1222811999, # 2008-09-30 23:59
       text  => 'Glinkastr. (Mitte) in Richtung Leipziger Str. zwischen Behrenstr. und J�gerstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 09.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009501',
       data  => <<EOF,
userdel	1::inwork 9164,12172 9183,12076 9201,11968
EOF
     },
     { from  => 1312513200, # zweiter Termin im Jahr (August oder September)
       until => 1312754400,
       text  => 'M�llerstr. (Wedding) in beiden Richtungen zwischen Leopoldplatz und Seestr. Veranstaltung, Stra�e vollst�ndig gesperrt (5. bis 7. August 2011)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 6781,16026 6914,15908 6936,15888 7043,15793 7129,15717 7198,15656 7277,15586
EOF
     },
     { from  => 1217625939, # 2008-08-01 23:25
       until => 1217880000, # 2008-08-04 22:00
       text  => 'Str. d. Pariser Kommune und Lebuser Str. in beiden Richtungen zwischen Weidenweg, bzw. Neue Weberstr. und Karl-Marx-Allee Veranstaltung, Stra�e vollst�ndig gesperrt (bis 04.08.08, 22 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_009533',
       data  => <<EOF,
userdel	2::temp 12360,12505 12362,12540 12364,12589
userdel	2::temp 12891,12549 12869,12425
EOF
     },
     { from  => 1217880521,
       until => Time::Local::timelocal(reverse(2008-1900,12-1,31,23,59,59)),
       text  => 'Baut�tigkeit bis Ende 2008, daher Einbahnstra�e vom Sterndamm in Richtung Haeckelstr.',
       type  => 'gesperrt',
       data  => <<EOF,
	1 17379,3932 17346,4031 17341,4046 17297,4159 17261,4267
EOF
     },
     { from  => 1218264643, # 2008-08-09 08:50
       until => 1218420000, # 2008-08-11 04:00
       text  => 'Spandauer-Damm-Br�cke Baustelle, unter Umst�nden vollst�ndig gesperrt (bis 11.08.08, 4 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_009598',
       data  => <<EOF,
userdel	2::inwork 2152,12389 2193,12393
EOF
     },
     { from  => 1218578400, # 2008-08-13 00:00
       until => 1219096800, # 2008-08-19 00:00
       text  => 'B 087 M�llroser Chaussee zw. Br�cke A 12 und Siedlung Markendorf Deckenerneuerung Vollsperrung 14.08.2008-18.08.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 84677,-9063 85598,-8331
EOF
     },
     { from  => 1218146400, # 2008-08-08 00:00
       until => 1218405600, # 2008-08-11 00:00
       text  => 'B 101 OD Elsterwerda, zw. Bahnunterf�hr.u. Berliner Str. Deckeneinbau Vollsperrung 09.08.2008-10.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 18928,-103699 18887,-104083
EOF
     },
     { from  => 1218232800, # 2008-08-09 00:00
       until => 1218405600, # 2008-08-11 00:00
       text  => 'B 168 OD Peitz, zw. Kreisverkehr und Spreewaldstr. 55. Fischerfest Vollsperrung 10.08.2008-10.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 80426,-59644 80046,-59594
EOF
     },
     { from  => 1218319200, # 2008-08-10 00:00
       until => 1220306400, # 2008-09-02 00:00
       text  => 'B 273 Bernauer Str., Schlo�platz OD Oranienburg Deckeneinbau Vollsperrung 11.08.2008-01.09.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -1553,38501 -1515,38500 -1487,38509
EOF
     },
     { from  => 1218924000, # 2008-08-17 00:00
       until => 1225494000, # 2008-11-01 00:00
       text  => 'L 031 Prenden - Zerpenschleuse Graben zw. Abzw. Marienwerder und Zerpenschleuse Br�ckenneubau Vollsperrung 18.08.2008-31.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 20048,48519 20965,48351
EOF
     },
     { from  => 1218319200, # 2008-08-10 00:00
       until => 1220652000, # 2008-09-06 00:00
       text  => 'L 033 Strausberg - Berlin zw. AS Berlin-Marzahn und Abzw. Neuenhagen Deckenerneuerung Vollsperrung 11.08.2008-05.09.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 28569,16324 27328,15740
EOF
     },
     { from  => 1218319200, # 2008-08-10 00:00
       until => 1230073200, # 2008-12-24 00:00
       text  => 'L 216 Gollin - Templin OD Vietmannsdorf, zw. Golliner Str. und OA Ri. Templin Br�cken- und Stra�enbau Vollsperrung 11.08.2008-23.12.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 17625,72041 17470,72358 17199,72738
EOF
     },
     { from  => 1218319200, # 2008-08-10 00:00
       until => 1219701600, # 2008-08-26 00:00
       text  => 'L 362 M�ncheberg - Wulkow OL Wulkow Instandsetzung Durchlass Vollsperrung 11.08.2008-25.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 66171,19651 66523,19497
EOF
     },
     { from  => 1219788000, # 2008-08-27 00:00
       until => 1220306400, # 2008-09-02 00:00
       text  => 'L 601 Berliner Str. OL Finsterwalde, zw. B 96 Bahnhofstr. und Str. der Jugend S�ngerfest Vollsperrung 28.08.2008-01.09.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 33060,-85292 33103,-85728
EOF
     },
     { from  => 1218739674, # 2008-08-14 20:47
       until => 1219523306, # 2008-08-31 23:59 1220219999
       text  => 'Alt-Buckow (Neuk�lln) Richtung Marienfelde zwischen Buckower Damm und Rufacher Weg Baustelle, Fahrtrichtung gesperrt (bis Ende 08.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009621',
       data  => <<EOF,
userdel	1::inwork 12817,2031 12574,1866 12547,1852 12452,1808 12207,1704
EOF
     },
     { from  => 1218578400, # 2008-08-13 00:00
       until => 1220133600, # 2008-08-31 00:00
       text  => 'B 246 Belzig - Wiesenburg OD Klein Glien Stra�enbau Vollsperrung 14.08.2008-30.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -48903,-31556 -49841,-31648
EOF
     },
     { from  => 1218924000, # 2008-08-17 00:00
       until => 1246399200, # 2009-07-01 00:00
       text  => 'B 273 A 11 - Wandlitz zw. Abzw. Bernau und Wandlitz R�ckau u. Erneuerung B273 Vollsperrung 18.08.2008-30.06.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 16953,35907 16653,35993 16132,36512 15491,37176 15387,37252 15201,37349 14948,37315 14703,37197 14470,37191 13546,37474
EOF
     },
     { from  => 1218924000, # 2008-08-17 00:00
       until => 1219523934, # 2008-08-27 00:00 1219788000
       text  => 'L 033 Strausberg - Berlin zw. AS Berlin-Marzahn und H�now, Mahlsdorfer Str. Deckenerneuerung Vollsperrung 18.08.2008-26.08.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 27328,15740 26908,15630 26538,15523 26333,15481
EOF
     },
     { from  => 1219183200, # 2008-08-20 00:00
       until => 1226268554, # 2008-12-01 00:00 1228086000
       text  => 'L 035 B246 Glienicke - Bad Saarow zw. Diensdorf und Pieskow Stra�enbauarbeiten Vollsperrung 21.08.2008-30.11.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 56312,-16543 56600,-15729 56485,-15230 56404,-14881
EOF
     },
     { from  => 1219523350, # 2008-08-23 22:29
       until => 1220219999, # 2008-08-31 23:59
       text  => 'Glienicker Weg (K�penick) in beiden Richtungen zwischen Spindlersfelder Str. und Zinsgutstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 08.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009456',
       data  => <<EOF,
userdel	2::inwork 21153,3484 21198,3522 21244,3571 21275,3607 21308,3644 21324,3691
EOF
     },
     { from  => 1219523390, # 2008-08-23 22:29
       until => 1219629600, # 2008-08-25 04:00
       text  => 'Berliner Str. (Pankow) in beiden Richtungen zwischen Florastr. und Granitzstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 25.08., 04 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_009756',
       data  => <<EOF,
userdel	2::inwork 10830,17985 10849,17848
EOF
     },
     { from  => 1219523435, # 2008-08-23 22:30
       until => 1219615199, # 2008-08-24 23:59
       text  => 'Hildebrandtstr. (Tiergarten) in beiden Richtungen zwischen Tiergartenstr. und Reichpietschufer Veranstaltung, Stra�e vollst�ndig gesperrt (bis 24.08., 21 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_009744',
       data  => <<EOF,
userdel	2::temp 7322,11177 7435,11514
EOF
     },
     { from  => 1219879749, # undef
       until => 1219879753, # undef
       text  => 'Johannisstr. (Mitte) in beiden Richtungen zwischen Friedrichstr. und Kalkscheunenstr. Veranstaltung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_009757',
       data  => <<EOF,
userdel	2::temp 9385,13174 9250,13163
EOF
     },
     { from  => 1219523521, # 2008-08-23 22:32
       until => 1219879770, # 2008-08-31 23:59 1220219999
       text  => 'Kreuznacher Str. (Wilmersdorf) in beiden Richtungen zwischen Schildhornstr. und Bonner Str. Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 08.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009721',
       data  => <<EOF,
userdel	2::inwork 4146,6693 4226,6712 4309,6709 4369,6708
EOF
     },
     { from  => 1219523565, # 2008-08-23 22:32
       until => 1219640400, # 2008-08-25 07:00
       text  => 'Schwarzer Weg (Mitte) in beiden Richtungen zwischen Habersaathstr. und Invalidenstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 25.08., 7 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_009745',
       data  => <<EOF,
userdel	2::temp 8574,13666 8426,13909
EOF
     },
     { from  => 1219879557, # 2008-08-28 01:25
       until => 1220219999, # 2008-08-31 23:59
       text  => 'Wichertstr. (Prenzlauer Berg) in Richtung Prenzlauer Allee zwischen Stahlheimer Str. und Prenzlauer Allee Baustelle, Fahrtrichtung gesperrt (bis Ende 08.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009715',
       data  => <<EOF,
userdel	1::inwork 11455,15916 11567,15842 11736,15727 11941,15586
EOF
     },
     { from  => 1219879654, # 2008-08-28 01:27
       until => 1222022573, # 2008-09-30 23:59 1222811999
       text  => 'Suermondtstr. (Hohensch�nhausen) Richtung Hauptstr. zwischen Degnerstr. und Konrad-Wolff-Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 09.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009790',
       data  => <<EOF,
userdel	1::inwork 16660,16165 16961,16042
EOF
     },
     { from  => 1247724607, # 2009-07-16 08:10
       until => 1251755999, # 2009-08-31 23:59
       text  => 'Wendenschlo�str. (K�penick) in beiden Richtungen zwischen Landj�gerstr. und Salvador-Allende-Str. Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 08.2009)',
       type  => 'handicap',
       source_id => 'IM_009763',
       data  => <<EOF,
userdel	q4::inwork 22740,4415 22759,4430 22791,4457 22832,4491 22862,4511 22893,4532 22959,4576 23055,4640 23363,4846 23451,4877
EOF
     },
     { from  => 1219528800, # 2008-08-24 00:00
       until => 1220220000, # 2008-09-01 00:00
       text  => 'L 054 Bahnhofstra�e OL Vetschau, Bahn�bergang Gleisarbeiten Vollsperrung 25.08.2008-31.08.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 58183,-67564 58018,-67843
EOF
     },
     { from  => 1219874400, # 2008-08-28 00:00
       until => 1220133600, # 2008-08-31 00:00
       text  => 'B 158 Berliner Str. OD Leuenberg Einbau Deckschicht Vollsperrung 29.08.2008-30.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 42781,33687 43093,33781
EOF
     },
     { from  => undef, # 2008-09-07 00:00 1220738400
       until => 1220474077, # 2008-09-23 00:00 1222120800
       text  => 'K 6917 K.-Marx-/F.-Engelsstra�e OL Borkheide Bahn�bergang zw. Birkenhain u. Str.d. Frieden Bauarbeiten am Gleisk�rper Vollsperrung 08.09.2008-22.09.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -26249,-20121 -26258,-20094 -26809,-18383
EOF
     },
     { from  => 1222552800, # 2008-09-28 00:00
       until => 1228086000, # 2008-12-01 00:00
       text  => 'L 373 B112 - M�llrose OL Bri.-Finkenheerd ab KP Bhf-/Sonnenburgstr., 500m Ri. OA Kanal- und Stra�enbau Vollsperrung 29.09.2008-30.11.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 89098,-16962 89237,-16878 89435,-16834 90073,-16502 90164,-16382
EOF
     },
     { from  => 1220035590, # 2008-08-29 20:46
       until => 1220220000, # 2008-09-01 00:00
       text  => 'Turmstra�e (Wedding) in beiden Richtungen, zwischen Stromstra�e und Waldstr. Veranstaltung, Stra�e gesperrt (bis 1.9.2008, 0.00 Uhr) ',
       type  => 'gesperrt',
       source_id => 'IM_009776',
       data  => <<EOF,
userdel	2::temp 6228,13324 6115,13328 6105,13328 6011,13330 5956,13330 5857,13342 5705,13359 5569,13381 5560,13382 5368,13406
EOF
     },
     { from  => 1219874400, # 2008-08-28 00:00
       until => 1220220000, # 2008-09-01 00:00
       text  => 'B 101 OD Elsterwerda, zw. Bahnunterf�hr.u. Heidaer Str.. Deckenerneuerung Vollsperrung 29.08.2008-31.08.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 19074,-103082 18928,-103699 18887,-104083
EOF
     },
     { from  => 1219788000, # 2008-08-27 00:00
       until => 1224108000, # 2008-10-16 00:00
       text  => 'L 435 Oelsen - Grunow (B246) zw. OA Oelsen u. Krzg. Lindenstra�e i.d. OL Grunow Grundhafter Ausbau Vollsperrung 28.08.2008-15.10.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 77489,-28251 77555,-28060 78085,-27152
EOF
     },
     { from  => 1220473304, # 2008-09-03 22:21
       until => 1222811999, # 2008-09-30 23:59
       text  => 'Schlichtallee (Lichtenberg) in beiden Richtungen zwischen Hauptstr. und Zobtener Str. Br�ckenbau, Stra�e vollst�ndig gesperrt (bis Ende 09.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009784',
       data  => <<EOF,
userdel	2::inwork 15758,10578 15639,10469
EOF
     },
     { from  => 1220565600, # 2008-09-05 00:00
       until => 1220824800, # 2008-09-08 00:00
       text  => 'B 101 Lauchhammerstr. OD Elsterwerda, zw. Ackerstr. und Elsterstr. Historische Einkaufsnacht Vollsperrung 06.09.2008-07.09.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 21106,-104865 20827,-105106 20890,-105457
EOF
     },
     { from  => 1220133600, # 2008-08-31 00:00
       until => 1230073200, # 2008-12-24 00:00
       text  => 'B 109 August-Bebel-Str. OD Templin, zw. R.-Koch-Str. und Prenzlauer Allee Grundhafter Stra�enausbau Vollsperrung 01.09.2008-23.12.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 16331,79764 16200,79437 16116,79398 15887,79291
EOF
     },
     { from  => 1219528800, # 2008-08-24 00:00
       until => 1230764400, # 2009-01-01 00:00
       text  => 'L 023 Ringenwalde - Milmersdorf OD G�tschendorf Grundh.Stra�enausbau Vollsperrung 25.08.2008-31.12.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 28003,76731 27309,76652 26735,76914
EOF
     },
     { from  => 1220565600, # 2008-09-05 00:00
       until => 1220738400, # 2008-09-07 00:00
       text  => 'L 029 Berliner Stra�e OL Oderberg in/aus Richtg. Liepe, H�he Hausnr. 51-55 Kanalarbeiten Vollsperrung 06.09.2008-06.09.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 52671,51846 53187,51918
EOF
     },
     { from  => 1219874400, # 2008-08-28 00:00
       until => 1221516000, # 2008-09-16 00:00
       text  => 'L 059 Wainsdorf - Pr�sen zw. OA Wainsdorf und OE Pr�sen Deckenerneuerung Vollsperrung 29.08.2008-15.09.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 16901,-110215 17717,-110344 19244,-110623
EOF
     },
     { from  => 1220565600, # 2008-09-05 00:00
       until => 1220824800, # 2008-09-08 00:00
       text  => 'L 071 OD Sch�newalde, zw. Wei�ener Str. und Gartenstr. 850 - Jahrfeier Vollsperrung 06.09.2008-07.09.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 60,-66035 -575,-65978
EOF
     },
     { from  => 1221775200, # 2008-09-19 00:00
       until => 1226790000, # 2008-11-16 00:00
       text  => 'L 073 Neue Beelitzer Str. OL Luckenwalde, zw. Bahnhofstr. und Beelitzer Tor Stra�enausbau Vollsperrung 20.09.2008-15.11.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -4725,-34957 -5019,-34814
EOF
     },
     { from  => 1220392800, # 2008-09-03 00:00
       until => 1221170400, # 2008-09-12 00:00
       text  => 'L 220 AS Finowfurt - Joachimsthal zw. der B167 und der OL Eichhorst Deckenerneuerung Vollsperrung 04.09.2008-11.09.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 25488,54151 25401,53587 25395,53549 25347,53338 25368,53125 25393,52762 25556,52375 26351,50634
EOF
     },
     { from  => 1221084000, # 2008-09-11 00:00
       until => 1221429600, # 2008-09-15 00:00
       text  => 'L 793 Alfred-K�hne-Str. zw. OA Ludwigsfelde und Am Birkengrund Deckeninstandsetzung Vollsperrung 12.09.2008-14.09.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 2423,-11316 2580,-11069 2629,-10301
EOF
     },
     { from  => 1221076110, # 2008-09-10 21:48
       until => 1222811999, # 2008-09-30 23:59
       text  => 'Ewaldstr. (Treptow) in beiden Richtungen zwischen Bohnsdorfer Weg und Rebenweg geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt (bis Ende 09.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009890',
       data  => <<EOF,
userdel	2::inwork 20673,-31 20590,-120 20519,-198
userdel	2::inwork 20688,-10 20686,57 20684,105 20719,140
userdel	2::inwork 20161,-487 20300,-416 20348,-380 20476,-279 20505,-217
EOF
     },
     { from  => 1217714400, # 2008-08-03 00:00
       until => 1221170400, # 2008-09-12 00:00
       text  => 'B 246 zw. Eisenh�ttenstadt und F�nfeichen Deckenerneuerung Vollsperrung 04.08.2008-11.09.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 92608,-26929 91443,-26741 90867,-27074
EOF
     },
     { from  => 1222639200, # 2008-09-29 00:00
       until => 1223589600, # 2008-10-10 00:00
       text  => 'B 158 Neuenhagen - B158 A Kreuzung B158/ B158A Altglietzen/ L 28 Gabow Stra�enbauarb., Radweg, LSA Vollsperrung 30.09.2008-09.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 54862,47561 54012,46907
EOF
     },
     { from  => 1221775200, # 2008-09-19 00:00
       until => 1221948000, # 2008-09-21 00:00
       text  => 'B 179 zw. Neu L�bbenau und Leibsch Deckenerneinbau Vollsperrung 20.09.2008-20.09.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 43537,-35512 43650,-35762 43875,-35850 44731,-35697
EOF
     },
     { from  => 1220738400, # 2008-09-07 00:00
       until => 1222898400, # 2008-10-02 00:00
       text  => 'B 198 Angerm�nde - Greiffenberg zw. OA Kerkow und Abzw. Bruchhagen Deckschichterneuerung Vollsperrung 08.09.2008-01.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 46704,75833 46875,75023 47223,73677 47297,73550 47908,73136 48164,72815 48951,71593
EOF
     },
     { from  => 1221948000, # 2008-09-21 00:00
       until => 1222812000, # 2008-10-01 00:00
       text  => 'L 028 Neureetz - B158 Kreuzung bei Gabow/ B158/B158A Stra�enbauarb., Radweg, LSA Vollsperrung 22.09.2008-30.09.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 54862,47561 55048,47057
EOF
     },
     { from  => 1221343200, # 2008-09-14 00:00
       until => 1229122800, # 2008-12-13 00:00
       text  => 'L 232 Lichtenow - Rehfelde Br�cke �ber das Zinndorfer M�hlenflie� bei Werder Br�ckenerneuerung Vollsperrung 15.09.2008-12.12.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 46163,13586 46017,13884
EOF
     },
     { from  => 1220738400, # 2008-09-07 00:00
       until => 1225148400, # 2008-10-28 00:00
       text  => 'L 702 zw. Werenzhain und D�brichen Deckenernuerung Vollsperrung 08.09.2008-27.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 20497,-83501 20193,-83398 19068,-82695 17319,-82108
EOF
     },
     { from  => 1222034400, # 2008-09-22 00:00
       until => 1222466400, # 2008-09-27 00:00
       text  => 'K 6425 Wiesenstr. OL Hoppegarten, Einm. Neuer H�nower Weg Deckenerneuerung Vollsperrung 23.09.2008-26.09.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 27272,11970 27490,11678
EOF
     },
     { from  => 1221343200, # 2008-09-14 00:00
       until => 1225407600, # 2008-10-31 00:00
       text  => 'L 050 Gubener Str. OD Peitz, zw. Malxebogen und A.-Bebel-Str. Instandsetz.Durchlass, Entw�. Vollsperrung 15.09.2008-30.10.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 80426,-59644 80719,-59219
EOF
     },
     { from  => 1221681660, # 2008-09-17 22:01
       until => 1225493999, # 2008-10-31 23:59
       text  => 'Weinmeisterstr. (Mitte) Richtung Alexanderplatz gesperrt (bis Ende 10.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009483',
       data  => <<EOF,
userdel	1::inwork 10350,13376 10527,13257
EOF
     },
     { from  => 1221686258, # 2008-09-17 23:17
       until => 1222811999, # 2008-09-30 23:59
       text  => 'Edisonstr. (Obersch�neweide) in Richtung Treskowallee zwischen Wilhelminenhofstr. und Siemensstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 09.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009957',
       data  => <<EOF,
userdel	1::inwork 17992,6436 17962,6674
EOF
     },
     { from  => 1229375516, # 2008-12-15 22:11
       until => 1234738799, # 2009-02-15 23:59
       text  => 'Parkstr. (Wei�ensee) Richtung Berliner Allee zwischen Charlottenburger Str. und Berliner Allee Baustelle, Fahrtrichtung gesperrt (bis Mitte 02.2009)',
       type  => 'gesperrt',
       source_id => 'IM_009965',
       data  => <<EOF,
userdel	1::inwork 13712,16089 13737,15994
EOF
     },
     { from  => 1221775200, # 2008-09-19 00:00
       until => 1221948000, # 2008-09-21 00:00
       text  => 'K 6828 L164 Altfriesack - Wuthenow OD Karwe Erntedankfest Vollsperrung 20.09.2008-20.09.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -25968,49631 -27035,49829 -27196,50015
EOF
     },
     { from  => 1221084000, # 2008-09-11 00:00
       until => 1221688800, # 2008-09-18 00:00
       text  => 'L 030 Neu Zittauer Str. OD Erkner Stra�enbauarbeiten halbseitig gesperrt; Einbahnstra�e 12.09.2008-17.09.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 34232,888 34449,1689 34443,1951
EOF
     },
     { from  => 1221602400, # 2008-09-17 00:00
       until => 1222293600, # 2008-09-25 00:00
       text  => 'L 033 Wriezen - Pr�tzel zw. Schulzendorf und Herzhorn Stra�enbauarbeiten Vollsperrung 18.09.2008-24.09.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 56219,31042 54734,30001
EOF
     },
     { from  => 1221948000, # 2008-09-21 00:00
       until => 1223676000, # 2008-10-11 00:00
       text  => 'K 6411 Neulewin - Altwriezen zw. Heinrichsdorf und Kerstenbruch Stra�enbauarbeiten Vollsperrung 22.09.2008-10.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 68327,37979 67364,38248 67053,38406 66413,38217
EOF
     },
     { from  => 1223157600, # 2008-10-05 00:00
       until => 1238350261, # 2009-06-01 00:00 1243807200
       text  => 'L 015 Rosa-Luxemburg-Str. OL Wittstock, zw. Polthierstr. und Bohnekampweg Kanal- und Stra�enbau Vollsperrung 06.10.2008-31.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -53868,82504 -53648,82294 -53491,81954
EOF
     },
     { from  => 1221948000, # 2008-09-21 00:00
       until => 1239657904, # 2009-05-01 00:00 1241128800
       text  => 'L 030 Fredersdorf - Altlandsberg - Bernau OD Altlandsberg, zw. OE und Strausberger Tor Stra�enausbau Vollsperrung * 22.09.2008-30.04.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 33133,18131 32941,18121 32690,18122 32513,18082 32293,18093
EOF
     },
     { from  => 1221948000, # 2008-09-21 00:00
       until => 1222466400, # 2008-09-27 00:00
       text  => 'L 212 Gro� Sch�nebeck - Hammer - B167 zw. Gro� Sch�nebeck und B�hmerheide Deckenerneuerung Vollsperrung 22.09.2008-26.09.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 15301,53802 15886,54280 17031,55218 17658,55401 17733,55423
EOF
     },
     { from  => undef, # 
       until => 1272120180, # -> �berf�hrt nach gesperrt-orig
       text  => 'Unterf�hrung unter Adlergestell und Bahn wegen Br�ckenerneuerung gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 20810,2398 20939,2413
EOF
     },
     { from  => 1223320498, # 2008-10-06 21:14
       until => 1225493999, # 2008-10-31 23:59
       text  => 'Glinkastr. (Mitte) in Richtung Leipziger Str. zwischen Behrenstr. und J�gerstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 10.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009501',
       data  => <<EOF,
userdel	1::inwork 9164,12172 9183,12076
EOF
     },
     { from  => 1223320616, # 2008-10-06 21:16
       until => 1225580399, # 2008-11-01 23:59
       text  => 'Ordensmeisterstr. (Tempelhof) in Richtung Tempelhofer Damm zwischen Colditzstr. und Wenckebachstr. Baustelle, Fahrtrichtung gesperrt (bis Anfang 11.2008)',
       type  => 'gesperrt',
       source_id => 'IM_010086',
       data  => <<EOF,
userdel	1::inwork 9796,5790 9668,5733 9457,5641 9368,5608
EOF
     },
     { from  => 1223320675, # 2008-10-06 21:17
       until => 1224107999, # 2008-10-15 23:59
       text  => 'Waltersdorfer Str. (Treptow) in beiden Richtungen zwischen Buntzelstr. und Wachtelstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Mitte 10.2008)',
       type  => 'gesperrt',
       source_id => 'IM_010134',
       data  => <<EOF,
userdel	2::inwork 22172,194 22169,14 22168,-71 22177,-137 22190,-228
EOF
     },
     { from  => 1224799200, # 2008-10-24 00:00
       until => 1225058400, # 2008-10-26 23:00
       text  => 'B 107 Gl�wen - B 5 Gumtow Durchlass vor Br�cke �ber die Karthane bei Gl�wen Durchlassneubau Vollsperrung 25.10.2008-26.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -80266,56143 -80074,58321
EOF
     },
     { from  => 1222725600, # 2008-09-30 00:00
       until => 1226271600, # 2008-11-10 00:00
       text  => 'K 6312 Brandenburger Allee, Bahnhofsta�e OD Paulinenaue Stra�enbau Vollsperrung 01.10.2008-09.11.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -36724,28543 -36808,28769 -37053,29229
EOF
     },
     { from  => 1223157600, # 2008-10-05 00:00
       until => 1226790000, # 2008-11-16 00:00
       text  => 'K 6423 Platanenstr., Lindenallee Bahn�bergang in der OL Fredersdorf Ausbau B� mit Gehweg Vollsperrung 06.10.2008-15.11.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 34139,13113 34183,13746 34276,14308
EOF
     },
     { from  => 1222552800, # 2008-09-28 00:00
       until => 1224453600, # 2008-10-20 00:00
       text  => 'K 6435 Ernst-Th�lmann-Str. OD Seelow, zw. R.-Koch-Str. und Werbiger Str. Stra�eninstandsetzung Vollsperrung 29.09.2008-19.10.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 76771,15413 76589,15970
EOF
     },
     { from  => 1221948000, # 2008-09-21 00:00
       until => 1223848800, # 2008-10-13 00:00
       text  => 'L 015 Berliner Str. OL Lychen, zw. Hohenstegstr. und F�rstenberger Tor Stra�enbau, Sanie.St�tzmauer Vollsperrung 22.09.2008-12.10.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 2111,89378 2480,89399
EOF
     },
     { from  => 1222552800, # 2008-09-28 00:00
       until => 1230073200, # 2008-12-24 00:00
       text  => 'L 025 Schm�lln - LG - Penkun zw. Landesgrenze und Schm�lln grundhafter Stra�enbau Vollsperrung 29.09.2008-23.12.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 55977,100103 56188,99924 56268,99856 56856,99683 57042,99574 57516,99296
EOF
     },
     { from  => 1223416800, # 2008-10-08 00:00
       until => 1224108000, # 2008-10-16 00:00
       text  => 'L 074 OL Halbe Bahn�bergang Gleisbauarbeiten Vollsperrung 09.10.2008-15.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 31593,-32938 31657,-32860 31700,-32810
EOF
     },
     { from  => 1222552800, # 2008-09-28 00:00
       until => 1226185200, # 2008-11-09 00:00
       text  => 'L 239 Angerm�nde - Joachimsthal zw. Kerkow und G�rlsdorf Erneuerung Deckenbelag Vollsperrung 29.09.2008-08.11.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 45864,72724 46253,72339 46555,72293 46770,72248 47266,71628 48092,70962 48147,70935 48237,70892 48672,70933
EOF
     },
     { from  => 1221948000, # 2008-09-21 00:00
       until => 1229295600, # 2008-12-15 00:00
       text  => 'L 294 Ruhlsdorfer Str. OD Biesenthal, zw. Lanker Str. und Akazienallee Stra�enneubau Vollsperrung 22.09.2008-14.12.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 24120,41684 24106,41050 24185,40670 24374,40395
EOF
     },
     { from  => 1224540000, # 2008-10-21 00:00
       until => 1226790000, # 2008-11-16 00:00
       text  => 'L 431 Neuzelle - M�biskruge OD Neuzelle, Slawengrund Deckenerneuerung Vollsperrung 22.10.2008-15.11.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 94961,-33275 95107,-33405 95699,-33584 96017,-33547
EOF
     },
     { from  => 1223503200, # 2008-10-09 00:00
       until => 1223848800, # 2008-10-13 00:00
       text  => 'L 442 Goyatz-Guhlen - B 87 Mittweide Br�cke �ber das Ressener Flie� in der OL Ressen Deckeneinbau Vollsperrung 10.10.2008-12.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 62465,-40268 63081,-40295 63207,-40382 63692,-41106
EOF
     },
     { from  => 1223933600, # 2008-10-13 23:33
       until => 1224280799, # 2008-10-17 23:59
       text  => 'Am Kupfergraben (Mitte) in beiden Richtungen H�he Pergamonmuseum Baustelle, Stra�e vollst�ndig gesperrt (bis 17.10.)',
       type  => 'handicap',
       source_id => 'IM_010271',
       data  => <<EOF,
userdel	q4::inwork 9815,12705 9870,12657
EOF
     },
     { from  => 1223933669, # 2008-10-13 23:34
       until => 1226789999, # 2008-11-15 23:59
       text  => 'N�ldnerstr. (Lichtenberg) Richtung Karlshorster Str. zwischen L�ckstr. und Karlsholrster Str. Baustelle, Fahrtrichtung gesperrt (bis Mitte 11.2008)',
       type  => 'gesperrt',
       source_id => 'IM_010255',
       data  => <<EOF,
userdel	1::inwork 16032,10842 15983,10836 15681,10801 15433,10765 15388,10758 15272,10790
EOF
     },
     { from  => 1223416800, # 2008-10-08 00:00
       until => 1225926000, # 2008-11-06 00:00
       text  => 'K 6722 Bornow - Gro� Rietz Bahn�bergang zw. Bornow und Birkholz Gleisbauarbeiten Vollsperrung 09.10.2008-05.11.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 64933,-24619 64924,-23029
EOF
     },
     { from  => 1223762400, # 2008-10-12 00:00
       until => 1225148400, # 2008-10-28 00:00
       text  => 'L 015 Berliner-/Fontanestra�e OL Lychen zw. Schl��stra�e u. Ortsausgang Erneuerung Deckenbelag Vollsperrung 13.10.2008-27.10.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 1544,89701 1090,89570
EOF
     },
     { from  => 1224194400, # 2008-10-17 00:00
       until => 1224453600, # 2008-10-20 00:00
       text  => 'L 030 Mittenwalde - K�nigs Wusterhausen zw. AS Mittenwalde und Schenkendorf Stra�enbauarbeiten Vollsperrung 18.10.2008-19.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 22865,-15325 23123,-14619
EOF
     },
     { from  => 1224540000, # 2008-10-21 00:00
       until => 1224799200, # 2008-10-24 00:00
       text  => 'L 030 Mittenwalde - K�nigs Wusterhausen zw. Schenkendorf und K�nigs Wusterhausen Stra�enbauarbeiten Vollsperrung 22.10.2008-23.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 24843,-13725 25148,-13393 25203,-13334
EOF
     },
     { from  => 1224367200, # 2008-10-19 00:00
       until => 1225407600, # 2008-10-31 00:00
       text  => 'L 034 Hohensteiner Chaussee OD Strausberg, zw. Ph.-M�ller-Str. und Getr�nkemarkt Instandsetzung Entw�ss. Vollsperrung 20.10.2008-30.10.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 43131,19792 43686,19241
EOF
     },
     { from  => 1191362400, # 2007-10-03 00:00
       until => 1226268590, # 2009-01-01 00:00 1230764400
       text  => 'L 315 Prenden-Klosterfelde OD Klosterfelde grundhafter Stra�enbau Vollsperrung 04.10.2007-31.12.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 14941,42957 15632,43100
EOF
     },
     { from  => 1224540000, # 2008-10-21 00:00
       until => 1225058400, # 2008-10-26 23:00
       text  => 'L 707 Baruth - Kummersdorf Gut zw. Horstwalde und Kummersdorf Gut Stra�enbauarbeiten Vollsperrung 22.10.2008-26.10.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 11040,-35529 10087,-34897 9406,-34427
EOF
     },
     { from  => 1224975600, # 2008-10-26 01:00
       until => 1230758415, # 2008-12-31 22:20
       text  => 'Sanierung der Kurt-Tucholsky-Str., 26.10.2008 - Ende 2008',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 938,28349 978,28400 1007,28446 1009,28662 1020,28712 1078,28830 1124,28923 1234,29120 1304,29256 1366,29416
EOF
     },
     { from  => 1226267311, # 2008-11-09 22:48
       until => 1228085999, # 2008-11-30 23:59
       text  => 'Eberswalder Str. (Prenzlauer Berg) Richtung Brunnenstra�e zwischen Schwedter Str. und Sch�nhauser Allee Baustelle, Fahrtrichtung gesperrt, eine Umleitung ist ausgeschildert (bis Ende 11.2008)',
       type  => 'gesperrt',
       source_id => 'IM_008229',
       data  => <<EOF,
userdel	1::inwork 10366,14992 10515,15045 10618,15076 10881,15047
EOF
     },
     { from  => 1226267354, # 2008-11-09 22:49
       until => 1228172399, # 2008-12-01 23:59
       text  => 'K�penicker Str. (Mitte) Richtung Kreuzberg zwischen Br�ckenstr. und Michaelkirchstr. Baustelle, Fahrtrichtung gesperrt (bis Anfang 12.2008)',
       type  => 'gesperrt',
       source_id => 'IM_009727',
       data  => <<EOF,
userdel	1::inwork 11569,11587 11324,11689 11242,11720
EOF
     },
     { from  => 1230474772, # 2008-12-28 15:32
       until => 1238536799, # 2009-03-31 23:59
       text  => 'Ordensmeisterstr. (Tempelhof) Richtung Tempelhofer Damm zwischen Lorenzstr. und Tempelhofer Damm Baustelle, Fahrtrichtung gesperrt (bis Ende 03.2009)',
       type  => 'gesperrt',
       source_id => 'IM_010086',
       data  => <<EOF,
userdel	1::inwork 9368,5608 9147,5534
EOF
     },
     { from  => 1226267441, # 2008-11-09 22:50
       until => 1226789999, # 2008-11-15 23:59
       text  => 'Waltersdorfer Str. (Treptow) in beiden Richtungen zwischen Dhamestr. und Sandbacher Weg Baustelle, Stra�e vollst�ndig gesperrt (bis Mitte 11.2008)',
       type  => 'gesperrt',
       source_id => 'IM_010134',
       data  => <<EOF,
userdel	2::inwork 22172,194 22169,14 22168,-71 22177,-137
EOF
     },
     { from  => 1243972540, # 2009-06-02 21:55
       until => 1244786221, # 2009-06-15 23:59 1245103199
       text  => 'Gubitzstr. (Prenzlauer Berg) in beiden Richtungen zwischen K�selstr. und Scheritzstr. Bauarbeiten, Stra�e vollst�ndig gesperrt (bis Mitte 06.2009)',
       type  => 'handicap',
       source_id => 'IM_010519',
       data  => <<EOF,
userdel	q4::inwork 12463,15774 12384,15618 12299,15463
EOF
     },
     { from  => 1230474690, # 2008-12-28 15:31
       until => 1233442799, # 2009-01-31 23:59
       text  => 'K�thener Str. (Kreuzberg) in beiden Richtungen zwischen Bernburger Str. und Hafenplatz Baustelle, Stra�e vollst�ndig gesperrt ausgeschildert (bis Ende 1.2009)',
       type  => 'gesperrt',
       source_id => 'IM_010401',
       data  => <<EOF,
userdel	2::inwork 8483,10900 8536,11063
EOF
     },
     { from  => 1226267628, # 2008-11-09 22:53
       until => 1233442799, # 2009-01-31 23:59
       text  => 'Storkower Str. (Prenzlauer Berg) Richtung Wedding zwischen Kniprodestr. und Greifswalder Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 01.2009)',
       type  => 'gesperrt',
       source_id => 'IM_010408',
       data  => <<EOF,
userdel	1::inwork 13438,14675 13151,14855 13110,14879 12812,15053 12709,15112
EOF
     },
     { from  => 1224626400, # 2008-10-22 00:00
       until => 1227999600, # 2008-11-30 00:00
       text  => 'B 158 Oderberg - Angerm�nde ab OD Parstein bis Kreisgrenze bei Neuk�nkendorf Stra�enbauarbeiten Vollsperrung 23.10.2008-29.11.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 52554,62772 52445,61982 52484,61529 52571,60809 52603,60356 52441,59932 52362,59750
EOF
     },
     { from  => 1225666800, # 2008-11-03 00:00
       until => 1229209200, # 2008-12-14 00:00
       text  => 'B 273 Bernauer Str. OD Oranienburg, zw. Schmachtenhagener Str. und K�lner Str. Stra�enbauarbeiten Vollsperrung 04.11.2008-13.12.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 187,39231 221,39242 570,39376 643,39426 1223,39893
EOF
     },
     { from  => 1226185200, # 2008-11-09 00:00
       until => 1230073200, # 2008-12-24 00:00
       text  => 'L 015 F�rstenberg - Menz zw. F�rstenberg und Abzw. Altglobsow Stra�enbau Vollsperrung 10.11.2008-23.12.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -10085,84390 -10054,84256 -10109,84134 -10281,83899 -10516,83471 -11849,81547
EOF
     },
     { from  => 1225494000, # 2008-11-01 00:00
       until => 1226790000, # 2008-11-16 00:00
       text  => 'L 015 zw. Abzw. Himmelpfort und F�rstenberg Erneuerung Deckenbelag Vollsperrung 02.11.2008-15.11.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 627,89430 234,89271 -306,89232 -676,89041 -1718,88714 -2243,88584 -2617,88528 -2940,88449 -3184,88449 -4847,88034 -5326,87861 -6133,87749
EOF
     },
     { from  => 1226185200, # 2008-11-09 00:00
       until => 1229727600, # 2008-12-20 00:00
       text  => 'L 020 Falkensee - Velten zw. Sch�nwalde und Gewerbegebiet Stra�enbauarbeiten Vollsperrung 10.11.2008-19.12.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -8777,22961 -7734,23796 -7599,23946 -7533,24138
EOF
     },
     { from  => 1225753200, # 2008-11-04 00:00
       until => 1226530800, # 2008-11-13 00:00
       text  => 'L 040 Th�lmannstr. OD Dahlewitz, H�he Rangsdorfer Weg Kanal- und Stra�enbau Vollsperrung 05.11.2008-12.11.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 12805,-9035 13228,-9606 13576,-9738
EOF
     },
     { from  => 1225666800, # 2008-11-03 00:00
       until => 1227308400, # 2008-11-22 00:00
       text  => 'L 053 Seestr., Calauer Str. OD Gro�r�schen, zw. Chransdorfer Str. und Berliner Str. Kanal- und Stra�enbau Vollsperrung 04.11.2008-21.11.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 54017,-89128 53789,-90228
EOF
     },
     { from  => 1146348000, # 2006-04-30 00:00
       until => 1261003082, # 2010-01-01 00:00 1262300400
       text  => 'L 060 Schipkau-Lichterfeld zw. Lichterfeld und Lauchhammer-Nord grundhafter Stra�enbau Vollsperrung 01.05.2006-31.12.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 37797,-89881 37187,-90210 37102,-90307 37059,-90429 37023,-90770 37078,-90978 37419,-91709 37675,-92038 37809,-92300 37918,-93202 37419,-94853 37230,-95682 37151,-95962 37151,-96145
EOF
     },
     { from  => 1224367200, # 2008-10-19 00:00
       until => 1229727600, # 2008-12-20 00:00
       text  => 'L 088 Bahnhofstr. OD Lehnin, zw. Friedensstr. und Kreisverkehr Gehwegbau halbseitig gesperrt; Einbahnstra�e 20.10.2008-19.12.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -34488,-10578 -34063,-10552
EOF
     },
     { from  => 1224367200, # 2008-10-19 00:00
       until => 1227999600, # 2008-11-30 00:00
       text  => 'L 166 Friesack - Nackel zw. Nackel und Zootzen Deckenerneuerung Vollsperrung 20.10.2008-29.11.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -46590,45423 -46394,45253 -45792,44692 -45553,44122 -45441,43630 -45367,42665
EOF
     },
     { from  => 1226436338, # 2008-10-21 00:00 1224540000
       until => 1226436343, # 2009-05-16 00:00 1242424800 # disabled, using now Andreas Titz' entry
       text  => 'L 171 Kurt-Tucholsky-Str. OL Hohen Neuendorf, zw. K.-Marx-Str. und A.-Bebel-Str. Stra�enbauarbeiten halbseitig gesperrt; Einbahnstra�e 22.10.2008-15.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 1009,28662 1020,28712 1078,28830 1124,28923 1234,29120 1304,29256 1366,29416
EOF
     },
     { from  => 1227353475, # 2008-11-22 12:31
       until => 1228085999, # 2008-11-30 23:59
       text  => 'Invalidenstr. (Mitte) in beiden Richtungen zwischen Am Nordbahnhof und Chausseestr. Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 11.2008)',
       type  => 'gesperrt',
       source_id => 'IM_010718',
       data  => <<EOF,
userdel	2::inwork 9085,13919 8935,13844
EOF
     },
     { from  => 1227353511, # 2008-11-22 12:31
       until => 1230159600, # 2008-12-25 00:00
       text  => 'Platz der Vereinten Nationen in beiden Richtungen Veranstaltung, Stra�e vollst�ndig gesperrt (bis 24.12.2008)',
       type  => 'gesperrt',
       source_id => 'IM_010662',
       data  => <<EOF,
userdel	2::inwork 12177,13283 12126,13088
EOF
     },
     { from  => 1228345200, # 2008-12-04 00:00
       until => 1228950000, # 2008-12-11 00:00
       text  => 'K 7318 Blankenburg - Potzlow Bahn�bergang in der OD Seehausen Gleisbauarbeiten Vollsperrung 05.12.2008-10.12.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 41424,91331 41395,91313 41358,91294
EOF
     },
     { from  => 1231455600, # 2009-01-09 00:00
       until => 1231714800, # 2009-01-12 00:00
       text  => 'K 7318 Blankenburg - Potzlow Bahn�bergang in der OD Seehausen Gleisbauarbeiten Vollsperrung 10.01.2009-11.01.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 41424,91331 41395,91313 41358,91294
EOF
     },
     { from  => 1227394800, # 2008-11-23 00:00
       until => 1227913200, # 2008-11-29 00:00
       text  => 'K 7318 Blankenburg - Potzlow Bahn�bergang in der OD Seehausen Gleisbauarbeiten Vollsperrung 24.11.2008-28.11.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 41424,91331 41395,91313 41358,91294
EOF
     },
     { from  => 1227135600, # 2008-11-20 00:00
       until => 1227567600, # 2008-11-25 00:00
       text  => 'L 053 Calauer Str. OD Gro�r�schen, von IFA-Park bis Felix-Spiro-Str. Deckeneinbau Vollsperrung 21.11.2008-24.11.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 53789,-90228 54017,-89128
EOF
     },
     { from  => 1229122800, # 2008-12-13 00:00
       until => 1229295600, # 2008-12-15 00:00
       text  => 'L 071 Markt OL Sch�newalde, zw. Herzberger Str. und Gartenstr. Weihnachtsmarkt Vollsperrung 14.12.2008-14.12.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -575,-65978 60,-66035
EOF
     },
     { from  => 1226876400, # 2008-11-17 00:00
       until => 1230418799, # 2008-12-27 23:59
       text  => 'Sperrung des Delfter Ufers. Ab Montag, dem 17.11.2008 wird f�r ca. vier Wochen ein Teilst�ck von ca. 250 m der Gr�nanlage Delfter Ufer in H�he der Rudergesellschaft Wiking e.V. bis zum r�ckw�rtigen Firmengel�nde Testorp gesperrt werden. Der Rad- und Fu�weg kann in dieser Zeit nicht durchg�ngig genutzt werden. Ein Ausweichen ist �ber den Schwarzen Weg, Haarlemer Stra�e und wieder zur�ck zum Delfter Ufer �ber den Weg der Kolonie "Zum Siedlerheim" m�glich.',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 13766,6019 13971,5978 14136,5831 14241,5674
EOF
     },
     { from  => 1228340462, # 2008-12-03 22:41
       until => 1233442799, # 2009-01-31 23:59
       text  => 'K�penicker Str. (Mitte) Richtung Kreuzberg zwischen Br�ckenstr. und Michaelkirchstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 01.2009)',
       type  => 'gesperrt',
       source_id => 'IM_009727',
       data  => <<EOF,
userdel	1::inwork 11242,11720 11324,11689 11569,11587
EOF
     },
     { from  => 1233866284, # 2009-02-05 21:38
       until => 1235861999, # 2009-02-28 23:59
       text  => 'N�ldnerstr. (Lichtenberg) Richtung Karlshorster Str. zwischen L�ckstr. und Karlshorster Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 02.2009)',
       type  => 'gesperrt',
       source_id => 'IM_010255',
       data  => <<EOF,
userdel	1::inwork 16032,10842 15983,10836 15681,10801 15433,10765 15388,10758 15272,10790
EOF
     },
     { from  => 1228431600, # 2008-12-05 00:00
       until => 1228690800, # 2008-12-08 00:00
       text  => 'B 096 Stra�e der Jugend OL Zossen zw.York- und Mittenwalder-/Baruther Str. (B246) Einbau Deckschicht Vollsperrung 06.12.2008-07.12.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 14604,-22009 14714,-22665
EOF
     },
     { from  => 1227394800, # 2008-11-23 00:00
       until => 1229727600, # 2008-12-20 00:00
       text  => 'L 025 G�stow - Sch�nermark zw. Sch�nermark und Wilhelmshof Stra�enbauarbeiten Vollsperrung 24.11.2008-19.12.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30734,103253 29305,103289
EOF
     },
     { from  => 1229377525, # 
       until => 1229377528, #
       text  => 'K�penicker Str. (Alt-Glienicke) in beiden Richtungen zwischen Semmelweisstr. und Gr�nauer Str. Stra�ensch�den, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_010810',
       data  => <<EOF,
userdel	2::inwork 19803,1911 19771,1793
EOF
     },
     { from  => 1228675001, # 2008-12-07 19:36
       until => 1230159600, # 2008-12-25 00:00
       text  => 'Simplonstr. zwischen Lenbachstr. und Matkowskystr. bis 24.12.2008 gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 14601,11074 14530,11137
EOF
     },
     { from  => 1229377415, # 2008-12-15 22:43
       until => 1230475010, # 2008-12-31 23:59 1230764399
       text  => 'D�rpfeldstr. (Adlershof) Richtung K�penick zwischen Anna-Seghers-Str. und Gellertstr. Baustelle, Fahrtrichtung gesperrt, bis Ende 12.2008)',
       type  => 'gesperrt',
       source_id => 'IM_010963',
       data  => <<EOF,
userdel	1::inwork 20012,3532 20082,3578
EOF
     },
     { from  => 1229382000, # 2008-12-16 00:00
       until => 1229727600, # 2008-12-20 00:00
       text  => 'K 6636 Kraftwerkstr. OL L�bbenau, Bereich Bahn�bergang Stra�eninstandsetzungsarb. Vollsperrung 17.12.2008-19.12.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 50112,-59987 50337,-60337
EOF
     },
     { from  => 1229036400, # 2008-12-12 00:00
       until => 1230073200, # 2008-12-24 00:00
       text  => 'L 232 Lichtenow - Rehfelde Br�cke �ber das Zinndorfer M�hlenflie� bei Werder Br�ckenerneuerung Vollsperrung 13.12.2008-23.12.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 46163,13586 46017,13884
EOF
     },
     { from  => 1230474969, # 2008-12-28 15:36
       until => 1230958800, # 2009-01-03 06:00
       text  => 'Stra�e des 17. Juni (Tiergarten) Veranstaltung, Stra�e vollst�ndig gesperrt, ebenso Yitzhak-Rabin-Str. und Ebertstr. (bis 03.01.09, ca. 6 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_010978',
       data  => <<EOF,
userdel	2::temp 8119,12414 8055,12186 8089,12190 8214,12205 8303,12216 8538,12245 8546,12279
userdel	2::temp 8595,12066 8600,12165 8538,12245
userdel	2::temp 8055,12186 7816,12150 7383,12095 6828,12031
userdel	2::temp 8538,12245 8610,12254 8731,12270 8804,12280
EOF
     },
     { from  => 1230730702, # 2008-12-31 14:38
       until => 1230807600, # 2009-01-01 12:00
       text  => 'John-Foster-Dulles-Allee - Scheidemannstr. - Dorotheenstr. (Tiergarten/Mitte) in beiden Richtungen zwischen Spreeweg und Wilhelmstr. Veranstaltung, Stra�en vollst�ndig gesperrt (bis 01.01.09, ca. 12 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_011040',
       data  => <<EOF,
userdel	2::temp 7875,12363 8017,12359 8070,12409 8119,12414 8354,12416 8546,12279 8570,12302 8573,12325 8540,12420
userdel	2::temp 8354,12416 8400,12417 8540,12420 8775,12457
EOF
     },
     { from  => 1231707292, # 2009-01-11 21:54
       until => 1262300400, # 2010-01-01 00:00
       text  => 'Blankenburger Str. (Pankow) Richtung Dietzgenstr. zwischen Siegfriedstr. und Dietzgenstr. Baustelle, Fahrtrichtung gesperrt; ebenso ist die Siegfriedstr. als Einbahnstra�e von Blankenburger Str. in Richtung Herthaplatz ausgewiesen (bis Anfang 2010)',
       type  => 'gesperrt',
       source_id => 'IM_011081',
       data  => <<EOF,
userdel	1::inwork 10742,19632 10439,19576 10377,19565 10331,19556 10257,19542
userdel	1::inwork 10614,19907 10742,19632
EOF
     },
     { from  => 1229554800, # 2008-12-18 00:00
       until => 1233442800, # 2009-02-01 00:00
       text  => 'L 401 Karl-Marx-Str., Friedrich-Engels-Str. OD Wildau, zw. Freiheitsstr. und Westkorso grundhafter Stra�enneubau Wintersicherung 19.12.2008-31.01.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 26609,-7136 26700,-7334 26790,-7918 26786,-7968 26775,-8117 26749,-8475
EOF
     },
     { from  => 1231196400, # 2009-01-06 00:00
       until => 1232406000, # 2009-01-20 00:00
       text  => 'K 7359 Crussow - B 2 zw. Kreisverkehr B 2 Ri. Schwedt und OE Neuhof Rohre f�r Erdgastrasse Vollsperrung 07.01.2009-19.01.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 55424,69905 55318,70278
EOF
     },
     { from  => 1233001614, # 2009-01-26 21:26
       until => 1247256157, # 2009-09-15 00:00 1252965600
       text  => 'K�nigsallee (Wilmersdorf) stadtausw�rts zwischen Schinkelstr. und Lynarstr. Baustelle, Fahrtrichtung gesperrt (aber der Radweg ist m�glicherweise noch nutzbar) (Ende ca. Mitte 09.2009) ',
       type  => 'gesperrt',
       source_id => 'IM_009603',
       data  => <<EOF,
userdel	1::inwork 2186,9612 2122,9539 2065,9459 2056,9446 1932,9263
EOF
     },
     { from  => 1233088186, # 2009-01-27 21:29
       until => 1235861999, # 2009-02-28 23:59
       text  => 'Ruhlsdorfer Str. (Ruhlsdorf/Teltow) Zwischen Ruhlsdorfer Platz und Schenkendorfer Weg Fahrtrichtung gesperrt, Richtung: S�den (bis Ende 02.2009)',
       type  => 'gesperrt',
       source_id => 'IM_008991',
       data  => <<EOF,
userdel	1::inwork 1186,-1973 1182,-2170 1001,-3066
EOF
     },
     { from  => 1231023600, # 2009-01-04 00:00
       until => 1257030000, # 2009-11-01 00:00
       text  => 'B 273 Oranienb.-, Gartenstr., Lindenpl., Berl.Str. OD Nauen Kanal- und Stra�enbau halbseitig gesperrt; Einbahnstra�e 05.01.2009-31.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork -25441,21563 -25466,21523 -25542,21416
EOF
     },
     { from  => 1260212611, # undef
       until => 1273690257, # undef
       text  => 'Reichenberger Str., Einbahnstra�e Richtung Kottbusser Tor',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 12398,9938 12556,9862 12714,9792 12834,9738
EOF
     },
     { from  => 1238954607, # 2009-04-05 20:03
       until => 1240518023, # 2009-10-31 23:59 1257029999
       text  => 'Glinkastr. (Mitte) Richtung Leipziger Str. zwischen Franz�sische Str. und J�gerstr. Baustelle, Fahrtrichtung gesperrt (bis 10.2009)',
       type  => 'gesperrt',
       source_id => 'IM_009981',
       data  => <<EOF,
userdel	1::inwork 9183,12076 9201,11968
EOF
     },
     { from  => 1235862000, # 2009-03-01 00:00
       until => 1237244400, # 2009-03-17 00:00
       text  => 'K 6161 Friedenstr. Bahn�bergang in Eichwalde Gleisbauarbeiten Vollsperrung 02.03.2009-16.03.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 25173,-3957 25212,-4025 25269,-4041 25320,-4049
EOF
     },
     { from  => 1234652400, # 2009-02-15 00:00
       until => 1235257200, # 2009-02-22 00:00
       text  => 'L 035 Saarower Chaussee/ Friedensstr. Autobahnbr�cke Friedensstr. in F�rstenwalde Ri. Petersdorf Br�ckenabbruch 16.02.2009-21.02.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 56358,-6276 56333,-6677 56312,-6895 56416,-7090
EOF
     },
     { from  => 1344780493, # undef, # 1234122499, # 2009-02-08 20:48
       until => 1344780497, # undef, # 1281802300, # 2009-02-28 23:59 1235861999 undef
       text  => 'Weinmeisterstr. (Mitte) in Richtung Alexanderplatz gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_011184',
       data  => <<EOF,
userdel	q4::inwork; 10350,13376 10527,13257
EOF
     },
     { from  => 1238347304, # 2009-03-29 19:21
       until => 1238623199, # 2009-04-01 23:59
       text  => 'Eberswalder Str. (Prenzlauer Berg) Richtung Prenzlauer Allee zwischen Schwedter Str. und Danziger Str. Baustelle, Fahrtrichtung gesperrt ist eingerichtet (bis Anfang 04.2009)',
       type  => 'handicap',
       source_id => 'IM_011698',
       data  => <<EOF,
userdel	q4::inwork; 10366,14992 10515,15045 10618,15076 10881,15047
EOF
     },
     { from  => 1238347383, # 2009-03-29 19:23
       until => 1238623199, # 2009-04-01 23:59
       text  => 'Konrad-Wolf-Str. (Hohensch�nhausen) Richtung Suermondtstr. in H�he Altenhofer Str. Baustelle, Fahrtrichtung gesperrt, eine Umleitung ist eingerichtet (bis Anfang 04.2009)',
       type  => 'handicap',
       source_id => 'IM_011938',
       data  => <<EOF,
userdel	q4::inwork; 15058,14575 15174,14638 15272,14691 15345,14736 15383,14759
EOF
     },
     { from  => 1244065297, # 2009-06-03 23:41
       until => 1245103199, # 2009-06-15 23:59
       text  => 'K�penicker Str. (Kreuzberg) Richtung Engeldamm zwischen Heinrich-Heine-Str. und Michaelkirchstr. Baustelle, Fahrtrichtung gesperrt (bis Mitte 06.2009)',
       type  => 'handicap',
       source_id => 'IM_012479',
       data  => <<EOF,
userdel	q4::inwork; 11242,11720 11324,11689 11569,11587
EOF
     },
     { from  => 1238347506, # 2009-03-29 19:25
       until => 1297363088, # 2010-01-01 00:00 1262300400 undef --- 2011-02-09 gepr�ft: weitgehend durchl�ssig
       text  => 'K�thener Str. (Kreuzberg) zwischen Bernburger Str. und Hallesches Ufer Baustelle, Einbahnstra�e Richtung Norden',
       type  => 'handicap',
       source_id => 'IM_011637',
       data  => <<EOF,
userdel	q4::inwork; 8483,10900 8443,10777
EOF
     },
     { from  => 1244065177, # 2009-06-03 23:39
       until => 1246208296, # 2009-06-30 23:59 1246399199
       text  => 'L�ckstr. (Lichtenberg) Richtung N�ldnerstr. zwischen Giselastr. und N�ldnerplatz Baustelle, Fahrtrichtung gesperrt; sowie Einbahnstra�enregelungen in der Giselastr. und Stadthausstr. (bis Ende 06.2009)',
       type  => 'handicap',
       source_id => 'IM_011767',
       data  => <<EOF,
userdel	q4::inwork; 16153,10818 16085,10844 16032,10842
userdel	q4::inwork; 16196,10911 16153,10818
userdel	q4::inwork; 15681,10801 15674,10851
EOF
     },
     { from  => 1242281854, # 2009-05-14 08:17
       until => 1255499918, # 2009-10-31 23:59 1257029999
       text  => 'Pappelallee (Prenzlauer Berg) Richtung Wisbyer Str. zwischen Stargarder Str. und Wichertstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 10.2009)',
       type  => 'handicap',
       source_id => 'IM_012654',
       data  => <<EOF,
userdel	q4::inwork; 11301,15668 11373,15789 11393,15823 11455,15916
EOF
     },
     { from  => 1238347688, # 2009-03-29 19:28
       until => 1238536799, # 2009-03-31 23:59
       text  => 'Weddigenweg (Lichterfelde) Kreuzungsbereich Baseler Str. geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt (bis Ende 03.2009)',
       type  => 'handicap',
       source_id => 'IM_011933',
       data  => <<EOF,
userdel	q4::inwork 3318,3046 3174,3052 3026,3058
EOF
     },
     { from  => 1237071600, # 2009-03-15 00:00
       until => 1240610400, # 2009-04-25 00:00
       text  => 'B 104 Pasewalk - Strasburg zw. Wilsickow und Louisfelde Dammsanierung Vollsperrung 16.03.2009-24.04.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 35808,121116 37210,121086 38889,120566 39344,120804
EOF
     },
     { from  => 1237849200, # 2009-03-24 00:00
       until => 1251756000, # 2009-09-01 00:00
       text  => 'B 109 B167 - Zehdenick OD Falkenthal Stra�enbauarbeiten Vollsperrung 25.03.2009-31.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 2947,56408 2775,56089 2034,55227
EOF
     },
     { from  => 1237071600, # 2009-03-15 00:00
       until => 1251669600, # 2009-08-31 00:00
       text  => 'B 198 Pol�en - Gramzow OD Meichow grundhafter Stra�enbau Vollsperrung 16.03.2009-30.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 48310,87199 48468,87288 48550,87381 48624,87416
EOF
     },
     { from  => 1240005600, # 2009-04-18 00:00
       until => 1240178400, # 2009-04-20 00:00
       text  => 'K 6722 Bornow - Gro� Rietz Bahn�bergang bei Bornow Gleisbauarbeiten Vollsperrung 19.04.2009-19.04.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 64933,-24619 64924,-23029
EOF
     },
     { from  => 1239055200, # 2009-04-07 00:00
       until => 1240092000, # 2009-04-19 00:00
       text  => 'K 6828 Altfriesack-Wuthenow zw. Seehof u. Karwe Stra�enbauarbeiten Vollsperrung 08.04.2009-18.04.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -27196,50015 -27421,50349 -28001,50966 -28368,51517 -28736,52387
EOF
     },
     { from  => 1238536800, # 2009-04-01 00:00
       until => 1253359305, # 2010-05-31 00:00 1275256800
       text  => 'K 6910 Am Wasser OD Schwielowsee, zw. Baumgartenbr�ck u. OA Kanal- u. Stra�enbau halbseitig gesperrt; Einbahnstra�e 02.04.2009-30.05.2010 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; -19332,-5240 -19652,-5090 -19744,-4792
EOF
     },
     { from  => 1240005600, # 2009-04-18 00:00
       until => 1240178400, # 2009-04-20 00:00
       text  => 'K 7126 B 169 Leuthen - Koschendorf Drebkau, OT Leuthen, Hauptstra�e 75 Jahrfeier FFw Leuthen Vollsperrung 19.04.2009-19.04.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 69846,-78006 69561,-77883 69446,-77826
EOF
     },
     { from  => 1236898800, # 2009-03-13 00:00
       until => 1242424800, # 2009-05-16 00:00
       text  => 'K 7234 Goethestra�e OD Dabendorf Kanalarbeiten halbseitig gesperrt; Einbahnstra�e 14.03.2009-15.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 14153,-17829 13282,-18250
EOF
     },
     { from  => 1241042400, # 2009-04-30 00:00
       until => 1243720800, # 2009-05-31 00:00
       text  => 'L 015 F�rstenberg - Menz OD F�rstenberg, Krz. B 96 Stra�enbau Vollsperrung 01.05.2009-30.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -8775,85947 -8893,85743
EOF
     },
     { from  => 1236466800, # 2009-03-08 00:00
       until => 1246399200, # 2009-07-01 00:00
       text  => 'L 015 F�rstenberg - Menz zw. F�rstenberg und Abzw. Altglobsow Stra�enbau Vollsperrung 09.03.2009-30.06.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -9850,84800 -10085,84390 -10054,84256 -10109,84134 -10281,83899 -10516,83471 -11849,81547
EOF
     },
     { from  => 1237676400, # 2009-03-22 00:00
       until => 1243637028, # 2009-07-01 00:00 1246399200
       text  => 'L 016 Flatow - Fehrbellin zw. Tarmow und Hakenberg Deckenerneuerung Vollsperrung 23.03.2009-30.06.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -29100,40590 -29745,41348 -30926,42438
EOF
     },
     { from  => 1236812400, # 2009-03-12 00:00
       until => 1238536800, # 2009-04-01 00:00
       text  => 'L 035 Kno. Friedensstr./ Saarower Chausse OL F�rstenwalde, Abzw. Friedensstr. Br�ckenabbruch A 12 Friedensstr. gesperrt 13.03.2009-31.03.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 56416,-7090 56312,-6895 56333,-6677 56358,-6276
EOF
     },
     { from  => 1237417200, # 2009-03-19 00:00
       until => 1238450400, # 2009-03-31 00:00
       text  => 'L 040 L23 Storkow - Friedersdorf Durchlass bei Kummersdorf Ersatzneubau Durchlass Vollsperrung 20.03.2009-30.03.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 44261,-14205 43456,-14384 42430,-14398
EOF
     },
     { from  => 1238277600, # 2009-03-28 23:00
       until => 1240178400, # 2009-04-20 00:00
       text  => 'L 051 Cottbus - Burg Kreisel Briesen Ri. Burg Ausbauarbeiten Vollsperrung 30.03.2009-19.04.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 67790,-65471 69116,-65620 69513,-65962 70038,-66419 70748,-67199 71950,-68237 72284,-68499
EOF
     },
     { from  => 1238709600, # 2009-04-03 00:00
       until => 1238882400, # 2009-04-05 00:00
       text  => 'L 052 Drebkau - Ogrosen zw. Abzw. Radensdorf u. Casel Stra�enbauarbeiten Vollsperrung 04.04.2009-04.04.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 61785,-79030 61948,-79050 62310,-79192 62865,-79490 63443,-79906 63683,-79952 63870,-80117 64754,-80954
EOF
     },
     { from  => 1239832800, # 2009-04-16 00:00
       until => 1240178400, # 2009-04-20 00:00
       text  => 'L 056 Klein Meh�ow-Crinitz OD F�rstlich Drehna, zw. Driftweg u. Crinitzer Stra�e Motocross Meisterschaften Vollsperrung 17.04.2009-19.04.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 39419,-72066 39608,-71896
EOF
     },
     { from  => 1237676400, # 2009-03-22 00:00
       until => 1239746400, # 2009-04-15 00:00
       text  => 'L 077 Saarmund - G�terfelde Bereich KVK Philippsthal Radwegbau Vollsperrung 23.03.2009-14.04.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -5575,-6838 -6043,-7395 -6319,-7823
EOF
     },
     { from  => 1237676400, # 2009-03-22 00:00
       until => 1261770596, # 2010-01-01 00:00 1262300400
       text  => 'L 086 Belziger Stra�e OD Lehnin Kreuzungsbereich Gohlitzstra�e Stra�enbau Vollsperrung 23.03.2009-31.12.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -34655,-11263 -34337,-11047
EOF
     },
     { from  => 1224540000, # 2008-10-21 00:00
       until => 1242424800, # 2009-05-16 00:00
       text  => 'L 171 Kurt-Tucholsky-Str. OL Hohen Neuendorf, zw. Karl-Marx-Str. und Eichenallee Neubau Nebenanlagen halbseitig gesperrt; Einbahnstra�e 22.10.2008-15.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 1366,29416 1304,29256 1234,29120 1124,28923 1078,28830 1020,28712 1009,28662 1007,28446 978,28400 938,28349
EOF
     },
     { from  => 1238022000, # 2009-03-26 00:00
       until => 1238623200, # 2009-04-02 00:00
       text  => 'L 283 Parstein - B 2, Schmargendorf Bahn�bergang OD Herzsprung Gleisbauarbeiten Vollsperrung 27.03.2009-01.04.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 49004,64047 48516,64085 48151,64245
EOF
     },
     { from  => 1236466800, # 2009-03-08 00:00
       until => 1247256843, # 2009-09-01 00:00 1251756000
       text  => 'L 402 Zeuthen - Dahlewitz Kreuzung zw. Zeuthen und Kiekebusch Neubau Kreisverkehr Vollsperrung 09.03.2009-31.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 22467,-7066 21783,-6875 21527,-6853
EOF
     },
     { from  => 1237935600, # 2009-03-25 00:00
       until => 1244150009, # 2010-01-01 00:00 1262300400
       text  => 'L 412 Bad Saarow - Alt Golm OD Neu Golm Kanal- und Stra�enbau Vollsperrung 26.03.2009-31.12.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 58018,-10573 57882,-10535 57752,-10566 57479,-10535 57371,-10550 57225,-10700
EOF
     },
     { from  => 1249152434, # 
       until => 1249152439, # XXX -> handicap_s-orig
       text  => 'Bauarbeiten in der Simplonstr., Stra�e gesperrt',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 14601,11074 14530,11137
userdel	q4::inwork 14530,11137 14465,11195
EOF
     },
     { from  => undef, # 
       until => 1257190766, # Time::Local::timelocal(reverse(2009-1900,10-1,31,23,59,59)), # XXX
       text  => 'Jessnerstr. wegen Bauarbeiten in Richtung S�den nicht befahrbar, bis Oktober 2009',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 15080,11905 14981,11751 14946,11697 14849,11539
EOF
     },
     { from  => 1238954738, # 2009-04-05 20:05
       until => 1243807199, # 2009-05-31 23:59
       text  => 'Glinkastr. (Mitte) Baustelle, Fahrbahn gesperrt (bis Ende 05.2009)',
       type  => 'handicap',
       source_id => 'IM_012052',
       data  => <<EOF,
#: last_checked: 2009-05-27
userdel	q4::inwork; 9164,12172 9183,12076
EOF
     },
     { from  => 1238954788, # 2009-04-05 20:06
       until => 1241128799, # 2009-04-30 23:59
       text  => 'Ordensmeisterstr. (Tempelhof) Richtung Tempelhofer Damm zwischen Lorenzweg und Tempelhofer Damm Baustelle, Fahrtrichtung gesperrt (bis Ende 04.2009)',
       type  => 'handicap',
       source_id => 'IM_012064',
       data  => <<EOF,
userdel	q4::inwork; 9457,5641 9368,5608 9147,5534
EOF
     },
     { from  => 1238954845, # 2009-04-05 20:07
       until => 1240164000, # 2009-04-19 20:00
       text  => 'Perleberger Str. (Tiergarten) Richtung Stromstra�e zwischen Heidestr. und Rathenower Str. Baustelle, Fahrtrichtung gesperrt, ebenso die Einm�ndungsbereiche Quitzowstr. und Lehrter Str. zur Perleberger Str. �ber Heidestr. (bis 19.04.2009, 20 Uhr)',
       type  => 'handicap',
       source_id => 'IM_012112',
       data  => <<EOF,
userdel	q4::inwork; 7373,14566 7180,14419 7123,14367 6992,14251 6818,14102 6730,14021 6646,13951 6493,13822 6366,13716 6230,13596
EOF
     },
     { from  => 1238450400, # 2009-03-31 00:00
       until => 1247695200, # 2009-07-16 00:00
       text  => 'B 002 Wittenberg - LG - Treuenbrietzen OD Marzahna Kanal- und Stra�enbau halbseitig gesperrt; Einbahnstra�e 01.04.2009-15.07.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; -32313,-49192 -31201,-45781
EOF
     },
     { from  => 1235862000, # 2009-03-01 00:00
       until => 1243202400, # 2009-05-25 00:00
       text  => 'B 102 Gro�e Milower Str. OD Rathenow, zw. Wolzenstr. und Heidefeldstr. Neubau Kreisverkehr Vollsperrung 02.03.2009-24.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -62290,19904 -62333,20390
EOF
     },
     { from  => 1244757600, # 2009-06-12 00:00
       until => 1244930400, # 2009-06-14 00:00
       text  => 'B 112 Forst - Guben OD Grie�en Derny-Rennen Vollsperrung 13.06.2009-13.06.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 92350,-60772 92627,-60499
EOF
     },
     { from  => 1239573600, # 2009-04-13 00:00
       until => 1240092000, # 2009-04-19 00:00
       text  => 'B 167 Bad Freienwalde - Eberswalde OD Falkenberg, Karl-Marx-Str. Stra�enbauarbeiten Vollsperrung 14.04.2009-18.04.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 47893,44581 47735,44502 47657,44531 47628,44635
EOF
     },
     { from  => 1240696800, # 2009-04-26 00:00
       until => 1241820000, # 2009-05-09 00:00
       text  => 'K 6304 Chaussee OD Priort, Bahn�bergang Gleisbauarbeiten Vollsperrung 27.04.2009-08.05.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -19058,11636 -19029,11660 -18750,11919
EOF
     },
     { from  => 1239573600, # 2009-04-13 00:00
       until => 1243634400, # 2009-05-30 00:00
       text  => 'L 063 Finsterwalder Stra�e OD Lauchhammer, zw. Bockwitzer Str. u. Neue Schehlenstra�e Kanalarbeiten Vollsperrung 14.04.2009-29.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 35072,-102150 35379,-103141
EOF
     },
     { from  => 1239573600, # 2009-04-13 00:00
       until => 1240092000, # 2009-04-19 00:00
       text  => 'L 281 Neureetz-Altranft zw. Neureetz u. Croustellier Deckenerneuerung Vollsperrung 14.04.2009-18.04.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 59730,42362 58564,43539
EOF
     },
     { from  => 1239657365, # 2009-04-13 23:16
       until => 1240517989, # 2009-04-30 23:59 1241128799
       text  => 'Bernstorffstr. (Reinickendorf) Richtung Berliner Str. zwischen Buddestr. und Berliner Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 04.2009)',
       type  => 'handicap',
       source_id => 'IM_012136',
       data  => <<EOF,
userdel	q4::inwork; 2241,20487 2131,20406 2020,20327
EOF
     },
     { from  => 1239660000, # 2009-04-14 00:00
       until => 1243634400, # 2009-05-30 00:00
       text  => 'B 102 Belziger Stra�e OD Treuenbrietzen, Kreisverkehr Ri. Belzig Sanierung Kreisverkehr Vollsperrung 15.04.2009-29.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -25654,-35292 -25419,-35417
EOF
     },
     { from  => 1239573600, # 2009-04-13 00:00
       until => 1242160146, # 2009-07-14 00:00 1247522400
       text  => 'B 158 Blumberg - Werneuchen zw. Blumberg u. Seefeld Deckenerneuerung Vollsperrung 14.04.2009-13.07.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 28531,24375 28246,24272 27608,23776 27283,23503 26936,23104 26764,23083 25641,22864 25295,22655 24951,22681 24735,22556
EOF
     },
     { from  => 1239919200, # 2009-04-17 00:00
       until => 1240092000, # 2009-04-19 00:00
       text  => 'B 246 Lindenberg - Wendisch Rietz Bahn�bergang OL Lindenberg Gleisbauarbeiten Vollsperrung 18.04.2009-18.04.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 59522,-22230 59293,-21524
EOF
     },
     { from  => 1239919200, # 2009-04-17 00:00
       until => 1240092000, # 2009-04-19 00:00
       text  => 'B 273 Bernauer Stra�e OL Oranienburg, zw. Liebigstr. u. Lehnitzstr. Oranienburger Autofr�hling Vollsperrung 18.04.2009-18.04.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -1032,38792 -1253,38715
EOF
     },
     { from  => 1239573600, # 2009-04-13 00:00
       until => 1240005600, # 2009-04-18 00:00
       text  => 'K 6303 Brieselang - Bredow Autobahnbr�cke zw. Brieselang und Bredow Br�ckenabbruch Vollsperrung 14.04.2009-17.04.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -20109,20341 -19128,19920
EOF
     },
     { from  => 1240092000, # 2009-04-19 00:00
       until => 1262300400, # 2010-01-01 00:00
       text  => 'L 033 Gielsdorfer Str. / Pr�tzeler Chaussee OL Strausberg, Kreisverk. Abzw. Wriezener Str. Stra�enausbau Wriezener Str. gesperrt 20.04.2009-31.12.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 43584,20871 43209,20665
EOF
     },
     { from  => 1239573600, # 2009-04-13 00:00
       until => 1243029600, # 2009-05-23 00:00
       text  => 'L 161 bei Vehlefanz Stra�en- u. Durchlassbau Vollsperrung 14.04.2009-22.05.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -11367,34034 -11282,34185 -10702,34336
EOF
     },
     { from  => 1239746400, # 2009-04-15 00:00
       until => 1240264800, # 2009-04-21 00:00
       text  => 'K 6425 Lindenallee OD Hoppegarten, zw. Kreisverkehr und An der Zoche Deckeneinbau Vollsperrung 16.04.2009-20.04.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 28510,12507 28287,12471
EOF
     },
     { from  => 1239912175, # 2009-04-16 22:02
       until => 1240005600, # 2009-04-18 00:00
       text  => 'Ordensmeisterstr. (Tempelhof) in beiden Richtungen zwischen Lorenzweg und Tempelhofer Damm Baustelle, Stra�e vollst�ndig gesperrt (bis 17.04.09 abends)',
       type  => 'handicap',
       source_id => 'IM_012244',
       data  => <<EOF,
userdel	q4::inwork 9457,5641 9368,5608 9147,5534
EOF
     },
     { from  => 1243371742, # 2009-05-26 23:02
       until => 1243807199, # 2009-05-31 23:59
       text  => 'Schlichtallee (Lichtenberg) Richtung N�ldnerplatz zwischen beiden Einm�ndungen Fischerstr. Baustelle, gesperrt (Umfahrung �ber Fischerstr.) (bis Ende 05.09)',
       type  => 'gesperrt',
       source_id => 'IM_011757',
       data  => <<EOF,
userdel	1::inwork 15982,10765 16003,10797 16032,10842
EOF
     },
     { from  => 1239912306, # 2009-04-16 22:05
       until => 1240437600, # 2009-04-23 00:00
       text  => 'Steglitzer Damm (Steglitz) Richtung Attilastr. zwischen Albrechtstr. und Presselstr. geplatzte Wasserleitung, gesperrt (bis ca. 22.04.09)',
       type  => 'handicap',
       source_id => 'IM_012235',
       data  => <<EOF,
userdel	q4::inwork; 6053,4942 6191,4923
EOF
     },
     { from  => 1240092000, # 2009-04-19 00:00
       until => 1247263200, # 2009-07-11 00:00
       text  => 'L 015 F�rstenberger Stra�e OD Lychen, zw. Markt u. F�rstenberger Tor Kanal- u. Stra�enbau Vollsperrung 20.04.2009-10.07.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -18726,-19242 -19026,-19156
EOF
     },
     { from  => 1239660000, # 2009-04-14 00:00
       until => 1257030000, # 2009-11-01 00:00
       text  => 'L 022 Zehdenick - Gransee Br�cke �ber den Welsegraben bei Badingen Br�ckenbauarbeiten Vollsperrung 15.04.2009-31.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -3207,65718 -3718,65788 -4295,65959
EOF
     },
     { from  => 1239573600, # 2009-04-13 00:00
       until => 1241128800, # 2009-05-01 00:00
       text  => 'L 077 Saarmund - G�terfelde Bereich KVK Philippsthal Radwegbau Vollsperrung 14.04.2009-30.04.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -6043,-7395 -5575,-6838
EOF
     },
     { from  => 1240005600, # 2009-04-18 00:00
       until => 1240178400, # 2009-04-20 00:00
       text  => 'L 085 Linthe - Br�ck zw. AS zur A 9 und Einm�ndg. Gewerbegebiet ADAC StartUp Day Vollsperrung 19.04.2009-19.04.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -32763,-26409 -31197,-28211
EOF
     },
     { from  => undef, # 
       until => undef, # XXX
       text  => 'Anwohner haben den Uferweg am Griebnitzsee versperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp -8625,-1176 -8700,-997 -8813,-933 -8913,-813 -9103,-813 -9239,-739 -9337,-668 -9365,-610 -9454,-434 -9562,-325
userdel	2::temp -8087,-1453 -8151,-1470 -8306,-1454
EOF
     },
     { from  => 1240517911, # 2009-04-23 22:18
       until => 1240840800, # 2009-04-27 16:00
       text  => 'Alt-K�penick (K�penick) in der Altstadt-K�penick Veranstaltung, Sperrungen (bis 27.04.09, 16 Uhr)',
       type  => 'handicap',
       source_id => 'IM_012333',
       data  => <<EOF,
userdel	q4::temp 22196,4847 22175,4730 22138,4661 22133,4644 22111,4562 22093,4499
EOF
     },
     { from  => 1242770815, # 2009-05-20 00:06
       until => 1290963632, # 1301608800, # 2011-09-01 00:00 # -> handicap_s-orig
       text  => 'Rathausstr. (Mitte) Richtung Alexanderplatz zwischen Breitestr. und Poststr. Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 2011)',
       type  => 'handicap',
       source_id => 'IM_012342',
       data  => <<EOF,
userdel	q4::inwork 10285,12306 10357,12356
userdel	q4::inwork 10422,12395 10476,12432
EOF
     },
     { from  => 1240518036, # 2009-04-23 22:20
       until => 1241128799, # 2009-04-30 23:59
       text  => 'Glinkastr. (Mitte) Kreuzungsbereich Behrenstr. Baustelle, gesperrt (bis Ende 04.09)',
       type  => 'handicap',
       source_id => 'IM_012301',
       data  => <<EOF,
userdel	q4::inwork 9183,12076 9164,12172
EOF
     },
     { from  => 1240524000, # 2009-04-24 00:00
       until => 1240783200, # 2009-04-27 00:00
       text  => 'B 096 Stra�e der Jugend OL Zossen zw.York- und Mittenwalder-/Baruther Str. Deckschichteinbau Vollsperrung 25.04.2009-26.04.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 14604,-22009 14714,-22665
EOF
     },
     { from  => 1241301600, # 2009-05-03 00:00
       until => 1261436400, # 2009-12-22 00:00
       text  => 'B 198 Neubrandenburger Stra�e OD Prenzlau, Br�cke �ber die �cker Br�ckenneubau Vollsperrung 04.05.2009-21.12.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 39239,101950 39066,102017
EOF
     },
     { from  => 1240696800, # 2009-04-26 00:00
       until => 1240869600, # 2009-04-28 00:00
       text  => 'L 338 Hauptstra�e OL Neuenhagen, vor Grundst. Nr. 32 Kranaufstellung Vollsperrung 27.04.2009-27.04.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 30179,13667 30795,13191
EOF
     },
     { from  => 1240696800, # 2009-04-26 00:00
       until => 1242368265, # 2009-05-16 00:00 1242424800
       text  => 'L 075 Mahlow - Gro�ziethen zw. Kreuzg. B96A u. Kleinziethen Deckeninstandsetzung Vollsperrung 27.04.2009-15.05.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 13506,-2809 13373,-3234 13321,-3678 13301,-4355 13237,-4511 13215,-4564 13289,-4660
EOF
     },
     { from  => 1240783200, # 2009-04-27 00:00
       until => 1240956000, # 2009-04-29 00:00
       text  => 'L 030 Gerichtsstr. (Puschkinstr.) OL K�nigs Wusterhausen, zw. Br�ckenstr. und Kirchplatz Kanal- und Stra�enbau halbseitig gesperrt; Einbahnstra�e 28.04.2009-28.04.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 25859,-11559 26177,-11648
EOF
     },
     { from  => 1240783200, # 2009-04-27 00:00
       until => 1251756000, # 2009-09-01 00:00
       text  => 'L 341 Steinbeck - Heckelberg OD Brunow, zw. Freudenberger Str. u. Tramper Weg Stra�enausbau Vollsperrung 28.04.2009-31.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 41624,36648 41618,36515 41808,36267
EOF
     },
     { from  => 1240953370, # 2009-04-28 23:16
       until => 1243807199, # 2009-05-31 23:59 die eigentliche Baustelle (Wilhelmstr.): Durchfahrt f�r Radfahrer frei!
       text  => 'Schadowstr. Richtung Unter den Linden Fahrtrichtung gesperrt (bis Ende 05.2009)',
       type  => 'handicap',
       source_id => 'IM_012427',
       data  => <<EOF,
#userdel	q4::inwork; 8804,12280 8775,12457
#: last_checked: 2009-05-21
userdel	q4::inwork; 9016,12416 9028,12307
EOF
     },
     { from  => 1241301600, # 2009-05-03 00:00
       until => 1241820000, # 2009-05-09 00:00
       text  => 'B 087 zw. Abzw. Freiimfelde und Luckau Stra�enbau Vollsperrung 04.05.2009-08.05.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 37549,-57430 36050,-58754
EOF
     },
     { from  => 1241301600, # 2009-05-03 00:00
       until => 1244585507, # 2009-06-27 00:00 1246053600
       text  => 'K 6315 Nennhausen - Rhinsm�hlen zw. Nennhausen und Kotzen Stra�enbau Vollsperrung 04.05.2009-26.06.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -50010,23562 -50201,23411 -50255,22794 -50938,21256
userdel	2::inwork -50149,24689 -50048,24475 -49883,24097
EOF
     },
     { from  => 1241647200, # 2009-05-07 00:00
       until => 1241906400, # 2009-05-10 00:00
       text  => 'L 023 Ringenwalde - Milmersdorf OD G�tschendorf Deckeneinbau Vollsperrung 08.05.2009-09.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 28003,76731 27309,76652 26735,76914
EOF
     },
     { from  => 1241158758, # 2009-05-01 08:19
       until => 1241222400, # 2009-05-02 02:00
       text  => 'Stra�e des 17. Juni (Tiergarten) in beiden Richtungen zwischen Yitzhak-Rabin-Str. und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (bis 02.05.09, 02 Uhr)',
       type  => 'handicap',
       source_id => 'IM_012478',
       data  => <<EOF,
userdel	q4::temp 8055,12186 8089,12190 8214,12205 8303,12216 8538,12245
EOF
     },
     { from  => 1242079200, # 2009-05-12 00:00
       until => 1243634400, # 2009-05-30 00:00
       text  => 'L 712 Kemlitz-Paplitz zw. B115 und Paplitz, bei Baruth Stra�enbau Vollsperrung 13.05.2009-29.05.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 15977,-42207 16047,-39802 15949,-39449
EOF
     },
     { from  => 1241301600, # 2009-05-03 00:00
       until => 1241647200, # 2009-05-07 00:00
       text  => 'L 021 Zehlendorf - Liebenwalde OD Zehlendorf Regenentw�sserung Vollsperrung 04.05.2009-06.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 9098,42254 9043,42165 9032,42153
EOF
     },
     { from  => $isodate2epoch->("2013-05-24 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-05-26 23:59:59"),
       periodic => 1,
       text  => 'Preu�enallee (Charlottenburg) zwischen Marathonallee und Badenallee Veranstaltung (Fr�hling in der Preu�enallee), Stra�e wahrscheinlich vollst�ndig gesperrt (25. und 26. Mai 2013)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 589,11953 577,11837 562,11710 560,11695 550,11607
EOF
     },
     { from  => 1241419680, # 2009-05-04 08:48
       until => 1309438800, # 2011-06-30 15:00
       text  => 'Kantstr. zwischen Hardebergstr. und Joachimstaler Str. gesperrt (bis 2011) ',
       type  => 'gesperrt',
       source_id => 'IM_012523',
       data  => <<EOF,
userdel	2::inwork 5652,11004 5613,10963 5488,10978
EOF
     },
     { from  => 1244582648, # 
       until => 1244582652, # XXX
       text  => 'Bauarbeiten in der Pasewalker Str., Marienstra�e ist eine Sackgasse, aber Radfahrer k�nnen passieren',
       type  => 'handicap',
       data  => <<EOF,
#: by: Axel Schumacher:
#: last_checked: 2009-05
userdel	q2::inwork 12095,20832 11686,21058
EOF
     },
     { from  => 1241972889, #  undef
       until => 1241972895, # undef -> Axel meint, dass hier kein Problem w�re
       text  => 'Bauarbeiten in der Pasewalker Str., eingeschr�nkter Zugang zur Eweststr., aber Radfahrer k�nnen passieren',
       type  => 'handicap',
       data  => <<EOF,
userdel	q3::inwork 12121,20969 12189,20959
EOF
     },
     { from  => 1242840466, # 
       until => 1242840469, #
       text  => 'Bauarbeiten in der W�hlischstra�e (Einbahnstra�e Richtung Osten) und Holteistra�e (Kreuzungsbereich zur W�hlischstra�e ist gesperrt).',
       type  => 'handicap',
       data  => <<EOF,
#: check_frequency: 7d vvv
#: last_checked: 2009-05-09 vvv
userdel	q4::inwork 14639,11512 14575,11407
userdel	q4::inwork; 14759,11339 14737,11347 14674,11370 14575,11407
#: last_checked: ^^^
#: check_frequency ^^^
EOF
     },
     { from  => 1241647200, # 2009-05-07 00:00
       until => 1241992800, # 2009-05-11 00:00
       text  => 'B 112 Guben - Neuzelle zw. Abzw. Streichwitz u. Abzw. Wellmitz Arbeiten a. d. Erdgasleitung Vollsperrung 08.05.2009-10.05.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 97032,-36743 97016,-36424 96951,-34887
EOF
     },
     { from  => 1242338400, # 2009-05-15 00:00
       until => 1242597600, # 2009-05-18 00:00
       text  => 'L 743 Motzen - Bestensee OL Motzen, T�pchiner Str. Stra�enbau Vollsperrung 16.05.2009-17.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 23485,-22730 23239,-23484
EOF
     },
     { from  => 1244066400, # 2009-06-04 00:00
       until => 1244498400, # 2009-06-09 00:00
       text  => 'B 087 Beeskow - L�bben zw. Birkenhainichen u. Biebersdorf Deckschichteinbau Vollsperrung 05.06.2009-08.06.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 52695,-45345 53268,-45117 55628,-43569
EOF
     },
     { from  => 1241906400, # 2009-05-10 00:00
       until => 1242160096, # 2009-07-23 00:00 1248300000
       text  => 'B 102 Wildberg - Neustadt-Dosse zw. B�ckwitz u. Neustadt-Dosse Stra�enbau Vollsperrung 11.05.2009-22.07.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -53139,50022 -54295,49682 -54769,49740 -54942,49716
EOF
     },
     { from  => 1241906400, # 2009-05-10 00:00
       until => 1242424800, # 2009-05-16 00:00
       text  => 'K 7312 Passow - Fredersdorf zw. Passow u. Briest, H�he Briester Weg Bau eines Durchlasses Vollsperrung 11.05.2009-15.05.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 55392,83218 55808,83296 55901,83313
EOF
     },
     { from  => 1241906400, # 2009-05-10 00:00
       until => 1253359337, # 2009-09-26 00:00 1253916000
       text  => 'L 029 Oderberg - Niederfinow OD Liepe, E.-Th�lmann-Stra�e Erneuerung St�tzmauer Vollsperrung 11.05.2009-25.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 48662,51337 49039,51453
EOF
     },
     { from  => 1243807200, # 2009-06-01 00:00
       until => 1251528245, # 2009-09-01 00:00 1251756000
       text  => 'B 102 Wildberg - Neustadt-Dosse Kreuzungsber. B 5 bei B�ckwitz Kreiselneubau Vollsperrung 02.06.2009-31.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -53139,50022 -52854,50094
EOF
     },
     { from  => 1241906400, # 2009-05-10 00:00
       until => 1244930400, # 2009-06-14 00:00
       text  => 'B 158 Blumberg - Werneuchen zw. Seefeld und Werneuchen Deckenerneuerung Vollsperrung 11.05.2009-13.06.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 29103,24437 29528,24348 29791,24336 31924,25478 32253,25457
EOF
     },
     { from  => 1242281874, # 2009-05-14 08:17
       until => 1243578967, # 2009-05-31 23:59 1243807199
       text  => 'Pappelallee (Prenzlauer Berg) in Richtung Sch�nhauser Allee zwischen Gneiststr. und Sch�nhauser Alllee Baustelle, Fahrtrichtung gesperrt (bis Ende 05.2009)',
       type  => 'handicap',
       source_id => 'IM_012659',
       data  => <<EOF,
userdel	q4::inwork; 11119,15385 10881,15047
EOF
     },
     { from  => 1242982031, # 
       until => 1242982046, #
       text  => 'Stra�e der Pariser Kommune (Friedrichshain) in beiden Richtungen zwischen Karl-Marx-Allee und R�dersdorfer Str. geplatzte Wasserleitung, gesperrt',
       type  => 'handicap',
       source_id => 'IM_012636',
       data  => <<EOF,
#: last_checked: 2009-05-21
userdel	q4::inwork 12822,12067 12833,12154 12850,12286 12869,12425
EOF
     },
     { from  => 1252767974, # undef
       until => 1252767981, # XXX undef -> nach handicap_s-orig gewandert
       text  => 'Varian-Fry-Str.: Baustelle, Fahrbahn gesperrt',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 8389,11378 8374,11479
EOF
     },
     { from  => 1242852079, # 2009-06-04 00:00 1244066400
       until => 1242852084, # 2009-06-07 00:00 1244325600
       text  => 'B 096 Luckau - Baruth zw. Gie�mannsdorf und R�dingsdorf Stra�enbauarbeiten Vollsperrung 05.06.2009-06.06.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 31525,-58272 31401,-57829 31077,-57151 30859,-56304
EOF
     },
     { from  => 1243116000, # 2009-05-24 00:00
       until => 1249077600, # 2009-08-01 00:00
       text  => 'L 025 Prenzlau - F�rstenwerder zw. OA Sch�nermark u. OE Kraatz Stra�enbauarbeiten Vollsperrung 25.05.2009-31.07.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 28511,103728 28338,104176 27732,105878 27213,107158 25934,109206 25606,109314
EOF
     },
     { from  => 1242712036, # 2009-05-19 07:47
       until => 1243288800, # 2009-05-26 00:00
       text  => 'Ebertstr. (Tiergarten) in beiden Richtungen zwischen Behrenstr. und Scheidemannstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 25.05.2009) ',
       type  => 'gesperrt',
       source_id => 'IM_012693',
       data  => <<EOF,
userdel	2::temp 8595,12066 8600,12165 8538,12245 8546,12279 8570,12302 8573,12325 8540,12420
EOF
     },
     { from  => 1242712062, # 2009-05-19 07:47
       until => 1245103199, # 2009-06-15 23:59
       text  => 'Gartenstr. (Mitte) vor der Einm�ndung in die Torstr. Baustelle, Fahrbahn gesperrt (bis Mitte 06.2009)',
       type  => 'handicap',
       source_id => 'IM_012706',
       data  => <<EOF,
#: last_checked: 2009-05-28
userdel	q4::inwork 9531,13797 9668,13629
EOF
     },
     { from  => 1242712177, # 2009-05-19 07:49
       until => 1243288800, # 2009-05-26 00:00
       text  => 'Str. des 17. Juni (Tiergarten) in beiden Richtungen zwischen Gro�er Stern und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (bis 25.05.2009)',
       type  => 'gesperrt',
       source_id => 'IM_012692',
       data  => <<EOF,
userdel	2::temp 8538,12245 8303,12216 8214,12205 8089,12190 8055,12186 7816,12150 7383,12095 6828,12031
EOF
     },
     { from  => 1242712208, # 2009-05-19 07:50
       until => 1243288800, # 2009-05-26 00:00
       text  => 'Yitzhak-Rabin-Str. (Tiergarten) in beiden Richtungen zwischen Scheidemannstr. und Str. des 17. Juni Veranstaltung, Stra�e vollst�ndig gesperrt (bis 25.05.2009)',
       type  => 'gesperrt',
       source_id => 'IM_012694',
       data  => <<EOF,
userdel	2::temp 8055,12186 8119,12414
EOF
     },
     { from  => 1242770400, # 2009-05-20 00:00
       until => 1242943200, # 2009-05-22 00:00
       text  => 'B 112 Frankfurter-, Bahnhofstra�e OD Neuzelle 16. Bibulibustag Vollsperrung 21.05.2009-21.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 96017,-33547 96014,-33803
EOF
     },
     { from  => 1243116000, # 2009-05-24 00:00
       until => 1251756000, # 2009-09-01 00:00
       text  => 'B 087 Luckau - Herzberg OD Schlieben Deckenerneuerung Vollsperrung 25.05.2009-31.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 10533,-76130 10891,-76066
EOF
     },
     { from  => 1247954400, # 2009-07-19 00:00
       until => 1253311200, # 2009-09-19 00:00
       text  => 'L 014 Kyritz - Wittstock OD Herzsprung Stra�enausbau Vollsperrung 20.07.2009-18.09.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -54249,73343 -54091,72917 -54034,72687
EOF
     },
     { from  => 1243116000, # 2009-05-24 00:00
       until => 1246312800, # 2009-06-30 00:00
       text  => 'L 014 Kyritz - Wittstock OD Herzsprung grundhafter Stra�enausbau Vollsperrung 25.05.2009-29.06.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -54338,71670 -54116,72465
EOF
     },
     { from  => 1244498400, # 2009-06-09 00:00
       until => 1245362400, # 2009-06-19 00:00
       text  => 'L 144 Herzsprung - Blumenthal OD Herzsprung grundhafter Stra�enausbau Vollsperrung 10.06.2009-18.06.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -54665,72030 -54116,72465
EOF
     },
     { from  => 1306879200, # 1242851109, # 2009-05-20 22:25
       until => 1307311200, # 1243256400, # 2009-05-25 15:00
       text  => 'Oberfeldstr. (Marzahn) in beiden Richtungen zwischen Schulstr. und Nordpromenade Veranstaltung, gesperrt. Ebenso ist die Nordpromenade gesperrt. (2. bis 5. Juni 2011)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 20599,11938 20610,12050
userdel	2::temp 20610,12050 20715,12040
EOF
     },
     { from  => 1242851164, # 2009-05-20 22:26
       until => 1243202400, # 2009-05-25 00:00
       text  => 'Scheidemannstr. (Tiergarten) in beiden Richtungen zwischen Yitzhak-Rabin-Str. und Ebertstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 24.05.09 nachts)',
       type  => 'gesperrt',
       source_id => 'IM_012708',
       data  => <<EOF,
userdel	2::temp 8540,12420 8400,12417 8354,12416 8119,12414
EOF
     },
     { from  => 1243116000, # 2009-05-24 00:00
       until => 1245621600, # 2009-06-22 00:00
       text  => 'B 103 Kyritz - Pritzwalk zw. Kyritz u. Gantikow, Bahn�bergang Erneuerung Bahn�bergang Vollsperrung 25.05.2009-21.06.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -60072,61047 -61764,62280
EOF
     },
     { from  => 1243116000, # 2009-05-24 00:00
       until => 1243807200, # 2009-06-01 00:00
       text  => 'L 014 Rosa-Luxemburg-Stra�e OL Wittstock, Kreuzungsberereich Bohnekampweg Bau Kreisverkehr Vollsperrung 25.05.2009-31.05.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -53648,82294 -53491,81954 -53248,81574
EOF
     },
     { from  => 1243116000, # 2009-05-24 00:00
       until => 1245448800, # 2009-06-20 00:00
       text  => 'L 015 Menz - Rheinsberg OD Menz Stra�enbau Vollsperrung 25.05.2009-19.06.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -15379,77129 -17592,77812
EOF
     },
     { from  => 1244412000, # 2009-06-08 00:00
       until => 1248071647, # 2009-07-21 00:00 1248127200
       text  => 'L 015 Menz - Rheinsberg zw. Menz u. Rheinsberg Stra�enbau Vollsperrung 09.06.2009-20.07.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -24815,76635 -23305,77059 -22937,77020 -22504,76981 -21965,77030 -21728,77161 -21621,77313 -20227,77714 -19875,77881 -19494,78080 -19300,78146 -18544,78020 -17592,77812
EOF
     },
     { from  => 1248559200, # 2009-07-26 00:00
       until => 1249682400, # 2009-08-08 00:00
       text  => 'L 141 B5 - Neustadt OD Dreetz Stra�enbauarbeiten Vollsperrung 27.07.2009-07.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -54456,42981 -53872,42916
EOF
     },
     { from  => 1248200979, # undef
       until => 1248200986, # XXX undef
       text  => 'Mittelstr. zwischen Friedrichstra�e und Neust�dtische Kirchstr.: Bauarbeiten, Fahrbahn gesperrt, Gehweg offen',
       type  => 'handicap',
       data  => <<EOF,
#: last_checked: 2009-05-21
userdel	q4::inwork 9130,12433 9343,12464
EOF
     },
     { from  => 1243370925, # 2009-05-26 22:48
       until => 1262300399, # 2009-12-31 23:59
       text  => 'Blockdammweg (Lichtenberg) Richtung Karlshorst zwischen H�nower Wiesenweg und Ehrlichstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 12/2009)',
       type  => 'handicap',
       source_id => 'IM_012809',
       data  => <<EOF,
userdel	q4::inwork; 17380,8858 17729,8850
EOF
     },
     { from  => 1251530088, # 2009-08-29 09:14
       until => 1251755999, # 2009-08-31 23:59
       text  => 'Glienicker Weg/Glienicker Str. (Treptow) in beiden Richtungen zwischen Adlergestell und Spindlersfelder Str. (DB-Br�cke) Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 08.2009)',
       type  => 'handicap',
       source_id => 'IM_012799',
       data  => <<EOF,
userdel	q4::inwork 21244,3571 21275,3607 21308,3644 21324,3691
EOF
     },
     { from  => 1255162601, # 2009-10-10 10:16
       until => 1255384800, # 2009-10-13 00:00
       text  => 'Glinkastr. (Mitte) in beiden Richtungen zwischen J�gerstr. und Taubenstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 12.10.2009)',
       type  => 'handicap',
       source_id => 'IM_012764',
       data  => <<EOF,
userdel	q4::inwork 9201,11968 9208,11872
EOF
     },
     { from  => 1243116000, # 2009-05-24 00:00
       until => 1246831200, # 2009-07-06 00:00
       text  => 'L 171 Kurt-Tucholsky-Stra�e Ol Hohen Neuendorf, zw. H�he E.-Toller-Str. u. OA Neubau Stra�enbordanlage halbseitig gesperrt; Einbahnstra�e 25.05.2009-05.07.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 1366,29416 1304,29256 1234,29120 1124,28923 1078,28830 1020,28712 1009,28662 1007,28446
EOF
     },
     { from  => 1243116000, # 2009-05-24 00:00
       until => 1244844000, # 2009-06-13 00:00
       text  => 'L 303 Umgehungsstra�e OD Eggersdorf, Krz. E.-Th�lmann-Str. Deckenerneuerung Vollsperrung 25.05.2009-12.06.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 38771,14926 38637,14790
EOF
     },
     { from  => 1243578195, # 2009-05-29 08:23
       until => 1243893600, # 2009-06-02 00:00
       text  => 'Stendaler Str. (Hellersdorf) Richtung Riesaer Str. zwischen Janusz-Korczak-Str. und Hellersdorfer Str. Veranstaltung, gesperrt (bis 01.06.09 nachts)',
       type  => 'handicap',
       source_id => 'IM_012806',
       data  => <<EOF,
userdel	q4::inwork; 23960,15021 23993,14797
EOF
     },
     { from  => 1244671200, # 2009-06-11 00:00
       until => 1245103200, # 2009-06-16 00:00
       text  => 'B 096 Baruth - W�nsdorf OL Neuhof, Bahn�bergang Reperaturarb. am Bahn�bergang halbseitig gesperrt; Einbahnstra�e 12.06.2009-15.06.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 16360,-29489 16379,-29446
EOF
     },
     { from  => 1243807200, # 2009-06-01 00:00
       until => 1259960685, # 2010-02-01 00:00 1264978800
       text  => 'L 076 Mahlow - Teltow zw. Abzw. Birkholz und Abzw. Gro�beeren Stra�enbau Vollsperrung 02.06.2009-31.01.2010 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 7955,-4250 7790,-3985 6012,-3393 5394,-3053
EOF
     },
     { from  => 1243807200, # 2009-06-01 00:00
       until => 1245103200, # 2009-06-16 00:00
       text  => 'K 6304 Priort - B5, Elstal OL Priort, Bahn�bergang Gleisbauarbeiten Vollsperrung 02.06.2009-15.06.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -19058,11636 -19029,11660 -18750,11919
EOF
     },
     { from  => 1243831620, # 2009-06-01 06:47
       until => 1312117200, # 2011-07-31 15:00 # by: wosch (Schlo�allee)
       text  => 'Pasewalker Str. (Pankow): Baustelle, Fahrtrichtung gesperrt (bis Ende 07/2011) stadteinw�rts zwischen Eweststr.und Auffahrt A114, ebenso Einbahnstra�e: Schlo�allee zwischen Pasewalker Str. und Grumbkowstr., u.U. Ausweichen auf Gehweg m�glich; 02.06.2009 06:47 Uhr bis 31.07.2011 15:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_017116',
       data  => <<EOF,
userdel	q4::inwork; 12095,20832 12076,20731 12039,20538 12030,20490 12008,20368 12000,20327 11984,20246 11963,20136 11931,19965 11907,19838 11907,19749
userdel	q4::inwork; 11883,19739 11730,19684
EOF
     },
     { from  => 1243972705, # 2009-06-02 21:58
       until => 1245103199, # 2009-06-15 23:59
       text  => 'Sakrower Landstr. (Kladow) in beiden Richtungen zwischen Krampnitzer Weg und Kindlebenstr. Baustelle, f�r beide Richtungen nur ein Fahrstreifen abwechselnd frei (bis Mitte 06.2009)',
       type  => 'handicap',
       source_id => 'IM_012896',
       data  => <<EOF,
userdel	q3::inwork -7713,4775 -7519,4843
EOF
     },
     { from  => 1244065266, # 2009-06-03 23:41
       until => 1246485599, # 2009-07-01 23:59
       text  => 'Bahnhofstr. (Pankow) in beiden Richtungen zwischen M�nchm�hler Str. und Bahn�bergang Baustelle, Stra�e vollst�ndig gesperrt (bis Anfang 07.2009)',
       type  => 'handicap',
       source_id => 'IM_012890',
       data  => <<EOF,
userdel	q4::inwork 8632,23442 8803,23478 8909,23506
EOF
     },
     { from  => 1244065335, # 2009-06-03 23:42
       until => 1249077599, # 2009-07-31 23:59
       text  => 'Durchfahrt Bayreuther Str. gesperrt (bis Ende 07.2009)',
       type  => 'handicap',
       source_id => 'IM_009958',
       data  => <<EOF,
userdel	q4::inwork 6380,10704 6353,10583
EOF
     },
     { from  => 1245016800, # 2009-06-15 00:00
       until => 1245362400, # 2009-06-19 00:00
       text  => 'B 096 L�wenberg - Gransee OD L�wenberg Deckeneinbau Vollsperrung 16.06.2009-18.06.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -7387,54453 -7352,54661
EOF
     },
     { from  => 1244584800, # 2009-06-10 00:00
       until => 1245103200, # 2009-06-16 00:00
       text  => 'B 096 Nassenheide - L�wenberg OD L�wenberg Deckeneinbau Vollsperrung 11.06.2009-15.06.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -7665,54237 -6983,52753
EOF
     },
     { from  => 1244584800, # 2009-06-10 00:00
       until => 1245103200, # 2009-06-16 00:00
       text  => 'B 096 Nassenheide - L�wenberg OD L�wenberg, Friedrich-Ebert-Str. Deckeneinbau Vollsperrung 11.06.2009-15.06.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -7665,54237 -7387,54453
EOF
     },
     { from  => 1244325600, # 2009-06-07 00:00
       until => 1244671200, # 2009-06-11 00:00
       text  => 'B 167 Liebenberg - L�wenberg OD L�wenberg Deckeneinbau Vollsperrung 08.06.2009-10.06.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -7114,54591 -7387,54453
EOF
     },
     { from  => 1244152800, # 2009-06-05 00:00
       until => 1244325600, # 2009-06-07 00:00
       text  => 'B 167 L�wenberg - Grieben OD L�wenberg Deckeneinbau Vollsperrung 06.06.2009-06.06.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -7665,54237 -7918,54138 -8307,53883
EOF
     },
     { from  => 1244584599, # 2009-06-09 23:56
       until => 1245103199, # 2009-06-15 23:59
       text  => 'Charlottenstr. (Mitte) in beiden Richtungen zwischen Franz�sische Str. und J�gerstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Mitte 06.2009)',
       type  => 'handicap',
       source_id => 'IM_012983',
       data  => <<EOF,
userdel	q4::inwork 9524,12010 9510,12113
EOF
     },
     { from  => 1244785956, # 2009-06-12 07:52
       until => 1244865600, # 2009-06-13 06:00
       text  => 'John-Foster-Dulles-Allee (Tiergarten) in beiden Richtungen zwischen Spreeweg und Yitzhak-Rabin-Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 13.06.2009, ca. 6 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_012990',
       data  => <<EOF,
userdel	2::temp 7039,12314 7215,12295 7437,12368 7514,12387 7627,12380 7821,12367 7875,12363 8017,12359 8070,12409 8119,12414
EOF
     },
     { from  => 1244930400, # 2009-06-14 00:00
       until => 1248127200, # 2009-07-21 00:00
       text  => 'B 102 Treuenbrietzener Str. OD J�terbog, zw. Parkstr. und B�lowstr. Stra�enausbau Vollsperrung 15.06.2009-20.07.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -13108,-46122 -12541,-46115
EOF
     },
     { from  => 1244930400, # 2009-06-14 00:00
       until => 1257030000, # 2009-11-01 00:00
       text  => 'K 6153 L 39 Wenzlow - K�nigs Wusterhausen OD Friedrichshof Stra�enneubau Vollsperrung 15.06.2009-31.10.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 35981,-9481 35666,-9320 35315,-9216
EOF
     },
     { from  => 1244325600, # 2009-06-07 00:00
       until => 1262300400, # 2010-01-01 00:00
       text  => 'K 6828 Altfriesack - Wuthenow OD Karwe, Lange Stra�e Kanal- u. Stra�enbau Vollsperrung 08.06.2009-31.12.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -28001,50966 -27421,50349 -27196,50015
EOF
     },
     { from  => 1244325600, # 2009-06-07 00:00
       until => 1261350000, # 2009-12-21 00:00
       text  => 'K 6938 G�rzke - Hohenlobbese OD G�rzke, zw. B107 und. Reppinicher Str., 2 Bauabschn. Kanalarbeiten Vollsperrung 08.06.2009-20.12.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -59612,-27488 -59438,-27447 -59410,-27340 -59110,-27297 -58946,-27254 -58822,-27227 -58801,-27202
EOF
     },
     { from  => 1244498400, # 2009-06-09 00:00
       until => 1244757600, # 2009-06-12 00:00
       text  => 'L 402 Zeuthen - Schulzendorf Bahn�bergang Forstweg in Zeuthen Gleisbauarbeiten Vollsperrung 10.06.2009-11.06.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 26001,-6257 26057,-6241 26146,-6218
EOF
     },
     { from  => $isodate2epoch->("2013-06-13 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-06-16 23:59:59"),
       periodic => 1,
       text  => 'K�penicker Sommer: Veranstaltung, folgende Stra�en sind gesperrt: Alt-K�penick, Schlossplatz, Schlossinsel und Luisenhain (14.6.2013 bis 16.6.2013)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 22111,4562 22093,4499 22076,4422
userdel	2::temp 22071,4501 22057,4531 22043,4562 22057,4618 22074,4664 22153,4840 22196,4847 22175,4730 22138,4661 22133,4644 22111,4562
userdel	2::temp 22133,4644 22074,4664
# REMOVED --- userdel	2::temp 22111,4562 22162,4546 22214,4548 22324,4586 22314,4604 22355,4660 22365,4676 22395,4678
EOF
     },
     { from  => 1246207038, # 2009-06-28 18:37
       until => 1246485599, # 2009-07-01 23:59
       text  => 'Damerowstr. / Breite Str. (Pankow) Richtung Sch�nholzer Str. nach Mendelstr. Baustelle, Fahrtrichtung gesperrt (bis Anfang 07.2009)',
       type  => 'handicap',
       source_id => 'IM_013029',
       data  => <<EOF,
userdel	q4::inwork; 11357,18598 11204,18545 11168,18542 11001,18528
EOF
     },
     { from  => 1244930400, # 2009-06-14 00:00
       until => 1252706400, # 2009-09-12 00:00
       text  => 'K 6422 Eggersdorfer Str. OL Petershagen, zw. Gravenhainstr. u. Johannesstr. Stra�enausbau Vollsperrung 15.06.2009-11.09.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 36654,13977 35900,13643
EOF
     },
     { from  => 1244757600, # 2009-06-12 00:00
       until => 1244930400, # 2009-06-14 00:00
       text  => 'K 6905 Langerwisch - Wilhelmshorst - B 2 OD Langerwisch, Abzw. Wilhelmshorst Stra�enbau Vollsperrung 13.06.2009-13.06.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -12312,-10337 -12305,-10732
EOF
     },
     { from  => 1250200800, # 2009-08-14 00:00
       until => 1251669600, # 2009-08-31 00:00
       text  => 'L 077 Langerwisch - Saarmund OD Langerwisch, zw. Nahkauf u. Beelitzer Str. Stra�enbau Vollsperrung 15.08.2009-30.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -12915,-10753 -12305,-10732
EOF
     },
     { from  => 1244584800, # 2009-06-10 00:00
       until => 1246658400, # 2009-07-04 00:00
       text  => 'L 082 Zeudener Str. OD Marzahna Kanal- und Stra�enbau Vollsperrung 11.06.2009-03.07.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -33582,-43378 -32661,-44144
EOF
     },
     { from  => 1244844000, # 2009-06-13 00:00
       until => 1245016800, # 2009-06-15 00:00
       text  => 'L 513 Bahnhofstra�e OL Burg, zw. Hauptstra�e u. Am Bahndamm Intern. Folklorelawine Vollsperrung 14.06.2009-14.06.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 62010,-62330 62522,-62647
EOF
     },
     { from  => 1261827633, #  undef
       until => 1261827641, # XXX undef
       text  => 'K�bisstr.: Zugang zum Reichpietschufer wegen Bauarbeiten nicht m�glich',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 7160,11225 7103,11247 6851,11346
EOF
     },
     { from  => 1246206950, # 2009-06-28 18:35
       until => 1247241600, # 2009-07-10 18:00
       text  => 'Charlottenstr. (Mitte) in beiden Richtungen zwischen Taubenstr.. und J�gerstr. sowie Gendarmenmarkt: Classic Open Air, Stra�en vollst�ndig gesperrt (bis 10.07.09, 18 Uhr) ',
       type  => 'gesperrt',
       source_id => 'IM_012983',
       data  => <<EOF,
userdel	2::temp 9668,11928 9536,11912 9524,12010 9656,12021
EOF
     },
     { from  => 1246207852, # 2009-06-28 18:50
       until => 1247695199, # 2009-07-15 23:59
       text  => 'Berliner Str. (Pankow) stadtausw�rts zwischen Am Wasserturm und Romain-Rolland-Str. Baustelle, Fahrtrichtung gesperrt, bis Mitte 07.2009',
       type  => 'handicap',
       source_id => 'IM_013096',
       data  => <<EOF,
userdel	q4::inwork; 12467,17814 12736,17998
EOF
     },
     { from  => 1245658920, # 2009-06-22 10:22
       until => 1303304400, # 2011-04-20 15:00
       text  => 'Kastanienallee (Rosenthal) Richtung Dietzgenstr. zwischen Hauptstr. und Friedrich-Engels-Str. Baustelle, Fahrtrichtung gesperrt (bis 04.2011) ',
       type  => 'handicap',
       source_id => 'IM_013223',
       data  => <<EOF,
userdel	q4::inwork; 7979,20528 8343,20556 8410,20561 8481,20566 8543,20571 8561,20572 8717,20584 8900,20601
EOF
     },
     { from  => 1246208018, # 2009-06-28 18:53
       until => 1247695199, # 2009-07-15 23:59
       text  => 'Romain-Rolland-Str. (Heinersdorf) in beiden Richtungen zwischen Rothenbachstr. und Neukirchstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Mitte 07.2009)',
       type  => 'handicap',
       source_id => 'IM_013086',
       data  => <<EOF,
userdel	q4::inwork 12548,18503 12555,18375 12566,18275
EOF
     },
     { from  => 1246398622, # 2009-06-30 23:50
       until => 1246996643, # 2009-07-15 23:59 1247695199
       text  => 'Dammweg Richtung K�penicker Landstr. gesperrt (bis Mitte Juli 2009)',
       type  => 'handicap',
       data  => <<EOF,
#: last_checked: 2009-06-27
userdel	q4::inwork; 15692,8198 15557,8077
EOF
     },
     { from  => 1245535200, # 2009-06-21 00:00
       until => 1247349600, # 2009-07-12 00:00
       text  => 'B 198 zw. Kerkow u. Greiffenberg Deckenerneuerung Vollsperrung 22.06.2009-11.07.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 48951,71593 48164,72815 47908,73136 47297,73550 47223,73677 46875,75023 46704,75833
EOF
     },
     { from  => 1245535200, # 2009-06-21 00:00
       until => 1249107177, # 2009-09-06 00:00 1252188000
       text  => 'K 6722 B246, Bornow - Gro� Rietz zw. Bornow und Birkholz Stra�enneubau Vollsperrung 22.06.2009-05.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 64933,-24619 64924,-23029
EOF
     },
     { from  => 1246140000, # 2009-06-28 00:00
       until => 1247954400, # 2009-07-19 00:00
       text  => 'L 014 Kyritz - Wittstock OD Herzsprung grundhafter Stra�enausbau Vollsperrung 29.06.2009-18.07.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -54338,71670 -54116,72465
EOF
     },
     { from  => 1246572000, # 2009-07-03 00:00
       until => 1246831200, # 2009-07-06 00:00
       text  => 'L 026 Wollschow - Prenzlau OD Br�ssow 750 Jahre Br�ssow Vollsperrung 04.07.2009-05.07.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 57672,111590 57565,111511 57477,111392
EOF
     },
     { from  => 1245794400, # 2009-06-24 00:00
       until => 1247263200, # 2009-07-11 00:00
       text  => 'L 073 Baruth - Luckenwalde zw. OA Baruth u. OE Paplitz Fahrbahnsanierung Vollsperrung 25.06.2009-10.07.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 17455,-39733 16994,-39479 16400,-39456
EOF
     },
     { from  => 1246485600, # 2009-07-02 00:00
       until => 1246917600, # 2009-07-07 00:00
       text  => 'L 086 Bahnhofstra�e OD Gro� Kreutz, Bahn�bergang Gleisbauarbeiten Vollsperrung 03.07.2009-06.07.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -31993,-726 -32143,-211
EOF
     },
     { from  => 1251064800, # 2009-08-24 00:00
       until => 1251324000, # 2009-08-27 00:00
       text  => 'L 086 Bahnhofstra�e OD Gro� Kreutz, Bahn�bergang Gleisbauarbeiten Vollsperrung 25.08.2009-26.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -31993,-726 -32143,-211 -32153,-176
EOF
     },
     { from  => 1245708000, # 2009-06-23 00:00
       until => 1247954400, # 2009-07-19 00:00
       text  => 'L 144 Herzsprung - Blumenthal OD Herzsprung grundhafter Stra�enausbau Vollsperrung 24.06.2009-18.07.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -54665,72030 -54116,72465
EOF
     },
     { from  => 1246572000, # 2009-07-03 00:00
       until => 1246831200, # 2009-07-06 00:00
       text  => 'L 251 Frauenhagen - Br�ssow OD Br�ssow 750 Jahre Br�ssow Vollsperrung 04.07.2009-05.07.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 57568,111045 57559,111267 57445,111340 57391,111374 57405,111424
EOF
     },
     { from  => 1245621600, # 2009-06-22 00:00
       until => 1247263200, # 2009-07-11 00:00
       text  => 'L 303 Umgehungsstr. OD Eggersdorf, zw. K.-Liebknecht-Str. u. Landhausstr. Stra�enbauarbeiten Vollsperrung 23.06.2009-10.07.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 38983,15053 38771,14926
EOF
     },
     { from  => 1245708000, # 2009-06-23 00:00
       until => 1251496800, # 2009-08-29 00:00
       text  => 'L 412 Bad Saarow - Alt Golm OD Neu Golm, Abzw. F�rstenwalder Str. Kanal- und Stra�enbau Vollsperrung 24.06.2009-28.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 57479,-10535 57752,-10566 57882,-10535
EOF
     },
     { from  => 1246399200, # 2009-07-01 00:00
       until => 1247090399, # 2009-07-08 23:59
       text  => 'Markgrafenstr. (Mitte) in beiden Richtungen zwischen J�gerstr. und Taubenstr. Veranstaltung, gesperrt. Die Markgrafenstr. ist au�erdem zw. Franz�sische Str. und Mohrenstr. vom 02.07.-08.07.09 t�gl. 17-01 Uhr gesperrt.',
       type  => 'gesperrt',
       source_id => 'IM_013316',
       data  => <<EOF,
userdel	2::temp 9643,12127 9656,12021 9668,11928 9679,11834
EOF
     },
     { from  => 1246398785, # 2009-06-30 23:53
       until => 1247341116, # 2009-07-15 23:59 1247695199
       text  => 'Sp�thstr. (Treptow) Richtung A113 zwischen K�nigsheideweg und Britzer Allee Baustelle, Fahrtrichtung gesperrt (bis Mitte 07.2009)',
       type  => 'gesperrt',
       source_id => 'IM_013302',
       data  => <<EOF,
userdel	1::inwork 15382,5687 15363,5668 15183,5480
EOF
     },
     { from  => undef, # 
       until => 1246831199, # 2009-07-05 23:59
       text  => 'Residenzstr. (Reinickendorf) in beiden Richtungen zwischen Pankower Allee und Emmentaler Str. Veranstaltung, Stra�e vollst�ndig gesperrt (Residenzstra�enfest)',
       type  => 'gesperrt',
       source_id => 'IM_013407',
       data  => <<EOF,
userdel	2::temp 7579,17532 7572,17558 7540,17675 7491,17793 7477,17832 7453,17899 7432,17964 7426,17981 7405,18047 7335,18257
EOF
     },
     { from  => 1246831200, # 2009-07-06 00:00
       until => 1254982631, # 2009-11-01 00:00 1257030000
       text  => 'B 112 OU Guben - OU Neuzelle zw. Abzw.Wellmitz und Neuzelle Stra�enneubau Vollsperrung 07.07.2009-31.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 96951,-34887 97016,-36424 97032,-36743 97476,-37327 97680,-37821
EOF
     },
     { from  => 1247608800, # 2009-07-15 00:00
       until => 1251529826, # 2009-09-02 00:00 1251842400
       text  => 'K 6910 Am Wasser OD Schwielowsee, zw. Baumgartenbr�ck u. B 1 Kanal- u. Stra�enbau Vollsperrung 16.07.2009-01.09.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -19332,-5240 -19112,-5226 -19013,-5247
EOF
     },
     { from  => 1246744800, # 2009-07-05 00:00
       until => 1254348000, # 2009-10-01 00:00
       text  => 'L 015 F�rstenberg - Menz OD F�rstenberg, zw. Bergstr. und OA Ri. Menz Stra�enbau, Br�ckenabriss Vollsperrung 06.07.2009-30.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -8893,85743 -9850,84800
EOF
     },
     { from  => 1261769245, # 2009-12-25 20:27
       until => 1276408849, # 2010-06-30 23:59 1277935199
       text  => 'Markgrafenstr. (Mitte) Richtung Behrenstr. zwischen Mohrenstr. und Franz�sische Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 06.10)',
       type  => 'handicap',
       source_id => 'IM_013316',
       data  => <<EOF,
userdel	q4::inwork; 9679,11834 9668,11928 9656,12021 9643,12127
EOF
     },
     { from  => 1247349600, # 2009-07-12 00:00
       until => 1257030000, # 2009-11-01 00:00
       text  => 'K 6145 Drahnsdorf - Gol�en OD Landwehr Stra�enbau Vollsperrung 13.07.2009-31.10.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 24326,-50111 24264,-49146
EOF
     },
     { from  => 1246917600, # 2009-07-07 00:00
       until => 1247090400, # 2009-07-09 00:00
       text  => 'L 021 M�hlenbecker Str. OL Schildow, Nr. 89 Kranarbeiten Vollsperrung 08.07.2009-08.07.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 8103,27587 8189,26883
EOF
     },
     { from  => 1247608800, # 2009-07-15 00:00
       until => 1248991199, # 2009-07-30 23:59
       text  => 'Bauarbeiten in der Frohnauer Stra�e zwischen den Kreuzungsbereichen Alemannenstra�e und Karmeliterweg, 16.07.-30.07.2009, Anliegerverkehr m�glich',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 1868,24633 1838,24675 1802,24707 1736,24722
EOF
     },
     { from  => 1247608800, # 2009-07-15 00:00
       until => 1248991199, # 2009-07-30 23:59
       text  => 'Bauarbeiten in der Alemannenstra�e, Einbahnstra�enregelung zwischen Frohnauer Str. und Maximiliankorso Richtung Norden, 16.07.-30.07.2009',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 1738,25243 1767,25098 1775,25019 1750,24942 1730,24860 1732,24798 1735,24738
EOF
     },
     { from  => 1247255857, # 2009-07-10 21:57
       until => 1249163999, # 2009-08-01 23:59
       text  => 'Bahnhofstr. (Pankow) in beiden Richtungen zwischen M�nchm�hler Str. und Bahn�bergang Baustelle, Stra�e vollst�ndig gesperrt (bis Anfang 08.2009)',
       type  => 'gesperrt',
       source_id => 'IM_012890',
       data  => <<EOF,
userdel	2::inwork 8803,23478 8632,23442 8619,23438 8562,23421
EOF
     },
     { from  => 1247169516, # 2009-07-09 21:58
       until => 1247454000, # 2009-07-13 05:00
       text  => 'Baumschulenstr. (Treptow) in beiden Richtungen zwischen Glanzstr. und Ekkehardstr. (DB-Br�cke) Baustelle, gesperrt (bis Montag 5 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_013579',
       data  => <<EOF,
userdel	2::inwork 16286,6946 16323,6998
EOF
     },
     { from  => 1247255953, # 2009-07-10 21:59
       until => 1247349600, # 2009-07-12 00:00
       text  => 'Bayreuther Str. (Charlottenburg) ebenso n�rdlicher Bereich des Wittenbergplatzes Veranstaltung: Bayreuther Str. ab Kleiststr. gesperrt. bis ca. 11.07.09, 24 Uhr',
       type  => 'handicap',
       source_id => 'IM_013507',
       data  => <<EOF,
userdel	q4::temp 6353,10583 6380,10704 6378,10887
EOF
     },
     { from  => 1247256047, # 2009-07-10 22:00
       until => 1249163999, # 2009-08-01 23:59
       text  => 'Eichelh�herstr. (Reinickendorf) in beiden Richtungen zwischen Habichtstr. und Am Eulenhorst Baustelle, f�r beide Richtungen nur ein Fahrstreifen abwechselnd frei. Bis Anfang 08.2009)',
       type  => 'handicap',
       source_id => 'IM_013510',
       data  => <<EOF,
userdel	q4::inwork -1787,19341 -1826,19541 -1788,19663
EOF
     },
     { from  => 1247090400, # 2009-07-09 00:00
       until => 1247954400, # 2009-07-19 00:00
       text  => 'B 087 Luckau - Schlieben zw. W�stermarke und Hohenbucko Fahrbahnsanierung Vollsperrung 10.07.2009-18.07.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 20927,-67514 22404,-66355 24219,-65378
EOF
     },
     { from  => 1247954400, # 2009-07-19 00:00
       until => 1248300000, # 2009-07-23 00:00
       text  => 'K 6813 B122 - K6812 Z�hlen zw. Zechow und Schwanow Stra�enbauarbeiten Vollsperrung 20.07.2009-22.07.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -24687,71412 -26350,70262 -26671,70334 -27168,70209 -27902,70373
EOF
     },
     { from  => 1248213600, # 2009-07-22 00:00
       until => 1248559200, # 2009-07-26 00:00
       text  => 'K 6813 B122 - K6812 Z�hlen zw. Zechow und Schwanow Stra�enbauarbeiten Vollsperrung 23.07.2009-25.07.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -27902,70373 -29027,70878
EOF
     },
     { from  => 1248559200, # 2009-07-26 00:00
       until => 1252706400, # 2009-09-12 00:00
       text  => 'L 015 Rheinsberg - Dorf Zechlin zw. Abzw. Z�hlen und Linow Stra�enneubau, Vollsperrung 27.07.2009-11.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -29636,76481 -28819,76060 -28278,75780 -27371,75722
EOF
     },
     { from  => 1252792800, # 2009-09-13 00:00
       until => 1253916000, # 2009-09-26 00:00
       text  => 'L 015 Rheinsberg - Dorf Zechlin zw. Rheinsberg und Abzw. Z�hlen Stra�enneubau, Vollsperrung 14.09.2009-25.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -26077,76116 -26509,76113 -26787,75950 -27091,75809 -27371,75722
EOF
     },
     { from  => 1247349600, # 2009-07-12 00:00
       until => 1256857200, # 2009-10-30 00:00
       text  => 'L 024 Greiffenberg - Gerswalde zw. OL Greiffenberg und Wilmersdorf Grundhafter Stra�enbau Vollsperrung 13.07.2009-29.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 45489,76653 45010,77128 44326,77553 43888,77919 43560,78752
EOF
     },
     { from  => 1337887384, # 1247468400, # 2009-07-13 09:00
       until => Time::Local::timelocal(reverse(2012-1900,5-1,31,17,0,0)), # 1281016800, # 2010-08-05 16:00
       text  => 'Hobrechtsfelder Chaussee - Bucher Str.: Br�ckenneubau, Stra�e vollst�ndig gesperrt, bis zum 31.05.2012',
       type  => 'gesperrt',
       source_id => 'INKO_113068',
       data  => <<EOF,
userdel	2::inwork 14314,25193 14219,25013 14029,24753
EOF
     },
     { from  => 1247723876, # 2009-07-16 07:57
       until => 1249077599, # 2009-07-31 23:59
       text  => 'Steglitzer Damm (Steglitz) Richtung Alt-Mariendorf zwischen Biberacher Weg und Attilastr. geplatzte Wasserleitung, Fahrtrichtung gesperrt (bis Ende 07.2009)',
       type  => 'handicap',
       source_id => 'IM_013591',
       data  => <<EOF,
userdel	q4::inwork; 7532,4605 7544,4587 7601,4485
EOF
     },
     { from  => 1249972560, # 2009-08-11 08:36
       until => 1251531024, # 2009-08-31 23:59 1251755999
       text  => 'Colditzstr. (Colditzbr�cke) in beiden Richtungen zwischen Ordensmeisterstra�e und Volkmarstra�e Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 08.2009)',
       type  => 'gesperrt',
       source_id => 'LMS_1623809882',
       data  => <<EOF,
userdel	2::inwork 9893,5569 9863,5637
EOF
     },
     { from  => 1247954400, # 2009-07-19 00:00
       until => 1251669600, # 2009-08-31 00:00
       text  => 'B 109 Prenzlau - Pasewalk OD G�ritz bis LG MVP Deckensanierung Vollsperrung 20.07.2009-30.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 44133,114908 43702,113455 43389,112844 43076,112210
EOF
     },
     { from  => 1247608800, # 2009-07-15 00:00
       until => 1251529861, # 2009-08-31 00:00 1251669600
       text  => 'L 038 zw. OA Hangelsberg u. Kreisverkehrsplatz Stra�eninstandsetzungsarbeiten Vollsperrung 16.07.2009-30.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 45037,31 43880,303 43456,337 42926,155
EOF
     },
     { from  => 1247436000, # 2009-07-13 00:00
       until => 1249768800, # 2009-08-09 00:00
       text  => 'L 212 Gro� Sch�nebeck - Hammer - B167 zw. B�hmerheide und Hammer Deckensanierung Vollsperrung 14.07.2009-08.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 12431,52894 12615,52952 13967,53380 15301,53802 15886,54280 17031,55218 17658,55401
EOF
     },
     { from  => 1300313794, # 2011-03-16 23:16
       until => 1306879200, # 2011-06-01 00:00
       text  => 'J�terbog: B102: Stra�enausbau - Bordumpflasterung an Mittelinseln OD J�terbog LSA-Regelung bei Baut�tigkeit, 15.06.2009 bis 31.05.2011 ',
       type  => 'handicap',
       source_id => 'LS/S-SG33-W/09/135',
       data  => <<EOF,
userdel	q4::inwork -12541,-46115 -13108,-46122
EOF
     },
     { from  => 1247608800, # 2009-07-15 00:00
       until => 1250546400, # 2009-08-18 00:00
       text  => 'B 167 Marienwerderstr. OD Finowfurt, zw. Anschlu�stelle A 11 u. Lehmschulzenstr. Stra�emerneuerung Vollsperrung 16.07.2009-17.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 28575,49756 27822,49878 27566,49942
EOF
     },
     { from  => 1250460000, # 2009-08-17 00:00
       until => 1251583200, # 2009-08-30 00:00
       text  => 'B 167 Marienwerderstr. OD Finowfurt, zw. Lehmschulzenstr. u. Tankstelle Stra�emerneuerung Vollsperrung 18.08.2009-29.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 28575,49756 27822,49878 27566,49942
EOF
     },
     { from  => 1240005600, # 2009-04-18 00:00
       until => 1249077600, # 2009-08-01 00:00
       text  => 'L 273 B166 - Stendell - Woltersdorf zw. Jamikow und Woltersdorf Kanal- und Stra�enbau Vollsperrung 19.04.2009-31.07.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 64018,86876 63805,86748 63574,86547 63391,86474 63202,86383 62757,86072 61678,85560
EOF
     },
     { from  => 1247954400, # 2009-07-19 00:00
       until => 1249676747, # 2009-08-14 23:59 1250287199
       text  => 'Stra�enbauarbeiten in der Sch�neberger Stra�e von 20. Juli 2009 bis 14. August 2009',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-steglitz-zehlendorf/presse/archiv/20090715.1320.132295.html',
       data  => <<EOF,
userdel	q4::inwork; 5370,6486 5470,6423 5582,6360
EOF
     },
     { from  => 1248040800, # 2009-07-20 00:00
       until => 1250892000, # 2009-08-22 00:00
       text  => 'B 320 Guben - Lieberose zw. Pinnow und Staakow Deckenerneuerung Vollsperrung 21.07.2009-21.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 87008,-46244 80025,-45601 79205,-45332
EOF
     },
     { from  => 1247954400, # 2009-07-19 00:00
       until => 1248071489, # 2009-11-15 00:00 1258239600
       text  => 'L 028 L 33, Wriezen - Neureetz OD Alt M�rdewitz Grundhafter Stra�enausbau Vollsperrung 20.07.2009-14.11.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 61432,38883 61546,39041 61413,39860
EOF
     },
     { from  => 1248213600, # 2009-07-22 00:00
       until => 1260572400, # 2009-12-12 00:00
       text  => 'L 059 Hainschestra�e Br�cke �ber den Binnengraben in Bad Liebenwerda Br�ckenneubau Vollsperrung 23.07.2009-11.12.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 12383,-99327 12173,-99115
EOF
     },
     { from  => 1248200556, # 2009-07-21 20:22
       until => 1258131416, # was 1257030000, 2009-11-01 00:00, bis Oktober 2009, but seems to be more work...; -> nach handicap_s-orig gewandert
       text  => 'Fahrbahn der Mauerstr. wegen Bauarbeiten gesperrt ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 9405,11413 9331,11497
EOF
     },
     { from  => 1248200777, # 2009-07-21 20:26
       until => 1258131029, # was 2009-10-01 00:00, 1254348000, bis September 2009, but seems to be more work... 
       text  => 'Bauarbeiten in der Mohrenstra�e, Fahrbahn gesperrt ',
       type  => 'handicap',
       data  => <<EOF,
#: last_checked: 2009-10-21
userdel	q4::inwork 9418,11804 9220,11781
EOF
     },
     { from  => 1259937995, # 
       until => 1259937999, # XXX -> nach handicap_s-orig gewandert
       text  => 'Die Charlottenstra�e ist wegen Bauarbeiten eine Einbahnstra�e Richtung S�den',
       type  => 'handicap',
       data  => <<EOF,
#: last_checked: 2009-10-16
userdel	q4::inwork; 9475,12365 9462,12481 9454,12558
EOF
     },
     { from  => 1248299511, # 2009-07-22 23:51
       until => 1253051999, # 2009-09-15 23:59
       text  => 'Buntzelstr. (Treptow) Richtung Waltersdorfer Str. zwischen Dahmestr. und Waltersdorfer Str. Baustelle, Fahrtrichtung gesperrt. (bis Mitte 09.2009)',
       type  => 'handicap',
       source_id => 'IM_013726',
       data  => <<EOF,
userdel	q4::inwork; 21968,-15 21977,-8 22108,82 22145,208
EOF
     },
     { from  => 1248559200, # 2009-07-26 00:00
       until => 1249682400, # 2009-08-08 00:00
       text  => 'B 168 zw. Beeskow B� Oegeln u. Ragow Deckenerneuerung Vollsperrung 27.07.2009-07.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 70065,-24817 70924,-23663
EOF
     },
     { from  => 1247608800, # 2009-07-15 00:00
       until => 1251583200, # 2009-08-30 00:00
       text  => 'L 038 Falkenberg - F�rstenwalde zw. Berkenbr�ck u. F�rstenwalde Deckenerneuerung Vollsperrung 16.07.2009-29.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 58249,-5090 58861,-5262 59449,-5351 60003,-5190 60687,-5131 60784,-5060 60918,-4953
EOF
     },
     { from  => 1248559200, # 2009-07-26 00:00
       until => 1249423200, # 2009-08-05 00:00
       text  => 'L 063 Berliner-, Finsterwalder Str. Bahn�bergang in Lauchhammer West Gleisbauarbeiten Vollsperrung 27.07.2009-04.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 35072,-102150 35379,-103141 35482,-103562
EOF
     },
     { from  => 1251324000, # 2009-08-27 00:00
       until => 1251756000, # 2009-09-01 00:00
       text  => 'L 063 Berliner-, Finsterwalder Str. Bahn�bergang in Lauchhammer West Gleisbauarbeiten Vollsperrung 28.08.2009-31.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 35072,-102150 35379,-103141 35482,-103562
EOF
     },
     { from  => 1248213600, # 2009-07-22 00:00
       until => 1249941600, # 2009-08-11 00:00
       text  => 'L 435 Mixdorf - M�llrose OD M�llrose, Mixdorfer Stra�e Kanal- u. Stra�enbau Vollsperrung 23.07.2009-10.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 79650,-16999 79549,-17498 79628,-17759
EOF
     },
     { from  => 1248127200, # 2009-07-21 00:00
       until => 1250892000, # 2009-08-22 00:00
       text  => 'L 715 zw- Hohenalsdorf u. Borgisdorf u. Werbig Deckenerneuerung Vollsperrung 22.07.2009-21.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -2997,-52781 -6384,-53390
EOF
     },
     { from  => undef, # 
       until => 1248600361, # 2009-07-26 23:59 1248645599
       text  => 'Stra�e des 17. Juni (Tiergarten) in beiden Richtungen zwischen Yitzhak-Rabin-Str. und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt, au�erdem gesperrt: Ebertstr. zwischen Behrenstr. und Dorotheenstr.',
       type  => 'gesperrt',
       source_id => 'IM_013767',
       data  => <<EOF,
userdel	2::temp 8055,12186 8089,12190 8214,12205 8303,12216 8538,12245 8546,12279 8570,12302 8573,12325 8540,12420
userdel	2::temp 8538,12245 8600,12165 8595,12066
EOF
     },
     { from  => 1248645600, # 2009-07-27 00:00
       until => 1249973521, # 2009-08-15 00:00 1250287200
       text  => 'L 023 Berliner Stra�e OL Strausberg, zw. Elefantenpfuhl u. Altlandsb. Chaussee Stra�enbauarbeiten Vollsperrung 28.07.2009-14.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 41698,17577 41193,17512
EOF
     },
     { from  => 1248559200, # 2009-07-26 00:00
       until => 1249941600, # 2009-08-11 00:00
       text  => 'L 040 L 23, Storkow - Friedersdorf zw. Abzw. Rieplos und Abzw. Alt Stahnsdorf Deckenerneuerung Vollsperrung 27.07.2009-10.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 45753,-14154 45263,-14192 44580,-14101 44261,-14205
EOF
     },
     { from  => 1247781600, # 2009-07-17 00:00
       until => 1249077600, # 2009-08-01 00:00
       text  => 'L 337 zw. B168 vor Tiefensee und B158 Werftpfuhl Deckenerneuerung Vollsperrung 18.07.2009-31.07.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 39155,29093 38087,29075 36975,29112
EOF
     },
     { from  => 1249106357, # 2009-08-01 07:59
       until => 1249304400, # 2009-08-03 15:00
       text  => 'Am Ostbahnhof (Friedrichshain) in beiden Richtungen zwischen Andreasstr. und Koppenstr. Veranstaltung, gesperrt (bis 03.08.09, ca. 15 Uhr)',
       type  => 'handicap',
       source_id => 'IM_013842',
       data  => <<EOF,
userdel	q4::temp 12310,11682 12208,11746
EOF
     },
     { from  => $isodate2epoch->("2013-06-14 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-06-16 23:59:59"),
       periodic => 1,
       text  => 'Badstr. (Wedding) zwischen Pankstr. und Behmstr. Veranstaltung (Seifenkistenderby), Stra�e vollst�ndig gesperrt (15. und 16. Juni 2013)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 9134,15953 9059,16038 8993,16100 8928,16158 8862,16208 8788,16264
EOF
     },
     { from  => 1249106497, # 2009-08-01 08:01
       until => 1249279200, # 2009-08-03 08:00
       text  => 'H�ttenweg (Grunewald) in beiden Richtungen zwischen A115 und Koenigsallee Bauarbeiten, Stra�e vollst�ndig gesperrt (bis 03.08.2009 morgens)',
       type  => 'gesperrt',
       source_id => 'IM_013853',
       data  => <<EOF,
userdel	2::inwork -130,6694 -739,6838 -927,6888
EOF
     },
     { from  => 1249106526, # 2009-08-01 08:02
       until => 1251531051, # 2009-08-31 23:59 1251755999
       text  => 'K�penicker Str. (Marzahn) in beiden Richtungen zwischen Heesestr. und Alfelder Str. Baustelle, gesperrt (bis Ende 08/2009)',
       type  => 'handicap',
       source_id => 'IM_013806',
       data  => <<EOF,
userdel	q4::inwork 21164,9960 21115,9842
EOF
     },
     { from  => 1248904800, # 2009-07-30 00:00
       until => 1249268400, # 2009-08-03 05:00
       text  => 'Salzufer (Charlottenburg) ebenso Gutenbergstr., Margarete-K�hn-Str., Hannah-Karminski-Str. Veranstaltung (31.07.09 - 02.08.09), gesperrt (bis 03.08.09, ca. 5 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_013844',
       data  => <<EOF,
userdel	2::temp 5253,12079 5231,12122 5181,12195 5243,12303 5325,12234
userdel	2::temp 5181,12195 5133,12240 5203,12387 5243,12303
EOF
     },
     { from  => 1249414524, # undef
       until => 1249414528, # XXX undef
       text  => 'Schlichtallee (Lichtenberg) in beiden Richtungen zwischen L�ckstr. und Hauptstr. Stra�ensch�den, Stra�e vollst�ndig gesperrt',
       type  => 'handicap',
       source_id => 'IM_013849',
       data  => <<EOF,
userdel	q4::inwork 15639,10469 15758,10578 15982,10765 16003,10797 16032,10842
EOF
     },
     { from  => 1249768800, # 2009-08-09 00:00
       until => 1251496800, # 2009-08-29 00:00
       text  => 'B 246 zw. Glienicke und Wendisch Rietz Deckenerneuerung Vollsperrung 10.08.2009-28.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 53843,-21346 54296,-20909 56184,-21060 57404,-20885
EOF
     },
     { from  => 1249768800, # 2009-08-09 00:00
       until => 1250546400, # 2009-08-18 00:00
       text  => 'B 246 zw. Sch�nhagen und L�wendorf Deckenerneuerung Vollsperrung 10.08.2009-17.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -3076,-20676 -4099,-20574
EOF
     },
     { from  => 1248732000, # 2009-07-28 00:00
       until => 1254348000, # 2009-10-01 00:00
       text  => 'K 6722 Bornow - Gro� Rietz zw. Birkholz und Gro� Rietz Stra�enneubau Vollsperrung 29.07.2009-30.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 65774,-20483 65659,-21355 65445,-21565 65314,-22074 65076,-22519
EOF
     },
     { from  => 1249336800, # 2009-08-04 00:00
       until => 1259967600, # 2009-12-05 00:00
       text  => 'K 7346 Rudolf-Breitscheid-Str. OL Angerm�nde, zw. Pestalozzistr. u. Sternefelder Weg Kanal- und Stra�enbau Vollsperrung 05.08.2009-04.12.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 48657,68265 49286,68297 49503,68415
EOF
     },
     { from  => 1248559200, # 2009-07-26 00:00
       until => 1261177200, # 2009-12-19 00:00
       text  => 'L 015 Schlo�str., Menzer Str. OD Rheinsberg, zw. Berliner Str. u. Kiefernweg Stra�enbauarbeiten Vollsperrung 27.07.2009-18.12.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -24965,76568 -25211,76393 -25508,76444
EOF
     },
     { from  => 1249164000, # 2009-08-02 00:00
       until => 1251583200, # 2009-08-30 00:00
       text  => 'L 023 Britz - Joachimsthal Bereich AS Chorin Grundhafter Ausbau Vollsperrung 03.08.2009-29.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 35405,59832 35962,59463
EOF
     },
     { from  => 1249113600, # 2009-08-01 10:00
       until => 1249243200, # 2009-08-02 22:00
       text  => 'Oberbaumbr�cke: gesperrt wegen der 7. Open-Air-Gallery, am 2. August 2009 von 10.00 Uhr bis 22.00 Uhr',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 13178,10623 13206,10651 13305,10789 13332,10832
EOF
     },
     { from  => 1249153223, # 2009-08-01 21:00
       until => 1251496799, # 2009-08-28 23:59
       text  => 'Erwin-Bock-Stra�e zwischen Alfred-Randt-Stra�e und M�ggelschl��chenweg: von der 30. bis 35. Kalenderwoche wird abschnittsweise unter einer halbseitigen bzw. Vollsperrung die Betonfahrbahn abgefr�st und durch eine bitumin�se Dechschicht erneuert.',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-treptow-koepenick/presse/archiv/20090722.1425.132805.html',
       data  => <<EOF,
userdel	q4::inwork 23749,3868 23749,3883 23753,4218
EOF
     },
     { from  => 1248559200, # 2009-07-26 00:00
       until => 1249941599, # 2009-08-10 23:59
       text  => 'Bellevuestra�e und Seelenbinderstra�e von Bahnhofstra�e bis Bellevuestra�e: Einbahnstra�e in Richtung F�rstenwalder Damm vom 27.7. bis zum 10.8.2009',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 22294,5777 22513,5747 22608,5732 22696,5728 22798,5731 22897,5740 23092,5762 23333,5710 23402,5483
EOF
     },
     { from  => 1249768800, # 2009-08-09 00:00
       until => 1250978399, # 2009-08-22 23:59
       text  => 'Bellevuestra�e und Seelenbinderstra�e von Bahnhofstra�e bis Bellevuestra�e: Einbahnstra�e in Richtung Bahnhofstr. vom 10.8. bis zum 22.8.2009',
       type  => 'handicap',
       # XXX URL existiert nicht mehr: source_id => 'http://www.berlin.de/ba-treptow-koepenick/presse/archiv/',
       data  => <<EOF,
userdel	q4::inwork; 22294,5777 22513,5747 22608,5732 22696,5728 22798,5731 22897,5740 23092,5762 23333,5710 23402,5483
EOF
     },
     { from  => 1252879200, # 2009-09-14 00:00
       until => 1254347999, # 2009-09-30 23:59
       text  => 'Bauarbeiten in der Buntzelstr. zwischen Parchwitzer Str. und Paradiesstr., Einbahnstra�enregelung, etwa vom 15.9. bis zum 30.9.2009',
       type  => 'handicap',
       source_id => 'IM_013726', # auch: http://www.berlin.de/ba-treptow-koepenick/presse/archiv/
       data  => <<EOF,
userdel	q4::inwork; 21355,-309 21235,-354 21157,-413 21120,-444
EOF
     },
     { from  => 1249154403, # 2009-08-01 21:20
       until => 1252965600, # 2009-09-15 00:00
       text  => 'Hebbelstra�e - Trinkwasserverlegung Voraussichtlich bis Anfang September werden Bauarbeiten zur Verlegung einer Trinkwasserleitung in der westlichen Hebbelstra�e zwischen Mittelstra�e und Kurf�rstenstra�e durchgef�hrt. W�hrend der Bauzeit wird in der Hebbelstra�e eine Einbahnstra�e in Richtung Kurf�rstenstra�e eingerichtet. ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; -12571,-581 -12545,-698
EOF
     },
     { from  => 1247349600, # 2009-07-12 00:00
       until => 1255384800, # 2009-10-13 00:00
       text  => 'Seit dem 13.07.2009 erfolgt der Bau einer Regenwasserleitung in der Steinstra�e zwischen Gro�beerenstra�e und Hubertusdamm. Die Arbeiten werden unter Vollsperrung der Steinstra�e durchgef�hrt. Die Arbeiten werden voraussichtlich drei Monate andauern. ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -7060,-3124 -7266,-2736
EOF
     },
     { from  => 1249164000, # 2009-08-02 00:00
       until => 1251064800, # 2009-08-24 00:00
       text  => 'Ab 03.08.2009 muss die Fr.-Ebert-Stra�e in H�he Stadthaus wegen Gleisbauarbeiten und Leitungsarbeiten f�r den Verkehr gesperrt werden. Die Arbeiten dauern vorausichtlich bis 24.08.2009.',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -12872,-565 -12865,-425
EOF
     },
     { from  => 1246140000, # 2009-06-28 00:00
       until => 1262214000, # 2009-12-31 00:00
       text  => 'Aufgrund der Arbeiten zum Stra�enneubau und der Verlegung von Schmutz- und Regenwasserleitungen kommt es ab dem 29.06.2009 zu Vollsperrungen der Otto-Nagel-Stra�e. Begonnen wird an der Kreuzung Berliner Stra�e. Die gesamte Ma�nahme wir voraussichtlich zum Ende des 4. Quartals abgeschlossen werden. ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -12054,-274 -11978,-348 -11877,-478
EOF
     },
     { from  => 1251756000, # 2009-09-01 00:00
       until => 1260831600, # 2009-12-15 00:00
       text  => 'Fu�g�ngertunnel Lange Br�cke: vollst�ndig gesperrt (September 2009 - Dezember 2009)',
       type  => 'gesperrt',
       source_id => 'http://www.potsdam.de/cms/beitrag/10051448/757395/',
       data  => <<EOF,
userdel	2::inwork -12669,-1768 -12608,-1715
EOF
     },
     { from  => 1249768800, # 2009-08-09 00:00
       until => 1250546400, # 2009-08-18 00:00
       text  => 'B 246 Trebbin - Beelitz OL Sch�nhagen, zw. OE aus Ri. Trebbin u. Abzw. Blankensee Deckensanierung Vollsperrung 10.08.2009-17.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -6477,-21754 -6207,-21822 -5205,-21433 -4354,-20661
EOF
     },
     { from  => 1249596000, # 2009-08-07 00:00
       until => 1249941600, # 2009-08-11 00:00
       text  => 'L 029 Wandlitz - Zehlendorf zw. Stolzenhagen u. B� Zehlendorf Stra�enausbesserungsarbeiten Vollsperrung 08.08.2009-10.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 9356,42175 9475,42182 9540,42187 9767,42206 10034,42225 10418,42259 11393,41903 11975,41509 12132,41423
EOF
     },
     { from  => 1253052000, # 2009-09-16 00:00
       until => 1253570400, # 2009-09-22 00:00
       text  => 'L 030 Friedrichstr. OD Erkner, zw. Kreisverkehr u. Beuststr. 17. Heimatfest Vollsperrung 17.09.2009-21.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 34443,1951 34250,2546
EOF
     },
     { from  => 1249941600, # 2009-08-11 00:00
       until => 1251496800, # 2009-08-29 00:00
       text  => 'L 040 L 23, Storkow - Friedersdorf zw. Abzw. Alt Stahnsdorf u. Abzw. Kummersdorf Deckenerneuerung Vollsperrung 12.08.2009-28.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 44261,-14205 43456,-14384 42430,-14398
EOF
     },
     { from  => 1249250400, # 2009-08-03 00:00
       until => 1249768800, # 2009-08-09 00:00
       text  => 'L 272 Vierraden - Woltersdorf OD Kunow Stra�enausbesserungsarbeiten Vollsperrung 04.08.2009-08.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 66998,82800 66940,82666 66943,82495
EOF
     },
     { from  => 1251530039, # 2009-08-29 09:13
       until => 1275343199, # 2010-05-31 23:59
       text  => 'Friedrich-Engels-Str. (Pankow) stadteinw�rts zwischen Platanenstr. und Pastor-Niem�ller-Platz Baustelle, Fahrtrichtung gesperrt (bis Ende 05/2010)',
       type  => 'handicap',
       source_id => 'IM_013876',
       data  => <<EOF,
userdel	q4::inwork; 9355,19789 9408,19707 9468,19599 9606,19510 9698,19443 9791,19363
EOF
     },
     { from  => 1249365600, # 2009-08-04 08:00
       until => 1249934400, # 2009-08-10 22:00
       text  => 'Sperrung der Stra�e der Pariser Kommune zwischen Weidenweg / Palisadenstr. und Karl-Marx-Allee, Sperrung der Koppenstr. zwischen Karl-Marx-Allee und Stichstr., sowie Sperrung der Lebuserstr. zwischen Neue Weberstr. und Karl-Marx-Allee Grund: Veranstaltung. Dauer: vom 05.08.09, 08:00 Uhr bis 10.08.09, 22:00 Uhr. (08:07) ',
       type  => 'handicap',
       source_id => 'LMS_2386386548',
       data  => <<EOF,
userdel	q4::temp 12635,12629 12596,12472
userdel	q4::temp 12360,12505 12362,12540 12364,12589
userdel	q4::temp 12891,12549 12869,12425
EOF
     },
     { from  => 1249676503, # 2009-08-07 22:21
       until => 1251280800, # 2009-08-26 12:00
       text  => 'Stra�e des 17. Juni In beiden Richtungen zwischen Brandenburger Tor und Yitzhak-Rabin-Str. gesperrt (bis 26.08.09, 12 Uhr)',
       type  => 'gesperrt',
       source_id => 'LMS_2287412476',
       data  => <<EOF,
userdel	2::temp 8089,12190 8214,12205 8303,12216 8538,12245
EOF
     },
     { from  => undef, # 
       until => 1249768799, # 2009-08-08 23:59
       text  => 'Paul-L�be-Allee (Tiergarten) in beiden Richtungen H�he Willy-Brandt-Str. Veranstaltung, gesperrt (bis Samstag Nacht)',
       type  => 'handicap',
       source_id => 'IM_013880',
       data  => <<EOF,
userdel	q4::temp 8207,12608 8306,12609
EOF
     },
     { from  => 1249768800, # 2009-08-09 00:00
       until => 1251151200, # 2009-08-25 00:00
       text  => 'Ilsestr., Bauarbeiten 10.8.2009 - 24.8.2009',
       type  => 'handicap',
       source_id => 'MoPo 8. August 2009',
       data  => <<EOF,
userdel	q4::inwork 12645,7087 12632,7137 12613,7236
EOF
     },
     { from  => 1250373600, # 2009-08-16 00:00
       until => 1251756000, # 2009-09-01 00:00
       text  => 'Hannemannstr., Bauarbeiten 17.8.2009 - 31.8.2009',
       type  => 'handicap',
       source_id => 'MoPo, 8. August 2009',
       data  => <<EOF,
userdel	q4::inwork 13158,5490 13075,5470
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Innovationspark K�penick: Privatstra�e, nachts ab 20 Uhr und am Wochenende gesperrt',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
#: note: Sperrung best�tigt von Stefan (s.sms): vvv
#: note: genauere Uhrzeit von Dieter Heimann
#: confirmed_by: um 20:30 Uhr steht man vor einem geschlossenen Tor, zumindest an der Nordostseite (2012-08)
Am Wuhleufer, Innovationspark K�penick: Privatstra�e, nachts ab 20 Uhr und am Wochenende gesperrt	2::night:weekend 21683,6946 21498,7153 21475,7500 21497,7597 21546,7635
Stra�e am Wald, Innovationspark K�penick: Privatstra�e, nachts ab 20 Uhr und am Wochenende gesperrt	2::night:weekend 21475,7500 21341,7487 21025,7349
#: note: ^^^
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Neuer Garten: Wege sind nur zwischen 6 Uhr bis zum Einbruch der Dunkelheit ge�ffnet',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	2::night -11615,853 -11715,959 -11818,993 -11871,1087 -12081,1168 -12094,1273 -12139,1325
	2::night -11650,590 -11603,721 -11615,853
	2::night -11510,810 -11562,918 -11575,1031 -11537,1206 -11544,1262 -11580,1281 -11871,1185 -11990,1214 -12124,1359 -12141,1357
	2::night -11615,853 -11510,810 -11412,784 -11392,762 -11231,696
(�konomieweg, Neuer Garten): Weg ist nur zwischen 6 Uhr bis zum Einbruch der Dunkelheit ge�ffnet 	2::night -12528,-11 -12518,13 -12537,48 -12531,75 -12475,116 -12448,246 -12373,288 -12276,554 -12182,816 -12154,963 -12186,1118 -12148,1245 -12139,1325 -12141,1357 -12166,1384
Neuer Garten, Westufer des Heiligen Sees: Weg ist nur zwischen 6 Uhr bis zum Einbruch der Dunkelheit ge�ffnet 	2::night -12265,-418 -12263,-403 -12262,-362 -12328,-212 -12334,-114 -12321,9 -12278,134 -12156,193 -12103,315 -12143,353 -12115,409 -12068,384 -11990,790 -11950,781 -11887,837 -11856,950 -11818,993
Neuer Garten (am Portierhaus) - Weinmeisterstr.: Weg ist nur zwischen 6 Uhr bis zum Einbruch der Dunkelheit ge�ffnet 	2::night -12334,-114 -12424,-107 -12453,-36 -12518,13 -12561,35
Neuer Garten: Weg ist nur zwischen 6 Uhr bis zum Einbruch der Dunkelheit ge�ffnet	2::night -12332,585 -12276,554 -12115,409
	2::night -12263,-403 -12280,-385 -12306,-378 -12357,-307 -12371,-284 -12396,-298
	2::night -12449,-186 -12440,-181 -12449,-134 -12424,-107
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Sanssouci: Wege sind nur zwischen 6 Uhr bis zum Einbruch der Dunkelheit ge�ffnet',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
(Am Neuen Palais, direkter Weg) 	2::night -15810,-1274 -15820,-1146 -15854,-656
(Am Gr�nen Gitter, Sanssouci): Weg ist nur zwischen 6 Uhr bis zum Einbruch der Dunkelheit ge�ffnet 	2::night -13857,-1040 -14153,-1135 -14171,-1026
(�konomieweg, Sanssouci): Weg ist nur zwischen 6 Uhr bis zum Einbruch der Dunkelheit ge�ffnet 	2::night -14171,-1026 -14482,-1043 -14622,-1138 -14865,-1118 -15025,-1096 -15553,-1139 -15651,-1137 -15820,-1146
(Lennestr. - �konomieweg, Sanssouci): Weg ist nur zwischen 6 Uhr bis zum Einbruch der Dunkelheit ge�ffnet 	2::night -14614,-1342 -14856,-1223 -14865,-1118
(Affengang, Sanssouci): Weg ist nur zwischen 6 Uhr bis zum Einbruch der Dunkelheit ge�ffnet 	2::night -14129,-1258 -14131,-1181 -14153,-1135
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Schlo�park Charlottenburg: bei Dunkelheit geschlossen',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	2::night 3332,12742 3231,12749 3127,12793 3065,12975 3016,13315 2987,13448 2953,13489 2950,13552
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => '(Neue Gr�nstr. - Alte Jakobstr.): Der Hofdurchgang ist nachts zwischen 23 und 6 Uhr sowie an Sonn- und Feiertagen geschlossen',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	2::night:weekend 10624,11548 10526,11612
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Eberbacher Str.: Di und Fr 08.00-13.00 wegen Wochenmarkt zwischen Binger Str und R�desheimer Str gesperrt',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
######################################################################
# Wochenm�rkte vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
	q4::temp:clock 4397,7375 4330,7375 4162,7375 4059,7375
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Nestorstr.: Di und Fr 08.00-13.00 Wochenmarkt, Behinderungen m�glich',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	q4::temp:clock 3374,10201 3359,9968 3347,9793
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Maybachufer: Di und Fr 11.00-18.30 Wochenmarkt, Behinderungen m�glich',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	q4::temp:clock 11543,10015 11669,9987 11880,9874
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Friedrichstra�e: zwischen Franz-Kl�hs-Str. und Mehringplatz, Markt Do 10.00-18.00 und Sa 08.00-13.00, Behinderungen m�glich',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
#: note: http://www.berlin.de/ba-friedrichshain-kreuzberg/wirtschaftsfoerderung/wirtschaftsstandort/maerkte.html
	q4::temp:clock 9570,10566 9587,10421
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Crellestr: Mi und Sa 10.00-15.00 Wochenmarkt, Behinderungen m�glich',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	q4::temp:clock 7882,9490 7836,9413 7771,9389
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Charlottenbrunner Str.: Mo und Do 09.00-14.00 Wochenmarkt, Ausweichen auf Gehweg',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	q4::temp:clock 3073,9020 2972,9037
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Karl-August-Platz, Weimarer Str.: Mi 08.00-13.00 und Sa 08.00-14.00 Wochenmarkt, Behinderungen m�glich',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	q4::temp:clock 4101,11347 4101,11233
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Richard-Wagner-Platz: Wochenmarkt Mo und Do 08.00-13.00, Behinderungen m�glich',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	q4::temp:clock 3763,12279 3701,12279
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Ladiusmarkt in der Andr�ezeile: Wochenmarkt Dienstag, Donnerstag und Sonnabend, Behinderungen m�glich',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	q4::temp:clock 1020,496 1078,443
EOF
     },
     { from  => undef, #
       until => undef, #
       #: by: Stefan Klinkusch (korrigierte Wochentage)
       text  => 'Preu�enallee zwischen Marathonallee und Badenallee: Wochenmarkt Di 08.00-13.00 und Fr 08.00-13.00, Behinderungen m�glich',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	q4::temp:clock 589,11953 577,11837 562,11710 560,11695 550,11607
# Wochenm�rkte ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
######################################################################
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Uferpromenade und Invalidenfriedhof nachts geschlossen, �ffnungszeiten Winter (1.10-15.3.) 7.00-18.30, Sommer (16.3.-30.9.) 7.00-21.30',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
#: by: Marek B�nsch:
#: confirmed_by: srt
	2::night 8337,13541 8248,13659 8101,13901 8119,13912 8096,13951 8011,14096
	2::night 8096,13951 8200,14016
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Park Biesdorf nachts geschlossen, �ffnungszeiten 6.00-23.00',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	2::night 21150,11925 21132,11943 21100,11960 20862,12027 20810,12031
	2::night 20862,12027 20836,11768
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Breite Gasse: nur von 9 Uhr bis zum Einschalten der Stra�enbeleuchtung ge�ffnet',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	2::night 22312,4329 22252,4362
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Park am Nordbahnhof: im Sommerhalbjahr zwischen 6.30 und 22.00 Uhr ge�ffnet, im Winterhalbjahr zwischen 7.30 und 19.00 Uhr',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	2::night 8825,14401 8868,14442 8913,14485 8839,14635 8848,14638 8938,14521 8953,14528
	2::night 8913,14485 9119,14255 9175,14193 9181,14186 9147,14151 9224,14169
	2::night 9175,14193 9144,14169 9081,14232 8868,14442
	2::night 9119,14255 9081,14232 8992,14176
EOF
     },
     { from  => 1249842805, # 2009-08-09 20:33
       until => 1251280800, # 2009-08-26 12:00
       text  => 'Brandenburger Tor: m�gliche Sperrungen zur Leichtathletik-WM (bis 26.08.09)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8600,12165 8538,12245 8610,12254 8731,12270
userdel	2::temp 8538,12245 8546,12279
EOF
     },
     { from  => 1249972926, # 2009-08-11 08:42
       until => 1251531090, # 2009-08-31 23:59 1251755999
       text  => 'Sterndamm (Treptow) Rudow Richtung Obersch�neweide zwischen Stubenrauchstr. und Lindhorstweg Baustelle, Fahrtrichtung gesperrt (bis Ende 08.2009)',
       type  => 'handicap',
       source_id => 'IM_013892',
       data  => <<EOF,
userdel	q4::inwork; 17364,3565 17219,3795 17053,3971 17108,4049
EOF
     },
     { from  => 1249768800, # 2009-08-09 00:00
       until => 1258239600, # 2009-11-15 00:00
       text  => 'L 028 L 33, Wriezen - Neureetz OD Alt M�rdewitz Grundhafter Stra�enausbau Vollsperrung 10.08.2009-14.11.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 61432,38883 61546,39041 61413,39860
EOF
     },
     { from  => 1251496800, # 2009-08-29 00:00
       until => 1251669600, # 2009-08-31 00:00
       text  => 'L 051 Hauptstr. OL Burg, zw. Krabatweg u. Bahnhofstr. Festumz. Heimat-u.Trachtenfest Vollsperrung 30.08.2009-30.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 62498,-63227 62522,-62647
EOF
     },
     { from  => 1249768800, # 2009-08-09 00:00
       until => 1251583200, # 2009-08-30 00:00
       text  => 'L 071 E.-Th�lmann-Str. OL Sch�newalde, zw. Str. d. Jugend u. Parkweg Pflaster- / Kanalarbeiten Vollsperrung 10.08.2009-29.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -932,-66045 -575,-65978 60,-66035
EOF
     },
     { from  => 1251496800, # 2009-08-29 00:00
       until => 1251669600, # 2009-08-31 00:00
       text  => 'L 513 Bahnhofstr., Rinchaussee OL Burg, zw. Hauptstr. u. Jugendherbergsweg Festumz. Heimat-u.Trachtenfest Vollsperrung 30.08.2009-30.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 62010,-62330 62522,-62647
EOF
     },
     { from  => 1250028000, # 2009-08-12 00:00
       until => 1250460000, # 2009-08-17 00:00
       text  => 'L 435 Mixdorf - M�llrose OD M�llrose, Mixdorfer Stra�e Kanal- u. Stra�enbau Vollsperrung 13.08.2009-16.08.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 79650,-16999 79549,-17498 79628,-17759
EOF
     },
     { from  => 1250373600, # 2009-08-16 00:00
       until => 1267398000, # 2010-03-01 00:00
       text  => 'B 001 Bundesgrenze Polen - K�strin Kietz Vorflutbr�cke bei K�strin Kietz Br�ckeninstandsetzung Vollsperrung 17.08.2009-28.02.2010 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 92925,19897 92970,19935 92970,20194 93096,20241 93405,20640
EOF
     },
     { from  => 1252188000, # 2009-09-06 00:00
       until => 1270072800, # 2010-04-01 00:00
       text  => 'B 005 Frankfurter Stra�e OL Heinersdorf Kanal- u. Stra�enbauarbeiten Vollsperrung 07.09.2009-31.03.2010 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 66009,6118 65618,6296 65528,6253 65365,6281 65225,6403
EOF
     },
     { from  => 1251237600, # 2009-08-26 00:00
       until => 1251583200, # 2009-08-30 00:00
       text  => 'B 087 L�bben - Luckau von AS Duben bis OA Duben Deckenerneuerung Vollsperrung 27.08.2009-29.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 39355,-56021 39767,-55820
EOF
     },
     { from  => 1252879200, # 2009-09-14 00:00
       until => 1253570400, # 2009-09-22 00:00
       text  => 'B 115 Am Spreeufer OL L�bben, zw. Krz. B87 u. Br�ckenplatz Stadtfest Vollsperrung 15.09.2009-21.09.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 45023,-51268 44951,-51018
EOF
     },
     { from  => 1251756000, # 2009-09-01 00:00
       until => 1252440991, # 2009-09-19 00:00 1253311200
       text  => 'B 158 Bad Freienwalde - Werneuchen zw. L236, Ri. Freudenberg u. OE Tiefensee Deckschichterneuerung Vollsperrung 02.09.2009-18.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 41925,33512 40827,32011 39783,31398
EOF
     },
     { from  => 1250373600, # 2009-08-16 00:00
       until => 1254520800, # 2009-10-03 00:00
       text  => 'L 025 Sch�nermark - F�rstenwerder - Woldegk zw. OL Kraatz u. F�rstenwerder u. LG Deckenerneuerung Vollsperrung 17.08.2009-02.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 21007,109931 21285,109895 22504,109807 23242,109707
EOF
     },
     { from  => 1250978400, # 2009-08-23 00:00
       until => 1252188000, # 2009-09-06 00:00
       text  => 'L 033 Wriezen - Pr�tzel zw. Abzw. Reichenow �ber Herzhorn nach Pr�tzel Deckenerneuerung Vollsperrung 24.08.2009-05.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 53517,29159 52892,28720 52634,28531 50690,27036
EOF
     },
     { from  => 1252015200, # 2009-09-04 00:00
       until => 1252274400, # 2009-09-07 00:00
       text  => 'L 070 St�lpe - Sperenberg bei Kummersdorf/ Gut Stra�enausbau Vollsperrung 05.09.2009-06.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 8564,-34625 9068,-34115
EOF
     },
     { from  => 1252620000, # 2009-09-11 00:00
       until => 1252879200, # 2009-09-14 00:00
       text  => 'L 070 St�lpe - Sperenberg bei Kummersdorf/ Gut Stra�enausbau Vollsperrung 12.09.2009-13.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 8564,-34625 9068,-34115
EOF
     },
     { from  => 1251410400, # 2009-08-28 00:00
       until => 1251669600, # 2009-08-31 00:00
       text  => 'L 070 St�lpe - Sperenberg bei Kummersdorf/ Gut Stra�enausbau Vollsperrung 29.08.2009-30.08.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 8564,-34625 9068,-34115
EOF
     },
     { from  => 1245103200, # 2009-06-16 00:00
       until => 1270072800, # 2010-04-01 00:00
       text  => 'L 077 Langerwisch - Saarmund OD Langerwisch, zw. Potsdamer Str. u. Am Plan Stra�enbau Vollsperrung 17.06.2009-31.03.2010 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -13211,-10642 -12915,-10753
EOF
     },
     { from  => 1251237600, # 2009-08-26 00:00
       until => 1252620000, # 2009-09-11 00:00
       text  => 'L 099 M�thlow - Barnewitz zw. Buschow u. Barnewitz Fahrbahnsanierungsarbeiten Vollsperrung 27.08.2009-10.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -42002,19243 -42106,18923 -42484,18388 -42920,17788 -43042,17302 -43226,16794
EOF
     },
     { from  => 1251064800, # 2009-08-24 00:00
       until => 1252441079, # 2009-09-19 00:00 1253311200
       text  => 'L 144 Herzsprung - Blumenthal OD Herzsprung grundhafter Stra�enausbau Vollsperrung 25.08.2009-18.09.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -54665,72030 -54116,72465
EOF
     },
     { from  => 1252188000, # 2009-09-06 00:00
       until => 1275343200, # 2010-06-01 00:00
       text  => 'L 303 Br�cke �ber die DB AG bei Eggersdorf Br�ckenersatzneubau Vollsperrung 07.09.2009-31.05.2010 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 38540,14138 38569,14332 38535,14602 38637,14790
EOF
     },
     { from  => 1250978400, # 2009-08-23 00:00
       until => 1275343200, # 2010-06-01 00:00
       text  => 'L 621 D�llinger Stra�e OL Hohenleipisch, zw. Goethestr. u. Abzw. L62 Berliner Str. Stra�en- und Kanalarbeiten Vollsperrung 24.08.2009-31.05.2010',
       type  => 'handicap',
       source_id => 'LS/S-SG33-C/09/208',
       data  => <<EOF,
userdel	q4::inwork 23464,-101227 23305,-100904 23220,-100874
EOF
     },
     { from  => 1251583200, # 2009-08-30 00:00
       until => 1253397600, # 2009-09-20 00:00
       text  => 'L 861 Damsdorf - Plessow zw. Damsdorf und G�hlsdorf Stra�ensanierung Vollsperrung 31.08.2009-19.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -30199,-5774 -30919,-6570 -31110,-6743 -32618,-7268
EOF
     },
     { from  => 1251090240, # 2009-08-24 07:04
       until => 1324044000, # 2011-12-16 15:00
       text  => 'Freiheit/Wiesendamm (Spandau): Baustelle, Fahrtrichtung gesperrt Richtung Spandauer Damm zwischen Kl�rwerkstr. und Spandauer Damm, 25.08.2009 07:04 Uhr bis 16.12.2011 15:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_013995',
       data  => <<EOF,
userdel	q4::inwork; -1258,13552 -990,13502 -729,13415 -346,13349 -307,13279 -264,13009
EOF
     },
     { from  => 1251530387, # 2009-08-29 09:19
       until => 1251842399, # 2009-09-01 23:59
       text  => 'Joachim-Friedrich-Str. (Wilmersdorf) in beiden Richtungen zwischen Kurf�rstendamm und Westf�lische Str. Baustelle, gesperrt (bis Anfang 09/2009)',
       type  => 'handicap',
       source_id => 'IM_013936',
       data  => <<EOF,
userdel	q4::inwork 3092,9886 3108,10069 3111,10116
EOF
     },
     { from  => 1251833196, # 2009-09-01 21:26
       until => 1252010774, # 2009-09-04 23:59 1252101599
       text  => 'Proskauer Str. (Friedrichshain) in beiden Richtungen zwischen Rigaer Str. und B�nschstr. geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt (bis Anfang 09/2009)',
       type  => 'handicap',
       source_id => 'IM_013998',
       data  => <<EOF,
userdel	q4::inwork 14266,12446 14297,12553 14319,12629
EOF
     },
     { from  => 1251530442, # 2009-08-29 09:20
       until => 1252790612, # 2009-09-15 23:59 1253051999
       text  => 'P�wesiner Weg (Spandau) Richtung Brunsb�tteler Damm zwischen Lazarusstr. und Brunsb�tteler Damm Baustelle, Fahrtrichtung gesperrt (bis Mitte 09.2009)',
       type  => 'handicap',
       source_id => 'IM_013939',
       data  => <<EOF,
userdel	q4::inwork; -4922,13609 -4922,13641 -4932,13887 -4926,13971
EOF
     },
     { from  => 1252010710, # 2009-09-03 22:45
       until => 1253051999, # 2009-09-15 23:59
       text  => 'Sch�nhauser Allee (Prenzlauer Berg) in beiden Richtungen im Kreuzungsbereich Schivelbeiner Str. - Wichertstr. Baustelle, Br�ckendurchfahrt gesperrt, aus allen Richtungen kein Linksabbiegen m�glich (bis Mitte 09.2009)',
       type  => 'gesperrt',
       source_id => 'IM_013990',
       data  => <<EOF,
Sch�nhauser Allee -> Schivelbeiner Str.:	3::inwork 10975,16010 10982,16121 10753,16144
Sch�nhauser Allee -> Wichertstr.:	3::inwork 10989,16197 10982,16121 11214,16043
Wichertstr. -> Sch�nhauser Allee:	3::inwork 11214,16043 10982,16121 10975,16010
Wichertstr. -> Schivelbeiner Str.:	3::inwork 11214,16043 10982,16121 10753,16144
Schivelbeiner Str. -> Sch�nhauser Allee:	3::inwork 10753,16144 10982,16121 10989,16197
Schivelbeiner Str. -> Wichertstr.:	3::inwork 10753,16144 10982,16121 11214,16043
EOF
     },
     { from  => 1251444429, # 2009-08-28 09:27
       until => 1251684000, # 2009-08-31 04:00
       text  => 'Spandauer Damm (Charlottenburg) in beiden Richtungen, Br�cke �ber die A100 Baustelle, Stra�e vollst�ndig gesperrt bis Mo 04:00 ',
       type  => 'gesperrt',
       source_id => 'IM_013988',
       data  => <<EOF,
userdel	2::inwork 2414,12418 2280,12403 2193,12393 2152,12389
EOF
     },
     { from  => 1251833280, # 2009-09-01 21:28
       until => 1260917999, # 2009-12-15 23:59
       text  => 'Winckelmannstr. (Johannisthal) Richtung Stubenrauchstr. zwischen Sterndamm und K�penicker Str. Baustelle, Fahrtrichtung gesperrt (bis Mitte 12.2009)',
       type  => 'handicap',
       source_id => 'IM_013929',
       data  => <<EOF,
userdel	q4::inwork; 17428,4503 17476,4337 17507,4216
EOF
     },
     { from  => 1251712860, # 2009-08-31 12:01
       until => 1280679736, # 2010-12-17 15:00 1292594400
       text  => 'Wendenschlo�str. (K�penick): Baustelle, Fahrtrichtung gesperrt Richtung M�ggelheimer Str. zwischen Salvador-Allende-Str. und Landj�gerstr., 01.09.2009 12:01 Uhr bis 17.12.2010 15:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_014045',
       data  => <<EOF,
userdel	q4::inwork; 23451,4877 23363,4846 23055,4640 22959,4576 22893,4532 22862,4511 22832,4491 22791,4457 22759,4430 22740,4415
EOF
     },
     { from  => 1250978400, # 2009-08-23 00:00
       until => 1262300399, # 2009-12-31 23:59
       text  => 'Aufgrund von Bauma�nahmen der Berliner Wasserbetriebe wird es vom 24. August bis zum 31. Dezember in der Rathausstra�e und den angrenzenden Kreuzungsbereichen Rathausstra�e/Frankfurter Allee und Rathaus-/M�llendorffstra�e zu Verkehrseinschr�nkungen kommen.',
       type  => 'handicap',
       # XXX URL existiert nicht mehr: source_id => 'http://www.berlin.de/ba-lichtenberg/presse/archiv/20090813.1105.134956.html',
       data  => <<EOF,
userdel	q4::inwork 15537,12367 15576,12315 15628,12246 15651,12214 15685,12154 15670,12022
EOF
     },
     { from  => 1250978400, # 2009-08-23 00:00
       until => 1262300399, # 2009-12-31 23:59
       text  => 'Vom 24. August bis zum 31. Dezember wird es in der Robert-Uhrig-Stra�e und den angrenzenden Kreuzungsbereichen Robert-Uhrig-Stra�e/Alt-Friedrichsfelde und Robert-Uhrig-/Paul-Gesche-Stra�e zu Verkehrseinschr�nkungen aufgrund von Bauma�nahmen der Berliner Wasserbetriebe kommen.',
       type  => 'handicap',
       # XXX URL existiert nicht mehr: source_id => 'http://www.berlin.de/ba-lichtenberg/presse/archiv/20090813.1105.134956.html',
       data  => <<EOF,
userdel	q4::inwork 17746,11748 17744,11703 17741,11607
EOF
     },
     { from  => 1252228140, # 2009-09-06 11:09
       until => 1275314400, # 2010-05-31 16:00
       text  => 'Miraustr. (Reinickendorf): Baustelle, Fahrtrichtung gesperrt (bis Ende 05/2010) stadteinw�rts zwischen Innungsstr. und Breitenbachstr., 07.09.2009 11:09 Uhr bis 31.05.2010 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_014098',
       data  => <<EOF,
userdel	q4::inwork; 4014,19433 4170,19079 4195,19043
EOF
     },
     { from  => 1252010752, # 2009-09-03 22:45
       until => 1253965910, # 2009-09-30 23:59 1254347999
       text  => 'B�ttgerstr. (Wedding) in beiden Richtungen zwischen Badstr. und Hochstr. Bauarbeiten, Stra�e vollst�ndig gesperrt (bis Ende 09/2009)',
       type  => 'handicap',
       source_id => 'IM_014062',
       data  => <<EOF,
userdel	q4::inwork 8923,15850 9134,15953
EOF
     },
     { from  => 1252014436, # 2009-09-04 00:00 1252015200
       until => 1252014437, # 2009-09-07 00:00 1252274400
       text  => 'B 087 Frankfurt/Oder - M�llrose zw. Markendorf u. Hohenwalde Durchlassneubau Vollsperrung 05.09.2009-06.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 82521,-12031 82191,-12275
EOF
     },
     { from  => 1251410400, # 2009-08-28 00:00
       until => 1254348000, # 2009-10-01 00:00
       text  => 'B 167 Marienwerderstr. OD Finowfurt, zw. Zum Krugacker u. Aral-Tankstelle Stra�enerneuerung Vollsperrung 29.08.2009-30.09.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 28575,49756 27822,49878
EOF
     },
     { from  => 1252533600, # 2009-09-10 00:00
       until => 1252965600, # 2009-09-15 00:00
       text  => 'L 373 B112 - M�llrose OL Brieskow-Finkenheerd, R.-Sonnenburg-Str. Deckenerneuerung Vollsperrung 11.09.2009-14.09.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 89435,-16834 90073,-16502 90164,-16382
EOF
     },
     { from  => 1252015200, # 2009-09-04 00:00
       until => 1252274400, # 2009-09-07 00:00
       text  => 'K 6303 Brieselang - L161 Bredow bei Bredow am Abzw. Brieselang Br�cken-, Radweg u. Stra�enbau Vollsperrung 05.09.2009-06.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -20109,20341 -20850,20447
EOF
     },
     { from  => 1252879200, # 2009-09-14 00:00
       until => 1253052000, # 2009-09-16 00:00
       text  => 'L 015 Berliner Stra�e OL Lychen, zw. Br�cke Nesselpfuhlflie� u. Schl��str. Kanal- u. Stra�enausbau Vollsperrung 15.09.2009-15.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 1544,89701 1907,89597
EOF
     },
     { from  => 1252015200, # 2009-09-04 00:00
       until => 1252188000, # 2009-09-06 00:00
       text  => 'L 030 Gerichtsstr. OL K�nigs Wusterhausen, zw. Schlo�platz u. Br�ckenstr. Schlossfest Vollsperrung 05.09.2009-05.09.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 25859,-11559 26177,-11648
EOF
     },
     { from  => 1252188000, # 2009-09-06 00:00
       until => 1253570400, # 2009-09-22 00:00
       text  => 'L 074 Sperenberger Str. OL Klausdorf, zw. Zossener Str. und Am Park Kanalarbeiten Vollsperrung 07.09.2009-21.09.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 11017,-27817 11325,-27743
EOF
     },
     { from  => 1252274400, # 2009-09-07 00:00
       until => 1252533600, # 2009-09-10 00:00
       text  => 'L 711 Krausnick - AS Staakow zw. Krausnick und Brand Stra�enbauarbeiten Vollsperrung 08.09.2009-09.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 35214,-41158 35289,-41439 35915,-41259 36010,-41272 36387,-40961 36499,-41097 37581,-41158
EOF
     },
     { from  => 1254952800, # 2009-10-08 00:00
       until => 1259622000, # 2009-12-01 00:00
       text  => 'L 792 Dorfstra�e OD Blankenfelde, zw. Zossener Damm u. H.-Heine-Str. Stra�enausbau Vollsperrung 09.10.2009-30.11.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 10448,-7582 10115,-8276
EOF
     },
     { from  => 1242684000, # 2009-05-19 00:00
       until => 1252440968, # 2010-01-01 00:00 1262300400
       text  => 'B 102 Gro�e Milower Str. OD Rathenow, zw. Wolzenstr. und K�rgraben Neubau Kreisverkehr Vollsperrung 20.05.2009-31.12.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -62290,19904 -62333,20390
EOF
     },
     { from  => 1252188000, # 2009-09-06 00:00
       until => 1272607615, # 2010-06-01 00:00 1275343200
       text  => 'B 087 Leipziger Stra�e Br�cke �ber den Elsterkolk in Herzberg Br�ckenneubau halbseitig gesperrt; Einbahnstra�e 07.09.2009-31.05.2010 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 1327,-79312 1746,-79119
EOF
     },
     { from  => 1252188000, # 2009-09-06 00:00
       until => 1253397600, # 2009-09-20 00:00
       text  => 'B 112 Eisenh�ttenstadt - Brieskow-Finenheerd Br�cke �ber DB u. Oder-Spree-Kanal bei Zilten Belagserneuerung Vollasperrung 07.09.2009-19.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 93494,-21221 93192,-21578
EOF
     },
     { from  => 1252447200, # 2009-09-09 00:00
       until => 1254348000, # 2009-10-01 00:00
       text  => 'L 068 Oelsig - Schlieben OD Schlieben, Am M�hlenberg Deckenerneuerung Vollsperrung 10.09.2009-30.09.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 10891,-76066 10533,-76130 10302,-76088
EOF
     },
     { from  => 1252620000, # 2009-09-11 00:00
       until => 1252965600, # 2009-09-15 00:00
       text  => 'L 338 Rosa-Luxemburg-Damm, Hauptstra�e Bahn�bergang in Neuenhagen Gleiserneuerung Vollsperrung 12.09.2009-14.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30910,13101 30815,13170 30795,13191
EOF
     },
     { from  => 1258844400, # 2009-11-22 00:00
       until => 1267398000, # 2010-03-01 00:00
       text  => 'B 167 Ruppiner Str. OD B�ckwitz, Einm�nd. B 5 Kreiselneubau gesperrt 23.11.2009-28.02.2010 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -52519,49887 -52595,49993
EOF
     },
     { from  => 1252792800, # 2009-09-13 00:00
       until => 1261770537, # 2010-05-01 00:00 1272664800
       text  => 'K 6422 Eggersdorfer Str. OL Petershagen, zw. Ebereschenstr. u. Kreisverkehr Stra�enausbau Vollsperrung 14.09.2009-30.04.2010 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 35900,13643 36654,13977
EOF
     },
     { from  => 1252533600, # 2009-09-10 00:00
       until => 1252879200, # 2009-09-14 00:00
       text  => 'K 6422 Eggersdorfer Str. OL Petershagen, zw. Elbestr. und Clara-Zetkin-Str. Stra�enausbau Vollsperrung 11.09.2009-13.09.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 35900,13643 36654,13977
EOF
     },
     { from  => 1252651373, # 2009-09-11 08:42
       until => 1252886400, # 2009-09-14 02:00
       text  => 'Ossietzkystr. (Pankow) in beiden Richtungen zwischen Breite Str. und Pestalozzistr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis Montag, 2 Uhr)',
       type  => 'handicap',
       source_id => 'IM_014139',
       data  => <<EOF,
userdel	q4::temp 10609,18384 10565,18507 10532,18601
EOF
     },
     { from  => 1252651497, # 2009-09-11 08:44
       until => 1252886400, # 2009-09-14 02:00
       text  => 'Bahnhofstr. (Lichtenrade) in beiden Richtungen zwischen Goltzstr. und Steinstr. Veranstaltung, Stra�e vollst�ndig gesperrt bis Mo 02:30 ',
       type  => 'handicap',
       source_id => 'IM_014144',
       data  => <<EOF,
userdel	q4::temp 10983,-2116 10747,-2129 10631,-2130 10509,-2131 10453,-2133 10310,-2136
EOF
     },
     { from  => 1252651568, # 2009-09-11 08:46
       until => 1252886400, # 2009-09-14 02:00
       text  => 'Breite Str. (Pankow) in beiden Richtungen zwischen Berliner Str. und M�hlenstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis Montag, 2 Uhr)',
       type  => 'handicap',
       source_id => 'IM_014138',
       data  => <<EOF,
userdel	q4::temp 10240,18193 10320,18197 10469,18262 10487,18270 10660,18345 10680,18380 10609,18384 10567,18366 10502,18338 10463,18321 10449,18315 10281,18241
EOF
     },
     { from  => 1252651605, # 2009-09-11 08:46
       until => 1252886400, # 2009-09-14 02:00
       text  => 'B�lschestr. (K�penick) in beiden Richtungen zwischen F�rstenwalder Damm und M�ggelseedamm Veranstaltung, Stra�e vollst�ndig gesperrt (15:29) ',
       type  => 'handicap',
       source_id => 'IM_014140',
       data  => <<EOF,
userdel	q4::temp 25519,4830 25524,5011 25539,5237 25544,5326 25546,5359 25548,5398 25553,5486 25567,5749 25571,5829 25579,5958
EOF
     },
     { from  => 1252738143, # 2009-09-12 08:49
       until => 1252879199, # 2009-09-13 23:59
       text  => 'Rheinstr. (Sch�neberg) stadtausw�rts zwischen Schmargendorfer Str. und Schmiljanstr. Veranstaltung, Fahrtrichtung gesperrt (bis 13.09., 24 Uhr)',
       type  => 'handicap',
       source_id => 'IM_014142',
       data  => <<EOF,
userdel	q4::temp; 5817,7223 5644,6936
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Breslauer Platz: Wochenmarkt Mittwoch 8-13 Uhr, Donnerstag 12-17 Uhr, Samstag 8-14 Uhr, Behinderungen m�glich',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	q4::temp:clock 5897,7337 5810,7337 5817,7223
EOF
     },
     { from  => 1254261600, # 2009-09-30 00:00
       until => 1280688123, # 2012-03-31 23:59 1333231199
       text  => 'Bauarbeiten in der Berliner Stra�e in Pankow ab Anfang Oktober 2009, Einbahnstra�e Richtung Breite Str.; die Hadlichstr. ab Damerowstra�e Einbahnstra�e in Richtung Berliner Stra�e',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-pankow/presse/archiv/20090903.1100.137516.html',
       data  => <<EOF,
#: XXX nach den Bauarbeiten f�llt evtl. das Kopfsteinpflaster weg, es wird zumindest Richtung Norden Radwege geben
#: last_checked: 2010-07-11
#: next_check: 2010-10-01
userdel	q4::inwork; 10680,18380 10739,18262 10755,18231 10819,18066 10830,17985
userdel	q4::inwork; 10819,18066 10907,18109 10938,18147 10989,18172 11132,18346 11001,18528
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Erich-Steinfurth-Str.: Antikmarkt am Ostbahnhof, Sonntag 9-17 Uhr, nur Schieben m�glich',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	q4::temp:clock 12596,11696 12453,11790 12366,11808
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Am Kupfergraben und am Zeughaus: Berliner Kunst- und Nostalgiemarkt, Samstag und Sonntag ca. 11-17 Uhr, nur Schieben m�glich',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	q4::temp:clock 9754,12775 9661,12876 9618,12907 9533,12925
	q4::temp:clock 9919,12613 9956,12523 9984,12426
EOF
     },
     { from  => 1253224800, # 2009-09-18 00:00
       until => 1253397600, # 2009-09-20 00:00
       text  => 'B 096 Sch�nflie�er Str.A OL Bergfelde, zw. Lindenallee und Ahornstr. Kranarbeiten Vollsperrung 19.09.2009-19.09.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 4167,29307 4267,29149 4412,28911 4807,28338
EOF
     },
     { from  => 1252792800, # 2009-09-13 00:00
       until => 1253052000, # 2009-09-16 00:00
       text  => 'B 101 Dresdner Stra�e Br�cke �ber die Schwarze Elster in Elsterwerda Br�ckenneubau Vollsperrung 14.09.2009-15.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 20952,-105585 21037,-105607
EOF
     },
     { from  => 1253397600, # 2009-09-20 00:00
       until => 1254175200, # 2009-09-29 00:00
       text  => 'B 102 Werbig - J�terbog zw. Hoheng�rsdorf und B101, Neumarkt Stra�enbau Vollsperrung 21.09.2009-28.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -6474,-50137 -7054,-49746 -7948,-48863 -8574,-48178 -8716,-47998
EOF
     },
     { from  => 1253052000, # 2009-09-16 00:00
       until => 1257030000, # 2009-11-01 00:00
       text  => 'L 435 Grunow - M�llrose OD M�llrose, Mixdorfer Stra�e Kanal- u. Stra�enbau Vollsperrung 17.09.2009-31.10.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 79549,-17498 79628,-17759
EOF
     },
     { from  => 1253357936, # 2009-09-19 12:58
       until => 1254434399, # 2009-10-01 23:59
       text  => 'Allee der Kosmonmauten (Marzahn) stadtausw�rts zwischen Rhinstr. und Marzahner Chaussee Baustelle, Fahrtrichtung gesperrt (bis Anfang 10.2009)',
       type  => 'handicap',
       source_id => 'IM_014203',
       data  => <<EOF,
userdel	q4::inwork; 18234,13500 18382,13492 18783,13469 18875,13467 19059,13474 19173,13478
EOF
     },
     { from  => undef, # 
       until => 1253483999, # 2009-09-20 23:59
       text  => 'Hauptstr. (Rosenthal) in beiden Richtungen zwischen Friedrich-Engels-Str. und Sch�nhauser Str. Veranstaltung, Verkehrsst�rung m�glich',
       type  => 'handicap',
       source_id => 'IM_014178',
       data  => <<EOF,
userdel	q4::temp 8277,21257 8389,21468 8460,21602
EOF
     },
     { from  => 1253272543, # 2009-09-18 13:15
       until => 1253505600, # 2009-09-21 06:00
       text  => 'Scheidemannstr. (Tiergarten) in beiden Richtungen zwischen John-Foster-Dulles-Allee und Dorotheestr. wegen Marathon, Stra�e vollst�ndig gesperrt, ebenfalls gesperrt: Heinrich-von-Gagern-Str, Paul-L�be-Allee (bis Montag, 6 Uhr) (11:55) ',
       type  => 'handicap',
       source_id => 'IM_014201',
       data  => <<EOF,
userdel	q4::temp 8540,12420 8400,12417 8354,12416 8119,12414 8122,12608 8207,12608 8306,12609 8348,12609 8399,12610
EOF
     },
     { from  => 1253359000, # 2009-09-19 13:16
       until => 1253570399, # 2009-09-21 23:59
       text  => 'Stra�e des 17. Juni (Tiergarten) in beiden Richtungen zwischen Gro�er Stern und Brandenburger Tor (Marathon), Stra�e vollst�ndig gesperrt, auch gesperrt ist die Ebertstr. zwischen Behrenstr. und Dorotheenstr. (bis 21.09., 12 Uhr)',
       type  => 'handicap',
       source_id => 'IM_014191',
       data  => <<EOF,
userdel	q4::temp 8595,12066 8600,12165 8538,12245 8546,12279 8570,12302 8573,12325 8540,12420
userdel	q4::temp 6828,12031 7383,12095 7816,12150 8055,12186 8089,12190 8214,12205 8303,12216 8538,12245 8610,12254
EOF
     },
     { from  => 1276547726, # 2010-06-14 22:35
       until => 1280613600, # 2010-08-01 00:00
       text  => 'Schwielowsee: K6910: Kanal- und Stra�enbau OL Geltow Richtungsverkehr zw. M�hlenbergstr. und B 1, Vollsperrung f�r Deckeneinbau, bis 31.07.2010',
       type  => 'handicap',
       source_id => '96900159',
       data  => <<EOF,
userdel	q4::inwork -19013,-5247 -19112,-5226 -19332,-5240
EOF
     },
     { from  => 1253138400, # 2009-09-17 00:00
       until => 1253570400, # 2009-09-22 00:00
       text  => 'L 030 Stra�e der Jugend OL R�dersdorf, zw. Am Landhof und Torellplatz Gleisbauarbeiten Vollsperrung 18.09.2009-21.09.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 35771,7946 35662,8028 35625,8093
EOF
     },
     { from  => 1253730664, # 2009-09-23 20:31
       until => 1255643999, # 2009-10-15 23:59
       text  => 'Bahnhofstr. (Pankow) in beiden Richtungen zwischen M�nchm�hler Str. und Bahn�bergang (ehemaliger Bahnhof Blankenfelde) Baustelle, Stra�e vollst�ndig gesperrt (bis Mitte 10.2009)',
       type  => 'handicap',
       source_id => 'IM_014217',
       data  => <<EOF,
userdel	q4::inwork 8909,23506 8803,23478 8632,23442
EOF
     },
     { from  => 1253730749, # 2009-09-23 20:32
       until => 1254434399, # 2009-10-01 23:59
       text  => 'Vulkanstr. ist voll gesperrt (bis Anfang 10.2009)',
       type  => 'handicap',
       source_id => 'IM_014223',
       data  => <<EOF,
userdel	q4::inwork 15838,14319 15855,14207 15871,14106 15897,13942
EOF
     },
     { from  => 1254980700, # 2009-10-08 07:45
       until => 1257029999, # 2009-10-31 23:59
       text  => 'Dar�er Str. (Hohensch�nhausen) Richtung Falkenberger Chaussee zwischen Graaler Weg und Ribnitzer Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 10.2009)',
       type  => 'handicap',
       source_id => 'IM_014235',
       data  => <<EOF,
userdel	q4::inwork; 15881,17899 16277,17830
EOF
     },
     { from  => 1253731186, # 2009-09-23 20:39
       until => 1254240000, # 2009-09-29 18:00
       text  => 'Scheidemannstr. (Tiergarten) in beiden Richtungen zwischen Ebertstr. und John-Foster-Dulles-Allee Veranstaltung, gesperrt (bis 29.09.09, ca. 18 Uhr)',
       type  => 'handicap',
       source_id => 'IM_014246',
       data  => <<EOF,
userdel	q4::temp 8540,12420 8400,12417 8354,12416 8119,12414
EOF
     },
     { from  => 1254952800, # 2009-10-08 00:00
       until => 1255384800, # 2009-10-13 00:00
       text  => 'B 096 Sonnewalde - Luckau zw. L561, Wei�ack und OU Luckau Deckenerneuerung Vollsperrung 09.10.2009-12.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 31378,-67751 31039,-67133 30744,-66875 30597,-66340 30577,-65764 30491,-65399
EOF
     },
     { from  => 1253484000, # 2009-09-21 00:00
       until => 1255039200, # 2009-10-09 00:00
       text  => 'B 169 Lauchhammer - Elsterwerda zw. Abzw. Schraden und Plessa Deckenerneuerung Richtungsverkehr 22.09.2009-08.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 28404,-104242 29283,-103951 32685,-103832 33348,-104123 33767,-104125
EOF
     },
     { from  => 1253397600, # 2009-09-20 00:00
       until => 1261769610, # 2010-12-31 00:00 1293750000
       text  => 'L 026 Br�ssow - Prenzlau zw. Baumgarten und Prenzlau Grundhafter Stra�enbau Vollsperrung 21.09.2009-30.12.2010 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 45393,105220 44963,104618 44698,104375 44487,104325 42804,104235 42306,103942 42002,103540 41700,103365
EOF
     },
     { from  => 1253397600, # 2009-09-20 00:00
       until => 1253743200, # 2009-09-24 00:00
       text  => 'L 029 Oderberg - Hohenfinow Klappbr�cke �ber den Finowkanal in Niederfinow Wartungsarbeiten Vollsperrung 21.09.2009-23.09.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 45328,48225 45321,48142 45322,48104
userdel	2::inwork 45406,45979 45119,45958
EOF
     },
     { from  => 1253965502, # 2009-09-26 13:45
       until => 1254153600, # 2009-09-28 18:00
       text  => 'Charlottenstr. (Mitte) in beiden Richtungen zwischen Dorotheenstr. und Unter den Linden Veranstaltung, gesperrt. Ebenso gesperrt ist die Mittelstr. zwischen Friedrichstr. und Charlottenstr. (bis 28.09.09, 18 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_014251',
       data  => <<EOF,
userdel	2::temp 9343,12464 9462,12481 9475,12365
userdel	2::temp 9462,12481 9454,12558
EOF
     },
     { from  => undef, # 
       until => 1253995200, # 2009-09-26 22:00
       text  => 'Friedrich-Wilhelm-Platz (Nebenfahrbahn) (Sch�neberg) in beiden Richtungen zwischen Wilhelmsh�her Str. und Wiesbadener Str. Veranstaltung, gesperrt (bis 22 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_014275',
       data  => <<EOF,
userdel	2::temp 5314,7217 5310,7325
EOF
     },
     { from  => undef, # 
       until => 1253995200, # 2009-09-26 22:00
       text  => 'Friedrichstr. (Kreuzberg) in beiden Richtungen zwischen Franz-Kl�hs-Str. und Rahel-Varnhagen-Promenade Veranstaltung, gesperrt (bis ca. 20 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_014281',
       data  => <<EOF,
userdel	2::temp 9570,10566 9559,10656
EOF
     },
     { from  => 1253965727, # 2009-09-26 13:48
       until => 1254175200, # 2009-09-29 00:00
       text  => 'Konrad-Adenauer-Str. (Mitte) in beiden Richtungen Veranstaltung, gesperrt (bis 28.09.09, ca. 24 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_014247',
       data  => <<EOF,
userdel	2::temp 8417,12846 8309,12758 8306,12609
EOF
     },
     { from  => $isodate2epoch->("2013-09-20 11:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-09-22 20:00:00"),
       periodic => 1,
       text  => 'Preu�enallee (Charlottenburg) zwischen Marathonallee und Heerstr. Veranstaltung (Herbst in der Preu�enallee), Stra�e vollst�ndig gesperrt (21. und 22. September 2011) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 571,11255 541,11464 550,11607 560,11695 562,11710 577,11837 589,11953
EOF
     },
     { from  => 1253965842, # 2009-09-26 13:50
       until => 1254175200, # 2009-09-29 00:00
       text  => 'Stresemannstr. (Kreuzberg) Richtung Potsdamer Platz zwischen Wilhelmstr. und Gro�beerenstr. Veranstaltung, gesperrt (bis 28.09.09, 24 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_014250',
       data  => <<EOF,
userdel	2::temp 9388,10393 9250,10563
EOF
     },
     { from  => 1253965870, # 2009-09-26 13:51
       until => 1254175200, # 2009-09-29 00:00
       text  => 'Wilhelmstr. (Kreuzberg) Richtung Tempelhof zwischen Hedemannstr. und Stresemannstr. Veranstaltung, gesperrt (bis 28.09.2009, 24 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_014248',
       data  => <<EOF,
userdel	2::temp 9375,10616 9384,10536 9388,10393
EOF
     },
     { from  => 1254002400, # 2009-09-27 00:00
       until => 1255163073, # 2009-10-12 00:00 1255298400
       text  => 'B 001 zw. Manschnow und Abzw. Alt Tucheband Stra�enbau Vollsperrung 28.09.2009-11.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 88364,18251 87135,17933 86429,17774 85640,17560
EOF
     },
     { from  => 1256857200, # 2009-10-30 00:00
       until => 1257116400, # 2009-11-02 00:00
       text  => 'B 087 Frankfurt/Oder - M�llrose zw. Markendorf u. Hohenwalde Durchlassneubau Hinterf�ll. Vollsperrung 31.10.2009-01.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 82521,-12031 82191,-12275
EOF
     },
     { from  => 1255644000, # 2009-10-16 00:00
       until => 1255903200, # 2009-10-19 00:00
       text  => 'B 087 Frankfurt/Oder - M�llrose zw. Markendorf u. Hohenwalde Durchlassneubau Montagearb. Vollsperrung 17.10.2009-18.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 82521,-12031 82191,-12275
EOF
     },
     { from  => 1257195560, # 2009-11-06 00:00 1257462000
       until => 1257195564, # 2009-11-09 00:00 1257721200
       text  => 'B 087 Frankfurt/Oder - M�llrose zw. Markendorf u. Hohenwalde Stra�enbau Durchlass Vollsperrung 07.11.2009-08.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 82521,-12031 82191,-12275
EOF
     },
     { from  => 1253656800, # 2009-09-23 00:00
       until => 1255384800, # 2009-10-13 00:00
       text  => 'B 115 Baruth - J�terbog zw. Charlottenfelde und Abzw. Wahlsdorf Stra�enbauarbeiten Vollsperrung 24.09.2009-12.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 4784,-46940 4232,-46877
EOF
     },
     { from  => 1253570400, # 2009-09-22 00:00
       until => 1261350000, # 2009-12-21 00:00
       text  => 'K 6422 Petershagener Str. OL Fredersdorf, zw. Rosinstr. und Platanenstr. Stra�en- und Durchlassbau Vollsperrung 23.09.2009-20.12.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 34139,13113 34896,13562
EOF
     },
     { from  => 1254002400, # 2009-09-27 00:00
       until => 1256943600, # 2009-10-31 00:00
       text  => 'L 015 Rheinsberg - Dorf Zechlin zw. Rheinsberg und Abzw. Z�hlen Stra�enneubau mit KV Vollsperrung 28.09.2009-30.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -26509,76113 -26787,75950 -27091,75809 -27371,75722
EOF
     },
     { from  => 1254002400, # 2009-09-27 00:00
       until => 1269163006, # 2010-05-01 00:00 1272664800
       text  => 'L 054 Vetschau - Burg OL Vetschau, Kreuz. J.-Gagarin-/Bahnhofstr. Neubau Kreisverkehr Vollsperrung 28.09.2009-30.04.2010 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 58183,-67564 58018,-67843
EOF
     },
     { from  => 1254002400, # 2009-09-27 00:00
       until => 1260918000, # 2009-12-16 00:00
       text  => 'L 812 B102 - Kemnitz Br�cke �ber den Arm der Nieplitz zw. Bardenitz u. Kemnitz Br�ckenneubau Vollsperrung 28.09.2009-15.12.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -19162,-33731 -18692,-33299
EOF
     },
     { from  => 1254981556, # 2009-10-08 07:59
       until => 1256194316, # 2009-10-31 23:59 1257029999
       text  => 'Erkstr. (Neuk�lln) in beiden Richtungen zwischen Sonnenallee und Donaustr. Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 10.2009)',
       type  => 'handicap',
       source_id => 'IM_014353',
       data  => <<EOF,
userdel	q4::inwork 12902,8470 12771,8439
EOF
     },
     { from  => 1255162874, # 
       until => 1255162879, # XXX
       text  => 'L1171 Naumannstra�e Kreuzberg Richtung Sch�neberg Zwischen Kolonnenstra�e und Tempelhofer Weg gesperrt, Baustelle,',
       type  => 'handicap',
       source_id => 'LMS_157063303',
       data  => <<EOF,
userdel	q4::inwork 7709,8777 7713,8600 7716,8370 7716,8356 7715,8308 7710,8051 7733,8023 7713,8001 7717,7879 7717,7830 7696,7771
EOF
     },
     { from  => 1255816800, # 2009-10-18 00:00
       until => 1257030000, # 2009-11-01 00:00
       text  => 'L 034 Br�cke �ber das Sophienflie� bei Bollersdorf B�schungssanierung Vollsperrung 19.10.2009-31.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 55194,21167 55013,20980
EOF
     },
     { from  => 1254607200, # 2009-10-04 00:00
       until => 1261263600, # 2009-12-20 00:00
       text  => 'L 063 Berliner Stra�e OL Lauchhammer, zw. Dimitroffstr. u. Bahn�bergang Kanalbau Vollsperrung 05.10.2009-19.12.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 35482,-103562 35379,-103141
EOF
     },
     { from  => 1254261600, # 2009-09-30 00:00
       until => 1261177200, # 2009-12-19 00:00
       text  => 'L 292 Sch�nfeld - Gr�ntal OD Tempelfelde, Sch�nefelder Str. Kanal- und Stra�enbau Vollsperrung 01.10.2009-18.12.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 31377,34072 31293,33987
EOF
     },
     { from  => 1254607200, # 2009-10-04 00:00
       until => 1257548400, # 2009-11-07 00:00
       text  => 'L 339 Neuer H�nower Weg OD Hoppegarten, zw. Berliner Str. u. Industriestr. Deckenerneuerung Vollsperrung 05.10.2009-06.11.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 26880,11479 26625,10953
EOF
     },
     { from  => 1256425200, # 2009-10-25 01:00
       until => 1258153200, # 2009-11-14 00:00
       text  => 'L 339 Neuer H�nower Weg OD Hoppegarten, zw. Industriestr. u. Wiesenstr. Deckenerneuerung Vollsperrung 26.10.2009-13.11.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 26880,11479 27272,11970
EOF
     },
     { from  => 1255212000, # 2009-10-11 00:00
       until => 1255644000, # 2009-10-16 00:00
       text  => 'L 412 Bad Saarow - Alt Golm OD Neu Golm Einbau Deckschicht Vollsperrung 12.10.2009-15.10.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 57225,-10700 57371,-10550 57479,-10535 57752,-10566 57882,-10535 58018,-10573
EOF
     },
     { from  => 1254952800, # 2009-10-08 00:00
       until => 1255212000, # 2009-10-11 00:00
       text  => 'L 085 Treuenbrietzen - Br�ck zw. Treuenbrietzen und Nichel Stra�enbau am B� Vollsperrung 09.10.2009-10.10.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -25920,-35115 -26873,-34493 -27632,-34000
EOF
     },
     { from  => 1255212000, # 2009-10-11 00:00
       until => 1256943600, # 2009-10-31 00:00
       text  => 'B 166 zw. Heinersdorf und Abzw. Passow Deckenerneuerung Vollsperrung 12.10.2009-30.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 64624,77291 61819,80513 61420,80705 60511,80745 60070,81164 59018,81801 58771,82019
EOF
     },
     { from  => 1254607200, # 2009-10-04 00:00
       until => 1257202800, # 2009-11-03 00:00
       text  => 'B 198 zw. Prenzlau und Dedelow grundh. Stra�ebau, Radwegbau Vollsperrung 05.10.2009-02.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 36927,105345 36726,106236 36665,106354 36137,106832 35674,106889 35287,106742
EOF
     },
     { from  => 1255212000, # 2009-10-11 00:00
       until => 1255989600, # 2009-10-20 00:00
       text  => 'B 101 Zinnaer Str. OD Luckenwalde, zw. Kirchstr. und Am Nutheflie� Stra�enbau Vollsperrung 12.10.2009-19.10.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -4630,-36012 -4603,-35730
EOF
     },
     { from  => 1254866400, # 2009-10-07 00:00
       until => 1255212000, # 2009-10-11 00:00
       text  => 'B 169 Lauchhammer - Elsterwerda zw. Abzw. Schraden und Plessa Deckeneinbau Vollsperrung 08.10.2009-10.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 33767,-104125 33348,-104123 32685,-103832
EOF
     },
     { from  => 1250978400, # 2009-08-23 00:00
       until => 1257030000, # 2009-11-01 00:00
       text  => 'K 6737 B 5, Arensdorf - L 36, Steinh�fel zw. Hasenfelde und L36, Steinh�fel Stra�enbauarbeiten Vollsperrung 24.08.2009-31.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 65190,3699 64905,3165 63793,2943 63284,3141
EOF
     },
     { from  => 1254866400, # 2009-10-07 00:00
       until => 1255212000, # 2009-10-11 00:00
       text  => 'L 060 zw. Finsterwalde u. Hennersdorf Deckeneinbau Vollsperrung 08.10.2009-10.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 31829,-85450 31240,-85488 30463,-85655 29077,-85475 27831,-85375
EOF
     },
     { from  => 1254952800, # 2009-10-08 00:00
       until => 1255212000, # 2009-10-11 00:00
       text  => 'L 070 Baruther Str. OL Trebbin Stra�enbauarbeiten Vollsperrung 09.10.2009-10.10.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -237,-21890 -749,-21486
EOF
     },
     { from  => 1255039200, # 2009-10-09 00:00
       until => 1255298400, # 2009-10-12 00:00
       text  => 'L 070 St�lpe - Sperenberg OD Kummersdorf-Gut Stra�enausbau Vollsperrung 10.10.2009-11.10.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 8564,-34625 9068,-34115 9300,-34066
EOF
     },
     { from  => 1255644000, # 2009-10-16 00:00
       until => 1255903200, # 2009-10-19 00:00
       text  => 'L 070 St�lpe - Sperenberg OD Kummersdorf-Gut Stra�enausbau Vollsperrung 17.10.2009-18.10.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 8564,-34625 9068,-34115 9300,-34066
EOF
     },
     { from  => 1255162667, # 2009-10-10 10:17
       until => 1255298400, # 2009-10-12 00:00
       text  => 'Grunewaldstr. (Sch�neberg) zwischen Hauptstr. und Akazienstr. sowie Akazienstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 11.10.09, 24 Uhr)',
       type  => 'handicap',
       source_id => 'IM_014394',
       data  => <<EOF,
userdel	q4::temp 7201,8870 7110,9024 7044,9163 7022,9211 7006,9282 7130,9305 7201,9318 7418,9366 7479,9357
EOF
     },
     { from  => 1255644000, # 2009-10-16 00:00
       until => 1257030000, # 2009-11-01 00:00
       text  => 'B 107 Gl�wen - B 5 Gumtow Durchlass zw. Gl�wen und Abzw. Klein Leppin Durchlassneubau Vollsperrung 17.10.2009-31.10.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -80266,56143 -80074,58321
EOF
     },
     { from  => 1255212000, # 2009-10-11 00:00
       until => 1257807600, # 2009-11-10 00:00
       text  => 'B 115 Baruth - J�terbog zw. Abzw. Wahlsdorf und Markendorf Stra�enbauarbeiten Vollsperrung 12.10.2009-09.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -3854,-46999 -1480,-46978 897,-46109 1296,-45979 2044,-46150
EOF
     },
     { from  => 1257375600, # 2009-11-05 00:00
       until => 1257721200, # 2009-11-09 00:00
       text  => 'B 115 Baruth - J�terbog zw. J�terbog und Markendorf Deckschichteinbau Vollsperrung 06.11.2009-08.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -5760,-46987 -6787,-46974 -6986,-46942
userdel	2::inwork -7582,-46937 -7831,-47100 -7975,-47313 -8299,-47368
EOF
     },
     { from  => 1255644000, # 2009-10-16 00:00
       until => 1256421600, # 2009-10-25 00:00
       text  => 'B 115 Baruth - Petkus OD Merzdorf Deckenerneuerung Vollsperrung 17.10.2009-24.10.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 12648,-45054 12332,-44991 12078,-45032 11929,-45268
EOF
     },
     { from  => undef, # 
       until => Time::Local::timelocal(reverse(2009-1900,11-1,16,12,0,0)),
       text  => 'Wegen Bauarbeiten ist der Radweg am Kurt-Schumacher-Damm zwischen Rue Ambroise Pare und Hinckeldeybr�cke bis Mitte November nicht befahrbar',
       type  => 'gesperrt',
       source_id => 'Message-ID: <001e01ca4b11$15559d20$4000d760$@grittner@adfc-berlin.de>', # au�erdem: http://www.berlin.de/ba-reinickendorf/presse/archiv/20091006.1420.141477.html
       data  => <<EOF,
#: last_checked: 2009-10-10 by Susanne Grittner
userdel	2::inwork 3314,15782 3398,16000 3564,16294
EOF
     },
     { from  => 1270235189, # 2010-04-02 21:06
       until => Time::Local::timelocal(reverse(2010-1900,9-1,30,16,0,0)), # 1283205600, # 2010-08-31 00:00
       text  => 'Neust�dtische Kirchstr. (Mitte) Richtung Unter den Linden zwischen Dorotheenstr. und Unter den Linden Baustelle, Fahrtrichtung gesperrt bis 30.09.2010 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_014421',
       data  => <<EOF,
userdel	2::inwork; 9123,12500 9130,12433
Kein Durchgang von Mittelstr. zur Neust�dtischen Kirchstr., auch nicht f�r Fu�g�nger	2::inwork 9343,12464 9130,12433
userdel	q4::inwork; 9130,12433 9141,12320
EOF
     },
     { from  => 1255467829, # 2009-10-13 23:03
       until => 1256076000, # 2009-10-21 00:00
       text  => 'Vom 6.10.2009 bis 20.10.2009 ist der K�nigsweg zwischen Eichkampstra�e und H�ttenweg wegen Stra�enbauarbeiten komplett gesperrt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -903,6923 -643,7252 -348,7641 425,8766
EOF
     },
     { from  => 1255468338, # 2009-10-13 23:12
       until => 1275343200, # 2010-06-01 00:00
       text  => 'Verkehreinschr�nkungen in der Magdalenenstra�e und am Roedeliusplatz bis Mai 2010, Einbahnstra�enregelung in Fahrtrichtung Normannenstra�e ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 16159,12301 16158,12191 16127,11950
EOF
     },
     { from  => 1255384800, # 2009-10-13 00:00
       until => 1261769627, # 2010-01-01 00:00 1262300400
       text  => 'L 220 B167 - Joachimsthal zw. Eichhorst u. Joachimsthal, Chausseestr. Deckenerneuerung Vollsperrung 14.10.2009-31.12.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30781,60566 30784,60950 30960,61370 31147,61555 31880,61589 32748,62327
EOF
     },
     { from  => 1255812887, # 2009-10-14 19:00 1255539600
       until => 1255812894, # 2009-10-19 05:00 1255921200 verschoben um eine Woche!
       text  => 'Sperrungen an der Kreuzung Karl-Marx-Allee/Otto-Braun-Stra�e einschlie�lich Grunerstra�e bis Alexanderstra�e, 16.10.2009, 19.00 Uhr bis 19.10.2009, 05.00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 11267,13012 11226,12945 11134,12793
userdel	3 11139,13008 11226,12945 11289,12908
EOF
     },
     { from  => 1256144400, # 2009-10-21 19:00
       until => 1256529600, # 2009-10-26 05:00
       text  => 'Sperrungen an der Kreuzung Karl-Marx-Allee/Otto-Braun-Stra�e einschlie�lich Grunerstra�e bis Alexanderstra�e, 23.10.2009, 19.00 Uhr bis 26.10.2009, 05.00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 11267,13012 11226,12945 11134,12793
userdel	3 11139,13008 11226,12945 11289,12908
EOF
     },
     { from  => 1256752800, # 2009-10-28 19:00
       until => 1257134400, # 2009-11-02 05:00
       text  => 'Sperrungen an der Kreuzung Karl-Marx-Allee/Otto-Braun-Stra�e einschlie�lich Grunerstra�e bis Alexanderstra�e, 30.10.2009, 19.00 Uhr bis 2.11.2009, 05.00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 11267,13012 11226,12945 11134,12793
userdel	3 11139,13008 11226,12945 11289,12908
EOF
     },
     { from  => 1254891600, # 2009-10-07 07:00
       until => 1267397999, # 2010-02-28 23:59
       text  => 'Naumannstra�e zwischen Leuthener Stra�e und Tempelhofer Weg in Richtung Sachsendamm gesperrt, Baustelle, Dauer: 08.10.2009 07:00 Uhr bis Ende 02.2010',
       type  => 'handicap',
       source_id => 'IM_014786',
       data  => <<EOF,
userdel	q4::inwork; 7716,8356 7715,8308 7710,8051 7733,8023 7713,8001 7717,7879
EOF
     },
     { from  => 1259938062, # 
       until => 1259938066, # XXX -> nach handicap_s-orig gewandert
       text  => 'Universit�tsstra�e Richtung Unter den Linden gesperrt',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 9580,12581 9601,12380
EOF
     },
     { from  => 1364144751, # REMOVED -> permanent gesperrt (fr�her recurring)
       until => 1364144754, #
       text  => '(Drorystr. - Braunschweiger Str., Spielplatz): nachts werden die Tore geschlossen',
       type  => 'gesperrt',
       data  => <<EOF,
	2::night 13518,7477 13601,7366
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Weg vor der Max-Schmelling-Halle: w�hrend Veranstaltungen und nachts von 22 bis 6 Uhr gesperrt',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
#: XXX_prog: die "Veranstaltungen" sollten auch mit einer Kategorie bedacht werden
	2::night 10456,15561 10512,15406
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Luitpoldstr., Durchfahrt �ber Schulhof: nicht immer ge�ffnet!',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	2::temp 6611,9879 6670,9887
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Rutherfordstr.: nicht permanent ge�ffnet',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	2::temp 19071,2746 19136,2673 19207,2592
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Uferweg am Schlo� Bellevue: kann bei Staatsbesuchen gesperrt sein',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	2::temp 6694,12627 7039,12314
EOF
     },
     { from  => 1266162973, # 
       until => 1266162978, # XXX undef
       text  => 'Glasbl�serallee wegen Bauarbeiten gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 14835,10272 14888,10385
EOF
     },
     { from  => 1257194796, # 2009-11-02 21:46
       until => 1258325999, # 2009-11-15 23:59
       text  => 'Edisonstr. (K�penick) Richtung S�den zwischen Helmholtzstr. und Siemensstr. Bauarbeiten, Fahrtrichtung gesperrt (bis Mitte 11/2009)',
       type  => 'handicap',
       source_id => 'IM_014548',
       data  => <<EOF,
userdel	q4::inwork; 17919,6968 17962,6674
EOF
     },
     { from  => 1257194861, # 2009-11-02 21:47
       until => 1259708399, # 2009-12-01 23:59
       text  => 'Friedrichstr. (Mitte) Richtung Wedding zwischen Dorotheenstr. und Georgenstr. Baustelle, Fahrtrichtung gesperrt (bis Anfang 12.2009)',
       type  => 'handicap',
       source_id => 'IM_014503',
       data  => <<EOF,
userdel	q4::inwork; 9330,12529 9314,12652
EOF
     },
     { from  => 1255212000, # 2009-10-11 00:00
       until => 1259190000, # 2009-11-26 00:00
       text  => 'B 101 Zinnaer Str. OD Luckenwalde, zw. Kirchstr. und Am Nutheflie� Stra�enbau Vollsperrung 12.10.2009-25.11.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -4630,-36012 -4603,-35730
EOF
     },
     { from  => 1255816800, # 2009-10-18 00:00
       until => 1257980400, # 2009-11-12 00:00
       text  => 'B 179 zw. Gr�ditsch u. Neu L�bbenau, ab OL Kuschkow Deckeneinbau Vollsperrung 19.10.2009-11.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 46830,-37598 47572,-37563 48907,-37829
EOF
     },
     { from  => 1256684400, # 2009-10-28 00:00
       until => 1257634800, # 2009-11-08 00:00
       text  => 'B 103 Kyritz - Pritzwalk zw. Kollrep u. Abzw. K7012 Deckenerneuerung Vollsperrung 29.10.2009-07.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -67657,68360 -67922,68633 -69298,70111 -70126,70529 -70280,70719 -70377,70966 -70384,71350
EOF
     },
     { from  => 1257634800, # 2009-11-08 00:00
       until => 1259362800, # 2009-11-28 00:00
       text  => 'B 103 Meyenburg - Plau am See zw. Meyenburg und Ganzlin Deckenerneuerung Vollsperrung 09.11.2009-27.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -70491,100364 -70046,101896
EOF
     },
     { from  => 1257030000, # 2009-11-01 00:00
       until => 1261123459, # 2010-01-01 00:00 1262300400
       text  => 'B 112 OU Guben - OU Neuzelle zw. Abzw.Wellmitz und Abzw. Streichwitz Stra�enneubau Vollsperrung 02.11.2009-31.12.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 96951,-34887 97016,-36424 97032,-36743 97476,-37327 97680,-37821
EOF
     },
     { from  => 1258239600, # 2009-11-15 00:00
       until => 1261177200, # 2009-12-19 00:00
       text  => 'B 122 Zechlinerh�tte - Wesenberg zw. Abzw. Kleinzerlang und Prebelowbr�cke Deckenerneuerung Vollsperrung 16.11.2009-18.12.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -26520,83231 -26098,84240 -26120,84667 -26316,84900
EOF
     },
     { from  => 1256425200, # 2009-10-25 01:00
       until => 1257634800, # 2009-11-08 00:00
       text  => 'B 158 Oderberg - Angerm�nde zw. OA Parstein u. OE Neuendorf Stra�enbau Vollsperrung 26.10.2009-07.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 54050,56075 53725,56812 53450,57200 53250,57425 52950,58000 52740,58576 52499,58861
EOF
     },
     { from  => 1256598000, # 2009-10-27 00:00
       until => 1257548400, # 2009-11-07 00:00
       text  => 'K 6303 Br�cke zw. Brieselang und Nauen Stra�enerneuerung Vollsperrung 28.10.2009-06.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -20109,20341 -19128,19920
EOF
     },
     { from  => 1257030000, # 2009-11-01 00:00
       until => 1258326000, # 2009-11-16 00:00
       text  => 'L 049 Berliner Stra�e OL L�bbenau, Bahn�bergang, zw. Bahnhofstr. u. Berl. Str. Gleisbauarbeiten Vollsperrung 02.11.2009-15.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 49774,-59756 49226,-59451 47862,-59500
EOF
     },
     { from  => 1257404794, # 2009-11-05 08:06
       until => 1257980400, # 2009-11-12 00:00
       text  => 'Str. des 17. Juni und Ebertstr. (Tiergarten) in beiden Richtungen zwischen Y.-Rabin-Str. und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt, auch Ebertstr. zwischen Dorotheenstr. und Behrenstr. (bis 11.11.2009 nachts)',
       type  => 'gesperrt',
       source_id => 'IM_014555',
       data  => <<EOF,
userdel	2::temp 8610,12254 8538,12245 8303,12216 8214,12205 8089,12190
userdel	2::temp 8573,12325 8570,12302 8546,12279 8538,12245 8600,12165
EOF
     },
     { from  => 1257404868, # 2009-11-05 08:07
       until => 1257980400, # 2009-11-12 00:00
       text  => 'Ebertstr. (Mitte) in beiden Richtungen zwischen Hannah-Arendt-Str. und Behrenstr. Veranstaltung, Stra�e vollst�ndig gesperrt (auch im weiteren Verlauf bis Dorotheenstr.) (bis 11.11.2009 nachts)',
       type  => 'gesperrt',
       source_id => 'IM_014557',
       data  => <<EOF,
userdel	2::temp 8577,11896 8595,12066 8600,12165
EOF
     },
     { from  => 1259276400, # 2009-11-27 00:00
       until => 1259535600, # 2009-11-30 00:00
       text  => 'L 060 Ringstr. OD Uebigau, Bereich Markt Weihnachtsmarkt Vollsperrung 28.11.2009-29.11.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 5358,-90502 5798,-90075
EOF
     },
     { from  => 1257375600, # 2009-11-05 00:00
       until => 1257807600, # 2009-11-10 00:00
       text  => 'L 239 Kerkow - Joachimsthal Bahn�bergang Kerkow Gleiserneuerung Vollsperrung 06.11.2009, 08.11.2009 und 09.11.2009',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 48237,70892 48147,70935 48092,70962
EOF
     },
     { from  => 1259967600, # 2009-12-05 00:00
       until => 1260313200, # 2009-12-09 00:00
       text  => 'L 239 Kerkow - Joachimsthal Bahn�bergang Kerkow Gleiserneuerung Vollsperrung 06.12.2009 und 08.12.2009',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 48237,70892 48147,70935 48092,70962
EOF
     },
     { from  => 1258066800, # 2009-11-13 00:00
       until => 1258326000, # 2009-11-16 00:00
       text  => 'L 239 Kerkow - Joachimsthal Bahn�bergang Kerkow Gleiserneuerung Vollsperrung 14.11.2009-15.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 48237,70892 48147,70935 48092,70962
EOF
     },
     { from  => 1257202800, # 2009-11-03 00:00
       until => 1258498800, # 2009-11-18 00:00
       text  => 'L 704 B 87 - Lebusa zw. B 87 und Krassig Radwegneubau an B 87 Vollsperrung 04.11.2009-17.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 6325,-75436 6892,-75008
EOF
     },
     { from  => 1257721200, # 2009-11-09 00:00
       until => 1262214000, # 2009-12-31 00:00
       text  => 'Aufgrund einer Veranstaltung sind in der Zeit von 10.11.2009 bis 30.12.2009, 24:00 Uhr folgende Stra�enz�ge gesperrt: Niederlagstr. zwischen Am Schinkelplatz und Franz�sische Str. Oberwallstr. zwischen Unter den Linden und Franz�sische Str. Bebelplatz zwischen Unter den Linden und Behrenstr.',
       type  => 'gesperrt',
       source_id => 'IM_014608',
       data  => <<EOF,
userdel	2::temp 9943,12364 9961,12273 9972,12184
userdel	2::temp 9780,12401 9795,12293 9801,12245 9808,12182 9812,12145
userdel	2::temp 9852,12409 9869,12297 9875,12257 9890,12161
EOF
     },
     { from  => 1258239600, # 2009-11-15 00:00
       until => 1258412400, # 2009-11-17 00:00
       text  => 'B 087 Frankfurt/Oder - M�llrose zw. Markendorf u. Hohenwalde Deckeneinbau Vollsperrung 16.11.2009-16.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 83389,-11087 82521,-12031 82191,-12275 81697,-12826
EOF
     },
     { from  => 1257634800, # 2009-11-08 00:00
       until => 1259362756, # 2009-11-28 00:00 1259362800
       text  => 'B 109 Sch�nwalde - Wandlitz OD Sch�nwalde Durchlasssanierung Vollsperrung 09.11.2009-27.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 12635,32221 12466,30452
EOF
     },
     { from  => 1257462000, # 2009-11-06 00:00
       until => 1258758000, # 2009-11-21 00:00
       text  => 'B 115 Baruth - J�terbog zw. Charlottenfelde und Markendorf Stra�enbauarbeiten Vollsperrung 07.11.2009-20.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -1480,-46978 897,-46109
EOF
     },
     { from  => 1258585200, # 2009-11-19 00:00
       until => 1258844400, # 2009-11-22 00:00
       text  => 'B 115 Baruth - J�terbog zw. J�terbog und Markendorf Deckschichteinbau Vollsperrung 20.11.2009-21.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -4289,-47091 -5760,-46987 -6787,-46974 -6986,-46942 -7582,-46937 -7831,-47100
EOF
     },
     { from  => 1257807600, # 2009-11-10 00:00
       until => 1258585200, # 2009-11-19 00:00
       text  => 'B 158 Bad Freienwalde - Berlin zw. Bad Freienwalde, Abzw. Waldstadt und Forsthaus Deckenerneuerung Vollsperrung 11.11.2009-18.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 51252,41977 51162,41743 50650,41400 50271,41315
EOF
     },
     { from  => 1257375600, # 2009-11-05 00:00
       until => 1258239600, # 2009-11-15 00:00
       text  => 'B 179 zw. OL Kuschkow u. Neu L�bbenau Deckeneinbau Vollsperrung 06.11.2009-14.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 46362,-37400 46830,-37598 47572,-37563 48907,-37829 49139,-37938 49667,-38348
EOF
     },
     { from  => 1254607200, # 2009-10-04 00:00
       until => 1258326000, # 2009-11-16 00:00
       text  => 'B 198 zw. Prenzlau und Dedelow grundh. Stra�ebau, Radwegbau Vollsperrung 05.10.2009-15.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 36927,105345 36726,106236 36665,106354 36137,106832 35674,106889
EOF
     },
     { from  => 1272607127, # 2010-04-30 07:58
       until => 1273874400, # 2010-05-15 00:00
       text  => 'L 601 Finsterwalde - Doberlug-Kirchhain OD Lugau, zw. Abzw. Hennersdorfer Str. u. Abzw. Ha Stra�enbauarbeiten Vollsperrung 09.11.2009 bis 14.05.2010 ',
       type  => 'gesperrt',
       source_id => 'LSS-SG33-C09248',
       data  => <<EOF,
userdel	2::inwork 28028,-88225 26392,-88322 25763,-88254 25470,-88145 24969,-87998 24927,-87720
EOF
     },
     { from  => 1352934000, # 1321311600, # PERIODISCH! # fr�her: 1258045387, # 2009-11-12 18:03
       until => 1356994740, # 1325372340, # PERIODISCH! # fr�her: 1262300399, # 2009-12-31 23:59
       text  => 'Voltairestr.: Durchfahrt wegen des Weihnachtsmarkts am Einkaufszentrum Alexa nicht oder nur schwer m�glich',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 11209,12430 11329,12497
EOF
     },
     { from  => 1352734264, # 1290960699, # PERIODISCH! # fr�her: 1258207217, # 2009-11-14 15:00
       until => 1356994740, # 1293836399, # PERIODISCH! # fr�her: 1262300399, # 2009-12-31 23:59
       text  => 'Gendarmenmarkt: Weihnachtsmarkt, Durchfahrt nicht m�glich (Eintritt!)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 9536,11912 9668,11928
userdel	2::temp 9524,12010 9656,12021
EOF
     },
     { from  => 1262990710, #  undef
       until => 1263796807, # XXX undef 1262990714
       text  => 'Asphaltierung der Belziger Str., Einbahnstra�e Richtung Westen',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 7110,9024 7315,9156
EOF
     },
     { from  => 1258836011, # 2009-11-21 21:40
       until => 1259017199, # 2009-11-23 23:59
       text  => 'Tiergartenstr. (Tiergarten) in beiden Richtungen zwischen Hildebrandtsr. und Hiroshimastr. Baustelle, Stra�e vollst�ndig gesperrt (bis 23.11. 18 Uhr)',
       type  => 'handicap',
       source_id => 'IM_014662',
       data  => <<EOF,
userdel	q4::inwork 7435,11514 7356,11517
EOF
     },
     { from  => 1259104057, # 2009-11-25 00:07
       until => 1259518702, # 2009-11-30 23:59 1259621999
       text  => 'Einsteinufer (Charlottenburg) Richtung Marchstr. zwischen Str. des 17. Juni und Marchstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 11/2009)',
       type  => 'handicap',
       source_id => 'IM_014681',
       data  => <<EOF,
userdel	q4::inwork; 5361,11910 5229,12001 5128,12149 4981,12252
EOF
     },
     { from  => 1258239600, # 2009-11-15 00:00
       until => 1259535600, # 2009-11-30 00:00
       text  => 'B 167 Neuruppin - AS Neuruppin zw. Bechlin u. AS Neuruppin Stra�enbauarbeiten Vollsperrung 16.11.2009-29.11.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -35577,54824 -35059,54768 -34499,54966 -33922,55483
EOF
     },
     { from  => 1259276209, # 2009-11-26 23:56
       until => 1259553600, # 2009-11-30 05:00
       text  => 'Baumschulenstr. (Treptow) in beiden Richtungen zwischen Kiefholzstr. und K�penicker Landstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Montag, 5 Uhr) (10:27) ',
       type  => 'gesperrt',
       source_id => 'IM_014707',
       data  => <<EOF,
userdel	2::inwork 16286,6946 16323,6998
EOF
     },
     { from  => 1259622000, # 2009-12-01 00:00
       until => 1260054000, # 2009-12-06 00:00
       text  => 'B 096 Luckau - Baruth Br�cke �ber die Schuge bei R�dingsdorf Br�ckenneubau Vollsperrung 02.12.2009-05.12.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 29918,-54610 30409,-55818
EOF
     },
     { from  => 1259103600, # 2009-11-25 00:00
       until => 1259449200, # 2009-11-29 00:00
       text  => 'B 101 Zinnaer Str. OD Luckenwalde, zw. Heidestr. u. R.-Breitscheid-Str. Stra�enbau Vollsperrung 26.11.2009-28.11.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -4630,-36012 -4603,-35730
EOF
     },
     { from  => 1353279600, # 2012-11-19 00:00, # 1290380400, # PERIODISCH! # undef, # 
       until => 1356562799, # 2012-12-26 23:59, # 1293404400, # PERIODISCH! # fr�her: 1262300399, # 2009-12-31 23:59
       text  => 'Winterwelt am Potsdamer Platz vom 19. November 2012 bis 26. Dezember 2012',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/orte/weihnachtsmaerkte/87132_winterwelt_und_weihnachtsmarkt_potsdamer_platz/index.php',
       data  => <<EOF,
userdel	2::temp 8479,11493 8481,11447 8389,11378 8375,11368 8318,11324 8280,11296 8278,11257
#: XXX_prog "3::temp" geht nicht?
userdel	3 8427,11365 8389,11378 8374,11479
userdel	3 8374,11479 8389,11378 8427,11365
EOF
     },
     { from  => 1354809600, # 2012-12-06 17:00, # 1322780400, # PERIODISCH! # fr�her: 1259959719, # 2009-12-04 21:48
       until => 1355079600, # 2012-12-09 20:00, # 1323039600, # PERIODISCH! # fr�her: 1260140400, # 2009-12-07 00:00
       text  => 'Richardplatz (Neuk�lln) und die Durchfahrt aller angrenzenden Stra�en Rixdorfer Weihnachtsmarkt, Stra�e vollst�ndig gesperrt (vom 07.12.2012 17:00 Uhr bis 09.12.2012 20:00 Uhr)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 13416,7712 13426,7674
userdel	2::temp 13416,7712 13288,7653
userdel	2::temp 13426,7674 13400,7642 13303,7622
userdel	2::temp 12974,7598 13100,7626 13177,7644
userdel	2::temp 13188,7590 13177,7644
userdel	2::temp 13188,7590 13303,7622
userdel	2::temp 13288,7653 13303,7622
userdel	2::temp 13288,7653 13177,7644
EOF
     },
     { from  => 1212876000, # 2008-06-08 00:00
       until => 1264978800, # 2010-02-01 00:00
       text  => 'L 030 Bahnhofstra�e OL Erkner, Erneuerung Eisenbahnbr�cke Vollsperrung 09.06.2008-31.01.2010 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 34326,2915 34142,2742
EOF
     },
     { from  => 1254952800, # 2009-10-08 00:00
       until => 1261609200, # 2009-12-24 00:00
       text  => 'L 792 Dorfstra�e OD Blankenfelde, zw. Zossener Damm u. H.-Heine-Str. Stra�enausbau Vollsperrung 09.10.2009-23.12.2009 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 10115,-8276 10448,-7582
EOF
     },
     { from  => 1259449200, # 2009-11-29 00:00
       until => 1261123496, # 2010-09-01 00:00 1283292000
       text  => 'B 183 Dresdner Stra�e Br�cke �ber die Schwarze Elster in Bad Liebenwerda Br�ckenneubau Vollsperrung 30.11.2009-31.08.2010 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 12593,-99029 13053,-99051
EOF
     },
     { from  => undef, # 
       until => 1272664800, # 2010-05-01 00:00
       text  => 'Bauma�nahmen in der Parkanlage am Schlachtensee, teilweise ist der Uferweg gesperrt (bis zum Fr�hjahr 2010)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -2521,3637 -2396,3666 -2174,3718 -2014,3826 -1980,3872 -1974,3933 -1996,4063 -1944,4140 -1706,3971 -1624,3956 -1558,3965 -1468,3995 -1380,4108
EOF
     },
     { from  => 1354748400, # 2012-12-06 00:00, # 1291330800, # PERIODISCH! # fr�her: 1259794800, # 2009-12-03 00:00
       until => 1355698799, # 2012-12-16 23:59, # 1292194799, # PERIODISCH! # fr�her: 1260745199, # 2009-12-13 23:59
       text  => 'Alt-K�penicker Weihnachtsmarkt vom 07.12.2012 bis zum 16.12.2012',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/orte/weihnachtsmaerkte/schlossplatz-koepenick/index.php?y=2012',
       data  => <<EOF,
userdel	2::temp 22111,4562 22162,4546 22214,4548
EOF
     },
     { from  => 1260481636, # 2009-12-10 22:47
       until => 1260917999, # 2009-12-15 23:59
       text  => 'Rosenthaler Str. (Mitte) Richtung Rosenthaler Platz zwischen Neue Sch�nhauser Str. und Weinmeisterstr. Baustelle, Fahrtrichtung gesperrt (bis Mitte 12.2009)',
       type  => 'handicap',
       source_id => 'IM_014764',
       data  => <<EOF,
userdel	q4::inwork; 10317,13248 10350,13376
EOF
     },
     { from  => 1260481719, # 2009-12-10 22:48
       until => 1260917999, # 2009-12-15 23:59
       text  => 'Zeltinger Str. (Frohnau) Richtung Zeltinger Platz zwischen Sch�nflie�er Str. und Zerndorfer Weg Baustelle, Fahrtrichtung gesperrt (bis Mitte 12.2009)',
       type  => 'handicap',
       source_id => 'IM_014785',
       data  => <<EOF,
userdel	q4::inwork; 3112,26253 3045,26078 2985,25883 2933,25830
EOF
     },
     { from  => 1260399600, # 2009-12-10 00:00
       until => 1260572400, # 2009-12-12 00:00
       text  => 'B 096 Luckau - Baruth Br�cke �ber die Schuge bei R�dingsdorf Br�ckenneubau Vollsperrung 11.12.2009-11.12.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 29918,-54610 30409,-55818
EOF
     },
     { from  => 1260313200, # 2009-12-09 00:00
       until => 1261003050, # 2009-12-23 00:00 1261522800
       text  => 'L 029 Lanke - Wandlitz Durchlass bei �tzdorf Erneuerung Durchlass Vollsperrung 10.12.2009-22.12.2009 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 18702,39267 19045,39387
EOF
     },
     { from  => 1261046820, # 2009-12-17 11:47
       until => 1297202135, # 1314882000 2011-09-01 15:00
       text  => 'Eisenhutweg (Adlershof): Baustelle, Fahrtrichtung Richtung Rudower Chaussee gesperrt, 18.12.2009 11:47 Uhr bis 01.09.2011 15:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_014849',
       data  => <<EOF,
userdel	q4::inwork; 17142,3393 17194,3343 17274,3267 17525,3029 17741,2824 17894,2783
EOF
     },
     { from  => 1260745200, # 2009-12-14 00:00
       until => 1272664800, # 2010-05-01 00:00
       text  => 'L 601 Finsterwalde - Doberlug-Kirchhain OD Lugau, zw. Abzw. Hennersdorfer Str. u. Abzw. Ha Stra�enbauarbeiten Vollsperrung 15.12.2009-30.04.2010 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 28028,-88225 26392,-88322 25763,-88254 25470,-88145 24969,-87998
EOF
     },
     { from  => undef, # 1261945758, # 2009-12-27 21:29
       until => 1357167540, # 1262494800, # 2010-01-03 06:00
       text  => 'Stra�e des 17. Juni (Tiergarten) zwischen Gro�er Stern und Brandenburger Tor Veranstaltung (Silvesterparty), Stra�e vollst�ndig gesperrt, ebenfalls gesperrt Yitzhak-Rabin-Str. und Ebertstr. zwischen Behrenstr. und Scheidemannstr. (bis 02.01. nachts)',
       type  => 'gesperrt',
       source_id => 'IM_019485',
       data  => <<EOF,
userdel	2::temp 8731,12270 8610,12254 8538,12245 8303,12216 8214,12205 8089,12190 8055,12186 8119,12414
userdel	2::temp 8522,12239 8466,12197
userdel	2::temp 8540,12420 8573,12325 8570,12302 8546,12279 8538,12245 8600,12165 8595,12066
EOF
     },
     { from  => 1262821467, # 2010-01-07 00:44
       until => 1265028093, # 2010-07-31 23:59 1280613599
       text  => 'Tucholskystr. (Mitte) in beiden Richtungen zwischen Oranienburger Str. und Auguststr. Baustelle, gesperrt (bis Ende 07/2010)',
       type  => 'handicap',
       source_id => 'IM_014885',
       data  => <<EOF,
userdel	q4::inwork 9611,13245 9651,13406
EOF
     },
     { from  => 1263844274, # 2010-01-18 20:51
       until => 1272664799, # 2010-04-30 23:59
       text  => 'Lahnstr. (Neuk�lln) Richtung Grenzallee zwischen Naumburger Str. und Mierstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 04.2010)',
       type  => 'handicap',
       source_id => 'IM_014905',
       data  => <<EOF,
userdel	q4::inwork; 13278,6967 13500,7018 13627,7047
EOF
     },
     { from  => 1243461600, # 2009-05-28 00:00
       until => 1282946400, # 2010-08-28 00:00
       text  => 'B 246 Clara-Zetkin-Stra�e OD Beelitz, zw. Trebbiner Str. u. Br�cker Str. Kanal- u. Stra�enbauarbeiten halbseitig gesperrt; Einbahnstra�e 29.05.2009-27.08.2010 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -17930,-19476 -18615,-19264
EOF
     },
     { from  => 1275342093, # 2010-05-31 23:41
       until => 1276293600, # 2010-06-12 00:00
       text  => 'Werder (Havel): L90: Rohrleitungsbau / Stra�enbau / Gehweg OD Werder zw. Kesselgrund- und Gartenstra�e - 2. BA Richtungsverkehr zw. AS Ph�ben und Werder, 13.03.2009 bis 11.06.2010 ',
       type  => 'handicap',
       source_id => 'LS/W-SG33-P/09/109-8',
       data  => <<EOF,
userdel	q4::inwork; -22042,-2060 -21524,-2998
EOF
     },
     { from  => 1277442923, # 2010-06-25 07:15
       until => 1277503200, # 2010-06-26 00:00
       text  => 'Potsdam: L92: Br�ckenneubau - Stra�enbau Br�cke �ber den Schleusenkanal bei Paretz, 15.09.2009 bis 25.06.2010',
       type  => 'gesperrt',
       source_id => 'LS/W-SG33-P/09/467-1',
       data  => <<EOF,
userdel	2::inwork -24240,6075 -24731,6194
EOF
     },
     { from  => 1231063200, # 2009-01-04 11:00
       until => Time::Local::timelocal(reverse(2010-1900,10-1,15,15,0,0)), # 1283259600, # 2010-08-31 15:00
       text  => 'Blankenburger Str. (Pankow): Baustelle, Fahrtrichtung gesperrt Richtung Dietzgenstr. zwischen Siegfriedstr. und Dietzgenstr. sowie Einbahnstra�enregelung in der Siegfriedstr., 05.01.2009 11:00 Uhr bis 15.10.2010 ',
       type  => 'handicap',
       source_id => 'IM_011081',
       data  => <<EOF,
userdel	q4::inwork; 10742,19632 10439,19576 10377,19565 10331,19556 10257,19542
userdel	q4::inwork; 10614,19907 10742,19632
EOF
     },
     { from  => 1265413596, # 2010-02-06 00:46
       until => 1309471199, # 2011-06-30 23:59
       text  => 'Bahnhofstr. (Erkner) in beiden Richtungen zwischen Kreisverkehr Friedensplatz und Bahnhofsvorplatz Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 06.2011)',
       type  => 'handicap',
       source_id => 'IM_015001',
       data  => <<EOF,
userdel	2::inwork 34326,2915 34142,2742
EOF
     },
     { from  => 1270235299, # 2010-04-02 21:08
       until => 1272664800, # 2010-05-01 00:00
       text  => 'Winckelmannstr. (Johannisthal) Richtung Segelfliegerdamm zwischen Herweghstr. und K�penicker Str. Baustelle, gesperrt. Das Abbiegen vom Sterndamm in die Winckelmannstr. ist nicht m�glich. Dauer: bis 30.04.2010 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015007',
       data  => <<EOF,
userdel	q4::inwork; 17476,4337 17507,4216
EOF
     },
     { from  => 1267956000, # 2010-03-07 11:00
       until => 1275314400, # 2010-05-31 16:00
       text  => 'Fennstr. (Treptow): Baustelle, Fahrtrichtung gesperrt. Ebenso ist die Britzer Str. Richtung Michael-Br�ckner-Str. ab Schnellerstr. gesperrt. (bis Ende 05.2010) Richtung Schnellerstr. zwischen Michael-Br�ckner-Str. und Schnellerstr., 08.03.2010 11:00 Uhr bis 31.05.2010 16:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_015284',
       data  => <<EOF,
userdel	1::inwork 18370,5511 18307,5440 18214,5354 18080,5376 18245,5551
EOF
     },
     { from  => 1268521200, # 2010-03-14 00:00
       until => 1277320989, # Time::Local::timelocal(reverse(2010-1900,6-1,25,15,0,0)), # was: 1276898399, # 2010-06-18 23:59
       text  => 'Die Leipziger Str. ist zwischen Mauerstr. und Charlottenstr. Richtung Alexanderstr. wegen Bauarbeiten gesperrt. Zu Einbahnstra�en werden Teile der Mauer-, Krausen-, Charlottenstr. und Friedrichstr. Dauer: 15. M�rz 2010 bis 25. Juni 2010 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	q4::inwork; 9268,11590 9444,11616 9569,11631 9581,11523 9456,11513 9331,11497 9268,11590
userdel	q2::inwork; 9456,11513 9444,11616
userdel	q3::inwork 9444,11616 9432,11702
EOF
     },
     { from  => undef, # 
       until => 1360787052, # XXX -> schon lange als permanenten Sperrung in gesperrt-orig
       text  => 'Friedrich-Ebert-Platz: bei Bundestagssitzungen gesperrt',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	2::temp 8554,12593 8540,12420
EOF
     },
     { from  => 1267950480, # 2010-03-07 09:28
       until => 1274536800, # 2010-05-22 16:00
       text  => 'Pappelallee - Stahlheimer Str. (Prenzlauer Berg): Gleisbauarbeiten, Fahrtrichtung gesperrt Richtung Sch�nhauser Allee zwischen Wisbyer Str. und Danziger Str. (bis vorauss. 22.05.2010 16:00)',
       type  => 'handicap',
       source_id => 'IM_015288',
       data  => <<EOF,
userdel	q4::inwork; 11727,16358 11618,16183 11554,16075 11550,16068 11500,15988 11455,15916 11393,15823 11373,15789 11301,15668 11183,15485 11119,15385 10881,15047
EOF
     },
     { from  => 1269113469, # 2010-03-20 20:31
       until => 1285884000, # 2010-10-01 00:00
       text  => 'Altlandsberg: Stra�en - und Rohrleitungsbau OD Wegendorf, 15.03.2010 bis 30.09.2010',
       type  => 'handicap',
       source_id => 'LSO-SG33-F10025',
       data  => <<EOF,
userdel	q4::inwork 34125,22128 34176,22704
EOF
     },
     { from  => 1269113662, # 2010-03-20 20:34
       until => 1274392800, # 2010-05-21 00:00
       text  => 'Stra�enausbau in der OD Blankenfelde zw. Zossener Damm und H.-Heine-Str. 17.03.2010 bis 20.05.2010 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 10115,-8276 10448,-7582
EOF
     },
     { from  => 1269162211, # 2010-03-21 10:03
       until => 1277935200, # 2010-07-01 00:00
       text  => 'L�bben (Spreewald): Stra�enbau OD L�bben, 28.09.2009 bis 30.06.2010 ',
       type  => 'handicap',
       source_id => 'LSS-SG33-W09248',
       data  => <<EOF,
userdel	q4::inwork 43923,-52746 44496,-51922
EOF
     },
     { from  => 1269162391, # 2010-03-21 10:06
       until => 1288476000, # 2010-10-31 00:00
       text  => 'Nuthetal: Kanal-und Stra�enbauarbeiten L 771 OD Saarmund, 21.09.2009 bis 30.10.2010 ',
       type  => 'handicap',
       source_id => 'LSW-SG33-P09598-1',
       data  => <<EOF,
userdel	q4::inwork -8433,-11290 -8293,-10599
EOF
     },
     { from  => 1238191200, # 2009-03-27 23:00
       until => 1293750000, # 2010-12-31 00:00
       text  => 'Schenkenberg: L26: Grundhafter Stra�enbau Prenzlau - A 20, 28.03.2009 23:00 Uhr bis 30.12.2010 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-E/09/214',
       data  => <<EOF,
userdel	2::inwork 42804,104235 44487,104325
EOF
     },
     { from  => 1267945200, # 2010-03-07 08:00
       until => 1275314400, # 2010-05-31 16:00
       text  => 'Emmentaler Str. (Reinickendorf) Richtung Residenzstr. zwischen Klemkestr. und Armbrustweg: Baustelle, Fahrtrichtung gesperrt, 08.03.2010 08:00 Uhr bis 31.05.2010 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015285',
       data  => <<EOF,
userdel	q4::inwork; 7855,18697 7758,18535 7676,18492
EOF
     },
     { from  => 1269727200, # 2010-03-27 23:00
       until => 1275084000, # 2010-05-29 00:00
       text  => 'Vollsperrung zw. L�sikow und Rohrlack ab 29.03.10 bis 28.05.2010 ',
       type  => 'gesperrt',
       source_id => 'LSW-SG33-K10024',
       data  => <<EOF,
userdel	2::inwork -44683,45909 -46141,45772
EOF
     },
     { from  => 1270015036, # 2010-03-31 07:57
       until => 1277935200, # 2010-07-01 00:00
       text  => 'Petershagen/Eggersdorf: Stra�enausbau OD Petershagen zw. Bahngleise und Clara-Zetkin-Str. 22.03.2010 bis 30.06.2010 ',
       type  => 'handicap',
       source_id => '96400995',
       data  => <<EOF,
userdel	q4::inwork 36666,14172 36677,14087 36654,13977 35900,13643 35427,13624
EOF
     },
     { from  => 1269727743, # 2010-03-27 23:09
       until => 1275688800, # 2010-06-05 00:00
       text  => 'Kanal- und Leitungsbauarbeiten Neuruppin, OT Karwe, Vollsperrung 25.03.2010 bis 04.06.2010 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -27035,49829 -27196,50015 -27421,50349
EOF
     },
     { from  => 1269728021, # 2010-03-27 23:13
       until => 1271541600, # 2010-04-18 00:00
       text  => 'Deckenerneuerung B 246, Wendisch Rietz - Storkow 25.03.2010 bis 17.04.2010 ',
       type  => 'gesperrt',
       source_id => 'LSO-SG33-F10029',
       data  => <<EOF,
userdel	2::inwork 50359,-20087 49368,-19096
EOF
     },
     { from  => 1304110298, # 2011-04-29 22:51
       until => 1306101600, # 1305496799, # 2011-05-15 23:59
       text  => 'Erkstr. (Neuk�lln) Richtung Sonnenallee Baustelle, Fahrtrichtung gesperrt (bis Mitte 05/2011) ',
       type  => 'handicap',
       source_id => 'INKO_090026',
       data  => <<EOF,
userdel	q4::inwork; 12598,8390 12771,8439
EOF
     },
     { from  => 1272051674, # 2010-04-23 21:41
       until => 1273269600, # 2010-05-08 00:00
       text  => 'Pr�tzel: Durchlassbau und Stra�enbauarbeiten Pr�tzel -> Harnekop Sternbeck, 29.03.2010 bis 07.05.2010 ',
       type  => 'gesperrt',
       source_id => 'LSO-SG33-F10034',
       data  => <<EOF,
userdel	2::inwork 49820,27138 49875,28845
EOF
     },
     { from  => 1270235418, # 2010-04-02 21:10
       until => 1275343200, # 2010-06-01 00:00
       text  => 'Michendorf: Verbot f�r Fahrzeuge zw. Potsdamer Str. und Am Plan 27.10.2008 bis 31.05.2010 ',
       type  => 'handicap',
       source_id => '86901199',
       data  => <<EOF,
userdel	q4::inwork -12915,-10753 -12305,-10732
EOF
     },
     { from  => 1270235498, # 2010-04-02 21:11
       until => 1273092248, # 2010-06-01 00:00 1275343200
       text  => 'Steinh�fel: Kanal- und Stra�enbauarbeiten Ortslage Heinersdorf, Verbot f�r Fahrzeuge 07.09.2009 bis 31.05.2010 ',
       type  => 'handicap',
       source_id => 'LSO-SG33-F09177',
       data  => <<EOF,
userdel	q4::inwork 65618,6296 65528,6253 65365,6281 65225,6403
EOF
     },
     { from  => 1284411978, # 2010-09-13 23:06
       until => 1288389600, # 2010-10-30 00:00
       text  => 'Gr�nheide (Mark): L385: Br�ckenbauarbeiten OD Kienbaum, 24.02.2010 bis 29.10.2010 01:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-F/10/015',
       data  => <<EOF,
userdel	2::inwork 48182,6806 48027,6894
EOF
     },
     { from  => 1270235686, # 2010-04-02 21:14
       until => 1272664800, # 2010-05-01 00:00
       text  => 'Prenzlau: Verbot f�r Fahrzeuge Br�cke �ber die �cker 24.03.2010 bis 30.04.2010 ',
       type  => 'gesperrt',
       source_id => 'LSO-SG33-E09126.2',
       data  => <<EOF,
userdel	2::inwork 39239,101950 39066,102017
EOF
     },
     { from  => $isodate2epoch->("2013-08-29 10:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-09-01 20:00:00"),
       periodic => 1, # manchmal/immer (?) zwei Termine im Jahr, zweiter Termin
       text  => 'M�llerstr. (Wedding): Veranstaltung (traditionelles M�llerstra�enfest), Stra�e zwischen Seestr. und Luxemburger Str. gesperrt, 30.08.2013 10:00 - 01.09.2013 20:00',
       type  => 'gesperrt',
       source_id => 'IM_019233',
       data  => <<EOF,
userdel	2::temp 6781,16026 6914,15908 6936,15888 7043,15793 7129,15717 7198,15656 7277,15586
EOF
     },
     { from  => undef, # 
       until => undef, # XXX
       text  => 'Anwohner haben den Uferweg am Gro� Glienicker See versperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp -9668,6171 -9622,5804 -9640,5723 -9727,5573
EOF
     },
     { from  => 1271280104, # 2010-04-14 23:21
       until => 1275775200, # 2010-06-06 00:00
       text  => 'Alth�ttendorf: Grundhafter Ausbau im Bereich der AS Chorin, westl. Seite 12.04.2010 bis 05.06.2010 ',
       type  => 'gesperrt',
       source_id => '101100040',
       data  => <<EOF,
userdel	2::inwork 35000,60912 35215,60669 35255,60090
EOF
     },
     { from  => 1271280213, # 2010-04-14 23:23
       until => 1279317600, # 2010-07-17 00:00
       text  => 'Angerm�nde: Grundhafter Stra�en- und Kanalbau OL Angerm�nde, R.-Breitscheid-Str., 06.04.2010 bis 16.07.2010 ',
       type  => 'handicap',
       source_id => '107300037',
       data  => <<EOF,
userdel	q4::inwork 48657,68265 49286,68297 49503,68415
EOF
     },
     { from  => 1270980000, # 2010-04-11 12:00
       until => 1304111276, # 2011-04-30 16:00 1304172000
       text  => 'Klemkestr. (Reinickendorf): Baustelle, Fahrtrichtung gesperrt, Richtung Residenzstr. zwischen Str. vor Sch�nholz und Emmentaler Str., 12.04.2010 12:00 Uhr bis 30.04.2011 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015512',
       data  => <<EOF,
userdel	q4::inwork; 8182,18761 8066,18754 7886,18742 7855,18697
EOF
     },
     { from  => 1270987200, # 2010-04-11 14:00
       until => 1324033200, # 2011-12-16 12:00 1319984100, # 2011-10-30 15:15
       text  => 'Heinrich-Mann-Str. (Pankow): Baustelle, gesperrt in beiden Richtungen zwischen Cottastr. und Grabbeallee. 12.04.2010 bis 16.12.2011',
       type  => 'handicap',
       source_id => 'IM_015518',
       data  => <<EOF,
userdel	q4::inwork 9881,18354 9821,18392
EOF
     },
     { from  => 1271281013, # 2010-04-14 23:36
       until => 1283292000, # 2010-09-01 00:00
       text  => 'Hoppegarten: Deckenerneuerung H�now - Mehrow Vollsperrung zw. H�now, Grenzweg bis Mehrow, Altlandsberger Weg 12.04.2010 bis 31.08.2010 ',
       type  => 'gesperrt',
       source_id => 'LSO-SG33-E10030',
       data  => <<EOF,
userdel	2::inwork 25170,18422 25654,17351
EOF
     },
     { from  => 1274300034, # 2010-05-19 22:13
       until => 1274479200, # 2010-05-22 00:00
       text  => 'Liebenwalde: B109: Deckenerneuerung Klosterfelde - Zerpenschleuse, 07.04.2010 bis 21.05.2010 ',
       type  => 'gesperrt',
       source_id => 'LSO-SG33-E10027',
       data  => <<EOF,
userdel	2::inwork 16050,46166 16134,45616
EOF
     },
     { from  => 1271281087, # 2010-04-14 23:38
       until => 1273183200, # 2010-05-07 00:00
       text  => 'Massen-Niederlausitz: Deckenerneuerung Lieskau - Massen Standorte: B96 12.04.2010 bis 06.05.2010 ',
       type  => 'gesperrt',
       source_id => 'LSS-SG33-C10063',
       data  => <<EOF,
userdel	2::inwork 37473,-85957 37200,-85763 36941,-85640
EOF
     },
     { from  => 1271281149, # 2010-04-14 23:39
       until => 1293145200, # 2010-12-24 00:00
       text  => 'Neuruppin: Ersatzneubau der Br�cke L 164, 06.04.2010 bis 23.12.2010 ',
       type  => 'gesperrt',
       source_id => 'LSW-SG33-K10017',
       data  => <<EOF,
userdel	2::inwork -20021,54750 -20798,54347
EOF
     },
     { from  => 1272607378, # 2010-04-30 08:02
       until => 1272924000, # 2010-05-04 00:00
       text  => 'Rheinsberg: Stra�enausbau und Bau einer Verkehrsinsel Ortslage Dorf Zechlin, 06.04.2010 bis 03.05.2010 ',
       type  => 'handicap',
       source_id => 'LSW-SG33-K10037',
       data  => <<EOF,
userdel	q4::inwork -33491,80874 -33511,80553
EOF
     },
     { from  => 1271281239, # 2010-04-14 23:40
       until => 1277935200, # 2010-07-01 00:00
       text  => 'Stahnsdorf: Stra�enbau zw. OA Schenkenhorst und KVK Nudow Vollsperrung 12.04.2010 bis 30.06.2010 ',
       type  => 'gesperrt',
       source_id => '106900153',
       data  => <<EOF,
userdel	2::inwork -4503,-8506 -4020,-7973 -3596,-7607
EOF
     },
     { from  => 1271281324, # 2010-04-14 23:42
       until => 1288389600, # 2010-10-30 00:00
       text  => 'Wandlitz: Stra�enbau (Ausbau OD) OD Zerpenschleuse 06.04.2010 bis 29.10.2010 ',
       type  => 'handicap',
       source_id => 'LSO-SG33-E10026',
       data  => <<EOF,
userdel	q4::inwork 18301,50512 18022,49766 17638,49090
EOF
     },
     { from  => 1271281409, # 2010-04-14 23:43
       until => 1271887200, # 2010-04-22 00:00
       text  => 'Zeschdorf: Stra�enausbau zwischen Alt Zeschdorf und Abzweig B 167 14.04.2010 bis 21.04.2010 ',
       type  => 'gesperrt',
       source_id => 'LSO-SG33-F10040',
       data  => <<EOF,
userdel	2::inwork 81301,3881 82314,4413 82765,4636
EOF
     },
     { from  => 1271624843, # 2010-04-18 23:07
       until => 1291158000, # 2010-12-01 00:00
       text  => 'Pr�tzel: Kanal- und Stra�enbauarbeiten Ortsdurchfahrt Pr�tzel, 29.03.2010 bis 30.11.2010 ',
       type  => 'handicap',
       source_id => 'LSO-SG33-F10022',
       data  => <<EOF,
userdel	q4::inwork 49255,26084 49808,26346
EOF
     },
     { from  => 1271707200, # 2010-04-19 22:00
       until => 1272340800, # 2010-04-27 06:00
       text  => 'Sanierung des Bahn�bergangs Bahn�bergang zw. Gransee und Altl�dersdorf - vom 19.04.2010 22:00 Uhr bis 27.04.2010 06:00 Uhr Vollsperrung',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -5575,69050 -5511,69122 -5146,69565
EOF
     },
     { from  => 1271829813, # 2010-04-21 08:03
       until => 1293836400, # 2011-01-01 00:00
       text  => 'Br�ckenneubau und Stra�enerneuerung OD Wandlitz 21.04.2010 bis 31.12.2010 ',
       type  => 'gesperrt',
       source_id => 'LSO-SG33-E10039',
       data  => <<EOF,
userdel	2::inwork 13546,37474 14470,37191
EOF
     },
     { from  => 1272051749, # 2010-04-23 21:42
       until => 1273269600, # 2010-05-08 00:00
       text  => 'Ausbau der L 38 zwischen Alt Zeschdorf und Abzweig B 167, 29.03.2010 bis 07.05.2010 ',
       type  => 'gesperrt',
       source_id => 'LSO-SG33-F10040',
       data  => <<EOF,
userdel	2::inwork 83070,5097 82765,4636 82314,4413 81301,3881
EOF
     },
     { from  => 1271654040, # 2010-04-19 07:14
       until => 1273249800, # 2010-05-07 18:30
       text  => 'Birkbuschstr. (Steglitz): Stra�e vollst�ndig gesperrt, Fahrbahnsch�den in beiden Richtungen zwischen Klingsorstr. und Haydnstr. 20.04.2010 07:14 Uhr bis 07.05.2010 18:30 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015553',
       data  => <<EOF,
userdel	q4::inwork 5271,4547 5161,4664 5137,4691 5076,4762
EOF
     },
     { from  => 1271855220, # 2010-04-21 15:07
       until => 1272472200, # 2010-04-28 18:30
       text  => 'Oranienburger Stra�e (Mitte): Stra�e vollst�ndig gesperrt, Grund: Wasserrohrbruch, in Richtung Friedrichstr. zwischen Hackescher Markt und Monbijouplatz. 22.04.2010 15:07 Uhr bis 28.04.2010 18:30 Uhr',
       type  => 'handicap',
       source_id => 'IM_015575',
       data  => <<EOF,
userdel	q4::inwork 10220,13098 10077,13100 9932,13109
EOF
     },
     { from  => 1271865600, # 2010-04-21 18:00
       until => 1272290400, # 2010-04-26 16:00
       text  => 'Stra�e des 17. Juni (Tiergarten) zwischen Yitzhak-Rabin-Str. und Brandenburger Tor: Veranstaltung (Kinderfest), Stra�e vollst�ndig gesperrt, ebenfalls gesperrt: Ebertstr. zwischen Behrenstr. und Scheidemannstr., 22.04.2010 18:00 Uhr bis 26.04.2010 16:00 Uhr',
       type  => 'gesperrt',
       source_id => 'IM_015533',
       data  => <<EOF,
userdel	2::temp 8573,12325 8540,12420
userdel	2::temp 8595,12066 8600,12165 8538,12245 8303,12216 8214,12205 8089,12190 8055,12186
userdel	2::temp 8538,12245 8546,12279 8570,12302
userdel	2::temp 8538,12245 8610,12254
EOF
     },
     { from  => 1271743200, # 2010-04-20 08:00
       until => 1272132000, # 2010-04-24 20:00
       text  => 'Ziegelstr. (Mitte): Veranstaltung, Stra�e vollst�ndig gesperrt, 21.04.2010 08:00 Uhr bis 24.04.2010 20:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_015565',
       data  => <<EOF,
userdel	2::temp 9262,13050 9413,13071 9559,13087
EOF
     },
     { from  => 1272607309, # 2010-04-30 08:01
       until => 1273183200, # 2010-05-07 00:00
       text  => 'H�henland: Verbot f�r Fahrzeuge Steinbeck-Brunow und umgekehrt 20.04.2010 bis 06.05.2010 ',
       type  => 'gesperrt',
       source_id => 'LSO-SG33-F10045',
       data  => <<EOF,
userdel	2::inwork 43155,35936 44203,35121
EOF
     },
     { from  => 1272214500, # 2010-04-25 18:55
       until => 1273092296, # 2010-05-14 22:55 1273870500
       text  => 'Roelckestr. (Wei�ensee) gesperrt, Baustelle In beiden Richtungen zwischen Pistoriusstr. und G�blerstr. 26.04.2010 18:55 Uhr bis 14.05.2010 22:55 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015593',
       data  => <<EOF,
userdel	q4::inwork 13104,16522 13272,16672
EOF
     },
     { from  => 1272956400, # 2010-05-04 09:00
       until => 1310326725, # 2011-07-29 16:00 1311948000
       text  => 'Blankenburger Chaussee (Karow): Baustelle, Fahrtrichtung gesperrt (Ende 07.2011) stadteinw�rts zwwischen Bahnhofstr. und Tarnowitzer Str., 05.05.2010 09:00 Uhr bis 29.07.2011 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015680',
       data  => <<EOF,
userdel	q4::inwork; 15428,22736 15357,22641 15271,22527 15154,22370
EOF
     },
     { from  => 1272860220, # 2010-05-03 06:17
       until => 1273237200, # 2010-05-07 15:00
       text  => 'Siemensstr. (Obersch�neweide): geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen Wilhelminenhofstr. und Edisonstr., 04.05.2010 06:17 Uhr bis 07.05.2010 15:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015641',
       data  => <<EOF,
userdel	q4::inwork 17962,6674 17860,6644 17766,6616 17614,6571
EOF
     },
     { from  => 1273091803, # 2010-05-05 22:36
       until => 1277935200, # 2010-07-01 00:00
       text  => 'Wandlitz: B273: Instandsetzung von Wintersch�den OD Wandlitz Ri. Wensickendorf Richtung Wensickendorf gesperrt, 04.05.2009 bis 30.06.2010 ',
       type  => 'handicap',
       source_id => 'LSO-SG33-E10043',
       data  => <<EOF,
userdel	q4::inwork; 13546,37474 13237,37524 12812,37567
EOF
     },
     { from  => 1272786420, # 2010-05-02 09:47
       until => 1275055200, # 2010-05-28 16:00
       text  => 'Zeltinger Str. (Reinickendorf): Baustelle, Fahrtrichtung gesperrt (bis Ende 05.2010) Richtung Zeltinger Platz zwischen Sch�nflie�er Str. und Zerndorfer Weg, 03.05.2010 09:47 Uhr bis 28.05.2010 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015638',
       data  => <<EOF,
userdel	q4::inwork; 3112,26253 3045,26078 2985,25883 2933,25830
EOF
     },
     { from  => 1273092119, # 2010-05-05 22:41
       until => 1293836400, # 2011-01-01 00:00
       text  => 'Zernitz-Lohm: L141: Ersatzneubau einer Br�cke ; Vollsperrung mit �rtlicher Umfahrung bei Zernitz, Br�cke �ber die Neue J�glitz Umfahrung mit LSA, 05.05.2010 bis 31.12.2010 ',
       type  => 'gesperrt',
       source_id => 'LSW-SG33-K10053',
       data  => <<EOF,
userdel	2::inwork -60868,50275 -60612,50931
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Ehemaliger Flughafen Tempelhof: das Befahren ist nur tags�ber m�glich ' .
                do {
		    # by: http://www.tempelhoferfreiheit.de/besuchen/oeffnungszeiten/
		    # by: http://www.tempelhofer-park.de/oeffnungszeiten/
		    my $mon = (localtime)[4]+1;
		    my $until = { 1 => '(im Januar von 7.30 bis 17.00 Uhr)',
				  2 => '(im Februar von 7.00 bis 18.00 Uhr)',
				  3 => '(im M�rz von 6.00 bis 19.00 Uhr)',
				  4 => '(im April von 6.00 bis 20.30 Uhr)',
				  5 => '(im Mai von 6.00 bis 21.30 Uhr)',
				  6 => '(im Juni von 6.00 bis 22.30 Uhr)',
				  7 => '(im Juli von 6.00 bis 22.30 Uhr)',
				  8 => '(im August von 6.00 bis 21.30 Uhr)',
				  9 => '(im September von 6.00 bis 20.30 Uhr)',
				  10 => '(im Oktober von 7.00 bis 19.00 Uhr)',
				  11 => '(im November von 7.00 bis 18.00 Uhr)',
				  12 => '(im Dezember von 7.30 bis 17.00 Uhr)',
				}->{$mon};
		    $until || '';
		} . '. Achtung: das Verlassen des Gel�ndes nach Sonnenuntergang ist f�r Tandems und Anh�nger schwierig oder gar nicht m�glich.',
       recurring => 1,
       data  => <<EOF,
(Eingang Columbiadamm - Rundkurs auf dem Flughafen Tempelhof)	2::night 10691,8532 10644,8363 10598,8270 10575,8218
(Eingang Columbiadamm - Rundkurs auf dem Flughafen Tempelhof)	2::night 10598,8270 10729,8152
(Eingang Columbiadamm/Gol�ener Str. - Rundkurs auf dem Flughafen Tempelhof)	2::night 10384,8628 10360,8521 10298,8245
(Rundkurs auf dem Flughafen Tempelhof)	2::night 11460,7802 11470,7744 11543,7369 11593,7314 11598,7264 11407,7198 11310,7071 11128,6967 10944,6790 10746,6693 10558,6661 10282,6692 10023,6806 9792,6964 9681,7075 9509,7195 9545,7426 9525,7558
(Rundkurs auf dem Flughafen Tempelhof)	2::night 9525,7558 9522,7624 9562,7796 9619,7930 9709,8127 9784,8209 9884,8265 10037,8269 10298,8245 10575,8218
(Rundkurs auf dem Flughafen Tempelhof)	2::night 10575,8218 10729,8152 10909,8003 11090,7916 11264,7882 11355,7871 11388,7777 11460,7447 11518,7314
(Rundkurs auf dem Flughafen Tempelhof - Eingang Tempelhofer Damm)	2::night 9525,7558 9431,7425 9386,7326 9300,7312 9302,7294 9242,7286
(Weg parallel zum Tempelhofer Damm)	2::night  9300,7312 9281,7651 9281,7795
(Eingang Peter-Strasser-Weg)	2::night 9281,7795 9240,7811
(N�rdliche Landebahn - Eingang Peter-Strasser-Weg)	2::night 9362,7616 9281,7651
(Rundkurs auf dem Flughafen Tempelhof - Eingang Peter-Strasser-Weg)	2::night 9562,7796 9372,7798 9281,7795
(S�dliche Landebahn)	2::night 9461,7190 9509,7195 9677,7206 11332,7305 11518,7314 11593,7314
(S�dliche Landebahn - Rundkurs)	2::night 11332,7305 11438,7371 11460,7447
(N�rdliche Landebahn)	2::night 9362,7616 9522,7624 9653,7635 10204,7680 11279,7768 11388,7777 11430,7781 11460,7802
(N�rdliche Landebahn - Eingang Oderstr./Herrfurthstr.)	2::night 11460,7802 11439,7894
(Eingang Oderstr./Herrfurthstr. - Flughafen Tempelhof)	2::night 11472,7899 11458,7897 11439,7894
(Strecke an der nord�stlichen Begrenzung - Rundkurs)	2::night 11005,8064 10909,8003
(Strecke an der nord�stlichen Begrenzung)	2::night 11439,7894 11418,8015 11327,8007 11303,8089 11143,8139 11005,8064 10803,8251 10644,8363 10360,8521
(Weg parallel zur Oderstr.)	2::night 11458,7897 11489,7748 11507,7647 11528,7528 11547,7432 11554,7382 11593,7314
(Eingang Kienitzer Str.)	2::night 11498,7750 11489,7748 11479,7746 11470,7744
(Flughafen Tempelhof - Eingang Allerstr.)	2::night 11507,7647 11516,7654
(Flughafen Tempelhof - Eingang Okerstr.)	2::night 11528,7528 11540,7534
(Flughafen Tempelhof - Eingang Leinestr.)	2::night 11547,7432 11558,7438
(Flughafen Tempelhof - Eingang Oderstr.)	2::night 11598,7264 11608,7267
(Eingang Tempelhofer Damm - s�dliche Landebahn)	2::night 9302,7294 9351,7241 9461,7190
(Alter Hafen)	2::night 10204,7680 10134,7797 10076,8040 10037,8269
EOF
     },
     { from  => 1304110406, # 2011-04-29 22:53
       until => 1315087199, # 2011-09-03 23:59 #        until => 1314914399, # 2011-09-01 23:59
       text  => 'Lahnstr. (Neuk�lln) Richtung Grenzallee zwischen Mierstr. und Niemetzstr. Baustelle, in beiden Richtungen gesperrt (bis Anfang 09/2011) ',
       type  => 'handicap',
       source_id => 'INKO_107124', # auch: http://www.berlin.de/ba-neukoelln/presse/archiv/20110819.1100.355442.html
       data  => <<EOF,
userdel	q4::inwork 13627,7047 13891,7107
EOF
     },
     { from  => 1274300387, # 2010-05-19 22:19
       until => 1280181600, # 2010-07-27 00:00
       text  => 'Oberkr�mer: L17: grundhafter Ausbau der Ortsdurchfahrt OD Schwante zw. Ortseingang und Kreisverkehr, 17.05.2010 bis 26.07.2010 ',
       type  => 'handicap',
       source_id => 'LS/O-SG33-E/10/042',
       data  => <<EOF,
userdel	q4::inwork -11307,35852 -11541,36139
EOF
     },
     { from  => 1274001000, # 2010-05-16 11:10
       until => 1276264800, # 2010-06-11 16:00
       text  => 'Otternbuchtstr. (Spandau): Baustelle, Fahrtrichtung gesperrt (bis voraus. Ende 05/2010) Richtung Nonnendammallee zwischen Motardstr. und Nonnendammallee, 17.05.2010 11:10 Uhr bis 11.06.2010 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015726',
       data  => <<EOF,
userdel	q4::inwork; -260,14210 -245,14333 -283,14523
EOF
     },
     { from  => 1274188260, # 2010-05-18 15:11
       until => 1274612350, # 2010-06-18 18:00 1276876800
       text  => 'Stuttgarter Platz (Charlottenburg): Baustelle, Fahrtrichtung gesperrt (bis Mitte 06/2010) Richtung Kaiser-Friedrich-Str. ab Wilmersdorfer Str., 19.05.2010 15:11 Uhr bis 18.06.2010 18:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015738',
       data  => <<EOF,
userdel	q4::inwork; 3827,10980 3546,10962
EOF
     },
     { from  => 1273997280, # 2010-05-16 10:08
       until => 1274450880, # 2010-05-21 16:08
       text  => 'Westf�lische Str. (Wilmersdorf): Baustelle, Fahrtrichtung gesperrt (bis Ende 05/2010) Richtung Kurf�rstendamm zwischen Joachim-Friedrich-Str. und Johann-Sigismund-Str., 17.05.2010 10:08 Uhr bis 21.05.2010 16:08 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015724',
       data  => <<EOF,
userdel	q4::inwork; 3092,9886 2938,9935
EOF
     },
     { from  => 1274019000, # 2010-05-16 16:10
       until => 1275318720, # 2010-05-31 17:12
       text  => 'Wiltbergstr. (Pankow): Baustelle, f�r beide Richtungen nur ein Fahrstreifen abwechselnd frei (bis ca. Ende 05/2010) in beiden Richtungen zwischen Alt-Buch und R�bellweg, 17.05.2010 16:10 Uhr bis 31.05.2010 17:12 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015731',
       data  => <<EOF,
userdel	q3::inwork 16414,25575 16294,25683 16220,25716 16166,25767 16114,25827 16045,25907
EOF
     },
     { from  => 1274820117, # 2010-05-25 22:41
       until => 1286575200, # 2010-10-09 00:00
       text  => 'Treuenbrietzen: L82: Bau Schmutzwasser- und Trinkwasserleitungen OL Marzahna, 27.05.2010 bis 08.10.2010',
       type  => 'gesperrt',
       source_id => '106900348',
       data  => <<EOF,
userdel	2::inwork -29601,-47258 -30976,-45652
EOF
     },
     { from  => 1275170400, # 2010-05-30 00:00
       until => 1285883999, # 2010-09-30 23:59
       text  => 'Marksburgstra�e, Bauarbeiten zwischen Treskowallee und Hentigstra�e, 31.05. bis 30.09., Fahrbahn gesperrt',
       type  => 'handicap',
       # XXX URL existiert nicht mehr: source_id => 'http://www.berlin.de/ba-lichtenberg/presse/archiv/20100528.1110.297131.html',
       data  => <<EOF,
userdel	q4::inwork 18809,9133 18697,9153 18586,9172
EOF
     },
     { from  => 1281736800, # 2010-08-14 00:00
       until => 1288652399, # 2010-11-01 23:59
       text  => 'Marksburgstra�e, Bauarbeiten zwischen Hentigstra�e und Sangeallee, 15.08. bis 01.11., Fahrbahn gesperrt ',
       type  => 'handicap',
       # XXX URL existiert nicht mehr: source_id => 'http://www.berlin.de/ba-lichtenberg/presse/archiv/20100528.1110.297131.html',
       data  => <<EOF,
userdel	q4::inwork 18586,9172 18511,9185 18430,9199 18319,9218
EOF
     },
     { from  => $isodate2epoch->("2013-05-30 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-06-01 23:59:59"),
       periodic => 1,
       text  => 'Erkner: Heimatfest, 31.5.2013 bis 2.6.2013',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 34443,1951 34250,2546
EOF
     },
     { from  => 1275537600, # 2010-06-03 06:00
       until => 1275861540, # 2010-06-06 23:59
       text  => 'Neue Krugallee (Treptow): Veranstaltung, gesperrt. Ebenso gesperrt Bulgarische Str. zw. Neue Krugallee und Parkplatz (bis 06.06.10 24.00 Uhr) in beiden Richtungen zw. Bulgarische Str. und Am Pl�nterwald, 04.06.2010 06:00 Uhr bis 06.06.2010 23:59 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015813',
       data  => <<EOF,
userdel	q4::temp 15778,8990 15680,8914 15591,8848 15714,8633
EOF
     },
     { from  => 1276547925, # 2010-06-14 22:38
       until => 1291158000, # 2010-12-01 00:00
       text  => 'Neuruppin: K6828: Stra�enbau OL Karwe, 14.06.2010 bis 30.11.2010',
       type  => 'gesperrt',
       source_id => '106800201',
       data  => <<EOF,
userdel	2::inwork -27035,49829 -25968,49631
EOF
     },
     { from  => 1276547986, # 2010-06-14 22:39
       until => 1292626800, # 2010-12-18 00:00
       text  => 'Rehfelde: K6419: Stra�enausbau OL Rehfelde, zw. Bahnhofstra�e und Kreisverkehr, 07.06.2010 bis 17.12.2010 ',
       type  => 'handicap',
       source_id => '106401098',
       data  => <<EOF,
userdel	q4::inwork 45856,14437 44121,14615
EOF
     },
     { from  => 1276548087, # 2010-06-14 22:41
       until => 1293663600, # 2010-12-30 00:00
       text  => 'Wusterhausen/Dosse: K6806, B167: Stra�enbauarbeiten OD Metzelthin , 07.06.2010 bis 29.12.2010 ',
       type  => 'gesperrt',
       source_id => 'LS/W-SG33-K/10/066',
       data  => <<EOF,
userdel	2::inwork -50068,51237 -51018,51135
EOF
     },
     { from  => $isodate2epoch->("2013-06-21 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-06-22 23:59:59"),
       periodic => 1,
       text  => 'CSD am 22.6.2012',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 10605,10312 10363,10303 10122,10294 9948,10280 9873,10285 9593,10238 9492,10226 9404,10250 9388,10393 9384,10536 9375,10616 9368,10641 9323,10791 9275,10932 9234,11056 9196,11165 9155,11283 8720,11226 8631,11334 8602,11369 8573,11404 8542,11502 8548,11571 8553,11630 8553,11638 8567,11799 8571,11846 8577,11896 8632,11912 8783,11959 8901,12008 9063,12051 9076,12054 9183,12076 9164,12172 9141,12320 9130,12433 9123,12500 9008,12485 8907,12472 8775,12457 8540,12420 8400,12417 8354,12416 8119,12414 8055,12186 8089,12190 8214,12205 8303,12216 8538,12245
userdel	2::temp 8546,12279 8538,12245 8600,12165
userdel auto	3 9108,11961 9076,12054 9064,12156
userdel auto	3 8573,12325 8540,12420 8554,12593
userdel auto	3 9358,12351 9141,12320 9028,12307
userdel auto	3 9599,10175 9593,10238 9592,10263
userdel auto	3 10178,10411 10122,10294 10083,10192
userdel auto	3 8610,12254 8538,12245 8522,12187
userdel auto	3 8610,12254 8538,12245 8522,12239
userdel auto	3 7816,12150 8055,12186 8048,12135
userdel auto	3 8861,12125 8901,12008 8972,11810
userdel auto	3 8048,12135 8055,12186 7816,12150
userdel auto	3 9201,11968 9183,12076 9270,12086 9385,12098
userdel auto	3 9865,10227 9873,10285 9858,10350
userdel auto	3 9865,10227 9873,10285 9668,10306
userdel auto	3 9409,10226 9404,10250 9239,10313
userdel auto	3 8766,12541 8775,12457 8804,12280
userdel auto	3 8442,11555 8542,11502 8596,11508
userdel auto	3 8442,11555 8542,11502 8479,11493
userdel auto	3 8522,12239 8538,12245 8522,12187
userdel auto	3 8522,12239 8538,12245 8610,12254
userdel auto	3 9539,10820 9323,10791 9131,10716
userdel auto	3 9330,12529 9123,12500 9108,12635
userdel auto	3 8737,12098 8783,11959 8813,11825
userdel auto	3 9559,10656 9368,10641 9210,10614
userdel auto	3 8596,11508 8542,11502 8479,11493
userdel auto	3 8596,11508 8542,11502 8442,11555
userdel auto	3 9028,12307 9141,12320 9358,12351
userdel auto	3 9239,10313 9404,10250 9409,10226
userdel auto	3 9058,11564 9155,11283 9478,11317
userdel auto	3 9016,12416 9130,12433 9343,12464
userdel auto	3 8972,11810 8901,12008 8861,12125
userdel auto	3 9250,10563 9388,10393 9527,10389
userdel auto	3 9131,10716 9323,10791 9539,10820
userdel auto	3 9385,12098 9270,12086 9183,12076 9201,11968
userdel auto	3 8554,12593 8540,12420 8573,12325
userdel auto	3 9108,12635 9123,12500 9330,12529
userdel auto	3 9858,10350 9873,10285 9668,10306
userdel auto	3 9858,10350 9873,10285 9865,10227
userdel auto	3 8070,12409 8119,12414 8122,12608
userdel auto	3 9343,12464 9130,12433 9016,12416
userdel auto	3 8479,11493 8542,11502 8596,11508
userdel auto	3 8479,11493 8542,11502 8442,11555
userdel auto	3 8522,12187 8538,12245 8522,12239
userdel auto	3 8522,12187 8538,12245 8610,12254
userdel auto	3 9373,12197 9164,12172 9064,12156
userdel auto	3 9210,10614 9368,10641 9559,10656
userdel auto	3 8743,11663 8553,11638 8473,11634
userdel auto	3 8122,12608 8119,12414 8070,12409
userdel auto	3 9592,10263 9593,10238 9599,10175
userdel auto	3 9064,12156 9076,12054 9108,11961
userdel auto	3 9064,12156 9164,12172 9373,12197
userdel auto	3 9668,10306 9873,10285 9858,10350
userdel auto	3 9668,10306 9873,10285 9865,10227
userdel auto	3 9527,10389 9388,10393 9250,10563
userdel auto	3 10083,10192 10122,10294 10178,10411
userdel auto	3 9478,11317 9155,11283 9058,11564
userdel auto	3 8473,11634 8553,11638 8743,11663
userdel auto	3 8813,11825 8783,11959 8737,12098
userdel auto	3 8804,12280 8775,12457 8766,12541
EOF
     },
     { from  => 1276783200, # 2010-06-17 16:00
       until => 1277089200, # 2010-06-21 05:00
       text  => 'Frohnauer Br�cke (Reinickendorf): Veranstaltung, gesperrt (bis 21.06.10, 5 Uhr) und Zeltinger Platz sowie Ludolfinger Platz, 18.06.2010 16:00 Uhr bis 21.06.2010 05:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015895',
       data  => <<EOF,
userdel	q4::temp 2404,25187 2277,25094
EOF
     },
     { from  => 1276833600, # 2010-06-18 06:00
       until => 1276977600, # 2010-06-19 22:00
       text  => 'Gotzkwoskystra�e (Tiergarten): Veranstaltung, gesperrt (bis 22 Uhr) in beide Richtungen zwischen Alt-Moabit und Turmstra�e, 19.06.2010 06:00 Uhr bis 19.06.2010 22:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_015893',
       data  => <<EOF,
userdel	q4::temp 5368,13406 5351,13238 5328,13019
EOF
     },
     { from  => 1276833600, # 2010-06-18 06:00
       until => 1276966800, # 2010-06-19 19:00
       text  => 'Lipschitzallee (Neuk�lln): Veranstaltung, gesperrt (bis 19 Uhr) in beiden Richtungen zwischen Fritz-Erler-Allee und Rudower Stra�e, 19.06.2010 06:00 Uhr bis 19.06.2010 19:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_015892',
       data  => <<EOF,
userdel	q4::temp 14946,2519 15078,2647 15174,2773 15254,2926 15301,3038
EOF
     },
     { from  => 1276790400, # 2010-06-17 18:00
       until => 1277085600, # 2010-06-21 04:00
       text  => 'Melchow: L200: Gleisbauarbeiten Bahn�bergang bei Melchow , 18.06.2010 18:00 Uhr bis 21.06.2010 04:00 Uhr ',
       type  => 'gesperrt',
       source_id => '106000270',
       data  => <<EOF,
userdel	2::inwork 30143,41500 29553,41441 29468,41438
EOF
     },
     { from  => 1276869600, # 2010-06-18 16:00
       until => 1279231140, # 2010-07-15 23:59
       text  => 'Stra�e des 17. Juni (Tiergarten): FIFA Fan Fest, Stra�e vollst�ndig gesperrt (bis 15. Juli, 24 Uhr) in beiden Richtungen zwischen Gro�er Stern und Eberstr., ebenso Yitzhak-Rabin-Str. sowie der �stliche Tiergarten, 19.06.2010 16:00 Uhr bis 15.07.2010 23:59 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_015899',
       data  => <<EOF,
userdel	2::temp 8055,12186 7816,12150 7383,12095 6828,12031
userdel	2::temp 8089,12190 8055,12186 8119,12414
userdel auto	3 7460,12054 7383,12095 7039,12314
userdel auto	3 7827,12105 7816,12150 7875,12363
userdel auto	3 7875,12363 7816,12150 7827,12105
userdel auto	3 7039,12314 7383,12095 7460,12054
userdel	2::temp 7382,11588 7163,11738 7287,11763 7535,11677
userdel	2::temp 8021,11636 8016,11770 7801,11875 7717,11918 7663,11946
userdel	2::temp 7796,11681 7816,11571
userdel	2::temp 8022,12016 8016,11770 7901,11684
userdel	2::temp 7816,12150 7875,12363
userdel	2::temp 7711,11558 7669,11586 7621,11620 7606,11629
userdel	2::temp 8055,12186 8048,12135 8034,12093
userdel	2::temp 7822,11952 7832,12036
userdel	2::temp 8172,11679 8016,11770 8156,11863 8210,11775
userdel	2::temp 7696,11621 7735,11656
userdel	2::temp 7039,12314 7383,12095
userdel	2::temp 7795,11823 7777,11787
userdel	2::temp 6778,11742 7073,11798 6809,11979
userdel	2::temp 8091,11992 8089,12041
userdel	2::temp 8018,12131 7827,12105 7777,12098 7460,12054 7663,11946 7570,11855 7223,11897 7182,11870 7173,11864 7073,11798 7163,11738 6980,11583
userdel	2::temp 7460,12054 6857,11992
EOF
     },
     { from  => $isodate2epoch->("2013-06-27 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-06-30 23:59:59"),
       periodic => 1,
       text  => 'Bergmannstra�e (Kreuzberg): Veranstaltung (Bergmannstra�enfest), Stra�e vollst�ndig zwischen Mehringdamm und Zossener Str. gesperrt (28. bis 30. Juni 2013)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 9248,9350 9309,9347 9489,9309 9505,9306 9632,9280 9689,9266 9753,9252
userdel auto	3 9487,9209 9505,9306 9524,9426
userdel auto	3 9524,9426 9505,9306 9487,9209
EOF
     },
     { from  => 1277443049, # 2010-06-25 07:17
       until => 1324422000, # 2011-12-21 00:00
       text  => 'Cottbus: L511: Stra�en- und Kanalbauarbeiten Cottbus, OT Sielow , 20.06.2010 bis 20.12.2011 ',
       type  => 'handicap',
       source_id => '105200001',
       data  => <<EOF,
userdel	q4::inwork 73237,-66975 73640,-67643
EOF
     },
     { from  => 1277589600, # 2010-06-27 00:00
       until => 1279576799, # 2010-07-19 23:59
       text  => 'Instandsetzung des Radweges K�nigsweg zwischen Eichkampstra�e und H�ttenweg, ab 28.06.2010 f�r drei Wochen komplett gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -903,6923 -643,7252 -348,7641 425,8766
EOF
     },
     { from  => 1278267896, # 2010-07-04 20:24
       until => Time::Local::timelocal(reverse(2011-1900,3-1,31,12,0,0)), # 1293836400, # 2011-01-01 00:00
       text  => 'Tauche: B87: Ausbau der Ortslage Trebatsch hier: Vollsperrung der Spreebr�cke B 87, Ortslage Trebatsch, 24.02.2010 bis 31.03.2011 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-F/10/013',
       data  => <<EOF,
userdel	2::inwork 63609,-34428 63520,-34874
EOF
     },
     { from  => 1278267949, # 2010-07-04 20:25
       until => 1278969842, # 2010-07-31 00:00 1280527200
       text  => 'Wandlitz: L315: Grundhafter Ausbau der L 315 unter Vollsperrung Prenden - Klosterfelde, 26.04.2010 bis 30.07.2010 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-E/10/041',
       data  => <<EOF,
userdel	2::inwork 19611,43150 19578,43131 19107,43180 18720,43107 17840,43420 17394,43597 17006,43801 16258,43457 15783,43227 15632,43100 14941,42957
EOF
     },
     { from  => 1279836000, # 2010-07-23 00:00
       until => 1280613600, # 2010-08-01 00:00
       text  => 'Alt-Rudow zwischen K�penicker Stra�e und Neudecker vom 24.07.2010 bis zum 31.07.2010 vollst�ndig gesperrt. Die Einbahnstra�enregelung Am Hanfgraben wird umgekehrt. ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 16849,1437 16975,1262
EOF
     },
     { from  => 1278270043, # 2010-07-04 21:00
       until => 1280613599, # 2010-07-31 23:59
       text  => 'Wilhelminenhofstra�e zwischen Rathenau- und Firlstra�e vom 7. bis 31. Juli 2010 in beiden Richtungen f�r den Fahrzeugverkehr gesperrt; die Rathenaustra�e in Richtung Pl�nzeile als Einbahnstra�e ausgewiesen.',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 18970,6110 18861,6000 18843,6013 18766,6067 18670,6132 18574,6197 18473,6265
EOF
     },
     { from  => undef, # 
       until => undef, # XXX
       text  => 'Johannes-Kraatz-Str.: Tor, Zugang k�nnte versperrt sein',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
userdel	2::temp 18870,5833 18932,5926
EOF
     },
     { from  => 1278970058, # 2010-07-12 23:27
       until => 1289602800, # 2010-11-13 00:00
       text  => 'Buckow (M�rkische Schweiz), Stadt: K6413: Deckenerneuerung, Instandsetzung Durchl�sse Bollersdorf - Buckow, 08.07.2010 bis 12.11.2010 ',
       type  => 'handicap',
       source_id => '106401308',
       data  => <<EOF,
userdel	q4::inwork 55377,20271 55292,20466 55207,20563 55131,20837
EOF
     },
     { from  => 1278478800, # 2010-07-07 07:00
       until => 1282428000, # 2010-08-22 00:00
       text  => 'Lebus: B112: Instandsetzungsarbeiten Br�cke �ber das Alt Zeschdorfer Flie� bei Lebus - OT W�ste Kunersdorf, 08.07.2010 07:00 Uhr bis 21.08.2010 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-F/10/089',
       data  => <<EOF,
userdel	2::inwork 87344,3693 86769,1414
EOF
     },
     { from  => 1278970267, # 2010-07-12 23:31
       until => 1282773600, # 2010-08-26 00:00
       text  => 'Zossen: B96: Deckenerneuerung W�nsdorf - Zossen, 12.07.2010 bis 25.08.2010 ',
       type  => 'gesperrt',
       source_id => 'LS/S-SG33-W/10/140',
       data  => <<EOF,
userdel	2::inwork 15118,-24016 15693,-26169
EOF
     },
     { from  => 1279050848, # 2010-07-13 21:54
       until => 1283291999, # 2010-08-31 23:59
       text  => 'Fahrbahnsanierung in der Pestalozzistra�e zwischen Wielandstra�e und Schl�terstra�e, ab Montag, 12.07.2010 bis Ende August 2010, nur einspurig in Fahrtrichtung Wielandstra�e befahrbar.',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 4434,11227 4555,11216
EOF
     },
     { from  => undef, # 
       until => undef, # XXX
       text  => 'Gewerbegebiet: Privatstra�en, u.U. Durchfahrt nicht gestattet',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
#: note: allerdings keine Hinweise auf eine verbotene Durchfahrt gesehen
(Gewerbegebiet)	2 21617,3287 21826,3129 21770,2936 21816,2919 21939,2894 21984,2897 22004,2904
EOF
     },
     { from  => 1279577078, # 2010-07-20 00:04
       until => 1320102000, # 2011-11-01 00:00
       text  => 'Degnerstr., Bauarbeiten, Einbahnstra�e in Richtung S�den, bis Oktober 2011',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-lichtenberg/presse/archiv/20100714.1400.303010.html',
       data  => <<EOF,
userdel	q4::inwork; 16692,16253 16806,16496 16849,16551 17014,16724
EOF
     },
     { from  => 1279436400, # 2010-07-18 09:00
       until => 1283526000, # 2010-09-03 17:00
       text  => 'Schmidt-Knobelsdorf-Stra�e (Spandau): Baustelle, Einbahnstra�e in Richtung Lutoner Str., 19.07.2010 09:00 Uhr bis 03.09.2010 17:00 Uhr',
       type  => 'handicap',
       source_id => 'IM_016077',
       data  => <<EOF,
userdel	q4::inwork; -5030,13017 -4725,12883 -4494,12776 -4277,12675 -4239,12626
EOF
     },
     { from  => 1273993200, # 2010-05-16 09:00
       until => 1281304800, # 2010-08-09 00:00
       text  => 'Nauen: L201: Br�ckeninstandsetzung Alt Brieselang - B273 Br�cke H�he AS Falkensee, 17.05.2010 09:00 Uhr bis 08.08.2010 ',
       type  => 'gesperrt',
       source_id => '101100060',
       data  => <<EOF,
userdel	2::inwork -19282,23081 -17931,23152
EOF
     },
     { from  => 1280677738, # 2010-08-01 17:48
       until => 1281132000, # 2010-08-07 00:00
       text  => 'Wriezen: K6436: Verlegung OPAL Erdgasleitung Wriezen - Altgaul, 07.07.2010 bis 06.08.2010 ',
       type  => 'gesperrt',
       source_id => '106401404',
       data  => <<EOF,
userdel	2::inwork 58456,36743 58206,37275
EOF
     },
     { from  => 1280677929, # 2010-08-01 17:52
       until => 1288303200, # 2010-10-29 00:00
       text  => 'Brandenburg an der Havel: L93: Ausbau Bahn�bergang Wilhelmsdorfer Landstra�e, 27.07.2010 bis 28.10.2010 01:00 Uhr ',
       type  => 'handicap',
       source_id => '105100738',
       data  => <<EOF,
userdel	q4::inwork -48338,-2586 -48114,-2344 -47938,-2184
EOF
     },
     { from  => 1280678128, # 2010-08-01 17:55
       until => 1288303200, # 2010-10-29 00:00
       text  => 'Brandenburg an der Havel: L93: Ausbau Bahn�bergang Ziesarer Landstra�e, 27.07.2010 bis 28.10.2010 01:00 Uhr',
       type  => 'handicap',
       source_id => '105100738_1',
       data  => <<EOF,
userdel	q4::inwork -49042,-3647 -48542,-2958 -48338,-2586
EOF
     },
     { from  => 1335556384, # 2012-04-27 21:53
       until => 1380578400, # 2013-10-01 00:00
       text  => 'Lichterfeld-Schacksdorf: L60: Bauma�nahme der LMBV Lauchhammer - Licherfelde und umgekehrt, 23.04.2012 bis 30.09.2013 ',
       type  => 'gesperrt',
       source_id => '126200259',
       data  => <<EOF,
userdel	2::inwork 37809,-92300 37918,-93202 37419,-94853 37230,-95682
EOF
     },
     { from  => 1280678341, # 2010-08-01 17:59
       until => 1282168800, # 2010-08-19 00:00
       text  => 'Petershagen/Eggersdorf: K6422: Kanal-/Leitungsbau (TW) OL Petershagen, 03.08.2009 bis 18.08.2010 ',
       type  => 'handicap',
       source_id => '096401484',
       data  => <<EOF,
userdel	q4::inwork 35900,13643 35427,13624
EOF
     },
     { from  => 1292490120, # 2010-12-16 10:02
       until => 1293112800, # 2010-12-23 15:00
       text  => 'Tucholskystr. (Mitte): Baustelle, Stra�e vollst�ndig gesperrt (bis 23.12.2010) in beiden Richtungen zwischen Oranienburger Str. und Auguststr., 17.12.2010 10:02 Uhr bis 23.12.2010 15:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016759',
       data  => <<EOF,
userdel	q4::inwork 9611,13245 9651,13406
EOF
     },
     { from  => 1280687843, # 2010-08-01 20:37
       until => 1281823199, # 2010-08-14 23:59
       text  => 'Sperrung der Eisenacher Stra�e zwischen dem Blumberger Damm und der Gothaer Stra�e vom 02. August bis zum 14. August 2010 ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-marzahn-hellersdorf/aktuelles/presse/archiv/20100720.1055.303592.html',
       data  => <<EOF,
userdel	q4::inwork 22605,15111 22449,15127 22419,15127 22343,15115 22059,15153
EOF
     },
     { from  => 1281128604, # 2010-08-08 00:00 1281218400
       until => 1281128608, # 2010-09-10 00:00 1284069600 --- wird auf September verschoben
       text  => 'Einbahnstra�enregelung in der Wasserwerkstr., Richtung Pionierstra�e offen, vom 09.08.2010 bis zum 09.09.2010 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; -5806,16403 -5830,16356 -5849,16199 -5875,15994 -5911,15877
EOF
     },
     { from  => 1280613600, # 2010-08-01 00:00
       until => 1282341600, # 2010-08-21 00:00
       text  => 'Fahrbahnsanierung am Dahlemer Weg vom 02.08.2010 bis 20.08.2010, zwischen der McNair-Promenade und der Seehofstra�e in Richtung Norden gesperrt ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 1785,1338 1825,1534 1848,1647 1854,1677 1873,1772 1945,2127
EOF
     },
     { from  => 1280635200, # 2010-08-01 06:00
       until => 1285941600, # 2010-10-01 16:00
       text  => 'Lehrter Str. (Moabit): Baustelle, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen Invalidenstr. und Seydlitzstr., 02.08.2010 06:00 Uhr bis 01.10.2010 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016121',
       data  => <<EOF,
userdel	q4::inwork 7759,13246 7651,13447 7643,13461 7660,13506 7655,13539
EOF
     },
     { from  => 1280985970, # 2010-08-05 07:26
       until => 1282946400, # 2010-08-28 00:00
       text  => 'Plessa: K6208: Gleisbauarbeiten und Umbau des B�, Stra�en- und Schwarzdeckeneinbau OL Kahla, Bahn�bergang, 03.08.2010 bis 27.08.2010 ',
       type  => 'gesperrt',
       source_id => '106200364',
       data  => <<EOF,
userdel	2::inwork 23805,-103848 24165,-103467 25237,-102574
EOF
     },
     { from  => 1281391200, # 2010-08-10 00:00
       until => 1282427999, # 2010-08-21 23:59
       text  => 'In der Zeit vom 11.08. bis voraussichtlich 21.08. wird die Dessauer Stra�e zwischen K�thener Stra�e und Schwarzwurzelstra�e auf Grund von Fahrbahnsanierungsarbeiten voll gesperrt. ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-marzahn-hellersdorf/aktuelles/presse/archiv/20100804.0935.305087.html',
       data  => <<EOF,
userdel	q4::inwork 20576,17994 20460,18030 20351,18066 20256,18096 20232,18123 20186,18238
EOF
     },
     { from  => 1281247200, # 2010-08-08 08:00
       until => 1322694000, # 2011-12-01 00:00
       text  => 'Nuthetal: L77, L771: Bau OU G�terfelde, Berliner Stra�e / Stahnsdorfer Damm, 09.08.2010 08:00 Uhr bis 30.11.2011 ',
       type  => 'gesperrt',
       source_id => 'LS/W-SG33-P/10/410',
       data  => <<EOF,
userdel	2::inwork -2815,-3574 -3368,-4430
EOF
     },
     { from  => 1290975348, # 2010-11-28 21:15
       until => 1292626800, # 2010-12-18 00:00
       text  => 'Belzig: K6933: Br�ckeninstandsetzung / Streckenausbau Bad Belzig - Borne, 16.08.2010 bis 17.12.2010 ',
       type  => 'gesperrt',
       source_id => '106900748',
       data  => <<EOF,
userdel	2::inwork -45941,-31977 -46134,-32389 -46514,-32785
EOF
     },
     { from  => 1283547955, # 2010-09-03 23:05
       until => 1292972400, # 2010-12-22 00:00
       text  => 'Bernau bei Berlin: L314: Verlegung Trinkwasser/ Sanierung Schmutzwasser, Ausbau n�rdl. Geh- und Radweg OD Bernau, Zepernicker Chaussee zw. Elbestr. und Autobahnbr�cke gesperrt, 30.08.2010 bis 21.12.2010 ',
       type  => 'handicap',
       source_id => '106000506',
       data  => <<EOF,
userdel	q4::inwork; 20537,29285 20704,29485 21085,29942
EOF
     },
     { from  => 1283457600, # 2010-09-02 22:00
       until => 1283630400, # 2010-09-04 22:00
       text  => 'Boxhagener Str. (Friedrichshain): Bauarbeiten an der Eisenbahn�berf�hrung, Stra�e vollst�ndig gesperrt (bis 04.09., 22 Uhr) in beiden Richtungen zwischen zwischen Kynaststr. und Neue Bahnhofstr., 03.09.2010 22:00 Uhr bis 04.09.2010 22:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_016276',
       data  => <<EOF,
userdel	2::inwork 14918,11249 14988,11130
EOF
     },
     { from  => 1283237460, # 2010-08-31 08:51
       until => 1285000200, # 2010-09-20 18:30
       text  => 'Romain-Rolland-Str. (Heinersdorf): Baustelle, Fahrtrichtung gesperrt (bis Ende 09/2010) Richtung Hohensch�nhausen zwischen Rothenbachstr. und Berliner Str., 01.09.2010 08:51 Uhr bis 20.09.2010 18:30 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016256',
       data  => <<EOF,
userdel	q4::inwork; 12566,18275 12592,18230 12690,18079 12736,17998
EOF
     },
     { from  => 1284532129, # undef
       until => 1284532135, # XXX undef
       text  => 'Mariannenstr. zwischen Skalitzer Str. und Heinrichplatz: Fahrbahn gesperrt',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 11722,10533 11671,10402
EOF
     },
     { from  => 1283623066, # 2010-09-04 19:57
       until => 1291157999, # 2010-11-30 23:59:59
       text  => 'Die Charlottenstra�e zwischen Hermann-Elflein-Stra�e und Schopenhauerstra�e ist f�r den Bau von Hausanschl�ssen halbseitig gesperrt. Im Baubereich ist eine Einbahnstra�e in Richtung Wilhelmgalerie eingerichtet. Die Arbeiten dauern bis voraus. Ende November 2010. ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; -13392,-1196 -13516,-1225
EOF
     },
     { from  => 1281218400, # 2010-08-08 00:00
       until => 1343685600, # 2012-07-31 00:00
       text  => 'F�r die Arbeiten an der Br�cke des Friedens in Neu Fahrland wird der Lerchensteig auf der gesamten Baul�nge zwischen Nedlitzer Stra�e und Am Golfplatz voll gesperrt . Der Zeitraum f�r diese Arbeiten ist vom 09.08.2010 bis ca. 30.07.2012 geplant ',
       type  => 'handicap',
       source_id => 'http://www.potsdam.de/cms/beitrag/10067788/966975/',
       data  => <<EOF,
userdel	q4::inwork -13387,2987 -13581,3075 -13840,2956 -14382,3066
EOF
     },
     { from  => 1284532162, # undef
       until => 1284532308, # undef
       text  => 'Die Wilhelm-Kabus-Str. ist noch nicht komplett fertig gestellt. Unter Umst�nden ist die Durchfahrt nicht m�glich!',
       type  => 'handicap',
       data  => <<EOF,
	2::inwork 7733,8023 7793,8043 7834,8085 7859,8252 7893,8327 7942,8380 8078,8772
EOF
     },
     { from  => $isodate2epoch->("2013-07-12 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-07-14 23:59:59"),
       periodic => 1, # zweiter Termin im Jahr
       text  => 'Rheinstra�e (Friedenau): Veranstaltung (traditionelles Rheinstra�enfest), Stra�e vollst�ndig zwischen Walther-Schreiber-Platz und Kaisereiche gesperrt (13. und 14. Juli 2013)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 5370,6486 5424,6584 5533,6753 5644,6936
EOF
     },
     { from  => 1346968800, # 2012-09-07 00:00 # PERIODISCH!
       until => 1347228000, # 2012-09-10 00:00
       text  => 'Bahnhofstra�e (Lichtenrade): Veranstaltung, Stra�e vollst�ndig gesperrt zwischen Goltzstr. und Steinstr. (bis 09.09.12 nachts)',
       type  => 'handicap',
       source_id => 'IM_019152',
       data  => <<EOF,
userdel	q4::temp 10310,-2136 10453,-2133 10509,-2131 10631,-2130 10747,-2129 10983,-2116
EOF
     },
     { from  => 1284091200, # 2010-09-10 06:00 # PERIODISCH!
       until => 1284336000, # 2010-09-13 02:00
       text  => 'Breite Stra�e (Pankow): Veranstaltung, Stra�e vollst�ndig gesperrt (bis 13.09.10, 2 Uhr morgens) in beiden Richtungen zwischen M�hlenstr. und Berliner Str.',
       type  => 'handicap',
       source_id => 'IM_016308',
       data  => <<EOF,
userdel	q4::temp 10240,18193 10320,18197 10469,18262 10487,18270 10660,18345 10680,18380 10609,18384 10567,18366 10502,18338 10463,18321 10449,18315 10281,18241
EOF
     },
    { from  => 1346295600, # 2012-08-30 05:00 # PERIODISCH!
       until => 1346626800, # 2012-09-03 01:00
       text  => 'Turmstra�e (Moabit): Veranstaltung, Stra�e vollst�ndig gesperrt (31.08.2012 bis 02.09.2012) in beiden Richtungen zwischen Stromstr. und Waldstr.',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 5368,13406 5560,13382 5569,13381 5705,13359 5857,13342 5956,13330 6011,13330 6105,13328 6115,13328 6228,13324
EOF
     },
     { from  => 1284271200, # 2010-09-12 08:00
       until => 1286550000, # 2010-10-08 17:00
       text  => 'Dorfplatz (Bohnsdorf): Baustelle, Fahrtrichtung gesperrt Richtung A 117 zwischen Gr�nbergallee und Buntzelstr., 13.09.2010 08:00 Uhr bis 08.10.2010 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016334',
       data  => <<EOF,
userdel	q4::inwork; 20827,-537 20890,-546 20986,-529 21074,-475
EOF
     },
     { from  => 1284274800, # 2010-09-12 09:00
       until => 1285851600, # 2010-09-30 15:00
       text  => 'Neuer H�nower Weg (Dahlwitz-Hoppegarten): Baustelle, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen Industriestr. und Wiesenstr., 13.09.2010 09:00 Uhr bis 30.09.2010 15:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016338',
       data  => <<EOF,
userdel	q4::inwork 26880,11479 27272,11970
EOF
     },
     { from  => 1284361200, # 2010-09-13 09:00
       until => 1285945200, # 2010-10-01 17:00
       text  => 'K�penicker Str. (Biesdorf): Baustelle, f�r beide Richtungen nur ein Fahrstreifen abwechselnd frei, zwischen Tiergartenstr. und K�penicker Allee, 14.09.2010 09:00 Uhr bis 01.10.2010 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016343',
       data  => <<EOF,
userdel	q3::inwork 21027,7432 21032,7590 21037,7751
EOF
     },
     { from  => 1288905888, # 2010-11-04 22:24
       until => 1306620000, # 2011-05-29 00:00
       text  => 'Schenkenberg: L26: Bauarbeiten, Prenzlau - A 20 zw. AS Prenzlau-Ost und Abzweig Schenkenberg, 13.09.2010 bis 28.05.2011 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-E/09/214-7',
       data  => <<EOF,
userdel	2::inwork 46581,105900 47587,106693
EOF
     },
     { from  => 1284745737, # 2010-09-17 19:48
       until => 1338739578, # 1356994800, # 2013-01-01 00:00
       text  => 'Braunschweiger Str./Karl-Marx-Str.: Abbiegen nicht m�glich (bzw. nur auf dem Gehweg) bis 31.12.2012',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	3 13150,7254 13043,7234 13051,7157
userdel	3 13051,7157 13043,7234 13150,7254
userdel	3 13150,7254 13043,7234 13034,7319
userdel	3 13034,7319 13043,7234 13150,7254
EOF
     },
     { from  => 1284861600, # 2010-09-19 04:00
       until => 1286370000, # 2010-10-06 15:00
       text  => 'Friedrichstr. (Mitte): Baustelle, Fahrtrichtung Richtung Chausseestr. gesperrt zwischen Dorotheenstr. und Georgenstr., 20.09.2010 04:00 Uhr bis 06.10.2010 15:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016372',
       data  => <<EOF,
userdel	q4::inwork; 9330,12529 9314,12652
EOF
     },
     { from  => 1285014030, # 2010-09-20 22:20
       until => 1288562400, # 2010-10-31 23:00
       text  => 'Kremmen: B273: Abbruch der Br�cke bei Kremmen, 20.09.2010 bis 31.10.2010 01:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-E/10/086',
       data  => <<EOF,
userdel	2::inwork -17964,36290 -17262,37425
EOF
     },
     { from  => 1285020000, # 2010-09-21 00:00
       until => 1286402399, # 2010-10-06 23:59
       text  => 'Fahrbahnerneuerung im Zabel-Kr�ger-Damm zwischen Schluchseestra�e und Albtalweg, Einbahnstra�e Richtung Oraniendamm, vom 22. September 2010 bis zum 6. Oktober 2010 ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20100920.1135.311271.html',
       data  => <<EOF,
userdel	q4::inwork; 5006,22507 5142,22581 5260,22634 5368,22669
EOF
     },
     { from  => 1285855200, # 2010-09-30 16:00
       until => 1286164800, # 2010-10-04 06:00
       text  => 'Boxhagener Str. (Friedrichshain/Lichtenberg): Baustelle, Stra�e vollst�ndig gesperrt (bis vorauss. 04.10.2010 06:00) in beiden Richtungen zwischen Neue Bahnhofstr. und Kynaststr., 01.10.2010 16:00 Uhr bis 04.10.2010 06:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016440',
       data  => <<EOF,
userdel	q4::inwork 14918,11249 14988,11130
EOF
     },
     { from  => 1287036000, # 2010-10-14 08:00
       until => 1287064800, # 2010-10-14 16:00
       text  => 'Die Fahrbahn des Gro�-Glienicker-Wegs wird zwischen Buchwaldzeile und Kladower Damm erneuert, Vollsperrung am 14.10.2010 zwischen 8.00 und 16.00 Uhr ',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-spandau/presse/archiv/20100930.1500.312639.html',
       data  => <<EOF,
userdel	2::inwork -4578,8336 -4682,8292
EOF
     },
     { from  => 1266102000, # 2010-02-14 00:00
       until => 1286488800, # 2010-10-08 00:00
       text  => 'Br�cke �ber A10: Sperrung vom 15.02.2010 bis 08.10.2010 ',
       type  => 'gesperrt',
       source_id => 'http://www.stadtentwicklung.berlin.de/aktuell/pressebox/archiv_volltext.shtml?arch_1010/nachricht4072.html',
       data  => <<EOF,
	2:inwork 15347,24614 15490,24848
EOF
     },
     { from  => 1286661600, # 2010-10-10 00:00
       until => 1287784800, # 2010-10-23 00:00
       text  => 'Einbahnstra�enregelung in der Wasserwerkstr. vom 11.10.2010 bis zum 22.10.2010 zwischen Pfefferweg und Pionierstra�e.',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; -5806,16403 -5830,16356 -5849,16199
EOF
     },
     { from  => 1287957600, # 2010-10-25 00:00
       until => 1288998000, # 2010-11-06 00:00
       text  => 'Einbahnstra�enregelung in der Wasserwerkstr. zwischen Falkenseer Chaussee und Pfefferweg vom 25.10 bis 05.11.2010',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; -5849,16199 -5875,15994 -5911,15877
EOF
     },
     { from  => 1287315670, # 2010-10-17 13:41
       until => 1287957600, # 2010-10-25 00:00
       text  => 'Fahrbahnsanierung Paulsborner Stra�e zwischen Brandenburgische Stra�e und Westf�lische Stra�e, Vom 18.10.2010 bis 24.10.2010 ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-charlottenburg-wilmersdorf/presse/archiv/20101007.1035.313571.html',
       data  => <<EOF,
userdel	q4::inwork; 3431,9763 3467,9793 3587,9905 3620,9936 3706,10039 3747,10094 3852,10236
EOF
     },
     { from  => 1287892800, # 2010-10-24 06:00
       until => 1288368000, # 2010-10-29 18:00
       text  => 'Vollsperrung aufgrund von Stra�enbauma�nahmen im Staehleweg in Berlin-Reinickendorf vom 25.10.2010, 6.00 Uhr bis 29.10.2010, 18.00 Uhr ',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20101013.1345.314376.html',
       data  => <<EOF,
userdel	2::inwork 2061,27612 2345,27670
EOF
     },
     { from  => 1287295200, # 2010-10-17 08:00
       until => 1301317200, # 2011-03-28 15:00
       text  => 'Gr�nauer Str./Waltersdorfer Str. (Bohnsdorf bzw. Waltersdorf): Baustelle, Stra�e vollst�ndig gesperrt, in beiden Richtungen zwischen Waldstr. und Apfelweg (ob der Radweg betroffen ist, ist unbekannt), 18.10.2010 08:00 Uhr bis 28.03.2011 15:00 Uhr',
       type  => 'gesperrt',
       source_id => 'IM_016525',
       data  => <<EOF,
userdel	2::inwork 21687,-3601 21696,-2925 22003,-1625
EOF
     },
     { from  => 1288036570, # 2010-10-25 21:56
       until => 1288825199, # 2010-11-03 23:59
       text  => 'Der Steg Am Rohrbusch wird repariert Die Montage beginnt am Montag, dem 25.10.2010. Der Steg wird voraussichtlich am 3. November 2010 f�r die �ffentlichkeit wieder ge�ffnet.',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20101025.1235.315920.html',
       data  => <<EOF,
userdel	2::inwork 5534,24005 5596,23970
EOF
     },
     { from  => 1288479600, # 2010-10-31 01:00
       until => 1291157999, # 2010-11-30 23:59
       text  => 'Werneuchener Stra�e: zwischen Konrad-Wolf-Stra�e und Gro�e-Leege-Stra�e wird die Fahrbahn instand gesetzt. F�r den Zeitraum vom 1. bis 30. November wird die Werneuchener Stra�e zur Einbahnstra�e von der Konrad-Wolf-Stra�e aus in Richtung Gro�e-Leege-Stra�e.',
       type  => 'handicap',
       # XXX URL existiert nicht mehr: source_id => 'http://www.berlin.de/ba-lichtenberg/presse/archiv/20101028.1120.316439.html',
       data  => <<EOF,
userdel	q4::inwork; 16430,15168 16376,15209 16319,15229 16119,15302
EOF
     },
     { from  => 1288384501, # 2010-10-29 22:35
       until => 1291503600, # 2010-12-05 00:00
       text  => 'Kremmen: B273: Abbruch der Br�cke bei Kremmen, Kremmen - Staffelde, 20.09.2010 bis 04.12.2010 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-E/10/086',
       data  => <<EOF,
userdel	2::inwork -17114,37670 -17262,37425
EOF
     },
     { from  => 1288134000, # 2010-10-27 01:00
       until => 1292367600, # 2010-12-15 00:00
       text  => 'Sch�neiche bei Berlin: L302, L338: Gleis- und Stra�enbau (Knotenumbau L302/L338) OL Sch�neiche Knoten Rahnsdorfer Str. Vollsperrung, 28.10.2010 01:00 Uhr bis 14.12.2010 ',
       type  => 'handicap',
       source_id => '106701877',
       data  => <<EOF,
userdel	q4::inwork 30290,8562 30118,8128
EOF
     },
     { from  => 1288249200, # 2010-10-28 09:00
       until => 1301925600, # 2011-04-04 16:00
       text  => 'Niederkirchnerstr. (Mitte): Baustelle, Fahrtrichtung gesperrt in Richtung Wilhelmstr., 29.10.2010 bis 04.04.2011 ',
       type  => 'handicap',
       source_id => 'IM_016598',
       data  => <<EOF,
userdel	q4::inwork; 8720,11226 9155,11283
EOF
     },
     { from  => 1288238400, # 2010-10-28 06:00
       until => 1289577600, # 2010-11-12 17:00
       text  => 'Pankgrafenstra�e (Karow): Baustelle, f�r beide Richtungen nur ein Fahrstreifen abwechselnd frei, Regelung mit provisorischen Ampeln (bis ca. Mitte 11/2010) in beiden Richtungen H�he Bucher Str./Revierf�rsterei, 29.10.2010 06:00 Uhr bis 12.11.2010 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016591',
       data  => <<EOF,
userdel	q4::inwork 13220,23679 13953,23497
EOF
     },
     { from  => 1289257200, # 2010-11-09 00:00
       until => 1291503600, # 2010-12-05 00:00
       text  => 'Bauarbeiten in der Klemkestra�e zwischen Kopenhagener Stra�e und Emmentaler Stra�e vom 10.11.2010 bis 04.12.2010; Einbahnstra�e in Richtung Emmentaler Stra�e ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20101105.1400.317649.html',
       data  => <<EOF,
userdel	q4::inwork; 7855,18697 7785,18730 7676,18713 7599,18705 7520,18701 7492,18699 7434,18695 7217,18681
EOF
     },
     { from  => 1289156455, # 2010-11-07 20:00
       until => 1304200800, # 2011-05-01 00:00
       text  => 'Steinstra�e: F�r den Bau eines Schmutzwasserkanals ist die Steinstra�e zwischen Mendelssohn-Bartholdy-Stra�e und Bernhard-Beyer-Stra�e f�r den Kfz-Verkehr gesperrt. Die Arbeiten werden bis voraussichtlich April 2011 andauern.',
       type  => 'handicap',
       source_id => 'http://www.potsdam.de/cms/beitrag/10070344/966975/',
       data  => <<EOF,
userdel	q4::inwork -7750,-2431 -7909,-2375 -7996,-2293
EOF
     },
     { from  => 1289125260, # 2010-11-07 11:21
       until => 1290405600, # 2010-11-22 07:00
       text  => 'H�nower Stra�e (Mahlsdorf): Baustelle, Fahrtrichtung gesperrt Richtung H�now zwischen Fritz-Reuter-Str. und Linderhofstr., 08.11.2010 11:21 Uhr bis 22.11.2010 07:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016620',
       data  => <<EOF,
userdel	q4::inwork; 24556,12181 24530,12296
EOF
     },
     { from  => 1289373706, # 2010-11-10 08:21
       until => 1289602799, # 2010-11-12 23:59
       text  => 'Friedrichstr. (Mitte) in beiden Richtungen zwischen Unter den Linden und Behrenstr. Baustelle, Fahrbahn gesperrt, Fu�g�nger k�nnen passieren (bis vorauss. 12.11.2010 20:00) ',
       type  => 'handicap',
       source_id => 'INKO_104287',
       data  => <<EOF,
userdel	q4::inwork 9358,12351 9369,12253
EOF
     },
     { from  => 1289373786, # 2010-11-10 08:23
       until => 1289594954, # 2010-11-15 23:59 1289861999
       text  => 'Kastanienallee (Mitte) in beiden Richtungen H�he Zionskirchstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Mitte 11/2010) ',
       type  => 'handicap',
       source_id => 'INKO_103995',
       data  => <<EOF,
userdel	q4::inwork 10511,14418 10426,14262 10370,14158
EOF
     },
     { from  => 1289373844, # 2010-11-10 08:24
       until => 1290544815, # 2010-11-30 23:59 1291157999
       text  => 'L�ckstr. (Rummelsburg) Richtung N�ldnerplatz zwischen Emanuelstr. und Giselastr. Baustelle, Fahrtrichtung gesperrt (bis Ende 11.2010) ',
       type  => 'handicap',
       source_id => 'INKO_103947',
       data  => <<EOF,
userdel	q4::inwork; 16300,10753 16153,10818
EOF
     },
     { from  => 1289372400, # 2010-11-10 08:00
       until => 1289448000, # 2010-11-11 05:00
       text  => 'Strausberg: L34: Gleisbauarbeiten OL Strausberg, Bahn�bergang vom 10.11. 08:30 bis 11.11.10 05:00 Uhr ',
       type  => 'gesperrt',
       source_id => '106402691',
       data  => <<EOF,
userdel	2::inwork 43131,19792 43686,19241
EOF
     },
     { from  => 1289494800, # 2010-11-11 18:00
       until => 1289790000, # 2010-11-15 04:00
       text  => 'Teltower Damm (Zehlendorf) in beiden Richtungen zwischen Anhaltinerstr. und Machnower Str. Geplant ab: 12.11.2010 18 Uhr, Baustelle, Stra�e vollst�ndig gesperrt (Einbau einer Hilfsbr�cke) (bis vorauss. 15.11.2010 04:00)',
       type  => 'gesperrt',
       source_id => 'INKO_104132',
       data  => <<EOF,
userdel	2::inwork 749,2616 725,2702
EOF
     },
     { from  => 1289800800, # 2010-11-15 07:00
       until => 1290186000, # 2010-11-19 18:00
       text  => 'Ruhrstra�e zwischen Konstanzer Stra�e und Hohenzollerndamm wird ab Montag, dem 15.11. bis Freitag, dem 19.11.2010 instandgesetzt, Vollsperrung ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-charlottenburg-wilmersdorf/presse/archiv/20101111.1155.318374.html',
       data  => <<EOF,
userdel	q4::inwork 3983,9343 4230,9229
EOF
     },
     { from  => 1289775600, # 2010-11-15 00:00
       until => 1290293999, # 2010-11-20 23:59
       text  => 'Unterspreewald: B179: Br�ckenneubau Bauwerk 502 Br�cke �ber die alte Spree bei Leibsch ab 16.11.-20.11.10 Vollsperrung ',
       type  => 'gesperrt',
       source_id => 'LS/S-SG33-W/10/146',
       data  => <<EOF,
userdel	2::inwork 43875,-35850 44731,-35697
EOF
     },
     { from  => 1304373600, # 1290585600, #1290546446, # --- ausgesetzt 1290294000, # 2010-11-21 00:00
       until => 1305410400, # 1291654800, #1290546455, # --- ausgesetzt 1291503599, # 2010-12-04 23:59
       text  => 'Vollsperrung Falkentaler Steig in Berlin-Reinickendorf aufgrund von Stra�enbauma�nahmen in der Zeit von 3. bis 14. Mai 2011',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20110421.1005.341643.html',
#       source_id => 'IM_016682',
       data  => <<EOF,
userdel	q4::inwork 2492,24325 2708,24383
userdel	q4::inwork 3367,23654 3311,23677 3235,23781 3161,23888 3012,24107
EOF
     },
     { from  => 1290029417, # 2010-11-17 22:30
       until => 1293836400, # 2011-01-01 00:00
       text  => 'Bad Freienwalde (Oder): B167: Neubau Durchlass Br�cke �ber die Feldbahn bei Bad Freienwalde (H�he Recyclingzentrum), 17.11.2010 bis 31.12.2010',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-F/10/170',
       data  => <<EOF,
userdel	2::inwork 50799,43130 50169,43407
EOF
     },
     { from  => 1289892300, # 2010-11-16 08:25
       until => 1290780000, # 2010-11-26 15:00
       text  => 'Wasserwerkstr. (Spandau): Baustelle, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen Falkenseer Chaussee und Pionierstr., 17.11.2010 08:25 Uhr bis 26.11.2010 15:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016640',
       data  => <<EOF,
userdel	q4::inwork -5806,16403 -5830,16356 -5849,16199 -5875,15994 -5911,15877
EOF
     },
     { from  => 1301342279, # 2011-03-28 21:57
       until => 1302904800, # 2011-04-16 00:00
       text  => 'Wustermark: K6304: Stra�enneubau OD Priort, 15.11.2010 bis 15.04.2011 ',
       type  => 'handicap',
       source_id => '106300839',
       data  => <<EOF,
userdel	q4::inwork -19268,10819 -19323,11087 -19149,11495
EOF
     },
     { from  => 1290114000, # 2010-11-18 22:00
       until => 1290396600, # 2010-11-22 04:30
       text  => 'Oberspreestr. (K�penick): Baustelle, Stra�e vollst�ndig gesperrt, in beiden Richtungen zwischen Bruno-B�rgel-Weg und Moosstr., 19.11.2010 22:00 Uhr bis 22.11.2010 04:30 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_016647',
       data  => <<EOF,
userdel	2::inwork 19328,5304 19405,5284 19445,5271
EOF
     },
     { from  => 1290380400, # 2010-11-22 00:00
       until => 1291762800, # 2010-12-08 00:00
       text  => 'Bauarbeiten in der Donizettistra�e zwischen Mozart- und Schubertstra�e, 23.11.2010-7.12.2010',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 25161,12128 25286,12094
EOF
     },
     { from  => 1290803792, # 2010-11-26 21:36
       until => 1291014000, # 2010-11-29 08:00
       text  => 'Sachsendamm zwischen Gotenstr. und Priesterweg Richtung S-Bhf. Sch�neberg wegen Bauarbeiten gesperrt, 26. November 2010 abends bis 29. November 2010 fr�hmorgens',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-tempelhof-schoeneberg/presse/archiv/20101126.1415.320541.html',
       data  => <<EOF,
userdel	q4::inwork; 7480,7683
EOF
     },
     { from  => 1292184575, # 2010-12-12 21:09
       until => 1293357631, # 2010-12-31 23:59 1293836399
       text  => 'Hermann-Hesse-Str. (Pankow) Richtung Pastor-Niem�ller-Platz zwischen Tschaikowskistr.und Pastor-Niem�ller-Platz Baustelle, Fahrtrichtung gesperrt (bis Ende 12/2010) ',
       type  => 'gesperrt',
       source_id => 'INKO_104731',
       data  => <<EOF,
userdel	q4::inwork; 9501,18902 9681,19179 9811,19302
EOF
     },
     { from  => 1292184708, # 2010-12-12 21:11
       until => 1293145200, # 2010-12-24 00:00
       text  => 'Kremmen: B273: Abbruch der Br�cke bei Kremmen Kremmen - Staffelde, bis 23.12.2010',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-E/10/086',
       data  => <<EOF,
userdel	2::inwork -17114,37670 -17262,37425
EOF
     },
     { from  => 1292831040, # 2010-12-20 08:44
       until => 1293357689, # 2010-12-29 12:44 1293623040
       text  => 'K�penicker Allee (K�penick): Stra�ensch�den, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen K�penicker Str. und An der Wuhlheide, 21.12.2010 08:44 Uhr bis 29.12.2010 12:44 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016766',
       data  => <<EOF,
userdel	q4::inwork 21233,6096 20722,6971
EOF
     },
     { from  => 1254641760, # 2009-10-04 09:36
       until => 1338587292, # 1356969600, # 2012-12-31 17:00
       text  => 'Berliner Str. (Pankow): Baustelle, Fahrtrichtung gesperrt (bis Ende 12/2012) stadteinw�rts zwischen Breite Str. und Florastr. ',
       type  => 'handicap',
       source_id => 'IM_018078',
       data  => <<EOF,
#: next_check: 2012-05-15
userdel	q4::inwork; 10680,18380 10739,18262 10755,18231 10819,18066 10830,17985
EOF
     },
     { from  => 1295721886, # 2011-01-22 19:44
       until => 1304111420, # 2011-06-01 00:00 1306879200
       text  => 'Wandlitz: B273: Br�ckenneubau und Stra�enerneuerung OD Wandlitz, 21.04.2010 bis 31.05.2011 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-E/10/039',
       data  => <<EOF,
userdel	2::inwork 13546,37474 14470,37191
EOF
     },
     { from  => 1295721904, # 2011-01-22 19:45
       until => 1306879200, # 2011-06-01 00:00
       text  => 'Zernitz-Lohm: L141: Ersatzneubau einer Br�cke ; Vollsperrung mit �rtlicher Umfahrung bei Zernitz, Br�cke �ber die Neue J�glitz, 05.05.2010 bis 31.05.2011 ',
       type  => 'gesperrt',
       source_id => 'LS/W-SG33-K/10/053',
       data  => <<EOF,
userdel	2::inwork -60868,50275 -60612,50931
EOF
     },
     { from  => 1293530940, # 2010-12-28 11:09
       until => 1297722068, # 2011-02-28 15:09 1298902140
       text  => 'Stra�e Prenzlauer Berg (Prenzlauer Berg): gesperrt (geplatzte Wasserleitung) Richtung Friedrichshain zwischen Prenzlauer Allee und Greifswalder Str., 29.12.2010 11:09 Uhr bis 28.02.2011 15:09 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016795',
       data  => <<EOF,
userdel	q4::inwork; 11250,13655 11545,13690
EOF
     },
     { from  => 1294922580, # 2011-01-13 13:43
       until => 1296060180, # 2011-01-26 17:43
       text  => 'Stra�e nach Fichtenau (K�penick): Gefahrenstelle, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen Alter Fischerweg und F�rstenwalder Allee, 14.01.2011 13:43 Uhr bis 26.01.2011 17:43 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_016826',
       data  => <<EOF,
userdel	2::inwork 29898,5149 29832,5065 29705,4987 29712,4548
userdel	2::inwork 30041,5329 30074,5402
EOF
     },
     { from  => 1297201855, # 2011-02-08 22:50
       until => 1301608800, # 2011-04-01 00:00
       text  => 'Teupitz: L74: �berflutung der gesamten Fahrbahn zwischen Egsdorf und Teupitz der Verkehr wird einspurig �ber ein Provisorium gef�hrt, 18.01.2011 bis 31.03.2011 ',
       type  => 'handicap',
       source_id => 'LS/S-SG33-W/11/013',
       data  => <<EOF,
userdel	q4::inwork 23962,-30831 24550,-30862
EOF
     },
     { from  => 1296591853, # 2011-02-01 21:24
       until => 1300316399, # 2011-03-16 23:59
       text  => 'Dircksenstr., Rochstr., Rosa-Luxemburg-Str.: Behinderungen wegen Bauarbeiten und tempor�rer Einbahnstra�enregelung m�glich, 02. Februar bis 16. M�rz 2011 ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-mitte/aktuell/presse/archiv/20110201.1500.329349.html',
       data  => <<EOF,
userdel	q4::inwork 10755,13152 10706,13043 10595,13100 10635,13207
EOF
     },
     { from  => 1297067400, # 2011-02-07 09:30
       until => 1299918600, # 2011-03-12 09:30
       text  => 'Glinkastr. (Mitte): Baustelle, Fahrtrichtung gesperrt (bis Mitte 03/2011) Richtung Leipziger Str. zwischen Behrenstr. und Franz�sische Str., 08.02.2011 09:30 Uhr bis 12.03.2011 09:30 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016910',
       data  => <<EOF,
userdel	q4::inwork; 9164,12172 9183,12076
EOF
     },
     { from  => 1297067400, # 2011-02-07 09:30
       until => 1301752523, # 2011-12-31 17:00 XXX 1325347200
       text  => 'Behrenstr. (Mitte): Baustelle, Fahrtrichtung gesperrt (die Behrenstr. ist Richtung Glinkastr von Friedrichstr. kommend eine Sackgasse) Richtung Friedrichstr. im Kreuzungsbereich Glinkastr. (bis Ende 2011)',
       type  => 'handicap',
       source_id => 'IM_016911',
       data  => <<EOF,
userdel	q4::inwork 9373,12197 9164,12172
EOF
     },
     { from  => 1299034800, # 2011-03-02 04:00
       until => 1300143600, # 2011-03-15 00:00
       text  => 'Schulzendorf: K6161: Arbeiten am Bahn�bergang OL Eichwalde, 03.03.2011 04:00 Uhr bis 14.03.2011 ',
       type  => 'gesperrt',
       source_id => '116100155',
       data  => <<EOF,
userdel	2::inwork 25212,-4025 25269,-4041 25320,-4049
EOF
     },
     { from  => 1335462672, # 
       until => 1377985740, # 1356908400, # XXX
       text  => 'Auerbachtunnel: Fahrbahn wegen Bauarbeiten gesperrt, bis Sommer 2013',
       type  => 'handicap',
       source_id => 'IM_016416',
       data  => <<EOF,
#: by: http://www.berlin.de/ba-charlottenburg-wilmersdorf/presse/archiv/20110303.0840.333719.html
#: by: http://www.berlin.de/ba-charlottenburg-wilmersdorf/bvv-online/vo020.asp?VOLFDNR=4355&options=4 (Endedatum best�tigt)
#: next_check: 2013-08-31
#: last_checked: 2013-02-02
userdel	q4::inwork 425,8766 490,8716
EOF
     },
     { from  => 1299353825, # 2011-03-05 20:37
       until => 1321311600, # 2011-11-15 00:00
       text  => 'Leiblstra�e: F�r die Einrichtung einer Baustelle f�r den Bau von Wohnh�usern wird die Leiblstra�e bis voraussichtlich Mitte November von der Hans-Thoma-Stra�e in Richtung Hebbelstra�e als Einbahnstra�e ausgeschildert. ',
       type  => 'handicap',
       source_id => 'http://www.potsdam.de/cms/beitrag/10078717/1191938/',
       data  => <<EOF,
userdel	q4::inwork; -12545,-698 -12262,-612
EOF
     },
     { from  => 1299999600, # 2011-03-13 08:00
       until => 1305583200, # 2011-05-17 00:00
       text  => 'Bad Freienwalde (Oder): B167: Neubau Durchlass Br�cke �ber die Feldbahn bei Bad Freienwalde H�he Recyclingzentrum) Vollsperrung ab 14.03.11, 08:00 Uhr bis 16.05.2011 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-F/10/170',
       data  => <<EOF,
userdel	2::inwork 50799,43130 50169,43407
EOF
     },
     { from  => 1300575600, # 2011-03-20 00:00
       until => 1343685600, # 2012-07-31 00:00
       text  => 'Gusow-Platkow: B167: Grundhafter Ausbau einschlie�lich RW - Kanal Erneuerung Durchlass und Br�cke Ortslage Gusow halbseitige Sperrungen durch Suchschachtungen geplante Vollsperrung ab 21.03.11, 21.02.2011 bis 30.07.2012 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-F/11/022',
       data  => <<EOF,
userdel	2::inwork 74810,19707 74512,19946
EOF
     },
     { from  => 1299925522, # 2011-03-12 11:25
       until => 1304200800, # 2011-05-01 00:00
       text  => 'Rehfelde: L233, L232: Tief- und Gleisbauarbeiten OL Rehfelde, Bereich Bahn�bergang Parkstra�e/ Bahnhofstra�e/Friedrich-Engels-Str., 09.09.2010 bis 30.04.2011 ',
       type  => 'handicap',
       source_id => '106401892',
       data  => <<EOF,
userdel	q4::inwork 45732,14245 45537,13866
EOF
     },
     { from  => 1299925872, # 2011-03-12 11:31
       until => 1300229999, # 2011-03-15 23:59
       text  => 'Konrad-Wolf-Str. (Hohensch�nhausen) Richtung Suermondtstr. zwischen Wei�enseer Weg und Altenhofer Str. Baustelle, Fahrtrichtung gesperrt (bis Mitte 03/2011) ',
       type  => 'handicap',
       source_id => 'INKO_105791',
       data  => <<EOF,
userdel	q4::inwork; 15058,14575 15174,14638 15272,14691
EOF
     },
     { from  => 1299740460, # 2011-03-10 08:01
       until => 1300314164, # 2011-03-18 00:00 1300402800
       text  => 'Kopernikusstr. (Friedrichshain): Baustelle, Fahrtrichtung gesperrt Richtung Boxhagener Str. zwischen Libauer Str. und Simon-Dach-Str., 11.03.2011 08:01 Uhr bis 17.03.2011 ',
       type  => 'handicap',
       source_id => 'IM_017007',
       data  => <<EOF,
userdel	q4::inwork; 13895,11663 13954,11647
EOF
     },
     { from  => 1299992400, # 2011-03-13 06:00
       until => 1300467600, # 2011-03-18 18:00
       text  => 'K�nigs Wusterhausen: B179: Gleisbauarbeiten B� Zeesen, 14.03.2011 06:00 Uhr bis 18.03.2011 18:00 Uhr ',
       type  => 'gesperrt',
       source_id => '116100196',
       data  => <<EOF,
userdel	2::inwork 26758,-15727 26650,-15695
EOF
     },
     { from  => 1299564000, # 2011-03-08 07:00
       until => 1305482400, # 2011-05-15 20:00
       text  => 'Stargarder Str. (Prenzlauer Berg): Baustelle, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen Dunckerstr. und Senefelder Str., 09.03.2011 07:00 Uhr bis 15.05.2011 20:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_017000',
       data  => <<EOF,
userdel	q4::inwork 11595,15460 11688,15398
EOF
     },
     { from  => 1299413700, # 2011-03-06 13:15
       until => 1300734000, # 2011-03-21 20:00
       text  => 'Stra�e Prenzlauer Berg (Prenzlauer Berg): Tiefbauarbeiten, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen Prenzlauer Allee und Greifswalder Str., 07.03.2011 13:15 Uhr bis 21.03.2011 20:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016995',
       data  => <<EOF,
userdel	q4::inwork 11545,13690 11250,13655
EOF
     },
     { from  => 1301342328, # 2011-03-28 21:58
       until => 1325372400, # 2012-01-01 00:00
       text  => 'Bad Wilsnack: L11: Ersatzneubau der Br�cke �ber die Karthane OD Bad Wilsnack, 28.03.2011 bis 31.12.2011 ',
       type  => 'gesperrt',
       source_id => 'LS/W-SG33-K/11/033',
       data  => <<EOF,
userdel	2::inwork -89568,59293 -91452,59580
EOF
     },
     { from  => 1301342447, # 2011-03-28 22:00
       until => 1301608799, # 2011-03-31 23:59
       text  => 'Hermann-Hesse-Str. (Pankow) Richtung Dietzgenstr. zwischen Tschaikowskistr. und Pastor-Niem�ller-Platz Baustelle, Fahrtrichtung gesperrt (bis Ende 03.2011) ',
       type  => 'handicap',
       source_id => 'INKO_105988',
       data  => <<EOF,
userdel	q4::inwork; 9501,18902 9681,19179 9811,19302
EOF
     },
     { from  => 1300611480, # 2011-03-20 09:58
       until => 1301497200, # 2011-03-30 17:00
       text  => 'Hermsdorfer Str. (Wittenau): geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen Alt-Wittenau und Cyclopstr., 21.03.2011 09:58 Uhr bis 30.03.2011 17:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_017035',
       data  => <<EOF,
userdel	2::inwork 4775,21522 4772,21389
EOF
     },
     { from  => 1301342612, # 2011-03-28 22:03
       until => 1302904799, # 2011-04-15 23:59
       text  => 'Rennbahnstr. (Wei�ensee) Richtung Heinersdorf zwischen Pasedagplatz und Roelckestr. Baustelle, Fahrtrichtung gesperrt (bis Mitte 04/11) ',
       type  => 'handicap',
       source_id => 'INKO_105693',
       data  => <<EOF,
userdel	q4::inwork; 14144,17165 14099,17195 14060,17221 13912,17320
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Albrecht-Thaer-Weg: Privatstra�e, eventuell zeitweise gesperrt (nachts?)',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
Albrecht-Thaer-Weg: Privatstra�e, evtl. nicht ge�ffnet	2::night 3347,6460 3449,6863
EOF
     },
     { from  => 1280051220, # 2010-07-25 11:47
       until => 1308938946, # 2011-07-30 16:00 1312034400
       text  => 'General-Pape-Stra�e (Tempelhof): Baustelle, Fahrtichtung gesperrt (bis ca. 07/2011) Richtung Kolonnenstr. zwischen Werner-Vo�-Str. und Loewenhardtdamm, 26.07.2010 11:47 Uhr bis 30.07.2011 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016132',
       data  => <<EOF,
userdel	q4::inwork; 7949,7607 7943,7708 7951,7801 7955,7840 8088,8254 8100,8288 8215,8631 8237,8685 8306,8722
EOF
     },
     { from  => 1302411000, # 2011-04-10 06:50
       until => 1311976800, # 2011-07-30 00:00
       text  => 'Kastanienallee (Prenzlauer Berg): Baustelle, Fahrtrichtung gesperrt (bis Ende 07/2011) Richtung Fehrbelliner Str. zwischen Sch�nhauser Allee und Oderberger Str., 11.04.2011 06:50 Uhr bis 29.07.2011 ',
       type  => 'handicap',
       source_id => 'IM_017117',
       data  => <<EOF,
userdel	q4::inwork; 10881,15047 10838,14962 10723,14772
EOF
     },
     { from  => 1318630793, # 2011-10-15 00:19
       until => 1321311600, # 2011-11-15 00:00
       text  => 'Schenkenberg: L26: grundhafter Ausbau der L 26 Prenzlau - A20, 02.05.2011 bis 14.11.2011',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-E/10/214-10',
       data  => <<EOF,
userdel	2::inwork 45393,105220 45906,105450 46581,105900 47587,106693
EOF
     },
     { from  => 1302991200, # 2011-04-17 00:00
       until => 1305928800, # 2011-05-21 00:00
       text  => 'Zichow: L280, B166: Deckenerneuerung Zichow - Passow ab 18.04.11 Abzw. Zichow gesperrt, 22.11.2010 bis 20.05.2011 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-E/10/124.5',
       data  => <<EOF,
userdel	2::inwork 52733,87022 52642,86984
EOF
     },
     { from  => 1304110785, # 2011-04-29 22:59
       until => 1309471200, # 2011-07-01 00:00
       text  => 'Rehfelde: K6419: Stra�enausbau OL Rehfelde, zw. Bahnhofstra�e und Kreisverkehr gesperrt, bis 30.06.2011 ',
       type  => 'handicap',
       source_id => '106401098',
       data  => <<EOF,
userdel	q4::inwork; 45856,14437 44121,14615
EOF
     },
     { from  => 1304111111, # 2011-04-29 23:05
       until => 1304294400, # 2011-05-02 02:00
       text  => 'Stra�e des 17. Juni (Tiergarten) in beiden Richtungen zwischen Y.-Rabin-Str. und Brandenburger Tor; auch Ebertstr. zwischen Scheidemannstr. und Behrenstr., Veranstaltung, Stra�e vollst�ndig gesperrt (30.04.2011 12 Uhr bis 02.05.11 ca. 02:00 Uhr) ',
       type  => 'gesperrt',
       source_id => 'IM_017171',
       data  => <<EOF,
userdel	2::temp 8610,12254 8538,12245 8303,12216 8214,12205 8089,12190 8055,12186
userdel	2::temp 8540,12420 8573,12325 8570,12302 8546,12279 8538,12245 8600,12165 8595,12066
EOF
     },
     { from  => 1304481600, # 2011-05-04 06:00
       until => 1304870400, # 2011-05-08 18:00
       text  => 'Bauvorhaben Umbau Wendenschlo�stra�e von M�ggelheimer Stra�e bis Salvador-Allende-Stra�e, Vollsperrung vom 05.05.11 6.00 Uhr bis 08.05.11 18.00 Uhr ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-treptow-koepenick/presse/archiv/20110421.1205.341677.html',
       data  => <<EOF,
userdel	q4::inwork 22740,4415 22759,4430 22791,4457 22832,4491 22862,4511 22893,4532 22959,4576 23055,4640 23363,4846 23451,4877
EOF
     },
     { from  => 1304676000, # 2011-05-06 12:00
       until => 1304798400, # 2011-05-07 22:00
       text  => 'Blankenfelde-Mahlow: L792: Traditionelles Dorfangerfest - Fest der Vereine OL Blankenfelde Umleitung: innerorts, 07.05.2011 12:00 Uhr bis 07.05.2011 22:00 Uhr ',
       type  => 'gesperrt',
       source_id => '117200018',
       data  => <<EOF,
userdel	2::temp 9990,-8867 10115,-8276
EOF
     },
     { from  => 1315519200, # 2011-09-09 00:00 # PERIODISCH!
       until => 1315778399, # 2011-09-11 23:59
       text  => 'Seifenkistenrennen auf dem Kaiserdamm zwischen Theodor-Heuss-Platz und K�nigin-Elisabeth-Stra�e, 10./11.09.2011',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::temp 1574,11379 1625,11380 1834,11408 1960,11426 2109,11441
EOF
     },
     { from  => $isodate2epoch->("2013-07-06 10:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-07-07 21:00:00"),
       periodic => 1, # zweiter Termin im Sommer
       text  => 'Open Air Gallery am 7. Juli 2013 auf der Oberbaumbr�cke (10:00 - 21:00)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	q4::temp 13178,10623 13206,10651 13305,10789 13332,10832
EOF
     },
     { from  => $isodate2epoch->("2013-04-25 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-05-20 00:00:00"),
       periodic => 1,
       text  => 'Neuk�llner Maientage im Volkspark Hasenheide, Behinderungen m�glich, 26.04.2013 bis 20.05.2013',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 11182,8983 11255,8591 11279,8489 11282,8428 11275,8387 11266,8336
userdel	q4::temp 11225,8350 11230,8402 11235,8454 11193,8568 11137,8738
userdel	q4::temp 11275,8387 11230,8402
userdel	q4::temp 11333,8582 11255,8591 11193,8568 11133,8560
EOF
     },
     { from  => 1338760800, # 2012-06-04 00:00
       until => 1339106399, # 2012-06-07 23:59
       text  => 'Flieth-Stegelitz: L24: Br�cke �ber den Stierngraben bei Kaakstedt, geplante Vollsperrung 05.06. - 07.06.12 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-E/11/044',
       data  => <<EOF,
userdel	2::inwork 35887,85385 34920,85944
EOF
     },
     { from  => 1304796386, # 2011-05-07 21:26
       until => 1317420000, # 2011-10-01 00:00
       text  => 'Bad Freienwalde (Oder): B167: Stra�enbau- und Kanalarbeiten Ortsdurchfahrt Bad Freienwalde, Eberswalder Stra�e Beginn Vollsperrung geplant, 09.05.2011 bis 30.09.2011 ',
       type  => 'handicap',
       source_id => 'LS/O-SG33-F/11/070',
       data  => <<EOF,
userdel	q4::inwork 52119,43318 50799,43130
EOF
     },
     { from  => 1305435600, # 2011-05-15 07:00
       until => 1338476400, # 2012-05-31 17:00
       text  => 'Schadowstr. (Mitte): Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 05/12) in beiden Richtungen zwischen Unter den Linden und Dorotheenstr., 16.05.2011 07:00 Uhr bis 31.05.2012 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_093372',
       data  => <<EOF,
#: last_checked: 2012-04-28
userdel	q4::inwork 9028,12307 9016,12416 9008,12485
EOF
     },
     { from  => 1305746527, # 2011-05-18 21:22
       until => 1305928799, # 2011-05-20 23:59
       text  => 'Einschr�nkungen im Tempelhofer Park wegen der Michelin Challenge Bibendum: Vom 18. - 20. Mai 2011 wird der n�rdliche Bereich der Tempelhofer Freiheit inklusive des Biergartens tags�ber bis 19.00 Uhr nicht zug�nglich sein. Die Eing�nge am Columbiadamm sind erst ab 19.00 Uhr ge�ffnet.',
       type  => 'gesperrt',
       data  => <<EOF,
#: by: http://www.tempelhoferfreiheit.de/ueber-die-tempelhofer-freiheit/aktuelles/die-challenge-bibendum-startet/
#: by: http://www.tempelhoferfreiheit.de/fileadmin/user_upload/Ueber_die_Tempelhofer_Freiheit/Aktuelles/Plan_ChallengeBibendum2011-THF.jpg
userdel	2::temp 11355,7871 11388,7777 11279,7768 10204,7680 9653,7635 9522,7624 9562,7796 9619,7930 9709,8127 9784,8209 9884,8265 10037,8269 10298,8245 10360,8521 10644,8363 10803,8251 11005,8064 10909,8003
userdel	2::temp 9362,7616 9522,7624 9525,7558
userdel	2::temp 10360,8521 10384,8628
userdel	2::temp 10575,8218 10729,8152 10598,8270 10575,8218 10298,8245
userdel	2::temp 10729,8152 10909,8003 11090,7916 11264,7882
userdel	2::temp 10598,8270 10644,8363 10691,8532
EOF
     },
     { from  => 1305840528, # 2011-05-19 23:28
       until => 1306879199, # 2011-05-31 23:59
       text  => 'H�nower Str. (Mahlsdorf) Richtung H�now zwischen Fritz-Reuter-Str. und Ridbacher Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 05/11) ',
       type  => 'handicap',
       source_id => 'INKO_107373',
       data  => <<EOF,
userdel	q4::inwork; 24554,12100 24556,12181 24530,12296
EOF
     },
     { from  => 1301202000, # 2011-03-27 07:00
       until => 1309190400, # 2011-06-27 18:00
       text  => 'Lahnstr. (Neuk�lln): Baustelle, Fahrtrichtung gesperrt (bis Ende 06/11) Richtung Grenzallee zwischen Karl-Marx-Str. und Naumburger Str., 28.03.2011 07:00 Uhr bis 27.06.2011 18:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_105491',
       data  => <<EOF,
userdel	q4::inwork; 13085,6925 13278,6967
EOF
     },
     { from  => 1305840997, # 2011-05-19 23:36
       until => 1306101600, # 2011-05-23 00:00
       text  => 'Str. des 17. Juni (Tiergarten) in beiden Richtungen zwischen Y.-Rabin-Str. und Brandenburger Tor, auch Ebertstr. zwischen Behrenstr. und Dorotheenstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 22.05.2011 ca. 24:00 Uhr) ',
       type  => 'gesperrt',
       source_id => 'IM_017297',
       data  => <<EOF,
userdel	2::temp 8055,12186 8089,12190 8214,12205 8303,12216 8538,12245 8610,12254
userdel	2::temp 8540,12420 8573,12325 8570,12302 8546,12279 8538,12245 8600,12165 8595,12066
userdel	2::temp 8542,11502 8548,11571
EOF
     },
     { from  => 1306040400, # 2011-05-22 07:00
       until => 1307718000, # 2011-06-10 17:00
       text  => 'Puschkinallee (Treptow): Baustelle, Stra�e vollst�ndig gesperrt zwischen Bulgarische Str. und Elsenstr., 23.05.2011 07:00 Uhr bis 10.06.2011 17:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_017318',
       data  => <<EOF,
#: by: http://www.berlin.de/ba-treptow-koepenick/presse/archiv/20110530.1300.346009.html
userdel	2::inwork 15383,9191 14883,9431 14819,9462 14780,9480 14310,9692
EOF
     },
     { from  => undef, # 
       until => 1314041104, # XXX
       text  => 'Fuldastr., von Donaustr. Richtung Karl-Marx-Str. ist die Fahrbahn gesperrt',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 12549,8616 12500,8504
EOF
     },
     { from  => undef, # 
       until => 1306436321, # 1306447199, # 2011-05-26 23:59
       text  => 'Oberbaumbruecke wegen Bombenfunds gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 13332,10832 13305,10789 13206,10651 13178,10623 13082,10634
userdel	2::temp 13249,10445 13142,10530
userdel	2::temp 13409,11004 13332,10832 13389,10808
userdel	2::temp 13332,10832 13144,10921
userdel	2::temp 13077,10747 13206,10651
userdel	2::temp 12985,10665 12879,10750 12951,10839 13077,10747 13015,10659 13082,10634 13028,10629 13136,10535 13178,10623
EOF
     },
     { from  => 1308262849, # undef
       until => 1308262854, # undef, # XXX --- ist mittlerweile unproblematisch (2011-05-15)
       text  => 'Friedrichsbr�cke: Bauarbeiten, Fahrrad muss geschoben werden, mit Anhaenger kommt man nicht durch',
       type  => 'handicap',
       data  => <<EOF,
#: by: wosch
userdel	q4::inwork 10086,12725 10166,12777
EOF
     },
     { from  => 1331065556, # 
       until => 1331065559, # XXX -> jetzt in handicap_s
       text  => 'Burgstra�e: Bauarbeiten, Einbahnstra�enregelung',
       type  => 'handicap',
       data  => <<EOF,
#: by: wosch
#: confirmed_by: srt
#: last_checked: 2012-01-22
#: note: eigentlich Radfahren auf der Friedrichsbr�cke jetzt auch verboten
userdel	q4::inwork; 10166,12777 10132,12941
EOF
     },
     { from  => 1307219374, # 2011-06-04 22:29
       until => 1318888800, # 2011-10-18 00:00
       text  => 'L314: Stra�enbau, Ausbau der Bernauer Stra�e 3. BA Ortsdurchfahrt Zepernick 1. VSA zw. Neckarstr. und H�ndelstr., 22.03.2011 bis 17.10.2011 ',
       type  => 'handicap',
       source_id => 'LS/O-SG33-E/11/027',
       data  => <<EOF,
userdel	q4::inwork 19595,27953 20114,28315 20362,28420
EOF
     },
     { from  => 1307174400, # 2011-06-04 10:00
       until => 1307652701, # XXX -> handicap_s-orig 2013-05-31 20:00 1370023200
       text  => 'Invalidenstr. (Mitte): Baustelle, Fahrtrichtung gesperrt (bis 05/13) Richtung Alt-Moabit zwischen Gartenstr. und Hessische Str., 05.06.2011 10:00 Uhr bis 31.05.2013 20:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_017330',
       data  => <<EOF,
userdel	q4::inwork; 9383,13978 9274,13963 9203,13953 9151,13941 9085,13919 8935,13844 8690,13723
EOF
     },
     { from  => 1308261600, # 2011-06-17 00:00
       until => 1308520800, # 2011-06-20 00:00
       text  => 'J�mlitz-Klein D�ben: B115, B112: Deckenerneuerung Simmersdorf - AS Forst geplante Vollsperrung: 17.06.11-19.06.11',
       type  => 'gesperrt',
       source_id => 'LS/S-SG33-C/11/084',
       data  => <<EOF,
userdel	2::inwork 97780,-91551 97468,-91292
EOF
     },
     { from  => 1299564000, # 2011-03-08 07:00
       until => 1337887761, # XXX? 1349114400, # 2012-10-01 20:00
       text  => 'Stargarder Str. (Prenzlauer Berg): Baustelle, Fahrtrichtung gesperrt Richtung Sch�nhauser Allee zwischen Dunckerstr. und Schliemannstr., 09.03.2011 bis 01.10.2012 ',
       type  => 'handicap',
       source_id => 'IM_017000',
       data  => <<EOF,
userdel	q4::inwork; 11595,15460 11502,15527
EOF
     },
     { from  => 1307250000, # 2011-06-05 07:00
       until => 1341068400, # 2012-06-30 17:00
       text  => 'Dorotheenstr. (Mitte): Baustelle, Fahrtrichtung gesperrt Richtung Friedrichstr. zwischen Wilhelmstr. und Schadowstr., 06.06.2011 07:00 Uhr bis 30.06.2012 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_093371',
       data  => <<EOF,
#: last_checked: 2012-04-20
userdel	q4::inwork; 8775,12457 8907,12472 9008,12485
EOF
     },
     { from  => 1307600160, # 2011-06-09 08:16
       until => 1307969127, # 2011-06-24 12:16 1308910560
       text  => 'Seidelstr. (Reinickendorf): St�rungen durch geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt In beiden Richtungen zwischen Otisstr. und Holzhauser Str., 10.06.2011 08:16 Uhr bis 24.06.2011 12:16 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_017428',
       data  => <<EOF,
userdel	2::inwork 3008,18464 2947,18570 2867,18736 2821,18831
EOF
     },
     { from  => 1308456000, # 2011-06-19 06:00
       until => 1308981600, # 2011-06-25 08:00
       text  => 'L�bben (Spreewald): B115: Gleisbauarbeiten OL L�bben, Bahn�bergang, 20.06.2011 06:00 Uhr bis 25.06.2011 08:00 Uhr',
       type  => 'gesperrt',
       source_id => '116100612',
       data  => <<EOF,
userdel	2::inwork 40079,-50702 43031,-50423 43540,-50369
EOF
     },
     { from  => 1308520800, # 2011-06-20 00:00
       until => 1308693599, # 2011-06-21 23:59
       text  => 'L�wenberger Land: B96: Fahrbahninstandsetzung OA Teschendorf - Nassenheide, Vollsperrung am 21.06.11 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-E/11/063',
       data  => <<EOF,
userdel	2::inwork -4587,48481 -4284,47803
EOF
     },
     { from  => 1309039200, # 2011-06-26 00:00
       until => 1309211999, # 2011-06-27 23:59
       text  => 'Neuenhagen bei Berlin: L338: Kranaufstellung, Aufstellen Betonpumpe OL Neuenhagen, Sch�neicher Str. Nr. 50 am 27.06.11 Vollsperrung ',
       type  => 'gesperrt',
       source_id => '116400693',
       data  => <<EOF,
userdel	2::inwork 30971,11749 31021,12174
EOF
     },
     { from  => 1320439456, # 2011-11-04 21:44
       until => 1323990000, # 2011-12-16 00:00
       text  => 'Neuhausen/Spree: L48: Br�ckenneubau Br�cke �ber das Flie� bei Gablenz, 19.04.2011 bis 15.12.2011 ',
       type  => 'gesperrt',
       source_id => 'LS/S-SG33-C/11/067',
       data  => <<EOF,
userdel	2::inwork 85633,-77062 87212,-78642
EOF
     },
     { from  => 1308805200, # 2011-06-23 07:00
       until => 1310742000, # 2011-07-15 17:00
       text  => 'Granitzstr. (Pankow): Baustelle, f�r beide Richtungen nur ein Fahrstreifen abwechselnd frei (bis Mitte 07/11) in beiden Richtungen zwischen Ha�furter Weg und Dettelbacher Weg, 24.06.2011 07:00 Uhr bis 15.07.2011 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_107899',
       data  => <<EOF,
userdel	q4::inwork 11796,18482 11698,18446
EOF
     },
     { from  => 1308592800, # 2011-06-20 20:00
       until => 1308974400, # 2011-06-25 06:00
       text  => 'John-Foster-Dulles-Allee (Tiergarten): Sportveranstaltung, Stra�e vollst�ndig gesperrt (bis 25.06., 06:00) in beiden Richtungen, 21.06.2011 20:00 Uhr bis 25.06.2011 06:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_017472',
       data  => <<EOF,
userdel	q4::temp 7215,12295 7437,12368
userdel	q4::temp 7875,12363 7821,12367 7627,12380 7514,12387
EOF
     },
     { from  => 1308466800, # 2011-06-19 09:00
       until => 1311343200, # 2011-07-22 16:00
       text  => 'Stargarder Str. (Prenzlauer Berg): Baustelle, Fahrtrichtung gesperrt (bis Ende 07/11) Richtung Prenzlauer Allee zwischen Sch�nhauser Allee und Pappelallee, 20.06.2011 09:00 Uhr bis 22.07.2011 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_017476',
       data  => <<EOF,
userdel	q4::inwork; 10953,15787 11086,15772 11158,15739 11301,15668
EOF
     },
     { from  => 1308974400, # 2011-06-25 06:00
       until => 1309104000, # 2011-06-26 18:00
       text  => 'S�dostallee (Treptow) in beiden Richtungen zwischen Kiefholzstr. und Baumschulenstr., Veranstaltung, Stra�e vollst�ndig gesperrt (26.06.2011 06 Uhr bis 18:00 Uhr)',
       type  => 'handicap',
       source_id => 'IM_017504',
       data  => <<EOF,
userdel	q4::temp 16049,6121 16122,6084 16510,5917 16868,5938
EOF
     },
     { from  => 1308988800, # 2011-06-25 10:00
       until => 1309093200, # 2011-06-26 15:00
       text  => 'Unter den Linden (Mitte) in beiden Richtungen zwischen Friedrichstr. und Oberwallstr./Hinter dem Gie�haus, Veranstaltung, Stra�e vollst�ndig gesperrt (26.06.2011 10:00 bis 15:00) ',
       type  => 'gesperrt',
       source_id => 'IM_017503',
       data  => <<EOF,
userdel	2::temp 9852,12409 9780,12401 9771,12400 9734,12395 9695,12390 9656,12386 9601,12380 9475,12365 9358,12351
EOF
     },
     { from  => 1311883200, # 2011-07-28 22:00
       until => 1312164000, # 2011-08-01 04:00
       text  => 'Sperrung des Bahn�berganges in der Lemkestra�e: 29.07.2011 22:00 Uhr bis 01.08.2011 04:00 Uhr',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-marzahn-hellersdorf/aktuelles/presse/archiv/20110623.1015.348936.html',
       data  => <<EOF,
userdel	2::inwork 25149,12266 25109,12196 25072,12107
EOF
     },
     { from  => 1314302400, # 2011-08-25 22:00
       until => 1314583200, # 2011-08-29 04:00
       text  => 'Sperrung des Bahn�berganges in der Lemkestra�e: 26.08.2011 22:00 Uhr bis 29.08.2011 04:00 Uhr',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-marzahn-hellersdorf/aktuelles/presse/archiv/20110623.1015.348936.html',
       data  => <<EOF,
userdel	2::inwork 25149,12266 25109,12196 25072,12107
EOF
     },
     { from  => 1314907200, # 2011-09-01 22:00
       until => 1315188000, # 2011-09-05 04:00
       text  => 'Sperrung des Bahn�berganges in der Lemkestra�e: 02.09.2011 22:00 Uhr bis 05.09.2011 04:00 Uhr',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-marzahn-hellersdorf/aktuelles/presse/archiv/20110623.1015.348936.html',
       data  => <<EOF,
userdel	2::inwork 25149,12266 25109,12196 25072,12107
EOF
     },
     { from  => 1309060800, # 2011-06-26 06:00
       until => 1309532400, # 2011-07-01 17:00
       text  => 'Kiefholzstr. (Treptow): Baustelle, Stra�e vollst�ndig gesperrt (bis Anfang 07/11) in beiden Richtungen zwischen Dammweg und Eichbuschallee, 27.06.2011 06:00 Uhr bis 01.07.2011 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_108107',
       data  => <<EOF,
userdel	q4::inwork 15557,7404 15221,7778
EOF
     },
     { from  => 1309644000, # 2011-07-03 00:00
       until => 1325372400, # 2012-01-01 00:00
       text  => 'Rabenstein/Fl�ming: L84, K6932: Stra�enbau OD R�digke LSA-Regelung, Abzw. Buchholz gesperrt ab 04.07.11 Vollsperrung, 27.06.2011 bis 31.12.2011 ',
       type  => 'gesperrt',
       source_id => 'LS/W-SG33-P/11/484',
       data  => <<EOF,
userdel	2::inwork -41811,-40216 -41351,-39981
EOF
     },
     { from  => 1307948160, # 2011-06-13 08:56
       until => 1310216400, # 1310130000, # 2011-07-08 15:00
       text  => 'Puschkinallee (Treptow): Baumpflegearbeiten, Stra�e gesperrt zwischen Elsenstr. und Eichenstr., sowie Einbahnstra�enregelung in der Martin-Hoffmann-Str., 14.06.2011 08:56 Uhr bis 09.07.2011 15:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_017436',
       data  => <<EOF,
userdel	2::inwork 13829,9905 13884,9882 13995,9834 14193,9746
	q4::inwork; 13835,10083 13928,10053 14012,10029 14076,10011 14289,9870
EOF
     },
     { from  => 1309644000, # 2011-07-03 00:00
       until => 1311199200, # 2011-07-21 00:00 # until => 1310853599, # 2011-07-16 23:59
       text  => 'Kleinmachnow: L77: Instandsetzungsarbeiten OL Kleinmachnow , Friedensbr�cke 04.07.-20.07.2011 Vollsperrung ',
       type  => 'gesperrt',
       source_id => 'LS/W-SG33-P/11/412',
       data  => <<EOF,
userdel	2::inwork -1378,-1022 -1348,-1098
EOF
     },
     { from  => 1309928959, # 2011-07-06 07:09
       until => 1310040000, # 2011-07-07 14:00
       text  => 'Bombenfund am Bahnhof K�penick',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 22365,6149 22467,6135 22539,6258
userdel	2::inwork 22358,5918 22428,6063 22467,6135 22603,6141
userdel	2::inwork 22478,6041 22544,6037
userdel	2::inwork 22324,6397 22365,6149 22283,6174
userdel	2::inwork 22513,5747 22531,5871 22358,5918 22294,5777
userdel	2::inwork 22777,6151 22603,6141
userdel	2::inwork 22608,5732 22631,5866 22531,5871 22539,5956 22730,5944
userdel	2::inwork 22639,6062 22544,6037 22539,5956
EOF
     },
     { from  => 1309903200, # 2011-07-06 00:00
       until => 1310075999, # 2011-07-07 23:59
       text  => 'Markgrafenstr. (Mitte) in beiden Richtungen zwischen Franz�sische Str. und Mohrenstr. ab 07.07.2011 17 Uhr, Veranstaltung, Stra�e vollst�ndig gesperrt ',
       type  => 'gesperrt',
       source_id => 'IM_017545',
       data  => <<EOF,
userdel	2::temp 9643,12127 9656,12021 9668,11928 9679,11834
EOF
     },
     { from  => 1310016128, # 2011-07-07 07:22
       until => 1310767200, # 2011-07-16 00:00
       text  => 'Markgrafenstr. (Mitte): Veranstaltung, Stra�e vollst�ndig gesperrt (bis 15.07., 18:00) in beiden Richtungen zwischen J�gerstr. und Taubenstr., 03.07.2011 bis 15.07.2011 18:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_017544',
       data  => <<EOF,
userdel	2::temp 9656,12021 9668,11928
EOF
     },
     { from  => 1358139600, # 2013-01-14 06:00
       until => 1358445600, # 2013-01-17 19:00
       text  => 'Platz der Luftbr�cke (Tempelhof): Veranstaltung, Stra�e vollst�ndig zwischen Tempelhofer Damm und Columbiadamm gesperrt (bis Donnerstag)',
       type  => 'gesperrt',
       source_id => 'IM_019522',
       data  => <<EOF,
userdel	q4::temp 9233,8597 9321,8607 9364,8640 9395,8726
userdel	q4::temp 9321,8607 9401,8510 9451,8548 9364,8640
EOF
     },
     { from  => undef, # 
       until => 1317938400, # 2011-10-07 00:00
       text  => 'D�rpfeldstr.: Bauarbeiten, Fahrbahn gesperrt',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 19904,3464 20012,3532
EOF
     },
     { from  => 1310014800, # 2011-07-07 07:00
       until => 1314806400, # 2011-08-31 18:00
       text  => 'Geschwister-Scholl-Str./Tucholskystr. (Mitte): Bauarbeiten, Br�cke vollst�ndig gesperrt (bis Ende 08/11) in beiden Richtungen H�he Ebertsbr�cke, 08.07.2011 07:00 Uhr bis 31.08.2011 18:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'INKO_096636',
       data  => <<EOF,
userdel	2::inwork 9534,12953 9533,12925
EOF
     },
     { from  => 1310335200, # 2011-07-11 00:00
       until => 1314395999, # 2011-08-26 23:59
       text  => 'Instandsetzung des Stegs zwischen Nackthals- und Seidenhuhnweg, u.U. Vollsperrung, ab 12. Juli 2011 f�r ca. 10 Wochen',
       type  => 'gesperrt',
       source_id => 'http://www.stadtentwicklung.berlin.de/aktuell/pressebox/archiv_volltext.shtml?arch_1107/nachricht4413.html',
       data  => <<EOF,
#: XXX bis Sommer 2012 werden noch weitere Br�cken am Rudower Flie� instandgesetzt
userdel	2::inwork 16135,473 16148,458 16130,420 16122,403
userdel	2::inwork 16148,458 16169,458
EOF
     },
     { from  => undef, # 
       until => 1313791199, # 2011-08-19 23:59
       text  => 'Fahrbahn am �stlichen Herthaplatz wird ausgebaut, bis Mitte August 2011',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-pankow/presse/archiv/20110712.1215.351002.html',
       data  => <<EOF,
userdel	q4::inwork 10599,19957 10614,19907
EOF
     },
     { from  => 1310504724, # 2011-07-12 23:05
       until => 1324668762, # XXX 1342389599, # 2012-07-15 23:59
       text  => 'Neubau der Buddestra�e von Bernstorffstra�e bis Brunowstra�e, Sperrung der Fahrbahn, bis Mitte Juli 2012',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20111220.1150.364099.html',
       data  => <<EOF,
#: XXX Weiterbau zwischen Gorkistr. und Bernstorffstra�e ab M�rz 2012 vorgesehen
#: next_check: 2012-03-01
userdel	q4::inwork 2358,20368 2295,20358 2241,20487
userdel	q4::inwork 2295,20358 2362,20218 2402,20126
EOF
     },
     { from  => 1311832800, # 2011-07-28 08:00
       until => 1312142400, # 2011-07-31 22:00
       text  => 'Einbahnstra�enregelung in der Neuen Krugallee zwischen Baumschulenstr. und Rodelbergweg vom 29.07.2011, 8:00 Uhr bis 31.07.2011, 22:00 Uhr',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-treptow-koepenick/presse/archiv/20110711.0715.350961.html',
       data  => <<EOF,
userdel	q4::inwork; 16507,7254 16615,7062
EOF
     },
     { from  => 1310763434, # 2011-07-15 22:57
       until => 1341093600, # 201207010000 1331568000, # 2012-03-12 17:00 # until => 1333231200, # 2012-04-01 00:00
       text  => 'Instandsetzung der Pankgrafenbr�cke bis Anfang Juli 2012, Einschr�nkungen m�glich',
       type  => 'handicap',
       # auch: 'INKO_108508'
       source_id => 'http://www.stadtentwicklung.berlin.de/aktuell/pressebox/archiv_volltext.shtml?arch_1206/nachricht4696.html',
       data  => <<EOF,
userdel	q4::inwork 13953,23497 13976,23490 14173,23426
EOF
     },
     { from  => 1281243600, # 2010-08-08 07:00
       until => 1316786400, # 2011-09-23 16:00
       text  => 'K�penicker Str. (Altglienicke): Baustelle, f�r beide Richtungen nur ein Fahrstreifen abwechselnd frei (bis Ende 09/11) in beiden Richtungen zwischen Korkedamm und Semmelweisstr., 09.08.2010 07:00 Uhr bis 23.09.2011 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_016196',
       data  => <<EOF,
userdel	q4::inwork 19819,1980 19840,2010 19939,2074 20100,2247
EOF
     },
     { from  => 1312229266, # 2011-08-01 22:07
       until => 1314828000, # 2011-09-01 00:00
       text  => 'Eberswalde (Stadt): B167: Umbau Konten Freienwalder Stra�e/Saarstra�e OD Eberswalde Saarstra�e gesperrt, 25.07.2011 bis 31.08.2011 ',
       type  => 'handicap',
       source_id => 'LS/O-SG33-E/11/084',
       data  => <<EOF,
userdel	q4::inwork 38504,47638 39129,47518
EOF
     },
     { from  => 1312090200, # 2011-07-31 07:30
       until => 1314025200, # 2011-08-22 17:00
       text  => 'Gartenstr. (Mitte): Baustelle, Fahrtrichtung gesperrt (bis Ende 08/11) Richtung Invalidenstr. zwischen Bernauer Str. und Invalidenstr., 01.08.2011 07:30 Uhr bis 22.08.2011 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_107796',
       data  => <<EOF,
userdel	q4::inwork; 9224,14169 9383,13978
EOF
     },
     { from  => 1313269753, # 2011-08-13 23:09
       until => 1315605600, # 2011-09-10 00:00
       text  => 'Oranienburg: B273: Kampfmitteluntersuchung OL Oranienburg, 01.08.2011 bis 09.09.2011 ',
       type  => 'gesperrt',
       source_id => '116501481',
       data  => <<EOF,
userdel	2::inwork -1887,38134 -2179,38179
EOF
     },
     { from  => 1311483600, # 2011-07-24 07:00
       until => 1312642800, # 2011-08-06 17:00
       text  => 'Pastor-Niem�ller-Platz (Niedersch�nhausen): Baustelle, Einm�ndung Friedrichs-Engels-Str. vollst�ndig gesperrt, Staugefahr (bis Anfang 08/11) im Kreisverkehr Einm�ndung Friedrich-Engels-Str., 25.07.2011 07:00 Uhr bis 06.08.2011 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_108243',
       data  => <<EOF,
userdel	q4::inwork 9826,19382 9791,19363 9789,19329
EOF
     },
     { from  => 1312088400, # 2011-07-31 07:00
       until => 1313161200, # 2011-08-12 17:00
       text  => 'Sp�thstr. (Treptow): Baustelle, Stra�e vollst�ndig gesperrt (bis Mitte 08/11) in beiden Richtungen zwischen K�nigsheideweg und Neue Sp�thstr., 01.08.2011 07:00 Uhr bis 12.08.2011 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_108454',
       data  => <<EOF,
userdel	q4::inwork 15363,5668 15183,5480 15038,5235 14988,5214 14808,5202 14744,5211
EOF
     },
     { from  => 1312063200, # 2011-07-31 00:00
       until => 1313359200, # 2011-08-15 00:00
       text  => 'Zabel-Kr�ger-Damm: Bauarbeiten, Einbahnstra�enregelung, auch in der Schonacher Str., vom 01.08.2011 bis voraussichtlich 14.08.2011',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20110727.1340.352586.html',
       data  => <<EOF,
userdel	q4::inwork; 4718,22384 4800,22418 4898,22459 5006,22507 4919,22658
EOF
     },
     { from  => 1313272800, # 2011-08-14 00:00
       until => 1314568800, # 2011-08-29 00:00
       text  => 'Stra�enbauarbeiten in der Chris-Gueffroy-Allee: Vollsperrung der Fahrbahn, 15.8.2011-28.8.2011',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-treptow-koepenick/presse/archiv/20110727.1340.352585.html',
       data  => <<EOF,
userdel	q4::inwork 15183,5480 15165,5506 15146,5592 15143,5705 15141,5774 15141,5800 15141,5870 15143,5936
EOF
     },
     { from  => 1312526331, # 2011-08-05 08:38
       until => 1312772400, # 2011-08-08 05:00
       text  => 'Holzhauser Str. (Reinickendorf) in beiden Richtungen zwischen Wittestr. und Berliner Str., Bauarbeiten, Stra�e vollst�ndig gesperrt, 05.05.2011 bis 08.05.2011 05:00 Uhr',
       type  => 'gesperrt',
       source_id => 'INKO_108474',
       data  => <<EOF,
userdel	2::inwork 3079,19045 2993,18962
EOF
     },
     { from  => 1343894400, # 2012-08-02 10:00
       until => 1344211200, # 2012-08-06 02:00
       text  => 'Lebuser Str., Koppenstr. und Str. der Pariser Kommune (Friedrichshain): Veranstaltung, Stra�en n�rdlich der Karl-Marx-Str. vollst�ndig gesperrt (bis 06.08.12, 02:00)',
       type  => 'gesperrt',
       source_id => 'IM_019026',
       data  => <<EOF,
userdel	2::temp 12360,12505 12362,12540 12364,12589
userdel	2::temp 12891,12549 12869,12425
userdel	2::temp 12635,12629 12596,12472
EOF
     },
     { from  => 1312520400, # 2011-08-05 07:00
       until => 1312667999, # 2011-08-06 23:59
       text  => 'Yitzak-Rabin-Str. (Tiergarten) zwischen Str. des 17. Juni und Scheidemannstr sowie Scheidemannstr. und Heinrich-v.-Gagern-Str. gesperrt, ab 06.08.2011 07 Uhr bis ca. 24:00',
       type  => 'gesperrt',
       source_id => 'IM_017645',
       data  => <<EOF,
userdel	2::temp 8122,12608 8119,12414 8055,12186
userdel	2::temp 8540,12420 8400,12417 8354,12416 8119,12414
EOF
     },
     { from  => 1310464800, # 2011-07-12 12:00
       until => 1314802800, # 2011-08-31 17:00
       text  => 'Wartenberger Weg (Malchow): Baustelle, Stra�e vollst�ndig gesperrt, auf der Dorfstr. Verkehrseinschr�nkungen (bis Ende 08/11) in beiden Richtungen an der Kreuzung Dorfstr., 13.07.2011 12:00 Uhr bis 31.08.2011 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_107049',
       data  => <<EOF,
userdel	q4::inwork 16104,19165 15647,19165
EOF
     },
     { from  => 1332272539, # 2012-03-20 20:42
       until => 1333144800, # 2012-03-31 00:00
       text  => 'Wildau: L401: Stra�enbau OD Wildau, Einm�ndung Richard-Sorge-Stra�e bis Stichkanal Richtungsverkehr zw. Bergstr. und Freiheitsstr., 15.12.2011 bis 30.03.2012 ',
       type  => 'handicap',
       source_id => 'LS/S-SG33-W/11/303',
       data  => <<EOF,
userdel	q3::inwork; 26679,-8825 26381,-9753
EOF
     },
     { from  => 1313270628, # 2011-08-13 23:23
       until => 1313783686, # 1314827999, # 2011-08-31 23:59
       text  => 'Rennbahnstr. (Wei�ensee) Richtung Heinersdorf H�he Pasedagplatz Bauarbeiten, Fahrtrichtung gesperrt (bis Ende 08/11) ',
       type  => 'handicap',
       source_id => 'INKO_108874',
       data  => <<EOF,
userdel	q4::inwork; 14144,17165 14099,17195 14060,17221 13912,17320
EOF
     },
     { from  => 1313270697, # 2011-08-13 23:24
       until => 1318629600, # 2011-10-15 00:00
       text  => 'Schenkenberg: L26: grundhafter Ausbau der L 26 OA Baumgarten - Knoten Schenkenberg, 02.05.2011 bis 14.10.2011 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-E/10/214-10',
       data  => <<EOF,
userdel	2::inwork 45906,105450 46581,105900
EOF
     },
     { from  => 1313694142, # 2011-08-18 21:02
       until => 1313989200, # 2011-08-22 07:00
       text  => 'Schwarzer Weg (Mitte) in beiden Richtungen zwischen Invalidenstr. und Habersathstr. Veranstaltung, Stra�e vollst�ndig gesperrt, 19.08.2011 12 Uhr bis 22.08.2011 07:00 ',
       type  => 'gesperrt',
       source_id => 'IM_017698',
       data  => <<EOF,
userdel	2::temp 8426,13909 8574,13666
EOF
     },
     { from  => 1313553600, # 2011-08-17 06:00
       until => 1313985600, # 2011-08-22 06:00
       text  => 'Str. des 17. Juni (Tiergarten): Veranstaltung, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen Y.-Rabin-Str. und Ebertstr., Ebertstr. ebenfalls gesperrt, 18.08.2011, 06:00 Uhr bis 22.08.2011, 06:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_017679',
       data  => <<EOF,
userdel	q4::temp 8089,12190 8214,12205 8303,12216 8538,12245
userdel	q4::temp 8595,12066 8600,12165 8538,12245 8546,12279 8570,12302 8573,12325 8540,12420
EOF
     },
     { from  => 1313596800, # 2011-08-17 18:00
       until => 1313949600, # 2011-08-21 20:00
       text  => 'Triftstr. (Reinickendorf): Veranstaltung, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen Am Nordgraben und Holzhauser Str., 18.08.2011, 18:00 Uhr bis 21.08.2011, 20:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_017672',
       data  => <<EOF,
userdel	2::temp 4262,20025 4319,20182
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Hausvogteiplatz: Wochenmarkt Mittwoch und Freitag 9-16 Uhr, Behinderungen m�glich',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
#: by: http://www.berliner-woche.de/fileadmin/Wochenblatt-Ausgaben/2011/1122_MI.pdf
	q4::temp:clock 9925,11947 9878,11857
EOF
     },
     { from  => 1313733600, # 2011-08-19 08:00
       until => 1313888400, # 2011-08-21 03:00
       text  => 'Kirchstr. (Moabit) Veranstaltung zwischen Alt-Moabit und Helgol�nder Ufer ab 20.08.2011, 08 Uhr bis 21.08.2011, 03:00 Uhr',
       type  => 'handicap',
       source_id => 'IM_017697',
       data  => <<EOF,
userdel	q4::temp 6608,12858 6661,13130
EOF
     },
     { from  => 1314482400, # 2011-08-28 00:00
       until => 1317506400, # 2011-10-02 00:00
       text  => 'Vollsperrung der Schorfheidestra�e zwischen Dannenwalder Weg und Wilhelmsruher Damm in Berlin-Reinickendorf aufgrund von Stra�enbauma�nahmen, vom 29.08.2011 bis voraussichtlich 01.10.2011 ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20110825.1435.356236.html',
       data  => <<EOF,
userdel	q4::inwork 6279,20587 6317,20751 6337,20826 6356,20910 6368,20956 6374,20987 6371,21110
EOF
     },
     { from  => 1314482400, # 2011-08-28 00:00
       until => 1324656000, # 2011-12-23 17:00
       text  => 'Kastanienallee: Fahrbahn zwischen Oderberger Stra�e und Sch�nhauser Allee/Eberswalder Stra�e ab Montag dem 29.8.2011 gesperrt',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-pankow/presse/archiv/20110826.1055.356350.html', # und: source_id => 'IM_017746'
       data  => <<EOF,
userdel	q4::inwork 10881,15047 10838,14962 10723,14772
EOF
     },
     { from  => $isodate2epoch->("2013-08-08 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-08-11 23:59:59"),
       periodic => 1,
       text  => 'Berliner Allee (Wei�ensee): Veranstaltung (Blumenfest Wei�ensee), Fahrtrichtung gesperrt stadteinw�rts vom Wei�en See bis zum Antonplatz, 9.8.2013 bis 11.8.2013',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp; 14499,16341 14371,16252 14248,16202 14045,16120 14014,16106 13826,16026 13737,15994 13630,15956 13623,15954 13512,15909
EOF
     },
     { from  => 1313913600, # 2011-08-21 10:00
       until => 1322169302, # 1342796400, # 2012-07-20 17:00
       text  => 'B�kestr. (Wannsee): Br�ckenarbeiten, Stra�e vollst�ndig gesperrt, in beiden Richtungen zwischen Neue Kreisstr. und K�nigsweg, 22.08.2011 10:00 Uhr bis 20.07.2012 17:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'INKO_103963',
       data  => <<EOF,
userdel	2::inwork -7191,-1023 -7152,-1064 -7088,-1074 -7051,-1221
EOF
     },
     { from  => 1315087200, # 2011-09-04 00:00
       until => 1316469599, # 2011-09-19 23:59
       text  => 'Buchholzer Stra�e, Einbahnstra�e zwischen Beuthstra�e und Herthaplatz, von 5. September 2011 bis 19. September 2011',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-pankow/presse/archiv/20110902.1020.357195.html',
       data  => <<EOF,
userdel	q4::inwork; 10599,19957 10609,19971 10802,20240 10843,20301
EOF
     },
     { from  => 1315425600, # 2011-09-07 22:00
       until => 1315857600, # 2011-09-12 22:00
       text  => 'Gransee: B96: Gleisbauarbeiten Bahn�bergang bei Altl�dersdorf Vollsperrung ab 08.09.11 22:00 Uhr, 08.09.2011 22:00 Uhr bis 12.09.2011 22:00 Uhr ',
       type  => 'gesperrt',
       source_id => '116501441',
       data  => <<EOF,
userdel	2::inwork -5575,69050 -5511,69122 -5146,69565
EOF
     },
     { from  => 1314943200, # 2011-09-02 08:00
       until => 1315058400, # 2011-09-03 16:00
       text  => 'Joachim-Friedrich-Str. (Charlottenburg) in beiden Richtungen zwischen Kurf�rstendamm und Damaschkestr., Veranstaltung, Stra�e vollst�ndig gesperrt (03.09.2011 08:00 bis 16:00)',
       type  => 'handicap',
       source_id => 'IM_017752',
       data  => <<EOF,
userdel	q4::temp 3132,10499 3111,10116
EOF
     },
     { from  => 1315465200, # 2011-09-08 09:00
       until => 1315792800, # 2011-09-12 04:00
       text  => 'Potsdam: B2: Nesselgrundbr�cke zwischen Michendorf und Potsdam, Vollsperrung der Br�cke vom 09.09.11, 9:00 - 12.09.11, 04:00 Uhr',
       type  => 'gesperrt',
       source_id => 'LS/W-SG33-P/11/523',
       data  => <<EOF,
userdel	2::inwork -13687,-4949 -13723,-6401
EOF
     },
     { from  => $isodate2epoch->("2013-09-13 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-09-15 23:59:59"),
       periodic => 1,
       text  => 'Breite Str. (Pankow) in beiden Richtungen zwischen M�hlenstr. und Ossietzkystr., Veranstaltung (Fest an der Panke), Stra�e vollst�ndig gesperrt (14.09.2013 und 15.09.2013)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 10609,18384 10567,18366 10502,18338 10463,18321 10449,18315 10281,18241 10240,18193 10320,18197 10469,18262 10487,18270 10660,18345
EOF
     },
     { from  => 1315040400, # 2011-09-03 11:00
       until => 1338386400, # 2012-05-30 16:00
       text  => 'Lahnstr. (Neuk�lln): Baustelle, Fahrtrichtung gesperrt Richtung Neuk�llnische Allee zwischen Karl-Marx-Str. und Naumburger Str., 04.09.2011 11:00 Uhr bis 30.05.2012 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_017750',
       data  => <<EOF,
userdel	q4::inwork; 13236,6489 13455,6559 13520,6583
EOF
     },
     { from  => 1348699380, # undef, # 
       until => 1348699383, # 1356994800, # 2013-01-01 00:00
       text  => 'Jonasstr./Karl-Marx-Str.: Abbiegen nicht m�glich (bzw. nur auf dem Gehweg)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	3 12925,7425 13018,7441 13027,7368
userdel	3 13027,7368 13018,7441 12925,7425
userdel	3 12925,7425 13018,7441 13015,7471 12992,7545
userdel	3 12992,7545 13015,7471 13018,7441 12925,7425
EOF
     },
     { from  => 1318507200, # 2011-10-13 14:00
       until => 1318820400, # 2011-10-17 05:00
       text  => 'Rote Chaussee: Vollsperrung, vom 14.10.2011, 14:00 Uhr bis 17.10.2011, 5:00 Uhr',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20110929.0810.360313.html',
       data  => <<EOF,
userdel	2::inwork 872,24330 873,24112 825,24068 764,24065 609,24215 237,24374 195,24389 132,24390 78,24364 -406,23934
EOF
     },
     { from  => 1347508800, # 2012-09-13 06:00 PERIODISCH? ca. 2. Wochenende im September
       until => 1347832740, # 2012-09-16 23:59
       text  => 'Hauptstr. (Rosenthal): Veranstaltung, Stra�e vollst�ndig gesperrt zwischen Sch�nhauser Str. und An der Vogelweide, 14.09.2012 06:00 Uhr bis 16.09.2012 23:59 Uhr',
       type  => 'handicap',
       source_id => 'IM_019184',
       data  => <<EOF,
userdel	q4::temp 8556,21918 8568,21863 8473,21633 8460,21602
EOF
     },
     { from  => 1316088000, # 2011-09-15 14:00
       until => 1316282400, # 2011-09-17 20:00
       text  => 'Kirchstr. (Zehlendorf): Veranstaltung, Stra�e vollst�ndig gesperrt, 16.09.2011 14:00 Uhr bis 17.09.2011 20:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_017848',
       data  => <<EOF,
userdel	q4::temp 751,2860 589,2925
EOF
     },
     { from  => 1316412000, # 2011-09-19 08:00
       until => 1316743200, # 2011-09-23 04:00
       text  => 'John-Foster-Dulles-Allee (Tiergarten): Veranstaltung, Stra�e gesperrt zwischen Spreeweg und Yitzhak-Rabin-Str., 20.09.2011 08:00 Uhr bis 23.09.2011 04:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_017857',
       data  => <<EOF,
userdel	q4::temp 7039,12314 7215,12295 7437,12368 7514,12387 7627,12380 7821,12367 7875,12363 8017,12359 8070,12409 8119,12414
EOF
     },
     { from  => 1316491200, # 2011-09-20 06:00
       until => 1316750400, # 2011-09-23 06:00
       text  => 'Stra�e des 17. Juni (Tiergarten): Veranstaltung, Stra�e gesperrt zwischen Y.-Rabin-Str. und Ebertstr., 21.09.2011 06:00 Uhr bis 23.09.2011 06:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_017861',
       data  => <<EOF,
userdel	q4::temp 8089,12190 8214,12205 8303,12216 8538,12245
EOF
     },
     { from  => 1317679200, # 2011-10-04 00:00
       until => 1318111199, # 2011-10-08 23:59
       text  => 'Torstra�e: zwischen Chausseestra�e und Rosenthaler Platz Richtung Osten gesperrt, vom 04. bis 08. Oktober 2011',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-mitte/aktuell/presse/archiv/20110928.1340.360235.html',
       data  => <<EOF,
userdel	q4::inwork; 9212,13471 9340,13510 9394,13528 9517,13571 9571,13590 9668,13629 9799,13686 9918,13733 10177,13766
EOF
     },
     { from  => 1317679200, # 2011-10-04 00:00
       until => 1362092400, # M�rz 2013 # 1352476800, # 2012-11-09 17:00
       text  => 'Blankenburger Stra�e: Richtung Dietzgenstra�e zwischen Lindenberger Stra�e und Siegfriedstra�e wegen Bauarbeiten gesperrt; Herthaplatz ist teilweise eine Einbahnstra�e; 05.10.2011 11:00 Uhr bis M�rz 2013',
       type  => 'handicap',
       source_id => 'INKO_078941_COPY_1',
       data  => <<EOF,
#: by: http://www.berlin.de/ba-pankow/verwaltung/tiefbau/blankenburger-strasse2.html?date=20121116 vvv
userdel	q4::inwork; 11148,19838 11051,19789 10948,19737 10829,19676 10742,19632
userdel	q4::inwork; 10614,19907 10599,19957
#: by: ^^^
EOF
     },
     { from  => 1317592800, # 2011-10-03 00:00
       until => 1318716000, # 2011-10-16 00:00
       text  => 'Zeltinger Stra�e wird als Einbahnstra�e vom Zeltinger Platz in Richtung Zerndorfer Weg ausgewiesen, vom 04.10.2011 bis 15.10.2011',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20110928.1140.360205.html',
       data  => <<EOF,
userdel	q4::inwork; 2933,25830 2895,25786 2764,25639 2721,25576 2657,25486 2531,25368 2510,25350 2446,25265
EOF
     },
     { from  => 1318629629, # 2011-10-15 00:00
       until => 1320274799, # 2011-11-02 23:59
       text  => 'Instandsetzungsarbeiten an Fahrbahnfl�chen in der Pannwitzstra�e zwischen Olbendorfer Weg und Puchertweg, Vollsperrung, vom 12. Oktober bis zum 02. November 2011 ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20111006.1020.360727.html',
       data  => <<EOF,
userdel	q4::inwork 4608,19287 4690,19446
EOF
     },
     { from  => 1318229040, # 2011-10-10 08:44
       until => 1324656000, # 2011-12-23 17:00
       text  => 'Motardstr. (Spandau): Baustelle, Fahrtrichtung gesperrt Richtung Rohrdamm zwischen Sternfelder Str. und Rohrdamm, 11.10.2011 08:44 Uhr bis 23.12.2011 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_018013',
       data  => <<EOF,
userdel	q4::inwork; 386,14162 984,14086
EOF
     },
     { from  => 1318716000, # 2011-10-16 00:00
       until => 1322262000, # 2011-11-26 00:00
       text  => 'Pr�tzel: L35: Stra�enbauarbeiten Pr�tzel - Harnekop und umgekehrt Vollsperrung ab 17.10.11 bis 25.11.2011 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-F/11/197',
       data  => <<EOF,
userdel	2::inwork 50141,30438 50704,30986
EOF
     },
     { from  => 1317621600, # 2011-10-03 08:00
       until => 1321027200, # 2011-11-11 17:00
       text  => 'Silbersteinstr. (Neuk�lln): Baustelle, Fahrtrichtung gesperrt Richtung Oberlandstr. zwischen Hermannstr. bis Eschersheimer Str., 04.10.2011 08:00 Uhr bis 11.11.2011 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_108705',
       data  => <<EOF,
userdel	q4::inwork; 12395,6785 12044,6707 11689,6634
EOF
     },
     { from  => 1320702775, # undef, # 
       until => 1320702778, # undef, # XXX wieder passierbar
       text  => 'R�dersdorfer Str.: Einbahnstra�e zwischen Fredersdorfer Str. und Wedekindstr., offen in Richtung Osten',
       type  => 'handicap',
       data  => <<EOF,
userdel	q3::inwork; 13066,11854 13052,11867 12891,12008
EOF
     },
     { from  => 1318996800, # 2011-10-19 06:00
       until => 1319252400, # 2011-10-22 05:00
       text  => 'In den Ministerg�rten (Mitte): Veranstaltung, Stra�e vollst�ndig gesperrt zwischen Ebertstr. und Gertrud-Kolmar-Str., 20.10.2011 06:00 Uhr bis 22.10.2011 05:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_018057',
       data  => <<EOF,
userdel	2::temp 8567,11799 8813,11825
EOF
     },
     { from  => 1320382800, # 2011-11-04 06:00
       until => 1320606000, # 2011-11-06 20:00
       text  => 'Vollsperrungen im Bereich Invalidenstra�e zwischen Chausseestra�e und Am Nordbahnhof, 05.11.11 ab 6:00 Uhr bis 06.11.11, 20:00 Uhr',
       type  => 'handicap',
       source_id => 'http://www.stadtentwicklung.berlin.de/aktuell/pressebox/archiv_volltext.shtml?arch_1110/nachricht4508.html',
       data  => <<EOF,
userdel	q4::inwork 9085,13919 8935,13844
EOF
     },
     { from  => 1347099450, # undef, # 
       until => 1347099453, # undef, # XXX
       text  => 'Alt-Friedrichsfelde - Wei�enh�her Stra�e: Bauarbeiten, Durchfahrt k�nnte gesperrt sein',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 19750,11730 19827,11686 19879,11595 19881,11591
EOF
     },
     { from  => 1325955689, # 
       until => 1325955693, # XXX
       text  => 'Alfred-Kowalke-Str.: Bauarbeiten, teilweise muss auf den Gehweg ausgewichen werden',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 18286,11275 18229,11256 18202,11253 18061,11240
EOF
     },
     { from  => 1320534000, # 2011-11-06 00:00
       until => 1321138799, # 2011-11-12 23:59
       text  => 'Vollsperrung der Oderberger Stra�e vom 7. November 2011 bis 12. November 2011',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-pankow/presse/archiv/20111028.1105.361658.html',
       data  => <<EOF,
userdel	q4::inwork 10723,14772 10401,14963
EOF
     },
     { from  => 1319526000, # 2011-10-25 09:00
       until => 1323273600, # 2011-12-07 17:00
       text  => 'Teichstr. (Reinickendorf): Baustelle, Fahrtrichtung gesperrt (bis Anfang 12/11) Richtung Gotthardstr. zwischen Lindauer Allee und Gotthardstr. ',
       type  => 'handicap',
       source_id => 'INKO_110898',
       data  => <<EOF,
userdel	q4::inwork; 6432,18682 6418,18491 6403,18289 6383,18033 6380,17836
EOF
     },
     { from  => undef, # 
       until => 1338501600, # 2012-06-01 00:00
       text  => 'Bauma�nahmen in der Parkanlage an der S�dseite der Krummen Lanke, Sperrungen m�glich (bis Fr�hsommer 2012)',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-steglitz-zehlendorf/presse/archiv/20111030.0735.361648.html',
       data  => <<EOF,
userdel	2::inwork -1245,4414 -1185,4450 -1139,4575 -1134,4706 -971,4971 -724,5080 -604,5228
EOF
     },
     { from  => 1321138800, # 2011-11-13 00:00
       until => 1321397999, # 2011-11-15 23:59
       text  => 'N�ldnerstra�e am 14. und 15. November gesperrt (Bauarbeiten)',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-lichtenberg/presse/archiv/20111110.1420.362326.html',
       data  => <<EOF,
userdel	q4::inwork 15272,10790 15388,10758 15433,10765 15681,10801
EOF
     },
     { from  => 1321398000, # 2011-11-16 00:00
       until => 1322866799, # 2011-12-02 23:59
       text  => 'Sperrung der Stra�e Im Erpelgrund zwischen der Stra�e An der Schneise bis Dambockstra�e in �stlicher Richtung, vom 17. November 2011 bis voraussichtlich 2. Dezember 2011 ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20111110.1620.362354.html',
       data  => <<EOF,
userdel	q4::inwork -629,21975 -428,21933
EOF
     },
     { from  => 1320590700, # 2011-11-06 15:45
       until => 1324655160, # 2011-12-23 16:46
       text  => 'K�penicker Str. (Altglienicke): Baustelle, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen Semmelweisstr. und Rudower Str., 07.11.2011 15:45 Uhr bis 23.12.2011 16:46 Uhr ',
       type  => 'handicap',
       source_id => 'IM_018211',
       data  => <<EOF,
userdel	q4::inwork 19803,1911 19771,1793
#XXX del: userdel	q4::inwork 19771,1793 19728,1660 19679,1571
EOF
     },
     { from  => 1329681337, # 1320987600, # 2011-11-11 06:00
       until => 1329681343, # 1333206000, # 2012-03-31 17:00
       text  => 'Luisenstr. (Mitte): Baustelle, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen Invalidenstr. und Hannoversche Str., 12.11.2011 06:00 Uhr bis 31.03.2012 17:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_018151',
       data  => <<EOF,
userdel	q4::inwork 8634,13588 8626,13641 8619,13689
EOF
     },
     { from  => 1348076973, # 1314604800, # 2011-08-29 10:00
       until => 1365706902, # 1380636000, # 2013-10-01 16:00, # 1347721200, # 2012-09-15 17:00
       text  => 'Kastanienallee (Prenzlauer Berg): Bauarbeiten zwischen Oderberger Str. und Schwedter Str., Fahrbahn ist manchmal gesperrt, bis Herbst 2013',
       type  => 'handicap',
       source_id => 'IM_019212',
       data  => <<EOF,
#: by: http://www.berlin.de/ba-pankow/verwaltung/tiefbau/kastanienallee_pb.html
#: note: nur die halbe Strecke ist gesperrt, deshalb q3
#: note: am 2012-09-19 gepr�ft, Schranke, nur Stra�enbahnen werden durchgelassen
#: note: am 2012-10-18 gepr�ft, Schranke, nur Stra�enbahnen werden durchgelassen
#: note: am 2012-10-31 am s�dlichen Ende vorbeigefahren, m�glicherweise war heute die Schranke nicht aktiv
#: note: am 2013-02-11 gepr�ft, keine Schranke, aber nur f�r "Linienverkehr frei"
#: note: am 2013-04-11 gepr�ft: Radfahrer d�rfen hier offiziel entlangfahren
userdel	q3::inwork 10530,14452 10723,14772
EOF
     },
     { from  => 1295269680, # 2011-01-17 14:08
       until => 1334322000, # 2012-04-13 15:00
       text  => 'Heinrich-Mann-Str. (Pankow): Baustelle, Stra�e vollst�ndig gesperrt (bis Mitte 04/12) in beiden Richtungen zwischen Sch�nholzer Str. und Cottastr. ',
       type  => 'handicap',
       source_id => 'IM_016853',
       data  => <<EOF,
userdel	q4::inwork 9881,18354 9821,18392
EOF
     },
     { from  => 1325718000, # 2012-01-05 00:00
       until => 1327618800, # 2012-01-27 00:00
       text  => 'Str. des 17. Juni (Tiergarten) in beiden Richtungen zwischen Yitzhak-Rabin-Str. und Ebertstr. Veranstaltung, Stra�e vollst�ndig gesperrt (06.01.2012 06 Uh bis 26.01.12, ca. 18:00 Uhr) ',
       type  => 'gesperrt',
       source_id => 'IM_018330',
       data  => <<EOF,
userdel	2::temp 8538,12245 8303,12216 8214,12205 8089,12190
EOF
     },
     { from  => undef, # 
       until => undef, # XXX
       text  => 'Vollsperrung der Fu�g�ngerbr�cke Altglienicke, mindestens bis zum Sommer 2013',
       type  => 'gesperrt',
       source_id => 'http://www.stadtentwicklung.berlin.de/aktuell/pressebox/archiv_volltext.shtml?arch_1106/nachricht4399.html',
       data  => <<EOF,
#: by: http://www.altglienicke24.de/meldungen.html
#: by: http://www.stadtentwicklung.berlin.de/aktuell/pressebox/archiv_volltext.shtml?arch_1201/nachricht4563.html
#: by: http://pf-tk.de/ai1ec_event/podiumsdiskussion-wie-weiter-im-kolner-viertel/?instance_id=
#: by: http://www.morgenpost.de/bezirke/article112374495/Fussgaengerbruecke-wird-repariert.html (Reparatur ab Juni 2013, 2 Monate Bauzeit)
#: next_check: 2013-07-31
userdel	2::inwork 19968,16 19940,52
EOF
     },
     { from  => 1329680038, # 2012-02-19 20:33
       until => 1354316400, # 2012-12-01 00:00
       text  => 'Fredersdorf-Vogelsdorf: L30: Ersatzneubau Br�cke �ber das M�hlenflie� OD Fredersdorf, m�glicherweise komplett gesperrt, 06.02.2012 bis 30.11.2012 ',
       type  => 'gesperrt',
       source_id => 'LS/O-SG33-F/12/014',
       data  => <<EOF,
userdel	2::inwork 34913,13893 35382,13974
EOF
     },
     { from  => 1343067459, # 1329208920, # 2012-02-14 09:42 -> handicap_s-orig
       until => 1343067463, # 1369989720, # 2013-05-31 10:42
       text  => 'Hessische Str. (Mitte): Baustelle, Fahrtrichtung gesperrt (Umleitungsstrecke f�r die Arbeiten auf der Invalidenstr.) Richtung Oranienburger Tor, 15.02.2012 09:42 Uhr bis 31.05.2013 10:42 Uhr',
       type  => 'handicap',
       source_id => 'IM_018437',
       data  => <<EOF,
userdel	q4::inwork; 8690,13723 8775,13606
EOF
     },
     { from  => 1330026300, # 2012-02-23 20:45
       until => 1331766000, # 2012-03-15 00:00
       text  => 'Orankestrand wegen Bauarbeiten gesperrt, bis ungef�hr M�rz 2012, siehe http://www.berlin.de/ba-lichtenberg/presse/archiv/20120220.1530.366402.html',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-lichtenberg/presse/archiv/20120220.1530.366402.html',
       data  => <<EOF,
#: by: http://www.berlin.de/ba-lichtenberg/presse/archiv/20120220.1530.366402.html (Weg wieder ge�ffnet, allerdings nur ein Drittel der urspr�nglichen Breite)
userdel	2::inwork 15479,16060 15592,16069 15664,16115 15731,16208
EOF
     },
     { from  => 1330988400, # 2012-03-06 00:00
       until => 1345921074, # 2012-09-07 00:00 1346968800 # --- vorzeitig fertig geworden --- http://www.berlin.de/ba-reinickendorf/presse/archiv/20120824.1505.374170.html
       text  => 'Buddestra�e, Sperrung von Bernstorffstra�e bis Gorkistra�e wegen Bauarbeiten',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20120223.1505.366579.html',
       data  => <<EOF,
userdel	q4::inwork 2295,20358 2241,20487
EOF
     },
     { from  => 1330902000, # 2012-03-05 00:00
       until => 1370005200, # 2013-05-31 15:00
       text  => 'Neubau der Ruppiner Chaussee, Fahrbahn Richtung Tegel bis Schulzendorfer Str. gesperrt, bis Mitte 2013',
       type  => 'handicap',
       source_id => 'INKO_111647', # auch: http://www.berlin.de/ba-reinickendorf/presse/archiv/20120228.1300.366751.html
       data  => <<EOF,
#: osm_watch: way id="23243508" version="30"
userdel	q4::inwork; -1872,24336 -1790,24260 -1746,24219 -1627,24105 -1367,23853 -1286,23753 -1281,23746 -1084,23564 -997,23492 -984,23480 -903,23406 -783,23190 -656,23011
EOF
     },
     { from  => undef, # 1329631200, # 2012-02-19 07:00
       until => 1364925014, # 1404140400, # 2014-06-30 17:00 -> nach handicap_s-orig gewandert
       text  => 'Behrenstr. (Mitte): Fahrbahn Richtung Friedrichstr. zwischen Glinkastr. und Friedrichstr. gesperrt',
#       text  => 'Behrenstr. (Mitte): zwischen Glinkastr. und Friedrichstr. gesperrt',
       type  => 'handicap',
       source_id => 'INKO_093369',
#       source_id => 'INKO_117614',
       data  => <<EOF,
#: note: ab Glinkastr. nur ungef�hr die halbe Strecke bis zur Friedrichstr. gesperrt, deshalb q3
userdel	q3::inwork; 9164,12172 9373,12197
#userdel	q3::inwork 9164,12172 9373,12197
EOF
     },
     { from  => 1330419240, # 2012-02-28 09:54
       until => 1341583200, # 2012-07-06 16:00
       text  => 'Colditzstr. (Tempelhof): Baustelle, gesperrt Richtung Ullsteinstr. zwischen Volkmarstr. und Ullsteinstr., 29.02.2012 09:54 Uhr bis 06.07.2012 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_018476',
       data  => <<EOF,
userdel	q4::inwork; 9974,5385 10029,5230
EOF
     },
     { from  => 1330496400, # 2012-02-29 07:20
       until => 1331132400, # 2012-03-07 16:00
       text  => 'Damerowstr. (Pankow): Baustelle, Fahrtrichtung gesperrt Richtung Berliner Str. zwischen Mendelstr. und Stiftsweg, 01.03.2012 07:20 Uhr bis 07.03.2012 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_018478',
       data  => <<EOF,
userdel	q4::inwork; 11357,18598 11204,18545 11168,18542 11001,18528
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Am Schloss Sch�nhausen: nachts gesperrt (im Sommer ab ca. 19 Uhr, im Winter ab Einbruch der Dunkelheit)',
       recurring => 1,
       data => <<EOF,
#: by: cornelia (bayer...): vvv
Am Schloss Sch�nhausen	2::night 10308,19297 10344,19181 10382,19066
Am Schloss Sch�nhausen	2::night 10249,19148 10344,19181
#: by: ^^^
EOF
     },
     { from  => 1346696132, # XXX was: undef, # --- ich habe hier noch nie eine Sperrung erlebt, auch Sa abends nicht
       until => 1346696136, # XXX was: undef, #
       text  => 'Am Wriezener Bahnhof - Helsingforser Str./Wriezener Park: bei Veranstaltungen im Berghain u.U. nicht passierbar',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
	2::night 13002,11705 13042,11749
EOF
     },
     { from  => 1350075439, # undef, # 
       until => 1350075443, # undef, # XXX
       text  => 'Sredzkistr.: Fahrbahn zwischen Rykestr. und Kollwitzstr. komplett gesperrt. Dauer der Sperrung ist unbekannt.',
       type  => 'handicap',
       data  => <<EOF,
userdel	q3::inwork 11436,14741 11535,14688
EOF
     },
     { from  => 1335556039, # 2012-04-27 21:47
       until => 1337983200, # 2012-05-26 00:00
       text  => 'Buckower Damm (Neuk�lln): Baustelle, Stra�e vollst�ndig gesperrt zwischen Johannisthaler Chaussee und An den Achterh�fen, 30.03.2012 bis 25.05.2012 15:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_018622',
       data  => <<EOF,
userdel	q4::inwork 12817,2031 12911,1815
EOF
     },
     { from  => $isodate2epoch->("2013-04-26 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-04-28 23:59:59"),
       periodic => 1,
       text  => 'Str. des 17.Juni zwischen Yitzhak-Rabin-Str. und Platz des 18.M�rz sowie Ebertstr. gesperrt (Nisan Kinderfest, 27.4.2013 bis 28.4.2013)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8610,12254 8538,12245 8303,12216 8214,12205 8089,12190 8055,12186
userdel	2::temp 8540,12420 8573,12325 8570,12302 8546,12279 8538,12245 8600,12165
EOF
     },
     { from  => 1334814060, # 2012-04-19 07:41
       until => 1336482000, # 2012-05-08 15:00
       text  => 'K�thener Str. (Marzahn): Bauarbeiten Stra�e vollst�ndig gesperrt zwischen Dessauer Str. und Wuhletalstr., 20.04.2012 07:41 Uhr bis 08.05.2012 15:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_018679',
       data  => <<EOF,
userdel	q4::inwork 20485,17784 20542,17911 20576,17994
EOF
     },
     { from  => 1335088800, # 2012-04-22 12:00
       until => 1336136400, # 2012-05-04 15:00
       text  => 'Chausseestr. (Mitte) in H�he W�hlertstr.: Baustelle, Fahrtrichtung Richtung M�llerstr. gesperrt, 23.04.2012 12:00 Uhr bis 04.05.2012 15:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_112232',
       data  => <<EOF,
userdel	q4::inwork; 8527,14352 8442,14456 8406,14507 8346,14576
EOF
     },
     { from  => 1335854115, # 
       until => 1335909540, # 2012-05-01 23:59
       text  => 'Str. des 17.Juni zwischen Yitzhak-Rabin-Str. und Platz des 18.M�rz sowie Ebertstr. gesperrt (Veranstaltung zum 1. Mai)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8610,12254 8538,12245 8303,12216 8214,12205 8089,12190 8055,12186
userdel	2::temp 8540,12420 8573,12325 8570,12302 8546,12279 8538,12245 8600,12165
EOF
     },
     { from  => 1336255200, # 2012-05-06 00:00
       until => 1337464800, # 2012-05-20 00:00
       text  => 'Gr�nauer Stra�e: Vollsperrung zwischen Normannenstra�e und K�penicker Stra�e aufgrund eines defekten Regenentw�sserungskanal, Bauzeit vom 07.05.12 bis 19.05.12',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-treptow-koepenick/organisationseinheiten/tief/index.html',
       data  => <<EOF,
userdel	q4::inwork 19771,1793 19898,1704
EOF
     },
     { from  => 1336764755, # 2012-05-11 21:32
       until => 1337119199, # 2012-05-15 23:59
       text  => 'Vollsperrung der Bahnbr�cke Karlshorst: 10. bis 15. Mai 2012 (Sperrung der Fahrbahn)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 18731,8577 18709,8423
EOF
     },
     { from  => $isodate2epoch->("2013-06-18 20:00:00"), # 1 Tag Vorlauf # from  => 1338001200, # 2012-05-26 05:00
       until => $isodate2epoch->("2013-06-30 04:00:00"), #        until => 1338602400, # 2012-06-02 04:00
       text  => 'Sperrung der Bahnbr�cke Karlshorst (Treskowallee): 19. Juni 2013, 22 Uhr bis 30. Juni 2013, 4 Uhr',
       type  => 'gesperrt',
       data  => <<EOF,
#: by: http://www.s-bahn-berlin.de/aktuell/2013/pdf/faltblatt_bruecken_treskowstrasse.pdf
#: XXX n�chste Sperrung im Juli 2013
#: next_check: 2013-07-06
userdel	2::inwork 18731,8577 18709,8423
EOF
     },
     { from  => undef, # 
       until => 1341093600, # 2012-07-01 00:00
       text  => 'Peace Wall/Friedensmauer; auf Gehweg ausweichen (bis Juli 2012)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::temp 9527,10927 9539,10820
EOF
     },
     { from  => 1336943422, # 2012-05-13 23:10
       until => 1337887165, # 1337551200, # 2012-05-21 00:00
       text  => 'Ersatzneubau Br�cke �ber den Stierngraben Br�cke �ber den Stierngraben bei Kaakstedt, Vollsperrung zw. Suckow und Gerswalde und umgekehrt 07.05.2012 bis 20.05.2012',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 35887,85385 34920,85944
EOF
     },
     { from  => 1349635594, # 2012-10-07 20:46
       until => 1350684000, # 2012-10-20 00:00
       text  => 'Spanische Allee (Nikolassee): Bauarbeiten an den Bahnbr�cken, f�r beide Richtungen nur ein Fahrstreifen abwechselnd frei, Regelung mit provisorischen Ampeln bis Mitte Oktober 2012',
       type  => 'handicap',
       source_id => 'IM_018769',
       data  => <<EOF,
userdel	q4::inwork -3648,2881 -3736,2849
EOF
     },
     { from  => 1336944008, # 2012-05-13 23:20
       until => 1339797600, # 2012-06-16 00:00
       text  => 'W�nsdorfer Str. (Lichtenrade) zwischen Prinzessinnenstr. und Blohmstr zwischen 14.05.2012 und 15.06.2012 Baustelle, Vollsperrung',
       type  => 'handicap',
       source_id => 'INKO_112449',
       data  => <<EOF,
userdel	q4::inwork 10096,-2137 10021,-1918
EOF
     },
     { from  => 1337887553, # 2012-05-24 21:25
       until => 1341516003, # 1341612000, # 2012-07-07 00:00
       text  => 'Prenzlau: K7324: Stra�enbauarbeiten Prenzlau, zw. OL Wollenthin und B�ndigershof Umleitung: �ber Prenzlau, 02.04.2012 bis 06.07.2012 ',
       type  => 'gesperrt',
       source_id => '127310045',
       data  => <<EOF,
userdel	2::inwork 42981,101756 42922,101898 42875,102012 42912,102131 43131,102293 43262,102525 43200,102737
EOF
     },
     { from  => 1336899120, # 2012-05-13 10:52
       until => 1338566400, # 2012-06-01 18:00
       text  => 'W�hlischstr. (Friedrichshain): Baustelle, Fahrtrichtung Richtung Warschauer Str. zwischen Gryphiusstr. und Seumestr. gesperrt, als Radfahrer kann man langsam und vorsichtig passieren, 14.05.2012 10:52 Uhr bis 01.06.2012 18:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_018810',
       data  => <<EOF,
userdel	q3::inwork; 14434,11465 14369,11489 14305,11514
EOF
     },
     { from  => undef, # 
       until => 1368556113, # undef, # XXX
       text  => 'Sredzkistr. zwischen Knaackstr. und Hagenauer Str.: Teile der Fahrbahn gesperrt, Ausweichen auf Gehweg',
       type  => 'handicap',
       data  => <<EOF,
#: note: einige Meter �stlich der Knaackstr. gesperrt
userdel	q3::inwork 11101,14768 11187,14763
EOF
     },
     { from  => 1338778800,
       until => 1338919200,
       text  => 'Vollsperrung der Pankgrafenstra�e im Bereich der Pankgrafenbr�cke am 5. Juni 2012',
       type  => 'gesperrt',
       source_id => 'http://www.stadtentwicklung.berlin.de/aktuell/pressebox/archiv_volltext.shtml?arch_1206/nachricht4684.html',
       data  => <<EOF,
userdel	2::inwork 13953,23497 13976,23490 14173,23426
EOF
     },
     { from  => 1338204660, # 2012-05-28 13:31
       until => 1341673200, # 2012-07-07 17:00
       text  => 'Behrenstr. (Mitte): Baustelle, Fahrtrichtung gesperrt Richtung Friedrichstr. zwischen Mauerstr. und Glinkastr., bis 7. Juli ',
       type  => 'handicap',
       source_id => 'IM_018829',
       data  => <<EOF,
userdel	q4::inwork; 9064,12156 9164,12172
EOF
     },
     { from  => 1338283200, # 2012-05-29 11:20
       until => 1341515831, # 1343664000, # 2012-07-30 18:00
       text  => 'Klingsorstr. (Steglitz): Fahrbahnsch�den, Vollsperrung in beiden Richtungen zwischen Hindenburgdamm und Birkbuschstr., bis Ende Juli 2012 ',
       type  => 'handicap',
       source_id => 'IM_018838',
       data  => <<EOF,
userdel	q4::inwork 4932,4152 5068,4259
EOF
     },
     { from  => 1338750610, # 2012-06-03 21:10
       until => 1341352799, # 2012-07-03 23:59
       text  => 'Fanmeile EM 2012: Sperrung der Stra�e des 17. Juni und umliegenden Stra�en, bis 3. Juli 2012',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8573,12325 8540,12420
userdel	2::temp 8089,12190 8214,12205 8303,12216 8538,12245 8610,12254
userdel	2::temp 8354,12416 8546,12279 8538,12245 8600,12165 8595,12066
userdel	2::temp 7383,12095 7816,12150 8055,12186 8119,12414
userdel	2::temp 8546,12279 8570,12302
EOF
     },
     { from  => 1348929655, # undef, # 
       until => 1348929658, # undef, # XXX
       text  => 'Gleimstr.: Bauarbeiten zwischen Ystadter Str. und Sch�nhauser Allee, Einbahnstra�e Richtung Westen',
       type  => 'handicap',
       data  => <<EOF,
userdel	q3::inwork; 10423,15698 10427,15699 10564,15721 10713,15746 10953,15787
EOF
     },
     { from  => 1336057200, # 2012-05-03 17:00
       until => 1349877000, # 2012-10-10 15:50
       text  => 'Kastanienallee (Rosenthal): Bauarbeiten, zwischen Friedrich-Engels-Str. und Eschenallee in Richtung Osten gesperrt, bis Mitte Oktober 2012',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 8900,20601 9025,20611 9161,20622 9174,20623 9295,20632 9460,20644
EOF
     },
     { from  => 1339099200, # 2012-06-07 22:00
       until => 1339437600, # 2012-06-11 20:00
       text  => 'Oberspreestr., Sperrung des Bahn�bergangs, Radfahrer k�nnen �ber Fu�g�ngerumleitung langsam passieren bis 11.06.2012 20:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_113476',
       data  => <<EOF,
userdel	q4::inwork 19328,5304 19405,5284 19445,5271
EOF
     },
     { from  => 1351726607, # undef
       until => 1351726612, # undef, # XXX
       text  => 'Oderberger Str./Schwedter Str.: Bauarbeiten, Fahrbahn ist gesperrt. Dauer der Sperrung ist unbekannt.',
       type  => 'handicap',
       data  => <<EOF,
#: by: http://www.berlin.de/ba-pankow/verwaltung/tiefbau/oderberger_strasse.html (allerdings sind die Bauzeiten schon jetzt weit �berschritten)
#: last_checked: 2012-10-18 (aber Asphaltierung in Gange)
#: next_check: 2012-10-20
userdel	q4::inwork 10401,14963 10379,14963
#XXX del --- hier nicht mehr --- userdel	q4::inwork 10379,14963 10370,14946 10380,14911
#XXX del --- hier nicht mehr --- userdel	q4::inwork 10379,14963 10366,14992
EOF
     },
     { from  => 1339624800, # 2012-06-14 00:00
       until => 1344031200, # 2012-08-04 00:00
       text  => 'Sanierung Wanderweg am Hermsdorfer See, Sperrung im Zeitraum vom 15.06.2012 bis voraussichtlich 03.08.2012 ',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20120612.1440.371422.html',
       data  => <<EOF,
userdel	2::inwork 4824,22907 5054,23025 5127,23042 5205,23094 5232,23139
EOF
     },
     { from  => 1339797175, # 2012-06-15 23:52
       until => 1339970399, # 2012-06-17 23:59
       text  => 'Veranstaltung auf dem Mariannenplatz "Berlin lacht", 15.-17. Juni 2012',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 11770,10774 11841,10747 11897,10887 11958,11045
EOF
     },
     { from  => 1339907400, # 2012-06-17 06:30
       until => 1342191600, # 2012-07-13 17:00
       text  => 'Friedrichstr. (Mitte): Baustelle, zwischen Mittelstr. und Unter den Linden Richtung S�den gesperrt (bis Mitte 07/12)',
       type  => 'handicap',
       source_id => 'INKO_113724',
       data  => <<EOF,
userdel	q4::inwork; 9343,12464 9358,12351
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'F�lderichplatz: Wochenmarkt Dienstag 8-13 Uhr und Donnerstag 14-18 Uhr',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-spandau/presse/archiv/20120423.1455.369136.html', # und best�tigt von Stefan Klinkusch
       recurring => 1,
       data  => <<EOF,
	q4::temp:clock -3941,12545 -3941,12376
EOF
     },
     { from  => 1341525600, # 2012-07-06 00:00
       until => 1341784800, # 2012-07-09 00:00
       text  => 'Nauen: L16: Br�ckenabriss und Stra�enbau - Deckeneinbau zwischen B�rnicke und Tietzow LSA-Regelung 07.07./ 08.07.2012 Vollsperrung ',
       type  => 'gesperrt',
       source_id => 'LS/W-SG33-P/12/085',
       data  => <<EOF,
userdel	2::inwork -21888,31852 -21772,30661
EOF
     },
     { from  => 1339649580, # 2012-06-14 06:53
       until => 1350829854, # 1354298400, # 2012-11-30 19:00 --- Baustelle existiert zwar zwischen Neue Krugallee und Orionstr., aber Radfahrer kommen ganz gut vorbei
       text  => 'Dammweg (Pl�nterwald): Baustelle, Stra�e vollst�ndig gesperrt In beiden Richtungen zwischen K�penicker Landstr. und Orionstr., 15.06.2012 06:53 Uhr bis 30.11.2012 19:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_018917',
       data  => <<EOF,
userdel	q4::inwork 15751,8250 15692,8198 15557,8077
EOF
     },
     { from  => 1340082000, # 2012-06-19 07:00
       until => 1351699200, # 2012-10-31 17:00
       text  => 'Saalestr. (Neuk�lln): Fahrbahn in beiden Richtungen zwischen Karl-Marx-Str. und Wipperstr. bis Ende Oktober 2012 gesperrt',
       type  => 'handicap',
       source_id => 'IM_018927',
       data  => <<EOF,
userdel	q4::inwork 13161,7173 13051,7157
EOF
     },
     { from  => 1341133200, # 2012-07-01 11:00
       until => 1354633200, # 2012-12-04 16:00
       text  => 'Siemensstr. (Obersch�neweide): Baustelle, Fahrtrichtung gesperrt (bis Anfang 12/12) Richtung Edisonstr. zwischen Wattstr. und Edisonstr',
       type  => 'handicap',
       source_id => 'INKO_111688',
       data  => <<EOF,
userdel	q4::inwork; 17766,6616 17860,6644 17962,6674
EOF
     },
     { from  => 1341515513, # 2012-07-05 21:11
       until => 1342130400, # 2012-07-13 00:00
       text  => 'Str. des 17. Juni (Tiergarten): Veranstaltung, Stra�e vollst�ndig gesperrt, in beiden Richtungen zwischen Gro�er Stern und Y.-Rabin-Str., 04.07.2012 bis 12.07.2012 22:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_018979',
       data  => <<EOF,
userdel	2::temp 8055,12186 7816,12150 7383,12095 6828,12031
EOF
     },
     { from  => 1341698400, # 2012-07-08 00:00
       until => 1344117599, # 2012-08-04 23:59
       text  => 'Arbeiten in der Frohnauer Stra�e: w�hrend der Bauma�nahme ist die Frohnauer Stra�e zwischen Falkentaler Steig und Alemannenstra�e in Richtung Alemannstra�e gesperrt (vom 9. Juli 2012 bis voraussichtlich 4. August 2012)',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20120703.1445.372223.html',
       data  => <<EOF,
userdel	q4::inwork; 2492,24325 2469,24391 2325,24486 2262,24505 2146,24535 2058,24576 1925,24599 1878,24619 1868,24633 1838,24675 1802,24707 1736,24722
EOF
     },
     { from  => undef, # 
       until => 1343685600, # 2012-07-31 00:00
       text  => 'Krontaler Str.: m�gliche Sperrungen wegen Bauarbeiten an den Bahnbr�cken',
       type  => 'gesperrt',
       # ebenfalls: ein telefonischer Hinweis
       source_id => 'http://www.s-bahn-berlin.de/aktuell/2012/144_s8.htm',
       data  => <<EOF,
userdel	2::inwork 13429,22943 13521,23057
EOF
     },
     { from  => 1342130400, # 2012-07-13 00:00
       until => 1342303200, # 2012-07-15 00:00
       text  => 'Mittenwalde: L30: Br�ckenneubau im Zuge der OU K�nigs Wusterhausen zwischen K�nigs Wusterhausen und Schenkendorf Vollsperrung am 14.07.12',
       type  => 'gesperrt',
       source_id => 'LS/S-SG33-W/11/268',
       data  => <<EOF,
userdel	2::inwork 24843,-13725 25148,-13393
EOF
     },
     { from  => 1341730800, # 2012-07-08 09:00
       until => 1342796400, # 2012-07-20 17:00
       text  => 'Berliner Str. (Wei�ensee): Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 07/12) in beiden Richtungen zwischen Romain-Rolland-Str. und Am Wasserturm',
       type  => 'handicap',
       source_id => 'INKO_114025',
       data  => <<EOF,
userdel	q4::inwork 12736,17998 12467,17814
EOF
     },
     { from  => 1342208382, # 1342044000, # 2012-07-12 00:00 --- moved to handicap-s
       until => 1342208385, # 1388530799, # 2013-12-31 23:59
       text  => 'Friedrichstr.(Mitte) in beiden Richtungen zwischen Unter den Linden und Behrenstr. Baustelle, Stra�e vollst�ndig gesperrt, ab 13.07.2012 07 Uhr bis Ende Dezember 2013 ',
       type  => 'handicap',
       source_id => 'INKO_091722_COPY_1',
       data  => <<EOF,
userdel	q4::inwork 9358,12351 9369,12253
EOF
     },
     { from  => 1351810800, # 2012-11-02 00:00
       until => 1352084400, # 2012-11-05 04:00
       text  => 'Karlshorster Str. (Lichtenberg): Br�ckenarbeiten, Sperrung der kompletten Stra�e, Fu�g�nger und Radfahrer k�nnen nicht passieren, 03.11.2012 bis 05.11.2012 04:00 Uhr',
       type  => 'handicap',
       source_id => 'INKO_115760',
       data  => <<EOF,
userdel	2::inwork 15261,10738 15272,10790 15279,10862
EOF
     },
     { from  => undef, # 
       until => 1360611352, # undef, # XXX
       text  => 'Christburger Str.: Fahrbahn an der Prenzlauer Allee gesperrt, Ausweichen auf Gehweg',
       type  => 'handicap',
       data  => <<EOF,
userdel	q3::inwork 11912,14486 11642,14625
EOF
     },
     { from  => 1342994400, # 2012-07-23 00:00
       until => 1348610399, # 2012-09-25 23:59
       text  => 'Stra�enbauarbeiten John-Foster-Dulles-Allee zwischen Spreeweg und Zeltenplatz, 23.7. - 25.9.2012, Fahrbahn ist gesperrt, der n�rdliche Gehweg kann benutzt werden',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-mitte/aktuell/presse/archiv/20120719.1310.372734.html',
       data  => <<EOF,
userdel	q2::inwork 7437,12368 7215,12295 7039,12314
EOF
     },
     { from  => 1342945020, # 2012-07-22 10:17
       until => 1353254400, # 2012-11-18 17:00
       text  => 'Berliner Str. (Pankow): Baustelle, stadtausw�rts zwischen M�hlenstr. und Elsa-Br�ndstr�m-Str. bis Mitte November 2012 gesperrt',
       type  => 'handicap',
       source_id => 'IM_019006',
       data  => <<EOF,
userdel	q4::inwork; 10927,17022 10908,17142
EOF
     },
     { from  => 1342940400, # 2012-07-22 09:00
       until => 1354291200, # 2012-11-30 17:00
       text  => 'Pichelswerderstr. (Spandau): Baustelle, Fahrtrichtung gesperrt (bis Ende 11/2012) Richtung Freiheit zwischen Ruhlebener Str. und Gewerbehof',
       type  => 'handicap',
       source_id => 'INKO_113869',
       data  => <<EOF,
userdel	q4::inwork; -2706,13291 -2699,13359 -2669,13488
EOF
     },
     { from  => undef, # 
       until => undef, # XXX
       text  => 'Park am Gleisdreieck, Wege im Westpark: wegen Bauarbeiten k�nnen die Wege unpassierbar sein',
       type  => 'gesperrt',
       data  => <<EOF,
#: last_checked: 2013-04-28 vvv
userdel	2::inwork 8309,10368 8278,10384 8296,10438 8328,10585 8332,10637 8341,10721 8318,10738
userdel	2::inwork 8328,10585 8270,10613
userdel	2::inwork 8336,10829 8318,10738 8270,10613 8264,10460 8237,10418 8191,10346 8180,10282 8145,10090
userdel	2::inwork 8278,10384 8263,10349 8258,10338 8249,10313 8253,10265 8260,10183 8211,10083 8145,10090 8042,10084 8040,10076 8035,10075 8027,10076 8035,10075 8027,10076
userdel	2::inwork 8263,10349 8315,10347 8333,10167 8360,10133
userdel	2::inwork 8270,10613 8199,10634
userdel	2::inwork 8159,10430 8237,10418 8278,10384
userdel	2::inwork 8318,10738 8362,10779
#: last_checked ^^^
EOF
     },
     { from  => 1343332800, # 2012-07-26 22:00
       until => 1343617200, # 2012-07-30 05:00
       text  => 'Buckower Chaussee (Marienfelde): Baustelle, Vollsperrung H�he S-Bahnhof Buckower Chaussee, m�glicherweise f�r Radfahrer langsam passierbar (bis Montag, 05:00)',
       type  => 'handicap',
       source_id => 'INKO_113563',
       data  => <<EOF,
userdel	q4::inwork 9178,556 9158,551 9069,506
EOF
     },
     { from  => 1344282201, # 2012-08-06 21:43
       until => 1346364000, # 2012-08-31 00:00
       text  => 'Chemnitzer Str. (Kaulsdorf): Baustelle, Stra�e vollst�ndig gesperrt in beiden Richtungen zwischen Alt-Kaulsdorf und Am Niederfeld, 16.07.2012 bis 30.08.2012 ',
       type  => 'handicap',
       source_id => 'INKO_113817',
       data  => <<EOF,
userdel	q4::inwork 22484,11270 22436,11054
EOF
     },
     { from  => 1344142800, # 2012-08-05 07:00
       until => 1364479200, # 2013-03-28 15:00
       text  => 'Stargarder Str. (Prenzlauer Berg): Baustelle, Fahrtrichtung gesperrt Richtung Prenzlauer Allee zwischen Sch�nhauser Allee und Greifenhagener Str., bis Ende M�rz 2013',
       type  => 'handicap',
       source_id => 'IM_019043',
       data  => <<EOF,
userdel	q4::inwork; 10953,15787 11086,15772
EOF
     },
     { from  => 1342594800, # 2012-07-18 09:00
       until => 1358534778, # -> moved to handicap_s-orig --- undef, # XXX 1351724340, # 1350054000, # 2012-10-12 17:00
       text  => 'Adalbertstr.: Fahrbahn in Richtung Kottbusser Tor gesperrt',
       type  => 'handicap',
       source_id => 'INKO_114376',
       data  => <<EOF,
#: last_checked: 2013-01-18
#: XXX see also Adalbertstr. (Kreuzberg): Leitungsarbeiten, Fahrtrichtung gesperrt (bis Mitte 10/12) Richtung Kottbusser Tor zwischen Oranienstr. und Kottbusser Tor, 19.07.2012 09:00 Uhr bis 12.10.2012 17:00 Uhr�INKO_114376�http://asp.vmzberlin.com/VMZ_LSBB_MELDUNGEN_WEB/Meldungskarte.jsp?back=true&map=true&x=52.50035&y=13.41862&zoom=13&meldungId=INKO_114376
userdel	q4::inwork; 11389,10463 11393,10390
EOF
     },
     { from  => 1344535200, # 2012-08-09 20:00
       until => 1344826800, # 2012-08-13 05:00
       text  => 'Sperrung der B�sebr�cke ("Bornholmer Br�cke") in Fahrtrichtung Ost von Freitag, den 10.08.2012, 20:00 Uhr bis Montag, den 13.08.2012, 5:00 Uhr, Ausweichen auf gegen�berliegenden Gehweg m�glich',
       type  => 'handicap',
       source_id => 'http://www.stadtentwicklung.berlin.de/aktuell/pressebox/archiv_volltext.shtml?arch_1208/nachricht4740.html',
       data  => <<EOF,
userdel	q4::inwork; 9781,16569 9816,16565 9883,16557 9998,16547
EOF
     },
     { from  => 1345140000, # 2012-08-16 20:00
       until => 1345431600, # 2012-08-20 05:00
       text  => 'Sperrung der B�sebr�cke ("Bornholmer Br�cke") in Fahrtrichtung West von Freitag, den 17.08.2012, 20:00 Uhr bis Montag, den 20.08.2012, 5:00 Uhr, Ausweichen auf gegen�berliegenden Gehweg m�glich',
       type  => 'handicap',
       source_id => 'http://www.stadtentwicklung.berlin.de/aktuell/pressebox/archiv_volltext.shtml?arch_1208/nachricht4740.html',
       data  => <<EOF,
userdel	q4::inwork; 9998,16547 9883,16557 9816,16565 9781,16569
EOF
     },
     { from  => undef, # 
       until => undef, #
       text  => 'Weserstr. - Boxhagener Str.: Tor in einer Hausdurchfahrt, nachts gesperrt',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
#: note: gepr�ft am 2012-11-02 (gegen 22:30 - geschlossen)
#: note: und am 2012-11-15 (gegen 21:00 - offen)
userdel	2::night 14838,11410 14792,11391
EOF
     },
     { from  => 1345119120, # 2012-08-16 14:12
       until => 1355862384, # 1356105600, # 2012-12-21 17:00
       text  => 'K�thener Br�cke (Tiergarten): Baustelle, Stra�e gesperrt bis Mitte Dezember 2012',
       type  => 'handicap',
       source_id => 'IM_019090',
       data  => <<EOF,
userdel	q4::inwork 8443,10777 8430,10710
EOF
     },
     { from  => 1343706240, # 2012-07-31 05:44
       until => 1350503220, # 1351695600, # 2012-10-31 16:00
       text  => 'Uhlandstr. (Charlottenburg): Baustelle, Stra�e vollst�ndig gesperrt In beiden Richtungen zwischen Steinplatz und Kantstr., 01.08.2012 05:44 Uhr bis 31.10.2012 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_019071',
       data  => <<EOF,
userdel	q4::inwork 5102,11006 5122,11300
EOF
     },
     { from  => 1352918929, # undef, # 
       until => 1352918932, # undef, # XXX
       text  => 'Senefelderstr.: Fahrbahn vor der Raumerstr. gesperrt, Ausweichen auf Gehweg erforderlich',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 11615,15114 11595,15058
EOF
     },
     { from  => $isodate2epoch->("2013-07-31 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-08-11 23:59:59"),
       periodic => 1,
       text  => 'Gauklerfest, Stra�en am Schinkelplatz gesperrt, vom 1. August bis 11. August 2013',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 9994,12368 10008,12274 10010,12259 10035,12209
userdel	2::temp 10008,12274 10058,12290 9996,12401
userdel	2::temp 10091,12232 10058,12290
EOF
     },
     { from  => undef, # 
       until => 1361643418, # undef, # XXX
       text  => 'Hussitenstr.: Fahrbahn zwischen Stralsunder Str. und Usedomer Str. gesperrt, Ausweichen auf Gehweg',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 9112,14771 9250,14658
EOF
     },
     { from  => 1346825940, # 2012-09-05 08:19
       until => 1347444000, # 2012-09-12 12:00
       text  => 'Klingsorstr. (Steglitz): Baustelle, Richtung Hindenburgdamm zwischen Birkbuschstr. und Amfortasweg gesperrt, bis Mitte September 2012 ',
       type  => 'handicap',
       source_id => 'IM_019149',
       data  => <<EOF,
userdel	q4::inwork; 5271,4547 5214,4445
EOF
     },
     { from  => 1346558400, # 2012-09-02 06:00
       until => 1347890400, # 2012-09-17 16:00
       text  => 'Rosenthaler Str. (Mitte): zwischen Neue Sch�nhauser Str. und Hackescher Markt Baustelle, Fahrbahn gesperrt (bis Mitte 09/12)',
       type  => 'handicap',
       source_id => 'INKO_113178_COPY_5',
       data  => <<EOF,
userdel	q4::inwork 10310,13227 10264,13097
EOF
     },
     { from  => 1347746400, # 2012-09-16 00:00
       until => 1350165599, # 2012-10-13 23:59
       text  => 'Stra�enbau in der Alfred-Kowalke-Stra�e �stlich der Stra�e Am Tierpark, Stra�e ist gesperrt, 17. September 2012 bis 13. Oktober 2012 ',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-lichtenberg/presse/archiv/20120914.1355.375249.html',
       data  => <<EOF,
userdel	2::inwork 18286,11275 18409,11348 18477,11388 18618,11452
EOF
     },
     { from  => 1347508800, # 2012-09-13 06:00
       until => 1347825600, # 2012-09-16 22:00
       text  => 'Bergstr. (Steglitz): Veranstaltung, Stra�e zwischen K�rnerst. und Heesestr. gesperrt, 14.09.2012 06:00 Uhr bis 16.09.2012 22:00 Uhr ',
       type  => 'handicap',
       source_id => 'IM_019185',
       data  => <<EOF,
userdel	q4::temp 5464,5731 5280,5714
EOF
     },
     { from  => 1347429180, # 2012-09-12 07:53
       until => 1347832740, # 2012-09-16 23:59
       text  => 'Spanische Allee (Zehlendorf): Baustelle, Stra�e unter den Bahnbr�cken vollst�ndig gesperrt (bis 16.09.12 nachts)',
       type  => 'gesperrt',
       source_id => 'IM_019192',
       data  => <<EOF,
userdel	2::inwork -3736,2849 -3648,2881
EOF
     },
     { from  => undef, # 
       until => 1357672004, # undef, # XXX
       text  => 'Oderberger Str.: Fahrbahn zwischen Kastanienallee und Choriner Str. wegen Bauarbeiten gesperrt',
       type  => 'handicap',
       data  => <<EOF,
#: by: http://www.berlin.de/ba-pankow/verwaltung/tiefbau/oderberger_strasse.html?date=20121116
userdel	q4::inwork 10870,14689 10723,14772
EOF
     },
     { from  => undef, # 
       until => 1357672029, # undef, # XXX
       text  => 'Choriner Str.: Einbahnstra�e in H�he Oderberger Str., Richtung Sch�nhauser Allee gesperrt',
       type  => 'handicap',
       data  => <<EOF,
#: by: http://www.berlin.de/ba-pankow/verwaltung/tiefbau/oderberger_strasse.html?date=20121116
userdel	q4::inwork; 10870,14689 10893,14705
EOF
     },
     { from  => 1348437600, # 2012-09-24 00:00
       until => 1355525999, # 2012-12-14 23:59
       text  => 'Sanierung der Rheinsteinstra�e zwischen Zwieseler Str. und K�nigswinterstra�e, Teile der Fahrbahn sind gesperrt, vom 24. September bis zum 14. Dezember 2012 ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-lichtenberg/presse/archiv/20120921.1525.375622.html',
       data  => <<EOF,
userdel	q4::inwork 18988,8791 19073,8828 19116,8846 19163,8867 19299,8946 19500,9043 19629,9099
EOF
     },
     { from  => 1348376400, # 2012-09-23 07:00
       until => 1349964000, # 2012-10-11 16:00
       text  => 'Eisenacher Str. (Tempelhof): Baustelle, Richtung Richtung Rixdorfer Str. zwischen Mariendorfer Damm und Kosleckstr. gesperrt, 24.09.2012 07:00 Uhr bis 11.10.2012 16:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_115461',
       data  => <<EOF,
userdel	q4::inwork; 9277,4664 9405,4667 9494,4658 9695,4638 10010,4606
EOF
     },
     { from  => 1348632000, # 2012-09-26 06:00
       until => 1349092800, # 2012-10-01 14:00
       text  => 'Scheidemannstr. / John-Foster-Dulles-Allee: Stra�e wegen Marathon-Vorbereitungen zwischen Heinrich-von-Gagern-Str. und Gro�e Querallee gesperrt, 27.09.2012 06:00 Uhr bis 01.10.2012 14:00 Uhr ',
       type  => 'gesperrt',
       source_id => 'IM_019236',
       data  => <<EOF,
userdel	2::temp 7875,12363 8017,12359 8070,12409 8119,12414
EOF
     },
     { from  => $isodate2epoch->("2013-09-28 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-10-06 23:59:59"),
       periodic => 1,
       text  => 'Sperrungen wegen Marathon und Tag der deutschen Einheit: Stra�e des 17. Juni zwischen Gro�er Stern und Brandenburger Tor, Ebertstr. zwischen Behrenstr. und Scheidemannstr., Yitzak-Rabin-Str., 29.09.2013 bis 06.10.2013',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8573,12325 8540,12420
userdel	2::temp 8610,12254 8538,12245 8303,12216 8214,12205 8089,12190 8055,12186 7816,12150 7383,12095 6828,12031
userdel	2::temp 8570,12302 8546,12279 8538,12245 8600,12165 8595,12066
userdel	2::temp 8119,12414 8055,12186
EOF
     },
     { from  => 1348981200, # 2012-09-30 07:00
       until => 1350482400, # 2012-10-17 16:00
       text  => 'Roelckestr. (Wei�ensee): Baustelle, Stra�e zwischen Rennbahnstr. und Amalienstr. bis Mitte Oktober 2012 gesperrt ',
       type  => 'handicap',
       source_id => 'INKO_115090',
       data  => <<EOF,
userdel	q4::inwork 13589,16965 13767,17136 13818,17201 13839,17227 13912,17320
EOF
     },
     { from  => 1348981200, # 2012-09-30 07:00
       until => 1351260000, # 2012-10-26 16:00
       text  => 'Schulenburgstr. (Spandau): Baustelle, Richtung Ruhlebener Str. ab Tiefwerderweg gesperrt, bis Ende Oktober 2012 ',
       type  => 'handicap',
       source_id => 'INKO_113279',
       data  => <<EOF,
userdel	q4::inwork; -2960,13203 -2728,13269 -2706,13291
EOF
     },
     { from  => 1353366000, # 2012-11-20 00:00
       until => 1386169200, # 2013-12-04 16:00
       text  => 'Friedrich-Engels-Str. stadteinw�rts zwischen Nordendstr. und Platananenstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 2013/Anfang 2014)',
       type  => 'handicap',
       source_id => 'IM_019421',
       data  => <<EOF,
#: by: http://www.berlin.de/ba-pankow/presse/archiv/20121015.1240.376583.html (Verz�gerung bei den Bauarbeiten)
#: by: http://www.berlin.de/ba-pankow/presse/archiv/20121115.1100.378059.html
#: by: http://www.berlin.de/ba-pankow/verwaltung/tiefbau/friedrich_engels_strasse.html?date=20121116
#: by: IM_019421 (allerdings hier nur bis Dezember 2013)
#: next_check: 2013-12-04
#: XXX danach bessere Stra�enqualit�t? Radstreifen?
#: osm_watch: way id="24930947" version="20"
userdel	q4::inwork; 9149,20336 9235,20125 9266,20048 9300,19949 9333,19853 9355,19789
EOF
     },
     { from  => 1350252000, # 2012-10-15 00:00
       until => 1351551600, # 2012-10-30 00:00
       text  => 'D�rpfeldstra�e: wegen Gleisbauarbeiten zwischen Anna-Seghers-Stra�e und Thomas-M�ntzer-Stra�e als Einbahnstra�e in Richtung Osten gef�hrt (15.10.2012 bis 29.10.2012)',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-treptow-koepenick/presse/archiv/20121012.1220.376513.html',
       data  => <<EOF,
userdel	q4::inwork; 20012,3532 20082,3578 20136,3609 20149,3617
EOF
     },
     { from  => 1348376400, # 2012-09-23 07:00
       until => 1352905200, # 2012-11-14 16:00
       text  => 'Eisenacher Str. zwischen Kosleckweg und �neasstr Richtung Rixdorfer Str. Baustelle, Fahrbahn gesperrt, bis Mitte November 2012',
       type  => 'handicap',
       source_id => 'INKO_115461',
       data  => <<EOF,
userdel	q4::inwork; 10010,4606 10183,4583 10270,4571
EOF
     },
     { from  => 1350363600, # 2012-10-16 07:00
       until => 1353682800, # 2012-11-23 16:00
       text  => 'Kurf�rstenstr. zwischen Genthiner Str. und Einemstr. Richtung Westen Baustelle, Fahrbahn gesperrt, bis 23. November 2012 ',
       type  => 'handicap',
       source_id => 'INKO_114523',
       data  => <<EOF,
userdel	q4::inwork; 7315,10537 7117,10611 7115,10612 6972,10665
EOF
     },
     { from  => 1352070000, # 2012-11-05 00:00
       until => 1354316399, # 2012-11-30 23:59
       text  => 'Fahrbahnsanierung der Rathausstra�e vom 5. November 2012 bis Ende November 2012, Fahrbahn ist gesperrt',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-lichtenberg/presse/archiv/20121025.1210.377071.html',
       data  => <<EOF,
userdel	q4::inwork 15537,12367 15576,12315 15628,12246 15651,12214
EOF
     },
     { from  => undef, # 
       until => undef, # XXX
       text  => 'J�denstr.: das �berqueren der Grunerstr. ist insbesondere au�erhalb der Parkbewirtschaftungszeiten (abends, am Wochenende) sehr unbequem (eng parkende Autos)',
       type  => 'gesperrt',
       recurring => 1,
       data  => <<EOF,
#: by: http://www.berlin.de/ba-mitte/buergerdienste/parkraumbewirtschaftung.html (Zone 3)
userdel	2::temp::igndisp 10805,12468 10803,12470
EOF
     },
     { from  => 1351638000, # 2012-10-31 00:00
       until => 1355785199, # 2012-12-17 23:59
       text  => 'Fahrbahnfl�cheninstandsetzung in der Winterstra�e, voraussichtlich vom 1. November 2012 bis zum 17. Dezember 2012 wird die Fahrbahn wegen Bauarbeiten voll gesperrt ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20121030.1450.377336.html',
       data  => <<EOF,
userdel	q4::inwork 8296,18154 8116,18115
EOF
     },
     { from  => undef, # 
       until => undef, # XXX
       text  => 'Richardstr.: Baustelle zwischen B�hmische Str. und Richardplatz, Umfahrung auf dem Gehweg notwendig',
       type  => 'handicap',
       data  => <<EOF,
#: XXX bis wann ist die Baustelle fertig?
#: last_checked: 2013-05-06
userdel	q2::inwork 13339,7452 13303,7622
EOF
     },
     { from  => undef, # 
       until => 1368556143, # undef, # XXX
       text  => 'Sredzkistr./Husemannstr.: Kreuzungsbereich gesperrt, Ausweichen auf Gehweg',
       type  => 'handicap',
       data  => <<EOF,
#: XXX je 30 Meter vor und hinter der Kreuzung ist gesperrt vvv
userdel	q2::inwork 11436,14741 11271,14755
userdel	q3::inwork 11271,14755 11187,14763
#: XXX ^^^
#: XXX ebenfalls Umweg notwendig
userdel	q2::inwork 11293,14957 11271,14755 11255,14572
EOF
     },
     { from  => undef, #
       until => undef, #
       text  => 'Kollwitzplatz: Wochenmarkt Samstag 9-18 Uhr',
       type  => 'gesperrt',
       source_id => 'http://www.berliner-zeitung.de/berlin/kollwitzplatz-mit-sack-und-pack-,10809148,11393926.html',
       recurring => 1,
       data  => <<EOF,
#: by: http://www.berlin.de/ba-pankow/bvv-online/vo020.asp?VOLFDNR=3228&options=4 vvv
	q4::temp:clock 11317,14564 11285,14515 11229,14422
#: XXX_prog: q3, weil nur ca. 35m betroffen sind 
	q3::temp:clock 11317,14564 11436,14741
#: by: ^^^
EOF
     },
     { from  => 1352847600, # 2012-11-14 00:00
       until => 1354229999, # 2012-11-29 23:59
       text  => 'Stra�enbauarbeiten in der Zionskirchstra�e von Kastanienallee bis Choriner Stra�e, Fahrbahn ist gesperrt, vom 15. November 2012 bis ca. 29. November 2012 ',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-mitte/aktuell/presse/archiv/20121114.1215.378008.html',
       data  => <<EOF,
userdel	q4::inwork 10558,14176 10426,14262
EOF
     },
     { from  => undef, # 
       until => 1412114400, # 2014-10-01 00:00
       text  => 'Neubau der Schulstra�e, Bauabschnitt zwischen Duseke- und Grunowstra�e',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-pankow/verwaltung/tiefbau/nb_schulstr.html',
       data  => <<EOF,
#: XXX: zweiter Bauabschnitt wird bis zur Berliner Str. gehen
#: next_check: 2013-06-01
userdel	q4::inwork 10479,18007 10498,18014 10473,18113 10545,18143 10582,18159
EOF
     },
     { from  => 1351465200, # 2012-10-29 00:00
       until => 1354316400, # 2012-12-01 00:00
       text  => 'Hoeppnerstra�e zwischen Werner-Vo�-Damm und Mohnickesteig: halbseitige Sperrung mit Einbahnstra�enregelung in Fahrtrichtung Boelckestra�e, vom 29.10.2012 bis 30.11.2012 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 8604,7381 8479,7389 8429,7403 8386,7430 8376,7440 8302,7508 8267,7572 8263,7611
EOF
     },
     { from  => 1351983600, # 2012-11-04 00:00
       until => 1354316400, # 2012-12-01 00:00
       text  => 'Nuthestra�e zwischen Steinstra�e und Bodmerstra�e: Vollsperrung vom 05.11.2012 bis 30.11.2012 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 10293,-1904 10243,-1876 10099,-1482
EOF
     },
     { from  => undef, # 
       until => 1356611384, # undef, # XXX
       text  => 'Emser Stra�e: Bauarbeiten, Fahrbahn gesperrt',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 12872,7134 13051,7157
EOF
     },
     { from  => undef, # 
       until => 1375308000, # 2013-08-01 00:00
       text  => 'Weg am Nordgraben: Weg wird saniert und ist m�glicherweise nicht passierbar',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-reinickendorf/presse/archiv/20121128.1200.378696.html',
       data  => <<EOF,
userdel	2::inwork 6378,20460 6428,20487 6487,20512 6601,20542 7083,20584 7289,20618
EOF
     },
     { from  => undef,
       until => undef,
       text  => 'Potsdamer Wassertaxi: f�hrt nur im Sommer an Wochenenden und Feiertagen',
       recurring => 1,
       type  => 'gesperrt',
       source_id => 'http://www.potsdamer-wassertaxi.de/fahrplan.php?y=2012',
       data  => <<EOF,
#: XXX_prog tempor�re L�sung f�r saisonale F�hren vvv
	2::temp -12149,1436 -12057,1530 -11789,1502 -11323,1330 -10320,1494 -10098,1745 -10086,1886
	2::temp -10086,1886 -10055,1628
#: XXX_prog ^^^
EOF
     },
     { from  => undef,
       until => undef,
       text  => 'F�hren F21, F23, F24: fahren nur ab Karfreitag bis zum 3. Oktober, fahren nicht am Montag',
       recurring => 1,
       type  => 'gesperrt',
       source_id => 'http://www.bvg.de/index.php/de/3777/name/Faehrlinie+F21.html', # und 23 und 24
       data  => <<EOF,
#: XXX_prog tempor�re L�sung f�r saisonale F�hren vvv
	2::temp 27090,-2253 27420,-2067 27492,-1880 27490,-1710 27425,-1601 27374,-1573
	2::temp 29406,3776 29367,3690 29395,3572 29297,3456 29131,3489 29084,3331 29113,3324 29195,3191 29553,2934 29569,2909 29604,2931 29797,2918 29945,3001 29959,3031
	2::temp 29959,3031 29968,2986
#: XXX_prog ^^^
EOF
     },
     { from  => undef,
       until => undef,
       recurring => 1,
       text  => 'Karniner F�hre: f�hrt nur von Mai bis Oktober',
       type  => 'gesperrt',
       data  => <<EOF,
#: XXX_prog tempor�re L�sung f�r saisonale F�hren vvv
	2::temp 38674,160390 37644,160344 38049,160420 38325,160573
#: XXX_prog ^^^
EOF
     },
     { from  => undef,
       until => undef,
       recurring => 1,
       text  => 'Westkl�ne - Ostkl�ne: keine offizielle F�hre, aber wenn man Gl�ck hat, kann man per Ruderboot �bergesetzt werden',
       type  => 'gesperrt',
       data  => <<EOF,
#: XXX_prog tempor�re L�sung f�r saisonale F�hren vvv
	2::temp 42506,161075 42450,161090
#: XXX_prog ^^^
EOF
     },
     { from  => undef, # 
       until => 1369994400, # 2013-05-31 (laut Baustellenschild)
       text  => 'Hertzbergstr.: Bauarbeiten zwischen B�hmische Str. und Sonnenallee',
       type  => 'handicap',
       data  => <<EOF,
#: last_checked: 2013-05-06
#: next_check: 2013-05-31
#: XXX ist die Baustelle tats�chlich Ende Mai fertig?
#: note: in der Gegenrichtung (Richardplatz -> Sonnenallee) offiziell nur f�r Anwohner offen
userdel	q4::inwork; 13474,8060 13444,7879
EOF
     },
     { from  => 1357040979, # 2013-01-01 12:49
       until => 1358981999, # 2013-01-23 23:59
       text  => 'Stra�e des 17. Juni: wegen der Fashion Week gesperrt, bis 23. Januar 2013',
       type  => 'gesperrt',
       source_id => 'IM_019489',
       data  => <<EOF,
userdel	2::temp 8055,12186 8089,12190 8214,12205 8303,12216 8538,12245
EOF
     },
     { from  => undef,
       until => undef,
       text  => 'Friedhofswege nachts gesperrt',
       recurring => 1,
       data => <<EOF,
	2::night 12851,12602 13108,12859 13046,12956 12878,13229
	2::night 12773,12683 13046,12956
EOF
     },
     { from  => undef, # 
       until => 1358549999, # 2013-01-18 23:59
       text  => 'Schlo�platz: Weg an der ehemaligen Gr�nfl�che f�r einige Tage gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
#: by: http://www.tagesspiegel.de/berlin/gruenflaeche-muss-dem-schloss-weichen-ab-heute-verschwindet-der-rasen-am-schlossplatz-/7593590.html
# REMOVED (existiert nicht mehr) --- userdel	2::inwork 10155,12494 10285,12306
EOF
     },
     { from  => 1359830530, # 2013-02-02 19:42
       until => 1364770800, # 2013-04-01 01:00
       text  => 'Charlottenstra�e: Bauarbeiten zwischen Friedrich-Ebert-Stra�e und Dortustra�e, Einbahnstra�e bis voraussichtlich M�rz 2013',
       type  => 'handicap',
       data  => <<EOF,
#: by: http://www.potsdam.de/cms/beitrag/10098485/1463075
	q3::inwork; -12881,-1092 -12961,-1105 -12973,-1106 -13187,-1150
EOF
     },
     { from  => 1360350803, # 2013-02-08 20:13
       until => 1360551600, # 2013-02-11 04:00
       text  => 'Karlshorster Str. (Rummelsburg) gesperrt (09.02.2013 00 Uhr bis 11.02.2013 04:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'INKO_116993',
       data  => <<EOF,
userdel	2::inwork 15261,10738 15272,10790 15279,10862
EOF
     },
     { from  => 1361168940, # 2013-02-18 07:29
       until => 1364227200, # 2013-03-25 17:00
       text  => 'F�rstenwalder Damm (K�penick) Richtung B�lschestr. zwischen M�ggelseedamm und M�hlweg Baustelle, Fahrtrichtung gesperrt (bis Ende 03/13)',
       type  => 'handicap',
       source_id => 'IM_019584',
       data  => <<EOF,
userdel	q4::inwork; 23950,5342 24049,5380 24162,5424 24285,5472 24366,5504 24471,5544 24700,5633
EOF
     },
     { from  => 1364875200, # 2013-04-02 06:00
       until => 1365184800, # 2013-04-05 20:00
       text  => 'H�ttenweg (Grunewald): Br�ckenbauarbeiten, Vollsperrung bis Freitag, 20:00',
       type  => 'gesperrt',
       source_id => 'IM_019680',
       data  => <<EOF,
userdel	2::inwork -739,6838 -927,6888
EOF
     },
     { from  => $isodate2epoch->("2013-04-25 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-04-28 23:59:59"),
       text  => 'K�penicker Winzerfr�hling: Altstadt K�penick, Luisenhain, Schlossinsel, Behinderungen m�glich, 26.4.2013 bis 28.4.2013 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 22133,4644 22111,4562 22093,4499
userdel	2::temp 22071,4501 22057,4531 22043,4562 22057,4618 22074,4664 22133,4644 22138,4661 22175,4730 22196,4847 22153,4840 22074,4664
EOF
     },
     { from  => $isodate2epoch->("2013-07-17 00:00:00"), # 1 Tag Vorlauf
       until => $isodate2epoch->("2013-07-21 23:59:59"),
       periodic => 1, # XXX wahrscheinlich
       text  => 'Hafenfest Alt-Tegel, Greenwichpromenade, Behinderungen m�glich (18.07.2013 bis 21.07.2013)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 1557,19765 1397,20125 1340,20209 1269,20271
EOF
     },
     { from  => 1366495200, # 2013-04-21 00:00
       until => 1366574627, # 1378504799, # 2013-09-06 23:59 -> in gesperrt_orig
       text  => 'Sperrung am zuk�nftigen Landtag: Radweg Richtung Westen gesperrt (22. April 2013 - 6. September 2013)',
       type  => 'gesperrt',
       data  => <<EOF,
#: by: http://www.potsdam.de/cms/dokumente/10050614_996205/9f652b1a/Radverkehrsfuehrung_Potsdamer_Mitte_22_04k.pdf
userdel	1::inwork -12659,-1700 -12730,-1681 -12758,-1654
EOF
     },
     { from  => 1366740818, # 2013-04-23 20:13
       until => 1380578399, # 2013-09-30 23:59
       text  => 'Fasanenstr. zwischen Hardenbergstr. und Kantstr. Baustelle, Stra�e gesperrt (bis Ende September 2013) ',
       type  => 'handicap',
       source_id => 'IM_019747',
       data  => <<EOF,
#: by: http://www.ihk-berlin.de/servicemarken/Zentrale_Dateien/829038/Anfahrt_zur_IHK_Berlin.html;jsessionid=1F11D2F501D14347C6E58B1211A79DC4.repl1 (confirmation)
#: note: nur einige Meter an der Hardenbergstr. scheinen gesperrt zu sein
userdel	q2::inwork 5268,11274 5247,10992
EOF
     },
     { from  => 1367100000, # 2013-04-28 00:00
       until => 1370815199, # 2013-06-09 23:59
       text  => 'Fahrbahnsanierung Cauerstra�e: Einbahnstra�e, offen in Richtung Otto-Suhr-Allee, auch Einschr�nkungen in der Guerickestra�e, von Montag, dem 29.04.2013, bis voraussichtlich Donnerstag, dem 09.06.2013',
       type  => 'handicap',
       source_id => 'http://www.berlin.de/ba-charlottenburg-wilmersdorf/presse/archiv/20130424.1240.383903.html',
       data  => <<EOF,
#: source_id: IM_019774 vvv
userdel	q4::inwork; 4359,11979 4441,12185 4518,12350 4598,12501
userdel auto	3 4601,12310 4518,12350 4358,12365
userdel auto	3 4358,12365 4518,12350 4601,12310
#: source_id ^^^
EOF
     },
     { from  => 1367314200, # 2013-04-30 11:30
       until => 1367431200, # 2013-05-01 20:00
       text  => 'DGB-Familienfest auf der Stra�e des 17. Juni, am 1. Mai 2013 von 11:30 bis 19:00',
       type  => 'gesperrt',
       source_id => 'http://berlin.dgb.de/extra/1-mai-2013-unser-tag',
       data  => <<EOF,
userdel	2::temp 8055,12186 8089,12190 8214,12205 8303,12216 8538,12245 8610,12254
userdel auto	3 8546,12279 8538,12245 8600,12165
userdel auto	3 8546,12279 8538,12245 8522,12239
userdel auto	3 8546,12279 8538,12245 8522,12187
userdel auto	3 8600,12165 8538,12245 8522,12187
userdel auto	3 8600,12165 8538,12245 8522,12239
userdel auto	3 8600,12165 8538,12245 8546,12279
userdel auto	3 8522,12187 8538,12245 8546,12279
userdel auto	3 8522,12187 8538,12245 8600,12165
userdel auto	3 8522,12187 8538,12245 8522,12239
userdel auto	3 8522,12239 8538,12245 8546,12279
userdel auto	3 8522,12239 8538,12245 8600,12165
userdel auto	3 8522,12239 8538,12245 8522,12187
EOF
     },
     { from  => undef, # 
       until => undef, # XXX
       text  => 'Richardstr.: Baustelle zwischen Richardplatz und Herrnhuter Weg, Fahrtrichtung gesperrt',
       type  => 'handicap',
       data  => <<EOF,
#: XXX bis wann ist die Baustelle fertig?
#: last_checked: 2013-05-06
#: XXX Stra�e wird asphaltiert (siehe auch Eintrag in fragezeichen-orig)
userdel	q4::inwork; 13288,7653 13245,7742 13226,7775 13150,7845 13103,7889
EOF
     },
     { from  => 1367560561, # 2013-05-03 07:56
       until => 1367791199, # 2013-05-05 23:59
       text  => 'Bahnhofstr. (Lichtenrade) zwischen Riedingerstr. und Goltzstr. Veranstaltung, Vollsperrung (bis Sonntag, 24:00)',
       type  => 'gesperrt',
       source_id => 'IM_019787',
       data  => <<EOF,
userdel	2::temp 10453,-2133 10509,-2131 10631,-2130 10747,-2129 10983,-2116
EOF
     },
     { from  => 1367560678, # 2013-05-03 07:57
       until => 1367704799, # 2013-05-04 23:59
       text  => 'Stra�e des 17. Juni: wegen des Berliner Frauenlaufs zwischen Gro�er Stern und Brandenburger Tor gesperrt',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/events/2101687-2229501-avonrunning-berliner-frauenlauf.html',
       data  => <<EOF,
userdel	2::temp 8610,12254 8538,12245 8303,12216 8214,12205 8089,12190 8055,12186 8119,12414
userdel	2::temp 6828,12031 7383,12095 7816,12150 8055,12186
userdel auto	3 7460,12054 7383,12095 7039,12314
userdel auto	3 8522,12187 8538,12245 8600,12165
userdel auto	3 8522,12187 8538,12245 8546,12279
userdel auto	3 8522,12187 8538,12245 8522,12239
userdel auto	3 7875,12363 7816,12150 7827,12105
userdel auto	3 8522,12239 8538,12245 8522,12187
userdel auto	3 8522,12239 8538,12245 8546,12279
userdel auto	3 8522,12239 8538,12245 8600,12165
userdel auto	3 8546,12279 8538,12245 8600,12165
userdel auto	3 8546,12279 8538,12245 8522,12239
userdel auto	3 8546,12279 8538,12245 8522,12187
userdel auto	3 8600,12165 8538,12245 8546,12279
userdel auto	3 8600,12165 8538,12245 8522,12239
userdel auto	3 8600,12165 8538,12245 8522,12187
userdel auto	3 7039,12314 7383,12095 7460,12054
userdel auto	3 7827,12105 7816,12150 7875,12363
EOF
     },
     { from  => 1367560778, # 2013-05-03 07:59
       until => 1367791199, # 2013-05-05 23:59
       periodic => 1,
       text  => 'Sch�neberger Mai- und Spargelfest am 04. und 05. Mai 2013 in der Freiherr-vom-Stein-Stra�e',
       type  => 'gesperrt',
       source_id => 'http://www.berlin.de/ba-tempelhof-schoeneberg/presse/archiv/20130419.1210.383671.html',
       data  => <<EOF,
userdel	2::temp 6244,8597 6339,8644 6454,8653
EOF
     },
     { from  => 1368334800, # 2013-05-12 07:00
       until => 1369620000, # 2013-05-27 04:00
       text  => 'M�ggelseedamm (Frieddrichshagen): Baustelle, stadtausw�rts zwischen B�lschestr. und Kalkseestr. bis Ende Mai 2013 gesperrt, 13.05.2013 07:00 Uhr bis 27.05.2013 04:00 Uhr ',
       type  => 'handicap',
       source_id => 'INKO_114312',
       data  => <<EOF,
userdel	q4::inwork; 25552,4829 25720,4832 25802,4823 25948,4823 26086,4861 26237,4922 26340,4942 26500,4936
EOF
     },
     { from  => undef, # 
       until => undef, # XXX
       text  => 'Tegeler Str.: zwischen Triftstr. und Schlegelstr. Bauarbeiten, Ausweichen auf den Gehweg',
       type  => 'handicap',
       data  => <<EOF,
#: last_checked: 2013-05-08
#: XXX wann sind die Bauarbeiten beendet?
userdel	q4::inwork; 7085,15226 7131,15109
EOF
     },
    );
