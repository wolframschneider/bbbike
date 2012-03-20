// Copyright by http://www.openstreetmap.org/export
// OSM License, 2012
// http://bbbike.org
// 
// Start position for the map (hardcoded here for simplicity)
var lat = 52.51703;
var lon = 13.38885;
var zoom = 10;

var config = {
    "coord": ["#sw_lng", "#sw_lat", "#ne_lng", "#ne_lat"],
    "color_normal": "white",
    "color_error": "red",
    "max_skm": 240000,

    // map box for San Francisco, default
    "sw": [-122.9, 37.2],
    "ne": [-121.7, 37.9],

    "show_filesize": 1,

    "dummy": ""
};

// Initialise the 'map' object
var map;

function init() {

    map = new OpenLayers.Map("map", {
        controls: [
        new OpenLayers.Control.Navigation(), new OpenLayers.Control.PanZoomBar(), new OpenLayers.Control.ScaleLine({
            geodesic: true
        }), new OpenLayers.Control.MousePosition(), new OpenLayers.Control.Attribution(), new OpenLayers.Control.LayerSwitcher()],

        maxExtent: new OpenLayers.Bounds(-20037508.34, -20037508.34, 20037508.34, 20037508.34),
        maxResolution: 156543.0339,
        numZoomLevels: 19,
        units: 'm',
        projection: new OpenLayers.Projection("EPSG:900913"),
        displayProjection: new OpenLayers.Projection("EPSG:4326")
    });

    map.addLayer(new OpenLayers.Layer.OSM("Esri Topographic", "http://services.arcgisonline.com/ArcGIS/rest/services/World_Topo_Map/MapServer/tile/${z}/${y}/${x}.png", {
        attribution: "",
        numZoomLevels: 18
    }));

    map.addLayer(new OpenLayers.Layer.OSM.Mapnik("OSM Mapnik"));
    map.addLayer(new OpenLayers.Layer.OSM.CycleMap("OSM CycleMap"));
    map.addLayer(new OpenLayers.Layer.OSM("OSM Hike&Bike", ["http://a.www.toolserver.org/tiles/hikebike/${z}/${x}/${y}.png", "http://b.www.toolserver.org/tiles/hikebike/${z}/${x}/${y}.png"], {
        numZoomLevels: 18
    }));
    map.addLayer(new OpenLayers.Layer.OSM("Mapquest Satellite", ["http://mtile01.mqcdn.com/tiles/1.0.0/vy/sat/${z}/${x}/${y}.png", "http://mtile02.mqcdn.com/tiles/1.0.0/vy/sat/${z}/${x}/${y}.png"], {
        numZoomLevels: 19
    }));

    var epsg4326 = new OpenLayers.Projection("EPSG:4326");
    var bounds;

    // read from input, back button pressed?
    if (check_lat_form(1)) {
        bounds = new OpenLayers.Bounds($("#sw_lng").val(), $("#sw_lat").val(), $("#ne_lng").val(), $("#ne_lat").val());
    }

    // default city
    else {
        bounds = new OpenLayers.Bounds(config.sw[0], config.sw[1], config.ne[0], config.ne[1]);
    }

    bounds.transform(epsg4326, map.getProjectionObject());
    map.zoomToExtent(bounds);

    if (!map.getCenter()) {
        alert("foo");
        var lonLat = new OpenLayers.LonLat(lon, lat).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
        map.setCenter(lonLat, zoom);
    }

    osm_init();
}

function osm_init() {
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

    function validateControls() {
        var bounds = new OpenLayers.Bounds($("#sw_lng").val(), $("#sw_lat").val(), $("#ne_lng").val(), $("#ne_lat").val());

        var skm = square_km($("#sw_lat").val(), $("#sw_lng").val(), $("#ne_lat").val(), $("#ne_lng").val());
        if ($("#square_km")) {
            var html = "area covers " + large_int(skm) + " square km";
            if (config.show_filesize) {
                html += show_filesize(skm);
            }
            $("#square_km").html(html);
        }

        if (skm > config.max_skm) {
            $("#export_osm_too_large").show();
        } else {
            $("#export_osm_too_large").hide();
        }
    }

    function show_filesize(skm) {
        var size = skm / 1000;
        var format = $("select[name=format] option:selected").val();

        var factor = 1; // PBF
        if (format == "osm.gz") {
            factor = 2;
        } else if (format == "osm.bz2") {
            factor = 1.5;
        } else if (format == "osm.xz") {
            factor = 1.3;
        }

        return ", approx. " + Math.floor(factor * size * 0.75) + "-" + Math.ceil(factor * size * 2) + " MB OSM data";
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

    startExport();
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
            if (e.name == "city") continue;

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
