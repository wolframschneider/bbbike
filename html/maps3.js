//////////////////////////////////////////////////////////////////////
// global objects/variables
//
var city = ""; 	// bbbike city
var map; 	// main map object

var timeout = null;
var delay = 400; // delay until we render the map

// bbbike options
var bbbike = {
    // map type by google
    mapTypeControlOptions: { mapTypeIds: [ google.maps.MapTypeId.ROADMAP, google.maps.MapTypeId.SATELLITE ] },

    // map type by OpenStreetMap
    mapType: {
	MapnikMapType: true,
	CycleMapType: true,
	PublicTransportMapType: true,
	HikeBikeMapType: true,
	TahMapType: true
    },

    // optinal layers in google maps or all maps
    mapLayers: {
	TrafficLayer: false,
	BicyclingLayer: false,
	PanoramioLayer: false
    },

    // default map
    mapDefault: "mapnik",
    // mapDefault: "terrain",

   // visible controls
   controls: { 
	zoomControl: true, 
	scaleControl: true,
	overviewMapControl: false, // http://code.google.com/p/gmaps-api-issues/issues/detail?id=3167
	panControl: true
   },

   available_google_maps: [ "roadmap", "terrain", "satellite", "hybrid"],
   available_custom_maps: [ "tah", "public-transport", "hike-bike", "mapnik-de", "mapnik", "cycle" ],

   area: { 
	visible: true,
	greyout: true
   }
};

var layers = {};

//////////////////////////////////////////////////////////////////////
// functions
//

function togglePermaLinks() {
        togglePermaLink("permalink_url");
        togglePermaLink("permalink_url2");
}

function togglePermaLink(id) {
        var permalink = document.getElementById(id);
        if (permalink == null)
                return;

        if (permalink.style.display == "none") {
                permalink.style.display = "inline";
        } else {
                permalink.style.display = "none";
        };
}


function homemap_street (event) {
        var target = (event.target) ? event.target : event.srcElement;
        var street;

        // mouse event
        if (!target.id) {
                street = $(target).attr("title");
        }

        // key events in input field
        else {
                var ac_id = $("div.autocomplete");
                if (target.id == "suggest_start") {
                        street = $(ac_id[0]).find("div.selected").attr("title") || $("input#suggest_start").attr("value" );
                } else {
                        street = $(ac_id[1]).find("div.selected").attr("title") || $("input#suggest_ziel").attr("value" );
                }
        }

        if (street == undefined || street.length <= 2) { street = "" }
        // $("div#foo").text("street: " + street);

        if (street != "") {
                var js_div = $("div#BBBikeGooglemap").contents().find("div#street");
                if (js_div) {
                      getStreet(map, city, street);
                }
        }
}

function homemap_street_timer (event, time) {
        // cleanup older calls waiting in queue
        if (timeout != null) {
                clearTimeout(timeout);
        }
        timeout = setTimeout( function () { homemap_street (event); }, time);
}


// test for all google + custom maps
function is_supported_map (maptype) {
    if (is_supported_maptype( maptype, bbbike.available_google_maps) ||
        is_supported_maptype( maptype, bbbike.available_custom_maps) ) {
	return 1;
    } else {
	return 0;
    }
}

function is_supported_maptype (maptype, list) {
    if (!list)
	return 0;

    for (var i = 0; i < list.length; i++) {
	if (list[i] == maptype ) 
	    return 1;
    }

    return 0;
}

function bbbike_maps_init (maptype, marker_list, lang, without_area, region) {


    var routeLinkLabel = "Link to route: ";
    var routeLabel = "Route: ";
    var commonSearchParams = "&pref_seen=1&pref_speed=20&pref_cat=&pref_quality=&pref_green=&scope=;output_as=xml;referer=bbbikegooglemap";

    var startIcon = new google.maps.MarkerImage("../images/flag2_bl_centered.png", 
	new google.maps.Size(20, 32), new google.maps.Point(0,0), new google.maps.Point(16,16));
    var goalIcon = new google.maps.MarkerImage("../images/flag_ziel_centered.png", 
	new google.maps.Size(20, 32), new google.maps.Point(0,0), new google.maps.Point(16,16));

        map = new google.maps.Map(document.getElementById("map"), { 
	   zoomControl: bbbike.controls.zoomControl,
	   scaleControl: bbbike.controls.scaleControl,
	   panControl: bbbike.controls.panControl,
	   mapTypeControlOptions: { mapTypeIds: bbbike.mapTypeControlOptions.mapTypeIds },
	   overviewMapControl: bbbike.controls.overviewMapControl
	} );

        // for zoom level, see http://code.google.com/apis/maps/documentation/upgrade.html
	var b = navigator.userAgent.toLowerCase();

        if (marker_list.length > 0) { //  && !(/msie/.test(b) && !/opera/.test(b)) ) {
            var bounds = new google.maps.LatLngBounds;
            for (var i=0; i<marker_list.length; i++) {
                bounds.extend(new google.maps.LatLng( marker_list[i][0], marker_list[i][1]));
            }
            map.setCenter(bounds.getCenter());

            // var zoom = map.getBoundsZoomLevel(bounds);

	    // improve zoom level, max. area as possible
            var bounds_padding = new google.maps.LatLngBounds;
	    if ( marker_list.length == 2) {
	  	var padding_x = 0.10; // make the area smaller by this value to cheat to map.getZoom()
		var padding_y = 0.07;

	       	bounds_padding.extend(new google.maps.LatLng( marker_list[0][0] + padding_x, marker_list[0][1] + padding_y));
	       	bounds_padding.extend(new google.maps.LatLng( marker_list[1][0] - padding_x, marker_list[1][1] - padding_y));
               	map.fitBounds(bounds_padding);
	    } else {
                map.fitBounds(bounds);
	    }
	    var zoom = map.getZoom();

            // no zoom level higher than 15
            map.setZoom( zoom < 16 ? zoom : 15);

	    // re-center after resize of map window
	    $(window).resize( function(e) { 
			map.setCenter(bounds.getCenter()); 
			// var zoom = map.getBoundsZoomLevel(bounds)
			map.fitBounds(bounds_padding);
			var zoom = map.getZoom();

			map.setZoom( zoom < 16 ? zoom : 15); 
	    });


	    if (marker_list.length == 2 && without_area != 1 && bbbike.area.visible) {
	       var x1 = marker_list[0][0];
	       var y1 = marker_list[0][1];
	       var x2 = marker_list[1][0];
	       var y2 = marker_list[1][1];

	       var route = new google.maps.Polyline({ path: [
			new google.maps.LatLng(x1,y1), 
			new google.maps.LatLng(x2,y1), 
			new google.maps.LatLng(x2,y2), 
			new google.maps.LatLng(x1,y2), 
			new google.maps.LatLng(x1,y1)], // first point again
                        strokeColor: '#ff0000', 
			strokeWeight: 0
			});

	       route.setMap(map);

	       if (bbbike.area.greyout) {
               //x1-=1; y1-=1; x2+=1; y2+=1;
               var x3 = x1 - 180;
               var y3 = y1 - 179.99;
               var x4 = x1 + 180;  
               var y4 = y1 + 179.99;

	       var o = ['#ffffff', 0, 1, '#000000', 0.2];
               var area_around = new google.maps.Polygon({ paths: [
                        new google.maps.LatLng(x4,y1),
                        new google.maps.LatLng(x3,y1),
                        new google.maps.LatLng(x3,y3),
                        new google.maps.LatLng(x4,y3),
                        new google.maps.LatLng(x4,y1)], // first point again
			strokeColor: o[0], strokeWeight: o[1]  , strokeOpacity: o[2], fillOpacity: o[4]});
               area_around.setMap(map);

               area_around = new google.maps.Polygon({ path: [
                        new google.maps.LatLng(x4,y2),
                        new google.maps.LatLng(x3,y2),
                        new google.maps.LatLng(x3,y4),
                        new google.maps.LatLng(x4,y4),
                        new google.maps.LatLng(x4,y2)], // first point again
			strokeColor: o[0], strokeWeight: o[1], strokeOpacity: o[2], fillOpacity: o[4]});
               area_around.setMap(map);

               area_around = new google.maps.Polygon({ path: [
                        new google.maps.LatLng(x2,y1),
                        new google.maps.LatLng(x2,y2),
                        new google.maps.LatLng(x4,y2),
                        new google.maps.LatLng(x4,y1),
                        new google.maps.LatLng(x2,y1)],
			strokeColor: o[0], strokeWeight: o[1], strokeOpacity: o[2], fillOpacity: o[4]});
               area_around.setMap(map);

               area_around = new google.maps.Polygon( { path: [
                        new google.maps.LatLng(x1,y1),
                        new google.maps.LatLng(x1,y2),
                        new google.maps.LatLng(x3,y2),
                        new google.maps.LatLng(x3,y1),
                        new google.maps.LatLng(x1,y1)],
			strokeColor: o[0], strokeWeight: o[1], strokeOpacity: o[2], fillOpacity: o[4]});
               area_around.setMap(map);
             }
	     }
        }

    // see:
    // 	http://wiki.openstreetmap.org/wiki/Slippy_map_tilenames
    //  http://wiki.openstreetmap.org/wiki/Tileserver
    var mapnik_options = {
    	getTileUrl : function (a,z) { 
	   // select a random server
	   var list = ["a", "b"]; // "c"
           var server = list [ parseInt( Math.random() * list.length ) ];

    	   return "http://" + server + ".tile.openstreetmap.org/" + z + "/" + a.x + "/" + a.y + ".png";
     	},
     	isPng: true,
     	opacity: 1.0,
     	tileSize: new google.maps.Size(256,256),
     	name: "MAPNIK",
     	minZoom:1,
     	maxZoom:18
    };

    var tah_options = {
    	getTileUrl : function (a,z) { 
	   // select a random server
	   var list = ["a", "b"]; // "c"
           var server = list [ parseInt( Math.random() * list.length ) ];

    	   return "http://" + server + ".tah.openstreetmap.org/Tiles/tile/" + z + "/" + a.x + "/" + a.y + ".png";
     	},
     	isPng: true,
     	opacity: 1.0,
     	tileSize: new google.maps.Size(256,256),
     	name: "TAH",
     	minZoom:1,
     	maxZoom:17
    };

    // http://www.öpnvkarte.de/
    var public_transport_options = {
    	getTileUrl : function (a,z) { 
	   // select a random server
	   var list = ["a", "b"]; // "c"
           var server = list [ parseInt( Math.random() * list.length ) ];

    	   return "http://" + server + ".tile.xn--pnvkarte-m4a.de/tilegen/" + z + "/" + a.x + "/" + a.y + ".png";
     	},
     	isPng: true,
     	opacity: 1.0,
     	tileSize: new google.maps.Size(256,256),
     	name: "TAH",
     	minZoom:1,
     	maxZoom:18
    };

    // http://hikebikemap.de/
    var hike_bike_options = {
    	getTileUrl : function (a,z) { 
	   // select a random server
	   var list = ["a", "b"]; // "c"
           var server = list [ parseInt( Math.random() * list.length ) ];

    	   return "http://" + server + ".www.toolserver.org/tiles/hikebike/" + z + "/" + a.x + "/" + a.y + ".png";
     	},
     	isPng: true,
     	opacity: 1.0,
     	tileSize: new google.maps.Size(256,256),
     	name: "TAH",
     	minZoom:1,
     	maxZoom:17
    }

    var cycle_options = {
    	getTileUrl : function (a,z) { 

	   // select a random server
	   var list = ["a", "b"]; // "c"
           var server = list [ parseInt( Math.random() * list.length ) ];

    	   return "http://" + server + ".tile.opencyclemap.org/cycle/" + z + "/" + a.x + "/" + a.y + ".png";
     	},
        isPng: true,
     	opacity: 1.0,
     	tileSize: new google.maps.Size(256,256),
     	name: "CYCLE",
     	minZoom:1,
     	maxZoom:17
    };


    if (bbbike.mapType.MapnikMapType) {
        var MapnikMapType = new google.maps.ImageMapType( mapnik_options );
    	map.mapTypes.set("mapnik", MapnikMapType); 
    	custom_map( "mapnik", lang);
    }

    if (bbbike.mapType.CycleMapType) {
        var CycleMapType = new google.maps.ImageMapType( cycle_options );
        map.mapTypes.set("cycle", CycleMapType); 
    	custom_map( "cycle", lang);
    }

    if (bbbike.mapType.HikeBikeMapType) {
        var HikeBikeMapType = new google.maps.ImageMapType( hike_bike_options );
        map.mapTypes.set("hike-bike", HikeBikeMapType); 
    	custom_map( "hike-bike", lang);
    }


    if (bbbike.mapType.PublicTransportMapType) {
        var PublicTransportMapType = new google.maps.ImageMapType( public_transport_options );
        map.mapTypes.set("public-transport", PublicTransportMapType); 
    	custom_map( "public-transport", lang);
    }

    if (bbbike.mapType.TahMapType) {
        var TahMapType = new google.maps.ImageMapType( tah_options );
        map.mapTypes.set("tah", TahMapType); 
    	custom_map( "tah", lang);
    }

    if (!is_supported_map (maptype)) {
	maptype = bbbike.mapDefault;
    }

    map.setMapTypeId( maptype );
    if (is_supported_maptype( maptype, bbbike.available_custom_maps)) {
	setCustomBold(maptype);
    }

    // google maps layers
    init_layers ();
    custom_layer( map, {"layer":"PanoramioLayer", 
		        "enabled": bbbike.mapLayers.PanoramioLayer, 
			"callback": add_panoramio_layer, 
			"lang": lang });

    custom_layer( map, {"layer":"BicyclingLayer", 
		        "enabled": bbbike.mapLayers.BicyclingLayer, 
			"callback": add_bicycle_layer, 
			"lang": lang });

    custom_layer( map, {"layer":"TrafficLayer", 
		        "enabled": bbbike.mapLayers.TrafficLayer, 
			"callback": add_traffic_layer, 
			"lang": lang });

    hideGoogleLayers(maptype);

    // map changed
    google.maps.event.addListener(map, "maptypeid_changed",
	 function () { 
	    var maptype = map.getMapTypeId();
            hideGoogleLayers(maptype);
	}
    );
}

function init_layers () {
    layers.bicyclingLayer = new google.maps.BicyclingLayer();
    layers.trafficLayer = new google.maps.TrafficLayer();

    // need to download library first
    layers.panoramioLayer = false;
}

// add bicycle routes and lanes to map, by google maps
function add_bicycle_layer ( map, enable ) {
    if (!layers.bicyclingLayer) 
	return;

    if (enable) {
        layers.bicyclingLayer.setMap( map );
    } else {
        layers.bicyclingLayer.setMap( null );
    }
}

// add traffic to map, by google maps
function add_traffic_layer ( map, enable ) {
    if (!layers.trafficLayer) 
	return;

    if (enable) {
    	layers.trafficLayer.setMap( map );
    } else {
    	layers.trafficLayer.setMap( null );
    }
}
// add traffic to map, by google maps
function add_panoramio_layer ( map, enable, flag ) {
   // ignore if nothing to display
   if (!layers.panoramioLayer && !enable)
	return;

   // download JavaScript library for panoramio
   if (!layers.panoramioLayer && !flag) {
	if (0) {
	// if (!document.getElementById("panoramio") {
   	var panoramio = document.createElement('DIV');
	panoramio.setAttribute("id", "panoramio");

	var script = document.createElement("script");
	script.type = "text/javascript";
        script.src = "http://maps.google.com/maps/api/js?libraries=panoramio&sensor=true";

	panoramio.appendChild(script);	
        document.body.appendChild(panoramio);

	setTimeout( function () { 
		layers.panoramioLayer = new google.maps.panoramio.PanoramioLayer(); 
		add_panoramio_layer ( map, enable, true );
	}, 3000 );

	return;
	}

	layers.panoramioLayer = new google.maps.panoramio.PanoramioLayer(); 
   }

    if (enable) {
    	layers.panoramioLayer.setMap( map );
    } else {
    	layers.panoramioLayer.setMap( null );
    }
}


    var street = "";
    var street_cache = [];
    var data_cache = [];

    function getStreet(map, city, street, strokeColor) {
	var streetnames = 3; // if set, display a info window with the street name
	var autozoom = 13;   // if set, zoom to the streets

        var url = encodeURI("/cgi/street-coord.cgi?namespace=" + (streetnames ? "3" : "0") + ";city=" + city + "&query=" + street);

	if (!strokeColor) {
	    strokeColor = "#0000FF";
	}

	// cleanup map
	for (var i = 0; i < street_cache.length; i++) {
            street_cache[i].setMap(null);
	}

	// read data from cache
	street_cache = [];
	if (data_cache[url] != undefined) {
	    return plotStreet(data_cache[url]);
        }

        function addInfoWindow (marker, address) {
                infoWindow = new google.maps.InfoWindow({ maxWidth: 500 });
                var content = "<span id=\"infoWindowContent\">\n"
                content += "<p>" + address + "</p>\n";
                content += "</span>\n";
                infoWindow.setContent(content);
                infoWindow.open(map, marker);
        };

	// plot street(s) on map
        function plotStreet(data) {
	    var js = eval(data);
	    var streets_list = js[1];

	    var autozoom_points = [];
    	    for (var i = 0; i < streets_list.length; i++) {
    	        var streets_route = new Array;
		var s;
		var street;

		if (!streetnames) {
		   s = streets_list[i].split(" ");
		} else {
		   var list = streets_list[i].split("\t");
		   street = list[0];
		   s = list[1].split(" ");
		}

		for( var j = 0; j < s.length; j++) {
	  	  var coords = s[j].split(",");
		  streets_route.push(new google.maps.LatLng(coords[1], coords[0]));
		}
	        var route = new google.maps.Polyline( { 
			path: streets_route, 
			strokeColor: strokeColor,
			strokeWeight: 7, 
			strokeOpacity: 0.5} );
    	        route.setMap(map);

		street_cache.push(route);

		if (autozoom) {
		    autozoom_points.push ( streets_route[0] );
		    autozoom_points.push ( streets_route[ streets_route.length - 1] );
		}

		// display a small marker for every street
		if (streetnames) {
		   var pos = 0;
		   // set the marker in the middle of the street
		   if (streets_route.length > 0) {
			pos = Math.ceil( (streets_route.length - 1)/ 2);
		   }
	           var marker = new google.maps.Marker({
                   	position: streets_route[pos],
                  	icon: '/images/mm_20_green.png',
                   	map: map
        	   });

        	   // google.maps.event.addListener(marker, "click", function(event) { addInfoWindow(marker, street) } );
		   if (streets_list.length <= 10) {
        	   	addInfoWindow(marker, street);
		   }
		   street_cache.push(marker);
		}

	    }

	    if (autozoom && autozoom_points.length > 0) {
            	// improve zoom level, max. area as possible
            	var bounds = new google.maps.LatLngBounds;
	    	for ( var i = 0; i < autozoom_points.length; i++) {
                    bounds.extend( autozoom_points[i] );
            	}
            	map.fitBounds(bounds);
            	var zoom = map.getZoom();
            	// do not zoom higher than XY
            	map.setZoom( zoom > autozoom ? autozoom : zoom);
	    }
        }

	// download street coords with AJAX
	downloadUrl(url, function(data, responseCode) {
	  // To ensure against HTTP errors that result in null or bad data,
	  // always check status code is equal to 200 before processing the data

	  if(responseCode == 200) {
	        data_cache[url] = data;
		plotStreet(data);
	  } else if(responseCode == -1) {
	      alert("Data request timed out. Please try later.");
	  } else { 
	      alert("Request resulted in error. Check XML file is retrievable.");
	  }
	});
   }

    // bbbike_maps_init("default", [[48.0500000,7.3100000],[48.1300000,7.4100000]] );

    var infoWindow;
    var routeSave;
    var _area_hash = [];
    function plotRoute(map, opt, street) {
	var r = [];

    	for (var i = 0; i < street.length; i++) {
            //  string: '23.3529099,42.6708386'
	    if (typeof street[i] == 'string') {
	       var coords = street[i].split(",");
	       r.push(new google.maps.LatLng(coords[1], coords[0]));
	    } 

	    // array: [lat,lng] 
	    else { 
	       r.push(new google.maps.LatLng( street[i][1], street[i][0] ));
	    }
	}

	// create a random color
	var color;
	{ 
	  var _color_r  = parseInt( Math.random() * 16).toString(16);
	  var _color_g  = parseInt( Math.random() * 16).toString(16);
	  var _color_b  = parseInt( Math.random() * 16).toString(16);

	  color = "#" + _color_r + _color_r + _color_g + _color_g + _color_b + _color_b;
        }

	var x = r.length > 8 ? 8 : r.length;
        var route = new google.maps.Polyline( { 
		clickable: true,
		path: r,
		strokeColor: color,
		strokeWeight: 5, 
		strokeOpacity: 0.5} );
            route.setMap(map);

	var marker = new google.maps.Marker({
    		position: r[ parseInt( Math.random() * x) ],
		icon: '/images/mm_20_green.png',
    		map: map
	});
	var marker2 = new google.maps.Marker({
    		position: r[ r.length - 1 ],
		icon: '/images/mm_20_red.png',
    		map: map
	});

	function driving_time (driving_time) {
		var data = "";
		var time = driving_time.split('|');
		for (var i = 0; i < time.length; i++) {
			var t = time[i].split(':');
			data += t[0] + ":" + t[1] + "h (at " + t[2] + "km/h) ";
		}
		return data;
	}

        function area (area) {
           var a = area.split("!");
	   var x1y1 = a[0].split(",");
	   var x2y2 = a[1].split(",");
	   var x1 = x1y1[1];
	   var y1 = x1y1[0];
	   var x2 = x2y2[1];
	   var y2 = x2y2[0];

	   var r = [];
	   r.push(new google.maps.LatLng( x1, y1 ));
	   r.push(new google.maps.LatLng( x1, y2 ));
	   r.push(new google.maps.LatLng( x2, y2 ));
	   r.push(new google.maps.LatLng( x2, y1 ));
	   r.push(new google.maps.LatLng( x1, y1 ));

           var route = new google.maps.Polyline( { 
		path: r,
		strokeColor: "#006400",
		strokeWeight: 4, 
		strokeOpacity: 0.5} );
            route.setMap(map);
        }

	// plot the area *once* for a city
	if (opt.area && !_area_hash[opt.area]) {
	    area(opt.area);
	    _area_hash[opt.area] = 1;
        }

        google.maps.event.addListener(marker, "click", function(event) { addInfoWindow(marker) } );
        google.maps.event.addListener(marker2, "click", function(event) { addInfoWindow(marker2) } );

        function addInfoWindow (marker) {
		if (infoWindow) {
			infoWindow.close();
		}
		if (routeSave) {
			routeSave.setOptions({ strokeWeight: 5 });
		}

		infoWindow = new google.maps.InfoWindow({ maxWidth: 400});
		var content = "<div id=\"infoWindowContent\">\n"
		content += "City: " + '<a target="_new" href="/' + opt.city + '/">' + opt.city + '</a>' + "<br/>\n";
		content += "Start: " + opt.startname + "<br/>\n";
		content += "Destination: " + opt.zielname + "<br/>\n";
		content += "Route Length: " + opt.route_length + "km<br/>\n";
		content += "Driving time: " + driving_time(opt.driving_time) + "<br/>\n";
		// pref_cat pref_quality pref_specialvehicle pref_speed pref_ferry pref_unlit
		if (opt.pref_speed != "" && opt.pref_speed != "20" ) { 
		content += "Preferred speed: " + opt.pref_speed + "<br/>\n";
		}
		if (opt.pref_cat != "") { 
		content += "Preferred street category: " + opt.pref_cat + "<br/>\n";
		}
		if (opt.pref_quality != "") { 
		content += "Road surface: " + opt.pref_quality + "<br/>\n";
		}
		if (opt.pref_unlit != "") { 
		content += "Avoid unlit streets: " + opt.pref_unlit + "<br/>\n";
		}
		if (opt.pref_specialvehicle != "") { 
		content += "On the way with: " + opt.pref_specialvehicle + "<br/>\n";
		}
		if (opt.pref_ferry != "") { 
		content += "Use ferries: " + opt.pref_ferry + "<br/>\n";
		}

		content += "</div>\n";
		infoWindow.setContent(content);
		infoWindow.open(map, marker);

    		routeSave = route;
		route.setOptions({ strokeWeight: 10 });
	};
    }

    // bbbike_maps_init("default", [[48.0500000,7.3100000],[48.1300000,7.4100000]] );


// localized custom map names
function translate_mapcontrol ( word, lang ) {
  var l = {
   // master language, fallback for all
   "en" : { "mapnik" : "Mapnik", "cycle" : "Cycle", "tah":"Tile@Home", "hike-bike":"Hike&Bike", "public-transport":"Public Transport" },

   // rest
   "da" : { "cycle" : "Cykel" },
   "de" : { "mapnik" : "Mapnik", "cycle" : "Fahrrad", "traffic layer": "Google Verkehr", "Panoramio": "Panoramio Fotos", "cycle layer": "Google Fahrrad", "hike-bike":"Wandern", "public-transport":"ÖPNV" },
   "es" : { "cycle" : "Bicicletas" },
   "fr" : { "cycle" : "Vélo" },
   "hr" : { "cycle" : "Bicikl" },
   "nl" : { "cycle" : "Fiets" },
   "pl" : { "cycle" : "Rower" },
   "pt" : { "cycle" : "Bicicleta" },
   "ru" : { "cycle" : "Велосипед" },
   "zh" : { "cycle" : "自行车" }
  };

  if (!lang) {
	return word;
  } else if (l[lang] && l[lang][word]) {
	return l[lang][word];
  } else if (l["en"] && l["en"][word]) {
	return l["en"][word];
  } else {
	return word;
  }
}




/**
 * The HomeControl adds a control to the map that simply
 * returns the user to Chicago. This constructor takes
 * the control DIV as an argument.
 */

var currentText = [];
function HomeControl(controlDiv, map, maptype, lang) {

  // Set CSS styles for the DIV containing the control
  // Setting padding to 5 px will offset the control
  // from the edge of the map

  var controlUI = document.createElement('DIV');
  var controlText = document.createElement('DIV');

  controlDiv.style.paddingTop = '5px';
  controlDiv.style.paddingRight = '2px';

  // Set CSS for the control border
  controlUI.style.backgroundColor = 'white';
  controlUI.style.borderStyle = 'solid';
  controlUI.style.borderWidth = '0px';
  controlUI.style.cursor = 'pointer';
  controlUI.style.textAlign = 'center';
  controlUI.title = 'Click to set the map to Home';

  controlDiv.appendChild(controlUI);

  // Set CSS for the control interior
  // controlText.style.fontFamily = 'Arial,sans-serif';
  controlText.style.fontSize = '13px';
  controlText.style.paddingLeft = '8px';
  controlText.style.paddingRight = '8px';
  controlText.style.paddingTop = '3px';
  controlText.style.paddingBottom = '3px';

  controlText.innerHTML = translate_mapcontrol(maptype, lang);
  controlUI.appendChild(controlText);

  currentText[maptype] = controlText;

  // Setup the click event listeners: simply set the map to Chicago
  google.maps.event.addDomListener(controlUI, 'click', function() {
    map.setMapTypeId(maptype);
    setCustomBold( maptype );
  });
}

// de-select all custom maps and optional set a map to bold
function setCustomBold ( maptype ) {
   if (!currentText) 
	return;

   for (var key in  currentText) {
	currentText[key].style.fontWeight = "normal";
	currentText[key].style.color = "#000000";
	currentText[key].style.background = "#FFFFFF";
   }

   // optional: set map to bold
   if (currentText[ maptype ]) {
	currentText[maptype].style.fontWeight = "bold";
	currentText[maptype].style.color = "#FFFFFF";
	currentText[maptype].style.background = "#4682B4";
   }

}


// hide google layers on non-google custom maps
function hideGoogleLayers( maptype ) {
    var value = is_supported_maptype( maptype, bbbike.available_custom_maps) ? "hidden" : "visible";

    var timeout = value == "hidden" ? 2000 : 1000;

    setTimeout( function () { 
	var div = document.getElementById( "BicyclingLayer" );
	if (div)
	   div.style.visibility = value; 
   }, timeout);

    setTimeout( function () { 
	var div = document.getElementById( "TrafficLayer" );
	if (div) 
	   div.style.visibility = value;
    }, timeout - (value == "hidden" ? 500 : -500));

    setCustomBold( maptype );
}

var layerControl = {
   TrafficLayer: false,
   BicyclingLayer: false,
   PanoramioLayer: false
};

function LayerControl(controlDiv, map, opt) {
   var layer = opt.layer;
   var enabled = opt.enabled; 
   var callback = opt.callback;
   var lang = opt.lang;

  // Set CSS styles for the DIV containing the control
  // Setting padding to 5 px will offset the control
  // from the edge of the map

  var controlUI = document.createElement('DIV');
  controlUI.setAttribute("id", layer);

  var controlText = document.createElement('DIV');

  controlDiv.style.paddingTop = '5px';
  controlDiv.style.paddingRight = '2px';

  // Set CSS for the control border
  controlUI.style.backgroundColor = 'white';
  controlUI.style.borderStyle = 'solid';
  controlUI.style.borderWidth = '2px';
  controlUI.style.cursor = 'pointer';
  controlUI.style.textAlign = 'center';

  var layerText = layer;
  if (layer == "BicyclingLayer") {
      layerText = "cycle layer";
      callback ( map, enabled );
  }
  if (layer == "TrafficLayer") {
      layerText = "traffic layer";
      callback ( map, enabled );
  }
  if (layer == "PanoramioLayer") {
      layerText = "Panoramio";
      callback ( map, enabled );
  }


  layerControl.layer = enabled;

  function toogleColor (toogle) {
     controlUI.style.color = toogle ? '#cdc9c9' : '#228b22';
  }
  toogleColor(!layerControl.layer);

  controlUI.title = 'Click to add the layer ' + layerText;

  controlDiv.appendChild(controlUI);

  // Set CSS for the control interior
  // controlText.style.fontFamily = 'Arial,sans-serif';
  controlText.style.fontSize = '12px';
  controlText.style.paddingLeft = '8px';
  controlText.style.paddingRight = '8px';
  controlText.style.paddingTop = '1px';
  controlText.style.paddingBottom = '1px';

  controlText.innerHTML = translate_mapcontrol(layerText, lang);
  controlUI.appendChild(controlText);
  if (enabled) 
      controlText.fontWeight = "bold";

   // switch enabled <-> disabled
  google.maps.event.addDomListener(controlUI, 'click', function() {
    toogleColor(layerControl.layer);
    layerControl.layer = layerControl.layer ? false : true;
    callback ( map,  layerControl.layer);
  });

}

function custom_map ( maptype, lang ) {
  var homeControlDiv = document.createElement('DIV');
  var homeControl = new HomeControl(homeControlDiv, map, maptype, lang);

  homeControlDiv.index = 1;
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(homeControlDiv);
}

function custom_layer ( map, opt) { 
  var layerControlDiv = document.createElement('DIV');
  var layerControl = new LayerControl (layerControlDiv, map, opt);

  layerControlDiv.index = 1;
  map.controls[google.maps.ControlPosition.RIGHT_TOP].push(layerControlDiv);
}


function displayCurrentPosition (area) {
    if (!navigator.geolocation) {
	return;
    }

    navigator.geolocation.getCurrentPosition(function(position) {  
        currentPosition = { "lat": position.coords.latitude, "lng": position.coords.longitude };

	var pos = new google.maps.LatLng( currentPosition.lat, currentPosition.lng );
        var marker = new google.maps.Marker({
                position:  pos,
                map: map
        });

	var geocoder = new google.maps.Geocoder();
	geocoder.geocode({'latLng': pos}, function(results, status) {
  	   if(status != google.maps.GeocoderStatus.OK || !results[0]) {
    		// alert("reverse geocoder failed to find an address for " + latlng.toUrlValue());
  	   } else { 
		var result = results[0];

		// display info window at startup if inside the area
		if (area.length > 0) {
		   if (area[0][0] < currentPosition.lng && area[0][1] < currentPosition.lat &&
		       area[1][0] > currentPosition.lng && area[1][1] > currentPosition.lat) {

		      addInfoWindow (marker, result.formatted_address);

		      // hide window after N seconds
		      setTimeout( function () { 
			marker.setMap(null);
			marker = new google.maps.Marker({
               			position:  pos,
               			map: map
        		});

        	        google.maps.event.addListener(marker, "click", function(event) { addInfoWindow(marker, result.formatted_address) });

		        }, 5000 );
		   }
		}

		// or later at click event
        	google.maps.event.addListener(marker, "click", function(event) { addInfoWindow(marker, result.formatted_address) } );
  	   }
	});

       // google.maps.event.addListener(marker, "click", function(event) { addInfoWindow(marker) } );

        function addInfoWindow (marker, address) {
                infoWindow = new google.maps.InfoWindow({ disableAutoPan: true, maxWidth: 400});
                var content = "<div id=\"infoWindowContent\">\n"
                content += "<p>Your current postion: " + currentPosition.lat + "," + currentPosition.lng + "</p>\n";
		content += "<p>Approximate address: " +  address + "</p>\n";
                content += "</div>\n";
                infoWindow.setContent(content);
                infoWindow.open(map, marker);

        };
   });  
}


