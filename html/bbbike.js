
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
       // callback(request.responseXML, request.status);

       // JSON
       callback(request.responseText, request.status);

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
    var url = 'weather.cgi?lat=' + weather.lat + '&lng=' + weather.lng + '&city=' + weather.city;

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

	if (!js.weatherObservation) {
	    return; // no weather
	}
	var w = js.weatherObservation;	

	if (w.temperature == 0 && w.dewPoint == 0 && w.humidity == 100) {
	   // broken data, ignore
	   return;
        }

	var message = w.temperature + " &deg;C";

	if (w.clouds && w.clouds.substring(0, 2) != "n/") {
	   message += ", " + w.clouds;
	}

	if (w.wind > 0) {
	   message += ', max. wind speed ' + parseInt(w.wind) + "m/s";
	}

	var span = document.getElementById("current_weather");
	if (span) {
		span.innerHTML = message;
	}
}

// find a city and increase font size and set focus
function higlightCity (city) {
    city =  "C_" + city;

    var a = document.getElementsByTagName("a");
    var focus;
    for (var i=0; i<a.length; i++) {
        if (a[i].className == city) {
            a[i].style.fontSize = "200%";
            focus = a[i];
        }
    }

    // wait until the page loaded
    setTimeout(function() { if (focus) { focus.focus(); }}, 300 );
}

