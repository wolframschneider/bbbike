
/*************************************************
 * utils
 *
 */

/* http://gmaps-samples-v3.googlecode.com/svn/trunk/xmlparsing/downloadurl.html */
/**
* Returns an XMLHttp instance to use for asynchronous
* downloading. This method will never throw an exception, but will
* return NULL if the browser does not support XmlHttp for any reason.
* @return {XMLHttpRequest|Null}
*/
function createXmlHttpRequest() {
 try {
   if (typeof ActiveXObject != 'undefined') {
     return new ActiveXObject('Microsoft.XMLHTTP');
   } else if (window["XMLHttpRequest"]) {
     return new XMLHttpRequest();
   }
 } catch (e) {
   // alert(e);
 }
 return null;
};

/**
* This functions wraps XMLHttpRequest open/send function.
* It lets you specify a URL and will call the callback if
* it gets a status code of 200.
* @param {String} url The URL to retrieve
* @param {Function} callback The function to call once retrieved.
*/
function downloadUrl(url, callback) {
 var status = -1;
 var request = createXmlHttpRequest();
 if (!request) {
   return false;
 }

 request.onreadystatechange = function() {
   if (request.readyState == 4) {
     try {
       status = request.status;
     } catch (e) {
       // Usually indicates request timed out in FF.
     }

     if (status == 200) {
	if (request.getResponseHeader("Content-Type").match("/xml")) {
            callback(request.responseXML, request.status);
	} else {
          // JSON
           callback(request.responseText, request.status);
        }

       request.onreadystatechange = function() {};
     }
   }
 }

 request.open('GET', url, true);
 try {
   request.send(null);
 } catch (e) {
   // alert(e);
 }
};


/*************************************************
 * weather
 *
 */

function display_current_weather ( weather ) {
    // var url = 'http://ws.geonames.org/findNearByWeatherJSON?lat=' + lat + '&lng=' + lng;
    var url = '/cgi/weather.cgi?lat=' + weather.lat + '&lng=' + weather.lng + '&city=' + weather.city;

    if (weather.lang && weather.lang != "") {
	url += '&lang=' + weather.lang;
    }

    downloadUrl(url, function(data, responseCode) {
	if(responseCode == 200) {
            updateWeather(data);
        } else if(responseCode == -1) {
           alert("Data request timed out. Please try later.");
        } else {
            alert("Request resulted in error. Check XML file is retrievable.");
        }
    });
}

function updateWeather (data) {
	if (!data || data == "") {
		return;
	}

	// var js =  {"weatherObservation":{"clouds":"few clouds","weatherCondition":"n/a","observation":"LFSB 242100Z VRB03KT 9999 FEW040 14/13 Q1019 NOSIG","ICAO":"LFSB","elevation":271,"countryCode":"FR","lng":7.51666666666667,"temperature":"14","dewPoint":"13","windSpeed":"03","humidity":93,"stationName":"Bale-Mulhouse","datetime":"2010-08-24 21:00:00","lat":47.6,"hectoPascAltimeter":1019}};

	// invalid label bug
	var js = eval(  "(" + data + ")" );

	if (!js.weather || !js.weather.weatherObservation) {
	    return; // no weather
	}
	var w = js.weather.weatherObservation;	

	if (w.temperature == 0 && w.dewPoint == 0 && w.humidity == 100) {
	   // broken data, ignore
	   return;
        }

	var message = w.temperature + " &deg;C";

	if (w.clouds && w.clouds.substring(0, 2) != "n/") {
	   message += ", " + w.clouds;
	}

	if (w.windSpeed > 0) {
	   message += ', max. wind ' + parseInt(w.windSpeed, 10) + "m/s";
	}

	var span = document.getElementById("current_weather");
	if (span) {
		span.innerHTML = message;
	}

	span = document.getElementById("weather_forecast");
	if (span) {
		message = renderWeatherForecast( js.forecast );
	        if (message == "") {
		   message = ": no data available";
	        }
		span.innerHTML = message;
	}
}

function renderWeatherForecast( js ) {
	if (!js || js == "" || !js.weather) { return ""; }

	return google_weather(js);
}

// find a city and increase font size and set focus
function higlightCity (data, obj) {
    var pos = eval(  "(" + data + ")" );
    if (!pos || pos.city == "NO_CITY") {
	return;
    }

    var className =  "C_" + pos.city;

    var a = document.getElementsByTagName("a");
    var focus;
    for (var i=0; i<a.length; i++) {
        if (a[i].className == className) {
            a[i].style.fontSize = "200%";
            a[i].style.color = "#00f";

            a[i].setAttribute('title', pos.city + " " + obj.lat + "," + obj.lng);
            focus = a[i];
        }
    }

    // wait until the page loaded
    var body = document.getElementsByTagName("body");
    if (body && focus) {
    	body.onload = focus.focus();
    }
}

var currentPosition;
function geoCity (obj) {
    // "13.3888548", "52.5170397";
    // "-123.1333301", "49.2499987"
    if (!obj || obj.lng == undefined || obj.lat == undefined) {
	return;
    }

    var url = 'cgi/location.cgi?lng=' + obj.lng + '&lat=' + obj.lat;
	
    downloadUrl(url, function(data, responseCode) {
        if(responseCode == 200) {
            higlightCity(data, obj);
        } else if(responseCode == -1) {
           alert("Data request timed out. Please try later.");
        } else {
            alert("Request resulted in error. Check XML file is retrievable.");
        }
    });
}

function focusCity () {
    if (!navigator.geolocation) {
	return;
    }

    navigator.geolocation.getCurrentPosition(function(position) {  
	currentPosition = { "lat": position.coords.latitude, "lng": position.coords.longitude };
        geoCity(currentPosition);
   });  
}

function google_weather (w) {
	  var unit = w.weather.forecast_information ? w.weather.forecast_information.unit_system.data : "";
	  var html = "";
          var display_city_name = 1;

	  // Fahrenheit -> Celcius
	  function celcius(temp) {
	    if (unit == "US") {
		var t = (temp - 32) / 1.8;
	        return parseInt(t + 0.5, 10);
	    }
	    return temp;
	  }

	  var f = w.weather.current_conditions;
	  // give up
	  if (!f) {
		return html;
	  }

	if (display_city_name) {
	   html += '\n<span id="weather_city">';
	   if (w.weather.forecast_information && w.weather.forecast_information.city) {
		html += "<b>" + w.weather.forecast_information.city.data + "</b>";
		html += " :  " + w.weather.forecast_information.forecast_date.data;
	   }
	   html += '</span>';
	}

   	  html +=
   '<div id="weatherSection" class="marginLeft">' +
     '<div style="font-size: 0.8em;" class="roundCorner floatLeft" id="googleWeather">' +
      '<div style="padding: 5px; float: left;">' +
        '<div style="font-size: 140%;">' + '<b>' + f.temp_c.data + '°C' + '</b>' + 
        '</div>' +
        '<div>' +
        '<b>' + f.condition.data +'</b><br />' + f.wind_condition.data +'<br />' + f.humidity.data +'<br />' +
        '</div>' +
      '</div>';

	  function plot (f) {
		var html = '' +
      		  '<div style="padding: 5px; float: left;" align="center">';
		if (f.day_of_week) {
			html += f.day_of_week.data;
		}
		html += '<br />' +
        	   '<img style="border: 1px solid rgb(187, 187, 204); margin-bottom: 2px;" src="http://www.google.com' + 
		   f.icon.data + '" alt="' + f.condition.data + '" title="' + f.condition.data + '" /><br />';
		if (f.high) {
        	   html += '<nobr>' + celcius(f.high.data) + '°C | ' + celcius(f.low.data) +'°C</nobr>';
		}
      		html += '</div>';

		return html;
	  }

	html += plot( w.weather.current_conditions );

	var days = w.weather.forecast_conditions;
	for(var i = 0; i< days.length; i++) {
		html += plot (days[i]) ;
	}
 
        html += '</div><br class="clear" />'; 
        html += '</div>';


        return html;
}

