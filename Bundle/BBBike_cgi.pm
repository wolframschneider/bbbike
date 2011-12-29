# -*- perl -*-

package Bundle::BBBike_cgi;

$VERSION = sprintf("%d.%02d", q$Revision: 1.3 $ =~ /(\d+)\.(\d+)/);

1;

__END__

=head1 NAME

Bundle::BBBike_cgi - A bundle to install cgi dependencies of BBBike

=head1 SYNOPSIS

 perl -I`pwd` -MCPAN -e 'install Bundle::BBBike_cgi'

=head1 CONTENTS


LWP::UserAgent	- f�r die WWW-Verbindungen (z.B. Wetterbericht); in der Perl/Tk-GUI empfohlen f�r Daten-Updates �ber das Internet (ansonsten wird Http.pm verwendet)

Apache::Session::DB_File	- optionale Session-Verwaltung f�r das CGI-Programm, notwendig f�r wapbbbike

Apache::Session::Counted	- optionale aber sehr zu empfehlende Session-Verwaltung f�r das CGI-Programm

XML::Simple	- optional f�r XML-Dumps der BBBike-Route

XML::Parser	- optional f�r UAProf parsing (bevorzugt wird allerdings XML::LibXML::SAX oder XML::SAX::PurePerl)

YAML	- optional f�r YAML-Dumps der BBBike-Route sowie fuer temp_blockings

JSON::XS	- optional f�r JSON-Dumps der BBBike-Route und diverse Serialisierungsaufgaben

MIME::Lite	- Versenden von Benutzer-Kommentaren im Webinterface

String::Approx 2.7	- oder man verwendet agrep (mindestens Version 3.0)

GD 1.18	- zum On-the-fly-Erzeugen von Grafiken beim CGI-Programm

PDF::Create 0.06	- Erzeugung der Route als PDF-Dokument

Cairo	- Erzeugung der Route als PDF-Dokument, alternativer Renderer

Pango	- Erzeugung der Route als PDF-Dokument, alternativer Renderer

Class::Accessor	- f�r die ESRI-Module etc.

Template	- f�r BBBikeDraw::MapServer

Palm::PalmDoc	- f�r das Erzeugen von palmdoc-Dateien mit der Routenbeschreibung

XBase	- Erzeugen der Mapserver- oder anderer ESRI-Dateien

SVG	- additional optional BBBikeDraw backend for SVG graphics

Object::Iterate	- Notwendig f�r die bbd2-esri-Konvertierung

Archive::Zip	- Zum Zippen der BBBike-Daten in bbbike-data.cgi

Geo::SpaceManager 0.91	- Intelligentere Labelplatzierung, bei der PDF-Ausgabe verwendet

WWW::Mechanize	- F�r Testen des CGI-Interfaces

WWW::Mechanize::FormFiller	- F�r Testen des CGI-Interfaces


=head1 DESCRIPTION

Module f�r eine CGI-Installation.

=head1 AUTHOR

Slaven Rezic <slaven@rezic.de>

=cut
