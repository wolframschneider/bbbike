#!/usr/bin/perl

use CGI qw/-utf-8/;

use IO::File;
use JSON;
use Data::Dumper;

use strict;
use warnings;

my $logfile = '/var/log/lighttpd/bbbike.error.log';

my $q     = new CGI;
my $max   = 100;
my $debug = 1;

my $city_center;

# extract URLs from web server error log
sub extract_route {
    my $file = shift;
    my $max  = shift;

    my @data;
    my %hash;
    my @files = ( "$file.1.gz", $file );
    unshift( @files, "$file.3.gz", "$file.2.gz" ) if $max > 100;

    foreach my $file (@files) {
        next if !-f $file;

        my $fh;
        if ( $file =~ /\.gz$/ ) {
            open( $fh, "gzip -dc $file |" ) or die "open $file: $!\n";
        }
        else {
            open( $fh, $file ) or die "open $file: $!\n";
        }

        while (<$fh>) {
            next if !/ slippymap.cgi: /;
            next if !/coords/;

            my @list = split;
            my $url  = pop(@list);

            next if exists $hash{$url};
            push( @data, $url );
            $hash{$url} = 1;

            # limit number of URLs
            if ( scalar(@data) > $max ) {
                $url = shift @data;
                undef $hash{$url};
            }
        }
        close $fh;
    }

    return @data;
}

sub footer {
    return <<EOF;
<div id="footer">
<div id="footer_top">
<a href="../">home</a> 
</div>
</div>
<hr>

<div id="copyright" style="text-align: center; font-size: x-small; margin-top: 1em;" >
(&copy;) 2008-2010 <a href="http://www.rezic.de/eserte">Slaven Rezi&#x107;</a> &amp; <a href="http://wolfram.schneider.org">Wolfram Schneider</a> // <a href="http://www.bbbike.de">http://www.bbbike.de</a> <br >

  Map data by the <a href="http://www.openstreetmap.org/">OpenStreetMap</a> Project // <a href="http://wiki.openstreetmap.org/wiki/OpenStreetMap_License">OpenStreetMap License</a> <br >
<div id="footer_community">
</div>
</div>
EOF
}

##############################################################################################
#
# main
#

print $q->header( -charset => 'utf-8' );

print $q->start_html(
    -title => 'BBBike @ World livesearch',
    -head  => $q->meta(
        {
            -http_equiv => 'Content-Type',
            -content    => 'text/html; charset=utf-8'
        }
    ),

    -style => {
        'src' => [
            "../html/devbridge-jquery-autocomplete-1.1.2/styles.css",
            "../html/devbridge-jquery-autocomplete-1.1.2/styles.css",
            "../html/bbbike.css"
        ]
    },
    -script => [
        { -type => 'text/javascript', 'src' => "../html/jquery-1.4.2.min.js" },
        {
            -type => 'text/javascript',
            'src' =>
"../html/devbridge-jquery-autocomplete-1.1.2/jquery.autocomplete-min.js"
        },
        {
            -type => 'text/javascript',
            'src' =>
              "http://maps.google.com/maps/api/js?sensor=false&amp;language=de"
        },
        { -type => 'text/javascript', 'src' => "../html/maps3.js" }
    ]
);

print qq{<div id="routing"></div>\n};
print qq{<div id="BBBikeGooglemap" >\n<div id="map"></div>\n};

print <<EOF;
    <script type="text/javascript">
    //<![CDATA[

    city = "Foobar";
    bbbike_maps_init("terrain", [[42.5000000,2.5300000],[55.6498948, 15.0256735]] );
  
    function jumpToCity (coord) {
	var b = coord.split("!");

	var bounds = new google.maps.LatLngBounds;
        for (var i=0; i<b.length; i++) {
	      var c = b[i].split(",");
              bounds.extend(new google.maps.LatLng( c[1], c[0]));
        }
        map.setCenter(bounds.getCenter());
        map.fitBounds(bounds);
	var zoom = map.getZoom();

        // no zoom level higher than 15
         map.setZoom( zoom < 16 ? zoom + 1 : 16);
    } 

    //]]>
    </script>
EOF

if ( $q->param('max') ) {
    my $m = $q->param('max');
    $max = $m if $m > 0 && $m < 1024;
}
my @d = &extract_route( $logfile, $max );
print qq{<script type="text/javascript">\n};

my $json = new JSON;
my $cities;
foreach my $url (@d) {
    my $qq = CGI->new($url);
    print $url, "\n" if $debug >= 2;

    next if !$qq->param('driving_time');

    my $opt =
      { map { $_ => ( $qq->param($_) || "" ) }
          qw/city route_length driving_time startname zielname area/ };

    $city_center->{ $opt->{'city'} } = $opt->{'area'};

    if ( my $coords = $qq->param('coords') ) {
        my $data = "[";
        foreach my $c ( split /!/, $coords ) {
            $data .= qq{'$c', };
        }
        $data =~ s/, $/]/;

        my $opt_json = $json->encode($opt);
        print qq{plotRoute(map, $opt_json, $data);\n};

        push( @{ $cities->{ $opt->{'city'} } }, $opt ) if $opt->{'city'};
    }
}

print "/* ", Dumper($cities),      " */\n" if $debug >= 2;
print "/* ", Dumper($city_center), " */\n" if $debug >= 2;

my $d = join(
    "<br/>",
    map {
            qq/<a href="#" onclick="jumpToCity(\\'/
          . $city_center->{$_}
          . qq/\\')">$_(/
          . scalar( @{ $cities->{$_} } ) . ")</a>"
      } sort keys %$cities
);
print qq{\n\$("div#routing").html('$d');\n\n};

my $city = $q->param('city') || "";
if ( $city && exists $city_center->{$city} ) {
    print qq[\njumpToCity('$city_center->{ $city }');\n];
}

print qq{\n</script>\n};

print
qq{<noscript><p>You must enable JavaScript and CSS to run this application!</p>\n</noscript>\n};
print "</div>\n";
print &footer;

print $q->end_html;

