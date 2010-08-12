#!/usr/bin/perl

use CGI;
use IO::File;
use JSON;

use strict;
use warnings;

my $logfile = '/var/log/lighttpd/bbbike.error.log';

my $q     = new CGI;
my $max   = 100;
my $debug = 1;

# extract URLs from web server error log
sub extract_route {
    my $file = shift;
    my $max  = shift;

    my @data;
    my %hash;

    foreach my $file ( "$file.1.gz", $file ) {
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

print $q->header();
print $q->start_html(
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
   
    //]]>
    </script>
EOF

my @d = &extract_route( $logfile, $max );
print qq{<script type="text/javascript">\n};

my $json = new JSON;
foreach my $url (@d) {
    my $qq = CGI->new($url);
    print $url, "\n" if $debug >= 2;

    # print qq{ // city: }, $qq->param('city'), ", length: ", $qq->param('route_length'), ", driving time: ", $qq->param('driving_time'), "\n";
    my $opt = { map { $_ => ($qq->param($_) || "") } qw/city route_length driving_time startname zielname/ };

    if ( my $coords = $qq->param('coords') ) {
        my $data = "[";
        foreach my $c ( split /!/, $coords ) {
            $data .= qq{'$c', };
        }
        $data =~ s/, $/]/;

	my $opt_json = $json->encode($opt);
        print qq{plotRoute(map, $opt_json, $data);\n};
    }
}

print qq{</script>\n};

print "</div>\n";

print $q->end_html;

