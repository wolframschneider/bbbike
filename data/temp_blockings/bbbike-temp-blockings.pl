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
     { from  => Time::Local::timelocal(reverse(2003-1900,6-1,6,0,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,6-1,9,23,59,0)),
       file  => "strassenfest-bluecherplatz.bbd",
       text  => "Stra�enfest rund um den Bl�cherplatz vom 6.6. - 9.6.",
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
     { from  => Time::Local::timelocal(reverse(2003-1900,6-1,23,5,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,6-1,29,5,0,0)),
       file  => "csd.bbd",
       text  => "CSD am 28.5.",
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,6-1,27,6,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,6-1,29,23,59,59)),
       file  => "badstr.bbd",
       text  => "Badstra�e zwischen B�ttgerstra�e und Pankstra�e: in beiden Richtungen Veranstaltung, Stra�e gesperrt",
     },
     { from  => Time::Local::timelocal(reverse(2003-1900,7-1,3,6,0,0)),
       until => Time::Local::timelocal(reverse(2003-1900,7-1,7,23,59,59)),
       file  => "rheinstrassenfest.bbd",
       text  => "Rheinstra�enfest in der Rheinstra�e zwischen Breslauer Platz  und Walter-Schreiber-Platz. Beide Richtungsfahrbahnen sind ab dem 05.07.2003, 06.00 Uhr bis zum 06.07.2003, 24.00 Uhr gesperrt.",
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
     { from  => 1066924800, # 2003-10-23 18:00
       until => 1067295600, # 2003-10-28 00:00
       file  => 'schlichtallee.bbd',
       text  => 'Schlichtallee, zwischen Hauptstra�e und L�ckstra�e, Vollsperrung vom 24.10.03, 18.00 Uhr bis 27.10.03, 04.00 Uhr wegen Ein-/Ausbau der Bahnbr�cken. ',
       type  => 'gesperrt',
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
     { from  => 1079701200, # 2004-03-19 14:00
       until => 1080856800, # 2004-04-02 00:00
       file  => 'budapester.bbd',
       text  => 'Budapester Stra�e, St�lerstra�e, zwischen Klingelh�ferstra�e und Kurf�rstenstrs�e in beiden Richtungen f�r den Durchgangsverkehrgesperrt. Konferenz. Dauer: 20.03.2004, 14.00 Uhr bis 01.04.2004, 18.00 Uhr',
       type  => 'gesperrt',
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
     { from  => 1083204000, # 2004-04-29 04:00
       until => 1083535200, # 2004-05-03 00:00
       file  => 'turmstr.bbd',
       text  => 'Turmstra�e zwischen Stromstra�e und Oldenburger Stra�e/Ottostra�e Fr�hlingsfest, Stra�e gesperrt, Dauer: 30.04.2004, 04.00 Uhr bis 02.05.2004, 24.00 Uhr',
       type  => 'gesperrt',
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
     { from  => 1083189600, # 2004-04-29 00:00
       until => 1083535199, # 2004-05-02 23:59
       file  => 'muellerstr.bbd',
       text  => 'NEW: M�llerstr. (Wedding) in beiden Richtungen, zwischen Seestr. und Leopoldplatz Veranstaltung, Stra�enfest (vom 30.04. - 02.05.)',
       type  => 'gesperrt',
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
     { from  => 1084485600, # 2004-05-14 00:00
       until => 1084741200, # 2004-05-16 23:00
       file  => 'hermannstr.bbd',
       text  => 'Hermannstr. (Neuk�lln) in beiden Richtungen, zwischen Flughafenstr. und Thomasstr. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 16.05. 23 Uhr)',
       type  => 'gesperrt',
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
     { from  => 1088157600, # 2004-06-25 12:00
       until => 1088287200, # 2004-06-27 00:00
       file  => 'oberbaumbruecke.bbd',
       text  => 'Oberbaum-Br�ckenfest, 26.06.2004 von 12.00 Uhr bis 24.00 Uhr',
       type  => 'handicap',
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
     { from  => 1088719200, # 2004-07-02 00:00
       until => 1088964000, # 2004-07-04 20:00
       file  => 'muellerstr.bbd',
       text  => 'M�llerstr. (Wedding) in beiden Richtungen zwischen Londoner Str. und Barfu�str. Veranstaltung, Stra�e vollst�ndig gesperrt (bis 04.07. abends)',
       type  => 'handicap',
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
userdel	q4 35359,12542 35656,11817
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
userdel	q4 6040,12480 5798,12021
userdel	q4 5771,11887 5798,12021
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
     { from  => 1094076000, # 2004-09-02 00:00
       until => 1094421600, # 2004-09-06 00:00
       text  => 'B 103; (Havelberger Str.); OD Pritzwalk, Bahn�bergang Gleisbauarbeiten Vollsperrung 03.09.2004-05.09.2004 ',
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
userdel	1 19770,3343 19611,3167
EOF
     },
     { from  => 1094083200, # 2004-09-02 02:00
       until => 1094428800, # 2004-09-06 02:00
       text  => 'Turmstra�e zwischen Kreuzung Beusselstra�e und Kreuzung Stromstra�e sowie Thusneldaallee: Stra�e gesperrt (Turmstra�enfest), Dauer: 03.09.2004 02:00 Uhr bis 06.09.2004 02:00 Uhr ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 5256,13420 5388,13398 5585,13368 5723,13346 5844,13334 5964,13324 6113,13313 6247,13304
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
userdel	2 12041,7788 12075,7696
userdel	2 11979,8014 11960,8090
userdel	2 11979,8014 12025,7852
userdel	2 11933,8198 11960,8090
userdel	2 12075,7696 12122,7553
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
userdel	1 16655,10622 16460,10699 16153,10818 16032,10842
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
     { from  => 1096149600, # 2004-09-26 00:00
       until => 1100216074, # was 2005-05-28 00:00
       text  => 'K 6413; (Wriezener Stra�e); OL Buckow, zw. Ringstr. u. Weinbergsweg Kanal- u. Stra�enbau Vollsperrung 27.09.2004-27.05.2005 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 55429,20127 55558,19957
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
       until => 1114898400, # 2005-05-01 00:00
       text  => 'L 40; (Gro�beeren-G�terfelde); zw. Gro�beeren u. Neubeeren Neubau Bauwerk; Vollsperrung; 24.09.2004-30.04.2005 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 2715,-6365 2443,-6309
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
     { from  => 1096754400, # 2004-10-03 00:00
       until => 1102460400, # 2004-12-08 00:00
       text  => 'B 167; zw. Bad Freienw. u. Falkenberg, H�he Papierfabrik Neubau von Durchl�ssen Vollsperrung 04.10.2004-07.12.2004 ',
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
userdel	2 -9626,-6603 -8401,-9872
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
     { from  => 1098136800, # 2004-10-19 00:00
       until => 1098342189, # was 1100905200/2004-11-20 00:00
       text  => 'L 34; (Philipp-M�ller-Str.); OL Strausberg Fahrbahninstandsetzung Vollsperrung 20.10.2004-19.11.2004 ',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 43553,20466 43584,20871
userdel	2 43553,20466 43110,19818
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
     { from  => 1102981474, # 2004-12-14 00:44
       until => 1109631600, # 2005-03-01 00:00
       text  => 'Naumannstr. (Sch�neberg) in beiden Richtungen zwischen Torgauer Str. und Tempelhofer Weg Br�ckenarbeiten, Stra�e vollst�ndig gesperrt (bis 28.02.2005)',
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
userdel	2 375,28109 938,28349
EOF
     },
     { from  => 1103789525, # 2004-12-23 09:12
       until => 1104533999, # 2004-12-31 23:59
       text  => 'Blankenburger Weg - Blankenburger-Weg-Br�cke (Pankow) Richtung Bahnhofstr. zwischen Pasewalker Str. und Bahnhofsstra�e Baustelle, Einbahnstra�e in Richtung Bahnhofstr. (bis 12/2004)',
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
     { from  => 1098568800, # 2004-10-24 00:00
       until => 1104534000, # 2005-01-01 00:00
       text  => 'L 302; (Sch�neicher Stra�e in Sch�neiche); zwischen Stegeweg bis Dorfaue Gleisbau Vollsperrung 25.10.2004-31.12.2004 ',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4 31221,8312 30688,8432
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
userdel	2 8489,11782 8326,11732
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
       until => 1114898400, # 2005-05-01 00:00
       text  => 'L 401; (Lindenallee); OL Zeuthen, zw. Platanenallee und Ahornallee grundhafter Stra�enbau Vollsperrung 01.11.2004-30.04.2005 ',
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
       until => 1114898400, # 2005-05-01 00:00
       text  => 'L 19; (Zechlinerh�tte-Wesenberg (MVP)); zw. Abzw. Klein Zerlang u. LG (n�. Prebelowbr�cke) Br�ckenneubau Vollsperrung 11.10.2004-30.04.2005 ',
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
userdel	2 -13743,20218 -13941,20658
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
     { from  => 1100942003, # 2004-11-20 10:13
       until => 1102713377, # 2004-12-15 23:59 (fr�her beendet)
       text  => 'Volkradstr. (Friedrichsfelde) in Richtung Rummelsburger Str. ab Sewanstr. Baustelle, Fahrtrichtung gesperrt, Umleitung: Sewanstr. - Rummelsburger Str. (bis Mitte 12.2004)',
       type  => 'handicap',
       data  => <<EOF,
userdel	q4; 17427,10259 17621,10994
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
userdel	q4; 8595,12066 8571,11846
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
       until => 1117576800, # 2005-06-01 00:00
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
     { from  => 1102540046, # 2004-12-08 22:07
       until => 1104533999, # 2004-12-31 23:59
       text  => 'Johannisthaler Chaussee (Neuk�lln) in H�he der Ernst-Keller-Br�cke Baustelle, Stra�e vollst�ndig gesperrt wegen Br�ckenneubau (bis Ende 2004)',
       type  => 'gesperrt',
       data  => <<EOF,
userdel	2 15573,4122 15608,4175
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
       until => 1122760800, # 2005-07-31 00:00
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
userdel	2 9890,12161 9853,12402
userdel	2 9803,12243 9782,12393
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
    );
