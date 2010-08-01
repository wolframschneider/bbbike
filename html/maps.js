
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
                var iframe_dom = 1;

                // change URL for iframe map
                if (!iframe_dom) {
                var url = $("div#streetmap2").text() + ";street=" + street;
                var oldIframeURL = $("iframe#iframemap").attr("src");
                if (oldIframeURL != url) {
                        $("div#streetmap").text(street);
                        $("iframe#iframemap").attr("src",  url);
                } else {
                        $("div#streetmap").text(street + " no update: " );
                }

                // manipulate the iframe source code
                } else {
                    var js_div = $("div#BBBikeGooglemap").contents().find("div#street");
                    if (js_div) {
                        getStreet(map, street);
                    }
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


