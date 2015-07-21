# -*- perl -*-

#
# $Id: Brandenburg_DE.pm,v 1.4 2005/04/29 23:37:15 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 2001 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://bbbike.de
#

# Das Land Brandenburg

package Geography::Brandenburg_DE;
use strict;
use vars qw(%parts %kfz);

use base qw(Geography::Base);

my $partdef =
    ['Barnim',
     ['Ahrensfelde',
      'Basdorf',
      'Bernau' => ['Birkholzaue', 'Waldsiedlung'],
      'Biesenthal',
      'Blumberg',
      'Klosterfelde',
      'Lanke',
      'Lindenberg',
      'Lobetal',
      'Mehrow-Trappenfelde',
      'Sch�nerlinde',
      'Sch�nwalde',
      'Schwanebeck' => ['Neu-Schwanebeck'],
      'Seefeld',
      'Tiefensee',
      'Wandlitz',
      'Werneuchen' => ['Stienitzaue'],
      'Zepernick',
     ],

     'Havelland',
     ['Bredow' => ['Glien'],
      'Brieselang',
      'Dallgow-D�beritz' => ['Rohrbeck'],
      'Falkensee' => ['Falkenhain', 'Finkenkrug', 'Seegefeld'],
      'Ketzin',
      'Perwenitz',
      'Priort',
      'Sch�nwalde' => ['Siedlung'],
      'Wustermark' => ['Dyrotz', 'Nord'],
     ],

     'Landkreis Dahme-Spree',
     ['Bestensee',
      'Dannenreich' => ['Friedrichshof'],
      'Friedersdorf',
      'Gr�bendorf',
      'Kablow',
      'Kiekebusch' => ['Karlshof'],
      'K�nigs Wusterhausen',
      'Mittenwalde',
      'Motzen',
      'Niederlehme',
      'P�tz',
      'Prieros',
      'Sch�nefeld',
      'Streganz' => ['Klein Eichholz'],
      'Waltersdorf',
      'Wernsdorf',
      'Wildau',
      'Wolzig',
      'Zernsdorf',
      'Zeuthen',
     ],

     'Landkreis Oder-Spree',
     ['Alt-Stahnsdorf' => 'Neu Stahnsdorf',
      'Erkner',
      'Gosen',
      'Hangelsberg',
      'Hartmannsdorf',
      'Kagel',
      'Markgrafpieske',
      'Sch�neiche',
      'Spreeau',
      'Spreenhagen',
      'Woltersdorf',
     ],

     'M�rkisch Oderland',
     ['Altlandsberg',
      'Dahlwitz-Hoppegarten',
      'Fredersdorf-Vogelsdorf' => ['Fredersdorf', 'Vogelsdorf'],
      'Herzfelde',
      'H�now',
      'M�nchehofe',
      'Neuenhagen',
      'Rehfelde',
      'R�dersdorf',
      'Strausberg',
     ],

     'Oberhavelland',
     ['B�renklau',
      'Birkenwerder',
      'B�tzow' => ['West'],
      'Germendorf',
      'Gro�-Ziethen',
      'Hennigsdorf' => ['Nieder Neuendorf', 'Nord', 'Stolpe-S�d'],
      'Hohen Neuendorf' => ['Bergfelde', 'Stolpe', 'Borgsdorf'],
      'Kremmen',
      'Leegebruch',
      'Lehnitz',
      'M�hlenbeck' => ['Feldheim'],
      'Oberkr�mer' => ['Klein-Ziethen', 'Vehlefanz'],
      'Oranienburg' => ['Sachsenhausen', 'Eden'],
      'Schildow',
      'Schmachtenhagen',
      'Sch�nflie�',
      'Schwante',
      'Velten' => ['Hohensch�pping'],
      'Wensickendorf',
      'Zehlendorf',
      'Z�hlsdorf',
     ],

     'Potsdam',
     ['Am Schlaatz',
      'Am Stern',
      'Babelsberg',
      'Berliner Vorstadt',
      'Bornim',
      'Bornstedt',
      'Brandenburger Vorstadt',
      'Drewitz',
      'Eiche',
      'Innenstadt',
      'J�ger Vorstadt',
      'Kirchsteigfeld',
      'Nauener Vorstadt',
      'Nedlitz',
      'Potsdam West',
      'Sacrow',
      'Teltower Vorstadt',
      'Templiner Vorstadt',
      'Waldstadt',
      'Wildpark',
      'Zentrum Ost',
     ],

     'Potsdam-Mittelmark',
     ['Beelitz-Heilst�tten',
      'Bergholz-Rehbr�cke',
      'Bochow',
      'Damsdorf',
      'Derwitz',
      'Fahrland-Krampnitz',
      'Ferch',
      'Ferch-Schmerberg',
      'Fichtenwalde',
      'Geltow',
      'Golm',
      'Gro� Kreutz',
      'Kleinmachnow' => ['Dreilinden'],
      'Langerwisch',
      'Lehnin',
      'Michendorf',
      'Philippsthal',
      'Ph�ben',
      'Saarmund',
      'Satzkorn',
      'Schenkenhorst',
      'Seddiner See-Neuseddin',
      'Seeburg',
      'Stahnsdorf',
      'Teltow',
      'T�plitz' => ['Alt-T�plitz'],
      'Uetz',
      'Werder' => ['Bliesendorf', 'Pl�tzin'],
      'Wildenbruch',
      'Wilhelmshorst',
     ],

     'Teltow-Fl�ming',
     ['Gro�beeren',
      'Ludwigsfelde' => ['Genshagen'],
      'Siethen',
     ],

    ];

%kfz = (qw(B   Berlin
	   BAR Barnim
	   HVL Havelland
	   OHV Oberhavelland
	   P   Potsdam
	   PM  Potsdam-Mittelmark
	   TF  Teltow-Fl�ming
	  ),
	LDS => 'Landkreis Dahme-Spree',
	LOS => 'Landkreis Oder-Spree',
	MOL => 'M�rkisch Oderland',
       );

1;

__END__
