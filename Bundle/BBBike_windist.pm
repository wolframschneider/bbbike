# -*- perl -*-

package Bundle::BBBike_windist;

$VERSION = sprintf("%d.%02d", q$Revision: 1.3 $ =~ /(\d+)\.(\d+)/);

1;

__END__

=head1 NAME

Bundle::BBBike_windist - A bundle to install windows distribution dependencies of BBBike

=head1 SYNOPSIS

 perl -I`pwd` -MCPAN -e 'install Bundle::BBBike_windist'

=head1 CONTENTS


Tk 800.000	- das absolute Muss!

Tk::FireButton	- "Firebutton"-Funktionalit�t f�r die Windrose

Tk::Pod 2.8	- Online-Hilfe

Tk::FontDialog	- zum �ndern des Zeichensatzes aus dem Programm heraus

Tk::JPEG

Tie::Watch

Tk::HistEntry

Tk::Stderr	- optionales Redirect von Fehlermeldungen in ein Tk-Fenster

Tk::Date

Tk::PNG	- F�r Icons mit besserer Alpha-Unterst�tzung

Tk::NumEntry 2.06

LWP::UserAgent	- f�r die WWW-Verbindungen (z.B. Wetterbericht); in der Perl/Tk-GUI empfohlen f�r Daten-Updates �ber das Internet (ansonsten wird Http.pm verwendet)

XML::Twig	- alternativ f�r das Parsen und Erzeugen von GPX-Dateien, ben�tigt XML::Parser

String::Approx 2.7	- oder man verwendet agrep (mindestens Version 3.0)

Storable	- f�r das Caching beim CGI-Programm

MLDBM

Algorithm::Permute 0.08	- F�r das Problem des Handlungsreisenden (schnellerer Permutor)

List::Permutor	- F�r das Problem des Handlungsreisenden (langsamerer Permutor)

PDF::Create 0.06	- Erzeugung der Route als PDF-Dokument

Win32::API	- F�r das Ermitteln der verf�gbaren Desktop-Gr��e

Win32::Registry

Win32::Shortcut

Class::Accessor	- f�r die ESRI-Module etc.

IPC::Run	- hilft bei der sicheren Ausf�hrung von externen Kommandos (insbesondere f�r Win32)

Object::Iterate	- Notwendig f�r die bbd2-esri-Konvertierung

Tie::IxHash	- Damit Direktiven in Stra�en-Daten geordnet bleiben

GPS::Garmin	- f�r GPS-Upload

Geo::METAR	- Wetterdaten im METAR-Format


=head1 DESCRIPTION

Module f�r die bin�re Windows-Distribution.

=head1 AUTHOR

Slaven Rezic <slaven@rezic.de>

=cut
