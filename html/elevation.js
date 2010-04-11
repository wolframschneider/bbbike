/*
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
*/

  var map = null;
  var chart = null;
  
  var geocoderService = null;
  var elevationService = null;
  var directionsService = null;
  
  var mousemarker = null;
  var markers = [];
  var polyline = null;
  var elevations = null;
  
  var SAMPLES = 500;

  var examples = [{
    // Lombard St
    latlngs: [
      [37.801000, -122.426499],
      [37.802051, -122.419418],
      [37.802729, -122.413989]
    ],
    mapType: google.maps.MapTypeId.ROADMAP,
    travelMode: 'driving'
  },{
    // Mount Everest
    latlngs: [
      [27.973323, 86.908035],
      [28.020614, 86.960906]
    ],
    mapType: google.maps.MapTypeId.TERRAIN,
    travelMode: 'direct'
  },{
    // Challenger Deep
    latlngs: [
      [9.764009, 143.076632],
      [11.932658, 142.373507]
    ],
    mapType: google.maps.MapTypeId.ROADMAP,
    travelMode: 'direct'
  },{
    // foo
    latlngs: [
[47.5330135, 7.5961233],
[47.5326773, 7.5950625],
[47.527827, 7.5934769],
[47.5278511, 7.5932459],
[47.5267379, 7.5928775],
[47.5265623, 7.5900035],
[47.5265499, 7.5831392],
[47.5265782, 7.5829547],
[47.5268494, 7.5769051],

[47.5255186, 7.5751377],
[47.5259637, 7.5731076],
[47.5260581, 7.5731978],
[47.5263555, 7.5720822],
[47.5242266, 7.5706058],
[47.5254983, 7.5687585],

    ],
    mapType: google.maps.MapTypeId.ROADMAP,
    travelMode: 'direct'
  },{
    // Challenger Deep
    latlngs: [

[43.3136402, 5.3680144],
[43.3123856, 5.3687901],
[43.3071048, 5.3753099],
[43.3097707, 5.3796441],
[43.3106952, 5.3836872],
[43.311376, 5.3842623],
[43.3110912, 5.3862168],
[43.3115613, 5.3881206],
[43.309315, 5.390588],
[43.3060543, 5.393409],
[43.305968, 5.3936406],
[43.3066189, 5.3946627],
[43.3055532, 5.3980431],
[43.3061815, 5.3995109],
[43.3067889, 5.39969],
[43.3082563, 5.400965],
[43.3079282, 5.4019581],
[43.3078316, 5.4018697],
[43.3071255, 5.40862],
[43.3062988, 5.4098022],
[43.3054961, 5.4102716],
[43.3051607, 5.4095909],
[43.304669, 5.4102806],
[43.3048782, 5.4106096],
[43.304945, 5.4120598],
[43.3041957, 5.4121212],
[43.3043388, 5.4138052],
[43.3039348, 5.4187127],
[43.3037338, 5.4192019],
[43.3040248, 5.4225599],
[43.3032311, 5.4496462],
[43.3030345, 5.4520411],
[43.3014697, 5.4574281],
[43.3002063, 5.4769171],
[43.2893539, 5.4965152],
[43.2868045, 5.5141309],
[43.2854258, 5.5540415],
[43.2860006, 5.5551744],
[43.2877792, 5.5812209],
[43.2874726, 5.5826565],
[43.2872775, 5.5830016],
[43.286235, 5.5874039],
[43.2917601, 5.5878209],
[43.2929885, 5.593981],
    ],
    mapType: google.maps.MapTypeId.ROADMAP,
    travelMode: 'direct'
  },{
    // Death Valley
    latlngs: [
      [37.040952, -117.300314],
      [35.896862, -116.654868],
      [35.972751, -116.270689]
    ],
    mapType: google.maps.MapTypeId.TERRAIN,
    travelMode: 'driving'
  },{
    // Grand Canyon
    latlngs: [
      [36.012196, -112.100348],
      [36.221866, -112.098975],
    ],
    mapType: google.maps.MapTypeId.TERRAIN,
    travelMode: 'direct'
  },{
    // Uluru
    latlngs: [
      [-25.34696, 131.022323],
      [-25.34060, 131.045927]
    ],
    mapType: google.maps.MapTypeId.SATELLITE,
    travelMode: 'direct'
  }];

  // Load the Visualization API and the piechart package.
  google.load("visualization", "1", {packages: ["columnchart"]});
  
  // Set a callback to run when the Google Visualization API is loaded.
  google.setOnLoadCallback(initialize);
  
  function initialize() {
    var myLatlng = new google.maps.LatLng(15, 0);
    var myOptions = {
      zoom: 1,
      center: myLatlng,
      mapTypeId: google.maps.MapTypeId.TERRAIN
    }

    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
    chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
    
    geocoderService = new google.maps.Geocoder();
    elevationService = new google.maps.ElevationService();
    directionsService = new google.maps.DirectionsService();
    
    google.maps.event.addListener(map, 'click', function(event) {
      addMarker(event.latLng, true);
    });
    
    google.visualization.events.addListener(chart, 'onmouseover', function(e) {
      if (mousemarker == null) {
        mousemarker = new google.maps.Marker({
          position: elevations[e.row].location,
          map: map,
          icon: "http://maps.google.com/mapfiles/ms/icons/green-dot.png"
        });
      } else {
        mousemarker.setPosition(elevations[e.row].location);
      }
    });

    loadExample(4);
  }
  
  // Takes an array of ElevationResult objects, draws the path on the map
  // and plots the elevation profile on a GViz ColumnChart
  function plotElevation(results) {
    elevations = results;
    
    var path = [];
    for (var i = 0; i < results.length; i++) {
      path.push(elevations[i].location);
    }
    
    if (polyline) {
      polyline.setMap(null);
    }
    
    polyline = new google.maps.Polyline({
      path: path,
      strokeColor: "#000000",
      map: map});
    
    var data = new google.visualization.DataTable();
    data.addColumn('string', 'Sample');
    data.addColumn('number', 'Elevation');
    for (var i = 0; i < results.length; i++) {
      data.addRow(['', elevations[i].elevation]);
    }

    document.getElementById('chart_div').style.display = 'block';
    chart.draw(data, {
      width: 512,
      height: 200,
      legend: 'none',
      titleY: 'Elevation (m)',
      focusBorderColor: '#00ff00'
    });
  }
  
  // Remove the green rollover marker when the mouse leaves the chart
  function clearMouseMarker() {
    if (mousemarker != null) {
      mousemarker.setMap(null);
      mousemarker = null;
    }
  }
  
  // Geocode an address and add a marker for the result
  function addAddress() {
    var address = document.getElementById('address').value;
    geocoderService.geocode({ 'address': address }, function(results, status) {
      document.getElementById('address').value = "";
      if (status == google.maps.GeocoderStatus.OK) {
        var latlng = results[0].geometry.location;
        addMarker(latlng, true);
        if (markers.length > 1) {
          var bounds = new google.maps.LatLngBounds();
          for (var i in markers) {
            bounds.extend(markers[i].getPosition());
          }
          map.fitBounds(bounds);
        } else {
          map.fitBounds(results[0].geometry.viewport);
        }
      } else if (status == google.maps.GeocoderStatus.ZERO_RESULTS) {
        alert("Address not found");
      } else {
        alert("Address lookup failed");
      }
    })
  }
  
  // Add a marker and trigger recalculation of the path and elevation
  function addMarker(latlng, doQuery) {
    if (markers.length < 50) {
      
      var marker = new google.maps.Marker({
        position: latlng,
        map: map,
        draggable: true
      })
      
      google.maps.event.addListener(marker, 'dragend', function(e) {
        updateElevation();
      });
      
      markers.push(marker);
      
      if (doQuery) {
        updateElevation();
      }
      
      if (markers.length == 50) {
        document.getElementById('address').disabled = true;
      }
    } else {
      alert("No more than 50 points can be added");
    }
  }
  
  // Trigger the elevation query for point to point
  // or submit a directions request for the path between points
  function updateElevation() {
    if (markers.length > 1) {
      var travelMode = 'direct'; // document.getElementById("mode").value;
      if (travelMode != 'direct') {
        calcRoute(travelMode);
      } else {
        var latlngs = [];
        for (var i in markers) {
          latlngs.push(markers[i].getPosition())
        }
	/*
        elevationService.getElevationForLocations({
          locations: latlngs,
        }, plotElevation);
	*/

        elevationService.getElevationAlongPath({
          path: latlngs,
          samples: SAMPLES
        }, plotElevation);

      }
    }
  }
  
  // Submit a directions request for the path between points and an
  // elevation request for the path once returned
  function calcRoute(travelMode) {
    var origin = markers[0].getPosition();
    var destination = markers[markers.length - 1].getPosition();
    
    var waypoints = [];
    for (var i = 1; i < markers.length - 1; i++) {
      waypoints.push({
        location: markers[i].getPosition(),
        stopover: true
      });
    }
    
    var request = {
      origin: origin,
      destination: destination,
      waypoints: waypoints
    };
   
    switch (travelMode) {
      case "bicycling":
        request.travelMode = google.maps.DirectionsTravelMode.BICYCLING;
        break;
      case "driving":
        request.travelMode = google.maps.DirectionsTravelMode.DRIVING;
        break;
      case "walking":
        request.travelMode = google.maps.DirectionsTravelMode.WALKING;
        break;
    }
    
    directionsService.route(request, function(response, status) {
      if (status == google.maps.DirectionsStatus.OK) {
        elevationService.getElevationAlongPath({
          path: response.routes[0].overview_path,
          samples: SAMPLES
        }, plotElevation);
      } else if (status == google.maps.DirectionsStatus.ZERO_RESULTS) {
        alert("Could not find a route between these points");
      } else {
        alert("Directions request failed");
      }
    });
  }

  // Trigger a geocode request when the Return key is
  // pressed in the address field
  function addressKeyHandler(e) {
    var keycode;
    if (window.event) {
      keycode = window.event.keyCode;
    } else if (e) {
      keycode = e.which;
    } else {
      return true;
    }
    
    if (keycode == 13) {
       addAddress();
       return false;
    } else {
       return true;
    }
  }
  
  function loadExample(n) {
    reset();
    map.setMapTypeId(examples[n].mapType);
    // document.getElementById('mode').value = examples[n].travelMode;
    var bounds = new google.maps.LatLngBounds();
    for (var i = 0; i < examples[n].latlngs.length; i++) {
      var latlng = new google.maps.LatLng(
        examples[n].latlngs[i][0],
        examples[n].latlngs[i][1]
      );
      addMarker(latlng, false);
      bounds.extend(latlng);
    }
    map.fitBounds(bounds);
    updateElevation();
  }
  
  // Clear all overlays, reset the array of points, and hide the chart
  function reset() {
    if (polyline) {
      polyline.setMap(null);
    }
    
    for (var i in markers) {
      markers[i].setMap(null);
    }
    
    markers = [];
    
    document.getElementById('chart_div').style.display = 'none';
  }

/*
<body>
  <div style="width: 512px; text-align: center">Add points by clicking on the map or entering an address</div>
  <div id="map_canvas" style="border: 1px solid black; width:512px; height:400px"></div>
  <table style="width:512px;">
  <tr>
    <td>Address: <input type="text" id="address" size="15" onkeypress="return addressKeyHandler(event)"/></td>
    <td style="text-align: center">
      Mode of travel:
      <select id="mode" onchange="updateElevation()">
        <option value="direct">Direct</option>
        <option value="driving">Driving</option>
        <option value="bicycling">Bicycling</option>
        <option value="walking">Walking</option>
      </select>
    </td>
    <td style="text-align: right">
      <input type="button" value="Clear points" onclick="reset()"/>
    </td>
  </tr>
  </table>
  <table style="width:512px; font-size: small;">
    <tr>
      <td style="text-align: center"><a href="#" onclick="loadExample(1); return false">Mount Everest</a></td>
      <td style="text-align: center"><a href="#" onclick="loadExample(2); return false">Challenger Deep</a></td>
      <td style="text-align: center"><a href="#" onclick="loadExample(3); return false">Basel</a></td>
      <td style="text-align: center"><a href="#" onclick="loadExample(4); return false">Marseille</a></td>
    </tr>
  </table>
  <div id="chart_div" style="width:512px; height:200px" onmouseout="clearMouseMarker()"></div>
</body>
</html>
*/

