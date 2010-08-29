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
	var message = '';

	// invalid label bug
	var js = eval(  "(" + data + ")" );

	var temperature = js["weatherObservation"]["temperature"];
	if (temperature == 0 && js["weatherObservation"]["dewPoint"] == 0 && js["weatherObservation"]["humidity"] == 100) {
	   // broken data, ignore
	   return;
        }

	message += temperature + " &deg;C";
	var clouds = js["weatherObservation"]["clouds"];
	if (clouds && clouds.substring(0, 2) != "n/") {
	   message += ", " + clouds;
	}

	var wind = parseInt( js["weatherObservation"]["windSpeed"] );
	if (wind > 0) {
	   message += ', max. wind speed ' + wind + "m/s";
	}

	var span = document.getElementById("current_weather");
	if (span) {
		span.innerHTML = message;
	}
}

