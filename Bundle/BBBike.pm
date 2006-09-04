# -*- perl -*-

package Bundle::BBBike;

$VERSION = sprintf("%d.%02d", q$Revision: 1.2 $ =~ /(\d+)\.(\d+)/);

1;

__END__

=head1 NAME

Bundle::BBBike - A bundle to install all dependencies of BBBike

=head1 SYNOPSIS

 perl -I`pwd` -MCPAN -e 'install Bundle::BBBike'

=head1 CONTENTS


Tk 800.000	- das absolute Muss!

Tk::FireButton	- "Firebutton"-Funktionalit�t f�r die Windrose

Tk::Pod 2.8	- Online-Hilfe

Tk::FontDialog	- zum �ndern des Zeichensatzes aus dem Programm heraus

Tk::JPEG

Tie::Watch

Tk::HistEntry

Tk::Stderr	- optionales Redirect von Fehlermeldungen in ein Tk-Fenster

Tk::DateEntry 1.38

Tk::Date

Tk::PNG	- F�r Icons mit besserer Alpha-Unterst�tzung

Tk::NumEntry 2.06

LWP::UserAgent	- f�r die WWW-Verbindungen (z.B. Wetterbericht); in der Perl/Tk-GUI empfohlen f�r Daten-Updates �ber das Internet (ansonsten wird Http.pm verwendet)

Image::Magick	- f�r Bildmanipulationen beim Radar-Bild der FU

Apache::Session::DB_File	- optionale Session-Verwaltung f�r das CGI-Programm, notwendig f�r wapbbbike

Apache::Session::Counted	- optionale aber sehr zu empfehlende Session-Verwaltung f�r das CGI-Programm

XML::SAX	- CPAN.pm kann XML::SAX nicht �ber XML::Simple automatisch installieren

XML::Simple	- optional f�r XML-Dumps der BBBike-Route

XML::Parser	- optional f�r UAProf parsing (alternative w�re XML::SAX::PurePerl)

XML::LibXML	- optional f�r das Parsen und Erzeugen von GPX-Dateien

XML::Twig	- alternativ f�r das Parsen und Erzeugen von GPX-Dateien, ben�tigt XML::Parser

YAML	- optional f�r YAML-Dumps der BBBike-Route sowie fuer temp_blockings

Mail::Mailer 1.53	- falls man aus bbbike heraus E-Mails mit der Routenbeschreibung verschicken will

MIME::Lite	- Versenden von Benutzer-Kommentaren im Webinterface

String::Approx 2.7	- oder man verwendet agrep (mindestens Version 3.0)

String::Similarity	- optional f�r den temp_blockings-Editor und ungenaue Suche in der Perl/Tk-Applikation

Storable	- f�r das Caching beim CGI-Programm

MLDBM

GD 1.18	- zum On-the-fly-Erzeugen von Grafiken beim CGI-Programm

Chart::ThreeD::Pie	- Tortendiagramme in der Statistik

List::Permutor	- F�r das Problem des Handlungsreisenden

PDF::Create 0.06	- Erzeugung der Route als PDF-Dokument --- die neueste Version ist nur auf sourceforge erh�ltlich! (http://prdownloads.sourceforge.net/perl-pdf/perl-pdf-0.06.1b.tar.gz?download oder direkt: http://heanet.dl.sourceforge.net/sourceforge/perl-pdf/perl-pdf-0.06.1b.tar.gz)

Font::Metrics::Helvetica	- F�r die Reparatur der Zeichenbreitentabellen in PDF::Create

BSD::Resource

Devel::Peek

Statistics::Descriptive

Math::MatrixReal

Class::Accessor	- f�r GPS::GpsmanData, die ESRI-Module etc.

Template	- f�r BBBikeDraw::MapServer

Inline::C	- f�r den schnelleren Suchalgorithmus, siehe ext/Strassen-Inline

Pod::Usage	- f�r das Ausgeben der 'Usage' in einigen Entwicklungs-Tools

Palm::PalmDoc	- f�r das Erzeugen von palmdoc-Dateien mit der Routenbeschreibung

Astro::Sunrise	- Anzeige des Sonnenuntergangs/-aufgangs im Info-Fenster

WWW::Shorten	- K�rzen der langen Mapserver-Links im Info-Fenster

File::ReadBackwards	- LogTracker plugin, Edititeren

Date::Pcalc	- LogTracker plugin (m�gliche Alternative ist Date::Calc)

XBase	- Erzeugen der Mapserver- oder anderer ESRI-Dateien, notwendig f�r radzeit.de

IPC::Run	- hilft bei der sicheren Ausf�hrung von externen Kommandos (insbesondere f�r Win32)

Imager	- additional optional BBBikeDraw backend for PNG graphics

Image::ExifTool	- f�r geocode_images

SVG	- additional optional BBBikeDraw backend for SVG graphics

Object::Iterate	- Notwendig f�r die radzeit.de-Version (bbd2esri)

Object::Realize::Later	- Notwendig f�r Strassen::Lazy, selten ben�tigt

Archive::Zip	- Zum Zippen der BBBike-Daten in bbbike-data.cgi

Text::CSV_XS	- F�r das Parsen des MapInfo-Formats

DBI	- F�r XBase/MySQL, siehe unten

DBD::XBase	- F�r das Parsen des ESRI-Shapefile-Formats

XBase	- Ebenfalls f�r das Parsen des ESRI-Shapefile-Formats

DBD::mysql	- F�r den Zugriff auf die Hausnummerdatenbank

Tie::IxHash	- Damit Direktiven in Stra�en-Daten geordnet bleiben

CDB_File	- F�r die alternative A*-Optimierung in XS/C

DB_File::Lock	- Same DB_File operations, used in Strassen::Index

GPS::Garmin	- f�r GPS-Upload

Image::Info

Test::More

Test::Differences

Test::NoWarnings

WWW::Mechanize	- F�r Testen des CGI-Interfaces

Devel::Leak	- F�r Memory-Leak-Tests


=head1 DESCRIPTION

Dieses BE<uuml>ndel listet alle erforderlichen und empfohlenen Module
fE<uuml>r BBBike auf. Bis auf B<Tk> sind alle anderen Module optional.

This bundle lists all required and optional perl modules for BBBike.
Only B<Tk> is really required, all other modules are optional.

=head1 AUTHOR

Slaven Rezic <slaven@rezic.de>

=cut
