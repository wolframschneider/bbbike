#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: strasse.t,v 1.10 2005/11/20 17:36:52 eserte Exp $
# Author: Slaven Rezic
#

use strict;

use FindBin;
use lib ("$FindBin::RealBin/..", "$FindBin::RealBin/../data", "$FindBin::RealBin/../lib");
use Strassen::Strasse;

BEGIN {
    if (!eval q{
	use Test::More;
	1;
    }) {
	print "1..0 # skip: no Test::More module\n";
	exit;
    }
}

my @split_street_citypart =
    (["Heerstr. (Spandau, Charlottenburg)" =>
      ["Heerstr.", "Spandau", "Charlottenburg"]],
     ["Heerstr. (Spandau)" =>
      ["Heerstr.", "Spandau"]],
     ["Heerstr." =>
      ["Heerstr."]],
     ["Potsdam, Schopenhauerstr." =>
      ["Schopenhauerstr.", "Potsdam"]],
    );

my @beautify_landstrasse =
    (["Dudenstr." => "Dudenstr."],
     ["Heerstr. (Spandau)" => "Heerstr. (Spandau)"],
     ["Karl-Kunger-Str." => "Karl-Kunger-Str."],
     ["Karl-Kunger-Str. (Treptow)" => "Karl-Kunger-Str. (Treptow)"],
     ["B1: Berlin - Potsdam" =>
      "B1: (Berlin -) Potsdam", "B1: (Potsdam -) Berlin"],
     ["Am Neuen Palais (F2.2)" =>
      "Am Neuen Palais (F2.2)"],
     ["F2.2: Geltow - Wildpark West" =>
      "F2.2: (Geltow -) Wildpark West", "F2.2: (Wildpark West -) Geltow"],
     ["F2.2: Werderscher Damm (Wildpark West - Kuhfort)" => 
      "F2.2: Werderscher Damm ((Wildpark West -) Kuhfort)",
      "F2.2: Werderscher Damm ((Kuhfort -) Wildpark West)"],
     ["B179: Berlin - M�rkisch-Buchholz" =>
      "B179: (Berlin -) M�rkisch-Buchholz", "B179: (M�rkisch-Buchholz -) Berlin"],
     ["M�ncheberg - Pr�tzel (B168)" =>
      "(M�ncheberg -) Pr�tzel (B168)", "(Pr�tzel -) M�ncheberg (B168)"],
     ["Ferch - Geltow (F1)" =>
      "(Ferch -) Geltow (F1)", "(Geltow -) Ferch (F1)"],
     ["Geltow - F�hre (Caputher Chaussee) (F1)" =>
      "(Geltow -) F�hre (Caputher Chaussee) (F1)", "(F�hre -) Geltow (Caputher Chaussee) (F1)"],
     ["Werderscher Damm (Wildpark West - Kuhfort)" =>
      "Werderscher Damm ((Wildpark West -) Kuhfort)", "Werderscher Damm ((Kuhfort -) Wildpark West)"],
     ["Sybelstr. Ost - Lewishamstr.: Verbindung?" =>
      "(Sybelstr. Ost -) Lewishamstr.: Verbindung?", "(Lewishamstr. -) Sybelstr. Ost: Verbindung?"],
     ["Berlin - Altlandsberg - Strausberg" =>
      "(Berlin - Altlandsberg -) Strausberg", "(Strausberg - Altlandsberg -) Berlin"],
     ["B112: Manschnow - Lebus - Frankfurt" =>
      "B112: (Manschnow - Lebus -) Frankfurt", "B112: (Frankfurt - Lebus -) Manschnow"],
     ["B104 - Milow - Sch�nwerder - B198" =>
      "(B104 - Milow - Sch�nwerder -) B198", "(B198 - Sch�nwerder - Milow -) B104"],
     ["Alt-Golm - Saarow" =>
      "(Alt-Golm -) Saarow", "(Saarow -) Alt-Golm"],
     ["(M�llendorffstr. - Karl-Lade-Str.)" =>
      "((M�llendorffstr. -) Karl-Lade-Str.)",
      "((Karl-Lade-Str. -) M�llendorffstr.)"],
     ["Tiergarten (Hardenbergplatz - S-Bhf. Tiergarten)" =>
      "Tiergarten ((Hardenbergplatz -) S-Bhf. Tiergarten)",
      "Tiergarten ((S-Bhf. Tiergarten -) Hardenbergplatz)",
     ],
     ["(M�llendorffstr. - Karl-Lade-Str., Extra-Kommentar)" =>
      "((M�llendorffstr. -) Karl-Lade-Str., Extra-Kommentar)",
      "((Karl-Lade-Str. -) M�llendorffstr., Extra-Kommentar)"],
     ["M�llendorffstr. - Karl-Lade-Str., Extra-Kommentar" =>
      "(M�llendorffstr. -) Karl-Lade-Str., Extra-Kommentar",
      "(Karl-Lade-Str. -) M�llendorffstr., Extra-Kommentar"],
    );

if ($] >= 5.008) {
    eval q{
push @beautify_landstrasse,
     ["B104 - Milow - Sch�nwerder - B198" =>
      "(B104 \x{2192} Milow \x{2192} Sch�nwerder \x{2192}) B198",
      "(B198 \x{2192} Sch�nwerder \x{2192} Milow \x{2192}) B104", undef, "can_unicode"],
;
};
    die $@ if $@;
}

my $strip_bezirk_tests = 6;
plan tests => scalar(@split_street_citypart) + scalar(@beautify_landstrasse)*2 + $strip_bezirk_tests;

for my $s (@split_street_citypart) {
    my($str, @expected) = ($s->[0], @{ $s->[1] });
    my(@res) = Strasse::split_street_citypart($str);
    is(join("#", @res), join("#", @expected), "Split $str");
}

for my $s (@beautify_landstrasse) {
    my($str, $expected_forward, $expected_backward, $todo, $can_unicode) = @$s;
    if (!defined $expected_backward) {
	$expected_backward = $expected_forward;
    }
    local $TODO = $todo;
    is(Strasse::beautify_landstrasse($str, 0, -unicode => $can_unicode),
       $expected_forward, "$str forward" . ($can_unicode ? " with unicode" : ""));
    is(Strasse::beautify_landstrasse($str, 1, -unicode => $can_unicode),
       $expected_backward, "$str backward" . ($can_unicode ? " with unicode" : ""));
}

my $city = "Berlin_DE";
is(Strasse::strip_bezirk("Dudenstr. (Kreuzberg, Tempelhof)"),
   "Dudenstr.",
   "strip_bezirk simple");
is(Strasse::strip_bezirk_perfect("Dudenstr. (Kreuzberg, Tempelhof)", $city),
   "Dudenstr.",
   "strip_bezirk_perfect simple");
is(Strasse::strip_bezirk("Dudenstr. (foobar) (Kreuzberg, Tempelhof)"),
   "Dudenstr. (foobar)",
   "only last component is stripped");
is(Strasse::strip_bezirk_perfect("Dudenstr. (foobar) (Kreuzberg, Tempelhof)", $city),
   "Dudenstr. (foobar)",
   "only bezirke are stripped");
is(Strasse::strip_bezirk("Dudenstr. (foobar)"), "Dudenstr.",
   "non-bezirk incorrectly stripped");
is(Strasse::strip_bezirk_perfect("Dudenstr. (foobar)", $city),
   "Dudenstr. (foobar)",
   "non-bezirk not stripped");

__END__
