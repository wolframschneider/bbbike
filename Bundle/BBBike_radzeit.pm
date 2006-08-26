# -*- perl -*-

package Bundle::BBBike_radzeit;

$VERSION = sprintf("%d.%02d", q$Revision: 1.1 $ =~ /(\d+)\.(\d+)/);

1;

__END__

=head1 NAME

Bundle::BBBike - A bundle to install radzeit dependencies of BBBike

=head1 SYNOPSIS

 perl -I`pwd` -MCPAN -e 'install Bundle::BBBike_radzeit'

=head1 CONTENTS


LWP::UserAgent	- f�r die WWW-Verbindungen (z.B. Wetterbericht)

Apache::Session::DB_File	- optionale Session-Verwaltung f�r das CGI-Programm, notwendig f�r wapbbbike

Apache::Session::Counted	- optionale aber sehr zu empfehlende Session-Verwaltung f�r das CGI-Programm

XML::Simple	- optional f�r XML-Dumps der BBBike-Route

XML::Parser	- optional f�r UAProf parsing (alternative w�re XML::SAX::PurePerl)

YAML	- optional f�r YAML-Dumps der BBBike-Route sowie fuer temp_blockings

MIME::Lite	- Versenden von Benutzer-Kommentaren im Webinterface

String::Approx 2.7	- oder man verwendet agrep (mindestens Version 3.0)

GD 1.18	- zum On-the-fly-Erzeugen von Grafiken beim CGI-Programm

PDF::Create 0.06	- Erzeugung der Route als PDF-Dokument --- die neueste Version ist nur auf sourceforge erh�ltlich! (http://prdownloads.sourceforge.net/perl-pdf/perl-pdf-0.06.1b.tar.gz?download oder direkt: http://heanet.dl.sourceforge.net/sourceforge/perl-pdf/perl-pdf-0.06.1b.tar.gz)

Class::Accessor	- f�r GPS::GpsmanData, die ESRI-Module etc.

Template	- f�r BBBikeDraw::MapServer

Palm::PalmDoc	- f�r das Erzeugen von palmdoc-Dateien mit der Routenbeschreibung

XBase	- Erzeugen der Mapserver- oder anderer ESRI-Dateien, notwendig f�r radzeit.de

SVG	- additional optional BBBikeDraw backend for SVG graphics

Object::Iterate	- Notwendig f�r die radzeit.de-Version (bbd2esri)

Archive::Zip	- Zum Zippen der BBBike-Daten in bbbike-data.cgi

WWW::Mechanize	- F�r Testen des CGI-Interfaces


=head1 DESCRIPTION

Module f�r die Installation auf radzeit.de.

=head1 AUTHOR

Slaven Rezic <slaven@rezic.de>

=cut
