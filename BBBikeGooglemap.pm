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
    my ($self, $q) = @_;

    my $city = $q->param('city') || "";
    if ($city) {
        $ENV{DATA_DIR} = $ENV{BBBIKE_DATADIR} = "data-osm/$city";
    }

    local $CGI::POST_MAX = 2_000_000;

    my @polylines_polar;
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

    if ( param("wpt_or_trk") ) {
        my $wpt_or_trk = trim( param("wpt_or_trk") );
        if ( $wpt_or_trk =~ / / ) {
            param( "coords",
                join( "!", param("coords"), split( / /, $wpt_or_trk ) ) );
        }
        else {
            param( "wpt", $wpt_or_trk );
        }
    }

    my $filename = param("gpxfile");
    if ( defined $filename ) {
        ( my $ext = $filename ) =~ s{^.*\.}{.};
        require Strassen::Core;
        require File::Temp;
        my $fh = upload("gpxfile");
        if ( !$fh ) {
            $self->{errormessageupload} = "Upload-Datei fehlt!";
        }
        else {
            my ( $tmpfh, $tmpfile ) = File::Temp::tempfile(
                UNLINK => 1,
                SUFFIX => $ext
            );
            while (<$fh>) {
                print $tmpfh $_;
            }
            close $fh;
            close $tmpfh;

            my $gpx = Strassen->new( $tmpfile, name => "Uploaded GPX file" );
            $gpx->init;
            while (1) {
                my $r = $gpx->next;
                if (   !$r
                    || !UNIVERSAL::isa( $r->[ Strassen::COORDS() ], "ARRAY" ) )
                {
                    warn "Parse error in line " . $gpx->pos . ", skipping...";
                    next;
                }
                last if !@{ $r->[ Strassen::COORDS() ] };
                if ( @{ $r->[ Strassen::COORDS() ] } == 1 )
                {    # treat as waypoint
                        # XXX hack --- should append recognise self_or_default?
                    $CGI::Q->append(
                        -name   => 'wpt',
                        -values => $r->[ Strassen::NAME() ] . "!"
                          . $r->[ Strassen::COORDS() ][0]
                    );
                }
                else {

                    # XXX hack --- should append recognise self_or_default?
                    $CGI::Q->append(
                        -name => 'coords',
                        -values =>
                          [ join "!", @{ $r->[ Strassen::COORDS() ] } ],
                    );
                }
            }
        }
    }

    for my $def (
        [ 'coords',      \@polylines_polar ],
        [ 'city_center', \@polylines_polar ],
        [ 'area',        \@polylines_polar ],
        [ 'oldcoords',   \@polylines_polar_feeble ],
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

    print $self->get_html( \@polylines_polar, \@polylines_polar_feeble, \@wpt,
        $zoom, $center, $q );
}

sub bbbike_converter {
    my ( $x, $y ) = @_;
    local $^W;    # avoid non-numeric warnings...
    $Karte::Polar::obj->standard2map( $x, $y );
}

sub polar_converter { @_[ 0, 1 ] }

sub get_html {
    my ( $self, $paths_polar, $feeble_paths_polar, $wpts, $zoom, $center, $q ) = @_;

    my $converter   = $self->{converter};
    my $coordsystem = $self->{coordsystem};

    use Data::Dumper;
    my $coords = $$paths_polar[0];

    my $marker_list = '[';
    foreach my $c ( @{$coords} ) {
        next if $c !~ /,/;

        my ( $y, $x ) = split( /,/, $c );
        $marker_list .= qq/[$x,$y],/;
    }
    $marker_list =~ s/,\s*$/]/;

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
    my $maponly        = "";
    my $slippymap_size = qq{width: 100%; height: 75%;};
    {
        #my $q = new CGI;
        $script = $q->param('source_script') || 'bbbike.cgi';
        $maponly =
qq|div#nomap \t{ display: none }\n\thtml, body \t{ margin: 0; padding: 0; }\n|
          if !$q->param("map_menu");
        $slippymap_size = qq{ width: 100%; height: 100%; max-width: 800px;}
          if !$q->param("map_menu");
    }

    my $html = <<EOF;
<!-- BBBikeGooglemap starts here -->
<div id="BBBikeGooglemap" style="width:680x; height:420px;">

    <script src="http://maps.google.com/jsapi?key=$google_api_key" type="text/javascript"></script>
    <script type="text/javascript">
      google.load("maps", "2");
    </script>
    <script src="../html/sprintf.js" type="text/javascript"></script>
    <script src="../html/bbbike_util.js" type="text/javascript"></script>
    <style type="text/css">
        .sml          { font-size:x-small; }
	.rght	      { text-align:right; }
	#permalink    { color:red; }
	#addroutelink { color:blue; }
	.boxed	      { border:1px solid black; padding:3px; }
	#commentlink  { background-color:yellow; }
	body.nonWaitMode * { }
	body.waitMode *    { cursor:wait; }
        $maponly
    </style>
  </head>

    <div id="map" style="$slippymap_size"></div>
    <div id="nomap">
    <script type="text/javascript">
    //<![CDATA[

    var routeLinkLabel = "Link to route: ";
    var routeLabel = "Route: ";
    var commonSearchParams = "&pref_seen=1&pref_speed=20&pref_cat=&pref_quality=&pref_green=&scope=;output_as=xml;referer=bbbikegooglemap";
    var routePostParam = "";

    var addRoute = [];
    var undoRoute = [];
    var addRouteOverlay;
    var addRouteOverlay2;

    var userWpts = [];

    var searchStage = 0;

    var isGecko = navigator && navigator.product == "Gecko" ? true : false;
    var dragCursor = isGecko ? '-moz-grab' : 'url("../images/moz_grab.gif"), auto';

    var startIcon = new GIcon(G_DEFAULT_ICON, "../images/flag2_bl_centered.png");
    startIcon.iconAnchor = new GPoint(16,16);
    startIcon.iconSize = new GSize(32,32);
    var goalIcon = new GIcon(G_DEFAULT_ICON, "../images/flag_ziel_centered.png");
    goalIcon.iconAnchor = new GPoint(16,16);
    goalIcon.iconSize = new GSize(32,32);
    var currentPointMarker = null;
    var currentTempBlockingMarkers = [];

    var marker_list = $marker_list;

    function createMarker(point, html_name) {
	var marker = new GMarker(point);
        var html = "<b>" + html_name + "</b>";
	GEvent.addListener(marker, "click", function() {
	    marker.openInfoWindowHtml(html);
	});
	return marker;
    }

    function removeTempBlockingMarkers() {
	for(var i = 0; i < currentTempBlockingMarkers.length; i++) {
	    map.removeOverlay(currentTempBlockingMarkers[i]);
	}
	currentTempBlockingMarkers = [];
    }

    function setwpt(x,y) {
        map.panTo(new GLatLng(y, x));
    }

    function setwptAndMark(x,y) {
	var pt = new GLatLng(y, x);
	map.panTo(pt);
	if (currentPointMarker) {
	    map.removeOverlay(currentPointMarker);
	}
	currentPointMarker = new GMarker(pt);
	map.addOverlay(currentPointMarker);
    }
    
    function showCoords(point, message) {
        var latLngStr = message + formatPoint(point);
        document.getElementById("message").innerHTML = latLngStr;
    }

    function formatPoint(point) {
	var s = sprintf("%.6f,%.6f", point.x, point.y);
	return s;
    }

    function getCurrentMode() {
	var rb = document.forms["mapmode"].elements["mapmode"];
	for (var i = 0; i < rb.length; i++) {
	    if (rb[i].checked) {
		return rb[i].value;
	    }
	}
	return "browse"; // fallback
    }

    function currentModeChange() {
        var currentMode = getCurrentMode();
	var dragObj = map.getDragObject();
        if (currentMode == "search") {
	    if (searchStage == 0) {
		dragObj.setDraggableCursor('url("../images/start_ptr.png"), url("../images/flag2_bl.png"), ' + dragCursor);
	    } else {
		dragObj.setDraggableCursor('url("../images/ziel_ptr.png"), url("../images/flag_ziel.png"), ' + dragCursor);
	    }
        } else {
	    if (currentMode == "addroute" || currentMode == "addwpt") {
		dragObj.setDraggableCursor("default");
	    } else {
	        dragObj.setDraggableCursor(dragCursor);
	    }
	    document.getElementById("wpt").innerHTML = "";
        }
    }

    function addCoordsToRoute(point) {
	var currentMode = getCurrentMode();
	if (currentMode != "addroute") {
	    return;
	}
	if (addRoute.length > 0) {
	    var lastPoint = addRoute[addRoute.length-1];
	    if (lastPoint.x == point.x && lastPoint.y == point.y)
		return;
	}
	addRoute[addRoute.length] = point;
	updateRoute();
    }

    function deleteLastPoint() {
	if (addRoute.length > 0) {
	    addRoute.length = addRoute.length-1;
	    updateRoute(); 
	}
    }

    function resetRoute() {
	undoRoute = addRoute;
	addRoute = [];
	updateRoute();
	removeTempBlockingMarkers();
    }

    function doUndoRoute() {
	addRoute = undoRoute;
	undoRoute = [];
	updateRoute();
	removeTempBlockingMarkers();
    }

    function resetOrUndoRoute() {
        if (addRoute.length == 0 && undoRoute.length != 0) {
	    doUndoRoute();
	} else {
	    resetRoute();
	}
    }

    function setDeleteRouteLabel() {
	var routeDelLink = document.getElementById("routedellink");
	if (addRoute.length == 0 && undoRoute.length != 0) {
	    routeDelLink.innerHTML = "Route wiederherstellen";
	} else {
	    routeDelLink.innerHTML = "Route l&ouml;schen"; // see also HTML label!
	}
    }

    function updateRoute() {
	updateRouteDiv(); 
	updateRouteOverlay();
	if ($self->{autosel}) {
	    updateRouteSel();
	}
	setDeleteRouteLabel();
    }

    function updateRouteDiv() {
	var addRouteText = "";
	var addRouteLink = "";
	routePostParam = "";
	for(var i = 0; i < addRoute.length; i++) {
	    if (i == 0) {
		addRouteText = routeLabel;
		addRouteLink = routeLinkLabel + "@{[ $get_public_link->() ]}?zoom=" + map.getZoom() + "&coordsystem=polar" + "&maptype=" + mapTypeToString() + "&wpt_or_trk=";
	    } else if (i > 0) {
		addRouteText += " ";
		addRouteLink += "+";
		routePostParam += " ";
	    }
	    var formattedPoint = formatPoint(addRoute[i]);
	    addRouteText += formattedPoint;
	    addRouteLink += formattedPoint;
	    routePostParam += formattedPoint;
	}

	document.getElementById("addroutelink").innerHTML = addRouteLink;
        document.getElementById("addroutetext").innerHTML = addRouteText;

	updateCommentlinkVisibility();
    }

    function updateCommentlinkVisibility() {
	// XXX To be precise, this should also check if any of the userWpts
	// XXX is non-null.
	if (addRoute.length > 0 || userWpts.length > 0) {
	  document.getElementById("commentlink").style.display = "block";
	} else {
	  document.getElementById("commentlink").style.display = "none";
	}

	if (userWpts.length > 0) {
	  document.getElementById("hasuserwpts").style.visibility = "inherit";
	} else {
	  document.getElementById("hasuserwpts").style.visibility = "hidden";
	}
    }

    function updateRouteOverlay() {
	if (addRouteOverlay) {
	    map.removeOverlay(addRouteOverlay);
	    addRouteOverlay = null;
	}
	if (!addRoute.length) {
	   return;
	}
	if (addRoute.length == 1) {
	    addRouteOverlay = new GMarker(addRoute[0]);
	} else {
	    var opts = {}; // GPolylineOptions
	    opts.clickable = false;
	    addRouteOverlay = new GPolyline(addRoute, null, null, null, opts);
	}
	map.addOverlay(addRouteOverlay); 
	if (false) { // experiment: draw geodesic lines
	    if (addRouteOverlay2) {
		map.removeOverlay(addRouteOverlay2);
		addRouteOverlay2 = null;
	    }
	    var opts = {}; // GPolylineOptions
	    opts.geodesic = true;
	    addRouteOverlay2 = new GPolyline(addRoute, '#ff0000', null, null, opts);
	    map.addOverlay(addRouteOverlay2);
	}
    }

    function updateTempBlockings(resultXml) {
	removeTempBlockingMarkers()
        var affectingBlockings = resultXml.documentElement.getElementsByTagName("AffectingBlocking");
	if (affectingBlockings && affectingBlockings.length) {
            for(var i = 0; i < affectingBlockings.length; i++) {
		var affectingBlocking = affectingBlockings[i];
	        var llhs = affectingBlocking.getElementsByTagName("LongLatHop")
		if (llhs && llhs.length) {
		    var xy = llhs[0].getElementsByTagName("XY")[0].textContent.split(",");
		    var text = "";
		    var textElements = affectingBlocking.getElementsByTagName("Text");
		    if (textElements && textElements.length) {
			text = textElements[0].textContent;
		    }
		    var point = new GLatLng(xy[1], xy[0]);
	    	    var marker = createMarker(point, text);
		    map.addOverlay(marker);
		    currentTempBlockingMarkers[currentTempBlockingMarkers.length] = marker;
		}
	    }
        }
    }

    function updateWptDiv(resultXml) {
	var Path = "Path"
        if (!resultXml.documentElement.getElementsByTagName("Path")[0]) {
		Path = "LongLatPath";
	}

	var polarElements = resultXml.documentElement.getElementsByTagName("LongLatPath")[0].getElementsByTagName("XY");
	var bbbikeElements = resultXml.documentElement.getElementsByTagName(Path)[0].getElementsByTagName("XY");
	var bbbike2polar = {};
	for(var i = 0; i < polarElements.length; i++) {
	    bbbike2polar[bbbikeElements[i].textContent] = polarElements[i].textContent;
	}
	var pointElements = resultXml.documentElement.getElementsByTagName("Route")[0].getElementsByTagName("Point");
	var wptHTML = "";
	for(var i = 0; i < pointElements.length; i++) {
	    var pe = pointElements[i];
	    var bbbikeCoord = pe.getElementsByTagName("Coord")[0].textContent;
	    var polarCoord = bbbike2polar[bbbikeCoord];
	    if (polarCoord) {
		var xy = polarCoord.split(",");
		wptHTML += "<a href='#map' onclick='setwptAndMark(" + xy[0] + "," + xy[1] + ");return true;'>" + pe.getElementsByTagName("DistString")[0].textContent + " " + pe.getElementsByTagName("DirectionString")[0].textContent + " " + pe.getElementsByTagName("Strname")[0].textContent + "</a><br />\\n";
	    }
	}
	wptHTML += "Gesamtl&auml;nge: " + pointElements[pointElements.length-1].getElementsByTagName("TotalDistString")[0].textContent + "<br />\\n";
	wptHTML += "<a href=\\"javascript:wayBack()\\">R&uuml;ckweg</a><br />\\n";
	document.getElementById("wpt").innerHTML = wptHTML;
    }

    function updateRouteSel() {
	return; // XXX the selection code does not really work
	// See http://use.perl.org/~grink/journal/37262?from=rss for alternatives.
	// Keywords: clipboard selection copying security reasons

	var routeDiv = document.getElementById("addroutetext").firstChild;
	var range = document.createRange();
	range.setStart(routeDiv, routeLabel.length);
	range.setEnd(routeDiv, routeDiv.length);
	var s = window.getSelection();
	s.removeAllRanges();
	s.addRange(range);
    }

    function addUserWpt(point) {
	var userWpt = { index:userWpts.length };
	var marker = new GMarker(point);
	var preHtml = '<form>Kommentar:<br/><textarea id="userWptComment" cols="25" rows=4">';
	var postHtml = '</textarea></form><br/><a href="javascript:deleteUserWpt(' + userWpt.index + ')">Waypoint l&ouml;schen</a>';
	var html = preHtml + postHtml;
	var htmlElem = document.createElement("div");
	htmlElem.innerHTML = html;
	var textarea = htmlElem.getElementsByTagName("textarea")[0];
	userWpt.textarea = textarea;
	marker.bindInfoWindow(htmlElem);
	map.addOverlay(marker);
	userWpt.overlay = marker;
	userWpt.latLng = marker.getLatLng();
	userWpts[userWpts.length] = userWpt;
	updateCommentlinkVisibility();
    }

    function deleteUserWpt(i) {
        var userWpt = userWpts[i];
	if (userWpt) {
	    var overlay = userWpt.overlay;
	    if (overlay) {
	        map.removeOverlay(overlay);
	        userWpt.overlay = null;
	    }
            userWpts[i] = null;
	}
	// XXX should call updateCommentlinkVisibility()
	// XXX once it can handle single deleted waypoints
    }

    function deleteAllUserWpts() {
	for(var i in userWpts) {
	    deleteUserWpt(i);
	}
	userWpts = [];
	updateCommentlinkVisibility();
    }

    function mapTypeToString() {
	var mapType;
	if (map.getCurrentMapType() == G_NORMAL_MAP) {
	    mapType = "normal";
	} else if (map.getCurrentMapType() == G_HYBRID_MAP) {
	    mapType = "hybrid";
	} else {
	    mapType = "satellite";
	}
	return mapType;
    }

    function showLink(point, message) {
	var mapType = mapTypeToString();
        var latLngStr = message + "@{[ $get_public_link->() ]}?zoom=" + map.getZoom() + "&wpt=" + formatPoint(point) + "&coordsystem=polar" + "&maptype=" + mapType;
        document.getElementById("permalink").innerHTML = latLngStr;
    }

    function checkSetCoordForm() {
	if (document.googlemap.wpt_or_trk.value == "") {
	    alert("Bitte Koordinaten eingeben (z.B. im WGS84-Modus: 13.376431,52.516172)");
	    return false;
	}
	setZoomInForm();
	return true;	
    }

    function setZoomInForm() {
	document.googlemap.zoom.value = map.getZoom();
    }

    function setZoomInUploadForm() {
	document.upload.zoom.value = map.getZoom();
    }

    function waitMode() {
	document.getElementsByTagName("body")[0].className = "waitMode";
    }

    function nonWaitMode() {
        document.getElementsByTagName("body")[0].className = "nonWaitMode";
    }

    function searchRoute(startPoint, goalPoint) {
	var requestLine =
	    "@{[ $cgi_reldir ]}/$script?startpolar=" + startPoint.x + "x" + startPoint.y + "&zielpolar=" + goalPoint.x + "x" + goalPoint.y + commonSearchParams;
	var routeRequest = GXmlHttp.create();
	routeRequest.open("GET", requestLine, true);
	routeRequest.onreadystatechange = function() {
	    showRouteResult(routeRequest);
	};
	waitMode();
	routeRequest.send(null);
    }

    function showRouteResult(request) {
	if (request.readyState == 4) {
	    nonWaitMode();
	    if (request.status != 200) {
	        alert("Error calculating route: " + request.statusText);
	        return;
	    }
	    resetRoute();
	    var xml = request.responseXML;
	    var line = xml.documentElement.getElementsByTagName("LongLatPath")[0];
	    var pointElements = line.getElementsByTagName("XY");
	    for (var i = 0; i < pointElements.length; i++) {
	    	var xy = pointElements[i].textContent.split(",");
		if (i == 0) setwpt(xy[0],xy[1]);
	    	var p = new GLatLng(xy[1],xy[0]);
	    	addRoute[addRoute.length] = p;
            }
	    //updateRouteDiv();
	    updateRouteOverlay();
	    updateTempBlockings(xml);
	    updateWptDiv(xml);
	    setDeleteRouteLabel();
	}
    }

    var startOverlay = null;
    var startPoint = null;
    var goalOverlay = null;
    var goalPoint = null;

    function onClick(overlay, point) {
	var currentMode = getCurrentMode();
	if (currentMode == "addroute") {
	    showCoords(point, 'Center of map: ');
	    showLink(point, 'Link to map center: ');
	    addCoordsToRoute(point,true);
	    // XXX should the point also be centered or not?
	    return;
	} else if (currentMode == "addwpt") {
	    addUserWpt(point);
	    return;
	} else if (currentMode != "search") {
	    return;
	}
	if (searchStage == 0) { // set start
	    removeGoalMarker();
	    setStartMarker(point);
	    searchStage = 1;
	    currentModeChange();
	} else if (searchStage == 1) { // set goal
	    setGoalMarker(point);
	    searchStage = 0;
	    currentModeChange();
	    searchRoute(startPoint, goalPoint);
	}
    }

    function wayBack() {
        var tmp = startPoint;
	startPoint = goalPoint;
	goalPoint = tmp;
	tmp = startOverlay;
	startOverlay = goalOverlay;
	goalOverlay = tmp;
        setStartMarker(startPoint);
	setGoalMarker(goalPoint);
	searchRoute(startPoint, goalPoint);
    }

    function setStartMarker(point) {
        if (startOverlay) {
	    map.removeOverlay(startOverlay);
	    startOverlay = null;
	}
	startPoint = point;
	var startOpts = {icon:startIcon, clickable:false}; // GMarkerOptions
	startOverlay = new GMarker(startPoint, startOpts);
	map.addOverlay(startOverlay);
    }

    function setGoalMarker(point) {
	removeGoalMarker();
	goalPoint = point;
	var goalOpts = {icon:goalIcon, clickable:false}; // GMarkerOptions
	goalOverlay = new GMarker(goalPoint, goalOpts);
	map.addOverlay(goalOverlay);
    }

    function removeGoalMarker() {
	if (goalOverlay) {
	    map.removeOverlay(goalOverlay);
	    goalOverlay = null;
	}
    }

    function init() {
        var frm = document.forms.commentform;
        // get_and_set_email_author_from_cookie(frm);
        var initial_mapmode = "$self->{initial_mapmode}";
	if (initial_mapmode) {
	    var elem = document.getElementById("mapmode_" + initial_mapmode);
	    if (elem) {
		elem.checked = true;
		currentModeChange();
	    }
	}
    }

    function send_via_post() {
        var http = GXmlHttp.create(); // new XMLHttpRequest();
        var frm = document.forms.commentform;
        http.open('POST', "@{[ $cgi_reldir ]}/mapserver_comment.cgi", false);
        http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        var comment = frm.comment.value;
	var postContent = "author="+encodeURIComponent(frm.author.value)+"&"+
                          "email="+encodeURIComponent(frm.email.value)+"&"+
      	                  "comment="+encodeURIComponent(comment)+"&"+
			  "routelink="+encodeURIComponent(document.getElementById("addroutelink").innerHTML)+"&"+
      	                  "encoding=utf-8";
	for(var u_i in userWpts) {
	    var userWpt = userWpts[u_i];
	    if (userWpt) {
		var wptComment = "";
		if (userWpt.textarea) {
		    wptComment = userWpt.textarea.value;
		    wptComment = wptComment.replace(/!/, "."); // XXX hackish...
		}
		postContent += "&" + "wpt." + u_i + "=" + encodeURIComponent(wptComment + "!" + userWpt.latLng.lng() + "," + userWpt.latLng.lat());
	    }
	}
	if (routePostParam != "") {
	    postContent += "&" + "route=" + encodeURIComponent(routePostParam);
	}
        http.send(postContent);
        var strResult=http.responseText;
        if (http.status != 200) {
          strResult = "Die &Uuml;bertragung ist mit dem Fehlercode <" + http.status + "> fehlgeschlagen.\\n\\n" + strResult;
        }
        var answerBoxDiv = document.getElementById("answerbox");
        var answerDiv = document.getElementById("answer");
        answerBoxDiv.style.visibility = "visible";
        answerDiv.innerHTML=strResult;
	close_commentform();
    }
  
    function close_answerbox() {
        var answerDiv = document.getElementById("answer");
        var answerBoxDiv = document.getElementById("answerbox");
        answerBoxDiv.style.visibility = "hidden";
        answerDiv.innerHTML = "";
    }

    function close_commentform() {
        var frm = document.forms.commentform;
        frm.style.visibility = "hidden";
    }

    function show_comment() {
	close_answerbox();
        var commentformDiv = document.getElementById("commentform");
        commentformDiv.style.visibility = "visible";
    }

    function doGeocode() {
        var address = document.geocode.geocodeAddress.value;
        if (address == "") {
            alert("Bitte Adresse angeben");
            return false;
        }
	var geocoder = new GClientGeocoder();
	geocoder.setViewport(map.getBounds());
	geocoder.setBaseCountryCode("de");
	waitMode();
	geocoder.getLatLng(address, geocodeResult);
        return false;
    }

    function geocodeResult(point) {
	nonWaitMode();
	if (!point) {
	    alert("Adresse nicht gefunden");
	} else {
	    setwptAndMark(point.x, point.y);
	}
    }

    if (GBrowserIsCompatible() ) {
        var map = new GMap2(document.getElementById("map") );
	map.disableDoubleClickZoom();
        map.addControl(new GLargeMapControl());
        map.addControl(new GMapTypeControl());
        map.addControl(new GOverviewMapControl ());
 	// map.setMapType($self->{maptype});

        // for zoom level, see http://code.google.com/apis/maps/documentation/upgrade.html
	var b = navigator.userAgent.toLowerCase();

        if (marker_list.length > 0) { //  && !(/msie/.test(b) && !/opera/.test(b)) ) {
            var bounds = new GLatLngBounds;
            for (var i=0; i<marker_list.length; i++) {
                bounds.extend(new GLatLng( marker_list[i][0], marker_list[i][1]));
            }
            map.setCenter(bounds.getCenter());

            var zoom = map.getBoundsZoomLevel(bounds);
            // no zoom level higher than 15
            map.setZoom( zoom < 16 ? zoom : 15);

	    if (marker_list.length == 2) {
	       var x1 = marker_list[0][0];
	       var y1 = marker_list[0][1];
	       var x2 = marker_list[1][0];
	       var y2 = marker_list[1][1];

	       var route = new GPolyline([
			new GLatLng(x1,y1), 
			new GLatLng(x2,y1), 
			new GLatLng(x2,y2), 
			new GLatLng(x1,y2), 
			new GLatLng(x1,y1)], // first point again
			'#ff0000', 2, 0.5, {});
	       map.addOverlay(route);

               //x1-=1; y1-=1; x2+=1; y2+=1;
               var x3 = x1 - 180;
               var y3 = y1 - 179.99;
               var x4 = x1 + 180;  
               var y4 = y1 + 179.99;

               var area_around = new GPolygon([
                        new GLatLng(x4,y1),
                        new GLatLng(x3,y1),
                        new GLatLng(x3,y3),
                        new GLatLng(x4,y3),
                        new GLatLng(x4,y1)], // first point again
                        '#ffff00', 0, 0.8);
               map.addOverlay(area_around);

               area_around = new GPolygon([
                        new GLatLng(x4,y2),
                        new GLatLng(x3,y2),
                        new GLatLng(x3,y4),
                        new GLatLng(x4,y4),
                        new GLatLng(x4,y2)], // first point again
                        '#ffff00', 0, 0.5);
               map.addOverlay(area_around);

               area_around = new GPolygon([
                        new GLatLng(x2,y1),
                        new GLatLng(x2,y2),
                        new GLatLng(x4,y2),
                        new GLatLng(x4,y1),
                        new GLatLng(x2,y1)],
                        '#ffff00', 0, 0.5);
               map.addOverlay(area_around);

               area_around = new GPolygon([
                        new GLatLng(x1,y1),
                        new GLatLng(x1,y2),
                        new GLatLng(x3,y2),
                        new GLatLng(x3,y1),
                        new GLatLng(x1,y1)],
                        '#ffff00', 0, 0.5);
               map.addOverlay(area_around);
             }

        } else {
            // use default zoom level
            map.setCenter(new GLatLng($centery, $centerx), 17 - $zoom); // , G_NORMAL_MAP);
        }

	new GKeyboardHandler(map);
    } else {
        document.getElementById("map").innerHTML = '<p class="large-error">Sorry, your browser is not supported by <a href="http://maps.google.com/support">Google Maps</a></p>';
    }

    GEvent.addListener(map, "moveend", function() {
        var center = map.getCenter();
	showCoords(center, 'Center of map: ');
	showLink(center, 'Link to map center: ');
    });


    var copyright = new GCopyright(1,
        new GLatLngBounds(new GLatLng(-90,-180), new GLatLng(90,180)), 0,
        '(<a rel="license" target="_ccbysa" href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>)');
    var copyrightCollection =
        new GCopyrightCollection('Map data &copy; 2010 <a target="_osm" href="http://www.openstreetmap.org/">OpenStreetMap</a> Contributors');
    copyrightCollection.addCopyright(copyright);

    var tilelayers_mapnik = new Array();
    tilelayers_mapnik[0] = new GTileLayer(copyrightCollection, 0, 18);
    tilelayers_mapnik[0].getTileUrl = GetTileUrl_Mapnik;
    tilelayers_mapnik[0].isPng = function () { return true; };
    tilelayers_mapnik[0].getOpacity = function () { return 1.0; };
    var mapnik_map = new GMapType(tilelayers_mapnik,
        new GMercatorProjection(19), "Mapnik",
        { urlArg: 'mapnik', linkColor: '#000000' });
    map.addMapType(mapnik_map);

    var tilelayers_tah = new Array();
    tilelayers_tah[0] = new GTileLayer(copyrightCollection, 0, 17);
    tilelayers_tah[0].getTileUrl = GetTileUrl_TaH;
    tilelayers_tah[0].isPng = function () { return true; };
    tilelayers_tah[0].getOpacity = function () { return 1.0; };
    var tah_map = new GMapType(tilelayers_tah,
        new GMercatorProjection(19), "T\@H",
        { urlArg: 'tah', linkColor: '#000000' });
    map.addMapType(tah_map);

    var tilelayers_cycle = new Array();
    tilelayers_cycle[0] = new GTileLayer(copyrightCollection, 0, 16);
    tilelayers_cycle[0].getTileUrl = GetTileUrl_cycle;
    tilelayers_cycle[0].isPng = function () { return true; };
    tilelayers_cycle[0].getOpacity = function () { return 1.0; };
    var cycle_map = new GMapType(tilelayers_cycle,
        new GMercatorProjection(19), "Cycle",
        { urlArg: 'cycle', linkColor: '#000000' });
    map.addMapType(cycle_map);

    // map.setMapType(cycle_map);
    map.setMapType($self->{maptype});
    map.enableScrollWheelZoom();

    /*
    var marker_icon = new GIcon();
    marker_icon.image = "../images/pin-32x32.png";
    marker_icon.iconSize = new GSize(32, 32)
    marker_icon.iconAnchor = new GPoint(22, 30);

    var mlon = 13.3776;
    var mlat = 52.5162;
    var marker = new GMarker(new GLatLng(mlat, mlon),
        { icon: marker_icon,
          zIndexProcess: function() { return 200; } });
    map.addOverlay(marker);
    */


function GetTileUrl_Mapnik(a, z) {
    return "http://tile.openstreetmap.org/" +
                z + "/" + a.x + "/" + a.y + ".png";
}

function GetTileUrl_TaH(a, z) {
    return "http://tah.openstreetmap.org/Tiles/tile/" +
                z + "/" + a.x + "/" + a.y + ".png";
}

function GetTileUrl_cycle(a, z) {
    return "http://a.andy.sandbox.cloudmade.com/tiles/cycle/" +
                z + "/" + a.x + "/" + a.y + ".png";
}


EOF
    for my $def (
        [ $feeble_paths_polar, '#ff00ff', 5,  0.4 ],
        [ $paths_polar,        '#ff00ff', 10, undef ],
      )
    {
        my ( $paths_polar, $color, $width, $opacity ) = @$def;

        for my $path_polar (@$paths_polar) {
            my $route_js_code = <<EOF;
    var route = new GPolyline([
EOF
            $route_js_code .= join(
                ",\n",
                map {
                    my ( $x, $y ) = split /,/, $_;
                    sprintf 'new GLatLng(%.5f, %.5f)', $y, $x;
                  } @$path_polar
            );
            $route_js_code .= qq{], "$color", $width};
            if ( defined $opacity ) {
                $route_js_code .= qq{, $opacity};
            }
            $route_js_code .= qq{);};

            $html .= <<EOF;
$route_js_code
    // map.addOverlay(route);
EOF
        }
    }

    for my $wpt (@$wpts) {
        my ( $x, $y, $name ) = @$wpt;

        #my $html_name = escapeHTML($name);
        my $html_name = hrefify($name);
        $html .= <<EOF;
    var point = new GLatLng($y,$x);
    var marker = createMarker(point, '$html_name');
    map.addOverlay(marker);
EOF
    }

    #my $q      = new CGI;
    my $city   = $q->param('city') || "";
    my $street = $q->param('street') || "";
    $street = Encode::decode( utf8 => $street );

    my $streets_route = << "EOF";
    // city: $city
    var street = "$street";

    function getStreet(map, street) {
        var url = "/cgi/street-coord.cgi?namespace=0;city=$city&query=" + street;

        map.clearOverlays();

	GDownloadUrl(url, function(data, responseCode) {
	  // To ensure against HTTP errors that result in null or bad data,
	  // always check status code is equal to 200 before processing the data
	  if(responseCode == 200) {
	    var js = eval(data);
	    var streets_list = js[1];

    	    for (var i = 0; i < streets_list.length; i++) {
    	        var streets_route = new Array;
		var s = streets_list[i].split(" ");
		for( var j = 0; j < s.length; j++) {
	  	  var coords = s[j].split(",");
		  streets_route.push(new GLatLng(coords[1], coords[0]));
		}
    	        map.addOverlay(new GPolyline(streets_route, "", 7, 0.5));
    	    }

	  } else if(responseCode == -1) {
	    alert("Data request timed out. Please try later.");
	  } else { 
	    alert("Request resulted in error. Check XML file is retrievable.");
	  }
	});
   }

EOF

    $html .= <<EOF;
   
    $streets_route

    if (street) {
       getStreet(map, street);
    }

    GEvent.addListener(map, "click", onClick);

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

