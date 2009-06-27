# -*- perl -*-

#
# $Id: Berlin_DE.pm,v 1.30 2008/10/06 19:07:34 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 2000,2006 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: srezic@cpan.org
# WWW:  http://www.bbbike.de
#

# �berarbeiten anhand http://de.wikipedia.org/wiki/Berlin!
# U.U. "Ortslagen" (subsubcityparts) einf�hren

package Geography::Berlin_DE;

use strict;
# private:
use vars qw(%subcityparts %cityparts %subcitypart_to_citypart %properties);

use base qw(Geography::Base);

######################################################################
# Der Superbezirk Lichtenberg wird voraussichtlich folgende Stadtteile
# bekommen (siehe
# http://www.berlin.de/ba-lichtenberg/buergerdienste/stadtteilprofil1.html)
#
# 1 Malchow, Wartenberg, Falkenberg
# 2 Neu-Hohensch�nhausen Nord
# 3 Neu-Hohensch�nhausen S�d
# 
# 4 Alt-Hohensch�nhausen Nord
# 5 Alt-Hohensch�nhausen S�d
#
# 6 Fennpfuhl
# 7 Alt-Lichtenberg
# 
# 8 Frankfurter Allee S�d
# 9 Neu-Lichtenberg
# 10 Friedrichsfelde Nord
# 11 Friedrichsfelde S�d
#
# 12 Rummelsburger Bucht
# 13 Karlshorst

# (alte) Bezirke => Bezirksteile
%subcityparts =
    (
     'Charlottenburg'	 => [qw/Charlottenburg-Nord Pichelsberg Westend
			        Witzleben/],
     'Friedrichshain'	 => [],
     'Hellersdorf'	 => [qw/Kaulsdorf Mahlsdorf/],
     'Hohensch�nhausen'	 => [qw/Falkenberg Margaretenh�he Wartenberg Malchow/,
			     "Alt-Hohensch�nhausen", "Neu-Hohensch�nhausen"],
     'Kreuzberg'	 => [],
     # XXX Karolinenhof ist eine Ortslage in Schm�ckwitz (siehe http://de.wikipedia.org/wiki/Berlin-Schm%C3%B6ckwitz)
     'K�penick'		 => [qw/Friedrichshagen Gr�nau Hessenwinkel
			        Karolinenhof
			        M�ggelheim Obersch�neweide Rahnsdorf
			        Schm�ckwitz Wilhelmshagen/],
     'Lichtenberg'	 => [qw/Friedrichsfelde Karlshorst Rummelsburg
				Fennpfuhl/],
     'Marzahn'		 => [qw/Biesdorf/],
     'Mitte'		 => [],
     'Neuk�lln'		 => [qw/Britz Buckow Rudow Gropiusstadt/],
     'Pankow'		 => [qw/Blankenfelde Buch Niedersch�nhausen
			        Rosenthal Buchholz Wilhelmsruh/,
			     'Franz�sisch Buchholz',
			     'Stadtrandsiedlung Malchow',
			    ], # Buchholz hei�t heute "Franz�sisch Buchholz"
     'Prenzlauer Berg'	 => [],
     'Reinickendorf'	 => [qw/Borsigwalde Frohnau Heiligensee Hermsdorf
			        Konradsh�he L�bars Tegel Waidmannslust
			        Wittenau/, 'M�rkisches Viertel'],
     'Sch�neberg'	 => [qw/Friedenau Sch�neberg-Nord/],
     'Spandau'		 => [qw/Gatow Kladow Siemensstadt Haselhorst Staaken
				Wilhelmstadt Hakenfelde/,
			     'Falkenhagener Feld'],
     'Steglitz'		 => [qw/Lankwitz Lichterfelde/],
     'Tempelhof'	 => [qw/Lichtenrade Mariendorf Marienfelde/],
     'Tiergarten'	 => [qw/Tiergarten-S�d Hansaviertel Moabit/],
     'Treptow'		 => [qw/Adlershof Altglienicke Baumschulenweg
			        Bohnsdorf Johannisthal
			        Niedersch�neweide Pl�nterwald/, 'Alt-Treptow'],
     'Wedding'		 => [qw/Gesundbrunnen/],
     'Wei�ensee'	 => [qw/Blankenburg Heinersdorf Karow/],
     'Wilmersdorf'	 => [qw/Grunewald Schmargendorf Halensee/],
     'Zehlendorf'	 => [qw/Dahlem Nikolassee Wannsee/],
    );

while(my($cp,$scp) = each %subcityparts) {
    $subcitypart_to_citypart{$cp} = $cp; # self-reference
    foreach (@$scp) { $subcitypart_to_citypart{$_} = $cp }
}

# (neue) Bezirke => (alte) Bezirke
%cityparts =
    ('Mitte'                            => [qw/Mitte Tiergarten Wedding/],
     'Friedrichshain-Kreuzberg'         => [qw/Friedrichshain Kreuzberg/],
     # war: Pankow-Prenzlauer Berg-Wei�ensee, aber das ist nicht korrekt
     'Pankow'				=> [qw/Pankow Wei�ensee/,
					    'Prenzlauer Berg'],
     'Charlottenburg-Wilmersdorf'       => [qw/Charlottenburg Wilmersdorf/],
     'Spandau'                          => ['Spandau'],
     'Steglitz-Zehlendorf'              => [qw/Steglitz Zehlendorf/],
     'Tempelhof-Sch�neberg'             => [qw/Tempelhof Sch�neberg/],
     'Neuk�lln'                         => [qw/Neuk�lln/],
     'Treptow-K�penick'                 => [qw/Treptow K�penick/],
     'Marzahn-Hellersdorf'              => [qw/Marzahn Hellersdorf/],
     'Lichtenberg' 			=> [qw/Lichtenberg Hohensch�nhausen/],
     'Reinickendorf'                    => [qw/Reinickendorf/],
    );


# XXX Methode
%properties =
    ('has_u_bahn' => 1,
     'has_s_bahn' => 1,
     'has_r_bahn' => 1,
     'has_map'    => 1,
     # XXX etc.: z.B. Icon-Namen, weitere Feinheiten wie
     # map-Names, Zonen, overview-Karte...
    );

# cityname in native or common language
sub cityname { "Berlin" }

sub center { "8581,12243" } # Brandenburger Tor
sub center_name { "Berlin" }

sub supercityparts { sort keys %cityparts }
sub cityparts      { sort keys %subcityparts }
sub subcityparts   { map { (@$_) } values %subcityparts }

sub citypart_to_subcitypart { \%subcityparts }
sub subcitypart_to_citypart { \%subcitypart_to_citypart }

sub get_supercitypart_for_citypart { 
    shift; # object
    my $given_citypart = shift;
    keys %cityparts; # reset!!!
    while(my($supercitypart, $cityparts) = each %cityparts) {
	for my $citypart (@$cityparts) {
	    if ($citypart eq $given_citypart) {
		return $supercitypart;
	    }
	}
    }
    undef;
}

sub get_supercitypart_for_any {
    my $class = shift;
    my $given_part = shift;
    my $subcitypart_to_citypart = $class->subcitypart_to_citypart;
    if (exists $subcitypart_to_citypart->{$given_part}) {
	return $class->get_supercitypart_for_citypart($subcitypart_to_citypart->{$given_part});
    } else {
	my $ret = $class->get_supercitypart_for_citypart($given_part);
	return $ret if defined $ret;
	if (exists $cityparts{$given_part}) {
	    return $given_part;
	}
	return undef;
    }
}

sub get_cityparts_for_supercitypart {
    exists $cityparts{$_[1]} ? @{ $cityparts{$_[1]} } : ()
}

sub get_all_subparts { # ... recursive
    my($class, $name) = @_;
    if (!defined $name) {
	return map { $class->get_all_subparts($_) } $class->cityparts;
    }
    my %res = ($name => undef);
    if (exists $cityparts{$name}) {
	foreach my $cp (@{ $cityparts{$name} }) {
	    my @sub_res = $class->get_all_subparts($cp)
		unless $cp eq $name;
	    @res{@sub_res} = undef;
	}
    }
    if (exists $subcityparts{$name}) {
	@res{ @{$subcityparts{$name}} } = undef;
    }
    sort keys %res;
}

# XXX rename directory data to data_berlin_de?
sub datadir {
    require File::Basename;
    my $pkg = __PACKAGE__;
    $pkg =~ s|::|/|g; # XXX other oses?
    $pkg .= ".pm";
    if (exists $INC{$pkg}) {
	return File::Basename::dirname(File::Basename::dirname($INC{$pkg}))
	    . "/data";
    }
    undef; # XXX better solution?
}

sub parse_street_type_nr {
    my($self, $strname) = @_;
    my $type;
    my $do_round;
    my $image;
    if ($strname =~ /berlin\s*-\s*usedom/i) {
	$type = 'BU';
	$image = "BU.gif";
    } elsif ($strname =~ /berlin\s*-\s*kopenhagen/i) {
	$type = 'BK';
	$image = "BK.gif";
    } elsif ($strname =~ /mauer.*weg/i) {
	$type = 'M';
	$image = 'M.gif';
    } elsif ($strname =~ /havellandradweg/i) {
	$type = 'HVL';
	$image = 'HVL.gif';
    } elsif ($strname =~ /spreeradweg/i) {
	$type = 'SPR';
	$image = 'SPR.gif';
    } elsif ($strname =~ /hofjagdweg/i) {
	$type = 'H';
    } elsif ($strname =~ /uckerm.*rkischer\s+.*rundweg/i) {
	$type = 'UMR';
	$image = 'UMR.gif';
    } elsif ($strname =~ /tour.*brandenburg/i) {
	$type = 'TB';
	$image = 'TB.gif';
    } elsif ($strname =~ /oder.*nei(?:ss|�)e/i) {
	$type = 'ON';
	$image = 'ON.gif';
    } elsif ($strname =~ /flaeming.*skate/i) {
	$type = 'FS';
	$image = 'FS.gif';
    } elsif ($strname =~ /f.*rst.*p.*ckler/i) {
	$type = 'FR';
	$image = 'FR.gif';
    } elsif ($strname =~ /l.*wenberger.*land.*radtour/i) {
	$type = "LLR";
    } elsif ($strname =~ /haff.*radfernweg/i) {
	$type = "Haff";
    } elsif ($strname =~ /ostsee.*radweg/i) {
	$type = "Ostsee";
    } elsif ($strname =~ /berlin.*barnim.*oderbruch/i) {
	$type = 'BBO';
	$image = 'BBO.gif';
    }
    if (defined $type) {
	$do_round = 1;
    }
    ($type, undef, $do_round, $image);
}

sub cgi_list_all_size { "(ca. 150 kB)" }

1;

__END__
