// (c) 2007,2013 Slaven Rezic. All rights reserved.

// NOTE: this is duplicated in newstreetform.tpl.html
function get_and_set_email_author_from_cookie(frm) {
  if (document.cookie) {
    var cookies = document.cookie.split(/;\s*/);
    for (var i=0; i<cookies.length; i++) {
      if (cookies[i].match(/^mapserver_comment=(.*)/)) {
        var arr = RegExp.$1.split("&");
        for(var j=0; j<arr.length/2; j++) {
          var key = arr[j*2];
	  var val = arr[j*2+1];
	  val = val.replace(/%40/g, "@");
	  val = val.replace(/%20/g, " ");
  	  if (key == "email" || key == "author") {
	    frm.elements[key].value = val;
	  }
  	}
	break;
      }
    }
  }
}


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

// Local variables:
// c-basic-offset: 2
// End:
// From http://jan.moesen.nu/
// Found at http://jan.moesen.nu/code/javascript/sprintf-and-printf-in-javascript/

function sprintf()
{
    if (!arguments || arguments.length < 1 || !RegExp)
    {
	return;
    }
    var str = arguments[0];
    var re = /([^%]*)%('.|0|\x20)?(-)?(\d+)?(\.\d+)?(%|b|c|d|u|f|o|s|x|X)(.*)/; // '
    var a = b = [], numSubstitutions = 0, numMatches = 0;
    while (a = re.exec(str))
    {
	var leftpart = a[1], pPad = a[2], pJustify = a[3], pMinLength = a[4];
	var pPrecision = a[5], pType = a[6], rightPart = a[7];
	
	//alert(a + '\n' + [a[0], leftpart, pPad, pJustify, pMinLength, pPrecision);

	numMatches++;
	if (pType == '%')
	{
	    subst = '%';
	}
	else
	{
	    numSubstitutions++;
	    if (numSubstitutions >= arguments.length)
	    {
		alert('Error! Not enough function arguments (' + (arguments.length - 1) + ', excluding the string)\nfor the number of substitution parameters in string (' + numSubstitutions + ' so far).');
	    }
	    var param = arguments[numSubstitutions];
	    var pad = '';
	    if (pPad && pPad.substr(0,1) == "'") pad = leftpart.substr(1,1);
	    else if (pPad) pad = pPad;
	    var justifyRight = true;
	    if (pJustify && pJustify === "-") justifyRight = false;
	    var minLength = -1;
	    if (pMinLength) minLength = parseInt(pMinLength);
	    var precision = -1;
	    if (pPrecision && pType == 'f') precision = parseInt(pPrecision.substring(1));
	    var subst = param;
	    if (pType == 'b') subst = parseInt(param).toString(2);
	    else if (pType == 'c') subst = String.fromCharCode(parseInt(param));
	    else if (pType == 'd') subst = parseInt(param) ? parseInt(param) : 0;
	    else if (pType == 'u') subst = Math.abs(param);
	    else if (pType == 'f') subst = (precision > -1) ? Math.round(parseFloat(param) * Math.pow(10, precision)) / Math.pow(10, precision): parseFloat(param);
	    else if (pType == 'o') subst = parseInt(param).toString(8);
	    else if (pType == 's') subst = param;
	    else if (pType == 'x') subst = ('' + parseInt(param).toString(16)).toLowerCase();
	    else if (pType == 'X') subst = ('' + parseInt(param).toString(16)).toUpperCase();
	}
	str = leftpart + subst + rightPart;
    }
    return str;
}
