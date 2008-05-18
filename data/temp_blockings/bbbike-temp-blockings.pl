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
     { from  => 1180032943, # 2007-05-24 20:55
       until => 1180389600, # 2007-05-29 00:00
       text  => 'Stra�enfest rund um den Bl�cherplatz, 25.05.2007, 0.00 Uhr bis 29.05.2007, 0.00 Uhr ',
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
     { from  => 1180175400, # 2007-05-26 12:30
       until => 1180294200, # 2007-05-27 21:30
       text  => 'Karneval der Kulturen, 27.05.2007, 12.30 Uhr bis 21.30 Uhr ',
       type  => 'gesperrt',
       file  => "karneval-der-kulturen.bbd",
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
     { from  => 1135045277, # 2005-12-20 03:21
       until => 1135378800, # 2005-12-24 00:00
       text  => 'Schlichtallee zwischen Hauptstra�e und L�ckstra�e beidseitig wegen Bauarbeiten gesperrt bis 23.12.05 ',
       type  => 'gesperrt',
       source_id => 'LMS_1134638526559',
       data  => <<EOF,
userdel	2 15751,10582 16032,10842
userdel	2 15751,10582 15629,10481
EOF
     },
     { from  => undef,
       until => Time::Local::timelocal(reverse(2006,12-1,9,23,59,59)),
       text  => 'Richardplatz Alt-Rixdorfer Weihnachtsmarkt, gesperrt. Dauer: bis 09.12.2006. ',
       type  => 'gesperrt',
       file  => 'rixdorfer_weihnachtsmarkt.bbd',
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
     { from  => 1188506853, # 2007-08-30 22:47
       until => 1188770400, # 2007-09-03 00:00
       text  => 'Turmstr. (Moabit) in beiden Richtungen zwischen Stromstr. und Beusselstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 02.09.2007 nachts)',
       type  => 'gesperrt',
       source_id => 'IM_006461',
       data  => <<EOF,
userdel	2 6240,13324 6112,13327 6011,13330 5956,13330 5857,13342 5705,13359 5560,13382 5368,13406 5256,13420
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
userdel	2 7043,15793 7129,15717 7198,15656
userdel	2 7043,15793 6936,15888 6914,15908
userdel	2 7198,15656 7277,15586
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
userdel	2 7043,15793 7129,15717 7198,15656
userdel	2 7043,15793 6936,15888 6914,15908
userdel	2 7198,15656 7277,15586
userdel	2 6790,16018 6914,15908
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
     { from  => 1181192400, # 2007-06-07 07:00
       until => 1181512800, # 2007-06-11 00:00
       text  => 'Bergmannstra�enfest, Bergmannstr. zwischen Mehringdamm und Zossener Str. gesperrt, 08.06.2007, 7.00 Uhr bis 10.06.2007, 24.00 Uhr ',
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
     { from  => undef, # 
       until => 1150666200, # 2006-06-18 23:30
       text  => 'Badstr. (Wedding) in beiden Richtungen, zwischen Pankstr. und Behmstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 18.06.2006 23:30 Uhr) Seifenkistenrennen und Stra�enfest in der Badstr.',
       type  => 'gesperrt',
       file  => 'badstr.bbd',
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
userdel	2 6019,16712 5791,16910
userdel	2 6019,16712 6110,16630
userdel	2 6110,16630 6311,16457
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
userdel	2 22998,12453 23033,12367 23100,12269
EOF
     },
     { from  => undef,
       until => 1092439940,
       data => <<EOF,
userdel	2 9457,18612 9301,18722
userdel	2 9565,18555 9881,18354
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
userdel	q4 10023,-8859 10115,-8276
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
userdel	q4 -12325,-13958 -12177,-13787
EOF
     },
     { from  => undef, # 
       until => 1093376850, # 2004-08-26 12:00 fr�her
       text  => 'Bachstra�e: In beiden Richtungen St�rungen durch Rohrbruch, gesperrt bis Do 12:00 ',
       type  => 'handicap',
      data  => <<EOF,
userdel	q4 6020,12492 5951,12353 5938,12281 5874,12165 5798,12021
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
userdel	q4 33240,-85187 33354,-85304
userdel	q4 33240,-85187 33060,-85292
userdel	q4 33481,-85428 33354,-85304
userdel	q4 33481,-85428 33488,-85803
userdel	q4 33101,-85749 33060,-85292
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
userdel	2 7716,8048 7717,7879 7717,7759
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
userdel	2 9925,11947 9913,12068
EOF
     },
     { from  => 1093924800, # 2004-08-31 06:00
       until => 1098482400, # 2004-10-23 00:00
       text  => 'Gartenstra�e zwischen Invalidenstra�e und Bernauer Stra�e gesperrt, Baustelle, Einbahnstra�e in s�dlicher Richtung wird eingerichtet, zudem wird die Ackerstra�e zwischen Invalidenstra�e und Bernauer Stra�e gesperrt. Dauer: 01.09.2004, 06.00 Uhr bis 22.10.2004',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 9383,13978 9224,14169
userdel	1 9400,14400 9439,14368 9627,14229 9737,14126 9810,14066
EOF
     },
     { from  => 1093928400, # 2004-08-31 07:00
       until => 1094234400, # 2004-09-03 20:00
       text  => 'Dauer: 01.09.2004 07:00 Uhr bis 03.09.2004 20:00 Uhr. Rudower Chaussee, gesperrt von Agastra�e bis Gro�berliner Damm in Richtung Treptow',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 19732,3340 19581,3184 19501,3101
EOF
     },
     { from  => 1094083200, # 2004-09-02 02:00
       until => 1094428800, # 2004-09-06 02:00
       text  => 'Turmstra�e zwischen Kreuzung Beusselstra�e und Kreuzung Stromstra�e sowie Thusneldaallee: Stra�e gesperrt (Turmstra�enfest), Dauer: 03.09.2004 02:00 Uhr bis 06.09.2004 02:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 5256,13420 5368,13406 5560,13382 5705,13359 5857,13342 5956,13330 6011,13330 6112,13327 6240,13324
userdel	2 5975,13256 5956,13330
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
userdel	2 11920,8252 11931,8206 11933,8198
userdel	2 11920,8252 11892,8372
userdel	2 12041,7788 12055,7751 12075,7696
userdel	2 11979,8014 11960,8090
userdel	2 11979,8014 12001,7937 12025,7852
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
userdel	2 16610,1715 16849,1437
userdel	2 16960,1282 16849,1437
EOF
     },
     { from  => undef, # 
       until => 1097791200, # 2004-10-15 00:00
       text  => 'L�ckstr. Richtung stadteinw�rts zwischen Schlichtallee und W�nnichstr. Baustelle, Stra�e gesperrt (bis Mitte 10.2004) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 16666,10628 16588,10655 16460,10699 16316,10755 16153,10818 16032,10842
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
userdel	2 8214,12205 8089,12186 8063,12182
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
userdel	2 2443,-6309 2715,-6365
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
userdel	q4 49039,44131 48583,44366
userdel	q4 49039,44131 49691,43812
EOF
     },
     { from  => 1096578452, # 2004-09-30 23:07
       until => 1096862400, # 2004-10-04 06:00
       text  => 'Str. des 17. Juni / Ebertstr. (Tiergarten) in beiden Richtungen zwischen Entlastungsstr. und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (Vorbereitung Tag der Deutschen Einheit) (bis 04.10.2004, 6 Uhr) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8063,12182 8089,12186 8214,12205
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
userdel	q4 26650,-18150 26437,-18650 26343,-18775
EOF
     },
     { from  => 1096754400, # 2004-10-03 00:00
       until => 1097877600, # 2004-10-16 00:00
       text  => 'L 78; (Potsdamer Str.); OD Saarmund, Eisenbahnbr�cke Br�ckensanierung Vollsperrung 04.10.2004-15.10.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -9626,-6603 -9301,-7466 -8492,-9628 -8331,-9887
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
userdel	q4 28132,70222 26843,71276 26511,71453
userdel	q4 26511,71453 25875,71662
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
userdel	q4 -1872,24336 -1627,24105 -1367,23853 -1286,23753 -1281,23746
userdel	q4 -1872,24336 -1896,24275 -1935,24187
userdel	q4 -1872,24336 -1912,24442
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
userdel	q4; 6687,8385 6765,8480 6912,8617 6990,8685 7009,8705 7105,8788 7201,8870 7275,8960
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
userdel	q4 7717,7759 7717,7879 7716,8048
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
userdel	q4 21637,30946 20794,30899
userdel	q4 21637,30946 21955,30976
EOF
     },
     { from  => 1098568800, # 2004-10-24 00:00
       until => 1101855600, # 2004-12-01 00:00
       text  => 'L 792; Trebbiner Str.-Glasower Damm: Stra�enbau, Vollsperrung, 25.10.2004-30.11.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 11186,-5297 11077,-5335 10994,-5361
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
userdel	2 -926,27132 -1941,26218 -2118,26060
EOF
     },
     { from  => 1099177200, # 2004-10-31 01:00
       until => 1101078000, # 2004-11-22 00:00
       text  => 'L 200; (Breite Str.); OD Eberswalde, zw. B� und Neue Str. Stra�enbauarbeiten, Vollsperrung 01.11.2004-21.11.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 38264,50086 38035,49183
userdel	q4 38264,50086 38845,51258
EOF
     },
     { from  => 1196895600, # 2007-12-06 00:00
       until => 1197154800, # 2007-12-09 00:00
       text  => 'Richardplatz Neuk�lln Stra�ensperrung Weihnachtsmarkt 7.12.2007-8.12.2007 ',
       type  => 'gesperrt',
       source_id => 'IM_007405',
       file  => 'rixdorfer_weihnachtsmarkt.bbd',
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
userdel	q4 17475,10442 17511,10577 17565,10782 17621,10994
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
userdel	q4 13225,-681 13090,205 13225,-681 13309,-1268
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
userdel	2 10453,-2133 10631,-2130 10747,-2129
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
userdel	2 15585,4139 15594,4152 15618,4189
userdel	2 15669,4266 15640,4222 15618,4189
EOF
     },
     { from  => 1102712612, # 2004-12-10 22:03
       until => 1102910400, # 2004-12-13 05:00
       text  => 'Schulze-Boysen-Str. (Lichtenberg) in beiden Richtungen zwischen Wiesenweg und Pfarrstr. Kranarbeiten, Stra�e vollst�ndig gesperrt (bis 13.12.2004 ca. 5:00 Uhr)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15458,11342 15480,11392
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
     { from  => undef, #
       until => 1135551600, # 2005-12-26 00:00
       text  => 'Weihnachtsmarkt am Schlo�platz, bis 25.12.2005',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 10170,12261 10083,12442
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
userdel	q4 8214,12205 8089,12186 8063,12182
userdel	q4 8214,12205 8515,12242
userdel	q4 6653,12067 6642,12010
userdel	q4 6685,11954 6744,11936
userdel	q4 8610,12254 8515,12242
userdel	q4 7816,12150 8063,12182
userdel	q4 7816,12150 7383,12095
userdel	q4 6744,11936 6809,11979
userdel	q4 8861,12125 8737,12098
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
userdel	q4 6725,12113 6690,12104 6653,12067
userdel	q4 6799,12083 6754,12108 6725,12113
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
userdel	2 32937,-34794 32870,-34756 32781,-34707
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
userdel	2 13557,-21831 13960,-21244
EOF
     },
     { from  => 1109280022, # 2005-02-24 22:20
       until => 1109631600, # 2005-03-01 00:00
       text  => 'Sp�thstra�e (Treptow) In beiden Richtungen zwischen A113 und K�nigsheideweg St�rungen durch geplatzte Wasserleitung, Stra�e gesperrt (bis 28.02.2005) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 14687,5215 14994,5193
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
userdel	q4 -16479,-14389 -17341,-13386
userdel	q4 -18153,-12489 -17341,-13386
EOF
     },
     { from  => 1111437775, # 2005-03-21 21:42
       until => 1111705200, # 2005-03-25 00:00
       text  => 'Sterndamm (Treptow) in Richtung Rudow zwischen K�nigsheideweg und Winckelmannstr. Baustelle, Fahrtrichtung gesperrt, eine Umleitung ist eingerichtet (bis 24.03.2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 17518,4644 17471,4570 17428,4503
EOF
     },
     { from  => 1110235074, # 2005-03-07 23:37
       until => 1110317384, # XXX from 2005-12-09 marked as removed, check!
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
userdel	q4 7975,25642 8182,25608
EOF
     },
     { from  => 1149623367, # 2006-06-06 21:49
       until => 1154383199, # 2006-07-31 23:59
       text  => 'Nennhauser Damm (Spandau) stadteinw�rts zwischen Heerstr. und D�beritzer Weg Baustelle, Fahrtrichtung gesperrt (bis Ende 07.2006)',
       type  => 'gesperrt',
       source_id => 'IM_002500',
       data  => <<EOF,
userdel	1 -8784,13321 -8756,13356 -8358,13340 -8034,13339
EOF
     },
     { from  => 1111524913, # 2005-03-22 21:55
       until => 1120168800, # 2005-07-01 00:00
       text  => 'Pistoriusstr. (Weissensee) Richtung Berliner Allee zwischen Mirbachplatz und Parkstr. Baustelle, Fahrtrichtung gesperrt (bis 30.06.2005)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 13400,16395 13485,16362 13544,16339 13632,16305 13652,16297 13679,16286 13797,16237
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
userdel	q4 32966,64019 33080,63939 33254,63446
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
userdel	2 -3913,13054 -3886,13120 -3791,13357
userdel	2 -3913,13054 -3962,12973 -3999,12912 -4043,12833
userdel	2 -4043,12833 -4099,12763 -4163,12691
EOF
     },
     { from  => 1111960800, # 2005-03-28 00:00
       until => 1133391600, # 2005-12-01 00:00
       text  => 'B 2; (Leipziger Str.); OD Treuenbrietzen, zw. Krz.Leipz.-/Belziger Str. u. Hinter d.Mauer Stra�enbau, KVK Vollsperrung 29.03.2005-30.11.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -25322,-35457 -24967,-35112
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
userdel	q4; 21088,9175 21206,9130 21351,9066
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
userdel	q4 -16640,1304 -16023,1042 -15557,809 -15527,795
userdel	q4 -16640,1304 -16766,1399 -16905,1503
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
userdel	q4; 10755,13152 10846,13362 10817,13467 10790,13565 10777,13614 10746,13673
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
userdel	q4; 13540,15928 13623,15954 13630,15956 13753,16000 13826,16026 14014,16106 14067,16127 14248,16202 14371,16252
EOF
     },
     { from  => 1138319749, # 2006-01-27 00:55
       until => 1146434399, # 2006-04-30 23:59
       text  => 'Vulkanstr. (Lichtenberg) von Landsberger Allee bis Herzbergstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 04.2006)',
       type  => 'handicap',
       source_id => 'INKO_77420',
       data  => <<EOF,
userdel	q4; 15838,14319 15897,13942 15896,13547
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
userdel	q4 40682,100854 40507,100965
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
userdel	q4 55447,-4247 55447,-4432 55447,-4585 55562,-4726
EOF
     },
     { from  => 1117080000, # 2005-05-26 06:00
       until => 1117490400, # 2005-05-31 00:00
       text  => 'Luxemburger Stra�e - F�hrer Stra�e, Zwischen Kreuzung Leopoldplatz und Kreuzung Amrumer Stra�e Veranstaltung, Stra�e gesperrt, Dauer: 27.05.2005 06:00 Uhr bis 30.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 7148,15447 7020,15314
userdel	q4 7148,15447 7277,15586
userdel	q4 6630,15100 6737,15133
userdel	q4 6737,15133 6846,15202 7020,15314
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
userdel	2 14026,10869 14043,10928 14081,11057 14102,11133 14139,11269
EOF
     },
     { from  => 1118949539, # 2005-06-16 21:18
       until => 1120068000, # 2005-06-29 20:00
       text  => 'Franz�sische Str. ab Markgrafenstr., Werderscher Markt, Breite Str. gesperrt. Dauer: bis 29.06.2005, 20:00 Uhr. (Beachvolleyball) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9636,12126 9756,12139 9812,12145
userdel	2 10084,12228 9972,12184
userdel	2 9812,12145 9890,12161
userdel	2 9890,12161 9972,12184
userdel	2 10170,12261 10109,12238
userdel	2 10170,12261 10267,12305
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
userdel	2 22383,4703 22355,4660 22312,4593
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
userdel	q4; 9008,12485 9018,12400 9028,12307
EOF
     },
     { from  => 1119909600, # 2005-06-28 00:00
       until => 1125698400, # 2005-09-03 00:00
       text  => 'L 793; (Sch�nhagen-Ludwigsfelde); zw. Abzw. Gr�ben und Siethen Stra�enbauarbeiten Vollsperrung 29.06.2005-02.09.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -2542,-13926 -3801,-14252
EOF
     },
     { from  => 1119909600, # 2005-06-28 00:00
       until => 1125698400, # 2005-09-03 00:00
       text  => 'L 793; (Sch�nhagen-Ludwigsfelde); zw. OD J�tchendorf und Abzw. Gr�ben Stra�enbauarbeiten Vollsperrung 29.06.2005-02.09.2005 ',
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
     { from  => undef, # 
       until => 1148937435, # XXX zuletzt gesehen: 2006-03-19, laut http://archiv.tagesspiegel.de/archiv/29.05.2006/2555791.asp vorbei?
       text  => 'Rosa-Luxemburg-Str. Richtung Sch�nhauser Tor wegen Bauarbeiten gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 10755,13152 10846,13362 10817,13467 10790,13565 10777,13614 10746,13673
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
userdel	2 3049,10719 3093,10594
EOF
     },
     { from  => 1121378400, # 2005-07-15 00:00
       until => 1121637600, # 2005-07-18 00:00
       text  => 'Einfahrt in die Kastanienallee wegen Bauarbeiten gesperrt, 16.07.2005-17.07.2005',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 10889,15045 10838,14962 10723,14772
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
userdel	q4 12193,34683 12635,32221
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
userdel	2 -3650,12929 -3669,13015 -3764,13270 -3791,13357
userdel	2 -3650,12929 -3641,12861 -3629,12781
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
userdel	q4; 9164,12172 9365,12196 9492,12214
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
     { from  => 1121724000, # 2005-07-19 00:00
       until => 1128204000, # 2005-10-02 00:00
       text  => 'B 96; (Clara-Zetkin-Str.); OD Birkenwerder, zw. Weimarer Str. u. E.-M�hsam-Str. grundh. Stra�enausbau Vollsperrung 20.07.2005-01.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 1762,31318 1918,31279 1931,31275 2126,31207
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
userdel	q4; 24623,11684 24591,11625 24603,11450 24658,11293
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
userdel	q4; 19771,1793 19455,1870 19188,1980 18881,2062
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
userdel	2 6735,9103 6711,9225
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
userdel	2 -5813,51200 -3395,51242
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
userdel	q2::inwork 9494,15998 9646,15737
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
userdel	2 26583,-15677 26612,-15094
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
userdel	2 5657,10868 5484,10810
userdel	2 5657,10868 5725,10892
userdel	2 5725,10892 5797,10881
userdel	2 5942,10803 6040,10751
userdel	2 5942,10803 5797,10881
userdel	2 6040,10751 6137,10689
userdel	2 5484,10810 5351,10760
userdel auto	3 5831,10978 5797,10881 5681,10696
userdel auto	3 5247,10992 5242,10918 5229,10716 5207,10399
userdel auto	3 5207,10399 5229,10716 5242,10918 5247,10992
userdel auto	3 5479,10719 5484,10810 5505,10971
userdel auto	3 5877,10486 6040,10751 6135,10982
userdel auto	3 5505,10971 5484,10810 5479,10719
userdel auto	3 5681,10696 5797,10881 5831,10978
userdel auto	3 6135,10982 6040,10751 5877,10486
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
userdel	2 11145,11042 11105,10945
userdel	2 11105,10945 11039,10820
EOF
     },
     { from  => 1124742735, # 2005-08-22 22:32
       until => 1127512800, # 2005-09-24 00:00
       text  => 'Buschallee (Wei�ensee) in Richtung Berliner Allee zwischen Elsastr. und Hansastr. Baustelle, Fahrtrichtung gesperrt (bis 23.09.2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 15918,16383 15871,16399 15432,16500
EOF
     },
     { from  => 1124575200, # 2005-08-21 00:00
       until => 1125871200, # 2005-09-05 00:00
       text  => 'K 7237; (L 40 Klein Kienitz-Rangsdorf); zw. S�dringcenter Rangsdorf u. Klein Kienitz Stra�enbauarbeiten Vollsperrung 22.08.2005-04.09.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26583,-15677 26612,-15094
userdel	2 14327,-11767 15962,-10958
EOF
     },
     { from  => 1125612000, # 2005-09-02 00:00
       until => 1125784800, # 2005-09-04 00:00
       text  => 'B 167; (Frankfurter Str.); OD Seelow, zw. Breite Str. u. Berliner Str. Stadtfest Vollsperrung 03.09.2005-03.09.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 76771,15413 77081,14637
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
userdel	q4; 21823,4210 21679,4059 21492,3845 21434,3777 21316,3662 21227,3549 21198,3522 21153,3484 21055,3415 20967,3343 20818,3182
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
userdel	q4 16653,11251 16723,11470 16759,11582 16766,11603 16786,11668
userdel	q4 16958,11778 16821,11743
userdel	q4 16821,11743 16786,11668
EOF
     },
     { from  => 1174341828, # 2007-03-19 23:03
       until => 1174604400, # 2007-03-23 00:00
       text  => 'Florastr. (Pankow) in beiden Richtungen, zwischen Berliner Str. und M�hlenstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 22.03.07)',
       type  => 'gesperrt',
       source_id => 'IM_005006',
       data  => <<EOF,
userdel	2 10459,17754 10548,17817 10705,17931 10846,17992
EOF
     },
     { from  => 1127508095, # 2005-09-23 22:41
       until => 1136069999, # 2005-12-31 23:59
       text  => 'Wegedornstra�e (Adlershof) Richtung Rudow, zwischen Rudower Chaussee und Ernst-Ruska-Ufer Baustelle, Fahrtrichtung gesperrt (bis Ende 2005)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 18929,2454 18925,2700
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
userdel	q4 50109,89725 49930,89857
EOF
     },
     { from  => 1126994400, # 2005-09-18 00:00
       until => 1130191200, # 2005-10-25 00:00
       text  => 'B 179; (Karl-Liebknecht-Str.); OD Zeesen, zw. Spreewaldstr. u. Weidendamm Stra�enausbau Vollsperrung 19.09.2005-24.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26473,-14543 26612,-15094
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
userdel	2 46677,82770 47081,83093
userdel	2 47081,83093 47137,83456
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
userdel	q4 -15527,795 -15557,809 -16023,1042 -16640,1304
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
userdel	q4 -12601,19517 -12074,19052
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
userdel	2 13225,-681 13090,205 12984,1011
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
userdel	2 85403,-4497 85666,-3989
EOF
     },
     { from  => 1128117600, # 2005-10-01 00:00
       until => 1128398400, # 2005-10-04 06:00
       text  => 'Ebertstra�e, Pariser Platz: Veranstaltung, Stra�e gesperrt bis Di 06:00 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8581,11896 8595,12066
userdel	2 8581,11896 8571,11846
userdel	2 8595,12066 8600,12165
userdel	2 8539,12286 8515,12242
userdel	2 8539,12286 8560,12326
userdel	2 8540,12420 8560,12326
userdel	2 8600,12165 8515,12242
userdel	2 8515,12242 8610,12254
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
userdel	q4 -12601,19517 -12074,19052
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
userdel	q4 25095,35601 24915,35340
EOF
     },
     { from  => 1128988800, # 2005-10-11 02:00
       until => 1129298400, # 2005-10-14 16:00
       text  => 'Drakestra�e zwischen Hans-Sachs-Stra�e und Knesebeckstra�e in beiden Richtungen Br�ckenabriss, Stra�e gesperrt, Dauer: 12.10.2005 02:00 Uhr bis 14.10.2005 16:00 Uhr',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 3259,4002 3228,4046 3128,4190
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
userdel	q4 18147,8583 18225,8532 18391,8425 18461,8377 18528,8331 18615,8269 18683,8232
EOF
     },
     { from  => undef, # 
       until => 1128891600, # 2005-10-09 23:00
       text  => 'Hermannstra�e zwischen Flughafenstra�e und Thomasstra�e Veranstaltung, Stra�e gesperrt bis So 23:00 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 12090,7651 12075,7696
userdel	2 12090,7651 12122,7553
userdel	2 12180,7387 12122,7553
userdel	2 11920,8252 11931,8206 11933,8198
userdel	2 11920,8252 11892,8372
userdel	2 12041,7788 12055,7751
userdel	2 12041,7788 12025,7852
userdel	2 12001,7937 12025,7852
userdel	2 12001,7937 11979,8014
userdel	2 11979,8014 11960,8090
userdel	2 11933,8198 11960,8090
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
userdel	1 11723,13630 11538,13683 11257,13647
EOF
     },
     { from  => undef, # 
       until => 1129413599, # 2005-10-15 23:59
       text  => 'Mahlsdorfer Str. (K�penick) Richtung K�penick, zwischen Hultischiner Damm und Genovevastr. Baustelle, Fahrtrichtung gesperrt (bis 15.10.)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 23799,7877 23774,7803 23701,7772 23223,7493 23145,7429 23066,7355
EOF
     },
     { from  => 1129327200, # 2005-10-15 00:00
       until => 1129759200, # 2005-10-20 00:00
       text  => 'L 15; (B109-Boitzenburg); zw. Abzw. Klein Sperrenwalde u. OL Gollmitz, Prenzlauer Str. Stra�enbauarbeiten Vollsperrung 16.10.2005-19.10.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 31946,98379 30743,99403
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
userdel	q4; 10305,13211 10264,13097
EOF
     },
     { from  => 1119996000, # 2005-06-29 00:00
       until => 1133391600, # 2005-12-01 00:00
       text  => 'L 401; (Lindenallee); OD Zeuthen, zw. OE und An der Eisenbahn grundhafter Stra�enbau Vollsperrung 30.06.2005-30.11.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 26790,-7918 26700,-7334 26581,-7087
EOF
     },
     { from  => undef, # 
       until => 1168462241, # 2010-12-31 23:59 1293836399
       text  => 'Universit�tsstr., Richtung Dorotheenstr. gesperrt (bis 2010) ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 9603,12372 9574,12578
EOF
     },
     { from  => undef, # 
       until => 1168462241, # 2010-12-31 23:59 1293836399
       text  => 'Universit�tsstr., Richtung Dorotheenstr. gesperrt (bis 2010)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 9561,12687 9574,12578
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
userdel	1 2446,25265 2519,25353 2531,25368 2657,25486 2721,25576
EOF
     },
     { from  => 1129879314, # 2005-10-21 09:21
       until => 1130623200, # 2005-10-30 00:00
       text  => 'Scheidemannstr. Richtung Ebertstr. von Entlastungsstr. bis Ebertstr. Veranstaltung, Fahrtrichtung gesperrt (bis 29.10.2005)',
       type  => 'handicap',
       source_id => 'IM_002305',
       data  => <<EOF,
userdel	q4 8119,12414 8374,12416
userdel	q4 8400,12417 8540,12420
userdel	q4 8400,12417 8374,12416
EOF
     },
     { from  => 1129878000, # 2005-10-21 09:00
       until => 1129996800, # 2005-10-22 18:00
       text  => 'Stadtgebiet Potsdam: auf Grund einer Bombenentsch�rfung sind folgende Strassen innerhalb folgender Begrenzung gesperrt: Am Kanal -- Kurf�rstenstr. -- Berliner Strasse -- Friedrich-Ebert-Str., Dauer: 22.10.2005 09:00 Uhr bis 18:00 Uhr, ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -12306,-496 -12262,-612
userdel	2 -12531,-790 -12515,-889 -12512,-911 -12575,-1031
userdel	2 -12531,-790 -12219,-726
userdel	2 -12531,-790 -12693,-827
userdel	2 -12045,-757 -12148,-934
userdel	2 -12148,-934 -12231,-1078
userdel	2 -12148,-934 -12100,-962
userdel	2 -11910,-945 -12100,-962
userdel	2 -12285,-1174 -12231,-1078
userdel	2 -12285,-1174 -12359,-1096 -12488,-999
userdel	2 -12488,-999 -12553,-1025
userdel	2 -12262,-612 -12219,-726
userdel	2 -12262,-612 -12545,-698
userdel	2 -12575,-1031 -12768,-1069
userdel	2 -12575,-1031 -12553,-1025
userdel	2 -12553,-1025 -12552,-1233 -12549,-1277
userdel	2 -12078,-1068 -12070,-1153
userdel	2 -12078,-1068 -12020,-1062
userdel	2 -12078,-1068 -12231,-1078
userdel	2 -12078,-1068 -12100,-962
userdel	2 -12768,-1069 -12784,-956
userdel	2 -12571,-581 -12545,-698
userdel	2 -12219,-726
userdel	2 -12784,-956 -12804,-854
userdel	2 -12545,-698 -12712,-734
userdel	2 -12693,-827 -12804,-854
userdel	2 -12712,-734 -12884,-769
userdel	2 -12730,-627 -12712,-734
userdel	2 -12804,-854 -12886,-869
userdel	2 -12718,-1327 -12755,-1131 -12768,-1069
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
userdel	2 26639,-17861 26752,-17872
userdel	2 26832,-17882 26752,-17872
EOF
     },
     { from  => 1130277600, # 2005-10-26 00:00
       until => 1134774000, # 2005-12-17 00:00
       text  => 'L 15; (B109 s�dl. Prenzlau-Boitzenburg); OD Gollmitz Leitungsverlegung Vollsperrung 27.10.2005-16.12.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 30743,99403 30482,99609
EOF
     },
     { from  => 1130450400, # 2005-10-28 00:00
       until => 1130972400, # 2005-11-03 00:00
       text  => 'L 402; (Forstweg); Bahn�bergang in OL Zeuthen Gleisbauarbeiten Vollsperrung 29.10.2005-02.11.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26001,-6257 26146,-6218
EOF
     },
     { from  => 1130715720, # 2005-10-31 00:42
       until => 1132354800, # 2005-11-19 00:00
       text  => 'Naumannstra�e zwischen Torgauer Str. und Kolonnenstra�e in Richtung Kolonnenstra�e wegen Bauarbeiten gesperrt bis 18.11.2005 ',
       type  => 'handicap',
       source_id => 'LMS_1129024102795',
       data  => <<EOF,
userdel	q4; 7713,8600 7709,8770
userdel	q4; 7716,8048 7716,8356
EOF
     },
     { from  => 1130792769, # 2005-10-31 22:06
       until => 1131231600, # 2005-11-06 00:00
       text  => 'Br�ckensperrung zwischen Seehausen und Potzlow Die Br�cke ist ab dem 5.9.2005 bis zum 5.11.2005 auch f�r Radfahrer nicht passierbar ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 40230,90006 40938,90213
EOF
     },
     { from  => 1130831377, # 2005-11-01 08:49
       until => 1132354800, # 2005-11-19 00:00
       text  => 'Eldenaer Str. zwischen Thaerstr. und Proskauer Str. Baustelle, wegen Bauarbeiten gesperrt. Dauer: bis 18.11.2005',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 14363,12749 14336,12758
userdel	q4 13960,12866 14096,12827
userdel	q4 13960,12866 13844,12900
userdel	q4 14096,12827 14336,12758
EOF
     },
     { from  => 1131050267, # 2005-11-03 21:37
       until => 1132095599, # 2005-11-15 23:59
       text  => 'Romain-Rolland-Stra�e (Weissensee) zwischen Stra�e 16 und Berliner Stra�e Stra�enarbeiten, gesperrt (bis Mitte November 2005) ',
       type  => 'handicap',
       source_id => 'IM_002329',
       data  => <<EOF,
userdel	q4 13300,17726 13031,17775 12928,17801 12856,17825
userdel	q4 12856,17825 12736,17998
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
userdel	q4 8861,12125 8737,12098
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
userdel	1 -1668,-1709 -1752,-1823 -1921,-1931 -2049,-2165
EOF
     },
     { from  => 1132411558, # 2005-11-19 15:45
       until => 1136069999, # 2005-12-31 23:59
       text  => 'Weihnachtsmarkt an der Ged�chtniskirche, bis 2005-12-31',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 5831,10978 5797,10881
userdel	q4 5657,10868 5652,11004
userdel	q4; 5652,11004 5716,10978 5831,10978
EOF
     },
     { from  => 1132606608, # 2005-11-21 21:56
       until => 1143842399, # 2006-03-31 23:59
       text  => 'Pistoriusstr. (Pankow) Richtung Wei�ensee, zwischen Hamburger Platz und Roelckestr. Baustelle, Fahrtrichtung gesperrt (bis 03/2006)',
       type  => 'gesperrt',
       source_id => 'INKO_77722',
       data  => <<EOF,
userdel	1 12693,16700 12874,16631 13131,16525
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
userdel	q4 52316,69186 52711,69501
userdel	q4 52316,69186 50891,68557
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
userdel	q4 54357,-96691 54884,-96292
userdel	q4 55158,-95910 54884,-96292
EOF
     },
     { from  => 1129413600, # 2005-10-16 00:00
       until => 1135983600, # 2005-12-31 00:00
       text  => 'B 198 Greiffenberger Str. OD Kerkow grundhafter Stra�enbau Vollsperrung * 17.10.2005-30.12.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 48929,70947 48996,71176
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
userdel	2 47692,-6364 47806,-6168
userdel	2 47692,-6364 47514,-6402
userdel	2 48136,-5051 48131,-4175
userdel	2 48136,-5051 47885,-5561
userdel	2 47885,-5561 47908,-5802
userdel	2 47514,-6402 47354,-6584
userdel	2 47806,-6168 47908,-5802
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
userdel	q4 33080,63939 33254,63446
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
     { from  => 1165660181, # 2006-12-09 11:29
       until => 1165708800, # 2006-12-10 01:00
       text  => 'Bahnhofstr. (Lichtenrade) in beiden Richtungen zwischen Steinstr. und Goltzstr. Veranstaltung, Stra�e vollst�ndig gesperrt (Weihnachtsmarkt) (bis 10.12.2006 01:00 Uhr) ',
       type  => 'gesperrt',
       source_id => 'IM_004172',
       data  => <<EOF,
userdel	q4 10310,-2136 10453,-2133 10631,-2130 10747,-2129 10945,-2124
EOF
     },
     { from  => 1134255600, # 2005-12-11 00:00
       until => 1137776400, # 2006-01-20 18:00
       text  => 'Tietzenweg zwischen Margaretenstra�e und Unter den Eichen, Baustelle, Stra�e gesperrt. Dauer: 12.12.2005 bis 20.01.2006,18.00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 3490,4449 3425,4541
EOF
     },
     { from  => 1134428400, # 2005-12-13 00:00
       until => 1134774000, # 2005-12-17 00:00
       text  => 'B 167 Eisenbahn- u. Heegerm�hler Str. OD Eberswalde, Eisenbahnbr�cke Ersatzneubau Br�cke Vollsperrung; Umleitung 14.12.2005-16.12.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 36937,48074 36403,48168
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
userdel	2 9024,906 9165,1014 9241,1073
EOF
     },
     { from  => 1136070000, # 2006-01-01 00:00
       until => 1138057200, # 2006-01-24 00:00
       text  => 'B 179 Cottbuser-/ Fichtestr. OL K�nigs Wusterhausen, Bahn�bergang Fichtestr. Umbau Bahn�bergang Vollsperrung 02.01.2006-23.01.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26313,-13049 26028,-12312
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
userdel	q4 8462,11538 8209,11671 8202,11691
EOF
     },
     { from  => 1137548634, # 2006-01-18 02:43
       until => 1148759509, # 1149112799 2006-05-31 23:59
       text  => 'Vo�str. (Mitte) in Richtung Wilhelmstr. zwischen Ebertstr. und Gertrud-Kolmar-Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 05.2006)',
       type  => 'handicap',
       source_id => 'IM_002419',
       data  => <<EOF,
userdel	q4; 8553,11638 8837,11676
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
       until => 1152221087, # XXX undef
       text  => 'Pistoriusstr. (Wei�ensee) in Richtung Mirbachplatz zwischen Berliner Allee und Parkstr. Baustelle, Fahrtrichtung gesperrt',
       type  => 'handicap',
       source_id => 'IM_002437',
       data  => <<EOF,
userdel	q4; 14067,16127 13797,16237
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
	2 13289,-4660 13655,-4831
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
userdel	2 91858,-18170 90698,-16886
EOF
     },
     { from  => undef, # 
       until => 1139428054, # XXX
       text  => 'Elsenstr. (Kaulsdorf) in beiden Richtungen zwischen Kressenweg und Hornungsweg Wasser auf der Fahrbahn, Stra�e vollst�ndig gesperrt ',
       type  => 'gesperrt',
       source_id => 'LMS_1138607956237',
       data  => <<EOF,
userdel	2 23571,10990 24389,10836
EOF
     },
     { from  => 1150092737, # 2006-06-12 08:12
       until => 1150737175, # 1167605999 2006-12-31 23:59, jetzt nur noch "Engstellensignalisierung"
       text  => 'Schlichtallee (Rummelsburg) in Richtung Nord, auf der s�dlichen Bahnbr�cke Baustelle; Fahrtrichtung gesperrt (bis Ende 12/2006) ',
       type  => 'handicap',
       source_id => 'IM_002885',
       data  => <<EOF,
userdel	q4; 15629,10481 15751,10582 16032,10842
EOF
     },
     { from  => undef, # 
       until => 1139470769, # XXX
       text  => 'Berlin-L�bars: Am Freibad in beiden Richtungen Wasser auf der Fahrbahn, gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 5727,23485 5297,23633
EOF
     },
     { from  => undef, # 
       until => 1140727101, # XXX
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
       until => 1140120150, # XXX
       text  => 'S�ntisstra�e zwischen Daimlerstra�e und Albanstra�e St�rung am Bahn�bergang, Stra�e gesperrt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8957,852 9024,906
userdel	2 9241,1073 9165,1014 9024,906
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
userdel	2 26381,-9962 26339,-9943 25700,-9502
EOF
     },
     { from  => 1141254000, # 2006-03-02 00:00
       until => 1141686000, # 2006-03-07 00:00
       text  => 'L 090 Ph�bener Str. Bahn�bergang in OL Werder Gleisbauarbeiten Vollsperrung; Umleitung 03.03.2006-06.03.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -22206,-1693 -22146,-1832 -22146,-1832 -22042,-2060 -22042,-2060
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
userdel	2::inwork 22688,12007 22669,12049
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
userdel	2 23356,-20982 22599,-19785
EOF
     },
     { from  => 1161627812, # 2006-10-23 20:23
       until => 1175458876, # Time::Local::timelocal(reverse(2007-1900,7-1,1,0,0,0)),
       text  => 'Wiesbadener Str. (Wilmersdorf) Richtung Bundesallee zwischen Geisenheimer Str. und S�dwestkorso Baustelle, Fahrtrichtung gesperrt (bis Mitte 2007)',
       type  => 'gesperrt',
       source_id => 'IM_003889',
       data  => <<EOF,
userdel	q4::inwork; 4391,7258 4571,7239 4743,7212
userdel	q4::inwork; 4534,7015 4462,7137 4391,7258
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
       until => 1148166908, # XXX nur noch Fahrstreifeneinschr�nkung...
       text  => 'B�tzowstr. (Prenzlauer Berg) in beiden Richtungen, zwischen Danziger Str. und Hufelandstr. Baustelle, Stra�e vollst�ndig gesperrt',
       type  => 'handicap',
       source_id => 'IM_002530',
       data  => <<EOF,
userdel	q4 12438,14054 12499,14136
userdel	q4 12438,14054 12380,13975
userdel	q4 12578,14237 12630,14306
userdel	q4 12578,14237 12499,14136
EOF
     },
     { from  => 1142632575, # 2006-03-17 22:56
       until => 1142895600, # 2006-03-21 00:00
       text  => 'Charlottenstr. (Mitte) in Richtung Unter den Linden zwischen Mittelstr. und Unter den Linden Baustelle, Stra�e vollst�ndig gesperrt (bis 20.03.2006)',
       type  => 'handicap',
       source_id => 'IM_002531',
       data  => <<EOF,
userdel	q4; 9465,12460 9476,12359
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
userdel	q4 25012,5754 24700,5633 23950,5342
userdel	q4 25012,5754 25018,5756 25121,5799
userdel	q4 25579,5980 25121,5799
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
userdel	q4 48929,70947 48996,71176
EOF
     },
     { from  => 1143575024, # 2006-03-28 21:43
       until => 1143820800, # 2006-03-31 18:00
       text  => 'Hirtenstr. Arbeiten an Wasserleitungen, Stra�e in beiden Richtungen gesperrt. (zwischen Rosa-Luxemburg-Str. und Kleine Alexanderstr.) bis 31.03.06, 18:00 Uhr ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 10846,13362 10923,13317
EOF
     },
     { from  => undef, # 
       until => 1144438933, # XXX
       text  => 'Zoppoter Str. (Wilmersdorf) in beiden Richtungen zwischen Heiligendammer Str. und Breitestr. Tiefbauarbeiten, Stra�e vollst�ndig gesperrt',
       type  => 'handicap',
       source_id => 'IM_002552',
       data  => <<EOF,
userdel	q4 3349,7361 3314,7269
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
userdel	2 46677,82770 47081,83093
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
       text  => 'XXX',
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
userdel	q4 13225,-681 13090,205 12984,1011
EOF
     },
     { from  => 1143928800, # 2006-04-02 00:00
       until => 1155938400, # 2006-08-19 00:00
       text  => 'L 077 Lindenstr. OD Stahnsdorf, zw. Streuobsthang u. Ruhlsdorfer Str. Geh- und Radwegbau halbseitig gesperrt; Einbahnstra�e 03.04.2006-18.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 -2049,-2165 -1921,-1931 -1752,-1823
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
userdel	q4 91858,-18170 90698,-16886
EOF
     },
     { from  => 1145743200, # 2006-04-23 00:00
       until => 1146261600, # 2006-04-29 00:00
       text  => 'L 216 Gollin-Templin OD Vietmannsdorf, Br�cke �ber M�hlengraben Einbau Decke Vollsperrung 24.04.2006-28.04.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 17636,72217 17653,71852
EOF
     },
     { from  => 1144438665, # 2006-04-07 21:37
       until => 1146434400, # 2006-05-01 00:00
       text  => 'Br�cke �ber den Nordgraben (Reinickendorf) in beiden Richtungen, in H�he Schorfheidestr. Baustelle, Stra�e vollst�ndig gesperrt (bis 30.04.06)',
       type  => 'gesperrt',
       source_id => 'INKO_82299',
       data  => <<EOF,
userdel	2 6281,20369 6289,20468
EOF
     },
     { from  => 1144438729, # 2006-04-07 21:38
       until => 1144706400, # 2006-04-11 00:00
       text  => 'Charlottenstr. (Mitte) in beiden Richtungen, in H�he Mittelstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 10.04.06)',
       type  => 'gesperrt',
       source_id => 'IM_002607',
       data  => <<EOF,
userdel	2 9454,12558 9465,12460
userdel	2 9476,12359 9465,12460
EOF
     },
     { from  => 1144438828, # 2006-04-07 21:40
       until => 1151704800, # 2006-07-01 00:00
       text  => 'Roelckestr. (Weissensee) in beiden Richtungen zwischen Charlottenburger Str. und Pistoriusstr. Baustelle, Stra�e bis 30.06.2006 vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_002598',
       data  => <<EOF,
userdel	2 13131,16525 13045,16368
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
userdel	q4; 15349,12073
EOF
     },
     { from  => undef, # 
       until => 1144619999, # 2006-04-09 23:59
       text  => 'Scharnweberstr. (Reinickendorf) in beiden Richtungen zwischen Eichborndamm und Hechelstr. Veranstaltung, Stra�e vollst�ndig gesperrt (Stra�enfest)',
       type  => 'handicap',
       source_id => 'IM_002611',
       data  => <<EOF,
userdel	q4 4392,17777 4429,17763 4584,17704
userdel	q4 4392,17777 4326,17801
userdel	q4 4584,17704 4683,17669
userdel	q4 4326,17801 4200,17848 4096,17890 4015,17912
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
userdel	2 27543,-11912 27657,-11741
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
userdel	2 21182,4336 21174,4250
userdel	2 21100,4192 21137,4221 21174,4250
EOF
     },
     { from  => 1151002800, # 2006-06-22 21:00
       until => 1151168400, # 2006-06-24 19:00
       text  => '23.06.2006, 21.00 Uhr bis 24.06.2006, 19.00 Uhr Vollsperrung der Ottomar-Geschke-Stra�e ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 21182,4336 21174,4250
userdel	2 21100,4192 21137,4221 21174,4250
EOF
     },
     { from  => 1145209261, # 2006-04-16 19:41
       until => 1145311200, # 2006-04-18 00:00
       text  => 'Adamstr. (Spandau) in beiden Richtungen zwischen Wilhelmstr. und Pichelsdorfer Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 17.04.2006)',
       type  => 'gesperrt',
       source_id => 'IM_002648',
       data  => <<EOF,
userdel	2 -4167,12554 -4239,12626
userdel	2 -4167,12554 -4069,12558
userdel	2 -3621,12575 -3738,12572
userdel	2 -3738,12572 -3876,12567
userdel	2 -3876,12567 -4069,12558
EOF
     },
     { from  => 1145397600, # 2006-04-19 00:00
       until => 1149112800, # 2006-06-01 00:00
       text  => 'L 010 Havelberger Str. OD Bad Wilsnack, vom OE bis An der Trift Kanal- und Stra�enbau Vollsperrung 20.04.2006-31.05.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 -89647,59213 -89549,58784
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
userdel	2 2965,10522 2938,10071
EOF
     },
     { from  => 1145343600, # 2006-04-18 09:00
       until => 1145451600, # 2006-04-19 15:00
       text  => 'Invalidenstra�e, Prenzlauer Berg Richtung Tiergarten Zwischen Kreuzung Gartenstra�e und Kreuzung Chausseestra�e Baustelle, gesperrt, Dauer: 19.04.2006 09:00 Uhr bis 15:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 9383,13978 9203,13953
userdel	2 9151,13941 9203,13953
userdel	2 9151,13941 9076,13915
userdel	2 9076,13915 8935,13844
EOF
     },
     { from  => 1145430358, # 2006-04-19 09:05
       until => 1146866400, # 2006-05-06 00:00
       text  => 'Prenzlauer Promenade (Prenzlauer Berg) im Kreuzungsbereich Ostseestr. und Wisbyer Str Baustelle, in Richtung stadteinw�rts Stra�e gesperrt (Radfahrer k�nnen m�glicherweise den Gehweg benutzen) (bis 05.05.06)',
       type  => 'handicap',
       source_id => 'IM_002644',
       data  => <<EOF,
userdel	q4; 12097,16263 12091,16209
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
     { from  => 1146251142, # XXX 2006-05-01 00:00
       until => 1146251563, # XXX 2006-07-29 00:00
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
userdel	1 9248,9350 9235,9111 9235,9051 9234,9038 9227,8890 9222,8787
EOF
     },
     { from  => 1162325129, # 2006-10-31 21:05
       until => 1162821600, # 2006-11-06 15:00
       text  => 'Schulzendorfer Stra�e - Am Dachsbau (zwischen Ruppiner Chaussee und Blisenkrautstr.) in beiden Richtungen gesperrt, Baustelle bis 06.11.2006 15:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -915,22935 -1103,22889 -1299,22842
EOF
     },
     { from  => 1146701434, # 2006-05-04 02:10
       until => 1146834000, # 2006-05-05 15:00
       text  => 'Holtzendorffstr. zwischen R�nnestr. und Gervinusstr. in beiden Richtungen Br�ckenarbeiten gesperrt bis 05.05.06, 15:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 3093,10594 3049,10719
EOF
     },
     { from  => 1146768809, # 2006-05-04 20:53
       until => 1167606000, # 2007-01-01 00:00
       text  => 'Weinmeisterstr. (Mitte) in Richtung Alexanderplatz Baustelle, Stra�e vollst�ndig gesperrt, Einbahnstra�enreglung in Richtung Rosenthaler Str. (bis 31.12.06)',
       type  => 'gesperrt',
       source_id => 'IM_002733',
       data  => <<EOF,
userdel	1::inwork 10331,13397 10528,13243
EOF
     },
     { from  => 1147557600, # 2006-05-14 00:00
       until => 1159653600, # 2006-10-01 00:00
       text  => 'L 037 Petersdorfer Str. OD Petershagen Kanal- und Stra�enbauarbeiten Vollsperrung 15.05.2006-30.09.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 74092,475 74246,584
EOF
     },
     { from  => undef, # 
       until => 1147121258, # XXX
       text  => 'M�hlenstr. (Pankow) in Richtung Norden zwischen Florastr und Dolomitenstr. Einbahnstra�e in Richtung S�den',
       type  => 'gesperrt',
       source_id => 'IM_002743',
       data  => <<EOF,
userdel	1 10572,17573 10510,17649 10459,17754
EOF
     },
     { from  => undef, # 
       until => 1147067585, # XXX
       text  => 'Reichstagufer (Mitte) zwischen Neust�dter Kirchstr. und Friedrichsstr. Gefahr durch Uferuntersp�hlung, Stra�e gesperrt.',
       type  => 'gesperrt',
       source_id => 'LMS_1146113785841',
       data  => <<EOF,
userdel	2 9098,12687 9209,12795
userdel	2 9283,12856 9209,12795
EOF
     },
     { from  => 1146693600, # 2006-05-04 00:00
       until => 1147471200, # 2006-05-13 00:00
       text  => 'B 158 zw. OL Seefeld, L�hmer Ch. und Bahn�bergang Gleis- u. Stra�enbauarbeiten Vollsperrung 05.05.2006-12.05.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26936,23104 27283,23503
userdel	2 28323,24341 27608,23776
userdel	2 27283,23503 27608,23776
EOF
     },
     { from  => 1146866400, # 2006-05-06 00:00
       until => 1147471200, # 2006-05-13 00:00
       text  => 'L 401 R.-Sorge-/ Bergstr. Bahn�bergang Bergstra�e Gleisbauarbeiten Zufahrt gesperrt 07.05.2006-12.05.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 26381,-9962 26339,-9943 25700,-9502
EOF
     },
     { from  => 1146897090, # 2006-05-06 08:31
       until => 1147086000, # 2006-05-08 13:00
       text  => 'Wilhelmstra�e Richtung Pichelsdorf zwischen Einm�ndung Pichelsdorfer Stra�e und Einm�ndung Gatower Stra�e Baustelle, gesperrt bis 08.05.2006 13:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1 -3791,13357 -3886,13120 -3913,13054 -3962,12973 -3999,12912 -4043,12833 -4099,12763 -4163,12691 -4239,12626 -4300,12571 -4335,12465
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
       until => 1148166862, # XXX tritt nirgendwo mehr auf
       text  => 'Riemenschneiderweg zwischen Vorarlberger Damm und Grazer Platz, Baustelle, in beiden Richtungen gesperrt.',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 6802,6816 6781,7030 6773,7116
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
userdel	q4 7435,34963 7070,34665
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
userdel	1 15388,16502 15134,16499 14809,16525 14621,16563
EOF
     },
     { from  => 1147721063, # 2006-05-15 21:24
       until => 1172778049, # was 2006-05-17 00:00, but continuing undef
       text  => 'Linienstr. (Mitte) in Richtung Tucholskystr., ab Oranienburger Str. Stra�enarbeiten, Einbahnstra�e',
       type  => 'handicap',
       source_id => 'IM_002765',
       data  => <<EOF,
userdel	q4; 9607,13507 9281,13374
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
userdel	2 9076,13915 9006,14005
EOF
     },
     { from  => 1148162400, # 2006-05-21 00:00
       until => 1159653600, # 2006-10-01 00:00
       text  => 'L 011 Perleberger Chaussee zw. Weisen, Walhausstr. u. Wittenberge, Kyritzer Str. Stra�enausbau Vollsperrung 22.05.2006-30.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 -102390,65175 -102434,66177
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
userdel	2 11979,8014 12001,7937 12025,7852 12041,7788 12055,7751 12075,7696 12090,7651 12122,7553 12180,7387
EOF
     },
     { from  => 1148565600, # 2006-05-25 16:00
       until => 1153087200, # 2006-07-17 00:00
       text  => 'Vom 26.05.2006, 16:00 Uhr bis 16.07.2006 wird die Stra�e des 17. Juni zwischen Siegess�ule und Brandenburger Tor komplett gesperrt. Grund sind die geplante WM-Fanmeile sowie mehrere Festveranstaltungen (u.a. Love Parade).',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 8515,12242 8214,12205 8089,12186
userdel	2 8063,12182 7816,12150 7383,12095 6828,12031
userdel auto	3 7460,12054 7383,12095 7039,12314
userdel auto	3 7039,12314 7383,12095 7460,12054
userdel	3 8119,12414 8063,12182 8048,12135 8034,12093
userdel	3 8034,12093 8048,12135 8063,12182 8119,12414
EOF
     },
     { from  => 1148623200, # 2006-05-26 08:00
       until => 1148767200, # 2006-05-28 00:00
       text  => 'M�gliche Behinderungen wegen eines Flugspektakels am Flughafen Tempelhof, 27.5. von 8 bis 24 Uhr ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 10213,8665 9801,8683 9571,8706 9395,8726 9364,8640 9321,8607 9224,8584
userdel	q4 9395,8726 9303,8781 9222,8787 9221,8732 9224,8584 9223,8409 9224,8254 9229,8029 9227,7797 9231,7657 9236,7324 9234,7287 9234,7220 9235,7146
userdel auto	3 9227,8890 9222,8787 9050,8783
userdel auto	3 9050,8783 9222,8787 9227,8890
EOF
     },
     { from  => 1148767200, # 2006-05-28 00:00
       until => 1150754400, # 2006-06-20 00:00
       text  => 'B 179 Spreewaldstr. OD Zeesen, Einm�nd. zur K.-Liebknecht-Str. Umbau Knotenpunkt Vollsperrung 29.05.2006-19.06.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 26758,-15727 26699,-15709 26583,-15677
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
userdel	2 8119,12414 8122,12600
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
userdel	q4 8595,12066 8581,11896 8571,11846
EOF
     },
     { from  => 1149230977, # 2006-06-02 08:49
       until => 1149544800, # 2006-06-06 00:00
       text  => 'Bl�cherstr., Zossnerstr., Waterlooufer rund um den Bl�cherplatz Veranstaltung, Stra�en vollst�ndig gesperrt (bis 05.06.06)',
       type  => 'gesperrt',
       source_id => 'IM_002848',
       data  => <<EOF,
userdel	2 9522,10017 9444,10000
userdel	2 9811,10055 9522,10017 9536,10064 9579,10122 9592,10174 9812,10211 9851,10219
userdel	2 9401,10199 9592,10174
userdel	2 9579,10122 9689,10124
userdel	2 9811,10055 9827,10120 9849,10202 9851,10219
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
userdel	2::inwork 30221,7373 30118,8128
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
userdel	2::inwork 5791,16910 6042,17189 6118,17327 6154,17438
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
userdel	2::temp 8124,12742 8218,12742 8275,12742 8308,12742 8417,12846 8503,12895
EOF
     },
     { from  => 1149703449, # 2006-06-07 20:04
       until => 1152914400, # 2006-07-15 00:00
       text  => 'Regierungsviertel: im Zuge der Fu�ball-WM mehrere Stra�en gesperrt (bis 14.07.2006)',
       type  => 'gesperrt',
       source_id => 'IM_002870',
       data  => <<EOF,
userdel	2::temp 8168,12848 8209,12816 8218,12742 8218,12601
userdel	2::temp 8775,12457 8540,12420 8400,12417 8374,12416 8119,12414
userdel	2::temp 8032,12817 8124,12840
userdel	2::temp 8307,12601 8308,12742
userdel	2::temp 8032,12817 8017,12826
EOF
     },
     { from  => 1149703543, # 2006-06-07 20:05
       until => 1152914400, # 2006-07-15 00:00
       text  => 'John-Foster-Dulles-Allee (Tiergarten) in beiden Richtungen zwischen Yitzhak-Rabin-Str. und Spreeweg Stra�e vollst�ndig gesperrt, Veranstaltung (im Zuge der WM 2006 bis 14.07.06)',
       type  => 'gesperrt',
       source_id => 'IM_002839',
       data  => <<EOF,
userdel	2::temp 8119,12414 8070,12409 8017,12359 7875,12363 7514,12387 7437,12368 7215,12295 7039,12314
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
userdel	2::temp 8021,11636 8006,11766 8172,11679
userdel	2::temp 7816,12150 7875,12363
userdel	2::temp 7504,11504 7382,11588 7163,11738 7287,11763 7535,11677 7591,11639 7669,11586 7706,11612 7742,11639 7852,11721 8006,11766
userdel	2::temp 7669,11586 7711,11558
userdel	2::temp 8022,12016 8006,11766 7801,11875 7663,11946 7570,11855 7223,11897 7073,11798 7163,11738 6980,11583 6809,11570
userdel	2::temp 7039,12314 7383,12095
userdel	2::temp 7073,11798 6778,11742
userdel	2::temp 8374,12416 8539,12286
userdel	2::temp 7382,11588 7354,11513
userdel	2::temp 6809,11979 7073,11798
userdel	2::temp 8223,11700 8223,11796 8222,11881 8215,12156 8214,12205
userdel	2::temp 8119,12414 8063,12182
userdel	2::temp 8063,12182 8048,12135 8034,12093 8006,12074 7999,12049 8022,12016 8048,12033 8057,12059 8034,12093
userdel	2::temp 8540,12420 8560,12326 8539,12286 8515,12242 8600,12165 8595,12066
userdel	2::temp 8595,12066 8581,11896 8571,11846
EOF
     },
     { from  => undef, # 
       until => 1149833870, # XXX undef
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
userdel	2 6790,16018 6914,15908 6936,15888 7043,15793 7129,15717 7198,15656 7277,15586
EOF
     },
     { from  => 1150581600, # 2006-06-18 00:00
       until => 1151704800, # 2006-07-01 00:00
       text  => 'K 6162 OL Waltersdorf, Siedlung Kienberg, Bau der BAB 113n, Vollsperrung 19.06.2006-30.06.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 20575,-3680 20265,-3849
EOF
     },
     { from  => 1150395890, # 2006-06-15 20:24
       until => 1150754400, # 2006-06-20 00:00
       text  => 'Altstadt K�penick: K�penicker Sommer, Verkehrsbehinderung erwartet (bis 19.06.2006)',
       type  => 'handicap',
       source_id => 'IM_002922',
       data  => <<EOF,
userdel	q4 22439,4838 22445,4758 22381,4752 22377,4836 22196,4847 22138,4661 22111,4562 22162,4546 22312,4593 22358,4521
userdel	q4 22111,4562 22093,4499
userdel	q4 22445,4758 22452,4689 22395,4678 22383,4703 22355,4660 22312,4593 22263,4671 22243,4710 22234,4789
userdel	q4 22147,4831 22043,4562 22071,4501
userdel	q4 22381,4752 22383,4703
EOF
     },
     { from  => 1151532000, # 2006-06-29 00:00
       until => 1152050400, # 2006-07-05 00:00
       text  => 'B 246 OL Bestensee, Hauptstra�e OL Bestensee, Hauptstra�e, Bahn�bergang Bauarbeiten am Gleisk�rper Vollsperrung 30.06.2006-04.07.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 26639,-17861 26752,-17872 26832,-17882
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
userdel	2::inwork -915,22935 -596,23009
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
userdel	q4::inwork 7346,32257 7435,34963 8115,35387
userdel	q4::inwork 7070,34665 7435,34963 7443,36175
EOF
     },
     { from  => 1149026400, # 2006-05-31 00:00
       until => 1157061600, # 2006-09-01 00:00
       text  => 'L 010 Havelberger Str. OD Bad Wilsnack, vom OE bis An der Trift Kanal- und Stra�enbau Vollsperrung 01.06.2006-31.08.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -89549,58784 -89647,59213
EOF
     },
     { from  => 1150754400, # 2006-06-20 00:00
       until => 1157061600, # 2006-09-01 00:00
       text  => 'L 011 Gro�e Str. OD Bad Wilsnack, Einm�nd. zur Havelberger Str. Kanal- und Stra�enbau Vollsperrung 21.06.2006-31.08.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -89647,59213 -89606,59341
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
userdel	2 6240,13324 6112,13327 6011,13330 5956,13330 5857,13342 5705,13359 5560,13382 5368,13406
EOF
     },
     { from  => 1151099435, # 2006-06-23 23:50
       until => 1151290800, # 2006-06-26 05:00
       text  => 'D�rpfeldstr., Ottomar-Geschke-Str. (Treptow) in beiden Richtungen,zwischen Waldstr. und Oberspreestr. Baustelle, Stra�e vollst�ndig gesperrt (bis 26.06.06, 05.00 Uhr)',
       type  => 'gesperrt',
       source_id => 'INKO_64281_COPY_1',
       data  => <<EOF,
userdel	2 20692,3951 21100,4192 21137,4221 21174,4250 21182,4336 21332,4655
EOF
     },
     { from  => 1151101431, # 2006-06-24 00:23
       until => 1155679199, # 2006-08-15 23:59
       text  => 'Corinthstr. - Markgrafendamm: wegen einer Baustelle kann nur der Gehweg genutzt werden (bis Mitte 08.2006)',
       type  => 'handicap',
       source_id => 'INKO_77040_COPY_1',
       data  => <<EOF,
userdel	q4::inwork 14439,10496 14608,10409
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
userdel	2::temp 6653,12067 6642,12010 6685,11954 6744,11936 6809,11979 6828,12031 6799,12083 6754,12108 6725,12113 6690,12104
EOF
     },
     { from  => 1152234000, # 2006-07-07 03:00
       until => 1152504000, # 2006-07-10 06:00
       text  => 'Der gro�e Stern wird zu den Finalspielen am 8.7.2006 von 03.00 Uhr bis zum 10.7.2006 06.00 Uhr gesperrt. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 6653,12067 6642,12010 6685,11954 6744,11936 6809,11979 6828,12031 6799,12083 6754,12108 6725,12113 6690,12104
userdel	2::temp 6540,11754 6685,11954
userdel	2::temp 6825,11486 6809,11570 6778,11742 6744,11936
userdel	2::temp 6653,12067 6178,12387
userdel	2::temp 5901,11902 6642,12010
userdel	2::temp 7039,12314 6799,12083
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
userdel	q4::inwork; 13131,16525 13331,16424
EOF
     },
     { from  => 1153000800, # 2006-07-16 00:00
       until => 1167606000, # 2007-01-01 00:00
       text  => 'K 6413 Berliner Str. OL Buckow, zw. Hauptstr. und OA grundhafter Stra�enbau Vollsperrung 17.07.2006-31.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 55877,18248 55700,18101 55623,17923 55524,17754 55164,17565
EOF
     },
     { from  => 1152568800, # 2006-07-11 00:00
       until => 1152914400, # 2006-07-15 00:00
       text  => 'K 6413 Berliner Str. OL Buckow, zw. Nr. 60 und Waldweg grundhafter Stra�enbau Vollsperrung; Umleitung 12.07.2006-14.07.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 55877,18248 55700,18101 55623,17923 55524,17754 55164,17565
EOF
     },
     { from  => 1152568800, # 2006-07-11 00:00
       until => 1156975200, # 2006-08-31 00:00
       text  => 'L 029 Bahnhofstr. Bahn�bergang in Biesenthal Umbau Bahn�bergang Vollsperrung 12.07.2006-30.08.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 28993,38709 28248,39107 26237,40190
EOF
     },
     { from  => 1152223200, # 2006-07-07 00:00
       until => 1152655200, # 2006-07-12 00:00
       text  => 'L 171 Karl-Marx-Str. OD Hohen Neuendorf, Kno.K.-Tucholsky-Str. Stra�ensanierung halbseitig gesperrt; Einbahnstra�e 08.07.2006-11.07.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 1366,29416 1611,29359
EOF
     },
     { from  => 1152828000, # 2006-07-14 00:00
       until => 1153000800, # 2006-07-16 00:00
       text  => 'B 102 Gro�e Milower Str. OD Rathenow, zw. Eigendorfstr. u. Gr�nauer Weg Neub. B188n, Mont. Stahltr�ger Vollsperrung 15.07.2006-15.07.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -62333,20390 -62269,19881 -62153,19281
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
userdel	q4::inwork 26639,-17861 26650,-18150 26437,-18650 26343,-18775 25475,-19231
EOF
     },
     { from  => 1161366511, # 2006-10-20 19:48
       until => 1161554400, # 2006-10-23 00:00
       text  => 'G�rtelstr., Neue Bahnhofstr. in beiden Richtungen zwischen Boxhagener Str. und Oderstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 22.10.2006) ',
       type  => 'handicap',
       source_id => 'INKO_83811',
       data  => <<EOF,
userdel	q4::inwork 14912,11252 15008,11436 15043,11511 15091,11596
EOF
     },
     { from  => 1152228595, # 2006-07-07 01:29
       until => 1167606000, # 2007-01-01 00:00
       text  => 'Luisenhain ist gesperrt, Umgestaltung bis 2007',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 22196,4847 22147,4831 22043,4562 22071,4501
EOF
     },
     { from  => 1152363677, # 2006-07-08 15:01
       until => 1158357599, # 2006-09-15 23:59
       text  => 'Simon-Dach-Str.: Bauarbeiten an der W�hlischstr., Einbahnstra�e, bis 2006-09-15 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 13890,11411 13954,11647
EOF
     },
     { from  => 1152363870, # 2006-07-08 15:04
       until => 1167605999, # 2006-12-31 23:59
       text  => 'Neubau der Treptower Stra�e in Neuk�lln, Sperrung zwischen Kiefholzstra�e und Heidelberger Stra�e (Anliegerverkehr ist frei) (bis Ende 2006) ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 13857,8601 14015,8798 14140,8977
EOF
     },
     { from  => 1153955394, # 2006-07-27 01:09
       until => 1154124000, # 2006-07-29 00:00
       text  => 'Buschallee (Wei�ensee) in Richtung Hansastr., zwischen Berliner Allee und Hansastr. Baustelle, Stra�e vollst�ndig gesperrt (bis 28.07.06)',
       type  => 'gesperrt',
       source_id => 'INKO_84063',
       data  => <<EOF,
userdel	1::inwork 14621,16563 14809,16525 15134,16499 15388,16502
EOF
     },
     { from  => 1152566231, # 2006-07-10 23:17
       until => 1153860384, # 2006-07-31 23:59 1154383199
       text  => 'Wilhelminenhofstr. (Treptow) Richtung Rathenaustr. zwischen Edisonstr. und Schillerpromenade Baustelle, Fahrtrichtung gesperrt (bis Ende 07.2006)',
       type  => 'handicap',
       source_id => 'INKO_84075',
       data  => <<EOF,
userdel	q4::inwork; 18191,6363 18343,6318 18473,6265 18574,6197 18670,6132 18766,6067 18853,6009
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
userdel	1::inwork 5465,5726 5581,5741
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
userdel	2::inwork 7002,11034 7010,11002 6918,10854
EOF
     },
     { from  => 1153739453, # 2006-07-24 13:10
       until => 1154383199, # 2006-07-31 23:59
       text  => 'Rosestr., Germanenstr. (Treptow) An der Kreuzung Baustelle, Rosestra�e vollst�ndig gesperrt, Germaenstr. teilweise gesperrt (bis Ende 07.2006)',
       type  => 'gesperrt',
       source_id => 'INKO_84204',
       data  => <<EOF,
userdel	2::inwork 21350,852 21202,727 21164,697 21089,639
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
userdel	2::inwork 37875,48253 37532,48149
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
userdel	2::temp 33060,-85292 33101,-85749
EOF
     },
     { from  => 1153805975, # 2006-07-25 07:39
       until => 1162238095, # 2006-10-31 23:59 1162335599
       text  => 'Quitzowstr. (Tiergarten) Richtung Putlitzstr. zwischen Rathenower Str. und Havelberger Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 10.2006)',
       type  => 'handicap',
       source_id => 'INKO_82304',
       data  => <<EOF,
userdel	q4::inwork; 6656,14311 6476,14277
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
userdel	2::inwork 30743,99403 30482,99609
EOF
     },
     { from  => 1163442022, # 2006-11-13 19:20
       until => 1167675622, # 2007-01-01 19:20
       text  => 'Josef-Orlopp-Str. (Lichtenberg) in Richtung Siegfriedstr., zwischen Vulkanstr. und Siegfreidstr. Baustelle, Fahrtrichtung gesperrt (bis 2007)',
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
userdel	q4::inwork; 55549,-4992 55562,-4726
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
userdel	2::temp 5370,6486 5424,6584 5533,6753 5654,6941
EOF
     },
     { from  => 1154203576, # 2006-07-29 22:06
       until => Time::Local::timelocal(reverse(2007-1900,5-1,13,0,0,0)), # 1183240800, # 2007-07-01 00:00 # XXX nicht mehr in VMZ vorhanden!
       text  => 'Karl-Liebknecht-Str. (Mitte) in Richtung Spandauer Str., zwischen Memhardstr.. und Dircksenstr. Baustelle, Stra�e vollst�ndig gesperrt. Ebenfalls Einbahnstra�e: Teile der Dircksenstr. Die Ausfahrt aus der Memhardstra�e in Richtung Ost (Alexanderstra�e) ist nicht m�glich. (bis 2007-05-13) ',
       type  => 'gesperrt',
       source_id => 'IM_003157',
       data  => <<EOF,
userdel	1::inwork 10920,13139 10781,13002
userdel	1::inwork 10781,13002 10706,13043
userdel	3::inwork 10755,13152 10920,13139 11139,13008
EOF
     },
     { from  => 1154203576, # 2006-07-29 22:06
       until => Time::Local::timelocal(reverse(2006-1900,9-1,23,23,59,59)), # XXX nicht mehr in VMZ vorhanden!
       text  => 'Memhardstr. ist Einbahnstra�e Richtung Westen (bis 23. September 2006) ',
       type  => 'gesperrt',
       source_id => 'IM_003157',
       data  => <<EOF,
userdel	1::inwork 10755,13152 10920,13139
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
userdel	1::inwork 11323,12484 11209,12430 11092,12375 11056,12461 10954,12635
userdel	1::inwork 10954,12635 11057,12715 11105,12764 11134,12793
EOF
     },
     { from  => 1154786970, # 2006-08-05 16:09
       until => 1154988000, # 2006-08-08 00:00
       text  => 'Rixdorfer Str. (Treptow) in beiden Richtungen zwischen S�dostallee und Schnellerstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 07.08.2006 5 Uhr)',
       type  => 'handicap',
       source_id => 'INKO_84352',
       data  => <<EOF,
userdel	q4::inwork 16861,5935 17156,6235 17239,6182 17290,6228
EOF
     },
     { from  => 1154876732, # 2006-08-06 17:05
       until => 1156360698, # 1157061599 2006-08-31 23:59
       text  => 'Invalidenstr. in Richtung Tiergartentunnel, zwischen Ackerstr. und Bergstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 08.2006)',
       type  => 'gesperrt',
       source_id => 'INKO_70880',
       data  => <<EOF,
userdel	1::inwork 9810,14066 9663,14036
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
userdel	q4::temp 76771,15413 77081,14637
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
userdel	q4::inwork 20205,-548 20354,-569 20362,-511
EOF
     },
     { from  => undef, # 
       until => 1157843821, # XXX undef
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
userdel	1::inwork 12067,23241 12129,23117 12178,23034
EOF
     },
     { from  => 1155592800, # 2006-08-15 00:00
       until => 1159653600, # 2006-10-01 00:00
       text  => 'B 005 Berliner Str. OD Petershagen, zw. Betonstr. und Ortsausgang Kanal- und Stra�enbauarbeiten Vollsperrung 16.08.2006-30.09.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 73775,831 74246,584
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
userdel	1::inwork 17290,6228 17239,6182 17156,6235 16861,5935
EOF
     },
     { from  => 1155836502, # 2006-08-17 19:41
       until => 1156129200, # 2006-08-21 05:00
       text  => 'Kurf�rstendamm/ Tauentzienstr. (Charlottenburg) in beiden Richtungen zwischen Uhlandstr. und Passauer Str. Stra�enfest (Global City), Stra�e gesperrt (bis 21.08.2006, 5:00 Uhr) (18:00) ',
       type  => 'gesperrt',
       source_id => 'IM_003267',
       data  => <<EOF,
userdel	2::temp 6137,10689 6040,10751 5942,10803 5797,10881 5725,10892 5657,10868 5484,10810 5351,10760 5229,10716 5076,10658
EOF
     },
     { from  => 1156888800, # 2006-08-30 00:00
       until => 1157148000, # 2006-09-02 00:00
       text  => 'L 401 K�nigs Wusterhausen-Wildau OL K�nigs Wusterhausen, H�he Neue Ziegelei Deckeneinbau Vollsperrung 31.08.2006-01.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 26437,-10393 26418,-10758 26407,-10986
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
userdel	2::temp 8595,12066 8600,12165 8515,12242
userdel	2::temp 8119,12414 8063,12182
EOF
     },
     { from  => 1156358040, # 2006-08-23 20:34
       until => 1158336000, # 2006-09-15 18:00
       text  => 'Berlin Wei�ensee, Buschallee, Wei�ensee Richtung Ahrensfelde Zwischen Einm�ndung Berliner Allee und Kreuzung Hansastra�e Baustelle, gesperrt bis 15.09.2006 18:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 14621,16563 14809,16525 15134,16499 15388,16502 15432,16500
EOF
     },
     { from  => 1156478400, # 2006-08-25 06:00
       until => 1156716000, # 2006-08-28 00:00
       text  => 'Stra�enfest am Kaiserdamm. Die Fahrbahn Richtung Theodor-Heuss-Platz ist vom 26.08.2006, 6.00 Uhr, von der Sophie-Charlotten- bis zur K�nigin-Elisabeth-Stra�e bis zum 28.08.2006, 0.00 Uhr gesperrt.',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::temp 2612,11491 2390,11468 2282,11463 2191,11451 2109,11441
EOF
     },
     { from  => 1156454823, # 2006-08-24 23:27
       until => 1156802399, # 2006-08-28 23:59
       text  => 'Vom 26. August 2006, 13 Uhr bis zum 28. August 2006, 4 Uhr ist der Verkehr in der M��llendorffstra��e im Abschnitt zwischen der Stra��e Am Containerbahnhof und der Frankfurter Allee gesperrt.',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 15349,12073
EOF
     },
     { from  => 1154815200, # 2006-08-06 00:00
       until => 1164927599, # 2006-11-30 23:59
       text  => 'Hegemeisterweg ist vom 7. August 2006 bis zum 30. November 2006 nicht benutzbar. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 17775,7874 17987,7973 18387,7742
EOF
     },
     { from  => 1156975200, # 2006-08-31 00:00
       until => 1157320799, # 2006-09-03 23:59
       text  => 'Turmstra�enfest vom 01.09. bis 03.09.2006 (zwischen Strom- und Waldstra�e) ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 5368,13406 5560,13382 5705,13359 5857,13342 5956,13330 6011,13330 6112,13327 6240,13324
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
userdel	2::inwork -13946,-56116 -13817,-54938 -13601,-53865
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
userdel	1::inwork 18853,6009 18766,6067 18670,6132 18574,6197 18473,6265 18343,6318 18191,6363 17992,6436
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
userdel	2::inwork 42175,-37437 42793,-36256 43200,-36012
EOF
     },
     { from  => 1164236400, # 2006-11-23 00:00
       until => 1166828400, # 2006-12-23 00:00
       text  => 'L 075 Karl-Marx-Str. OD Gro�ziehten Stra�enbauarbeiten Vollsperrung 24.11.2006-22.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 13225,-681 13090,205 12984,1011
EOF
     },
     { from  => 1156629600, # 2006-08-27 00:00
       until => 1185919200, # 2007-08-01 00:00
       text  => 'L 201 OD Falkensee OD Falkensee, Falkenhagener Str. Stra�enbau Vollsperrung 28.08.2006-31.07.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -10661,17873 -10926,17992
EOF
     },
     { from  => 1156976097, # 2006-08-31 00:14
       until => 1167605999, # 2006-12-31 23:59
       text  => 'Hauptstr. (Pankow) in beiden Richtungen, in H�he Edelwei�str., zwischen Goethestr. und Garibaldistr. Baustelle, Verkehr wird wechselseitig vorbeigef�hrt (bis Ende 2006)',
       type  => 'handicap',
       source_id => 'INKO_84070',
       data  => <<EOF,
userdel	q4::inwork 7832,20219 7790,20132 7755,20059 7716,19954
EOF
     },
     { from  => undef, # 
       until => Time::Local::timelocal(reverse(2007-1900,7-1,9,0,0,0)), # 1185833757, # 2007-07-31 00:15
       text  => 'Pistoriusstr. (Pankow) Richtung Berliner Allee zwischen Hamburger Platz und Roelckstr. Baustelle, Fahrtrichtung gesperrt, eine Umleitung ist eingerichtet (bis Mitte 2007) (10:34) ',
       type  => 'gesperrt',
       source_id => 'INKO_77722',
       data  => <<EOF,
userdel	1::inwork 12693,16700 12874,16631 13131,16525
EOF
     },
     { from  => 1156976256, # 2006-08-31 00:17
       until => 1157580000, # 2006-09-07 00:00
       text  => 'Regattastr. (K�penick) in beiden Richtungen zwischen Rabindranath-Tagore-Str. und Steinbindeweg Baustelle, Stra�e vollst�ndig gesperrt (bis 06.09.2006)',
       type  => 'gesperrt',
       source_id => 'IM_003411',
       data  => <<EOF,
userdel	2::inwork 23277,776 23085,898
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
userdel	2::inwork -62153,19281 -62269,19881 -62333,20390
EOF
     },
     { from  => 1156975200, # 2006-08-31 00:00
       until => 1157320800, # 2006-09-04 00:00
       text  => 'L 015 B109 s�dl. Prenzlau-Boitzenburg OD Gollmitz Einbau Deckschicht Vollsperrung 01.09.2006-03.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30743,99403 30482,99609
EOF
     },
     { from  => 1157138648, # 2006-09-01 21:24
       until => 1157335200, # 2006-09-04 04:00
       text  => 'Landsberger Allee (Friedrichshain - Kreuzberg) in Richtung stadteinw�rts zwischen Virchowstr. und Friedensstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 04.09.2006 4.00 Uhr)',
       type  => 'handicap',
       source_id => 'INKO_83350',
       data  => <<EOF,
userdel	q4::inwork; 12975,13266 12909,13231 12808,13181 12727,13159 12582,13128 12386,13085
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
userdel	1::inwork -89549,58784 -89647,59213
EOF
     },
     { from  => 1157234400, # 2006-09-03 00:00
       until => 1157580000, # 2006-09-07 00:00
       text  => 'L 401 R.-Sorge-Str./ Bergstr. Bahn�bergang Bergstr. in OL Wildau Arbeiten am B� Vollsperrung; Umleitung 04.09.2006-06.09.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 26381,-9962 26339,-9943 25700,-9502
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
userdel	2::inwork 22967,4144 23435,4179
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
userdel	q4::inwork 18061,19097 18074,19227 18109,19352
EOF
     },
     { from  => 1159826400, # 2006-10-03 00:00
       until => 1165618800, # 2006-12-09 00:00
       text  => 'B 002 Eberswalde-Angerm�nde zw. Abzw. Britz und B� Chorin Deckenerneuerung Vollsperrung 04.10.2006-08.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 38845,51258 41075,53327 41587,53787 41654,53939 41847,54619 42231,54671 42595,54932 42742,54938 42749,55043 42452,55538 42981,57104 43462,57600 43581,57725
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
userdel	2::inwork 30773,54731 31076,54246
EOF
     },
     { from  => 1158865257, # 2006-09-21 21:00
       until => 1159156800, # 2006-09-25 06:00
       text  => 'Stra�e des 17. Juni und Yitzak-Rabin-Str. wegen Marathonvorbereitungen gesperrt (bis 25.09.06, 06.00 Uhr)',
       type  => 'handicap',
       source_id => 'IM_003565',
       data  => <<EOF,
userdel	q4::temp 8515,12242 8214,12205 8089,12186
userdel	q4::temp 8119,12414 8063,12182 7816,12150 7383,12095 6828,12031
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
userdel	2::inwork 12841,9368 12785,9443 12569,9547
EOF
     },
     { from  => 1160172484, # 2006-10-07 00:08
       until => 1160604000, # 2006-10-12 00:00
       text  => 'Stargarder Str. (Prenzlauer Berg) Richtung Sch�nhauser Allee zwischen Pappelallee und Greifenhagener Str. Baustelle, Fahrtrichtung gesperrt (bis 11.10.2006)',
       type  => 'gesperrt',
       source_id => 'IM_003670',
       data  => <<EOF,
userdel	1::inwork 11301,15668 11192,15721 11093,15771
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
userdel	1::inwork 17156,6235 16861,5935
EOF
     },
     { from  => 1159221600, # 2006-09-26 00:00
       until => 1161208800, # 2006-10-19 00:00
       text  => 'B 168 zw. Trampe und Eberswalde Deckenerneuerung Vollsperrung 27.09.2006-18.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 38522,47634 38653,47410 38723,47134 39446,42585
EOF
     },
     { from  => 1159426800, # 2006-09-28 09:00
       until => 1159934400, # 2006-10-04 06:00
       text  => 'Stra�e des 17. Juni zwischen Yitzhak-Rabin-Str.(ausschl.) und Ebertstr.(einschl.), Platz des 18. M�rz und Pariser Platz, Ebertstr. zwischen Behrenstr. und Scheidemannstr. sowie Scheidemannstr./Dorotheenstr. zwischen Yitzhak-Rabin-Str. und Wilhelmstr. gesperrt f�r das Deutschlandfest. Dauer: 29.09.2006 09:00 Uhr bis 04.10.2006 06:00 Uhr. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 8063,12182 8089,12186 8214,12205 8515,12242 8539,12286 8560,12326 8540,12420
userdel	2::temp 8610,12254 8515,12242 8600,12165 8595,12066
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
userdel	q4::inwork 11019,-8435 11555,-8625
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
       text  => 'Residenzstr. (Wedding) in beiden Richtungen, zwischen Lindauer Alle und Pankower Allee Veranstaltung, Stra�e vollst�ndig gesperrt (bis 04.10.06, 01.00 Uhr) ',
       type  => 'gesperrt',
       source_id => 'IM_003701',
       data  => <<EOF,
userdel	2::temp 7587,17532 7500,17796 7487,17836 7466,17904 7445,17968 7439,17985 7350,18262 7232,18572
EOF
     },
     { from  => undef, # 
       until => Time::Local::timelocal(reverse(2008-1900,9-1,13,0,0,0)), # laut Tsp vom 2008-01-22
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
userdel	q4::inwork 76131,90452 76075,90647 76078,90752
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
userdel	q4::inwork 7435,34963 7443,36175
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
userdel	2::inwork 9220,-90110 9366,-90900
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
userdel	2::inwork -6631,-9207 -6181,-10412
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
userdel	2::inwork 80143,-15900 79825,-16575
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
     { from  => 1160214543, # 2006-10-07 11:49
       until => 1160258400, # 2006-10-08 00:00
       text  => 'Akazienstr. in beiden Richtungen, zwischen Apostel-Paulus-Str. und Grunewaldstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 08.10.06, 00.00 Uhr) ',
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
userdel	2::temp 11979,8014 12001,7937 12025,7852 12041,7788 12055,7751 12075,7696 12090,7651 12122,7553 12180,7387
EOF
     },
     { from  => 1160107200, # 2006-10-06 06:00
       until => 1161360000, # 2006-10-20 18:00
       text  => 'Ehrlichstra�e zwischen Trautenauerstra�e und Blockdammweg gesperrt. Dauer 07.10.2006 06:00 Uhr bis 20.10.2006 18:00 Uhr. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 17729,8850 17879,8773 18080,8626 18147,8583
EOF
     },
     { from  => 1160107200, # 2006-10-06 06:00
       until => 1160431200, # 2006-10-10 00:00
       text  => 'Grunewaldstra�e zwischen Hauptstr. und Schw�bische Stra�e gesperrt, 7. Sch�neberger K�rbisfest, Dauer: 07.10.2006 06:00 Uhr bis 09.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 6923,9266 7006,9282 7130,9305 7201,9318 7374,9350 7478,9340
EOF
     },
     { from  => 1160517600, # 2006-10-11 00:00
       until => 1160776800, # 2006-10-14 00:00
       text  => 'B 087 Luckau - Duben zwischen OA Duben u. Abzweig Freiimfelde (Altenoer Str.) Fahrbahnsanierung Vollsperrung 12.10.2006-13.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 39767,-55820 39067,-56134 37549,-57430 36050,-58754
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
userdel	2::inwork -62153,19281 -62269,19881
EOF
     },
     { from  => 1160431200, # 2006-10-10 00:00
       until => 1166828400, # 2006-12-23 00:00
       text  => 'L 011 Wittenberger Str. OD Bad Wilsnack, zw. Karthanebr�cke u. Wedenstr. Kanal- und Stra�enbau Vollsperrung 11.10.2006-22.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -91328,59520 -89647,59213
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
userdel	2::temp 12500,8504 12540,8458 12582,8408 12598,8390 12639,8344 12689,8289 12714,8249 12753,8187 12794,8103 12830,8031 12865,7923 12898,7832 12914,7785 12980,7597
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
userdel	2::inwork 28975,69975 28132,70222 26843,71276 26511,71453
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
userdel	q4::inwork 16934,3571 17142,3393
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
userdel	q4::inwork 69341,80383 69442,80070 69400,79825
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
userdel	q4::inwork 49258,68818 49566,68311
EOF
     },
     { from  => 1160863200, # 2006-10-15 00:00
       until => 1161381600, # 2006-10-21 00:00
       text  => 'B 198 Pol�en-Gramzow zw. Meichow und Neumeichow Stra�eninstandsetzung Vollsperrung 16.10.2006-20.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 48676,87452 48856,87456 49525,88337
EOF
     },
     { from  => 1161468000, # 2006-10-22 00:00
       until => 1167519600, # 2006-12-31 00:00
       text  => 'B 198 Pol�en-Gramzow zw. Neimeichow und B166 OL Gramzow grundhafter Ausbau Vollsperrung 23.10.2006-30.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 49525,88337 49932,88969 49930,89857
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
userdel	q4::temp 8437,15894 8278,16043 8236,16071
EOF
     },
     { from  => 1161326842, # 2006-10-20 08:47
       until => 1161468000, # 2006-10-22 00:00
       text  => 'Str. des 17. Juni (Tiergarten) in beiden Richtungen zwischen Y.-Rabin-Str. und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (bis 21.10.2006 nachts)',
       type  => 'handicap',
       source_id => 'IM_003841',
       data  => <<EOF,
userdel	q4::temp 8515,12242 8214,12205 8089,12186
EOF
     },
     { from  => 1161366455, # 2006-10-20 19:47
       until => 1161468000, # 2006-10-22 00:00
       text  => 'Ebertstr. (Tiergarten) Richtung Potsdamer Platz zwischen Scheidemannstr. und Behrenstr. Veranstaltung, Fahrtrichtung gesperrt (bis 21.10.2006 nachts)',
       type  => 'handicap',
       source_id => 'IM_003842',
       data  => <<EOF,
userdel	q4::temp 8595,12066 8600,12165 8515,12242 8539,12286 8560,12326 8540,12420
userdel	q4::temp 8542,11502 8548,11552
EOF
     },
     { from  => undef, # 
       until => 1161442800, # 2006-10-21 17:00
       text  => 'Spandauer Str. (Mitte) in beiden Richtungen zwischen Karl-Liebknecht-Str. und Grunerstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis ca. 17:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_003844',
       data  => <<EOF,
userdel	2::temp 10738,12364 10684,12423 10644,12469 10596,12517 10440,12696
EOF
     },
     { from  => 1161542089, # 2006-10-22 20:34
       until => 1161986400, # 2006-10-28 00:00
       text  => 'Lankestr. gesperrt bis 27.10.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -9952,-109 -9942,21
EOF
     },
     { from  => 1161712875, # 2006-10-24 20:01
       until => 1162335599, # 2006-10-31 23:59
       text  => 'Loewenhardtdamm (Tempelhof) Richtung Manfred-von-Richthofen-Str. zwischen General-Pape-Str. und Bayernring Baustelle, Fahrtrichtung gesperrt (bis Ende 10.2006)',
       type  => 'gesperrt',
       source_id => 'IM_003899',
       data  => <<EOF,
userdel	1::inwork 8306,8722 8318,8692 8371,8543
EOF
     },
     { from  => 1162681200, # 2006-11-05 00:00
       until => 1163804400, # 2006-11-18 00:00
       text  => 'B 246 Bahn�bergang in der OD Bestensee Umbauarbeiten Vollsperrung 06.11.2006-17.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 26639,-17861 26752,-17872 26832,-17882
EOF
     },
     { from  => 1160604000, # 2006-10-12 00:00
       until => 1163199600, # 2006-11-11 00:00
       text  => 'L 033 Odervorstadt Bahn�bergang in der OD Wriezen Fahrbahninstandsetzung Vollsperrung 13.10.2006-10.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 60086,36267 59990,36267 59876,36115
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
userdel	2::inwork 20949,4775 21089,4731 21332,4655
EOF
     },
     { from  => 1163800165, # 2006-11-17 22:49
       until => 1165618800, # 2006-12-09 00:00
       text  => 'Kynaststr (Lichtenberg) in Richtung Marktstr., zwischen Haupstr. und Markstr. Baustelle, Fahrtrichtung gesperrt (bis 08.12.06)',
       type  => 'handicap',
       source_id => 'IM_003935',
       data  => <<EOF,
userdel	q4::inwork; 14881,10864 14897,10935 14988,11130
EOF
     },
     { from  => 1155592800, # 2006-08-15 00:00
       until => 1166570964, # 1166828400 2006-12-23 00:00
       text  => 'B 005 Berliner Str. OD Petershagen, zw. Betonstr. und Ortsausgang Kanal- und Stra�enbauarbeiten Vollsperrung 16.08.2006-22.12.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 74246,584 73775,831 73479,1000
EOF
     },
     { from  => 1162422000, # 2006-11-02 00:00
       until => 1162767600, # 2006-11-06 00:00
       text  => 'B 109 Prenzlauer Allee OD Templin, ab A.-Bebel-Str. bis OA Einbau Deckschicht Vollsperrung 03.11.2006-05.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 16463,79756 16850,79712 17455,80199
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
userdel	q4::inwork 11603,15455 11638,15522
EOF
     },
     { from  => 1162508400, # 2006-11-03 00:00
       until => 1162767600, # 2006-11-06 00:00
       text  => 'L 745 Motzener Str. OD Gallun Deckenerneuerung Vollsperrung 04.11.2006-05.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 21970,-18337 22324,-18950
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
userdel	q4::inwork 7360,8918 7325,8936 7320,8939 7275,8960
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
userdel	2::inwork 33589,15778 32985,17127 32665,17841
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
userdel	3::inwork 13206,10651 13178,10623 13135,10551
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
userdel	2::inwork 25585,6050 25776,6054 26221,6229 28794,7219 29168,7350
EOF
     },
     { from  => 1163286000, # 2006-11-12 00:00
       until => 1163545200, # 2006-11-15 00:00
       text  => 'L 086 Gro� Kreutz-Schmergow Bahn�bergang in der OL Gro� Kreutz Instandsetzungsarbeiten Vollsperrung 13.11.2006-14.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -31993,-726 -32143,-211 -32163,-143
EOF
     },
     { from  => 1163480400, # 2006-11-14 06:00
       until => 1167433200, # 2006-12-30 00:00
       text  => 'Bereich Oberwallstr., Niederlagstr., Hinter der Katholischen Kirche, Am Schinkelplatz gesperrt Grund : Veranstaltung (Weihnachtsmarkt am Opernpalais) Dauer: 15.11.2006 06:00 Uhr bis 29.12.2006 24:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 9890,12161 9875,12254 9801,12245 9782,12393
userdel	2::temp 9875,12254 9853,12402
userdel	2::temp 9801,12245 9812,12145
userdel	2::temp 10008,12378 9926,12368 9972,12184
userdel	2::temp 9918,12411 9926,12368
EOF
     },
     { from  => 1163718000, # 2006-11-17 00:00
       until => 1164150000, # 2006-11-22 00:00
       text  => 'L 338 Rosa-Luxemburg-Damm/ Hauptstr. Bahn�bergang in der OL Neuenhagen Erneu. Gleisanlagen Vollsperrung 18.11.2006-21.11.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 30179,13667 30795,13191 30815,13170 30975,12918
EOF
     },
     { from  => undef, # 
       until => 1167678155, # 2007-01-01 20:02
       text  => 'Bauarbeiten am Maybachufer zwischen Pannierstr. und Weichselstr., Behinderungen m�glich',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 12841,9368 12785,9443 12569,9547
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
userdel	q4::inwork; 15349,12073 15288,11968 15243,11881 15203,11807 15091,11596
EOF
     },
     { from  => undef, # 
       until => 1166139296, # 2006-12-15 00:34
       text  => 'Einemstr. (Sch�neberg) in Richtung Nollendorfplatz, hinter Kurf�rstenstr. Baustelle, Fahrtrichtung gesperrt (bis Mitte Dezember)',
       type  => 'handicap',
       source_id => 'IM_004168',
       data  => <<EOF,
userdel	q4::inwork; 6972,10665 6985,10597 7003,10513 7037,10359
EOF
     },
     { from  => 1163977200, # 2006-11-20 00:00
       until => 1164754800, # 2006-11-29 00:00
       text  => 'B 166 Berliner Str., Lindenallee OD Schwedt Deckenerneuerung Vollsperrung 21.11.2006-28.11.2006 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 69480,73471 69238,73315
EOF
     },
     { from  => 1164612153, # 2006-11-27 08:22
       until => 1164656874, # 2006-12-15 23:59 1166223599
       text  => 'Oranienburger Str. (Reinickendorf) in Richtung stadteinw�rts, zwischen Jansenstr. und Tessenowstr. Baustelle, Fahrtrichtung gesperrt (bis Mitte Dezember 2006)',
       type  => 'gesperrt',
       source_id => 'IM_004175',
       data  => <<EOF,
userdel	1::inwork 5533,19811 5476,19450
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
userdel	1::inwork 8211,17585 8095,17574 7998,17564 7915,17557 7841,17551 7675,17538 7587,17532
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
userdel	2::inwork -62269,19881 -62333,20390
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
userdel	1::inwork 10305,13211 10264,13097
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
userdel	q4::inwork 48203,79315 47124,77624
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
userdel	2::inwork 25185,-3955 25269,-4041 25372,-4019
EOF
     },
     { from  => 1166050800, # 2006-12-14 00:00
       until => 1166482800, # 2006-12-19 00:00
       text  => 'B 168 Frankfurter Chaussee Bahn�bergang Bahnhof Oegeln Gleisbauarbeiten Vollsperrung 15.12.2006-18.12.2006 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 70984,-23637 70075,-24862
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
userdel	q4::temp 8089,12186 8214,12205 8515,12242
EOF
     },
     { from  => undef, # 
       until => 1168288741, # 2007-07-01 00:00 1183240800
       text  => 'Treptower Str. (Treptow) in beiden Richtungen zwischen Kiefholzstr. und Harzer Str. Baustelle Stra�e vollst�ndig gesperrt (f�r Anlieger aber befahrbar!) (bis Mitte 2007) (16:10) ',
       type  => 'gesperrt',
       source_id => 'IM_004418',
       data  => <<EOF,
userdel	2::inwork 14140,8977 14015,8798 13857,8601
EOF
     },
     { from  => 1171050907, # 2007-02-09 20:55
       until => 1183240799, # 2007-06-30 23:59
       text  => 'Nennhauser Damm (Spandau) Richtung Brunsb�tteler Damm nach Heerstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 06.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004443',
       data  => <<EOF,
userdel	1::inwork -8784,13321 -8756,13356 -8358,13340 -8034,13339 -7693,13330
EOF
     },
     { from  => 1178865859, # 2007-05-11 08:44
       until => 1180648799, # 2007-05-31 23:59
       text  => 'Oranienstr. und Lobeckstr. (Kreuzberg) in beiden Richtungen an der Kreuzung Baustelle, Oranienstr. auf einen Fahrstreifen je Richtung verengt, Lobeckstr. Einbahnstr. Richtung Ritterstr. (bis Ende 05.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004447',
       data  => <<EOF,
userdel	1::inwork 10572,10773 10673,10975
EOF
     },
     { from  => 1168462111, # 2007-01-10 21:48
       until => 1168556400, # 2007-01-12 00:00
       text  => 'Schiffbauerdamm (Mitte) in beiden Richtungen zwischen Luisenstr. und Albrechtstr. Kraneinsatz, Stra�e vollst�ndig gesperrt (bis 11.01.2007 abends)',
       type  => 'gesperrt',
       source_id => 'IM_004454',
       data  => <<EOF,
userdel	2::temp 9106,12795 8852,12636
EOF
     },
     { from  => 1168898272, # 2007-01-15 22:57
       until => 1169215200, # 2007-01-19 15:00
       text  => 'Hultschiner Damm zwischen Alt-Mahlsdorf und Elsenstr. gesperrt, geplatzte Wasserleitung bis 19.01.2007 15:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 24637,10807 24735,11021 24658,11293
EOF
     },
     { from  => 1182281811, # 2007-06-19 21:36
       until => 1184018400, # 2007-07-10 00:00
       text  => 'Kaulsdorfer Br�cke (Hellerdorf) in beiden Richtungen Baustelle, Br�cke gesperrt (bis 09.07.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004489',
       data  => <<EOF,
userdel	2::inwork 22688,12007 22669,12049 22693,12084
EOF
     },
     { from  => undef, # 2007-01-15 22:59 1168898369
       until => 1185227672 , # 2008-06-30 23:59 1178221318 1214863199 undef
       text  => 'Weinmeisterstr. (Mitte) in Richtung M�nzstr. Baustelle, Fahrtrichtung gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_004491',
       data  => <<EOF,
userdel	1::inwork 10331,13397 10528,13243
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
userdel	1::inwork 18528,8331 18615,8269 18683,8232
EOF
     },
     { from  => 1169496024, # 2007-01-22 21:00
       until => 1169938800, # 2007-01-28 00:00
       text  => 'H�nower Str. (Hellersdorf) Richtung Ridbacher Str. zwischen Fritz-Reuter-Str. und Wilhelmsm�henweg Baustelle, Fahrtrichtung gesperrt (bis 27.01.2007)',
       type  => 'handicap',
       source_id => 'IM_004559',
       data  => <<EOF,
userdel	q4::inwork; 24623,11684 24652,11794 24578,11928
EOF
     },
     { from  => 1190067630, # 2007-09-18 00:20
       until => 1190498400, # 2007-09-23 00:00
       text  => 'G�rtelstr. (Friedrichshain) in beiden Richtungen zwischen Scharnweberstr. und Dossestr. Baustelle, Stra�e vollst�ndig gesperrt (bis 22.09.2007)',
       type  => 'handicap',
       source_id => 'IM_006669',
       data  => <<EOF,
userdel	q4::inwork 15203,11807 15243,11881
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
userdel	2::inwork 11603,15455 11638,15522
EOF
     },
     { from  => 1169839019, # 2007-01-26 20:16
       until => 1170370799, # 2007-02-01 23:59
       text  => 'Hultschiner Damm (Mahlsdorf) in beiden Richtungen zwischen Alt Mahlsdorf und Elsenstr. Stra�e vollst�ndig gesperrt, Rohrbruch (bis Anfang 02/2007)',
       type  => 'gesperrt',
       source_id => 'IM_004452',
       data  => <<EOF,
userdel	2::inwork 24637,10807 24735,11021 24658,11293
EOF
     },
     { from  => 1170098849, # 2007-01-29 20:27
       until => 1171062000, # 2007-02-10 00:00
       text  => 'Hauptstr. (Pankow) in Richtung stadteinw�rts, zwischen Bucherstr. und Blankenfelder Str. Baustelle, Fahrtrichtung gesperrt (bis 09.02.07)',
       type  => 'gesperrt',
       source_id => 'IM_004638',
       data  => <<EOF,
userdel	1::inwork 12178,23034 12213,22884 12187,22486
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
userdel	2::inwork 86769,1414 87351,3652
EOF
     },
     { from  => 1173515301, # 2007-03-10 09:28
       until => 1177970399, # 2007-04-30 23:59
       text  => 'Dunckerstr. (Prenzlauer Berg) in beiden Richtungen, Kreuzung Stargarder Str. Baustelle, Stra�e vollst�ndig gesperrt (bis 04.2007)',
       type  => 'gesperrt',
       source_id => 'IM_003972',
       data  => <<EOF,
userdel	2::inwork 11603,15455 11638,15522
EOF
     },
     { from  => 1181426400, # 2007-06-10 00:00
       until => 1195308700, # 2008-01-01 00:00 1199142000
       text  => 'L 090 Dr.-K�lz-Str. OD Glindow, zw. Alte Str. und Alpenstr. Kanal- und Stra�enbau Vollsperrung 11.06.2007-31.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -22914,-5137 -22867,-5778
EOF
     },
     { from  => 1171051156, # 2007-02-09 20:59
       until => 1171148400, # 2007-02-11 00:00
       text  => 'Bellevuestr. (K�penick) in beiden Richtungen zwischen F�rstenwalder Damm und Seelenbinderstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 10.02.2007 22 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_004721',
       data  => <<EOF,
userdel	2::inwork 23402,5483 23333,5731
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
userdel	2::inwork 31076,54246 30773,54731
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
       until => 1183500687, # XXX aufgehoben von steini
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
userdel	q4::inwork 25012,5754 24700,5633 23950,5342
EOF
     },
     { from  => 1172530621, # 2007-02-26 23:57
       until => 1173999599, # 2007-03-15 23:59
       text  => 'Hildburghauser Str. (Steglitz) in beiden Richtungen zwischen Oberhofer Weg und Geraer Str. Baustelle, Fahrbahn auf einen Fahrstreifen verengt, Verkehr wird wechselseitig vorbeigef�hrt (bis Mitte 03.2007)',
       type  => 'handicap',
       source_id => 'IM_004793',
       data  => <<EOF,
userdel	q4::inwork 5414,1304 5560,1278 5740,1227
EOF
     },
     { from  => 1172646005, # 2007-02-28 08:00
       until => 1175032135, # 1175378399 2007-03-31 23:59
       text  => 'Kastanienallee (Pankow) Richtung Sch�nhauser Str. zwischen Friedrich-Engels-Str. und Eschenallee Baustelle, Fahrtrichtung gesperrt (bis Ende 03.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004803',
       data  => <<EOF,
userdel	1::inwork 8900,20601 9025,20611 9476,20647 9655,20703 9737,20728 9848,20764
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
userdel	2::inwork 12984,1011 13090,205
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
userdel	2::inwork -12451,-9641 -12751,-8997 -12835,-8819
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
       until => 1176488053, # XXX undef
       text  => 'Kietzer Str. (K�penick) in beiden Richtungen, zwischen Gr�nstr. und Rosenstr. geplatzte Wasserleitung',
       type  => 'gesperrt',
       source_id => 'IM_004874',
       data  => <<EOF,
userdel	2::inwork 22312,4593 22263,4671
EOF
     },
     { from  => 1173135600, # 2007-03-06 00:00
       until => 1178575200, # 2007-05-08 00:00
       text  => 'L 040 Zossener Damm OD Blankenfelde, zw. Kreisverkehr u. K.-Liebknecht-Str. Stra�enausbau Vollsperrung 07.03.2007-07.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10115,-8276 11019,-8435
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
userdel	2::inwork 74092,475 74246,584
EOF
     },
     { from  => 1173308400, # 2007-03-08 00:00
       until => 1173740400, # 2007-03-13 00:00
       text  => 'L 742 Klein K�ris-Teupitz Bahn�bergang in der OD Gro� K�ris Gleisumbauarbeiten Vollsperrung 09.03.2007-12.03.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 28494,-27010 28010,-27154 27824,-27205
EOF
     },
     { from  => 1173913200, # 2007-03-15 00:00
       until => 1174345200, # 2007-03-20 00:00
       text  => 'L 023 Storkow-Herzfelde Bahn�bergang Fangschleuse Gleisbauarbeiten Vollsperrung 16.03.2007-19.03.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 39225,1082 39259,612 39264,-832
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
userdel	2::inwork 8306,8722 8237,8685 8206,8596 7932,7790
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
userdel	1::inwork 12000,10531 12056,10655
userdel	1::inwork 11949,10414 11833,10206 11735,10022
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
       until => 1174068889, # XXX
       text  => 'Bethaniendamm (Mitte) Kreuzung Leuschnerdamm Baustelle, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'INKO_86548_COPY_1',
       data  => <<EOF,
userdel	2::inwork 11461,11145 11421,11073
EOF
     },
     { from  => 1174172400, # 2007-03-18 00:00
       until => 1185141600, # 2007-07-23 00:00
       text  => 'B 273 Breite Str. OD Oranienburg, zw. Berliner Str. u. Havelstr. Stra�enbauarbeiten Vollsperrung 19.03.2007-22.07.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -1571,38406 -1553,38501 -1517,38543 -1500,38565
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
userdel	2::inwork 38475,90762 38637,91275 38612,91950
EOF
     },
     { from  => 1174068849, # 2007-03-16 19:14
       until => 1222812000, # 2008-10-01 00:00
       text  => 'Reichstagufer (Mitte) in beiden Richtungen Baustelle, Stra�e vollst�ndig gesperrt, Fu�g�nger k�nnen passieren (bis 30.09.2008)',
       type  => 'handicap',
       source_id => 'IM_004994',
       data  => <<EOF,
userdel	q4::inwork 9098,12687 9209,12795 9283,12856
EOF
     },
     { from  => 1174068872, # 2007-03-16 19:14
       until => 1174172400, # 2007-03-18 00:00
       text  => 'Stra�e des 17. Juni (Tiergarten) in beiden Richtungen zwischen Gro�er Stern und Y.-Rabin-Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 17.03.2007 24.00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_004977',
       data  => <<EOF,
userdel	2::temp 8063,12182 7816,12150 7383,12095 6828,12031
EOF
     },
     { from  => 1174115692, # 2007-03-17 08:14
       until => 1174287358, # 1174345200 2007-03-20 00:00
       text  => 'Bahnhofstr. (K�penick) in beiden Richtungen in H�he der Bahnhofsbr�cke Br�ckenarbeiten, Stra�e vollst�ndig gesperrt, eine Umleitung ist eingerichtet (bis 19.03.2007 04 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_004990',
       data  => <<EOF,
userdel	2::inwork 22428,6063 22475,6151
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
userdel	q4::inwork 28589,49775 27634,49953
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
userdel	2::temp 8540,12420 8560,12326 8539,12286 8515,12242 8214,12205 8089,12186 8063,12182
userdel	2::temp 8595,12066 8600,12165 8515,12242
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
userdel	2::inwork 22428,6063 22475,6151
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
userdel	2::temp 8861,12125 8737,12098 8595,12066
EOF
     },
     { from  => undef, # 
       until => 1174788000, # 2007-03-25 04:00
       text  => 'Kurf�rstendamm Charlottenburg, von Uhlandstra�e bis Wittenbergplatz Veranstaltung; Stra�e gesperrt Lange Nacht des Shoppings',
       type  => 'gesperrt',
       source_id => 'IM_005040',
       data  => <<EOF,
userdel	2::temp 6137,10689 6040,10751 5942,10803 5797,10881 5725,10892 5657,10868 5484,10810 5351,10760 5229,10716 5076,10658
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
userdel	1::inwork 10459,17754 10548,17817 10705,17931 10846,17992
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
userdel	2::inwork 45124,-52888 45152,-53482 45088,-55645
EOF
     },
     { from  => 1177020000, # 2007-04-20 00:00
       until => 1177365600, # 2007-04-24 00:00
       text  => 'L 049 L�bbenau-L�bben Bahn�bergang nach OA L�bben Gleisbauarbeiten Vollsperrung 21.04.2007-23.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 45088,-55645 45152,-53482 45124,-52888
EOF
     },
     { from  => 1177452000, # 2007-04-25 00:00
       until => 1177711200, # 2007-04-28 00:00
       text  => 'L 049 L�bbenau-L�bben Bahn�bergang nach OA L�bben Gleisbauarbeiten Vollsperrung 26.04.2007-27.04.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 45088,-55645 45152,-53482 45124,-52888
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
userdel	2::inwork 36768,17309 35618,17440 35225,17557
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
userdel	q4::inwork 1611,29359 2033,29198
EOF
     },
     { from  => 1176069600, # 2007-04-09 00:00
       until => 1177103835, # 1177452000 2007-04-25 00:00
       text  => 'B 167 Eberswalder Str. OD Eberswalde, zw. Spechthausener Str. u. Sch�nholzer Str. Deckenerneuerung Vollsperrung 10.04.2007-24.04.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 32143,48553 33252,48525 34356,48775
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
userdel	q4::inwork 15751,10582 15629,10481
EOF
     },
     { from  => 1176243818, # 2007-04-11 00:23
       until => 1176488154, # 2007-04-14 00:00 1176501600
       text  => 'Finkenkruger Weg (Spandau) in beiden Richtungen, zwischen Seegefelder Weg und Torweg Baustelle, Verkehr wird wechselseitig vorbeigef�hrt (bis 13.04.07)',
       type  => 'handicap',
       source_id => 'IM_005170',
       data  => <<EOF,
userdel	q4::inwork -7413,14561 -7390,14881 -7387,14951 -7371,15201 -7365,15306
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
userdel	2::inwork 9695,1563 9391,1235 9241,1073 9165,1014 9024,906
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
userdel	2::inwork 12731,15824 12642,15668 12559,15524
EOF
     },
     { from  => 1177103024, # 2007-04-20 23:03
       until => 1177308746, # 1177365600 2007-04-24 00:00
       text  => 'Ebertstr. (Mitte) in beiden Richtungen, zwischen Behrenstr. und Scheidemannstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 23.04.07, 05:00)',
       type  => 'gesperrt',
       source_id => 'IM_005269',
       data  => <<EOF,
userdel	2::temp 8595,12066 8600,12165 8515,12242 8539,12286 8560,12326 8540,12420
EOF
     },
     { from  => 1177103052, # 2007-04-20 23:04
       until => 1177297200, # 2007-04-23 05:00
       text  => 'Str. des 17, Juni (Tiergarten) in beiden Richtungen, zwischen Gro�er Stern und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (bis 23.04.07, 05:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005268',
       data  => <<EOF,
userdel	2::temp 6828,12031 7383,12095 7816,12150 8063,12182 8089,12186 8214,12205 8515,12242
EOF
     },
     { from  => 1177192800, # 2007-04-22 00:00
       until => 1184536800, # 2007-07-16 00:00
       text  => 'B 167 zw. Dolgelin und Friedersdorf Inbetriebnahme OU Vollsperrung 23.04.2007-15.07.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 78805,11331 78753,11368 78194,11798 77991,12506 77759,12767
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
userdel	2::inwork 9670,5728 9457,5641 9357,5601 9147,5534
EOF
     },
     { from  => undef, # 
       until => undef, # last-checked 2007-11-28 # war, ist nicht mehr: Abbiegen in Kleine Auguststr. und Joachimstr. nicht m�glich;	3 10020,13669 10081,13673 10142,13556; 	3 10142,13556 10081,13673 10214,13680
       text  => 'Linienstr.: Baustelle zwischen Koppenplatz (�stliche Stra�e) und Rosenthaler Str., Einbahnstra�e',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 10214,13680 10081,13673 10020,13669 9964,13665
EOF
     },
     { from  => 1177625221, # 
       until => 1177625224, # XXX
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
userdel	2::inwork 10427,-7665 10424,-7409
EOF
     },
     { from  => 1177970400, # 2007-05-01 00:00
       until => 1178748000, # 2007-05-10 00:00
       text  => 'L 034 Philipp-M�ller-Str. OD Strausberg, H�he Feuerwehr Instandsetzung TW-Schieber halbseitig gesperrt; Einbahnstra�e 02.05.2007-09.05.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 43584,20871 43553,20466 43110,19818
EOF
     },
     { from  => 1177739838, # 2007-04-28 07:57
       until => 1177884000, # 2007-04-30 00:00
       text  => 'Reichsstr. (Charlottenburg) in beiden Richtungen zwischen Theodor-Heuss-Platz und Steubenplatz Veranstaltung, Stra�e vollst�ndig gesperrt (bis 29.04.2007 nachts)',
       type  => 'gesperrt',
       source_id => 'IM_005329',
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
userdel	2::temp 5370,6486 5424,6584 5533,6753 5654,6941
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
     { from  => 1210715191, # 2008-05-13 23:46
       until => 1210801933, # 2008-06-30 23:59 1214863199
       text  => 'Bernauer Str. (Reinickendorf) in Richtung Spandau, zwischen Seidelstr. und Neheimer Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 06.2008)',
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
userdel	2::inwork 2951,24389 2690,24751 2542,24945 2438,25082
EOF
     },
     { from  => undef, # 
       until => 1178221293, # XXX undef
       text  => 'Tiergartenstr. - H. v. Karajan-Str- (Tiergarten) in beiden Richtungen zwischen Stauffenbergstr. und Kemperplatz Veranstaltung Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005359',
       data  => <<EOF,
userdel	2::temp 8172,11679 8021,11636 7717,11540
EOF
     },
     { from  => 1178221257, # 2007-05-03 21:40
       until => 1178575200, # 2007-05-08 00:00
       text  => 'Alt-K�penick (K�penick) gesamter Bereich Alt-K�penick, Schlossplatz, Rosentr., Gr�nstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 07.05.2007 16 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005385',
       data  => <<EOF,
userdel	2::temp 22263,4671 22138,4661 22111,4562 22162,4546 22312,4593
userdel	2::temp 22093,4499 22111,4562
userdel	2::temp 22196,4847 22138,4661
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
userdel	2::inwork 10115,-8276 11019,-8435
EOF
     },
     { from  => undef, # 
       until => 1178488800, # 2007-05-07 00:00
       text  => 'Turmstra�e (Wedding) in beiden Richtungen, zwischen Stromstra�e und Oldenburger Str. Veranstaltung, Stra�e gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005384',
       data  => <<EOF,
userdel	2::temp 6240,13324 6112,13327 6011,13330 5956,13330 5857,13342 5705,13359
EOF
     },
     { from  => 1178379282, # 2007-05-05 17:34
       until => 1178488800, # 2007-05-07 00:00
       text  => 'Alt-Rudow (Rudow) in beiden Richtungen zwischen K�penicker Str. und Krokusstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 06.05.2007 nachts)',
       type  => 'gesperrt',
       source_id => 'IM_005386',
       data  => <<EOF,
userdel	2::temp 16849,1437 16610,1715
EOF
     },
     { from  => 1178564497, # 2007-05-07 21:01
       until => 1178920800, # 2007-05-12 00:00
       text  => 'Gleimstr. (Prenzlauer Berg) Richtung Brunnenstr. zwischen Sch�nhauser Allee und Ystader Str. Baustelle, Fahrtrichtung gesperrt (bis 11.05.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005412',
       data  => <<EOF,
userdel	1::inwork 10963,15789 10713,15746 10564,15721 10423,15698
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
userdel	2::inwork 28993,38709 28248,39107 26237,40190
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
userdel	2::inwork 10115,-8276 11019,-8435
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
userdel	2::temp -20281,-6915 -19858,-6458
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
     { from  => 1178958684, # 2007-05-12 10:31
       until => 1179093600, # 2007-05-14 00:00
       text  => 'B�lschestr. (K�penick) in beiden Richtungen Veranstaltung, Stra�e vollst�ndig gesperrt (bis 13.05.07 24:00Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005473',
       data  => <<EOF,
userdel	2::temp 25512,4842 25539,5237 25553,5486 25568,5763 25572,5842 25579,5980
EOF
     },
     { from  => 1178874938, # 2007-05-11 11:15
       until => 1179007200, # 2007-05-13 00:00
       text  => 'Stra�e des 17.Juni (Tiergarten) in beiden Richtungen, zwischen Yitzhak-Rabin-Str. und Gro�er Stern Veranstaltung, Stra�e vollst�ndig gesperrt (bis 24:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005469',
       data  => <<EOF,
userdel	2::temp 8063,12182 7816,12150 7383,12095 6828,12031
EOF
     },
     { from  => 1179185929, # 2007-05-15 01:38
       until => 1180420736, # 2007-05-31 23:59 1180648799
       text  => 'Wilhelminenhofstr. (Obersch�neweide) Richtung An der Wuhlheide zwischen Rathenaustr. und Ostendstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 05.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005487',
       data  => <<EOF,
userdel	1::inwork 18853,6009 19024,5830
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
userdel	1::inwork 6334,14756 5991,14832 5753,15096
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
userdel	2::temp 8089,12186 8214,12205 8515,12242
EOF
     },
     { from  => 1179862554, # 2007-05-22 21:35
       until => 1180420718, # 2007-05-31 23:59 1180648799
       text  => 'Wa�mannsdorfer Chaussee (Rudow) in beiden Richtungen, zwischen Gefl�gelsteig und Rhodel�nderweg geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt (bis Ende 05/2007)',
       type  => 'gesperrt',
       source_id => 'IM_005511',
       data  => <<EOF,
userdel	2::inwork 16373,-496 16515,31
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
userdel	q4::inwork 10115,-8276 11019,-8435
EOF
     },
     { from  => 1180032862, # 2007-05-24 20:54
       until => 1180411200, # 2007-05-29 06:00
       text  => 'Ebertstr. (Tiergarten) In beiden Richtungen zwischen Behrenstr. und Scheidemannstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 29.05.2007 morgens)',
       type  => 'gesperrt',
       source_id => 'IM_005563',
       data  => <<EOF,
userdel	2::temp 8595,12066 8600,12165 8515,12242 8539,12286 8560,12326 8540,12420
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
       until => 1181428648, # XXX undef
       text  => 'Friedrichstr. (Kreuzberg) zwischen Kochstr. und Zimmerstr. Baustelle, Radfahrer k�nnen aber langsam passieren',
       type  => 'handicap',
       source_id => 'IM_005616',
       data  => <<EOF,
userdel	q4::inwork 9480,11207 9473,11316
EOF
     },
     { from  => 1180459975, # 2007-05-29 19:32
       until => 1180519200, # 2007-05-30 12:00
       text  => 'Friedrich-List-Ufer (Tiergarten) in beiden Richtungen bei Hauptbahnhof Veranstaltung, Stra�e vollst�ndig gesperrt (bis 30.05.2007 ca. 12 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005623',
       data  => <<EOF,
userdel	2::temp 8098,13419 8102,13304 8107,13146 8110,13042
EOF
     },
     { from  => undef, # 
       until => 1180730929, # XXX undef
       text  => 'L�ckstr. (Lichtenberg) in beiden Richtungen zwischen Weitlingstr. und Emanuelstr. Einsturzgefahr eines Hauses, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005633',
       data  => <<EOF,
userdel	2::inwork 16460,10699 16316,10755
EOF
     },
     { from  => 1180506105, # 2007-05-30 08:21
       until => 1180562399, # 2007-05-30 23:59
       text  => 'Sperrungen im Neuen Garten wegen des G8-Vorbereitungstreffens, bis 2007-05-30 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp -12166,1384 -12115,1331 -12081,1168 -12191,1196 -12182,816
userdel	2::temp -11818,993 -11871,1087 -12081,1168
userdel	2::temp -11887,837 -11856,950
userdel	2::temp -11581,559 -11650,590 -11603,721 -11615,853 -11715,959
userdel	2::temp -12000,1243 -11868,1193 -11568,1287 -11537,1206 -11575,1031 -11562,918 -11510,810 -11231,696
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
       until => 1181672441, # XXX
       text  => 'Blankenfelder Chaussee in beiden Richtungen, zwischen Alt-L�bars und Bahnhofstra�e Baustelle, Stra�e vollst�ndig gesperrt ',
       type  => 'gesperrt',
       source_id => 'IM_005637',
       data  => <<EOF,
userdel	2::inwork 8132,23478 7185,23749
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
       until => 1180901636, # XXX undef
       text  => 'Alt-M�ggelheim (K�penick) in beiden Richtungen Veranstaltung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005660',
       data  => <<EOF,
userdel	2::temp 28188,962 28317,891 28218,1017 28119,1079
userdel	2::temp 28119,1079 28188,962
EOF
     },
     { from  => 1180783143, # 2007-06-02 13:19
       until => 1180908000, # 2007-06-04 00:00
       text  => 'M�llerstr. (Wedding) in beiden Richtungen, zwischen Transvaalstr. und Liverpooler Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 03.06.2007, 24 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005655',
       data  => <<EOF,
userdel	2::temp 6311,16457 6110,16630 6019,16712 5791,16910
EOF
     },
     { from  => 1180783165, # 2007-06-02 13:19
       until => 1183327199, # 2007-07-01 23:59
       text  => 'Vo�str. (Mitte) Richtung Ebertstr. zwischen Wilhelmstr. und Ebertstr. Baustelle, Fahrtrichtung gesperrt (bis Anfang 07.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005661',
       data  => <<EOF,
userdel	1::inwork 9000,11727 8837,11676 8553,11638
EOF
     },
     { from  => 1195515804, #  undef
       until => 1195515809, # XXX last_checked: 2007-08-04
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
userdel	1::inwork 2029,20331 2241,20487
EOF
     },
     { from  => 1181165074, # undef
       until => 1181165075, # XXX undef (nur noch "Verkehrsst�rung erwartet)
       text  => 'Budapester Str. (Tiergarten) in beiden Richtungen zwischen L�tzowufer und Kurf�rstenstr. Stra�e vollst�ndig gesperrt, Staatsbesuch',
       type  => 'gesperrt',
       source_id => 'IM_005699',
       data  => <<EOF,
userdel	2::temp 6135,10982 6168,11042 6446,11147 6582,11202
EOF
     },
     { from  => 1181024556, # 2007-06-05 08:22
       until => 1181138400, # 2007-06-06 16:00
       text  => 'Drakestr. (Steglitz) in beiden Richtungen zwischen Knesebeckstr. und Hans-Sachs-Str. Baustelle, Stra�e vollst�ndig gesperrt (bis 16.00 Uhr)',
       type  => 'gesperrt',
       source_id => 'INKO_86792',
       data  => <<EOF,
userdel	2::inwork 3048,4305 3128,4190 3228,4046 3259,4002
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
userdel	1::inwork 23891,8780 24051,9156 24149,9387 24337,9835
EOF
     },
     { from  => 1182636000, # 2007-06-24 00:00
       until => 1220220000, # 2008-09-01 00:00
       text  => 'B 168 zw. F�rstenwalde und Trebus Grundhafter Stra�enbau Vollsperrung 25.06.2007-31.08.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 54195,309 54279,10 54341,-331 54657,-1293
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
       until => 1181587530, # XXX
       text  => 'Hosemannstr. (Prenzlauer Berg) in beiden Richtungen, zwischen Grellstr. und Ostseeplatz Baustelle, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005738',
       data  => <<EOF,
userdel	2::inwork 12731,15824 12642,15668 12559,15524 12472,15356 12428,15275
EOF
     },
     { from  => 1181373108, # 2007-06-09 09:11
       until => 1181512800, # 2007-06-11 00:00
       text  => 'Treptower Festtage bis zum 10.06.2007',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 14464,9927 14500,9856 14671,9759 14697,9726 14910,9643
userdel	2::temp 14500,9856 14483,9843
EOF
     },
     { from  => 1189968907, # 
       until => 1189968910, # XXX last_checked: 2007-08-05
       text  => 'Holteistra�e: Bauarbeiten, Fahrbahn ist nicht benutzbar',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 14535,11327 14495,11261 14459,11200
EOF
     },
     { from  => 1181768521, # 
       until => 1181768526, # XXX
       text  => 'Glienicker Weg (Adlershof) Richtung Adlergestell zwischen Nipkowstr. und Adlergestell Fahrbahnuntersp�lung, Fahrtrichtung gesperrt',
       type  => 'handicap',
       source_id => 'IM_005746',
       data  => <<EOF,
userdel	q4::inwork; 20818,3182 20760,3059 20565,2754
EOF
     },
     { from  => 1181685600, # 2007-06-13 00:00
       until => 1181858400, # 2007-06-15 00:00
       text  => 'B 115 Berliner Chaussee Bahn�bergang in der OD L�bben Gleisbauarbeiten Vollsperrung 14.06.2007-14.06.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 43610,-50356 43031,-50423 39975,-50522
EOF
     },
     { from  => 1181426400, # 2007-06-10 00:00
       until => 1182376800, # 2007-06-21 00:00
       text  => 'B 168 Breite Str. OD Eberswalde, zw. Heine-Str.u. Krz. Freienwalder Str. Deckenerneuerung halbseitig gesperrt; Einbahnstra�e 11.06.2007-20.06.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork; 38653,47410 38522,47634
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
userdel	2::inwork 20012,3532 19892,3454
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
     { from  => 1181941660, # 2007-06-15 23:07
       until => 1182204000, # 2007-06-19 00:00
       text  => 'Motzstr., Eisenacher Str., Kalckreuthstr. (Sch�neberg) in beiden Richtungen, Veranstaltung, Stra�e vollst�ndig gesperrt (bis 18.06.07 06 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005798',
       data  => <<EOF,
userdel	2::temp 6628,10318 6626,10155 6729,10212 6739,10120
userdel	2::temp 6609,10147 6514,10088
userdel	2::temp 7037,10359 6729,10212 6719,10347
EOF
     },
     { from  => 1182031200, # 2007-06-17 00:00
       until => 1192485600, # 2007-10-16 00:00
       text  => 'B 005 Treplin-Petershagen OD Petershagen, zw. KVK und Ortsausgang Kanal- und Stra�enbau Vollsperrung 18.06.2007-15.10.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 74246,584 74683,385
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
userdel	2::inwork 38357,51575 38111,51856
EOF
     },
     { from  => 1186170676, # 
       until => undef, # XXX (reported by: thuki@...) (Haus wird gebaut, kann eine Weile dauern)
       text  => 'Homburger Str.: Einbahnstra�e wegen Baustelle zw. Ahrweiler Str. und Assmannshauser Str., Durchfahrt Richtung Osten m�glich',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 4599,7474 4403,7498
EOF
     },
     { from  => undef, # 
       until => 1186170465, # XXX (reported by: thuki@...), auch die Aufhebung
       text  => 'Sarrazinstr.: zurzeit Einbahnstra�e (Elsastr. bis Bundesallee; Durchfahrt in dieser Richtung) wegen Baustelle',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 5361,7423 5422,7461 5452,7493 5492,7543
EOF
     },
     { from  => 1181999685, # 2007-06-16 15:14
       until => 1182110400, # 2007-06-17 22:00
       text  => 'Alt-K�penick (K�penick) in beiden Richtungen, sowie umgebende Stra�en Veranstaltung, Stra�e vollst�ndig gesperrt (bis 17.06.07 22:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005778',
       data  => <<EOF,
userdel	2::temp 22263,4671 22138,4661 22111,4562 22093,4499
userdel	2::temp 22111,4562 22162,4546
userdel	2::temp 22196,4847 22138,4661
EOF
     },
     { from  => 1182000409, # 2007-06-16 15:26
       until => 1182363070, # 1184536799 2007-07-15 23:59
       text  => 'Kastanienallee (Prenzlauer Berg) in Richtung Danziger Str., ab Schwedter Str. Baustelle, Fahrtrichtung gesperrt bis 15.07. ',
       type  => 'gesperrt',
       source_id => 'IM_005800',
       data  => <<EOF,
userdel	1::inwork 10534,14460 10723,14772 10838,14962 10889,15045
EOF
     },
     { from  => undef, # 
       until => 1185227622, # XXX undef
       text  => 'Drakestr. (Lichterfelde) in beiden Richtungen, zwischen Curtiusstr. und Unter den Eichen Fahrbahnuntersp�lung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005823',
       data  => <<EOF,
userdel	2::inwork 3048,4305 3128,4190 3228,4046 3259,4002
EOF
     },
     { from  => undef, # 
       until => 1183280362, # XXX undef
       text  => 'F�rstenbrunner Weg (Charlottenburg) in beiden Richtungen, zwischen Spandauer Damm und Rohrdamm Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005810',
       data  => <<EOF,
userdel	2::inwork 1971,12368 1935,12761 1901,13061
userdel	2::inwork 1858,13231 1610,13380 1545,13418
userdel	2::inwork 929,14261 990,14062 1053,13790 1124,13599
userdel	2::inwork 1159,13541 1175,13513 1193,13485 1488,13454
EOF
     },
     { from  => undef, # 
       until => 1182281918, # XXX undef
       text  => 'Hauptstr. (Blankenfelde) in beiden Richtungen, zwischen Berliner Str. und M�llersfelder Weg Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005809',
       data  => <<EOF,
userdel	2::inwork 9812,23983 9774,23936 9625,23781 9425,23693 9228,23643
EOF
     },
     { from  => undef, # 
       until => 1182281931, # XXX undef
       text  => 'H�ttenweg (Zehlendorf) in beiden Richtungen zwischen Clayallee und Onkel-Tom-Str. Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005827',
       data  => <<EOF,
userdel	2::inwork 297,6541 441,6435
userdel	2::inwork 1535,5155 1506,5169 1399,5208 1361,5228 1212,5353 1086,5491 1051,5525 990,5581 910,5654 894,5829 884,5974 869,6085 736,6217
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
userdel	1::inwork 9810,14066 9937,14080 10003,14088
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
userdel	q4::inwork 32766,25156 33511,24201
EOF
     },
     { from  => 1182281851, # 2007-06-19 21:37
       until => 1182492000, # 2007-06-22 08:00
       text  => 'Ebertstr. (Tiergarten) in beiden Richtungen zwischen Behrenstr. und Lenn�str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 22.06. morgens)',
       type  => 'handicap',
       source_id => 'IM_005839',
       data  => <<EOF,
userdel	q4::temp 8595,12066 8581,11896 8571,11846
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
     { from  => 1182577874, # 2007-06-23 07:51
       until => 1182722400, # 2007-06-25 00:00
       text  => 'Badstra�e (Wedding) in beiden Richtungen zwischen Pankstra�e und Behmstra�e Veranstaltung, Stra�e gesperrt (bis 24.06.2007 nachts)',
       type  => 'gesperrt',
       source_id => 'IM_005849',
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
userdel	1::inwork -8784,13321 -8756,13356 -8358,13340 -8034,13339
EOF
     },
     { from  => 1183280053, # 2007-07-01 10:54
       until => 1183413600, # 2007-07-03 00:00
       text  => 'Altstadt K�penick Stra�e Alt-K�penick und umliegende Stra�en Veranstaltung, Stra�e vollst�ndig gesperrt (bis 02.07.07 16 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_005925',
       data  => <<EOF,
userdel	2::temp 22263,4671 22138,4661 22111,4562 22093,4499
userdel	2::temp 22312,4593 22162,4546 22111,4562
userdel	2::temp 22196,4847 22138,4661
EOF
     },
     { from  => 1183193708, # 2007-06-30 10:55
       until => 1183323600, # 2007-07-01 23:00
       text  => 'Brunnenstr. (Wedding) in beiden Richtungen, zwischen Stralsunder Str. und Demminer Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 23 Uhr) ',
       type  => 'gesperrt',
       source_id => 'IM_005922',
       data  => <<EOF,
userdel	2::temp 9648,15027 9718,14888
EOF
     },
     { from  => 1183193764, # 2007-06-30 10:56
       until => 1183327199, # 2007-07-01 23:59
       text  => 'Mehringdamm (Kreuzberg) in Richtung Tempelhof, zwischen Kreuzbergstr. und Dudenstr. Veranstaltung (Seifenkistenrennen), Fahrtrichtung gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_005931',
       data  => <<EOF,
userdel	1::temp 9248,9350 9235,9111 9235,9051 9234,9038 9227,8890 9222,8787
EOF
     },
     { from  => 1183280291, # 2007-07-01 10:58
       until => 1184536799, # 2007-07-15 23:59
       text  => 'Stubenrauchstr. (Treptow ) in Richtung Segelfliegerdamm, ab Akeleiweg Baustelle, Fahrtrichtung gesperrt und Akeleiweg gesperrt (bis Mitte Juli 2007)',
       type  => 'handicap',
       source_id => 'IM_005905',
       data  => <<EOF,
userdel	q4::inwork; 17388,3576 17490,3637 17522,3653 17593,3748
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
userdel	q4::inwork 27067,12608 27094,12535 27117,12466
EOF
     },
     { from  => 1183412527, # 2007-07-02 23:42
       until => 1186773173, # 2007-08-15 23:59 1187215199
       text  => 'Treptower Str. (Treptow) in beiden Richtungen zwischen Kiefholzstr. und Harzer Str. Baustelle Stra�e vollst�ndig gesperrt (bis Mitte 08/2007)',
       type  => 'handicap',
       source_id => 'IM_004418',
       data  => <<EOF,
userdel	2::inwork 13857,8601 14015,8798 14140,8977
EOF
     },
     { from  => 1183412580, # 2007-07-02 23:43
       until => 1185833983, # 2007-08-31 23:59 1188597599
       text  => 'Pankower Allee (Reinickendorf) in Richtung Markstr., zwischen Reginhardstr. und Residenzstr. Baustelle, Fahrtrichtung gesperrt (bis 08.2007)',
       type  => 'gesperrt',
       source_id => 'IM_004242',
       data  => <<EOF,
userdel	1::inwork 8211,17585 8095,17574 7998,17564 7915,17557 7841,17551 7675,17538 7587,17532
EOF
     },
     { from  => undef, # 
       until => 1183798449, # XXX undef
       text  => 'Hauptstr. (Wilhelmsruh) in beiden Richtungen zwischen Schillerstr. und Edelwei�str. Baustelle, Stra�e vollst�ndig gesperrt (bis auf weiteres)',
       type  => 'handicap',
       source_id => 'IM_005953',
       data  => <<EOF,
userdel	q4::inwork 7755,20059 7790,20132 7832,20219
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
userdel	1::inwork 12693,16700 12604,16731 12486,16791 12257,16876 12241,16900
EOF
     },
     { from  => 1183704492, # 2007-07-06 08:48
       until => 1183798472, # 2007-07-08 00:00 1183845600
       text  => 'Str. des 17. Juni und Ebertstr. (Tiergarten) in beiden Richtungen zwischen Y.-Rabin-Str. und Brandenburger Tor Veranstaltung, Stra�e vollst�ndig gesperrt (bis 07.07.2007 morgens)',
       type  => 'gesperrt',
       source_id => 'IM_006009',
       data  => <<EOF,
userdel	2::temp 8515,12242 8214,12205 8089,12186
EOF
     },
     { from  => 1183798422, # 2007-07-07 10:53
       until => 1183932000, # 2007-07-09 00:00
       text  => 'Finsterwalder Str. (Reinickendorf) in beiden Richtungen zwischen Eichhorster Weg und Bruchst�ckgraben Veranstaltung, Stra�e vollst�ndig gesperrt (bis 08.07.2007 abends)',
       type  => 'gesperrt',
       source_id => 'IM_006015',
       data  => <<EOF,
userdel	2::temp 6442,22240 6492,22113 6485,21955 6420,21828 6337,21774 6093,21648 5934,21513
EOF
     },
     { from  => 1184018400, # 2007-07-10 00:00
       until => 1188079200, # 2007-08-26 00:00
       text  => 'L 020 Velten-Borgsdorf zw. OL Pinnow, Havelweg und Berliner Ch., Borgsdorf Grundhafter Stra�enbau Vollsperrung 11.07.2007-25.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -736,32837 -579,33145 -409,33522
EOF
     },
     { from  => 1183845600, # 2007-07-08 00:00
       until => 1194044400, # 2007-11-03 00:00
       text  => 'L 171 Karl-Marx-Str. OD Hohen Neuendorf, Krz. K.-Tucholsky-Str. grundh.Stra�enbau, Kreisverk. Vollsperrung 09.07.2007-02.11.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 1366,29416 1611,29359
EOF
     },
     { from  => 1186264800, # 2007-08-05 00:00
       until => 1187388000, # 2007-08-18 00:00
       text  => 'L 033 zw. Kreuz. H�now und Krz. Landsberger Ch./ Stendaler Str. Deckeninstandsetzung Vollsperrung 06.08.2007-17.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 25457,15594 25955,15531 26117,15452
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
userdel	2::temp 8515,12242 8214,12205 8089,12186
EOF
     },
     { from  => undef, # 
       until => 1184610940, # XXX
       text  => 'Str. nach Fichtenau (K�penick) in beiden Richtungen bei S Rahnsdorf geplatzte Wasserleitung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006066',
       data  => <<EOF,
userdel	2::inwork 30087,5448 30021,5322
EOF
     },
     { from  => 1184450400, # 2007-07-15 00:00
       until => 1184611295, # 2007-08-16 00:00 1187215200
       text  => 'B 002 Stettiner Str. OD Gartz, Knotenpunkt Stettiner-/Scheunenstra�e Ausbau Knotenpunkt Vollsperrung 16.07.2007-15.08.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 76078,90752 76075,90647
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
userdel	2::inwork 15763,15003 15856,14915 16025,14753
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
userdel	2::inwork 30795,13191 30815,13170 30975,12918
EOF
     },
     { from  => 1185055200, # 2007-07-22 00:00
       until => 1185228255, # 2007-08-04 00:00 1186178400
       text  => 'B 005 Kieler Str. OL Frankfurt (O), zw. Lebuser Ch. u. Goepelstr. Bergsicherungsarbeiten Vollsperrung 23.07.2007-03.08.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 87377,-3591 87248,-3446
EOF
     },
     { from  => 1184709600, # 2007-07-18 00:00
       until => 1186178400, # 2007-08-04 00:00
       text  => 'L 086 B 1 Gro� Kreutz-Schmergow OD Gro� Kreutz Kanal- und Stra�enbau Vollsperrung 19.07.2007-03.08.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork -32163,-143 -32143,-211 -31993,-726 -31991,-1024
EOF
     },
     { from  => undef, # 
       until => 1270065106, # 2010-03-31 21:51
       text  => 'Rudower Chaussee (Treptow - K�penick) in beiden Richtungen H�he S-Bahn Br�cke Adlershof Baustelle, Stra�e vollst�ndig gesperrt, als Fu�g�nger kann man passieren',
       type  => 'handicap',
       source_id => 'IM_006107',
       data  => <<EOF,
userdel	q4::inwork 19892,3454 19732,3340
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
userdel	2::inwork 26328,15462 26232,15444 26117,15452 25955,15531 25457,15594 25342,15609 25007,15650 23893,15893
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
userdel	2::inwork 14641,10552 14488,10603
EOF
     },
     { from  => 1186696800, # 2007-08-10 00:00
       until => 1187042400, # 2007-08-14 00:00
       text  => 'K 6153 AS Friedersdorf-K�nigs Wusterhausen Bahn�bergang in der OL Kablow Gleisbauarbeiten Vollsperrung 11.08.2007-13.08.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 33221,-10748 32827,-11406 32725,-11546
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
       until => 1185577821, # XXX
       text  => 'Marktstr. (Lichtenberg) Richtung Karlshorster Str. zwischen Kynaststr. und Schreiberhauer Str. geplatzte Wasserleitung, Fahrtrichtung gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006151',
       data  => <<EOF,
userdel	1::inwork 14988,11130 15050,11017 15085,10956 15109,10911
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
userdel	1::inwork 10138,20840 10119,20731 10063,20493
EOF
     },
     { from  => 1185833817, # 2007-07-31 00:16
       until => 1187989170, # 2007-08-31 23:59 1188597599
       text  => 'Drakestr. (Lichterfelde) in beiden Richtungen, zwischen Curtiusstr. und Unter den Eichen Fahrbahnuntersp�lung, Stra�e vollst�ndig gesperrt (bis Ende 08.2007)',
       type  => 'gesperrt',
       source_id => 'IM_005823',
       data  => <<EOF,
userdel	2::inwork 3048,4305 3128,4190 3228,4046 3259,4002
EOF
     },
     { from  => 1185833871, # 2007-07-31 00:17
       until => 1186168147, # 2007-08-04 00:00 1186178400
       text  => 'Gr�nbergallee (Bohnsdorf) in beiden Richtungen zwischen Am Seegraben und Rosenweg Baustelle, Stra�e vollst�ndig gesperrt, Zufahrt zum Baumarkt von Bohnsdorf kommend frei (bis 03.08.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006195',
       data  => <<EOF,
userdel	2::inwork 20362,-511 20354,-569 20205,-548
EOF
     },
     { from  => 1188428040, # 2007-08-30 00:54
       until => 1188683999, # 2007-09-01 23:59
       text  => 'Joachimstaler Str. (Charlottenburg) Richtung Kantstr. zwischen Lietzenburger Str. und Kurf�rstendamm Baustelle Fahrtrichtung gesperrt (bis Anfang 09.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006190',
       data  => <<EOF,
userdel	1::inwork 5468,10442 5479,10719 5484,10810
EOF
     },
     { from  => 1185833959, # 2007-07-31 00:19
       until => 1186937842, # 2007-08-15 23:59 1187215199
       text  => 'Oranienburger Str. (Wittenau) stadtausw�rts zwischen L�barser Str. und Wittenauer Str. Baustelle, Fahrtrichtung gesperrt (bis Mitte 08.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006189',
       data  => <<EOF,
userdel	1::inwork 5326,21407 5311,21495 5149,21721
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
userdel	2::inwork 9357,5601 9147,5534
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
userdel	1::inwork 23206,206 22547,651 22162,1067
EOF
     },
     { from  => undef, # 
       until => 1187560800, # 2007-08-20 00:00
       text  => 'N�ldnerstr.. (Lichtenberg) in Richtung Karlshorster Str. ab Schlichtalllee geplatzte Wasserleitung, Fahrtrichtung gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006236',
       data  => <<EOF,
userdel	1::inwork 16032,10842 15670,10800 15396,10767 15266,10791
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
     { from  => 1186214400, # 2007-08-04 10:00
       until => 1186344000, # 2007-08-05 22:00
       text  => '5. Open Air Gallery am Sonntag, den 05.08.2007 von 10.00 bis 22.00 Uhr auf der Oberbaumbr�cke ',
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
       until => 1188246970, # XXX laut Cord nur bis 2007-08-17
       text  => 'der Fu�weg von der Buchberger Str. zum S-Bahnhof N�ldnerplatz ist z.Zt. voll gesperrt (Bauzaun)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 15779,10970 15735,11201 15731,11270
EOF
     },
     { from  => 1186266363, # 2007-08-05 00:26
       until => 1186955999, # 2007-08-12 23:59
       text  => '17. Berliner Gauklerfest, 3. bis 12. August 2007, einige Stra�en am Opernpalais sind vollst�ndig gesperrt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::temp 9890,12161 9875,12254 9801,12245 9782,12393
userdel	2::temp 9875,12254 9853,12402
userdel	2::temp 10008,12378 9926,12368 9972,12184
userdel	2::temp 9918,12411 9926,12368
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
userdel	2::inwork 53048,-21761 52992,-21793 52982,-21800 52932,-21834
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
userdel	q4::inwork 78194,11798 78753,11368 78805,11331
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
userdel	2::temp 8063,12182 7816,12150 7383,12095 6828,12031
EOF
     },
     { from  => 1194897338, # 2007-11-12 20:55
       until => 1195686392, # 2007-11-30 23:59 1196463599
       text  => 'Gitschiner Str. (Kreuzberg) in Richtung Kottbusser Tor zwischen Lobeckstr. und Prinzenstr. wegen einer geplatzten Wasserleitung gesperrt, Radfahrer k�nnen auf dem Gehweg passieren (bis Ende 11.2007)',
       type  => 'handicap',
       source_id => 'IM_006274',
       data  => <<EOF,
userdel	q4::inwork; 10340,10301 10605,10312
EOF
     },
     { from  => 1188059338, # 
       until => 1188059341, # XXX
       text  => 'Alt-Moabit (Tiergarten) Kreuzung Thomasiusstra�e Fahrbahnabsenkung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006429',
       data  => <<EOF,
userdel	2::inwork 6882,13088 6757,13112 6661,13130
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
userdel	q4::inwork 3048,4305 3128,4190 3228,4046
EOF
     },
     { from  => 1187989232, # 2007-08-24 23:00
       until => 1188230400, # 2007-08-27 18:00
       text  => 'Ebertstr. (Mitte) in beiden Richtungen zwischen Dorotheenstr. und Hanna-Ahrendt-Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 27.08.07 18 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006365',
       data  => <<EOF,
userdel	2::temp 8581,11896 8595,12066 8600,12165 8515,12242 8539,12286 8560,12326 8540,12420
EOF
     },
     { from  => 1188059356, # 
       until => 1188059359, # XXX
       text  => 'Falkenhagener Str. (Spandau) zwischen Bismarckplatz und Elisabethstr. Fahrbahnabsenkung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006400',
       data  => <<EOF,
userdel	2::inwork -3481,15315 -3349,15229 -3241,15118
EOF
     },
     { from  => 1189353413, # undef
       until => 1189353419, # XXX undef
       text  => 'Oranienburger Str. (Reinickendorf) stadtausw�rts, zwischen L�barser Str. und WIttenauer Str. Baustelle, Fahrtrichtung gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006352',
       data  => <<EOF,
userdel	1::inwork 5326,21407 5311,21495 5149,21721
EOF
     },
     { from  => 1188240671, # 
       until => 1188240674, # XXX
       text  => 'Str. des 17. Juni (Tiergarten) in beiden Richtungen zwischen Brandenburger Tor und Yitzhak-Rabin-Str. Veranstaltung, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006364',
       data  => <<EOF,
userdel	2::temp 8610,12254 8515,12242 8214,12205 8089,12186 8063,12182
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
userdel	1::inwork 87207,-9278 86790,-8657
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
userdel	2::inwork 69461,-27572 69160,-25724
EOF
     },
     { from  => 1187560800, # 2007-08-20 00:00
       until => 1190325600, # 2007-09-21 00:00
       text  => 'K 6402 Ernst-Th�lmann-Str. OD Dolgelin, Krz. Hauptstr. Kanal-,Stra�en- u. Radwegbau Vollsperrung 21.08.2007-20.09.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 78753,11368 78711,11343 78598,11099
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
userdel	2::inwork 57050,65287 56712,66112 56200,66475
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
userdel	2::inwork 31076,54246 30773,54731
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
userdel	q4::inwork; 17898,6049 17937,6173 17952,6246 17992,6436
EOF
     },
     { from  => 1188059298, # 2007-08-25 18:28
       until => 1188183600, # 2007-08-27 05:00
       text  => 'Siegfriedstr. (Lichtenberg) in beiden Richtungen vor Kreuzung Landsberger Allee Bauarbeiten, Stra�e vollst�ndig gesperrt (bis 27.8. 5 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006391',
       data  => <<EOF,
userdel	2::inwork 16843,14420 16881,14063
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
userdel	2::temp 13915,20944 13570,20938 13594,20855
EOF
     },
     { from  => undef, # 
       until => 1188741600, # 2007-09-02 16:00
       text  => 'Kurf�rstendamm (Charlottenburg) in beiden Richtungen zwischen Knesebeckstr. und Breitscheidplatz Veranstaltung, Stra�e vollst�ndig gesperrt (bis ca. 16 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006499',
       data  => <<EOF,
userdel	2::temp 5797,10881 5725,10892 5657,10868 5484,10810 5351,10760 5229,10716 5076,10658 4847,10589
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
userdel	1::inwork 11134,12793 11207,12706 11252,12644 11323,12484
EOF
     },
     { from  => 1189893600, # 2007-09-16 00:00
       until => 1190584800, # 2007-09-24 00:00
       text  => 'B 087 Ortsumgehung M�llrose - Ragow Ortsausg.M�llrose bis hinter Ragow Stra�enbauarbeiten Vollsperrung 17.09.2007-23.09.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 74920,-18929 76631,-18359
userdel	2::inwork 71815,-22343 73222,-20567 74707,-18991
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
userdel	2::inwork -579,33145 -409,33522 103,33971
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
       until => 1603753200, # 2020-10-27 00:00
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
userdel	2::temp 8374,11477 8505,11494 8542,11502
userdel	2::temp 8226,11458 8301,11469 8358,11475
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
userdel	1::inwork 19273,5866 19650,5920 19681,5924 19934,5956
EOF
     },
     { from  => 1187992800, # 2007-08-25 00:00
       until => 1192658400, # 2007-10-18 00:00
       text  => 'L 020 Velten-Borgsdorf zw. OL Pinnow, Havelweg und Berliner Ch., Borgsdorf Grundhafter Stra�enbau Vollsperrung 26.08.2007-17.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -579,33145 -409,33522
EOF
     },
     { from  => 1190237327, # 
       until => 1190237331, # XXX
       text  => 'Glinkastr. (Mitte) in beiden Richtungen zwischen J�gerstr. und Taubenstr. Kranarbeiten, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_006682',
       data  => <<EOF,
userdel	2::inwork 9208,11872 9201,11968
EOF
     },
     { from  => 1190237300, # 2007-09-19 23:28
       until => 1193090292, # 2007-10-29 23:59 1193698799
       text  => 'L�ckstra�e (Lichtenberg) Richtung Ostkreuz ab Weitlingstra�e Baustelle, Fahrtrichtung gesperrt (bis 29.10.)',
       type  => 'gesperrt',
       source_id => 'IM_006691',
       data  => <<EOF,
userdel	1::inwork 16460,10699 16316,10755 16153,10818 16032,10842
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
     { from  => 1191018682, # 2007-09-29 00:31
       until => 1191520800, # 2007-10-04 20:00
       text  => 'Stra�e des 17. Juni, Y.-Rabin-Str. und Ebertstr. (Tiergarten) In beiden Richtungen zwischen Brandenburger Tor und Gro�er Stern Veranstaltung, Stra�e vollst�ndig gesperrt (Y.-Rabin-Str. zwischen Str. des 17. Juni und Scheidemannstr., Ebertstr. zwischen Behrenstr. und Dorotheenstr.) (bis 04.10.2007 20 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006765',
       data  => <<EOF,
userdel	2::temp 8063,12182 8089,12186 8214,12205
userdel	2::temp 8214,12205 8515,12242
userdel	2::temp 8539,12286 8515,12242
userdel	2::temp 8600,12165 8515,12242
userdel	2::temp 8515,12242 8610,12254
userdel	2::temp 8539,12286 8560,12326 8540,12420
userdel	2::temp 6828,12031 7383,12095 7816,12150 8063,12182
userdel	2::temp 8600,12165 8595,12066
userdel	2::temp 8119,12414 8063,12182
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
userdel	2::temp 7875,12363 8017,12359 8070,12409 8119,12414 8374,12416 8400,12417 8540,12420
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
userdel	2::inwork 24186,26271 24204,25870 24244,25405 24242,25066 24281,24622 24214,24093 24677,23407 24761,23151 24718,22731
EOF
     },
     { from  => 1191103200, # 2007-09-30 00:00
       until => 1198364400, # 2007-12-23 00:00
       text  => 'L 040 Zossener Damm OD Blankenfelde, zw. J�hnsdorfer Weg u. A.-D�rer-Str. Kanal- und Stra�enbau Vollsperrung 01.10.2007-22.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10115,-8276 11019,-8435
EOF
     },
     { from  => 1191708000, # 2007-10-07 00:00
       until => 1193608800, # 2007-10-28 23:00
       text  => 'L 073 Baruth-St�lpe zw. Paplitz und Lynow Deckeninstandsetzung Vollsperrung 08.10.2007-28.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10970,-39919 11561,-39875 11814,-39896 12751,-39434 13114,-39180 13618,-39476 13914,-39770 15241,-39692
EOF
     },
     { from  => 1193776679, # 2007-10-30 21:37
       until => 1196463599, # 2007-11-30 23:59
       text  => 'Simon-Bolivar-Str. (Hohensch�nhausen) in beiden Richtungen zwischen Konrad-Wolf-Str. und K�striner Str. Baustelle, Stra�e vollst�ndig gesperrt (bis Ende 11.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006088',
       data  => <<EOF,
userdel	2::inwork 15763,15003 15856,14915 16025,14753
EOF
     },
     { from  => 1191532907, # 2007-10-04 23:21
       until => 1191707999, # 2007-10-06 23:59
       text  => 'Ullsteinstr. (Tempelhof) in beiden Richtungen zwischen Rathausstr. und Mariendorfer Damm Baustelle, Stra�e vollst�ndig gesperrt (bis 06.10.)',
       type  => 'gesperrt',
       source_id => 'IM_006795',
       data  => <<EOF,
userdel	2::inwork 9213,5187 8934,5095 8813,5004
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
userdel	q4::inwork 22178,30343 21872,30139 21561,30131 21172,29984
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
userdel	2::inwork 8656,71489 8031,70019 8031,69636 7879,69487 7215,68252 6538,67236
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
     { from  => 1191967812, # 2007-10-10 00:10
       until => 1230764399, # 2008-12-31 23:59
       text  => 'Glinkastr. (Mitte) Richtung Leipziger Str. zwischen Franz�sische Str. und Leipziger Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 2008)',
       type  => 'gesperrt',
       source_id => 'IM_006819',
       data  => <<EOF,
userdel	1::inwork 9183,12076 9201,11968 9208,11872 9220,11781 9234,11683 9268,11590
EOF
     },
     { from  => 1191967853, # 2007-10-10 00:10
       until => 1193482895, # 2007-10-31 23:59 1193871599
       text  => 'S�dostallee (K�nigsheide) Richtung Sterndamm zwischen Rixdorfer Str. und Sterndamm Baustelle, Fahrtrichtung gesperrt (bis Ende 10.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006820',
       data  => <<EOF,
userdel	1::inwork 16861,5935 16987,5838 17331,5571 17586,5374
EOF
     },
     { from  => 1191708000, # 2007-10-07 00:00
       until => 1197325825, # 2007-12-15 00:00 1197673200
       text  => 'L 238 AS Werbellin-Joachimsthal OD Altenhof Kanal- und Stra�enbau Vollsperrung 08.10.2007-14.12.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 30762,56847 30526,56720 30056,56665 30137,56487
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
userdel	2::inwork 3228,4046 3128,4190
EOF
     },
     { from  => 1192140000, # 2007-10-12 00:00
       until => 1192399200, # 2007-10-15 00:00
       text  => 'B 096 Br�cke zw. Gro�r�schen und Freienhufen Br�ckenabbruch Vollsperrung 13.10.2007-14.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 50965,-90836 52580,-90602
EOF
     },
     { from  => 1192312800, # 2007-10-14 00:00
       until => 1193263200, # 2007-10-25 00:00
       text  => 'B 109 August-Bebel-Str. OD Templin, zw. Jahnstr. und Krz. Prenzlauer Allee Kanalarbeiten Vollsperrung 15.10.2007-24.10.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 16463,79756 16200,79437
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
userdel	2::inwork 80237,-17646 80679,-17994 82000,-19505
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
userdel	2::temp -3629,12781 -3641,12861 -3650,12929 -3669,13015 -3764,13270 -3791,13357
EOF
     },
     { from  => 1192310039, # 2007-10-13 23:13
       until => 1192402800, # 2007-10-15 01:00
       text  => 'Residenzstr. (Reinikendorf) in beiden Richtungen zwischen Emmentaler Str. und Franz-Neumann-Platz Veranstaltung, Stra�e vollst�ndig gesperrt (bis 15.10. - 01 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_006852',
       data  => <<EOF,
userdel	2::temp 7350,18262 7439,17985 7445,17968 7466,17904 7487,17836 7500,17796 7587,17532
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
userdel	2::inwork -2069,16907 -1863,16868
EOF
     },
     { from  => 1192489357, # 2007-10-16 01:02
       until => 1192831200, # 2007-10-20 00:00
       text  => 'Suermondtstr. (Hohensch�nhausen) Richtung Hauptstr. zwischen Augustastr. und Sabinensteig Baustelle, Fahrtrichtung gesperrt (bis 19.10.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006873',
       data  => <<EOF,
userdel	1::inwork 15918,16383 16095,16331 16260,16282 16416,16236 16515,16207
EOF
     },
     { from  => 1182031200, # 2007-06-17 00:00
       until => 1193436000, # 2007-10-27 00:00
       text  => 'B 005 Treplin-Petershagen OD Petershagen, zw. KVK und Ortsausgang Kanal- und Stra�enbau Vollsperrung 18.06.2007-26.10.2007 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 74246,584 74683,385
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
       until => 1230764400, # 2009-01-01 00:00
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
userdel	q4::inwork 22507,95722 22233,95712
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
userdel	2::inwork 13095,6926 13278,6967
EOF
     },
     { from  => 1193482816, # 2007-10-27 13:00
       until => 1193957647, # 2007-11-10 00:00 1194649200
       text  => 'Mahlsdorfer Str. (Uhlenhorst) Richtung K�penick zwischen Eitelsdorfer Str. und Gehsener Str. Baustelle, Fahrtrichtung gesperrt (bis 09.11.2007)',
       type  => 'handicap',
       source_id => 'IM_006985',
       data  => <<EOF,
userdel	q4::inwork; 22967,7252 22869,7095 22785,6984 22758,6944 22748,6714 22745,6657 22724,6608
EOF
     },
     { from  => 1193482855, # 2007-10-27 13:00
       until => 1194735600, # 2007-11-11 00:00
       text  => 'Silbersteinstr. (Neuk�lln) in beiden Richtungen zwischen Walterstr. und Karl-Marx-Str. Baustelle, Stra�e vollst�ndig gesperrt (bis 10.11.2007)',
       type  => 'gesperrt',
       source_id => 'IM_006966',
       data  => <<EOF,
userdel	2::inwork 12983,6904 13095,6926
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
userdel	2::inwork 14802,10505 14836,10524 14843,10621 14882,10732
EOF
     },
     { from  => undef, # 
       until => 1210598963, # Time::Local::timelocal(reverse(2010-1900,1-1,1,0,0,0))
       text  => 'Bauarbeiten am Ostkreuz, Durchfahrt nicht mehr m�glich',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 14906,10587 14843,10621
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
userdel	1::inwork 4898,22459 5006,22507 5148,22568
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
     { from  => undef, # 
       until => 1210801999, # 2008-07-01 00:00 1214863200
       text  => 'Holl�nderstr. (Reinickendorf) Richtung Markstr., zwischen Aroser Allee und Markstr. Baustelle, Fahrtrichtung gesperrt (bis Mitte 2008) (08:51) ',
       type  => 'gesperrt',
       source_id => 'IM_007023',
       data  => <<EOF,
userdel	1::inwork 6878,17315 6995,17322 7031,17323 7131,17329 7308,17306 7379,17295 7602,17399
EOF
     },
     { from  => 1194130800, # 2007-11-04 00:00
       until => 1220220000, # 2008-09-01 00:00
       text  => 'B 167 OD Alt Ruppin, zw. Br�ckenstr. und Neum�hler Weg Stra�en- u. Br�ckenbauarbeiten Vollsperrung 05.11.2007-31.08.2008 ',
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
userdel	2::inwork 15751,10582 15629,10481
EOF
     },
     { from  => 1194897448, # 2007-11-12 20:57
       until => 1198277999, # 2007-12-21 23:59
       text  => 'L�ckstr. (Lichtenberg) Richtung N�ldnerplatz zwischen Emanuelstr.und Schlichtallee Baustelle, Fahrtrichtung gesperrt (bis 21.12.)',
       type  => 'gesperrt',
       source_id => 'IM_007093',
       data  => <<EOF,
userdel	1::inwork 16316,10755 16153,10818 16032,10842
EOF
     },
     { from  => 1195308223, # 
       until => 1195308227, # XXX
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
userdel	2::inwork 16109,76100 16048,75165 17001,73315
EOF
     },
     { from  => 1195515878, # 2007-11-20 00:44
       until => 1196549999, # 2007-12-01 23:59
       text  => 'Bahnhofstr. (Blankenfelde) in beiden Richtungen Baustelle, Stra�e vollst�ndig gesperrt (bis Anfang 12.2007)',
       type  => 'gesperrt',
       source_id => 'IM_007189',
       data  => <<EOF,
userdel	2::inwork 8909,23506 8803,23478 8626,23432 8584,23421 8132,23478
EOF
     },
     { from  => 1195308071, # 2007-11-17 15:01
       until => 1195444800, # 2007-11-19 05:00
       text  => 'Baumschulenstr. (Treptow) in beiden Richtungen H�he S-Bahnbr�cke Baustelle, Stra�e vollst�ndig gesperrt ist ausgeschildert (bis 19.11. 05 Uhr)',
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
     { from  => undef, # 
       until => 1199141999, # 2007-12-31 23:59
       text  => 'Weihnachtsmarkt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 9700,12234 9681,12382
EOF
     },
     { from  => undef, # 
       until => 1199141999, # 2007-12-31 23:59
       text  => 'Weihnachtsmarkt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10170,12261 10083,12442
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
userdel	2::inwork -6342,54585 -5037,54561 -4176,54548
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
userdel	q4::inwork -1595,38315 -1571,38406 -1553,38501 -1517,38543
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
     { from  => 1190498400, # 2007-09-23 00:00
       until => 1225494000, # 2008-11-01 00:00
       text  => 'L 073 Beelitzer Str. OL Luckenwalde, zw. Puschkinstr. u. Woltersdorfer Str. Stra�enausbau Vollsperrung 24.09.2007-31.10.2008 ',
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
userdel	1::inwork 10902,13604 10746,13673
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
userdel	2::inwork 39917,38037 40666,38512 42062,39651
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
userdel	2::inwork 31076,54246 30773,54731
EOF
     },
     { from  => 1196982000, # 2007-12-07 00:00
       until => 1197759600, # 2007-12-16 00:00
       text  => 'L 792 Gro� Schulzendorf-Mahlow OD Blankenfelde, Kno. Zossener-/Potsdamer Damm Deckeneinbau Vollsperrung 08.12.2007-15.12.2007 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10023,-8859 10115,-8276
EOF
     },
     { from  => 1197233736, # 
       until => 1199903161, # XXX last_checked: 2007-12-09 XXX nach den Bauarbeiten asphaltiert?
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
userdel	2::inwork 69461,-27572 69160,-25724
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
userdel	1::inwork 25579,5980 25121,5799
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
     { from  => 1198105200, # 2007-12-20 00:00
       until => 1212271200, # 2008-06-01 00:00
       text  => 'L 030 Ethel-und-Julius-Rosenberg-Str. OD Woltersdorf, zw. A.-Bebel-Str. und R.-Breitscheid Stra�enbau, Entw�sserung Vollsperrung 21.12.2007-31.05.2008 ',
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
userdel	q4::inwork 10747,9326 10719,9259
EOF
     },
     { from  => 1198881536, # 2007-12-28 23:38
       until => 1199314800, # 2008-01-03 00:00
       text  => 'Stra�e des 17. Juni Mitte, zwischen Gro�er Stern und Brandenburger Tor, Ebertstr., Y.-Rabin-Str.: Silvesterparty am Brandenburger Tor, Stra�en vollst�ndig gesperrt (bis 03.01.2008 morgens)',
       type  => 'gesperrt',
       source_id => 'IM_007479',
       data  => <<EOF,
userdel	2::inwork 8600,12165 8515,12242 8214,12205 8089,12186
userdel	2::inwork 6828,12031 7383,12095 7816,12150 8063,12182 8119,12414
EOF
     },
     { from  => 1199891609, # 2008-01-09 16:13
       until => 1209592800, # 2008-05-01 00:00
       text  => 'Sterndamm (Treptow) Richtung Sch�neweide zwischen J.-Werner.Str und Lindhorstweg Baustelle, Fahrtrichtung gesperrt (bis April 2008)',
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
userdel	1::inwork 5149,7012 5251,6949 5374,6932
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
userdel	1::inwork 10309,12854 10171,12769
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
     { from  => 1209758305, # 2008-05-02 21:58
       until => 1222811999, # 2008-09-30 23:59
       text  => 'Pistoriusstr. (Wei�ensee) Richtung Berliner Str. zwischen Gustav-Adolf-Str. und Berliner Str. Baustelle, Fahrtrichtung gesperrt (bis Ende 09.2008)',
       type  => 'gesperrt',
       source_id => 'IM_006024',
       data  => <<EOF,
userdel	1::inwork 12486,16791 12604,16731 12693,16700
EOF
     },
     { from  => 1201647600, # 2008-01-30 00:00
       until => 1208556000, # 2008-04-19 00:00
       text  => 'L 314 Zepernicker Chaussee OD Bernau grundhafter Stra�enbau Vollsperrung 31.01.2008-18.04.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 22178,30343 21872,30139 21561,30131 21172,29984
EOF
     },
     { from  => 1207420756, # 2008-04-05 20:39
       until => 1210801866, # 2008-05-15 23:59 1210888799
       text  => 'Behrenstr. (Mitte) Richtung Bebelplatz zwischen Glinkastr. und Friedrichstr. Baustelle, Fahrtrichtung gesperrt (bis Mitte 05.2008)',
       type  => 'gesperrt',
       source_id => 'IM_007843',
       data  => <<EOF,
userdel	1::inwork 9164,12172 9365,12196
EOF
     },
     { from  => 1204328757, # 2008-03-01 00:45
       until => 1204758000, # 2008-03-06 00:00
       text  => 'Hultschiner Damm (Mahlsdorf) Richtung K�penick zwischen Alt-Mahlsdorf und Elsenstr. Baustelle, Fahrtrichtung gesperrt, eine Umleitung ist eingerichtet (bis 05.03.2008)',
       type  => 'gesperrt',
       source_id => 'IM_007852',
       data  => <<EOF,
userdel	1::inwork 24658,11293 24735,11021 24637,10807
EOF
     },
     { from  => 1203374120, # 2008-02-18 23:35
       until => 1209496368, # 2008-04-30 23:59 1209592799
       text  => 'Oranienburger Str. (Mitte) Richtung Friedrichstr. zwischen Linienstr. und Friedrichstr. Baustelle, Fahrtrichtung gesperrt (bis Ende 04.2008)',
       type  => 'handicap',
       source_id => 'IM_007850',
       data  => <<EOF,
userdel	q4::inwork; 9281,13374 9215,13392
EOF
     },
     { from  => 1203202800, # 2008-02-17 00:00
       until => 1230764400, # 2009-01-01 00:00
       text  => 'B 001 Brandenburger Str. OD Jeserig Stra�enbau Vollsperrung 18.02.2008-31.12.2008 ',
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
userdel	2::inwork 48953,26802 48260,27132 46629,27232 44331,27632 44074,27889 41563,28973
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
       until => 1214863200, # 2008-07-01 00:00
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
userdel	1::inwork 15267,10865 15266,10791 15255,10751
EOF
     },
     { from  => 1204412400, # 2008-03-02 00:00
       until => 1215208800, # 2008-07-05 00:00
       text  => 'B 168 zw. Abzw. Zeust und Beeskow Stra�enbauarbeiten Vollsperrung 03.03.2008-04.07.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 69461,-27572 69160,-25724
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
       until => 1205673255, # XXX
       text  => 'Sophienstr. (Mitte) in beiden Richtungen zwischen Gro�e Hamburger Str. und Rosenthaler Str. Bauarbeiten, Stra�e vollst�ndig gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_008076',
       data  => <<EOF,
userdel	2::inwork 9982,13411 10312,13231
EOF
     },
     { from  => 1205622000, # 2008-03-16 00:00
       until => 1212184800, # 2008-05-31 00:00
       text  => 'B 087 Leipziger Str. OD FFO, zw. Biegener- u. Krz.Kopernikus-/M�llroser-/EHS Str. Stra�enausbau halbseitig gesperrt; Einbahnstra�e 17.03.2008-30.05.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 87829,-6485 87655,-6717
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
userdel	2::inwork 49836,-67419 50143,-67035 50318,-65825
EOF
     },
     { from  => 1206313200, # 2008-03-24 00:00
       until => 1214949600, # 2008-07-02 00:00
       text  => 'L 075 Tollkrug - Selchow - Wa�mannsdorf OD Selchow Stra�enbauarbeiten Vollsperrung 25.03.2008-01.07.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 15355,-5280 15568,-5323 15771,-5575 15987,-6248 16190,-6406
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
userdel	q4::inwork 32766,25156 33511,24201
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
userdel	2::inwork -3001,13877 -3049,13959 -3072,14040
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
userdel	2::inwork 9982,13411 10312,13231
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
     { from  => 1206305145, # 2008-03-23 21:45
       until => 1262300399, # 2009-12-31 23:59
       text  => 'R�ckbau der Fr.-Ebert-Str. zwischen Breiter Str. und Platz der Einheit, Bauarbeiten bis Ende 2009. Unter Umst�nden Umfahrung �ber Alten Markt notwendig. ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -12719,-1661 -12755,-1585 -12773,-1544
EOF
     },
     { from  => 1206490011, # 2008-03-26 01:06
       until => 1210801965, # 2008-05-23 23:59 1211579999
       text  => 'Gormannstr. (Mitte) Kreuzung Linienstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 23.05.)',
       type  => 'handicap',
       source_id => 'IM_008182',
       data  => <<EOF,
userdel	q4::inwork 10385,13548 10432,13678 10445,13752
EOF
     },
     { from  => 1207000800, # 2008-04-01 00:00
       until => 1208988000, # 2008-04-24 00:00
       text  => 'B 101 zw. J�terbog und Hohenahlsdorf Deckenerneuerung Vollsperrung 02.04.2008-23.04.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork -7465,-53204 -7723,-51946 -8071,-50478 -8343,-49645 -8733,-48657 -9039,-47752
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
       until => 1222811999, # 2008-09-30 23:59
       text  => 'Bauarbeiten am nordwestlichen Bereich der Elsenbr�cke von 7. Januar 2008 bis September 2008; kein Zugang zum Spreeufer. ',
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
userdel	q4::inwork 13556,37493 12887,36543
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
userdel	q4::temp 33060,-85292 33101,-85749
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
userdel	q4::inwork 7497,5610 7599,5553 7816,5519 8038,5521
EOF
     },
     { from  => 1208546801, # 2008-04-18 21:26
       until => 1208750400, # 2008-04-21 06:00
       text  => 'Str. des 17. Juni (Tiergarten) in beiden Richtungen zwischen Brandenburger Tor und Y.-Rabin-Str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 21.04. ca. 6 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_008397',
       data  => <<EOF,
userdel	2::temp 8610,12254 8515,12242 8214,12205 8089,12186 8063,12182
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
userdel	2::temp 8595,12066 8600,12165 8515,12242 8539,12286 8560,12326 8540,12420
EOF
     },
     { from  => 1208460517, # 2008-04-17 21:28
       until => 1208728800, # 2008-04-21 00:00
       text  => 'Turmstra�e (Wedding) in beiden Richtungen, zwischen Stromstra�e und Oldenburger Str. Veranstaltung, Stra�e gesperrt',
       type  => 'gesperrt',
       source_id => 'IM_008375',
       data  => <<EOF,
userdel	2::temp 5705,13359 5857,13342 5956,13330 6011,13330 6112,13327 6240,13324
EOF
     },
     { from  => 1208892535, # 2008-04-22 21:28
       until => 1222811999, # 2008-09-30 23:59
       text  => 'Schillerstr. (Wilhelmsruh) Richtung Sch�nholzer Weg zwischen Hauptstr. und Sch�nholzer Weg Baustelle, Fahrtrichtung gesperrt (bis 09.2008)',
       type  => 'gesperrt',
       source_id => 'IM_008423',
       data  => <<EOF,
userdel	1::inwork 7832,20219 7957,20182 8062,20133 8196,20096
EOF
     },
     { from  => 1209496288, # 2008-04-29 21:11
       until => 1210313401, # 2008-05-09 23:59 1210370399
       text  => 'Malchower Weg (Hohensch�nhausen) in beiden Richtungen zwischen Degnerstr. und Gembitzer Str. Baustelle, Stra�e vollst�ndig gesperrt (bis 09. Mai 2008)',
       type  => 'gesperrt',
       source_id => 'IM_008483',
       data  => <<EOF,
userdel	2::inwork 17017,16716 17059,16560
EOF
     },
     { from  => 1209496325, # 2008-04-29 21:12
       until => 1210802123, # 2008-07-15 23:59 1216159199
       text  => 'Siemensstr. (Obersch�neweide) Richtung Edisonstr. zwischen Wilhelminenhofstr. und Edisonstr. Baustelle, Fahrbahn auf einen Fahrstreifen verengt bzw. gesperrt, eine Umleitung ist eingerichtet (bis Mitte 07.2008)',
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
userdel	2::inwork 41326,28975 40337,28961 40135,28824 39921,28733 39155,29093
EOF
     },
     { from  => 1209852000, # 2008-05-04 00:00
       until => 1215900000, # 2008-07-13 00:00
       text  => 'K 7318 Blankenburg - Potzlow zw. Potzlow und Seehausen Stra�enbauarbeiten Vollsperrung 05.05.2008-12.07.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 39375,90456 39870,90079 40230,90006 40938,90213 41085,90590
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
userdel	2::inwork 49836,-67419 50143,-67035 50318,-65825
EOF
     },
     { from  => 1209754023, # 2008-05-02 20:47
       until => 1230764399, # 2008-12-31 23:59 XXX Ende geraten
       text  => 'Mohrenstr. zwischen Mauerstr. und Glinkastr. gesperrt ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 9220,11781 9173,11770
EOF
     },
     { from  => 1209754154, # 2008-05-02 20:49
       until => 1230764399, # 2008-12-31 23:59 XXX Ende geraten
       text  => 'Oberwallstr. Einbahnstra�e zum Hausvogteiplatz',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 9925,11947 9913,12068
EOF
     },
     { from  => 1209667815, # 2008-05-01 20:50
       until => 1230764399, # 2008-12-31 23:59 XXX Ende geraten
       text  => 'Mohrenstr. am Gendarmenmarkt: Einbahnstra�e Richtung Osten',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 9672,11833 9538,11818
EOF
     },
     { from  => 1209754240, # 2008-05-02 20:50
       until => 1230764399, # 2008-12-31 23:59 XXX Ende geraten
       text  => 'Markgrafenstr. am Gendarmenmarkt: Einbahnstra�e Richtung Norden',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 9663,11927 9672,11833
EOF
     },
     { from  => 1209754714, # 2008-05-02 20:58
       until => 1230764399, # 2008-12-31 23:59
       text  => 'Kleine Gertraudenstr. - Gertraudenstr.: Bauarbeiten, gesperrt ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 10387,11901 10364,11896
EOF
     },
     { from  => 1210019166, # 2008-05-05 22:26
       until => 1229381999, # 2008-12-15 23:59
       text  => 'K�nigsheideweg (Treptow) Richtung Sterndamm zwischen Haushoferstr. und Sterndamm Baustelle, Fahrtrichtung gesperrt, Radfahrer k�nnen langsam passieren (eng!) (bis Mitte 12.2008)',
       type  => 'handicap',
       source_id => 'IM_008688',
       data  => <<EOF,
userdel	q4; 17115,4757 17266,4720 17518,4644
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
       until => undef, # XXX
       text  => 'Alt-Rudow: von Krokusstra�e bis K�penicker Stra�e Einbahnstra�e in Richtung Neudecker Weg',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	1::inwork 16849,1437 16610,1715
EOF
     },
     { from  => 1205622000, # 2008-03-16 00:00
       until => 1214863200, # 2008-07-01 00:00
       text  => 'L 793 Alfred-K�hne-Str. Ludwigsfelde, Kreuzung Am Birkengrund/ Ludwigsfelder Str. Bau Kreisverkehr Vollsperrung 17.03.2008-30.06.2008 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4::inwork 3257,-10374 2629,-10301 2580,-11069
userdel	q4::inwork 1867,-10228 2629,-10301
EOF
     },
     { from  => 1210313171, # 2008-05-09 08:06
       until => 1210629600, # 2008-05-13 00:00
       text  => 'Stra�en um den Bl�cherplatz Kreuzberg Bl�cherplatz, Waterlooufer: Mehringdamm - Zossener Str., Bl�cherstr.: Mehringdamm - Zossener Str., Zossener Str.: Waterlooufer-Bl�cherstr. gesperrt (bis 12.05.08, 24:00 Uhr)',
       type  => 'gesperrt',
       source_id => 'IM_008714',
       data  => <<EOF,
userdel	2::temp 9522,10017 9444,10000
userdel	2::temp 9849,10202 9827,10120 9811,10055 9522,10017 9536,10064 9579,10122 9592,10174 9812,10211 9851,10219
userdel	2::temp 9401,10199 9592,10174
userdel	2::temp 9579,10122 9689,10124 9811,10055
EOF
     },
     { from  => undef, # 
       until => 1210484837, # XXX undef
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
       until => 1217541600, # 2008-08-01 00:00
       text  => 'L 023 Strausberg - B168 - Eberswalde Abzw. Tiefensee-Pr�tzel aus Ri. Gielsdorf Deckenerneuerung Vollsperrung 13.05.2008-31.07.2008 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 41300,28061 41326,28975
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
       until => undef, # XXX
       text  => 'Untere Kynaststr.: Restbauarbeiten, Stra�e k�nnte u.U. gesperrt sein',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 14802,10505 14836,10524 14843,10621 14882,10732 14890,10824
EOF
     },
     { from  => undef, # 
       until => Time::Local::timelocal(reverse(2008-1900,5-1,14+2,0,0,0)), # XXX endtime guessed
       text  => 'Papierlager brennt, K�penicker Str. ist zwischen Manteuffelstr. und Engeldamm gesperrt',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2::inwork 12055,11331 12307,11169
EOF
     },
    );
