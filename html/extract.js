// Copyright (c) by http://www.openstreetmap.org/export - OSM License, 2012
// Copyright (c) 2012 Wolfram Schneider, http://bbbike.org
//
var config = {
    "coord": ["#sw_lng", "#sw_lat", "#ne_lng", "#ne_lat"],
    "color_normal": "white",
    "color_error": "red",
    "max_skm": 16000000,

    // map box for San Francisco, default
    "city": {
        "sw": [-122.9, 37.2],
        "ne": [-121.7, 37.9]
    },

    "show_filesize": 1,
    "city_name_optional": false,

    // in MB
    "max_size": {
        "default": 768,
        "osm.obf.zip": 250,
    },

    "dummy": ""
};

// global variables
var state = {};

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
        }, 500);
    });
}

function init() {
    initKeyPress();

    init_map_size();
    var opt = {
        "back_button": 0
    };

    var keyboard = new OpenLayers.Control.KeyboardDefaults({}); // "observeElement": jQuery("#map")} );
    map = new OpenLayers.Map("map", {
        controls: [
        new OpenLayers.Control.Navigation(), new OpenLayers.Control.PanZoomBar(), new OpenLayers.Control.ScaleLine({
            geodesic: true
        }), new OpenLayers.Control.MousePosition(), new OpenLayers.Control.Attribution(), new OpenLayers.Control.LayerSwitcher(), keyboard],

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
    if (check_lnglat_form(1)) {
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

        // setTimeout(function () { state.validateControls() }, 50);
    }

    // default city
    else {
        var c = select_city();
        bounds = new OpenLayers.Bounds(c.sw[0], c.sw[1], c.ne[0], c.ne[1]);
    }

    bounds.transform(epsg4326, map.getProjectionObject());
    map.zoomToExtent(bounds);

    permalink_init();

    osm_init(opt);
}

// override standard OpenLayers permalink method

function permalink_init() {
    OpenLayers.Control.Permalink.prototype.createParams = function (center, zoom, layers) {
        var params = OpenLayers.Util.getParameters(this.base);
        params.sw_lng = $("#sw_lng").val();
        params.sw_lat = $("#sw_lat").val();
        params.ne_lng = $("#ne_lng").val();
        params.ne_lat = $("#ne_lat").val();
        params.format = $("select[name=format] option:selected").val();

        // not supported yet
        // params.layers = layers;
        // params.city = $("#city").val();
        return params;
    };

    // wait a moment for inital permalink, to read values from forms
    setTimeout(function () {
        map.addControl(new OpenLayers.Control.Permalink('permalink'))
    }, 1000);
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
            }, 50);
        }
    }

    function boundsChanged() {
        var epsg4326 = new OpenLayers.Projection("EPSG:4326");

        if (!check_lnglat_form()) {
            alert("lng or lat value is out of range -180 ... 180, -90 .. 90");
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

        function v(value) {
            var val = Math.round(value * decimals) / decimals;
            if (val < -180) {
                val += 360;
            } else if (val > 180) {
                val -= 360;
            }

            return val;
        }

        $("#sw_lng").val(v(bounds.left));
        $("#sw_lat").val(v(bounds.bottom));
        $("#ne_lng").val(v(bounds.right));
        $("#ne_lat").val(v(bounds.top));

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

    // deprecated, replaced by validateControlsAjax()

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

    // wait 0.2 seconds before starting validate
    var _validate_timeout;

    var validateControls = function () {
            if (_validate_timeout) clearTimeout(_validate_timeout);
            _validate_timeout = setTimeout(function () {
                validateControlsAjax();
            }, 200);

        }
    state.validateControls = validateControls;

    function validateControlsAjax() {
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

            // keep area size in forms
            var area_size = $("#as");
            if (area_size) {
                area_size.attr("value", filesize.size_max);
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
    setTimeout(function () {
        $("#controls").show();
        polygon_init();
    }, 1000);

    var controls;

    function polygon_init() {
        var vectors;

        OpenLayers.Feature.Vector.style['default']['strokeWidth'] = '4';
        var renderer = OpenLayers.Layer.Vector.prototype.renderers;

        vectors = new OpenLayers.Layer.Vector("Vector Layer", {
            renderers: renderer
        });

        map.addLayer(vectors);

        if (console && console.log) {
            function report(event) {
                console.log(event.type, event.feature ? event.feature.id : event.components);
                if (event.feature) {
                    if (event.type == "featuremodified" || event.type == "sketchcomplete") {
                        serialize(event.feature);
                    }
                    if (event.type == "sketchcomplete") {
                        document.getElementById('modifyToggle').checked = true;
                        polygon_toggleControl(document.getElementById('modifyToggle'));
                    }
                }
            }

            vectors.events.on({
                "beforefeaturemodified": report,
                "featuremodified": report,
                "afterfeaturemodified": report,
                "vertexmodified": report,
                "sketchmodified": report,
                "sketchstarted": report,
                "sketchcomplete": report
            });
        }

        controls = {
            polygon: new OpenLayers.Control.DrawFeature(vectors, OpenLayers.Handler.Polygon),
            modify: new OpenLayers.Control.ModifyFeature(vectors)
        };

        for (var key in controls) {
            map.addControl(controls[key]);
        }

        function v(value) {
            return value
        };

        /* WTF? no bounds, trye again a little bit later */
	/*
        function serialize(feature) {
            setTimeout(function () {
                _serialize(feature)
            }, 500);
        }
	*/

        function serialize(obj) {
            var epsg4326 = new OpenLayers.Projection("EPSG:4326");

            // var bounds = obj.geometry.bounds.clone().transform(map.getProjectionObject(), epsg4326);
            var feature = obj.clone(); // work on a clone
            feature.geometry.transform(map.getProjectionObject(), epsg4326);
	    feature.geometry.calculateBounds();
	    var bounds = feature.geometry.bounds;

            var vec = feature.geometry.getVertices();
            var data = "p: " + vec.length + "<br/>";
	    data += parseInt(feature.geometry.getGeodesicArea()/100000)/10 + " sqkm<br/>";

            for (var i = 0; i < vec.length; i++) {
                if (i > 0) data += '!';
                data += vec[i].x + "," + vec[i].y;
            }

            if (bounds != null) {
                $("#sw_lng").val(v(bounds.left));
                $("#sw_lat").val(v(bounds.bottom));
                $("#ne_lng").val(v(bounds.right));
                $("#ne_lat").val(v(bounds.top));
                validateControlsAjax();
            }
            debug(data);
        }

        var options = {
/*
                hover: true,
                onSelect: serialize,
                clickoutFeature: serialize,
                outFeature: serialize,
                overFeature: serialize,
		*/
        };

        var select = new OpenLayers.Control.SelectFeature(vectors, options);
        map.addControl(select);
        select.activate();

        var out_options = {
            'internalProjection': map.baseLayer.projection,
            'externalProjection': new OpenLayers.Projection("EPSG:4326")
        };

        controls.polygon.activate();
        document.getElementById('polygonToggle').checked = true;
    }

    state.update = function update() {
        // reset modification mode
        controls.modify.mode = OpenLayers.Control.ModifyFeature.RESHAPE;
        var rotate = document.getElementById("rotate").checked;

        if (rotate) {
            controls.modify.mode |= OpenLayers.Control.ModifyFeature.ROTATE;
            controls.modify.mode |= OpenLayers.Control.ModifyFeature.RESIZE;
            //    controls.modify.mode &= ~OpenLayers.Control.ModifyFeature.RESHAPE;
            controls.modify.mode |= OpenLayers.Control.ModifyFeature.DRAG;
            controls.modify.mode &= ~OpenLayers.Control.ModifyFeature.RESHAPE;
        } else {
            controls.modify.createVertices = document.getElementById("createVertices").checked;
        }
    }

    state.toggleControl = function toggleControl(element) {
        for (key in controls) {
            var control = controls[key];
            if (element.value == key && element.checked) {
                control.activate();
            } else {
                control.deactivate();
            }
        }
    }
}

function polygon_update() {
    return state.update()
};

function polygon_toggleControl(element) {
    return state.toggleControl(element)
};

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

function check_lat(number) {
    return check_coord(number, 90)
}

function check_lng(number) {
    return check_coord(number, 180)
}

function check_coord(number, max) {
    if (number == NaN || number == "") return false;
    if (number >= -max && number <= max) return true;

    return false;
}

function checkform() {
    var ret = 0;
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
            ret = 1;
            continue;
        }

        if (e.name == "sw_lat" || e.name == "sw_lng" || e.name == "ne_lat" || e.name == "ne_lng") {
            if (!check_lat(e.value)) {
                e.style.background = color_error;
                ret = 1;
                continue;
            }
        }

        // check area size in MB
        if (e.name == "as") {
            var format = $("select[name=format] option:selected").val();
            var max_size = config.max_size[format] ? config.max_size[format] : config.max_size["default"];
            if (e.value < 0 || e.value > max_size) ret = 2;
            debug(format + " " + max_size + " " + e.value);
        }

        // reset color
        e.style.background = color_normal;
    }

    if (ret > 0) {
        alert(ret == 1 ? "Please fill out all fields!" : "Use a smaller area!");
    }

    return ret == 0 ? true : false;
}


function check_lnglat_form(noerror) {
    var ret = true;
    var coord = config.coord;

    for (var i = 0; i < coord.length; i++) {
        var val = $(coord[i]).val();
        if (i % 2 == 0 ? check_lng(val) : check_lat(val)) {
            $(coord[i]).css("background", config.color_normal);
        } else {
            if (!noerror) $(coord[i]).css("background", config.color_error);
            ret = false;
        }
    }

    return ret;
}

function debug(text, id) {
    // log to JavaScript console
    if (console && console.log) console.log("BBBike extract: " + text);

    if (!id) id = "debug";

    var tag = jQuery("#" + id);
    if (!tag) return;

    // log to HTML page
    tag.html("debug: " + text);
}

function setMapHeight() {
    var height = jQuery(window).height();
    var width = jQuery(window).width() - jQuery('#sidebar_left').width();
    if (height < 200) height = 200;

    // jQuery('#content').height(height);
    // jQuery('#content').width(width);
    width = Math.floor(width);
    height = Math.floor(height);

    jQuery('#map').width(width);
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

function google_plusone() {
    jQuery.getScript('https://apis.google.com/js/plusone.js');
    $('.gplus').remove();
}


/*
  here are dragons!
  code copied from js/OpenLayers-2.11/OpenLayers.js: OpenLayers.Control.KeyboardDefaults

  see also: http://www.mediaevent.de/javascript/Extras-Javascript-Keycodes.html
*/
function initKeyPress() {
    // move all maps left/right/top/down

    function moveMap(direction, option) {
        var animate = false;

        map.pan(direction, option, {
            animate: animate
        });
    };

    OpenLayers.Control.KeyboardDefaults.observeElement = jQuery("#map");

    OpenLayers.Control.KeyboardDefaults.prototype.defaultKeyPress = function (evt) {
        switch (evt.keyCode) {
        case OpenLayers.Event.KEY_LEFT:
            moveMap(-this.slideFactor, 0);
            break;
        case OpenLayers.Event.KEY_RIGHT:
            moveMap(this.slideFactor, 0);
            break;
        case OpenLayers.Event.KEY_UP:
            moveMap(0, -this.slideFactor);
            break;
        case OpenLayers.Event.KEY_DOWN:
            moveMap(0, this.slideFactor);
            break;
        }
    };
};

// EOF
