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

var city = "";

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

var timeout = null;
var delay = 400; // delay until we render the map

function homemap_street_timer (event, time) {
        // cleanup older calls waiting in queue
        if (timeout != null) {
                clearTimeout(timeout);
        }
        timeout = setTimeout( function () { homemap_street (event); }, time);
}



// main map object
var map;

function bbbike_maps_init (maptype, marker_list, lang) {


    var routeLinkLabel = "Link to route: ";
    var routeLabel = "Route: ";
    var commonSearchParams = "&pref_seen=1&pref_speed=20&pref_cat=&pref_quality=&pref_green=&scope=;output_as=xml;referer=bbbikegooglemap";

    var startIcon = new google.maps.MarkerImage("../images/flag2_bl_centered.png", 
	new google.maps.Size(20, 32), new google.maps.Point(0,0), new google.maps.Point(16,16));
    var goalIcon = new google.maps.MarkerImage("../images/flag_ziel_centered.png", 
	new google.maps.Size(20, 32), new google.maps.Point(0,0), new google.maps.Point(16,16));

    if (1 || GBrowserIsCompatible() ) {

        map = new google.maps.Map(document.getElementById("map"), { zoomControl: true, scaleControl: true } );

        // for zoom level, see http://code.google.com/apis/maps/documentation/upgrade.html
	var b = navigator.userAgent.toLowerCase();

        if (marker_list.length > 0) { //  && !(/msie/.test(b) && !/opera/.test(b)) ) {
            var bounds = new google.maps.LatLngBounds;
            for (var i=0; i<marker_list.length; i++) {
                bounds.extend(new google.maps.LatLng( marker_list[i][0], marker_list[i][1]));
            }
            map.setCenter(bounds.getCenter());

            // var zoom = map.getBoundsZoomLevel(bounds);
            map.fitBounds(bounds);
	    var zoom = map.getZoom();

            // no zoom level higher than 15
            map.setZoom( zoom < 16 ? zoom : 15);

	    // re-center after resize of map window
	    $(window).resize( function(e) { 
			map.setCenter(bounds.getCenter()); 
			// var zoom = map.getBoundsZoomLevel(bounds)
			map.fitBounds(bounds);
			var zoom = map.getZoom();

			map.setZoom( zoom < 16 ? zoom : 15); 
	    });


	    if (marker_list.length == 2) {
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
                        strokeColor: '#ff0000', strokeWeight: 1});

	       route.setMap(map);

               //x1-=1; y1-=1; x2+=1; y2+=1;
               var x3 = x1 - 180;
               var y3 = y1 - 179.99;
               var x4 = x1 + 180;  
               var y4 = y1 + 179.99;

	       var o = ['#fff', 0, 1, 0.2, 0.2];
               var area_around = new google.maps.Polygon({ paths: [
                        new google.maps.LatLng(x4,y1),
                        new google.maps.LatLng(x3,y1),
                        new google.maps.LatLng(x3,y3),
                        new google.maps.LatLng(x4,y3),
                        new google.maps.LatLng(x4,y1)], // first point again
			strokeColor: o[0], strokeWeight: o[1], strokeOpacity: o[2], fillColor: o[3], fillOpacity: o[4]});
               area_around.setMap(map);

               area_around = new google.maps.Polygon({ path: [
                        new google.maps.LatLng(x4,y2),
                        new google.maps.LatLng(x3,y2),
                        new google.maps.LatLng(x3,y4),
                        new google.maps.LatLng(x4,y4),
                        new google.maps.LatLng(x4,y2)], // first point again
			strokeColor: o[0], strokeWeight: o[1], strokeOpacity: o[2], fillColor: o[3], fillOpacity: o[4]});
               area_around.setMap(map);

               area_around = new google.maps.Polygon({ path: [
                        new google.maps.LatLng(x2,y1),
                        new google.maps.LatLng(x2,y2),
                        new google.maps.LatLng(x4,y2),
                        new google.maps.LatLng(x4,y1),
                        new google.maps.LatLng(x2,y1)],
			strokeColor: o[0], strokeWeight: o[1], strokeOpacity: o[2], fillColor: o[3], fillOpacity: o[4]});
               area_around.setMap(map);

               area_around = new google.maps.Polygon( { path: [
                        new google.maps.LatLng(x1,y1),
                        new google.maps.LatLng(x1,y2),
                        new google.maps.LatLng(x3,y2),
                        new google.maps.LatLng(x3,y1),
                        new google.maps.LatLng(x1,y1)],
			strokeColor: o[0], strokeWeight: o[1], strokeOpacity: o[2], fillColor: o[3], fillOpacity: o[4]});
               area_around.setMap(map);
             }

        } else {
            // use default zoom level
            // map.setCenter(new google.maps.LatLng(48.05000, 7.31000), 17 - 6); // , G_NORMAL_MAP);

        }

	// new GKeyboardHandler(map);
    } else {
        document.getElementById("map").innerHTML = '<p class="large-error">Sorry, your browser is not supported by <a href="http://maps.google.com/support">Google Maps</a></p>';
    }

    if (0) {
    var copyright = new GCopyright(1,
        new google.maps.LatLng(new google.maps.LatLng(-90,-180), new google.maps.LatLng(90,180)), 0,
        '(<a rel="license" target="_ccbysa" href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>)');
    var copyrightCollection =
        new GCopyrightCollection('Map data &copy; 2010 <a target="_osm" href="http://www.openstreetmap.org/">OpenStreetMap</a> Contributors');
    copyrightCollection.addCopyright(copyright);
    }


    var mapnik_options = {
    	getTileUrl : function (a,z) { 
    	   return "http://tile.openstreetmap.org/" + z + "/" + a.x + "/" + a.y + ".png";
     	},
     	isPng: true,
     	opacity: 1.0,
     	tileSize: new google.maps.Size(256,256),
     	name: "MAPNIK",
     	minZoom:1,
     	maxZoom:20
    }
    var MapnikMapType = new google.maps.ImageMapType( mapnik_options );

    var cycle_options = {
    	getTileUrl : function (a,z) { 
    	   return "http://a.tile.opencyclemap.org/cycle/" + z + "/" + a.x + "/" + a.y + ".png";
     	},
        isPng: true,
     	opacity: 1.0,
     	tileSize: new google.maps.Size(256,256),
     	name: "MAPNIK",
     	minZoom:1,
     	maxZoom:20
    }
    var CycleMapType = new google.maps.ImageMapType( cycle_options );

    // create new map types
    map.mapTypes.set("mapnik", MapnikMapType); 
    map.mapTypes.set("cycle", CycleMapType); 

    // default map type
    if (maptype == "mapnik" || maptype == "terrain" || maptype == "normal") {
    } else {
	maptype = "mapnik";
    }
    map.setMapTypeId( maptype );

    custom_map( "mapnik", lang);
    custom_map( "cycle", lang);
}

    var street = "";
    var street_cache = [];
    var data_cache = [];

    function getStreet(map, city, street) {
        var url = encodeURI("/cgi/street-coord.cgi?namespace=0;city=" + city + "&query=" + street);

	// cleanup map
	for (var i = 0; i < street_cache.length; i++) {
            street_cache[i].setMap(null);
	}

	// read data from cache
	street_cache = [];
	if (data_cache[url] != undefined) {
	    return plotStreet(data_cache[url]);
        }

	// plot street(s) on map
        function plotStreet(data) {
	    var js = eval(data);
	    var streets_list = js[1];

    	    for (var i = 0; i < streets_list.length; i++) {
    	        var streets_route = new Array;
		var s = streets_list[i].split(" ");
		for( var j = 0; j < s.length; j++) {
	  	  var coords = s[j].split(",");
		  streets_route.push(new google.maps.LatLng(coords[1], coords[0]));
		}
	        var route = new google.maps.Polyline( { 
			path: streets_route, 
			strokeColor: "#FF0000",
			strokeWeight: 7, 
			strokeOpacity: 0.5} );
    	        route.setMap(map);

		street_cache.push(route);
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
	var color = "#" + parseInt( Math.random() * 16).toString(16) + parseInt( Math.random() * 16).toString(16) + parseInt( Math.random() * 16).toString(16);

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
    		map: map
	});
	var marker2 = new google.maps.Marker({
    		position: r[ r.length - 1 ],
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
		content += "Route Length: " + opt.route_length + "<br/>\n";
		content += "Driving time: " + driving_time(opt.driving_time) + "<br/>\n";
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
   "da" : { "cycle" : "Cykel" },
   "de" : { "mapnik" : "Mapnik", "cycle" : "Fahrrad" },
   "en" : { "mapnik" : "Mapnik", "cycle" : "Cycle" },
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

var currentText;
function HomeControl(controlDiv, map, maptype, lang) {

  // Set CSS styles for the DIV containing the control
  // Setting padding to 5 px will offset the control
  // from the edge of the map

  controlDiv.style.paddingTop = '5px';
  controlDiv.style.paddingRight = '2px';

  // Set CSS for the control border
  var controlUI = document.createElement('DIV');
  controlUI.style.backgroundColor = 'white';
  controlUI.style.borderStyle = 'solid';
  controlUI.style.borderWidth = '2px';
  controlUI.style.cursor = 'pointer';
  controlUI.style.textAlign = 'center';

  controlUI.title = 'Click to set the map to Home';
  controlDiv.appendChild(controlUI);

  // Set CSS for the control interior
  var controlText = document.createElement('DIV');
  // controlText.style.fontFamily = 'Arial,sans-serif';
  controlText.style.fontSize = '12px';
  controlText.style.paddingLeft = '8px';
  controlText.style.paddingRight = '8px';
  controlText.style.paddingTop = '1px';
  controlText.style.paddingBottom = '1px';

  controlText.innerHTML = translate_mapcontrol(maptype, lang);
  controlUI.appendChild(controlText);

  // Setup the click event listeners: simply set the map to Chicago
  google.maps.event.addDomListener(controlUI, 'click', function() {
    map.setMapTypeId(maptype);

    // un-bold current text
    if (currentText) {
	currentText.style.fontWeight = "normal";	
    }
    controlText.style.fontWeight = "bold";
    currentText = controlText;

  });

}

function custom_map ( maptype, lang ) {
  var homeControlDiv = document.createElement('DIV');
  var homeControl = new HomeControl(homeControlDiv, map, maptype, lang);

  homeControlDiv.index = 1;
  map.controls[google.maps.ControlPosition.TOP_RIGHT].push(homeControlDiv);
}


function displayCurrentPosition () {
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

        google.maps.event.addListener(marker, "click", function(event) { addInfoWindow(marker) } );

        function addInfoWindow (marker) {
                infoWindow = new google.maps.InfoWindow({ maxWidth: 400});
                var content = "<div id=\"infoWindowContent\">\n"
                content += "Your current postion: " + currentPosition.lat + "," + currentPosition.lng + "<br/>\n";
                content += "</div>\n";
                infoWindow.setContent(content);
                infoWindow.open(map, marker);
        };
   });  
}


