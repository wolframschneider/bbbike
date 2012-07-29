// Copyright (c) by http://www.openstreetmap.org/export - OSM License, 2012
// Copyright (c) 2012 Wolfram Schneider, http://bbbike.org
// 
var config = {
    "coord": ["#sw_lng", "#sw_lat", "#ne_lng", "#ne_lat"],
    "color_normal": "white",
    "color_error": "red",
    "max_skm": 8000000,

    // map box for San Francisco, default
    "city": {
        "sw": [-122.9, 37.2],
        "ne": [-121.7, 37.9]
    },

    "show_filesize": 1,
    "city_name_optional": false,

    "max_size": {
        "default": 512,
        "osm.obf.zip": 200,
    },

    "dummy": ""
};

// Initialise the 'map' object
var map;

// select an area to display on the map

function select_city(name) {
    var city = {
        "Berlin": {
            "sw": [12.875, 52.329],
            "ne": [13.902, 52.705]
        },
        "SanFrancisco": {
            "sw": [-122.9, 37.2],
            "ne": [-121.7, 37.9]
        },
        "NewYork": {
            "sw": [-75, 40.1],
            "ne": [-72.9, 41.1]
        },
        "Copenhagen": {
            "sw": [11.8, 55.4],
            "ne": [13.3, 56]
        }
    }

    if (name && city[name]) {
        return city[name];
    }

    var key;
    var list = new Array;
    for (key in city) {
        list.push(key);
    }

    key = list[parseInt(Math.random() * list.length)];
    return city[key];
}

function init_map_size() {
    var resize = null;

    // set map height depending on the free space on the browser window
    setMapHeight();

    // reset map size, 3x a second
    jQuery(window).resize(function () {
        if (resize) clearTimeout(resize);
        resize = setTimeout(function () {
            setMapHeight();
        }, 300);
    });
}

function init() {
    init_map_size();
    var opt = {
        "back_button": 0
    };

    map = new OpenLayers.Map("map", {
        controls: [
        new OpenLayers.Control.Navigation(), new OpenLayers.Control.PanZoomBar(), new OpenLayers.Control.ScaleLine({
            geodesic: true
        }), new OpenLayers.Control.MousePosition(), new OpenLayers.Control.Attribution(), new OpenLayers.Control.LayerSwitcher(), new OpenLayers.Control.KeyboardDefaults()],

        maxExtent: new OpenLayers.Bounds(-20037508.34, -20037508.34, 20037508.34, 20037508.34),
        maxResolution: 156543.0339,
        numZoomLevels: 19,
        units: 'm',
        projection: new OpenLayers.Projection("EPSG:900913"),
        displayProjection: new OpenLayers.Projection("EPSG:4326")
    });

    map.addLayer(new OpenLayers.Layer.OSM("Esri Topographic", "http://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/${z}/${y}/${x}.png", {
        tileOptions: {
            crossOriginKeyword: null
        },
        attribution: "",
        numZoomLevels: 18
    }));

    map.addLayer(new OpenLayers.Layer.OSM.Mapnik("OSM Mapnik"));
    map.addLayer(new OpenLayers.Layer.OSM.CycleMap("OSM CycleMap"));
    map.addLayer(new OpenLayers.Layer.OSM("OSM Hike&Bike", ["http://a.www.toolserver.org/tiles/hikebike/${z}/${x}/${y}.png", "http://b.www.toolserver.org/tiles/hikebike/${z}/${x}/${y}.png"], {
        tileOptions: {
            crossOriginKeyword: null
        },
        numZoomLevels: 18
    }));
    map.addLayer(new OpenLayers.Layer.OSM("OSM Transport", ["http://a.tile2.opencyclemap.org/transport/${z}/${x}/${y}.png", "http://b.tile2.opencyclemap.org/transport/${z}/${x}/${y}.png"], {
        tileOptions: {
            crossOriginKeyword: null
        },
        numZoomLevels: 19
    }));

    map.addLayer(new OpenLayers.Layer.OSM("Mapquest OSM", ["http://otile1.mqcdn.com/tiles/1.0.0/osm/${z}/${x}/${y}.png", "http://otile2.mqcdn.com/tiles/1.0.0/osm/${z}/${x}/${y}.png"], {
        tileOptions: {
            crossOriginKeyword: null
        },
        numZoomLevels: 19
    }));
    map.addLayer(new OpenLayers.Layer.OSM("Mapquest Satellite", ["http://mtile01.mqcdn.com/tiles/1.0.0/vy/sat/${z}/${x}/${y}.png", "http://mtile02.mqcdn.com/tiles/1.0.0/vy/sat/${z}/${x}/${y}.png"], {
        tileOptions: {
            crossOriginKeyword: null
        },
        numZoomLevels: 19
    }));

    var epsg4326 = new OpenLayers.Projection("EPSG:4326");
    var bounds;

    // read from input, back button pressed?
    if (check_lat_form(1)) {
        // bounds = new OpenLayers.Bounds( $("#sw_lng").val(), $("#sw_lat").val(), $("#ne_lng").val(), $("#ne_lat").val() );
        opt.back_button = 1;

        var sw_lng = $("#sw_lng").val();
        var sw_lat = $("#sw_lat").val();
        var ne_lng = $("#ne_lng").val();
        var ne_lat = $("#ne_lat").val();

        bounds = new OpenLayers.Bounds(sw_lng, sw_lat, ne_lng, ne_lat);

        // back button: reset coordinates to original values
        opt.back_function = function () {
            $("#sw_lng").val(sw_lng);
            $("#sw_lat").val(sw_lat);
            $("#ne_lng").val(ne_lng);
            $("#ne_lat").val(ne_lat);
        };
    }

    // default city
    else {
        var c = select_city();
        bounds = new OpenLayers.Bounds(c.sw[0], c.sw[1], c.ne[0], c.ne[1]);
    }

    bounds.transform(epsg4326, map.getProjectionObject());
    map.zoomToExtent(bounds);

    osm_init(opt);
}

function osm_init(opt) {
    var vectors;
    var box;
    var transform;
    var markerLayer;
    var markerControl;

    function startExport() {
        vectors = new OpenLayers.Layer.Vector("Vector Layer", {
            displayInLayerSwitcher: false
        });
        map.addLayer(vectors);

        box = new OpenLayers.Control.DrawFeature(vectors, OpenLayers.Handler.RegularPolygon, {
            handlerOptions: {
                sides: 4,
                snapAngle: 90,
                irregular: true,
                persist: true
            }
        });
        box.handler.callbacks.done = endDrag;
        map.addControl(box);

        transform = new OpenLayers.Control.TransformFeature(vectors, {
            rotate: false,
            irregular: true
        });
        transform.events.register("transformcomplete", transform, transformComplete);
        map.addControl(transform);

        map.events.register("moveend", map, mapMoved);

        // $("#sidebar_title").html("Export");
        $("#ne_lat").change(boundsChanged);
        $("#sw_lng").change(boundsChanged);
        $("#ne_lng").change(boundsChanged);
        $("#sw_lat").change(boundsChanged);

        $("#drag_box").click(startDrag);
        setBounds(map.getExtent());

        // implement history for back button
        if (opt.back_button) {
            setTimeout(function () {
                opt.back_function();
                boundsChanged();
            }, 500);
        }

    }

    function boundsChanged() {
        var epsg4326 = new OpenLayers.Projection("EPSG:4326");

        if (!check_lat_form()) {
            alert("lat or lng value is out of range -180 ... 180");
            return;
        }

        var bounds = new OpenLayers.Bounds($("#sw_lng").val(), $("#sw_lat").val(), $("#ne_lng").val(), $("#ne_lat").val());

        bounds.transform(epsg4326, map.getProjectionObject());

        map.events.unregister("moveend", map, mapMoved);
        map.zoomToExtent(bounds);

        clearBox();
        drawBox(bounds);
        validateControls();
        mapnikSizeChanged();
    }

    function startDrag() {
        $("#drag_box").html("Drag a box on the map to select an area");

        clearBox();
        setBounds(map.getExtent());
        // setBounds(bounds);
        box.activate();
    };

    function endDrag(bbox) {
        var bounds = bbox.getBounds();

        map.events.unregister("moveend", map, mapMoved);
        setBounds(bounds);
        drawBox(bounds);
        box.deactivate();
        validateControls();

        $("#drag_box").html("Manually select a different area");
    }

    function transformComplete(event) {
        setBounds(event.feature.geometry.bounds);
        validateControls();
    }

    function mapMoved() {
        setBounds(map.getExtent());
        validateControls();
    }

    function setBounds(bounds) {
        var epsg4326 = new OpenLayers.Projection("EPSG:4326");
        var decimals = Math.pow(10, Math.floor(map.getZoom() / 3));

        bounds = bounds.clone().transform(map.getProjectionObject(), epsg4326);

        $("#sw_lng").val(Math.round(bounds.left * decimals) / decimals);
        $("#sw_lat").val(Math.round(bounds.bottom * decimals) / decimals);
        $("#ne_lng").val(Math.round(bounds.right * decimals) / decimals);
        $("#ne_lat").val(Math.round(bounds.top * decimals) / decimals);

        // $('input[name=sw_lat]', parent.document).attr("value", 'foo');
        mapnikSizeChanged();
    }

    function clearBox() {
        transform.deactivate();
        vectors.destroyFeatures();
    }

    function drawBox(bounds) {
        var feature = new OpenLayers.Feature.Vector(bounds.toGeometry());

        vectors.addFeatures(feature);
        transform.setFeature(feature);
    }

    // size of an area in square km 

    function square_km(x1, y1, x2, y2) { // SW x NE
        var height = OpenLayers.Util.distVincenty({
            lat: x1,
            lon: y1
        }, {
            lat: x1,
            lon: y2
        });
        var width = OpenLayers.Util.distVincenty({
            lat: x1,
            lon: y1
        }, {
            lat: x2,
            lon: y1
        });

        return Math.round(height * width + 0.5);
        // return height + " " + width;
    }

    function validateControlsGuess() {
        var bounds = new OpenLayers.Bounds($("#sw_lng").val(), $("#sw_lat").val(), $("#ne_lng").val(), $("#ne_lat").val());

        var skm = square_km($("#sw_lat").val(), $("#sw_lng").val(), $("#ne_lat").val(), $("#ne_lng").val());
        var filesize = show_filesize(skm);

        if ($("#square_km")) {
            var html = "area covers " + large_int(skm) + " square km";
            if (config.show_filesize) {
                html += filesize.html;
            }
            $("#square_km").html(html);
        }

        if (skm > config.max_skm) {
            $("#size").html("Max area size: " + config.max_skm + " square km!");
            $("#export_osm_too_large").show();
        } else if (filesize.size_max > config.max_size["default"]) {
            $("#size").html("Max file size: " + config.max_size["default"] + " MB.");
            $("#export_osm_too_large").show();
        } else if (filesize.format == "osm.obf.zip" && filesize.size_max > config.max_size["osm.obf.zip"]) {
            // Osmand works only for small areas less than 200MB
            $("#size").html("Max osmand file size: " + config.max_size["osm.obf.zip"] + " MB.");
            $("#export_osm_too_large").show();
        } else {
            $("#export_osm_too_large").hide();
        }
    }

    function validateControls() {
        var bounds = new OpenLayers.Bounds($("#sw_lng").val(), $("#sw_lat").val(), $("#ne_lng").val(), $("#ne_lat").val());

        var skm = square_km($("#sw_lat").val(), $("#sw_lng").val(), $("#ne_lat").val(), $("#ne_lng").val());
        var format = $("select[name=format] option:selected").val();

        var url = "/cgi/tile-size.cgi?format=" + format + "&lat_sw=" + $("#sw_lat").val() + "&lng_sw=" + $("#sw_lng").val() + "&lat_ne=" + $("#ne_lat").val() + "&lng_ne=" + $("#ne_lng").val();

        jQuery.getJSON(url, function (data) {
            // debug("size: " + data.size);
            var filesize = show_filesize(skm, data.size);
            show_skm(skm, filesize);
        });

        function show_skm(skm, filesize) {
            if ($("#square_km")) {
                var html = "area covers " + large_int(skm) + " square km";
                if (config.show_filesize) {
                    html += filesize.html;
                }
                $("#square_km").html(html);
            }

            if (skm > config.max_skm) {
                $("#size").html("Max area size: " + config.max_skm + "skm.");
                $("#export_osm_too_large").show();
            } else if (filesize.size_max > config.max_size["default"]) {
                $("#size").html("Max file size: " + config.max_size["default"] + " MB.");
                $("#export_osm_too_large").show();
            } else if (filesize.format == "osm.obf.zip" && filesize.size_max > config.max_size["osm.obf.zip"]) {
                // Osmand works only for small areas less than 200MB
                $("#size").html("Max osmand file size: " + config.max_size["osm.obf.zip"] + " MB.");
                $("#export_osm_too_large").show();
            } else {
                $("#export_osm_too_large").hide();
            }
        }

    }

    function show_filesize(skm, real_size) {
        var size = skm / 1000;
        var format = $("select[name=format] option:selected").val();

        if (real_size) size = real_size / 1024;

        var factor = 1; // PBF
        var factor_time = 0; // PBF
        if (format == "osm.gz") {
            factor = 2;
            factor_time = 0.5;
        } else if (format == "osm.bz2") {
            factor = 1.5;
            factor_time = 1;
        } else if (format == "osm.xz") {
            factor = 1.8;
            factor_time = 0.4;
        } else if (format.match(/^garmin-(osm|cycle|leisure)\.zip$/)) {
            factor = 0.8;
            factor_time = 2;
        } else if (format == "osm.shp.zip") {
            factor = 1.5;
            factor_time = 1;
        } else if (format == "osm.obf.zip") {
            factor = 1.4;
            factor_time = 20;
        }

        var time_min = 600 + (size * factor_time);
        var time_max = 600 + (size * factor_time * 2);
        var size_min = Math.floor(factor * size * 0.25);
        var size_max = Math.ceil(factor * size * 2);

        var html = ", approx. " + size_min + "-" + size_max + " MB OSM data";

        // we have real data, no need to guess
        if (real_size) {
            html = ", ~" + Math.round(real_size / 1024 * 10) / 10 + "MB " + format + " data";
            size_max = real_size / 1024;
        }

        if (skm < config.max_skm) {
            var min = Math.ceil(time_min / 60);
            var max = Math.ceil(time_max / 60);
            html += ", approx. extract time: " + min + (min != max ? "-" + max : "") + " minutes";
        }

        var obj = {
            "html": html,
            "size_max": size_max,
            "format": format
        };
        return obj;
    }

    function getMapLayers() {
        return "M";
    }

    function mapnikImageSize(scale) {
        var bounds = new OpenLayers.Bounds($("#sw_lng").val(), $("#sw_lat").val(), $("#ne_lng").val(), $("#ne_lat").val());
        var epsg4326 = new OpenLayers.Projection("EPSG:4326");
        var epsg900913 = new OpenLayers.Projection("EPSG:900913");

        bounds.transform(epsg4326, epsg900913);

        return new OpenLayers.Size(Math.round(bounds.getWidth() / scale / 0.00028), Math.round(bounds.getHeight() / scale / 0.00028));
    }

    function roundScale(scale) {
        var precision = 5 * Math.pow(10, Math.floor(Math.LOG10E * Math.log(scale)) - 2);

        return precision * Math.ceil(scale / precision);
    }

    function mapnikSizeChanged() {
        var size = mapnikImageSize($("#mapnik_scale").val());

        $("#mapnik_image_width").html(size.w);
        $("#mapnik_image_height").html(size.h);

        validateControls();
    }

    if ($("select[name=format]")) {
        $("select[name=format]").change(function () {
            validateControls()
        });
    }

    startExport(opt);
}

// 240000 -> 240,000

function large_int(number) {
    var string = String(number);

    if (number < 1000) {
        return number;
    } else {
        return string.slice(0, -3) + "," + string.substring(-3, 3);
    }
}

// validate lat or lng values

function check_lat(lat) {
    if (lat == NaN || lat == "") return false;
    if (lat >= -180 && lat <= 180) return true;

    return false;
}

function checkform() {
    var ret = true;
    var color_normal = "white";
    var color_error = "red";

    var inputs = $("form#extract input");
    // debug("inputs elements: " + inputs.length); return false;
    for (i = 0; i < inputs.length; ++i) {
        var e = inputs[i];

        if (e.value == "") {
            // optional forms fields
            if (config.city_name_optional && e.name == "city") continue;

            e.style.background = color_error;
            e.focus();
            ret = false;
            continue;
        }

        if (e.name == "sw_lat" || e.name == "sw_lng" || e.name == "ne_lat" || e.name == "ne_lng") {
            if (!check_lat(e.value)) {
                e.style.background = color_error;
                ret = false;
                continue;
            }
        }

        // reset color
        e.style.background = color_normal;
    }

    if (!ret) {
        alert("Please fill out all fields!");
    }
    return ret;
}


function check_lat_form(noerror) {
    var ret = true;
    var coord = config.coord;

    for (var i = 0; i < coord.length; i++) {
        var val = $(coord[i]).val();
        if (check_lat(val)) {
            $(coord[i]).css("background", config.color_normal);
        } else {
            if (!noerror) $(coord[i]).css("background", config.color_error);
            ret = false;
        }
    }

    return ret;
}

function debug(text, id) {
    if (!id) {
        id = "debug";
    }

    var tag = document.getElementById(id);
    var today = new Date();

    if (!tag) return;

    tag.innerHTML = "debug: " + text; // + " " + today;
}

function setMapHeight() {
    var height = jQuery(window).height() - jQuery('#top').height() - jQuery('#sidebar').height() - jQuery('#footer').height() - 100 + 10;
    if (height < 200) height = 200;
    jQuery('#map').height(height);

    // debug("height: " + height + " d.height: " + jQuery(document).height() + " w.height: " + jQuery(window).height() + " top.h: " + jQuery('#top').height());
};

/*
 * geo location
 *
 */
function locateMe() {
    if (!navigator || !navigator.geolocation) return;

    var tag = locateMe_tag();
    if (tag) {
        tag.show();
        navigator.geolocation.getCurrentPosition(locateMe_cb, locateMe_error);
        setTimeout(function () {
            tag.hide();
        }, 5000); // paranoid
    }
}

function locateMe_tag() {
    return jQuery("#tools-pageload");
}

function setStartPos(lon, lat, zoom) {
    var lonlat = new OpenLayers.LonLat(lon, lat);
    var proj4326 = new OpenLayers.Projection('EPSG:4326');

    var center = lonlat.clone();
    center.transform(proj4326, map.getProjectionObject());
    map.setCenter(center, zoom);
}

function locateMe_cb(position) {
    setStartPos(position.coords.longitude, position.coords.latitude, 10);
    locateMe_tag().hide();
    debug("set position: " + pos.lat + "," + pos.lon);
}

function locateMe_error(error) {
    debug("could not found position");
    locateMe_tag().hide();
    return;
}

// EOF
