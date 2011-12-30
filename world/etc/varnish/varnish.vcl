# This is a basic VCL configuration file for varnish.  See the vcl(7)
# man page for details on VCL syntax and semantics.
# 
# Default backend definition.  Set this to point to your content
# server.
# 
backend default {
    .host = "10.0.0.1";
    .port = "80";
}

backend tile {
    #.host = "10.0.0.5";
    .host = "tile";
    .port = "80";

    .first_byte_timeout = 600s;
    .connect_timeout = 600s;
    .between_bytes_timeout = 600s;

    #.probe = {
    #    .url = "/test.txt";
    #    .timeout = 2s;
    #    .interval = 10s;
    #    .window = 1;
    #    .threshold = 1;
    #}
}

backend bbbike {
    .host = "bbbike";
    .port = "80";
    .first_byte_timeout = 300s;
    .connect_timeout = 300s;
    .between_bytes_timeout = 300s;

    .probe = {
        .url = "/test.txt";
        .timeout =  1s;
        .interval = 30s;
        .window = 1;
        .threshold = 1;
    }
}

backend eserte {
    .host = "eserte";
    .port = "80";
    .first_byte_timeout = 300s;
    .connect_timeout = 300s;
    .between_bytes_timeout = 300s;
}

backend slaven {
    .host = "slaven";
    .port = "80";
    .first_byte_timeout = 300s;
    .connect_timeout = 300s;
    .between_bytes_timeout = 300s;
}

/*
backend eserte_devel {
    .host = "eserte";
    .port = "88";
    .first_byte_timeout = 300s;
    .connect_timeout = 300s;
    .between_bytes_timeout = 300s;
}
*/


# munin
backend localhost {
    .host = "localhost";
    .port = "8080";
}

backend bbbike_strato {
    .host = "test.bbbike.org";
    .port = "80";
    .first_byte_timeout = 300s;
    .connect_timeout = 300s;
    .between_bytes_timeout = 300s;

    .probe = {
        .url = "/test.txt";
        .timeout = 2s;
        .interval = 30s;
        .window = 1;
        .threshold = 1;
    }
}

sub vcl_recv {
    ######################################################################
    # backend config
    #

    # munin statistics
    if (req.http.host ~ "^dev[23]?\.bbbike\.org$" && req.url ~ "^/munin") {
        set req.backend = localhost;
    } else if (req.http.host ~ "^download[23]?\.bbbike\.org$") {
        set req.backend = bbbike;
    } else if (req.http.host ~ "^(m\.|www[23]?\.|dev[23]?\.|devel[23]?\.|)bbbike\.org$") {
        set req.backend = bbbike;

        # failover production @ strato 
        if (req.restarts == 1 || !req.backend.healthy) {
                set req.backend = bbbike_strato;
        }
    } else if (req.http.host ~ "^eserte\.bbbike\.org$" || req.http.host ~ "^.*bbbike\.de$") {
        set req.backend = eserte;
    } else if (req.http.host ~ "^eserte-devel\.bbbike\.org$" || req.http.host ~ "^.*dev.*bbbike\.de$" ) {
        set req.backend = slaven;
    } else if (req.http.host ~ "^([a-f]\.)?tile\.bbbike\.org$") {
        set req.backend = tile;
    } else if (req.http.host ~ "^([u-z])\.tile\.bbbike\.org$") {
        set req.backend = tile;
    } else {
        set req.backend = bbbike;
    }

    # dummy
    if (req.http.host ~ "foobar") {
        set req.backend = bbbike;
    }

    # log real IP address in backend
    if (req.http.x-forwarded-for) {
       set req.http.X-Forwarded-For =
           req.http.X-Forwarded-For ", " client.ip;
    } else {
       set req.http.X-Forwarded-For = client.ip;
    }

    ######################################################################
    # backends without caching, pipe/pass

    # do not cache OSM files
    if (req.http.host ~ "^(download[23]?)\.bbbike\.org$") {
         return (pipe);
    }

    # development machine of S.R.T
    if (req.http.host ~ "^eserte.*\.bbbike\.org$" || req.http.host ~ "^.*bbbike\.de$") {
	return (pass);
    }


    # not invented here
    if (req.http.host !~ "\.bbbike\.org$") {
	return (pass);
    }

    ######################################################################
    # force caching of images and CSS/JS files
    if (req.url ~ "^/html|^/images|^/feed/|^/osp/|^/cgi/[ac-z]|.*\.html$|.*/$|^/osm/") {
       unset req.http.cookie;
       unset req.http.Accept-Encoding;
       unset req.http.User-Agent;
       unset req.http.referer;
    }

    # override page reload requests from impatient users
    if (  req.http.Cache-Control ~ "no-cache" 
       || req.http.Cache-Control ~ "private"
       || req.http.Cache-Control ~ "max-age=0") {

      set req.http.Cache-Control = "max-age=240";
      #unset req.http.Expires;
    }

    # pipeline post requests trac #4124 
    if (req.request == "POST") {
	return (pass);
    }

    # test & development, no caching
    if (req.http.host ~ "^(dev|devel)[23]?\.bbbike\.org$") {
	return (pass);
    }

    # cache just by major browser type
    call normalize_user_agent;
    set req.http.User-Agent = req.http.X-UA;

    if (req.http.host ~ "^([a-z]\.)?tile\.bbbike\.org") { return (pass); } # no cache

    return (lookup);
}

sub vcl_hash {
    # cache requests with cookies in mind
    set req.hash += req.http.cookie;
}

sub vcl_fetch {
    #return (pass);

    #if (req.url ~ "^/html|^/images|^/feed/|.*\.html$|.*/$") {
    #   unset beresp.http.cookie;
    #}

    if (!beresp.cacheable) {
         return (pass);
    }

    return (deliver);

    #unset beresp.http.set-cookie;
    #if (beresp.http.Set-Cookie) {
    #    return (pass);
    #}
    #return (deliver);
}

sub vcl_pipe {
    /* Force the connection to be closed afterwards so subsequent reqs don't use pipe */
    set bereq.http.connection = "close";
}

# We're only interested in major categories, not versions, etc...
sub normalize_user_agent {
    if (req.http.user-agent ~ "MSIE 6") {
        set req.http.X-UA = "MSIE 6";
    } else if (req.http.user-agent ~ "MSIE 7") {
        set req.http.X-UA = "MSIE 7";
    } else if (req.http.user-agent ~ "iPhone|Android|iPod|Nokia|Symbian|BlackBerry|SonyEricsson") {
        set req.http.X-UA = "Mobile";
    } else {
        set req.http.X-UA = "";
    }
}

# 
# Below is a commented-out copy of the default VCL logic.  If you
# redefine any of these subroutines, the built-in logic will be
# appended to your code.
# 
# sub vcl_recv {
#     if (req.http.x-forwarded-for) {
# 	set req.http.X-Forwarded-For =
# 	    req.http.X-Forwarded-For ", " client.ip;
#     } else {
# 	set req.http.X-Forwarded-For = client.ip;
#     }
#     if (req.request != "GET" &&
#       req.request != "HEAD" &&
#       req.request != "PUT" &&
#       req.request != "POST" &&
#       req.request != "TRACE" &&
#       req.request != "OPTIONS" &&
#       req.request != "DELETE") {
#         /* Non-RFC2616 or CONNECT which is weird. */
#         return (pipe);
#     }
#     if (req.request != "GET" && req.request != "HEAD") {
#         /* We only deal with GET and HEAD by default */
#         return (pass);
#     }
#     if (req.http.Authorization || req.http.Cookie) {
#         /* Not cacheable by default */
#         return (pass);
#     }
#     return (lookup);
# }
# 
# sub vcl_pipe {
#     # Note that only the first request to the backend will have
#     # X-Forwarded-For set.  If you use X-Forwarded-For and want to
#     # have it set for all requests, make sure to have:
#     # set req.http.connection = "close";
#     # here.  It is not set by default as it might break some broken web
#     # applications, like IIS with NTLM authentication.
#     return (pipe);
# }
# 
# sub vcl_pass {
#     return (pass);
# }
# 
# sub vcl_hash {
#     set req.hash += req.url;
#     if (req.http.host) {
#         set req.hash += req.http.host;
#     } else {
#         set req.hash += server.ip;
#     }
#     return (hash);
# }
# 
# sub vcl_hit {
#     if (!obj.cacheable) {
#         return (pass);
#     }
#     return (deliver);
# }
# 
# sub vcl_miss {
#     return (fetch);
# }
# 
# sub vcl_fetch {
#     if (!beresp.cacheable) {
#         return (pass);
#     }
#     if (beresp.http.Set-Cookie) {
#         return (pass);
#     }
#     return (deliver);
# }
# 
# sub vcl_deliver {
#     return (deliver);
# }
# 
# sub vcl_error {
#     set obj.http.Content-Type = "text/html; charset=utf-8";
#     synthetic {"
# <?xml version="1.0" encoding="utf-8"?>
# <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
#  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
# <html>
#   <head>
#     <title>"} obj.status " " obj.response {"</title>
#   </head>
#   <body>
#     <h1>Error "} obj.status " " obj.response {"</h1>
#     <p>"} obj.response {"</p>
#     <h3>Guru Meditation:</h3>
#     <p>XID: "} req.xid {"</p>
#     <hr>
#     <p>Varnish cache server</p>
#   </body>
# </html>
# "};
#     return (deliver);
# }
