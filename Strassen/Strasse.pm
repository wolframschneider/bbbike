# -*- perl -*-

#
# Copyright (c) 1995-2012,2017 Slaven Rezic. All rights reserved.
# This is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License, see the file COPYING.
#
# Author: Slaven Rezic (eserte@cs.tu-berlin.de)
#

package Strassen::Strasse;

$VERSION = 1.38;

package Strasse;
use strict;
#use AutoLoader 'AUTOLOAD';

BEGIN { require Strassen::Core }

use constant NAME   => Strassen::NAME();
use constant COORDS => Strassen::COORDS();
use constant CAT    => Strassen::CAT();

sub new {
    my($class, $obj) = @_;
    bless $obj, $class;
}
sub name        { $_[0]->[NAME] }
sub coords      { $_[0]->[COORDS] }
sub coords_list { @{$_[0]->[COORDS]} }
sub category    { $_[0]->[CAT] }
sub is_empty    { @{$_[0]->[COORDS]} == 0 }
sub coord_as_string { $_[0]->coords->[$_[1]] }
sub coord_as_list {
    my($self, $i) = @_;
    my $s = $self->coords->[$i];
    Strassen::to_koord1($s); # XXX abh�ngig von Strassen!
}

# gibt TRUE zur�ck, wenn ein Teil der Stra�e im angegebenen Rechteck ist
# (keine perfekte L�sung)
### AutoLoad Sub
sub is_in {
    my($self, $x1, $y1, $x2, $y2) = @_;
    my $len = scalar $self->coords_list;
    for(my $i=0; $i<$len; $i++) {
	my($x, $y) = @{$self->coord_as_list($i)};
	if ($x >= $x1 && $x <= $x2 &&
	    $y >= $y1 && $y <= $y2) {
	    return 1;
	}
    }
    0;
}

# statische Methode
#
# XXX more candidates: ...heide, ...tunnel, but there are problems like
# "in die Fu�g�ngertunnel S-Bhf Jungfernheide" or
# "in den Platz am Spreetunnel"
### AutoLoad Sub
sub de_artikel {
    my($strasse) = @_;
    if ($strasse =~ /^(am|an|auf|hinter|im|in|unter|zum|zur|zwischen|u-bhf|s-bhf)\b/i) {
	"=>";
    } elsif ($strasse =~ / - /) {
	"=>";
    } elsif ($strasse =~ /^(avenue\b|rue\b|all�e)\b/i) { # oh la la
	"in die";
    } elsif ($strasse =~ /^(via\b)\b/i) {
	"in die";
    } elsif ($strasse =~ /(str\.|stra�e\b|allee\b|chaussee\b|promenade\b|zeile\b|gasse\b|kehre\b)/i) {
	"in die";
    } elsif ($strasse =~ /(park\b|garten\b|ring\b)/i) {
	"in den";
    } elsif ($strasse =~ /(damm\b|weg\b|steig\b)/i) {
	"in den";
    } elsif ($strasse =~ /(platz\b|steg\b|markt\b|pfad\b)/i) {
	"auf den";
    } elsif ($strasse =~ /(ufer\b|gestell\b)/i) {
	"in das";
    } elsif ($strasse =~ /(br�cke\b)/i) {
	"auf die";
    } elsif ($strasse =~ /(\balt\b)/i) {
	"in die Stra�e";
    } elsif ($strasse =~ /(\btor\b)/i) {
	"in das";
    } elsif ($strasse =~ /(\bstern\b)/i) { # m�glichst am Ende
	"auf den";
    } else {
	"=>";
    }
}

# XXX Maybe de_artikel and de_artikel_dativ should be refactored so
# the regexps are not duplicated here.
sub de_artikel_dativ {
    my($strasse) = @_;
    if ($strasse =~ /^(am|an|auf|hinter|im|in|unter|zum|zur|zwischen|u-bhf|s-bhf)\b/i) {
	"=>";
    } elsif ($strasse =~ / - /) {
	"=>";
    } elsif ($strasse =~ /^(avenue\b|rue\b|all�e)\b/i) { # oh la la
	"auf der";
    } elsif ($strasse =~ /^(via\b)\b/i) {
	"auf der";
    } elsif ($strasse =~ /(str\.|stra�e\b|allee\b|chaussee\b|promenade\b|zeile\b|gasse\b|kehre\b)/i) {
	"auf der";
    } elsif ($strasse =~ /(park\b|garten\b|ring\b)/i) {
	"auf dem";
    } elsif ($strasse =~ /(damm\b|weg\b|steig\b)/i) {
	"auf dem";
    } elsif ($strasse =~ /(platz\b|steg\b|markt\b|pfad\b)/i) {
	"auf dem";
    } elsif ($strasse =~ /(ufer\b|gestell\b)/i) {
	"auf dem";
    } elsif ($strasse =~ /(br�cke\b)/i) {
	"auf der";
    } elsif ($strasse =~ /(\balt\b)/i) {
	"auf der Stra�e";
    } elsif ($strasse =~ /(\btor\b)/i) {
	"auf dem";
    } elsif ($strasse =~ /(\bstern\b)/i) { # m�glichst am Ende
	"auf dem";
    } else {
	"=>";
    }
}

# Den Stra�ennamen so weit wie m�glich abk�rzen...
# Verschiedene Level (0 bis 4) sind m�glich
sub short {
    my($strname, $level, $nodot) = @_;
    my $dot = ($nodot ? "" : ".");
    if ($level >= 4) {
	# abbrev Bernhard-Lichtenberg-Str. to B-Lichtenberg-Str.
	$strname =~ s/^([A-Z])\S+(-[^ -]+-[^ -]+(?: .*)?)$/$1$2/
    }
    if ($level >= 1) {
	$strname =~ s/(s)tra(ss|�)e/$1tr$dot/i;
	$strname =~ s/(p)latz/$1l$dot/i;
	$strname =~ s/(s)teig/$1t$dot/i;
	$strname =~ s/\bBahnhof/Bhf$dot/;
    }
    if ($level >= 3) {
	$strname =~ s/str\.//;
	$strname =~ s/^Str\.\s+de[rs]\s+/S.d./;
	$strname =~ s/^Str\./Str/;
	$strname =~ s/([ \-]S)tr\.//;
	$strname =~ s/(p)l\./$1l/i;
	$strname =~ s/damm/d$dot/;
	$strname =~ s/br(�|ue)cke/br$dot/;
	$strname =~ s/(a)llee/$1$dot/i;
	$strname =~ s/\b(k)leine[srnm]?\b/$1l$dot/i;
	$strname =~ s/\b(g)ro(�|ss)e[srnm]?\b/$1r$dot/i;
	$strname =~ s/Rathaus\s+/Rath./i;
	$strname =~ s/b[eu]rg$/b\'g/;
    } elsif ($level >= 2) {
	$strname =~ s/(s)tr\./$1tr/i;
	$strname =~ s/(p)l\./$1l/i;
    }
    $strname;
}

# Turn
#    B1: Berlin - Potsdam
# into
#    B1: (Berlin -) Potsdam
# or
#    B1: (Potsdam -) Berlin
# depending on the traveling direction.
# Street numbers like "B1" or "F2.2" are recognized.
# A trailing " (...)" or ", ..." is always left at the end.
# Arguments:
#   $backwards: reverse the direction
#   -unicode => 1: use unicode characters, if appropriate
sub beautify_landstrasse {
    my($str, $backwards, %args) = @_;
    my $can_unicode = $args{-unicode};
    if ($str =~ m{^
		  ([^\[]+\[)
		  ([^\]]+)
		  (\])
		  $}x) {
	my($begin, $middle, $end) = ($1, $2, $3);
	return $begin . beautify_landstrasse($middle, $backwards) . $end;
    }
    if ($str =~ m{^
		  (.*\()
		  ([^\)]+\s-\s[^\)]+)
		  (\).*)
		  $}x) {
	my($begin, $middle, $end) = ($1, $2, $3);
	return $begin . beautify_landstrasse($middle, $backwards) . $end;
    }
    if ($str =~ m/^ (.*:\s*)?
		    (.*\s-\s.*?)
		    (\s*[:,].*|\s*\(.*\)\s*)?
		  $/x) {
	(my($pre), $str, my($post)) = ($1, $2, $3);
	$pre  = "" if !defined $pre;
	$post = "" if !defined $post;

	my(@comp) = split /\s-\s/, $str;
	if ($backwards) {
	    @comp = reverse @comp;
	}
	my $arrow = $can_unicode ? chr(0x2192) : "-";
	$str = $pre .
	       "(" . join(" $arrow ", @comp[0 .. $#comp-1]) . " $arrow) " . $comp[-1] .
	       $post;
    }
    $str;
}

# Turn "(Berlin - Potsdam)" or "Berlin - Potsdam" into Berlin (the
# start) or leave the name unchanged.
sub get_first_part {
    my($str) = @_;
    if ($str =~ /^\((.+?)\)/) {
	$str = $1;
    }
    if ($str =~ /^(.+?)\s+-\s+/) {
	$1;
    } else {
	$str;
    }
}

# Turn "(Berlin - Potsdam)" or "Berlin - Potsdam" into Potsdam (the
# destination) or leave the name unchanged.
sub get_last_part {
    my($str) = @_;
    if ($str =~ /^\((.+?)\)/) {
	$str = $1;
    }
    if ($str =~ /\s+-\s+(.+)/) {
	$1;
    } else {
	$str;
    }
}

# the following schemes are recognized:
#   (B 109)       (anywhere)
#   B 109:        (at beginning)
#   B 109         (whole string)
#   B 109 (...)   (at beginning)
#   F: Radrouten in Potsdam
#   R: Europaradwege
#   ZR: Zubringer zum Radweg
#   RR: Radialrouten (in Berlin)
#   TR: Tangentialrouten (in Berlin)
#   BAB: Bundesautobahn
#   A: Autostrada (in Polen)
#   DK: Droga krajowa (in Polen)
#   DW: Droga wojew�dzka (in Polen)
# In general, parse_street_type_nr returns a list:
#  (Type of street, Number of street, Bool for round sign, optional image)
sub parse_street_type_nr {
    my $strname = shift;
    my($type,$nr) = $strname =~ /\((B|L|BAB|A|DK|DW|F|R|ZR|RR|TR)\s*([\d\.]+)\)/;
    if (!defined $type) {
	($type,$nr) = $strname =~ /^(B|L|BAB|A|DK|DW|F|R|ZR|RR|TR)\s*([\d\.]+)(?::|$|\s*\()/;
	if (!defined $type) { # B101n
	    ($type,$nr) = $strname =~ /\((B|L)\s*(\d+(?:n|neu|a|b))\)/;
	    if (!defined $type) {
		($type,$nr) = $strname =~ /^(B|L)\s*(\d+(?:n|neu|a|b))(?::|$|\s*\()/;
	    }
	}
    }
    ($type, $nr);
}

# Schneidet den Teil in Klammern weg.
# Wird f�r Bezirke, aber auch bei Bahnh�fen (z.B. (U1)) verwendet.
### AutoLoad Sub
sub strip_bezirk {
    my $str = shift;
    if ($str !~ /^\s*\(/) {
	$str =~ s/\s*\(.*\(.*\).*\)\s*$//; # poor solution for parens in parens
	$str =~ s/\s*\([^\)]+\)\s*$//;
    }
    $str;
}

my %city2subparts;
sub strip_bezirk_perfect {
    my($str, $city) = @_;
    if (!exists $city2subparts{$city} && defined $city) {
	my $mod = qq{Geography::} . $city;
	eval qq{ require $mod };
	if ($@) {
	    $Strassen::DEBUG = $Strassen::DEBUG; # peacify -w
	    warn $@ if $Strassen::DEBUG;
	    return strip_bezirk($str);
	}
	$city2subparts{$city} = { map {($_,1)} $mod->get_all_subparts };
    }
    $str =~ s{\((.*?)\)}{
	my $bezirke = $1;
	my @bezirke = grep { !exists $city2subparts{$city}->{$_} }
	              split /,\s*/, $bezirke;
	@bezirke ? "(" . join(", ", @bezirke) . ")" : "";
    }eg;
    $str =~ s/\s+$//;
    $str =~ s/\s+/ /g;
    $str;
}

sub split_street_citypart {
    my $str = shift;
    my @cityparts;
    if ($str =~ m{^\(}) {
	# convention: streets beginning with "(" have no cityparts
    } elsif ($str =~ /^(.*)\s+\(([^\(]+)\)(\s+\[.+\])?$/) {
	no warnings 'uninitialized'; # $3 may be undef
	$str = "$1$3";
	@cityparts = split /\s*,\s*/, $2;
    } elsif ($str =~ /^.*\[.+\]$/) {
	# commas may appear between the [...], and the next regexp would do a split here, which is wrong, so intercept such strings here
    } elsif ($str =~ /^([^(),]+\S),\s+(.{3,})/) { # with some sanity check: street needs at least three characters
	$str = $2;
	@cityparts = $1;
    }
    ($str, @cityparts);
}

sub get_crossing_streets {
    my($main_street, $prev_street, $cross_streets_ref) = @_;
    my @cross_streets = $cross_streets_ref ? @$cross_streets_ref : ();

    @cross_streets = grep { ($_ ne $main_street &&
			     (!defined $prev_street || $_ ne $prev_street)
			    ) 
			} @cross_streets;

    @cross_streets;
}

# extract streetnames from a cross
#
# Garibaldistr/Herzstr -> ("Garibaldistr", "Herzstr")
# College St at Ossington -> ("College St", "Ossington")
#
sub split_crossing {
    my($street) = @_;
    return if !defined $street;

    # international
    if ($street =~ m{[/\\]}) {
	return split m{\s*[/\\]\s*}, $street, 2;
    }

    # american style
    if ($street =~ /\S+\s+at\s+\S+/) {
	return split m{\s+at\s+}, $street, 2;
    }

    # hacker style
    if ($street =~ /\S+\s*\@\s*\S+/) {
	return split m{\s*\@\s*}, $street, 2;
    }

    $street;
}

1;
