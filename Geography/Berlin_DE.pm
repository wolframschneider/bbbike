# -*- perl -*-

#
# $Id: Berlin_DE.pm,v 1.16 2005/04/27 00:12:11 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 2000 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: eserte@cs.tu-berlin.de
# WWW:  http://user.cs.tu-berlin.de/~eserte/
#

package Geography::Berlin_DE;

use strict;
# private:
use vars qw(%subcityparts %cityparts %subcitypart_to_citypart %properties);

# (alte) Bezirke => Bezirksteile
%subcityparts =
    (
     'Charlottenburg'	 => [qw/Charlottenburg-Nord Pichelsberg Westend
			        Witzleben Halensee/],
     'Friedrichshain'	 => [],
     'Hellersdorf'	 => [qw/Kaulsdorf Mahlsdorf/],
     'Hohensch�nhausen'	 => [qw/Falkenberg Margaretenh�he Wartenberg Malchow/],
     'Kreuzberg'	 => [],
     'K�penick'		 => [qw/Friedrichshagen Gr�nau Hessenwinkel
			        Karolinenhof
			        M�ggelheim Obersch�neweide Rahnsdorf
			        Schm�ckwitz Wilhelmshagen/],
     'Lichtenberg'	 => [qw/Friedrichsfelde Karlshorst/],
     'Marzahn'		 => [qw/Biesdorf/],
     'Mitte'		 => [],
     'Neuk�lln'		 => [qw/Britz Buckow Rudow/],
     'Pankow'		 => [qw/Blankenfelde Buchholz Buch Niedersch�nhausen
			        Rosenthal Franz�sisch-Buchholz/],
     'Prenzlauer Berg'	 => [],
     'Reinickendorf'	 => [qw/Borsigwalde Frohnau Heiligensee Hermsdorf
			        Konradsh�he L�bars Tegel Waidmannslust
			        Wittenau/, 'M�rkisches Viertel'],
     'Sch�neberg'	 => [qw/Friedenau Sch�neberg-Nord/],
     'Spandau'		 => [qw/Gatow Kladow Siemensstadt Haselhorst Staaken/],
     'Steglitz'		 => [qw/Lankwitz Lichterfelde/],
     'Tempelhof'	 => [qw/Lichtenrade Mariendorf Marienfelde/],
     'Tiergarten'	 => [qw/Tiergarten-S�d Hansaviertel Moabit/],
     'Treptow'		 => [qw/Adlershof Altglienicke Baumschulenweg
			        Bohnsdorf Johannisthal
			        Niedersch�neweide/],
     'Wedding'		 => [qw/Gesundbrunnen/],
     'Wei�ensee'	 => [qw/Blankenburg Heinersdorf Karow/],
     'Wilmersdorf'	 => [qw/Grunewald Schmargendorf/],
     'Zehlendorf'	 => [qw/Dahlem Nikolassee Wannsee/],
    );

while(my($cp,$scp) = each %subcityparts) {
    $subcitypart_to_citypart{$cp} = $cp; # self-reference
    foreach (@$scp) { $subcitypart_to_citypart{$_} = $cp }
}

# (neue) Bezirke => (alte) Bezirke
%cityparts =
    ('Mitte'                            => [qw/Mitte Tiergarten Wedding/],
     # XXX wrong Alias?
     'Mitte-Tiergarten-Wedding'         => [qw/Mitte Tiergarten Wedding/],
     'Friedrichshain-Kreuzberg'         => [qw/Friedrichshain Kreuzberg/],
     'Pankow-Prenzlauer Berg-Wei�ensee' => [qw/Pankow Wei�ensee/,
					    'Prenzlauer Berg'],
     # XXX wrong Alias?
     'Pankow-Prenzlauer Berg-Weissensee' => [qw/Pankow Wei�ensee/,
					     'Prenzlauer Berg'],
     'Charlottenburg-Wilmersdorf'       => [qw/Charlottenburg Wilmersdorf/],
     'Spandau'                          => ['Spandau'],
     'Steglitz-Zehlendorf'              => [qw/Steglitz Zehlendorf/],
     'Tempelhof-Sch�neberg'             => [qw/Tempelhof Sch�neberg/],
     'Neuk�lln'                         => [qw/Neuk�lln/],
     'Treptow-K�penick'                 => [qw/Treptow K�penick/],
     'Marzahn-Hellersdorf'              => [qw/Marzahn Hellersdorf/],
     'Lichtenberg-Hohensch�nhausen'     => [qw/Lichtenberg Hohensch�nhausen/],
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

sub new {
    my($class) = @_;
    bless {}, $class;
}

# cityname in native or common language
sub cityname { "Berlin" }

sub center { "8581,12243" } # Brandenburger Tor

sub supercityparts { sort keys %cityparts }
sub cityparts      { sort keys %subcityparts }
sub subcityparts   { map { (@$_) } values %subcityparts }

sub citypart_to_subcitypart { \%subcityparts }
sub subcitypart_to_citypart { \%subcitypart_to_citypart }

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
    if ($strname =~ /berlin\s*-\s*usedom/i) {
	$type = 'BU';
    } elsif ($strname =~ /berlin\s*-\s*kopenhagen/i) {
	$type = 'BK';
    } elsif ($strname =~ /mauer.*weg/i) {
	$type = 'M';
    } elsif ($strname =~ /havellandradweg/i) {
	$type = 'HVL';
    } elsif ($strname =~ /spreeradweg/i) {
	$type = 'S';
    } elsif ($strname =~ /hofjagdweg/i) {
	$type = 'H';
    }
    if (defined $type) {
	$do_round = 1;
    }
    ($type, undef, $do_round);
}

1;

__END__
