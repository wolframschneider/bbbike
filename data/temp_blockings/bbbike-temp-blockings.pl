# -*- bbbike -*-
# temp-blocking
# XXX undef old entries
# iso2epoch: date -j 2004MMDDhhmm +%s
#            date +%s
require Time::Local;
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
     { from  => 1115848800, # 2005-05-12 00:00
       until => 1116280616, # 2005-05-16 23:56
       text  => 'Stra�enfest rund um den Bl�cherplatz',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9522,10017 9811,10055
userdel	2 9522,10017 9444,10000
userdel	2 9592,10174 9812,10211
userdel	2 9401,10199 9592,10174
userdel	2 9579,10122 9536,10064
userdel	2 9579,10122 9689,10124
userdel	2 9827,10120 9811,10055
userdel	2 9827,10120 9849,10202
userdel auto	3 9593,10238 9592,10174 9579,10122
userdel auto	3 10002,9948 9811,10055 9837,9856
userdel auto	3 10002,9948 9811,10055 9689,10124
userdel auto	3 9837,9856 9811,10055 10002,9948
userdel auto	3 9837,9856 9811,10055 9689,10124
userdel auto	3 9689,10124 9811,10055 10002,9948
userdel auto	3 9689,10124 9811,10055 9837,9856
userdel auto	3 9579,10122 9592,10174 9593,10238
EOF
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,6-1,7,0,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,6-1,8,22,0,0)),
       file  => "karneval-der-kulturen.bbd",
       text  => "Karneval der Kulturen am 8.6. (Hasenheide - Gneisenaustr. - Yorckstr.)",
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
     { from  => Time::Local::timelocal(reverse(2005-1900,6-1,25,5,0,0)),
       until => Time::Local::timelocal(reverse(2005-1900,6-1,26,5,0,0)),
       file  => "csd.bbd",
       text  => "CSD am 25.6.",
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
     { from  => Time::Local::timelocal(reverse(2005-1900,6-1,25,6,0,0)),
       until => Time::Local::timelocal(reverse(2005-1900,6-1,27,1,0,0)),
       file  => "rheinstrassenfest.bbd",
       text  => "Rheinstra�enfest in der Rheinstra�e zwischen Breslauer Platz  und Walter-Schreiber-Platz. Dauer: 25.06.2005 06:00 Uhr bis 27.06.2005 01:00",
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
     { from  => 1063339200, # 2003-09-12 06:00
       until => 1063576800, # 2003-09-15 00:00
       file  => 'winzerfest.bbd',
       text  => 'Bahnhofstra�e, zwischen Goltzstra�e und Steinstra�e Vollsperrung, vom 13.09.2003, 06.00 Uhr bis 14.09.2003, 24.00 Uhr ',
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
     { from  => undef, # 
       until => Time::Local::timelocal(reverse(2005-1900,10-1,31,23,59,59)),
       text  => 'Schlichtallee zwischen Hauptstra�e und L�ckstra�e wegen Bauarbeiten gesperrt (bis 31.10.)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 15629,10481 15751,10582 16032,10842
EOF
     },
     { from  => 1070341200, # 2003-12-02 06:00
       until => 1070924399, # 2003-12-08 23:59
       file  => 'rixdorfer_weihnachtsmarkt.bbd',
       text  => 'Rixdorfer Weihnachtsmarkt',
       type  => 'gesperrt',
     },
     { from  => 1102672800, # 2004-12-10 11:00
       until => 1102805999, # 2004-12-11 23:59
       file  => 'spandauer_weihnachtsmarkt.bbd',
       text  => 'Spandauer Weihnachtsmarkt',
       type  => 'gesperrt',
     },
     { from  => 1070600400, # 2003-12-05 06:00
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
userdel	2 6446,11147 6168,11042
userdel	2 6446,11147 6582,11202
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
     { from  => 1112991869, # 2005-04-08 22:24
       until => 1113170400, # 2005-04-11 00:00
       text  => 'Turmstr. (Mitte) in beiden Richtungen zwischen Gotzkowskystr. und Stromstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 10.04.2005 ca. 24 Uhr)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 6113,13313 6247,13304
userdel	q4 5723,13346 5844,13334
userdel	q4 5723,13346 5565,13370
userdel	q4 5964,13324 5844,13334
userdel	q4 5388,13398 5565,13370
userdel	q4 6113,13313 6019,13320 5964,13324
EOF
     },
     { from  => Time::Local::timelocal(reverse(2004-1900,4-1,30,12,0,0)),
       until => Time::Local::timelocal(reverse(2004-1900,5-1,2,6,0,0)),
       file  => "kreuzberg-20020501.bbd",
       text  => "m�gliche Behinderungen zum 1. Mai in Kreuzberg",
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
userdel	2 7043,15793 7198,15656
userdel	2 7043,15793 6914,15908
userdel	2 7198,15656 7288,15579
userdel	2 6790,16018 6914,15908
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
userdel	2 7043,15793 7198,15656
userdel	2 7043,15793 6914,15908
userdel	2 7198,15656 7288,15579
userdel	2 6790,16018 6914,15908
EOF
     },
     { from  => 1084485600, # 2004-05-14 00:00
       until => 1084741200, # 2004-05-16 23:00
       file  => 'reichsstr.bbd',
       text  => 'Reichsstr. (Charlottenburg) in beiden Richtungen, zwischen Theodor-Heuss-Platz und Steubenplatz Veranstaltung, Stra�e vollst�ndig gesperrt (bis 16.05. 23 Uhr) Reichsstra�enfest',
       type  => 'gesperrt',
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
     { from  => 1086919200, # 2004-06-11 04:00
       until => 1087163999, # 2004-06-13 23:59
       file  => 'karlmarx.bbd',
       text  => 'Karl-Marx-Stra�e zwischen Flughafenstra�e und Uthmannstra�e sowie Erkstra�e zwischen Donaustra�e und Karl-Marx-Stra�e: Stra�enfest, Stra�en gesperrt, Dauer: 12.06.2004, 04.00 Uhr bis 13.06,24.00 Uhr. ',
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
     { from  => 1086818400, # 2004-06-10 00:00
       until => 1087164000, # 2004-06-14 00:00
       file  => 'bergmannstr.bbd',
       text  => 'Bergmannstra�enfest (Kreuzberg jazzt), Bergmannstr. zwischen Mehringdamm und Zossener Str. gesperrt, 11.06.2004, 7.00 Uhr bis 13.06.2004, 24.00 Uhr',
       type  => 'handicap',
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
     { from  => 1087509600, # 2004-06-18 00:00
       until => 1087767000, # 2004-06-20 23:30
       file  => 'badstr.bbd',
       text  => 'Badstr. (Wedding) in beiden Richtungen, zwischen Pankstr. und Behmstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 20.06. 23:30 Uhr) Seifenkistenrennen und Stra�enfest in der Badstr.',
       type  => 'gesperrt',
     },
     { from  => 1087462800, # 2004-06-17 11:00
       until => 1087765200, # 2004-06-20 23:00
       file  => 'motzstr.bbd',
       text  => 'NEW: Nollendorfplatz (Sch�neberg) Bereich Nollendorfplatz Veranstaltung (bis 20.06. 23 Uhr), Aufbau ab 18.06. 11 Uhr; 12. Lesbisch-schwules Stadtfest',
       type  => 'gesperrt',
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
userdel	2 6032,16698 5791,16910
userdel	2 6032,16698 6129,16611
userdel	2 6129,16611 6329,16438
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
userdel	2 22998,12453 22956,12669
userdel	2 22998,12453 23090,12302
EOF
     },
     { from  => undef,
       until => 1092439940,
       data => <<EOF,
userdel	2 9475,18617 9301,18722
userdel	2 9590,18548 9896,18343
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
userdel	q4 8194,25966 8182,25608
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
userdel	2 -21642,-16531 -21341,-17172
EOF
     },
     { from  => 1095717600, # 2004-09-21 00:00
       until => 1096149600, # 2004-09-26 00:00
       text  => 'L 88; (Beelitz-Lehnin); Bahn�bergang zw. Beelitz u. AS Beelitz-Heilst�tten Einbau Hilfsbr�cke Vollsperrung 22.09.2004-25.09.2004 ',
       type  => 'gesperrt',
      data  => <<EOF,
userdel	2 -21642,-16531 -21341,-17172
EOF
     },
     { from  => 1092866435, # 2004-08-19 00:00
       until => 1093989600, # 2004-09-01 00:00
       text  => 'B96A Berlin-Pankow, Sch�nholzer Stra�e - M�hlenstra�e, Oranienburg Richtung Berlin-Mitte, Zwischen Kreuzung Grabbeallee und Kreuzung Breite Stra�e Baustelle, gro�er Zeitverlust, lange Staus bis 31.08.2004 , eine Umleitung ist eingerichtet (Sperrung nur zwischen Wollankstra�e und Kreuzstra�e)',
       type  => 'handicap',
      data  => <<EOF,
userdel	q4 9909,18333 10089,18180
EOF
     },
     { from  => 1093125600, # 2004-08-22 00:00
       until => 1093125600, # 2004-08-28 00:00 removed
       text  => 'L 792; (Gro� Schulzendorf-Blankenfelde); OD Blankenfelde, Dorfstr. Stra�enbauarbeiten Vollsperrung 23.08.2004-27.08.2004 ',
       type  => 'handicap',
      data  => <<EOF,
userdel	q4 10023,-8859 10115,-8276
EOF
     },
     { from  => 1099177200, # 2004-10-31 01:00
       until => 1099522800, # 2004-11-04 00:00
       text  => 'L 142; (Kyritzer Stra�e); Klempnitzbr�cke in Wusterhausen Br�ckensanierung Vollsperrung 01.11.2004-03.11.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -54776,53333 -55166,53457
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
userdel	q4 -12325,-13958 -12177,-13787
EOF
     },
     { from  => undef, # 
       until => 1093376850, # 2004-08-26 12:00 fr�her
       text  => 'Bachstra�e: In beiden Richtungen St�rungen durch Rohrbruch, gesperrt bis Do 12:00 ',
       type  => 'handicap',
      data  => <<EOF,
userdel	q4 6040,12480 5874,12165 5798,12021
userdel	q4 5771,11887 5787,11966 5798,12021
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
userdel	q4 10023,-8859 10115,-8276
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
userdel	q4 33215,-85288 33412,-85191
userdel	q4 33215,-85288 33047,-85458
userdel	q4 33559,-85384 33412,-85191
userdel	q4 33559,-85384 33488,-85803
userdel	q4 33089,-85779 33047,-85458
EOF
     },
     { from  => 1096840800, # 2004-10-04 00:00
       until => 1099520857, # XXX siehe unten
       text  => 'B 167; zw. Bad Freienw. u. Falkenberg, H�he Papierfabrik Neubau von Durchl�ssen Vollsperrung 04.10.2004-unbekannt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 49039,44131 48583,44366
EOF
     },
     { from  => 1093496400, # 2004-08-26 07:00
       until => 1093716000, # 2004-08-28 20:00
       text  => 'Die Naumannstra�e ist zwischen Torgauer Stra�e und Tempelhofer Weg von 27.08.04, 07.00 Uhr bis 28.08.04, 20.00 Uhr gesperrt. Grund Bauarbeiten.',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 7716,8048 7717,7759
EOF
     },
     { from  => 1093730400, # 2004-08-29 00:00
       until => 1095397200, # 2004-09-17 07:00
       text  => 'Die Mohrenstra�e ist von der Charlottenstra�e in Richtung Friedrichstra�e wegen Kranarbeiten vom 30.08.2004 bis 17.09.2004 montags bis freitags jeweils in der Zeit von 07:00 Uhr bis 17:00 Uhr als Einbahnstra�e ausgewiesen.',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 9410,11803 9538,11818
EOF
     },
     { from  => 1093816800, # 2004-08-30 00:00
       until => 1098914400, # 2004-10-28 00:00
       text  => 'Oberwallstra�e, Baustelle, Stra�e gesperrt zwischen J�gerstra�e und Hausvogteiplatz, Dauer: 31.08.2004 bis 27.10.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9925,11947 9907,12055
EOF
     },
     { from  => 1093924800, # 2004-08-31 06:00
       until => 1098482400, # 2004-10-23 00:00
       text  => 'Gartenstra�e zwischen Invalidenstra�e und Bernauer Stra�e gesperrt, Baustelle, Einbahnstra�e in s�dlicher Richtung wird eingerichtet, zudem wird die Ackerstra�e zwischen Invalidenstra�e und Bernauer Stra�e gesperrt. Dauer: 01.09.2004, 06.00 Uhr bis 22.10.2004',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 9383,13978 9236,14157
userdel	1 9400,14400 9628,14215 9737,14126 9810,14066
EOF
     },
     { from  => 1093928400, # 2004-08-31 07:00
       until => 1094234400, # 2004-09-03 20:00
       text  => 'Dauer: 01.09.2004 07:00 Uhr bis 03.09.2004 20:00 Uhr. Rudower Chaussee, gesperrt von Agastra�e bis Gro�berliner Damm in Richtung Treptow',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 19732,3340 19581,3184 19495,3110
EOF
     },
     { from  => 1094083200, # 2004-09-02 02:00
       until => 1094428800, # 2004-09-06 02:00
       text  => 'Turmstra�e zwischen Kreuzung Beusselstra�e und Kreuzung Stromstra�e sowie Thusneldaallee: Stra�e gesperrt (Turmstra�enfest), Dauer: 03.09.2004 02:00 Uhr bis 06.09.2004 02:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 5256,13420 5388,13398 5565,13370 5723,13346 5844,13334 5964,13324 6019,13320 6113,13313 6247,13304
userdel	2 5975,13256 5964,13324
EOF
     },
     { from  => 1094097600, # 2004-09-02 06:00
       until => 1094248799, # 2004-09-03 23:59
       text  => 'Erkstra�e zwischen Kreuzung Karl-Marx-Stra�e und Kreuzung Sonnenallee Stra�e gesperrt (Spielfest), Dauer: 03.09.2004 06:00 Uhr bis 23:00 Uhr',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 12598,8390 12771,8439
userdel	2 12771,8439 12925,8494
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
userdel	2 -8879,-12309 -8457,-11261
EOF
     },
     { from  => 1094176800, # 2004-09-03 04:00
       until => 1094418000, # 2004-09-05 23:00
       text  => 'Hermannstra�enfest zwischen Flughafenstra�e und Thomasstra�e, Stra�e gesperrt, Dauer: 04.09.2004 04:00 Uhr bis 05.09.2004 23:00 Uhr',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 12180,7387 12122,7553
userdel	2 11920,8252 11933,8198
userdel	2 11920,8252 11892,8372
userdel	2 12041,7788 12055,7751 12075,7696
userdel	2 11979,8014 11960,8090
userdel	2 11979,8014 11998,7948 12025,7852
userdel	2 11933,8198 11960,8090
userdel	2 12075,7696 12090,7651 12122,7553
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
     { from  => undef, # 
       until => 1094421599, # 2004-09-05 23:59
       text  => 'Alt-Rudow in beiden Richtungen, zwischen Krokusstr. und Neudecker Weg Veranstaltung, Stra�e vollst�ndig gesperrt (bis 05.09. 24 Uhr), Rudower Meilenfest ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 16596,1730 16838,1457
userdel	2 16960,1282 16838,1457
EOF
     },
     { from  => undef, # 
       until => 1097791200, # 2004-10-15 00:00
       text  => 'L�ckstr. Richtung stadteinw�rts zwischen Schlichtallee und W�nnichstr. Baustelle, Stra�e gesperrt (bis Mitte 10.2004) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 16655,10622 16585,10650 16460,10699 16153,10818 16032,10842
EOF
     },
     { from  => 1094627730, # 2004-09-08 09:15
       until => 1096668000, # 2004-10-02 00:00
       text  => 'Gleim-Tunnel: Baustelle, Stra�e vollst�ndig gesperrt (bis 01.10.2004)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9917,15613 10122,15647
EOF
     },
     { from  => 1094421600, # 2004-09-06 00:00
       until => 1103151600, # 2004-12-16 00:00
       text  => 'K 7318; (Pinnow-L 24-Ha�leben); OD Buchholz Kanal- und Stra�enbau Vollsperrung 07.09.2004-15.12.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 32334,89385 31796,89304
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
userdel	2 8214,12205 8063,12182
userdel	2 8214,12205 8515,12242
userdel	2 8539,12286 8560,12326
userdel	2 8539,12286 8515,12242
userdel	2 8595,12066 8600,12165
userdel	2 8540,12420 8560,12326
userdel	2 8515,12242 8600,12165
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
userdel	q4 8493,25378 8370,25539
userdel	q4 8370,25539 8182,25608
EOF
     },
     { from  => 1105830000, # 2005-01-16 00:00
       until => 1116363037, # aufgehoben XXX 2005-05-28 00:00
       text  => 'K 6413; (Wriezener Stra�e); OL Buckow, zw. Weinbergsweg u. Ringstr. Kanal- u. Stra�enbau Vollsperrung 17.01.2005-27.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 55664,19342 55558,19957
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
userdel	2 2443,-6309 2715,-6365
EOF
     },
     { from  => 1096754400, # 2004-10-03 00:00
       until => 1103929200, # 2004-12-25 00:00
       text  => 'K 6907; (B 2-AS Ferch); OD Neuseddin Stra�enbauarbeiten Vollsperrung 04.10.2004-24.12.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -18080,-12637 -17374,-13449
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
userdel	q4 49039,44131 48583,44366
userdel	q4 49039,44131 49691,43812
EOF
     },
     { from  => 1096578452, # 2004-09-30 23:07
       until => 1096862400, # 2004-10-04 06:00
       text  => 'Str. des 17. Juni / Ebertstr. (Tiergarten) in beiden Richtungen zwischen Entlastungsstr. und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (Vorbereitung Tag der Deutschen Einheit) (bis 04.10.2004, 6 Uhr) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8063,12182 8214,12205
userdel	2 8214,12205 8515,12242
userdel	2 8539,12286 8515,12242
userdel	2 8600,12165 8515,12242
userdel	2 8515,12242 8610,12254
userdel	2 8539,12286 8560,12326 8540,12420 
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
userdel	q4 26650,-18150 26343,-18775
EOF
     },
     { from  => 1096754400, # 2004-10-03 00:00
       until => 1097877600, # 2004-10-16 00:00
       text  => 'L 78; (Potsdamer Str.); OD Saarmund, Eisenbahnbr�cke Br�ckensanierung Vollsperrung 04.10.2004-15.10.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -9626,-6603 -8492,-9628 -8331,-9887
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
userdel	q4 24200,72512 25875,71662
userdel	q4 28100,70162 26500,71425
userdel	q4 26500,71425 25875,71662
EOF
     },
     { from  => 1115503200, # 2005-05-08 00:00
       until => 1117576800, # 2005-06-01 00:00
       text  => 'L 34; (Philip-M�ller-Stra�e); OL Strausberg, zw. Feuerwehr und Nordkreuzung Fahrbahninstandsetzung halbseitig gesperrt; Einbahnstra�e 09.05.2005-31.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 43553,20466 43584,20871
userdel	q4 43553,20466 43110,19818
EOF
     },
     { from  => 1097177672, # 2004-10-07 21:34
       until => 1098050400, # 2004-10-18 00:00
       text  => 'Ruppiner Chaussee (Hennigsdorf) Kreuzung Hennigsdorfer Stra�e wegen Bauarbeiten gesperrt (bis 17.10.2004)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -1809,24343 -1214,23742
userdel	q4 -1809,24343 -1879,24174
userdel	q4 -1809,24343 -1912,24442
EOF
     },
     { from  => undef, # 
       until => 1097271072, # aufgehoben
       text  => 'Werner-Vo�-Damm (Tempelhof) in beidenRichtungen zwischen Boelckestra�e und B�umerplan Verkehrsbehinderung durch geplatzte Wasserleitung, Stra�e ind beiden Richtungen gesperrt.',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 8553,7795 8637,7871
userdel	q4 8553,7795 8512,7757
EOF
     },
     { from  => 1097359200, # 2004-10-10 00:00
       until => 1097877600, # 2004-10-16 00:00
       text  => 'L 30; (Sch�nower Chaussee); OD Bernau Baumf�llungen Vollsperrung 11.10.2004-15.10.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 21637,30946 20794,30899
userdel	q4 21637,30946 21955,30976
EOF
     },
     { from  => 1097208000, # 2004-10-08 06:00
       until => 1097442000, # 2004-10-10 23:00
       text  => 'Hauptstra�e, zwischen Kreuzung Dominicusstr. und Kreuzung Kaiser-Wilhelm-Platz K�rbisfest, Stra�e gesperrt, Dauer: 09.10.2004 06:00 Uhr bis 10.10.2004 23:00 Uhr ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 6698,8385 6990,8685 7009,8705 7201,8870 7275,8960
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
     { from  => 1109025830, # 2005-02-21 23:43
       until => 1113944974, # aufgehoben! 2005-04-30 23:59
       text  => 'Naumannstra�e zwischen Torgauer Str. und Tempelhofer Weg Br�ckenarbeiten, Stra�e vollst�ndig gesperrt (bis Ende 04/2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 7716,8048 7717,7759
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
     { from  => 1119904102, # 2005-06-27 22:28
       until => 1136069999, # 2005-12-31 23:59
       text  => 'Blankenburger Weg (Pankow) Richtung S�den zwischen Bahnhofstr. und Pasewalker Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 12442,20805 12030,20490
EOF
     },
     { from  => 1098309600, # 2004-10-21 00:00
       until => 1099427095, # 1101596400, 2004-11-28 00:00 => undef
       text  => 'B 109; (Templin-Zehdenick); Bahn�bergang s�dwestl.Ortsausg.Hammelspring Gleisbauarbeiten Vollsperrung 22.10.2004-27.11.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 10170,73230 8656,71489
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
userdel	q4 -1623,-21150 -1887,-21501
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
       until => 1135983600, # 2005-12-31 00:00
       text  => 'L 302; (Sch�neicher Str.); OL Sch�neiche, Dorfaue und R�dersdorfer Str. Kanal- und Stra�enbau Vollsperrung 12.04.2005-30.12.2005 ',
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
userdel	q4 21637,30946 20794,30899
userdel	q4 21637,30946 21955,30976
EOF
     },
     { from  => 1098568800, # 2004-10-24 00:00
       until => 1101855600, # 2004-12-01 00:00
       text  => 'L 792; Trebbiner Str.-Glasower Damm: Stra�enbau, Vollsperrung, 25.10.2004-30.11.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 11186,-5297 10994,-5361
EOF
     },
     { from  => 1098914007, # 2004-10-27 23:53
       until => 1101769140, # 200411292359
       text  => 'Gleimstr. (Mitte) in beiden Richtungen zwischen Gleimtunnel und Graunstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 29.11.2004)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9917,15613 10122,15647
EOF
     },
     { from  => 1098828000, # 2004-10-27 00:00
       until => 1103410800, # 2004-12-19 00:00
       text  => 'L 171; (Hohen Neuendorf-Hennigsdorf); Bereich Anschlu�stelle Stra�enbau Vollsperrung 28.10.2004-18.12.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -926,27132 -2118,26060
EOF
     },
     { from  => 1099177200, # 2004-10-31 01:00
       until => 1101078000, # 2004-11-22 00:00
       text  => 'L 200; (Breite Str.); OD Eberswalde, zw. B� und Neue Str. Stra�enbauarbeiten, Vollsperrung 01.11.2004-21.11.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 38264,50086 38035,49183
userdel	q4 38264,50086 38864,51295
EOF
     },
     { from  => 1101942000, # 2004-12-03 06:00
       until => 1102287540, # 2004-12-05 23:59
       file  => 'rixdorfer_weihnachtsmarkt.bbd',
       text  => 'Rixdorfer Weihnachtsmarkt, 03.12.2004-05.12.2004',
       type  => 'gesperrt',
     },
     { from  => 1100038749, # 2004-11-09 23:19
       until => 1100559600, # 2004-11-16 00:00
       text  => 'Lenn�str. zwischen Bellvuestr. und Eberstr. Baustelle, Stra�e gesperrt Richtung Ebertstr. (bis 15.11.2004) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8489,11782 8436,11766 8326,11732
userdel	2 8326,11732 8223,11700
EOF
     },
     { from  => 1092520800, # 2004-08-15 00:00
       until => 1104620400, # 2005-01-02 00:00
       text  => 'L 21; (M�hlenbecker Str.); OL Schildow grundh. Stra�enbau Vollsperrung 16.08.2004-01.01.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 8231,26584 8194,25966
EOF
     },
     { from  => 1099177200, # 2004-10-31 01:00
       until => 1123884000, # 2005-08-13 00:00
       text  => 'L 401; (Lindenallee, Fontaneallee); OL Zeuthen, zw. Forstweg und F�hrstr. grundhafter Stra�enbau Vollsperrung 01.11.2004-12.08.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 26581,-7087 26146,-6218
EOF
     },
     { from  => 1089496800, # 2004-07-11 00:00
       until => 1114898400, # 2005-05-01 00:00
       text  => 'K 6740; (L 38 �stl. Berkenbr�ck-Steinh�fel); OL Demnitz Stra�enbauarbeiten Vollsperrung 12.07.2004-30.04.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 64514,-1544 64439,-1243
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
userdel	2 -13743,20218 -13887,20543 -13941,20658
EOF
     },
     { from  => 1100559600, # 2004-11-16 00:00
       until => 1103583600, # 2004-12-21 00:00
       text  => 'L 23; (Templin-Lychen); OD Lychen Stra�enbau Vollsperrung 17.11.2004-20.12.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 3125,88753 2788,89447
EOF
     },
     { from  => 1116572111, # 2005-05-20 08:55
       until => 1116885600, # 2005-05-24 00:00
       text  => 'Volksradstr. (Friedrichsfelde) in beiden Richtungen Baustelle, Stra�e vollst�ndig gesperrt (bis 23.05.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 17475,10442 17565,10782 17621,10994
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
userdel	q4; 8595,12066 8581,11896 8571,11846
EOF
     },
     { from  => 1101337200, # 2004-11-25 00:00
       until => 1102374000, # 2004-12-07 00:00
       text  => 'B 167; (Zerpenschleuse-Liebenwalde); zw. OA Liebenwalde und Abzw. Hammer Erneuerung Durchlass Vollsperrung 26.11.2004-06.12.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 11228,52175 9686,52037
EOF
     },
     { from  => 1085263200, # 2004-05-23 00:00
       until => 1103583600, # 2004-12-21 00:00
       text  => 'L 75; (Karl-Marx-Stra�e); OD Gro�ziethen, von Dorfstra�e bis Friedhofsweg Stra�enbauarbeiten Vollsperrung 24.05.2004-20.12.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 13225,-681 13309,-1268
EOF
     },
     { from  => 1102654800, # 2004-12-10 06:00
       until => 1102892400, # 2004-12-13 00:00
       text  => 'Sophienstra�e, zwischen Gro�e Hamburger Stra�e und Rosenthaler Stra�e, f�r den Fahrzeugverkehr gesperrt (9. Umwelt- und Weihnachtsmarkt). Dauer: 11.12.2004 06:00 Uhr bis 12.12.2004 24:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9982,13411 10312,13231
EOF
     },
     { from  => 1102050000, # 2004-12-03 06:00
       until => 1102204800, # 2004-12-05 01:00
       text  => 'Bahnhofstr. zwischen Goltzstr. und Steinstra�e Weihnachstsmarkt, in beiden Richtungen gesperrt. Dauer: 04.12.2004, 06:00 Uhr bis 05.12.2004, 01:00 Uhr',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 10453,-2133 10747,-2129
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
userdel	2 -37026,11176 -36427,10861
EOF
     },
     { from  => 1102981307, # 2004-12-14 00:41
       until => 1103324400, # 2004-12-18 00:00
       text  => 'Emmentaler Str. (Reinickendorf) Richtung Westen zwischen Residenzstr. und Gamsbartweg Baustelle, Stra�e Richtung Westen gesperrt, Einbahnstra�enregelung Richtung Osten (bis 17.12.2004)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	q4; 7693,18481 7350,18262
EOF
     },
     { from  => 1101934006, # 2004-12-01 21:46
       until => 1114976619, # aufgehoben XXX 1117576800 2005-06-01 00:00
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
       until => 1122058621, # nicht mehr XXX
       text  => 'Johannisthaler Chaussee Zwischen Rudower Stra�e und K�nigsheideweg beidseitig Br�ckenarbeiten, gesperrt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15573,4122 15608,4175
userdel	2 15669,4266 15608,4175
EOF
     },
     { from  => 1102712612, # 2004-12-10 22:03
       until => 1102910400, # 2004-12-13 05:00
       text  => 'Schulze-Boysen-Str. (Lichtenberg) in beiden Richtungen zwischen Wiesenweg und Pfarrstr. Kranarbeiten, Stra�e vollst�ndig gesperrt (bis 13.12.2004 ca. 5:00 Uhr)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15452,11330 15480,11392
EOF
     },
     { from  => 1105225200, # 2005-01-09 00:00
       until => 1122406057, # 1122760800 2005-07-31 00:00
       text  => 'K 6938; (G�rzke-Hohenlobbese); zw. OL G�rzke und Abzw. Reppinichen, Br�cke Br�cken- und Stra�enbau Vollsperrung 10.01.2005-30.07.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -59599,-27568 -59265,-27286
EOF
     },
     { from  => 1102980646, # 2004-12-14 00:30
       until => 1104015600, # 2004-12-26 00:00
       text  => 'Weihnachtsmarkt am Opernpalais, bis 25.12.2004',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9890,12161 9875,12254 9853,12402
userdel	2 9801,12245 9782,12393
EOF
     },
     { from  => 1102980716, # 2004-12-14 00:31
       until => 1104015600, # 2004-12-26 00:00
       text  => 'Weihnachtsmarkt am Schlo�platz, bis 25.12.2004',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 10170,12261 10083,12442
EOF
     },
     { from  => undef, # 
       until => 1105275551, # wann wurde das hier aufgehoben?
       text  => 'Aufgrund eines Motorschaden ist der F�hrverkehr zwischen Ketzin und Schmergow bis auf weiteres eingestellt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -26784,5756 -26840,5684
EOF
     },
     { from  => 1104409481, # 2004-12-30 13:24
       until => 1104573600, # 2005-01-01 11:00
       text  => 'Str. des 17. Juni: Gro�er Stern - Brandenburger Tor (Mitte) in allen Richtungen sowie angrenzende Nebenstra�en Veranstaltung, Stra�e vollst�ndig gesperrt (bis 01.01.2005 ca. 11:00 Uhr)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 8214,12205 8063,12182
userdel	q4 8214,12205 8515,12242
userdel	q4 6653,12067 6642,12010
userdel	q4 6685,11954 6744,11936
userdel	q4 8610,12254 8515,12242
userdel	q4 7816,12150 8063,12182
userdel	q4 7816,12150 7383,12095
userdel	q4 6744,11936 6809,11979
userdel	q4 8851,12123 8737,12098
userdel	q4 6809,11979 6828,12031
userdel	q4 8539,12286 8560,12326
userdel	q4 8539,12286 8515,12242
userdel	q4 6828,12031 7383,12095
userdel	q4 6828,12031 6799,12083
userdel	q4 8775,12457 8540,12420
userdel	q4 8737,12098 8595,12066
userdel	q4 6642,12010 5901,11902
userdel	q4 6642,12010 6685,11954
userdel	q4 8595,12066 8600,12165
userdel	q4 8540,12420 8560,12326
userdel	q4 8515,12242 8600,12165
userdel	q4 6725,12113 6653,12067
userdel	q4 6799,12083 6725,12113
EOF
     },
     { from  => 1105311600, # 2005-01-10 00:00
       until => 1105830000, # 2005-01-16 00:00
       text  => 'K 6304; (Priorter Chaussee); OD Priort, Bahn�bergang Gleisbauarbeiten Vollsperrung 11.01.2005-15.01.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -19149,11495 -18916,11666
EOF
     },
     { from  => 1106434800, # 2005-01-23 00:00
       until => 1106780400, # 2005-01-27 00:00
       text  => 'L 62; (Elsterwerda-Hohenleipisch); Bahn�bergang bei Dreska Gleisbauarbeiten Vollsperrung 24.01.2005-26.01.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 22508,-102744 22382,-102254
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
userdel	q4 25185,-3955 23463,-4466
EOF
     },
     { from  => 1107475200, # 2005-02-04 01:00
       until => 1107741600, # 2005-02-07 03:00
       text  => 'Berliner Stra�e, Zwischen Kreuzung Granitzstra�e und Florastr. in beiden Richtungen Br�ckenarbeiten, gesperrt, Dauer: 05.02.2005 01:00 Uhr bis 07.02.2005 03:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 10846,17992 10859,17854
EOF
     },
     { from  => 1075827600, # 2004-02-03 18:00
       until => 1107748800, # 2005-02-07 05:00
       text  => 'Blockdammweg in Richtung K�penicker Chaussee ab H�nower Wiesenweg gesperrt (Arbeiten an Gasleitung). Dauer: 04.02.2004 18:00 Uhr bis 07.02.2005 05:00 Uhr ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 17375,8847 17072,8714
EOF
     },
     { from  => 1107730800, # 2005-02-07 00:00
       until => 1108681200, # 2005-02-18 00:00
       text  => 'K 6148; (Brand-Halbe); Bahn�bergang in OL Teurow Arbeiten an Signaltechnik Vollsperrung 08.02.2005-17.02.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 32937,-34794 32747,-34772
EOF
     },
     { from  => 1108854000, # 2005-02-20 00:00
       until => 1109199600, # 2005-02-24 00:00
       text  => 'L 62; (Elsterwerda-Hohenleipisch); Bahn�bergang bei Dreska Gleisbauarbeiten Vollsperrung 21.02.2005-23.02.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 22508,-102744 22382,-102254
EOF
     },
     { from  => 1108249200, # 2005-02-13 00:00
       until => 1110145553, # XXX not anymore, was 1114898400 2005-05-01 00:00
       text  => 'Im Zeitraum vom 14.02.2005 bis 30.04.2005 besteht f�r die L 73 zwischen Langerwisch und Wildenbruch Vollsperrung auf Grund von Bauarbeiten. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -12156,-13509 -12221,-13124
userdel	2 -12156,-13509 -12177,-13787
userdel	2 -12372,-12676 -12221,-13124
userdel	2 -12372,-12676 -12443,-12223 -12459,-12120
userdel	2 -12337,-10735 -12433,-11898 -12459,-12120
EOF
     },
     { from  => 1108684644, # 2005-02-18 00:57
       until => 1122847199, # 2005-07-31 23:59
       text  => 'F�rstenwalder Damm zwischen B�lschestr. und Stillerzeile Baustelle, Stra�e stadteinw�rts gesperrt (bis Ende 07.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q3; 25579,5980 25121,5799
EOF
     },
     { from  => 1108681200, # 2005-02-18 00:00
       until => 1109372400, # 2005-02-26 00:00
       text  => 'L 791; (Luckenwalder Str.); Bahn�bergang in Zossen, Havarie, Vollsperrung, 19.02.2005-25.02.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 13557,-21831 13014,-22300
userdel	2 13557,-21831 13988,-21217
EOF
     },
     { from  => 1109280022, # 2005-02-24 22:20
       until => 1109631600, # 2005-03-01 00:00
       text  => 'Sp�thstra�e (Treptow) In beiden Richtungen zwischen A113 und K�nigsheideweg St�rungen durch geplatzte Wasserleitung, Stra�e gesperrt (bis 28.02.2005) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 14705,5176 14994,5193
userdel	2 14994,5193 15174,5463
userdel	2 15174,5463 15382,5687
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
       text  => 'B 179; (Berliner Str.); OL K�nigs Wusterhausen, zw. Schlo�platz u. Funkerberg Kanalarbeiten halbseitig gesperrt (XXX welche Richtung?); Einbahnstra�e 01.03.2005-30.09.2005 ',
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
userdel	q4; 9112,14771 9472,14478
EOF
     },
     { from  => 1109628414, # 2005-02-28 23:06
       until => 1136069999, # 2005-12-31 23:59
       text  => 'Ringstr. (Steglitz) Richtung Finkensteinallee zwischen Drakestr. und Finckensteinallee Baustelle, Fahrtrichtung gesperrt (bis 12.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 3507,3635 3375,3544 3184,3413 3050,3316 2701,3064 2639,2989 2638,2843
EOF
     },
     { from  => 1110917391, # 2005-03-15 21:09
       until => 1111100400, # 2005-03-18 00:00
       text  => 'Augsburger Str. (Charlottenburg) in beiden Richtungen zwischen Joachimstaler Str. und Rankestr. Baustelle, Stra�e vollst�ndig gesperrt (Kranarbeiten) (bis 17.03.2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 5636,10626 5479,10719
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
userdel	q4 -16605,-14239 -17374,-13449
userdel	q4 -18080,-12637 -17374,-13449
EOF
     },
     { from  => 1111437775, # 2005-03-21 21:42
       until => 1111705200, # 2005-03-25 00:00
       text  => 'Sterndamm (Treptow) in Richtung Rudow zwischen K�nigsheideweg und Winckelmannstr. Baustelle, Fahrtrichtung gesperrt, eine Umleitung ist eingerichtet (bis 24.03.2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 17518,4644 17428,4503
EOF
     },
     { from  => 1110235074, # 2005-03-07 23:37
       until => 1110317384, # XXX handicap now, was: 1125525600 2005-09-01 00:00
       text  => 'Unter den Linden (Mitte) Richtung Westen zwischen Schadowstr. und Wilhelmstr. Baustelle, Stra�e vollst�ndig gesperrt (bis August 2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 9028,12307 8804,12280
EOF
     },
     { from  => 1123619410, # 2005-08-09 22:30
       until => 1124488800, # 2005-08-20 00:00
       text  => 'Dahlwitzer Landstr. - B�lschestr. (K�penick) in beiden Richtungen an der Bahnbr�cke B�lschestr. Baustelle, Stra�e vollst�ndig gesperrt (Br�cken- und Stra�enarbeiten) (bis 19.08.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 25585,6050 25579,5980
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
userdel	q4 22449,1281 22217,1108
userdel	q4 22449,1281 22663,1441
userdel	q4 22217,1108 22162,1067
EOF
     },
     { from  => 1110862800, # 2005-03-15 06:00
       until => 1111013999, # 2005-03-16 23:59
       text  => 'Kantstra�e Richtung Spandau: Zwischen Kreuzung Hardenbergstra�e und Kreuzung Joachimstaler Stra�e gesperrt, Dauer: 16.03.2005 06:00 Uhr bis 16:00 Uhr (Filmarbeiten) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 5652,11004 5613,10963 5505,10971
EOF
     },
     { from  => 1110700800, # 2005-03-13 09:00
       until => 1111168800, # 2005-03-18 19:00
       text  => 'Die Stadthausstra�e ist zwischen T�rschmidtstra�e und Archibaldweg gesperrt. Grund Bauarbeiten. Dauer: 14.03.05, 09.00 Uhr bis 18.03.05, 19.00 Uhr. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15657,10846 15628,10915
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
userdel	q4 8066,25646 8182,25608
EOF
     },
     { from  => 1111439519, # 2005-03-21 22:11
       until => 1191189599, # 2007-09-30 23:59
       text  => 'Nennhauser Damm (Spandau) stadteinw�rts zwischen Heerstr. und D�beritzer Weg Baustelle, Fahrtrichtung gesperrt (bis 09.2007)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 -8749,13269 -8662,13322 -8365,13294 -8014,13292
EOF
     },
     { from  => 1111524913, # 2005-03-22 21:55
       until => 1120168800, # 2005-07-01 00:00
       text  => 'Pistoriusstr. (Weissensee) Richtung Berliner Allee zwischen Mirbachplatz und Parkstr. Baustelle, Fahrtrichtung gesperrt (bis 30.06.2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 13386,16408 13652,16297 13797,16237
EOF
     },
     { from  => 1111960800, # 2005-03-28 00:00
       until => 1119477600, # 2005-06-23 00:00
       text  => 'B 2; (Bernau-Biesenthal); B 2, OD R�dnitz grundh. Ausbau, Bau Kreisverk. Vollsperrung 29.03.2005-22.06.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 25095,35601 24915,35340
EOF
     },
     { from  => 1111960800, # 2005-03-28 00:00
       until => 1120428000, # 2005-07-04 00:00
       text  => 'L 23; (Joachimsthal-Templin); OD Joachimsthal Neubau Durchlass Vollsperrung 29.03.2005-03.07.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 32966,64019 33099,63917 33254,63446
EOF
     },
     { from  => 1111532400, # 2005-03-23 00:00
       until => 1114898400, # 2005-05-01 00:00
       text  => 'L 291; (Oderberger Str.); OD Eberswalde, Einm. Breite Str. Stra�enbauarbeiten Vollsperrung 24.03.2005-30.04.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 38035,49183 37900,48350 37875,48253
EOF
     },
     { from  => 1111960800, # 2005-03-28 00:00
       until => 1115157600, # 2005-05-04 00:00
       text  => 'L 23; (Templin-Lychen); OD Lychen, Kreuzungsber. Stra�enbau Vollsperrung 29.03.2005-03.05.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	q4 3125,88753 2788,89447
EOF
     },
     { from  => 1113084000, # 2005-04-10 00:00
       until => 1113602400, # 2005-04-16 00:00
       text  => 'L 622; (R�ckersdorf-Doberlug Kirchhain); s�dl. Doberlug-Kirchhain, H�he Hammerteich Baumf�llarbeiten Vollsperrung 11.04.2005-15.04.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 22495,-89358 22558,-89699
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
userdel	2 -3880,13032 -3796,13312
userdel	2 -3880,13032 -3944,12929 -4025,12801
userdel	2 -4025,12801 -4137,12651
EOF
     },
     { from  => 1111960800, # 2005-03-28 00:00
       until => 1133391600, # 2005-12-01 00:00
       text  => 'B 2; (Leipziger Str.); OD Treuenbrietzen, zw. Krz.Leipz.-/Belziger Str. u. Hinter d.Mauer Stra�enbau, KVK Vollsperrung 29.03.2005-30.11.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -25472,-35585 -24967,-35112
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
       until => undef, # XXX
       text  => 'L 711; (Krausnick-AS Stakow); zw. Krausnick u. Bahnhof Brand Einschr�nkung Tragf�higkeit Vollsperrung, Dauer unbekannt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 35178,-41015 37450,-41050 37950,-41275 38512,-41000 40398,-40989
EOF
     },
     { from  => 1113256800, # 2005-04-12 00:00
       until => 1113688800, # 2005-04-17 00:00
       text  => 'L 30; (Bernauer Str.); OL Altlandsberg zw. Strausberger Str. u. Buchholzer Str. Kanalarbeiten Vollsperrung 13.04.2005-16.04.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 32665,17841 32985,17127 33589,15778
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
userdel	q4; 21093,9179 21351,9066
EOF
     },
     { from  => 1118872800, # 2005-06-16 00:00
       until => 1123538400, # 2005-08-09 00:00
       text  => 'B 101; (Berliner Str.); OD Trebbin Stra�enbauarbeiten Vollsperrung bis 08.08.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -1623,-21150 -1887,-21501
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
userdel	q4 -16640,1304 -15527,795
userdel	q4 -16640,1304 -16894,1485
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
userdel	q4; 10534,14460 10723,14772
EOF
     },
     { from  => 1113714000, # 2005-04-17 07:00
       until => 1114034400, # 2005-04-21 00:00
       text  => 'Kronenstra�e (Mitte) in beiden Richtungen, zwischen Charlottenstra�e und Markgrafenstra�e Kranarbeiten, Stra�e gesperrt, Dauer: 18.04.2005, 07.00 Uhr bis 20.04.2005',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 9569,11631 9701,11649
EOF
     },
     { from  => 1113870146, # 2005-04-19 02:22
       until => 1114553274, # XXX ich konnte aus der S-Bahn heraus nichts erkennen 2005-12-31 23:59
       text  => 'Rosa-Luxemburg-Str. (Mitte) Richtung stadtausw�rts, zwischen Memhardstr. und Torstr. Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 2005) Umleitung �ber Karl-Liebknecht-Stra�e - Torstra�e',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 10755,13152 10846,13362 10790,13565 10777,13614 10746,13673
EOF
     },
     { from  => 1112220000, # 2005-03-31 00:00
       until => 1115244000, # 2005-05-05 00:00
       text  => 'B 101; (Luckenwalder-, Berliner Str.); OD Trebbin, Knoten Beelitzer Str. Stra�enbauarbeiten Vollsperrung 01.04.2005-04.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -1887,-21501 -1992,-21489
EOF
     },
     { from  => 1114468172, # 2005-04-26 00:29
       until => 1136069999, # 2005-12-31 23:59
       text  => 'Berliner Allee Richtung stadtauw�rts, zwischen Langhanstr. und Lindenallee Baustelle, Fahrtrichtung gesperrt (bis Ende 2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 13540,15928 13751,16009 14014,16106 14067,16127 14371,16252
EOF
     },
     { from  => 1114468319, # 2005-04-26 00:31
       until => 1136069999, # 2005-12-31 23:59
       text  => 'Vulkanstr. in Richtung Herzbergstr. Baustelle, Einbahnstra�e in Richtung Landsberger Allee (bis Ende 2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 15838,14319 15873,14046 15880,13535
EOF
     },
     { from  => 1114466400, # 2005-04-26 00:00
       until => 1136070000, # 2006-01-01 00:00
       text  => 'B 1; (Potsdamer Str.); OD Gro� Kreutz Kanal- und Stra�enbau Vollsperrung 27.04.2005-31.12.2005 ',
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
userdel	2 27543,-11912 27657,-11741
EOF
     },
     { from  => 1122760800, # 2005-07-31 00:00
       until => 1124056800, # 2005-08-15 00:00
       text  => 'B 179; (Cottbuser-/ Fichtestr.); OL K�nigs Wusterhausen, Bahn�bergang Fichtestr. Umbau Bahn�bergang Vollsp * 01.08.2005-14.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26313,-13049 26028,-12312
EOF
     },
     { from  => 1114725600, # 2005-04-29 00:00
       until => 1114984800, # 2005-05-02 00:00
       text  => 'B 198; (Schwedter Str.); OD Prenzlau, Kno. Uckermarkkaserne Ausbau Knotenpunkt Vollsperrung 30.04.2005-01.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 40864,100741 40507,100965
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
userdel	q4 1453,-746 1550,-761 1709,-953
userdel	q4 1916,-1090 1709,-953
EOF
     },
     { from  => 1115589537, # 2005-05-08 23:58
       until => 1126821599, # 2005-09-15 23:59
       text  => 'Danziger Str. (Prenzlauer Berg) Richtung Osten zwischen Sch�nhauser Allee und Knaackstr. Baustelle Fahrtrichtung gesperrt, Umleitung: Sch�nhauser Allee - Sredzkistr. - Knaackstr. (bis Mitte 09.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 10889,15045 11056,15009
EOF
     },
     { from  => 1115535600, # 2005-05-08 09:00
       until => 1118354400, # 2005-06-10 00:00
       text  => 'Rosenfelder Stra�e Richtung Frankfurter Allee zwischen Skandinavische Stra�e und Frankfurter Allee Baustelle, Stra�e gesperrt, Dauer: 09.05.2005, 09.00 Uhr bis 09.06.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 17363,11972 17249,11802
EOF
     },
     { from  => 1116280800, # 2005-05-17 00:00
       until => 1141167600, # 2006-03-01 00:00
       text  => 'B 115; (Forster Str.); OD D�bern grundhafter Stra�enausbau Vollsperrung 18.05.2005-28.02.2006 ',
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
userdel	q4 55393,-4240 55563,-4690
EOF
     },
     { from  => 1117080000, # 2005-05-26 06:00
       until => 1117490400, # 2005-05-31 00:00
       text  => 'Luxemburger Stra�e - F�hrer Stra�e, Zwischen Kreuzung Leopoldplatz und Kreuzung Amrumer Stra�e Veranstaltung, Stra�e gesperrt, Dauer: 27.05.2005 06:00 Uhr bis 30.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 7162,15436 7020,15314
userdel	q4 7162,15436 7288,15579
userdel	q4 6647,15094 6737,15133
userdel	q4 6737,15133 7020,15314
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
userdel	2 15403,40364 14713,40426
EOF
     },
     { from  => 1117317600, # 2005-05-29 00:00
       until => 1126821600, # 2005-09-16 00:00
       text  => 'K 7330; (L 23 n�rdl. Templin-Gandenitz); OD Gandenitz Kanal- und Stra�enbau Vollsperrung 30.05.2005-15.09.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 11401,84932 11423,85183
EOF
     },
     { from  => 1118091230, # 2005-06-06 22:53
       until => 1136069999, # 2005-12-31 23:59
       text  => 'Bouch�stra�e (Treptow) in beiden Richtungen zwischen Kiefholzstra�e und Am Treptower Park Fahrbahnerneuerung, Stra�e vollst�ndig gesperrt (bis Ende 2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 13867,9864 13601,9572
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
       until => 1129327200, # 2005-10-15 00:00
       text  => 'L 216; (Gollin-Templin); OD Vietmannsdorf, Br�cke �ber M�hlengraben Br�ckenneubau Vollsperrung 13.06.2005-14.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 17636,72217 17653,71852
EOF
     },
     { from  => 1118959200, # 2005-06-17 00:00
       until => 1119132000, # 2005-06-19 00:00
       text  => 'L 23; (M�hlenstr.); OD Templin, zw. Heinestr. und M.-Luther-Str. 16. Stadtfest Vollsperrung 18.06.2005-18.06.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 15448,79614 15840,79375
EOF
     },
     { from  => 1118527200, # 2005-06-12 00:00
       until => 1119650399, # 2005-06-24 23:59
       text  => 'Zimmerstra�e Richtung Charlottenstra�e zwischen Friedrichstra�e und Charlottenstra�e Kranarbeiten, gesperrt bis 24.06.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 9473,11316 9603,11328
EOF
     },
     { from  => 1119240000, # 2005-06-20 06:00
       until => 1119412800, # 2005-06-22 06:00
       text  => '"Bridge Partie", Modersohnbr�cke von 21.06.2005, 06.00 Uhr bis 22.06.2005, 06:00 Uhr gesperrt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 14026,10869 14139,11269
EOF
     },
     { from  => 1118949539, # 2005-06-16 21:18
       until => 1120068000, # 2005-06-29 20:00
       text  => 'Franz�sische Str. ab Markgrafenstr., Werderscher Markt, Breite Str. gesperrt. Dauer: bis 29.06.2005, 20:00 Uhr. (Beachvolleyball) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9636,12126 9756,12139 9812,12145
userdel	2 10084,12228 9959,12180
userdel	2 9812,12145 9890,12161
userdel	2 9890,12161 9959,12180
userdel	2 10170,12261 10109,12238
userdel	2 10170,12261 10267,12305
EOF
     },
     { from  => 1118988173, # 2005-06-17 08:02
       until => 1119218400, # 2005-06-20 00:00
       text  => '300 Jahre Charlottenburg, 17.06.2005 bis 19.06.2005',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 3076,12192 3038,12482
userdel	2 3076,12192 3091,12071
userdel	2 3038,12482 2647,12427
userdel	2 3038,12482 3280,12512
userdel	2 3103,11968 3091,12071
userdel auto	3 3365,12231 3076,12192 2902,12183
userdel auto	3 2902,12183 3076,12192 3365,12231
EOF
     },
     { from  => 1120180333, # undef XXX 2005-07-07 00:00
       until => 1120180333, # undef XXX 2005-07-10 00:00
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
userdel	2 22138,4661 22111,4562
userdel	2 22138,4661 22196,4847
userdel	2 22111,4562 22162,4546
userdel	2 22111,4562 22093,4499
userdel	2 22147,4831 22043,4562
userdel	2 22383,4703 22312,4593
userdel	2 22312,4593 22162,4546
userdel	2 22043,4562 22071,4501
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
userdel	q4 53810,-90698 53805,-90240
userdel	q4 53252,-90440 53805,-90240
EOF
     },
     { from  => 1119736800, # 2005-06-26 00:00
       until => 1129240800, # 2005-10-14 00:00
       text  => 'Kreisverkehr bei Hennigsdorf Stra�enbau Vollsperrung 27.06.2005-13.10.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -2800,25478 -2446,25386
EOF
     },
     { from  => 1119736800, # 2005-06-26 00:00
       until => 1121117530, # 1121119200 2005-07-12 00:00
       text  => 'L 26; (L�cknitz MVP-LG-Br�ssow); zw. LG und Kno. Wollschow Deckeneinbau Vollsperrung 27.06.2005-11.07.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 61780,112606 61784,112969
EOF
     },
     { from  => 1119697095, # 2005-06-25 12:58
       until => 1136069999, # 2005-12-31 23:59
       text  => 'Dorotheenstr. Richtung Osten zwischen Wilhelmstr. und Schadowstr. sowie Schadowstr. Richtung Unter den Linden gesperrt (bis Ende 2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 8775,12457 8907,12472 9008,12485
userdel	q4; 9008,12485 9018,12400 9028,12307
EOF
     },
     { from  => 1119909600, # 2005-06-28 00:00
       until => 1124575200, # 2005-08-21 00:00
       text  => 'L 793; (Sch�nhagen-Ludwigsfelde); zw. Abzw. Gr�ben und Siethen Stra�enbauarbeiten Vollsperrung 29.06.2005-20.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -2542,-13926 -3801,-14252
EOF
     },
     { from  => 1119909600, # 2005-06-28 00:00
       until => 1124575200, # 2005-08-21 00:00
       text  => 'L 793; (Sch�nhagen-Ludwigsfelde); zw. OD J�tchendorf und Abzw. Gr�ben Stra�enbauarbeiten Vollsperrung 29.06.2005-20.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -3694,-14508 -4077,-14595
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
userdel	2 7816,12150 8063,12182
userdel auto	3 7663,11946 7460,12054 7383,12095 7039,12314
userdel auto	3 7039,12314 7383,12095 7460,12054 7663,11946
EOF
     },
     { from  => 1120086052, # 2005-06-30 01:00
       until => 1136069999, # 2005-12-31 23:59
       text  => 'Rosa-Luxemburg-Str. zwischen Torstr. und Memhardstr. Baustelle, Einbahnstra�e in Richtung Alexanderplatz, (bis Ende 2005) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 10846,13362 10790,13565
	3 10757,13401 10846,13362 10923,13317
	3 10923,13317 10846,13362 10757,13401
	3 10969,13430 10846,13362 10757,13401
	3 10757,13401 10846,13362 10969,13430
EOF
     },
     { from  => 1114293600, # 2005-04-24 00:00
       until => 1125525600, # 2005-09-01 00:00
       text  => 'L 70; (Karl-Fiedler-Str.); OD Sperenberg, zw. Goethestr. u. Am Niederflie� Kompletter Stra�enausbau Vollsperrung 25.04.2005-31.08.2005 ',
       type  => 'handicap',
       data  => <<EOF,
	q4 8576,-29378 8721,-29879
EOF
     },
     { from  => 1120088649, # 2005-06-30 01:44
       until => 1126796400, # 2005-09-15 17:00
       text  => 'Holzendorffstra�e zwischen R�nnestra�e und Gervinusstra�e Br�ckenarbeiten, Stra�e gesperrt. Dauer: bis 15.09.2005, 17.00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 3344,10878 3395,10704
EOF
     },
     { from  => 1121378400, # 2005-07-15 00:00
       until => 1121637600, # 2005-07-18 00:00
       text  => 'Einfahrt in die Kastanienallee wegen Bauarbeiten gesperrt, 16.07.2005-17.07.2005',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 10889,15045 10723,14772
EOF
     },
     { from  => 1121732314, # 2005-07-19 02:18
       until => 1123452000, # 2005-08-08 00:00
       text  => 'Pappelallee (Prenzlauer Berg) in beiden Richtungen zwischen Raumerstr. und Sch�nhauser Allee Baustelle, Stra�e vollst�ndig gesperrt (bis 07.08.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 11119,15385 10889,15045
EOF
     },
     { from  => 1120341600, # 2005-07-03 00:00
       until => 1123538400, # 2005-08-09 00:00
       text  => 'B 109; (Prenzlauer Str.); OD Basdorf, Kno. Dimitroff-/Waldheimstr. Stra�en-,Geh- u.Radwegbau Vollsperrung 04.07.2005-08.08.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 12193,34683 12551,32765
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
     { from  => 1120946400, # 2005-07-10 00:00
       until => 1125266400, # 2005-08-29 00:00
       text  => 'L 23; (Storkow-Gr�nheide); OD Spreenhagen, Br�cke �ber Oder-Spree-Kanal Sanierung Br�cke Vollsperrung 11.07.2005-28.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 42368,-5702 42647,-6368
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
     { from  => 1120293437, # 2005-07-02 10:37
       until => 1120424400, # 2005-07-03 23:00
       text  => 'Pichelsdorfer Stra�e, zwischen Kreuzung Wilhelmstra�e und Kreuzung Betckestra�e Stra�e gesperrt bis 03.07.2005 23:00 Uhr (Sommerfest Wilhelmstadt) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -3642,12886 -3796,13312
userdel	2 -3642,12886 -3626,12739
userdel	2 -3614,12529 -3626,12739
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
       data  => <<EOF,
userdel	q4; 9164,12172 9365,12196 9492,12214
EOF
     },
     { from  => 1121551200, # 2005-07-17 00:00
       until => 1122674400, # 2005-07-30 00:00
       text  => 'L 235; (Gielsdorf-Werneuchen); OD Wegendorf, Schulstr. Ersatzneubau Durchlass Vollsperrung 18.07.2005-29.07.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 34471,22214 34321,22151
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
userdel	2 81786,-12568 81278,-13886
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
userdel	2 85161,-3425 84653,-3159
EOF
     },
     { from  => 1122415200, # 2005-07-27 00:00
       until => 1125007200, # 2005-08-26 00:00
       text  => 'B 96; (Clara-Zetkin-Str.); OD Birkenwerder, zw. Weimarerstr. u. E.-M�hsam-Str. grundh. Stra�enausbau Vollsperrung 28.07.2005-25.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 1772,31266 2257,31124
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
userdel	q4; 24631,11719 24591,11625 24603,11450 24658,11293
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
     { from  => 1122156000, # 2005-07-24 00:00
       until => 1122588000, # 2005-07-29 00:00
       text  => 'B 112; Bahn�bergang zw. Gro� Breesen u. Bresinchen Gleisinstandsetztungsarb. Vollsp * 25.07.2005-28.07.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 99277,-43921 99228,-44346
EOF
     },
     { from  => 1121892756, # 2005-07-20 22:52
       until => 1123279200, # 2005-08-06 00:00
       text  => 'Rudower Str. (Treptow) Richtung stadteinw�rts zwischen K�penicker Str. und Wegedornstr. Baustelle, Fahrtrichtung gesperrt, Einbahnstra�e in Richtung K�penicker Str. (bis 05.08.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 19771,1793 19455,1870 19188,1980 18900,2033
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
userdel	2 6745,9106 6769,8996
userdel	2 6745,9106 6727,9229
userdel	2 7009,8705 6870,8872
userdel	2 6769,8996 6870,8872
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
userdel	2 -5813,51200 -3395,51242
EOF
     },
     { from  => 1123106400, # 2005-08-04 00:00
       until => 1123452000, # 2005-08-08 00:00
       text  => 'B 169; von OD Kahla bis OE Elsterwerda Deckschichteinbau Vollsperrung 05.08.2005-07.08.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 23758,-103850 22424,-103934
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
userdel	2 30455,10061 30500,10571
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
userdel	2 2996,-10338 1764,-12480
EOF
     },
    );
