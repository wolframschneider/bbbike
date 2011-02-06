#!/usr/bin/perl -w
# -*- perl -*-

# Author: Slaven Rezic
#
# Copyright (C) 2005,2006,2007,2008 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: eserte@users.sourceforge.net
# WWW:  http://bbbike.sourceforge.net
#

package BBBikeGooglemap;

use strict;
use FindBin;
use lib (
    grep { -d } (
        "$FindBin::RealBin/..",
        "$FindBin::RealBin/../lib",

        # für Radzeit:
        "$FindBin::RealBin/../BBBike",
        "$FindBin::RealBin/../BBBike/lib",
    )
);
use CGI qw(:standard);
use CGI::Carp;
use File::Basename qw(dirname);
use URI;
use BBBikeCGIUtil qw();
use BBBikeVar;
use Karte;
use Karte::Polar;
use Encode;

sub new { bless {}, shift }

my $force_utf8 = 1;

sub run {

    #my ($self, $q, $gmap_api_version, $lang, $fullscreen) = @_;
    my $self = shift;
    my %args = @_;

    my $q                = $args{'q'};
    my $gmap_api_version = $args{'gmap_api_version'};
    my $lang             = $args{'lang'};
    my $fullscreen       = $args{'fullscreen'};

    my $city = $q->param('city') || "";
    if ($city) {
        $ENV{DATA_DIR} = $ENV{BBBIKE_DATADIR} = "data-osm/$city";
    }
    $self->{gmap_api_version} = $gmap_api_version;

    local $CGI::POST_MAX = 2_000_000;

    my @polylines_polar;
    my @polylines_route;
    my @polylines_polar_feeble;
    my @wpt;

    my $coordsystem = param("coordsystem") || "wgs84";
    my $converter;
    if ( $coordsystem =~ m{^(wgs84|polar)$} ) {
        $converter = \&polar_converter;
        $coordsystem = 'polar';    # normalize XXX should be wgs84 some day?
    }
    else {                         # bbbike or standard
        $converter = \&bbbike_converter;
    }

    my $filename = param("gpxfile");

    for my $def (
        [ 'coords', \@polylines_route ],

        #[ 'city_center', \@polylines_polar ],
        [ 'area', \@polylines_polar ],

        #[ 'oldcoords',   \@polylines_polar_feeble ],
      )
    {
        my ( $cgiparam, $polylines_ref ) = @$def;

        for my $coords ( $q->param($cgiparam) ) {
            my (@coords) = split /[!;]/, $coords;
            my (@coords_polar) = map {
                my ( $x, $y ) = split /,/, $_;
                join ",", $converter->( $x, $y );
            } @coords;
            push @$polylines_ref, \@coords_polar;
        }
    }

    # center defaults to Berlin
    if ( scalar(@polylines_polar) == 0 ) {
        push @polylines_polar, ["13.376431,52.516172"];
    }

    for my $wpt ( $q->param("wpt") ) {
        my ( $name, $coord );
        if ( $wpt =~ /[!;]/ ) {
            ( $name, $coord ) = split /[!;]/, $wpt;
        }
        else {
            $name  = "";
            $coord = $wpt;
        }
        my ( $x, $y ) = split /,/, $coord;
        ( $x, $y ) = $converter->( $x, $y );
        push @wpt, [ $x, $y, $name ];
    }

    my $zoom = $q->param("zoom");
    $zoom = 3 if !defined $zoom;

    my $autosel = $q->param("autosel") || "";
    $self->{autosel} = $autosel && $autosel ne 'false' ? "true" : "false";

    my $maptype = $q->param("maptype") || "";
    $self->{maptype} = (
          $maptype =~ /hybrid/i    ? 'G_HYBRID_MAP'
        : $maptype =~ /normal/i    ? 'G_NORMAL_MAP'
        : $maptype =~ /^satelite/i ? 'G_SATELLITE_MAP'
        : $maptype =~ /^physical/i ? 'G_PHYSICAL_MAP'
        : $maptype =~ /^cycle$/    ? 'cycle_map'
        : $maptype =~ /^mapnik$/   ? 'mapnik_map'
        : $maptype =~ /^tah$/      ? 'tah_map'
        : 'cycle_map'
    );

    my $mapmode = $q->param("mapmode") || "";
    ( $self->{initial_mapmode} ) =
      $mapmode =~ m{^(search|addroute|browse|addwpt)$};
    $self->{initial_mapmode} ||= "";

    my $center = $q->param("center") || "";

    $self->{converter}   = $converter;
    $self->{coordsystem} = $coordsystem;

    #print header ( "-type" => "text/html; charset=utf-8" );

    binmode( \*STDOUT, ":utf8" ) if $force_utf8;
    binmode( \*STDERR, ":utf8" ) if $force_utf8;

    print $self->get_html( \@polylines_polar, \@polylines_route, \@wpt, $zoom,
        $center, $q, $lang, $fullscreen );
}

sub bbbike_converter {
    my ( $x, $y ) = @_;
    local $^W;    # avoid non-numeric warnings...
    $Karte::Polar::obj->standard2map( $x, $y );
}

sub polar_converter { @_[ 0, 1 ] }

sub get_html {
    my (
        $self,   $paths_polar, $paths_route, $wpts, $zoom,
        $center, $q,           $lang,        $fullscreen
    ) = @_;

    my $converter   = $self->{converter};
    my $coordsystem = $self->{coordsystem};

    use Data::Dumper;
    my $coords = $$paths_polar[0];
    my $route  = $$paths_route[0];

    my $marker_list = '[';
    foreach my $c ( @{$coords} ) {
        next if $c !~ /,/;

        my ( $y, $x ) = split( /,/, $c );
        $marker_list .= qq/[$x,$y],/;
    }
    $marker_list =~ s/,\s*$/]/;

    my $route_list = '';
    foreach my $c ( @{$route} ) {
        next if $c !~ /,/;

        my ( $y, $x ) = split( /,/, $c );
        $route_list .= qq/[$x,$y], /;
    }
    $route_list =~ s/,\s*$//;

    #warn Dumper($marker_list);

    my ( $centerx, $centery );
    if ($center) {
        ( $centerx, $centery ) = map { sprintf "%.5f", $_ } split /,/, $center;
    }
    elsif ( $paths_polar && @$paths_polar ) {
        ( $centerx, $centery ) = map { sprintf "%.5f", $_ } split /,/,
          $paths_polar->[0][0];
    }
    elsif ( $wpts && @$wpts ) {
        ( $centerx, $centery ) = map { sprintf "%.5f", $_ } $wpts->[0][0],
          $wpts->[0][1];
    }
    else {
        require Geography::Berlin_DE;
        ( $centerx, $centery ) =
          $converter->( split /,/, Geography::Berlin_DE->center() );
    }

    my %google_api_keys = (
        'bbbike.dyndns.org' =>
"ABQIAAAAidl4U46XIm-bi0ECbPGe5hSLqR5A2UGypn5BXWnifa_ooUsHQRSCfjJjmO9rJsmHNGaXSFEFrCsW4A",

        '78.47.225.30' =>
"ABQIAAAACNG-XP3VVgdpYda6EwQUyhTTdIcL8tflEzX084lXqj663ODsaRSCKugGasYn0ZdJkWoEtD-oJeRhNw",
        'bbbike.de' =>
'ABQIAAAACNG-XP3VVgdpYda6EwQUyhRfQt6AwvKXAVZ7ZsvglWYeC-xX5BROlXoba_KenDFQUtSEB_RJPUVetw',
        'bbbike.org' =>
'ABQIAAAAX99Vmq6XHlL56h0rQy6IShRC_6-KTdKUFGO0FTIV9HYn6k4jEBS45YeLakLQU48-9GshjYiSza7RMg',
        'www.bbbike.org' =>
'ABQIAAAAX99Vmq6XHlL56h0rQy6IShRC_6-KTdKUFGO0FTIV9HYn6k4jEBS45YeLakLQU48-9GshjYiSza7RMg',
        'dev.bbbike.org' =>
'ABQIAAAAX99Vmq6XHlL56h0rQy6IShQGl2ahQNKygvI--_E2nchLqmbBhxRLXr4pQqVNorfON2MgRTxoThX1iw',
        'devel.bbbike.org' =>
'ABQIAAAAX99Vmq6XHlL56h0rQy6IShSz9Y_XkjB4bplja172uJiTycvaMBQbZCQc60GoFTYOa5aTUrzyHP-dVQ',
        'localhost' =>
'ABQIAAAAX99Vmq6XHlL56h0rQy6IShT2yXp_ZAY8_ufC3CFXhHIE1NvwkxTN4WPiGfl2FX2PYZt6wyT5v7xqcg',
    );

    my $full = URI->new( BBBikeCGIUtil::my_url( CGI->new($q), -full => 1 ) );
    my $fallback_host = "bbbike.de";
    my $host = eval { $full->host } || $fallback_host;

    # warn "Google maps API: host: $host, full: $full\n";

    my $google_api_key = $google_api_keys{$host}
      || $google_api_keys{$fallback_host};
    my $cgi_reldir = dirname( $full->path );
    my $is_beta = $full =~ m{bbikegooglemap2.cgi};

    my $bbbikeroot      = "/BBBike";
    my $get_public_link = sub {
        BBBikeCGIUtil::my_url( CGI->new($q), -full => 1 );
    };
    if ( $host eq 'bbbike.dyndns.org' ) {
        $bbbikeroot = "/bbbike";
    }
    elsif ( $host =~ m{srand\.de} ) {
        $bbbikeroot = dirname( dirname( $full->path ) );
    }
    elsif ( $host eq 'localhost' ) {
        $bbbikeroot      = "/bbbike";
        $get_public_link = sub {
            my $link = BBBikeCGIUtil::my_url( CGI->new($q), -full => 1 );
            $link =~ s{localhost$bbbikeroot/cgi}{bbbike.de/cgi-bin};
            $link;
        };
    }

    my $script;
    my $slippymap_size = "";

    if ( $q->user_agent("XXXiPhone") ) {

        #$slippymap_size = qq{ style="width:240px; height:240px; "};
        $slippymap_size = qq{ style="display:none"};
    }

    my $city = $q->param('city') || "";
    my $gmap_api_version = $self->{gmap_api_version};

    $lang = "en" if !$lang;

    my $startname    = Encode::decode( utf8 => $q->param('startname') );
    my $zielname     = Encode::decode( utf8 => $q->param('zielname') );
    my $driving_time = Encode::decode( utf8 => $q->param('driving_time') );
    my $route_length = Encode::decode( utf8 => $q->param('route_length') );

    my $html;

    if ($fullscreen) {
        $html = <<EOF;
<style type="text/css">
div#BBBikeGooglemap { 
	width: 90%; 
	height: 80%; 
	margin-left: 5%; 
	margin-right: 5%; 
	padding: 0em; 
        top: 0em; 
}
</style>
EOF
    }

    $html .= <<EOF;
<!-- BBBikeGooglemap starts here -->
<div id="chart_div" onmouseout="clearMouseMarker()" style="display:none"></div>
<div id="BBBikeGooglemap" $slippymap_size>
EOF

    $html .=
qq{<script type="text/javascript"> google.load("maps", $gmap_api_version); </script>\n}
      if $gmap_api_version == 2;

    $html .= <<EOF;

    <div id="map"></div>

    <div id="nomap_script">
    <script type="text/javascript">
    //<![CDATA[

    var marker_list = [ $route_list ];

    city = "$city";
    bbbike_maps_init("default", $marker_list, "$lang" );

EOF

    if ( $route_length ne '' ) {

        $html .= <<EOF;
    elevation_initialize(map, {"driving_time":"$driving_time", "area":$marker_list, "lang":"$lang", "route_length":"$route_length", 
				"city":"$city", "startname":"$startname", "zielname": "$zielname", 
				"maptype":"cycle"
				});
EOF
    }

    $html .= <<EOF;
   
    //]]>
    </script>
    <noscript>
        <p>You must enable JavaScript and CSS to run this application!</p>
    </noscript>
</div> <!-- nomaps -->
</div> <!-- BBBikeGooglemap -->
<!-- BBBikeGooglemap ends here -->
EOF

    $html;
}

#my $o = BBBikeGooglemap->new;
#$o->run(new CGI);

1;

