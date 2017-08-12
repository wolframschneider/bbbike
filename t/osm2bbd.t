#!/usr/bin/perl -w
# -*- mode:cperl; coding:iso-8859-1 -*-

#
# Author: Slaven Rezic
#

use strict;
use FindBin;
use lib (
	 "$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	);

use File::Temp qw(tempdir tempfile);
use Getopt::Long;
use Test::More 'no_plan';

use BBBikeYAML;
use Strassen::Core;

my $osm2bbd = "$FindBin::RealBin/../miscsrc/osm2bbd";

my $keep;
GetOptions("keep" => \$keep)
    or die "usage: $0 [--keep]\n";

{
    my $destdir = tempdir(CLEANUP => $keep ? 0 : 1);
    if ($keep) {
	diag "1st destination directory is: $destdir";
    }
    my($osmfh,$osmfile) = tempfile(UNLINK => 1, SUFFIX => '_osm2bbd.osm');
    print $osmfh <<'EOF';
<?xml version="1.0" encoding="UTF-8"?>
<osm version="0.6" generator="Overpass API">
<note>The data included in this document is from www.openstreetmap.org. The data is made available under ODbL.</note>
<meta osm_base="2014-03-23T11:14:02Z"/>

  <!-- nodes for Karl-Marx-Allee -->
  <node id="29271394" lat="52.5178395" lon="13.4329187" version="12" timestamp="2012-05-16T22:57:29Z" changeset="11618882" uid="76006" user="Inhiber">
    <tag k="highway" v="traffic_signals"/>
  </node>
  <node id="29271393" lat="52.5174916" lon="13.4364709" version="5" timestamp="2013-05-15T16:31:54Z" changeset="16141106" uid="1439784" user="der-martin"/>

  <!-- nodes for Rudi-Dutschke-Str. -->
  <node id="25663454" lat="52.5067076" lon="13.3905066" version="7" timestamp="2012-07-18T12:30:56Z" changeset="12281912" uid="722137" user="OSMF Redaction Account"/>
  <node id="1814134273" lat="52.5067128" lon="13.3905715" version="2" timestamp="2012-07-05T20:06:34Z" changeset="12124058" uid="125718" user="Fabi2"/>

  <!-- nodes for Wismarplatz -->
  <node id="27459716" lat="52.5114094" lon="13.4630646" version="6" timestamp="2012-09-03T18:56:16Z" changeset="12971697" uid="209498" user="nurinfo"/>
  <node id="29785833" lat="52.5108136" lon="13.4627415" version="5" timestamp="2010-03-07T15:29:56Z" changeset="4061779" uid="115651" user="Konrad Aust"/>

  <!-- nodes for Evangelicky Kristuv kostel -->
  <node id="603020423" visible="true" version="1" changeset="3517189" timestamp="2010-01-02T11:04:47Z" user="Datin" uid="115815" lat="49.8392106" lon="18.2869317"/>
  <node id="603020424" visible="true" version="1" changeset="3517189" timestamp="2010-01-02T11:04:47Z" user="Datin" uid="115815" lat="49.8392232" lon="18.2869912"/>

  <!-- way with cycleway and oneway -->
  <way id="76865761" version="4" timestamp="2013-09-26T03:46:24Z" changeset="18038475" uid="1439784" user="der-martin">
    <nd ref="29271394"/>
    <nd ref="29271393"/>
    <tag k="cycleway" v="track"/>
    <tag k="highway" v="primary"/>
    <tag k="name" v="Karl-Marx-Allee"/>
    <tag k="oneway" v="yes"/>
    <tag k="postal_code" v="10243"/>
    <tag k="ref" v="B 1;B 5"/>
  </way>

 <!-- way with cycleway:left -->
 <way id="4396302" version="15" timestamp="2012-12-02T20:26:29Z" changeset="14130596" uid="111462" user="Posemuckel">
    <nd ref="25663454"/>
    <nd ref="1814134273"/>
    <tag k="cycleway:left" v="share_busway"/>
    <tag k="highway" v="secondary"/>
    <tag k="name" v="Rudi-Dutschke-Straße"/>
    <tag k="postal_code" v="10969"/>
  </way>

 <!-- way with oneway:bicycle -->
 <way id="4685868" version="11" timestamp="2014-03-24T12:15:47Z" changeset="21283624" uid="884156" user="DieBuche">
   <nd ref="27459716"/>
   <nd ref="29785833"/>
   <tag k="highway" v="residential"/>
   <tag k="maxspeed" v="30"/>
   <tag k="name" v="Wismarplatz"/>
   <tag k="oneway" v="yes"/>
   <tag k="oneway:bicycle" v="no"/>
   <tag k="postal_code" v="10245"/>
   <tag k="surface" v="cobblestone"/>
 </way>

 <!-- embedded newlines -->
 <way id="47356195" visible="true" version="5" changeset="25521525" timestamp="2014-09-18T14:24:09Z" user="Vladimir Domes" uid="1595880">
  <nd ref="603020423"/>
  <nd ref="603020424"/>
  <tag k="amenity" v="place_of_worship"/>
  <tag k="building" v="church"/>
  <tag k="building:height" v="60"/>
  <tag k="denomination" v="evangelical"/>
  <tag k="name" v="Evangelicky Kristuv kostel"/>
  <tag k="religion" v="christian"/>
  <tag k="start_date" v="1907"/>
  <tag k="wikipedia" v="cs: Evangelicky Kristuv kostel&#10;(Ostrava)"/>
 </way>

</osm>
EOF
    close $osmfh;

    my @cmd = ($^X, $osm2bbd, "--debug=0", "-f", "-o", $destdir, $osmfile);
    system @cmd;
    is $?, 0, "<@cmd> works";

    my $meta = BBBikeYAML::LoadFile("$destdir/meta.yml");
    is $meta->{source}, 'osm';
    like $meta->{created}, qr{^2\d{7}\d{6}}, 'looks like an ISO date';
    is $meta->{coordsys}, 'wgs84';
    like "@{ $meta->{commandline} }", qr{osm2bbd};

    {
	my $strassen = Strassen->new("$destdir/strassen");
	ok $strassen, 'strassen could be loaded';
	is $strassen->data->[0], "Karl-Marx-Allee (B 1;B 5)\tHH 13.4329187,52.5178395 13.4364709,52.5174916\n";
	is $strassen->data->[1], "Rudi-Dutschke-Stra�e\tH 13.3905066,52.5067076 13.3905715,52.5067128\n";
	is $strassen->data->[2], "Wismarplatz\tN 13.4630646,52.5114094 13.4627415,52.5108136\n";
    }

    {
	my $radwege = Strassen->new("$destdir/radwege");
	ok $radwege, 'radwege could be loaded';
	is $radwege->data->[0], "Karl-Marx-Allee (B 1;B 5)\tRW1; 13.4329187,52.5178395 13.4364709,52.5174916\n";
	is $radwege->data->[1], "Rudi-Dutschke-Stra�e\t;RW5 13.3905066,52.5067076 13.3905715,52.5067128\n";
    }

    {
	my $ampeln = Strassen->new("$destdir/ampeln");
	ok $ampeln, 'ampeln could be loaded';
	is $ampeln->data->[0], "\tX 13.4329187,52.5178395\n";
    }

    {
	my $gesperrt = Strassen->new("$destdir/gesperrt");
	ok $gesperrt, 'gesperrt could be loaded';
	is $gesperrt->data->[0], "Karl-Marx-Allee (B 1;B 5)\t1 13.4364709,52.5174916 13.4329187,52.5178395\n";
    }

    {
	my $gesperrt_car = Strassen->new("$destdir/gesperrt_car");
	ok $gesperrt_car, 'oneway:bicycle=no goes to gesperrt_car';
	is $gesperrt_car->data->[0], "Wismarplatz\t1 13.4627415,52.5108136 13.4630646,52.5114094\n";
    }

    {
	my $qualitaet_s = Strassen->new("$destdir/qualitaet_s");
	ok $qualitaet_s, 'cobblestone to quality file';
	is $qualitaet_s->data->[0], "Wismarplatz: Kopfsteinpflaster\tQ2 13.4630646,52.5114094 13.4627415,52.5108136\n";
    }

    {
	my $sights = Strassen->new_stream("$destdir/sehenswuerdigkeit", UseLocalDirectives => 1);
	ok $sights, 'constructed sights file';
	my $found_url;
	my $record_number = 0;
	$sights->read_stream
	    (sub {
		 my($r, $dir) = @_;
		 if ($record_number == 0) {
		     $found_url = $dir->{url}->[0];
		 }
		 $record_number++;
	     });
	is $found_url, 'http://en.wikipedia.org/wiki/cs: Evangelicky Kristuv kostel (Ostrava)', 'url in sights file';
    }
}

# Following is actually checking two things:
# - handling gzipped osm files
# - the polar_coord_hack experiment, together with checking the generated Karte/Polar.pm file
SKIP: {
    skip "Need IO::Zlib for testing .osm.gz files", 1
	if !eval { require IO::Zlib; 1 };

    my $destdir = tempdir(CLEANUP => $keep ? 0 : 1);
    if ($keep) {
	diag "2nd destination directory is: $destdir";
    }

    my(undef,$osm_gzip_file) = tempfile(UNLINK => 1, SUFFIX => ".osm2bbd.t.osm.gz");
    my $fh = IO::Zlib->new($osm_gzip_file, "wb9")
	or die "Can't create gzipped file: $!";
    print $fh <<'EOF';
<?xml version='1.0' encoding='UTF-8'?>
<osm version="0.6" generator="osmconvert 0.8.4" timestamp="2017-08-07T01:59:59Z">
        <bounds minlat="53.246" minlon="11.085" maxlat="53.83" maxlon="11.964"/>
        <node id="5072583" lat="53.8246271" lon="11.3533807" version="1"/>
        <node id="5072743" lat="53.8206992" lon="11.325464" version="1"/>
        <way id="4040433" version="1">
                <nd ref="5072583"/>
                <nd ref="5072743"/>
		<tag k="highway" v="residential"/>
		<tag k="name" v="Teststreet"/>
	</way>
</osm>
EOF
    close $fh
	or die $!;

    my @cmd = ($^X, $osm2bbd, "--debug=0", "--experiment=polar_coord_hack", "-f", "-o", $destdir, $osm_gzip_file);
    system @cmd;
    is $?, 0, "<@cmd> works";

    {
	my $strassen = Strassen->new("$destdir/strassen");
	ok $strassen, 'strassen could be loaded';
	is $strassen->data->[0], "Teststreet\tN 11.3533807,53.8246271 11.325464,53.8206992\n";
    }

    ok -f "$destdir/Karte/Polar.pm", 'Karte::Polar was created';

 SKIP: {
	skip 'Requires IPC::Run for Karte::Polar test', 1
	    if !eval { require IPC::Run; 1 };
	my @polar_cmd = ($^X, "-I$destdir", "-MKarte::Polar", "-MKarte::Standard", "-MKarte", "-e", 'Karte::preload(":all"); print join(",", $Karte::map{"polar"}->trim_accuracy($Karte::map{"polar"}->standard2map(0,0))), "\n"');
	my $succ = IPC::Run::run(\@polar_cmd, '>', \my $got, '2>', \my $stderr);
	ok $succ, "Running <@polar_cmd> was successful";
	is $got, "13.651456,52.403097\n", "expected translation for 0,0 (trimmed)";
	is $stderr, "Using corrected Karte::Polar for latitude 53.538...\n", "expected diagnostics"; # may be removed some day?
    }
}


__END__
