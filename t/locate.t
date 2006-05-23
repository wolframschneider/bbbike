#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: locate.t,v 1.2 2006/05/23 22:25:20 eserte Exp $
# Author: Slaven Rezic
#

use strict;

#use NotYetWritten;

BEGIN {
    if (!eval q{
	use Test::More;
	1;
    }) {
	print "1..0 # skip: no Test::More module\n";
	exit;
    }
}

plan tests => 1;

pass("This is the test for the yet-to-written Strassen::Locate ? module");

my @tests = (
	     ["Boitzenburg" => "22642,95423"], # Stadt in Brandenburg (orte/orte2)
	     ["Berliner Str., Teltow" => "1453,-746"], # Stra�e/Stadt-Kombination
	     ["Teltow, Berliner Str." => "1453,-746"], # Stadt/Stra�e-Kombination
	     ["Berliner Str. (Teltow)" => "1453,-746"], # Stra�e/Stadt-Kombination
	     ["Berliner Str.    (Teltow)" => "1453,-746"], # Stra�e/Stadt-Kombination mit Spaces
	     ["Berliner Stra�e    (Teltow)" => "1453,-746"], # Stra�e/Stadt-Kombination
	     ["berliner stra�e    (teltow)" => "1453,-746"], # Stra�e/Stadt-Kombination, Kleinschreibung
	     ["Wandlitz" => "14822,37589"], # Stadt in Brandenburg (orte/orte2), �hnliche Stra�e in Berlin existiert
	     ["K�nigs Wusterhausen" => "..."], # Ort in Brandenburg
	     ["Berlin, Thaerstra�e" => "..."], # Stadt/Stra�e-Kombination mit Berlin als Stadt
	     ["S-Bahnhof Bernau" => "..."], # S-Bahnh�fe im Umland
	     ["S Zeuthen" => "..."],
	     ["s- bahnhof buch" => "..."], # mit unn�tigen Spaces
	     ["S -Bhf Erkner" => "..."],
	     ["S- Griebnitzsee" => "..."],
	     ["Potsdam Hbf" => "..."], # Potsdam Hbf Variationen
	     ["Potsdam Hauptbahnhof" => "..."],
	     ["S Potsdam HBF" => "..."],
	     ["s-bahnhof potsdam hbf" => "..."],
	     ["Kleinmachnow" => "..."], # Stadt in Brandenburg
	     ["Neurupin Stadt" => "..."], # Bahnhof in Brandenburg mit Rechtschreibfehler
	     ["Siegess�ule" => "..."], # Sehensw�rdigkeit
	     ["checkpoint charly" => "..."], # Sehensw�rdigkeit mit Rechtschreibfehler
	     ["Hamburger Bahnhof" => "..."], # Sehensw�rdigkeit, kein Bahnhof!
	     ["deutsches theater" => "..."], # Sehensw�rdigkeit
	     ["Virchow-Klinikum" => "..."], # m�glicherweise in den Sehensw�rdigkeiten enthalten
	     ["ged�chtniskirche" => "..."], # Sehensw�rdigkeit, Kurzschreibweise
	     ["ICC" => "..."], # Sehensw�rdigkeit
	     ["Charlottenburger Schlo�" => "..."], # sollte das Schlo� Charlottenburg als Ergebnis haben
	     ["Museumsinsel" => "..."], # Fl�che/Sehensw�rdigkeit?
	     ["Nikolaiviertel" => "..."], # dito
	     ["Spandau Altstadt" => "..."], # dito
	     ["zoolog garten" => "..."], # interessante Abk�rzung
	     ["triglaw br�cke" => "..."], # Br�cke
	     ["gotzkowskibr�cke" => "..."], # Br�cke mit Rechtschreibfehler
	     ["berliner str. 76 13189 berlin" => "..."], # Stra�e+Hausnummer+PLZ+Ortsangabe
	     ["Ringstr. 44, 12105 Berlin" => "..."], # dito, mit Interpunktion
	     ["15732 Schulzendorf August-Bebel-Str. 18" => "..."], # andere Reihenfolge, nicht in Berlin
	     ["12359 onkel-br�sig-str." => "..."], # PLZ am Anfang
	     ["12359 berlin" => "..."], # PLZ und Stadt
	     ["10247 Weichselstra�e" => "..."], # PLZ und Stra�e
	     ["Berlin Blankenburg" => "..."], # Ortsteil in Berlin
	     ["Oskar Helene Heim" => "..."], # gibt es als U-Bahnhof und Siedlung
	     ["U Zinnowitzer Stra�e" => "..."], # sollte den U-Bahnhof als Ergebnis haben
	     ["s s�dkreuz" => "..."], # neuer Name
	     ["s papestr" => "..."], # alter Name
	     ["bahnhof wannsee" => "..."], # ohne "S-", Regional-...
	     ["Ulmenallee 39 a" => "..."], # komplizierte Hausnummer mit Space
	     ["Reichenberger Str. 113 a" => "..."], # dito
	     ["k�nigstr 36 b" => "..."], # und nochmal
	     ["Rummelsburger Stra�e 15 A" => "..."], # Gro�buchstaben k�nnen auch vorkommen
	     ["Whulheide" => "..."], # Buchstabendreher, k�nnte den S-Bahnhof oder Park als Ergebnis haben
	     ["Mauerstra�e Berlin-Mitte" => "..."], # Stra�e, Stadt, Ortsteil
	     ["spekteweg 52-berlin spandau" => "..."], # Stra�e, Hausnummer, Stadt, Ortsteil
	     ["priester" => "..."], # sollte priesterweg statt Priesterstege finden
	     ["albertstr, schoeneberg" => "..."], # Stra�e, Ortsteil
	     ["F�hrweg, Woltersdorf" => "..."], # ebenso
	     ["sch�nefeld flughafen" => "..."], # Wortdreher
	     ["M�ggelsee, kl. m�ggelsee" => "..."], # Hmmm...
	     ["zehlendorf s�d" => "..."], # Ortsteil oder ehem. Bahnhof
	     ["lichterfelde" => "..."], # Ortsteil in Berlin
	     ["am langen see" => "..."], # gibt es als strasse, aber nicht in Berlin.coords.data
	     ["stra�e zur krampenburg" => "..."], # ebenso
	     ["Spinnerbr�cke" => "..."], # popul�rer Name, d�rfte in Alias oder so stehen...
	     ["indira-ghandi-allee" => "..."], # allee statt str. oder so
	     ["rudow, d�rferblick" => "..."], # Park/Wald
	     ["Berlin Zob" => "..."], # Zentraler Omnibusbahnhof
	     ["12355 Berlin, Str. 181 Nr. 89" => "..."], # besonders kompliziert...
	     ["reichstr.105" => "..."], # warum wurde hier nichts gefunden? kein space?
	     ["neuer h�nower weg" => "..."], # sollte existieren?
	     ["teerofendamm kleinmachnow" => "..."], # stra�e, stadt
	     ["gro�beerenstr. potsdam" => "..."], # stra�e, stadt, sollte nicht die gleichnamnige Berliner Stra�e ausgeben
	     ["usedom" => "..."], # Hauptstadt von Usedom?
	     ["Av. Ch. de Gaulle 5" => "..."], # Abk. f�r Avenue
	     ["schlo� cecilienhof" => "..."], # Sehensw�rdigkeit im Umland. Neue vs. alte Rechtschreibung ber�cksichtigen
	     ["Schloss Diedersdorf" => "..."], # Sehensw�rdigkeit im Umland.
	     ["glockebturmweg" => "..."], # zu viele Rechtschreibfehler? oder nicht in Berlin.coords.data? oder glockenturmstr. (wieder str./weg/allee etc. verwechselt!)
	     ["Entlastungsstra�e" => ":.."], # ist die Stra�e nicht mehr in Berlin.coords.data oder so enthalten? oldname verwenden!
	     ["F�hre Caputt" => "..."], # ferry, Rechtschreibfehler
	     ["Warschauer STar�e" => "..."], # er hat es tats�chlich geschafft...
	     ["hahn meitner" => "..."], # Institut
	     ["hmi" => "..."], # ebenso
	     ["Lilienthalsstr Ecke S�dstern" => "..."], # Ecken werden nur mit ".../..." erkannt
	     ["Mahlower Str Ecke Fontanestr" => "..."],
	     ["s-bahnhof lichterfelde west" => "..."], # warum wurde dieser hier nicht erkannt? kein bindestrich?
	     ["Hackische H�fe" => "..."], # Sehensw�rdigkeit mit Rechtschreibfehler
	     ["S-Bahnhof Hackischer Markt" =>" ..."], # S-Bhf. mit Rechtschreibfehler
	     ["Berlin-Tegel" => "..."], # ist hier der Ortsteil oder der Flughafen gemeint?
	     ["U-Bahn Tegel" => "..."], # Als Ergebnis kam hier S-Bhf Tegel...
	     ["Heinersdorf bei m�ncheberg" => "..."], # ich benutze selbst "bei"-Variationen in diesen F�llen. Vielleicht lieber die geografische N�he verwenden, also alle Heinersd�rfer in Bezug auf die Entfernung zu M�ncheberg vergleichen.
	     ["Baggersee Biesdorf" => "..."], # wasserstadt
	     ["lankwitz kirche" => "..."], # popul�re Bezeichnung, BVG-Haltestelle?
	     ["Berlin, Flughafen Sch�nefeld" => "..."], # ausschweifend...
	     ["tiergartentunnel" => "..."], # Alias in strassen_bab
	    );

__END__
