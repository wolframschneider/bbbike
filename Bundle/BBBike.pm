# -*- perl -*-

package Bundle::BBBike;

$VERSION = sprintf("%d.%02d", q$Revision: 2.3 $ =~ /(\d+)\.(\d+)/);

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

LWP::UserAgent	- f�r die WWW-Verbindungen (z.B. Wetterbericht)

Image::Magick	- f�r Bildmanipulationen beim Radar-Bild der FU

Apache::Session::DB_File	- optionale Session-Verwaltung f�r das CGI-Programm, notwendig f�r wapbbbike

Apache::Session::Counted	- optionale aber sehr zu empfehlende Session-Verwaltung f�r das CGI-Programm

XML::SAX	- CPAN.pm kann XML::SAX nicht �ber XML::Simple automatisch installieren

XML::Simple	- optional f�r XML-Dumps der BBBike-Route

XML::Parser	- optional f�r UAProf parsing (alternative w�re XML::SAX::PurePerl)

XML::LibXML	- optional f�r das Parsen von GPX-Dateien

YAML	- optional f�r YAML-Dumps der BBBike-Route sowie fuer temp_blockings

Mail::Send	- falls man aus bbbike heraus E-Mails mit der Routenbeschreibung verschicken will

String::Approx 2.7	- oder man verwendet agrep (mindestens Version 3.0)

String::Similarity	- optional f�r den temp_blockings-Editor

Storable	- f�r das Caching beim CGI-Programm

MLDBM

GD 1.18	- zum On-the-fly-Erzeugen von Grafiken beim CGI-Programm

Chart::ThreeD::Pie	- Tortendiagramme in der Statistik

List::Permutor	- F�r das Problem des Handlungsreisenden

PDF::Create 0.06	- Erzeugung der Route als PDF-Dokument --- die neueste Version ist nur auf sourceforge erh�ltlich! (http://prdownloads.sourceforge.net/perl-pdf/perl-pdf-0.06.1b.tar.gz?download)

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

File::ReadBackwards	- LogTracker plugin, Edititeren

Date::Pcalc	- LogTracker plugin (Alternative w�re Date::Calc)

XBase	- Erzeugen der Mapserver- oder anderer ESRI-Dateien, notwendig f�r radzeit.de

IPC::Run	- hilft bei der sicheren Ausf�hrung von externen Kommandos (insbesondere f�r Win32)

Imager	- additional optional BBBikeDraw backend for PNG graphics

Image::ExifTool	- f�r geocode_images

SVG	- additional optional BBBikeDraw backend for SVG graphics

Object::Iterate	- Notwendig f�r die radzeit.de-Version (bbd2esri)

Image::Info

Test::More

Test::Differences

Test::NoWarnings

WWW::Mechanize	- F�r Testen des CGI-Interfaces


=head1 DESCRIPTION

Dieses BE<uuml>ndel listet alle erforderlichen und empfohlenen Module
fE<uuml>r BBBike auf. Bis auf B<Tk> sind alle anderen Module optional.

This bundle lists all required and optional perl modules for BBBike.
Only B<Tk> is really required, all other modules are optional.

=head1 AUTHOR

Slaven Rezic <slaven@rezic.de>

=cut
