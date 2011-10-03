#!/usr/local/bin/perl
# -*- perl -*-

#
# $Id: bbbike.cgi,v 9.30 2009/04/04 11:13:58 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 1998-2011 Slaven Rezic. All rights reserved.
# This is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License, see the file COPYING.
#
# Mail: slaven@rezic.de
# WWW:  http://bbbike.sourceforge.net
#

=head1 NAME

bbbike.cgi - CGI interface to bbbike

=cut

BEGIN {
    $ENV{SERVER_NAME} ||= "";
    open(STDERR, ">> /tmp/bbbike.log")
	if $ENV{SERVER_NAME} =~ /sourceforge/ ||
           $ENV{SERVER_NAME} =~ m,^(dev|test).*$,;
	 
    $^W = 1 if $ENV{SERVER_NAME} =~ /herceg\.de/i;
    $main::datadir = $ENV{'DATA_DIR'} || "data";
    $ENV{LANG} = 'C'; 
}
use vars qw(@extra_libs);
BEGIN { delete $INC{"FindBin.pm"} } # causes warnings, maybe try FindBin->again if available?
use FindBin;
BEGIN {
    if ($ENV{MOD_PERL} && $ENV{MOD_PERL} =~ m{mod_perl/2}) {
	# Fix FindBin for ModPerl::Registry operation
	($FindBin::RealBin = __FILE__) =~ s{/[^/]+$}{};
    }
    {
	# Achtung: evtl. ist auch ~/lib/ f�r GD.pm notwendig (z.B. CS)
	@extra_libs =
	    (grep { -d }
	     #"/home/e/eserte/src/bbbike",
	     "$FindBin::RealBin/..", # falls normal installiert
	     "$FindBin::RealBin/../lib",
	     "$FindBin::RealBin/../BBBike", # falls in .../cgi-bin/... installiert
	     "$FindBin::RealBin/../BBBike/lib",
	     "$FindBin::RealBin/BBBike", # weitere Alternative
	     "$FindBin::RealBin/BBBike/lib",
	     "$FindBin::RealBin",
	    );
    }
}
use lib (@extra_libs);

use Strassen; # XXX => Core etc.?
use Strassen::Dataset;
#use Strassen::Lazy; # XXX mal sehen...
use BBBikeCalc;
use BBBikeVar;
use BBBikeUtil qw(is_in_path min max kmh2ms);
use BBBikeCGIUtil;
use File::Basename qw(dirname basename);
use CGI;
use CGI::Carp; # Nur zum Debuggen verwenden --- manche Web-Server machen bei den kleinsten Kleinigkeiten Probleme damit: qw(fatalsToBrowser);
use BrowserInfo 1.47;
use Encode;
use BBBikeGooglemap;
use BBBikeAds;
use BBBikeElevation;
use Data::Dumper;

use strict;
use vars qw($VERSION $VERBOSE $WAP_URL
	    $debug $tmp_dir $mapdir_fs $mapdir_url $local_route_dir
	    $bbbike_root $bbbike_images $bbbike_url $bbbike2_url $is_beta
	    $bbbike_html
	    $modperl_lowmem $use_imagemap $create_imagemap $detailmap_module
	    $q %persistent %c $got_cookie
	    $g_str $orte $orte2 $multiorte
	    $ampeln $qualitaet_net $handicap_net
	    $strcat_net $radwege_strcat_net $radwege_net $routen_net $comments_net
	    $green_net $unlit_streets_net
	    $crossings $kr %cached_plz $net $multi_bez_str
	    $sperre_tragen $sperre_narrowpassage
	    $overview_map $city
	    $use_umland $use_umland_jwd $use_special_destinations
	    $use_fragezeichen $use_fragezeichen_routelist
	    $check_map_time $use_cgi_bin_layout
	    $show_weather $show_start_ziel_url @weather_cmdline
	    $bp_obj $bi $use_select
	    $graphic_format $use_mysql_db $use_exact_streetchooser
	    $use_module
	    $cannot_gif_png $cannot_jpeg $cannot_pdf $cannot_svg $can_gif
	    $can_wbmp $can_palmdoc $can_gpx $can_kml
	    $can_google_maps $can_gpsies_link
	    $can_mapserver $mapserver_address_url
	    $mapserver_init_url $no_berlinmap $max_plz_streets $with_comments
	    $with_cat_display
	    $use_coord_link
	    @weak_cache @no_cache %proc
	    $bbbike_script $cgi $port
	    $search_algorithm $use_background_image
	    $use_apache_session $now_use_apache_session $apache_session_module $cookiename
	    $bbbike_temp_blockings_file $bbbike_temp_blockings_optimized_file
	    @temp_blocking $temp_blocking_epoch
	    $use_cgi_compress_gzip $use_bbbikedraw_compress $max_matches
	    $use_winter_optimization $winter_hardness
	    $with_fullsearch_radio
	    $with_lang_switch
	    $newstreetform_encoding
	    $use_region_image
	    $include_outer_region @outer_berlin_places $outer_berlin_qr
	    $datadir $show_mini_map $show_mini_googlemap $show_mini_googlemap_city
	    $no_input_streetname
	    $enable_opensearch_suggestions
	    $enable_current_weather
	    $warn_message $use_utf8 $use_via $enable_via_hide
	    $enable_google_analytics
	    $with_green_ways
            $no_teaser $no_teaser_right $teaser_bottom
            $slippymap_zoom $slippymap_zoom_maponly $slippymap_zoom_city
	    $enable_opensearch_plugin 
	    $nice_abc_list
	    $warn_message $use_utf8 $data_is_wgs84
	    $enable_homemap_streets
	    $warn_message $use_utf8 $data_is_wgs84 $osm_data
	    $gmap_api_version
	    $enable_current_postion
	    $enable_weather_forecast
	    $enable_facebook_t_link
	    $enable_twitter_t_link
	    $enable_google_plusone_t_link
	    $enable_rss_feed $enable_rss_icon
	    $gmapsv3
	    $facebook_page
	    $enable_google_adsense
	    $enable_google_adsense_start
	    $enable_google_adsense_street
	    $enable_google_adsense_linkblock
	    $enable_google_adsense_street_linkblock
	    $enable_panoramio_photos
	    $enable_elevation
	    $dos_run_timeout
	    $show_real_time
	    $cache_streets_html
	    $bbbike_start_js_version
	    $enable_latlng_search
	   );

$gmap_api_version = 3;
$facebook_page = 'http://www.facebook.com/BBBikeWorld';

# XXX This may be removed one day
use vars qw($use_cooked_street_data);

$gmapsv3 = 1;

#XXX in mod_perl/Apache::Registry operation there are a lot of "shared
# variable" warnings. They seem to be not harmful, but I should get
# rid of them.

#open(STDERR, ">>/tmp/bbbike.log");

# versucht, die C/XS-Version von make_net zu laden
eval q{local $SIG{'__DIE__'};
       # XXX warum gibt das hier Fehler auf stderr aus?
       # (nur bei 5.6.0?)
       use BBBikeXS;
   };

=head1 Configuration section

Please change the configuration variables in the file bbbike.cgi.config
(replace bbbike.cgi with the basename of the CGI script).

=head2 Filesystem and URLs

=over

=item $mapdir_url

URL for directory where the imagemaps are created. The directory should
be writable for the owner of the httpd process.

=cut

#$mapdir_url = '/~eserte/bbbike-tmp';

=item $mapdir_fs

The C<$mapdir_url> path in filesystem space.

=cut

#$mapdir_fs  = '/home/e/eserte/www/bbbike-tmp';

=item $tmp_dir

Temporary directory for cache files, weather data files etc. Default:
the environment variables TMPDIR or TEMP or the C</tmp> directory. A
good platform-independent default is

    do { require File::Spec; File::Spec->tmpdir }

=cut

$tmp_dir = $ENV{TMPDIR} || $ENV{TEMP} || "/tmp";

=item $use_cgi_bin_layout

Set to true, if you are using a cgi-bin styled layout, that is, cgi-bin
and htdocs are in seperate directories. Default: false.

=cut

$use_cgi_bin_layout = 0;

=item $local_route_dir

A directory where local route files are stored. These may be drawn
with the C<localroutefile> parameter.

=cut

undef $local_route_dir;

=back

=head2 External programs

=over

=item $ENV{PATH}

Some WWW servers set the PATH environment variable empty. Set this to
a sane value (e.g. /bin:/usr/bin) for some required external programs.

=cut

$ENV{PATH} = '' if !defined $ENV{PATH};
$ENV{PATH} = "/usr/bin:$ENV{PATH}" if $ENV{PATH} !~ m{/usr/bin}; # for Sys::Hostname

=item $Strassen::OLD_AGREP, $PLZ::OLD_AGREP

Set the C<$Strassen::OLD_AGREP> and C<$PLZ::OLD_AGREP> to a true value to
not use C<agrep> (instead C<String::Approx> will be used for approximate
matches). Please note that C<agrep> in versions less than 3.0 does not handle
umlauts correctly.

=cut

$Strassen::OLD_AGREP = 1;
$PLZ::OLD_AGREP      = 1;
$PLZ::OLD_AGREP      = $PLZ::OLD_AGREP; # peacify -w

=back

=head2 Web Server

=over

=item $modperl_lowmem

In the case of using the script in a  modperl environment: set this to
true, if global variables should be deleted after the end of a request.
This may help if there are memory leaks. Default: true if MOD_PERL.

=cut

$modperl_lowmem = $ENV{MOD_PERL};

=item $use_apache_session

Use an L<Apache::Session> class for storing the route coordinates.
This is useful for large routes which would overflow the URL capacity
of most browsers and web servers. Default: false.

=cut

$use_apache_session = 0;

=item $apache_session_module

The class of the L<Apache::Session> family to be used. Default is
L<Apache::Session::DB_File>.

=cut

$apache_session_module = "Apache::Session::DB_File";

=back

=head2 Imagemaps, graphic creation, export formats

=over

=item $use_imagemap

Set to true, if the detail maps should use an imagemap. This feature
seems to be supported only on Netscape running on FreeBSD or Linux.
On other systems there may be fatal errors if this is set to true.
Default: false.

=cut

$use_imagemap = 0;

=item $create_imagemap

If set to true, then imagemaps for C<$use_imagemap> will be created.
Default: true.

=cut

$create_imagemap = 1;

=item $detailmap_module

The L<BBBikeDraw> module to use for detailmap creation. By default
C<GD> is used.

=cut

$detailmap_module = undef;

=item $check_map_time

Control the checking of the up-to-dateness of imagemaps.

=over

=item 0: no check

=item 1: check against the "strassen" datafile

=item 2: check against the "strassen" datafile and the CGI script itself

=back

=cut

$check_map_time = 0;

=item $graphic_format

Set the preferred graphic format: C<png> or C<gif>. If using C<GD
1.20> or newer, this *must* be set to png, otherwise the creation of
graphics will not work! If neither gif nor png can be produced, set
the the variable to an empty string. Default: png.

=cut

$graphic_format = 'png';

=item $use_module

Use another drawing module instead of the default GD. Possible values
are ImageMagick or Imager.

=cut

undef $use_module;

=item $cannot_jpeg

If for some reasons JPEG cannot be produced (because GD is not able
to), set this variable to a true value. Default: true.

=cut

$cannot_jpeg = 1;

=item $cannot_pdf

If PDF::Create is not installed, set this variable to a true value. Default:
false.

=cut

$cannot_pdf  = 0;

=item $cannot_svg

If C<SVG.pm> is not installed, set this variable to a true value. Default:
true.

=cut

$cannot_svg  = 1;

=item $can_gif

Set this to a true value if you can produce gif images. Default: false.

=cut

$can_gif = 0;

=item $can_wbmp

Set this to a true value if you can produce wbmp images. Default: false.

=cut

$can_wbmp = 0;

=item $can_palmdoc

Set this to a true value if you can produce palmdoc documents with the
L<Palm::PalmDoc> module (possible viewer: CSpotRun). Default: false.

=cut

$can_palmdoc = 0;

=item $can_gpx

Set this to a true value if you can produce GPX documents (needs
L<XML::LibXML>. Default: false.

=cut

$can_gpx = 0;

=item $can_kml

Set this to a true value if you can produce KML documents (needs
L<XML::LibXML>. Default: false.

=cut

$can_kml = 0;

=item $can_mapserver

Set this to a true value if mapserver can be used. Default: false. See
below for special mapserver variables.

=cut

$can_mapserver = 0;

=item $can_gpsies_link

Set this to a true value if a link to L<www.gpsies.com> should be
created. Default: false.

=cut

$can_gpsies_link = 0;

=back

=head2 Mapserver

=over

=item $mapserver_dir

Directory containing map and template html files.

=item $mapserver_prog_relurl

Relative URL to the mapserver cgi program.

=item $mapserver_prog_url

Absolute URL to the mapserver cgi program.

=item $mapserver_init_url

Absolute URL to the page which starts the mapserver program.

=cut

$mapserver_init_url = $BBBike::BBBIKE_MAPSERVER_DIRECT;

=item $mapserver_address_url

Absolute URL to the mapserver address cgi program.

=cut

$mapserver_address_url = $BBBike::BBBIKE_MAPSERVER_ADDRESS_URL;

=item $bbd2esri_prog

Path to the bbd2esri program.

=back

=head2 Appearance

=over

=item $show_start_ziel_url

Create links for start/goal URLs. Default: true.

=cut

$show_start_ziel_url = 1;

=item $show_weather

Show and fetch the current weather information. Default: true.

=cut

$show_weather = 1;

=item @weather_cmdline

The command line for the weather information fetching program.

=cut

@weather_cmdline = ("$FindBin::RealBin/" . ($use_cgi_bin_layout
					    ? "BBBike" : "..") .
		    "/lib/wettermeldung2", qw(-dahlem1));

=item $use_select

Use E<lt>SELECTE<gt> instead of E<lt>INPUT TYPE=RADIOE<gt>, if possible.
Default: true.

=cut

$use_select = 1;

=item $no_berlinmap

If no detailmap links should be shown (because GD is not installed at all),
then set this to true. Default: false.

=cut

$no_berlinmap = 1 if $osm_data;

=item $use_background_image

Show the nice background image. Default: true.

=cut

$use_background_image = 1;

=item $with_comments

Include column for comments in route list. Only activated if browser
is able to display tables.

=cut

$with_comments = 1;

=item $with_cat_display

Include column for graphical category display. Only activated if
browser is able to display tables. Default is false.

=cut

$with_cat_display = 0;

=item $use_coord_link

Use an own exact coordinate link (i.e. to Mapserver) instead of a
"Stadtplan" link. Default: true.

=cut

$use_coord_link = 1;

=back

=head2 Data

=over

=item $city

The city/country key. Default is Berlin_DE. A same named module as
Geography::I<$city> should exist.

=cut

$city = "Berlin_DE";

=item $use_umland

NYI: search in the region. Default: false.

=cut

$use_umland = 0;

=item $use_umland_jwd

NYI: search in the wide region. Default: false.

=cut

$use_umland_jwd = 0;

=item $use_special_destinations

Set to a true value if special destinations like bikeshops, bankomats etc.
may be used. NOT YET USED.

=cut

$use_special_destinations = 0;

=item $use_fragezeichen

Set to true to allow the user to search unknown streets.

=cut

$use_fragezeichen = 0;

=item $use_fragezeichen_routelist

Set to true to show unknown streets in the route list.

=cut

$use_fragezeichen_routelist = 1;

=back

=head2 Misc

=over

=item $search_algorithm

Default search algorithm is (pure perl) A*, but may be set to C<C-A*> or
other.

=cut

$search_algorithm = undef;

=item $use_mysql_db

Should the MySQL database (TelbuchDBApprox) be used if a house number
is given? Default: false.

=cut

$use_mysql_db = 0;

=item $use_exact_streetchooser

Exact chooser for near coordinates ... somewhat slower, but more
exact. Default: true.

=cut

$use_exact_streetchooser = 1;

=item $VERBOSE

Set this to true for debugging purposes.

=cut

$VERBOSE = 1;

=item $bbbike_temp_blockings_file

Full path to a bbbike-temp-blockings.pl file. See @temp_blocking for
more information on the file format.

=item @temp_blocking

Array with temporary blocking elements. Each element is a hash with the
following keys set:

=over

=item from

unix time of start of temporary blocking or undef.

=item until

unix time of end of temporary blocking or undef.

=item file

bbd file for temporary blocking data or undef.

=item text

Explanation text for temporary blockings.

=back

=item $use_utf8

Set to a true value if the C<utf-8> encoding should be used on the
generated HTML pages. Highly recommended for non-latin1 data.

=cut

$use_utf8 = 0;

=item $use_via

Set to a true value if the you want show a via search field.

=item $data_is_wgs84

Set to a true value if data is using wgs84 coordinates instead of
the home-brew bbbike format. Probably only useful for data converted
from OpenStreetMap.

=cut

$data_is_wgs84 = 0;

=item $osm_data

Set to a true value if data originates from OpenStreetMap.

=cut

$osm_data = 0;

=back

=cut

$use_via = 1;

# XXX document: # show max n matches in start form
$max_matches = 20;

$newstreetform_encoding = "";

@outer_berlin_places = (qw(Potsdam Oranienburg Birkenwerder Kleinmachnow Stahnsdorf Teltow Bernau Strausberg Falkensee Mahlow Erkner
			   Dahlwitz-Hoppegarten Woltersdorf R�dersdorf Werder Hennigsdorf Schwanebeck H�now Ahrensfelde Gro�ziethen
		          ), "Hohen Neuendorf", "K�nigs Wusterhausen", "Sch�neiche bei Berlin", "Neuenhagen bei Berlin",
			"Petershagen bei Berlin", 'Dallgow-D�beritz', "Sch�nefeld", "Gosen", "Zepernick", "R�ntgental",
			"Glienicke/Nordbahn", "Dahlewitz",
		       );
$outer_berlin_qr = "^(?:" . join("|", map { quotemeta } @outer_berlin_places) . ")\$"; $outer_berlin_qr = qr{$outer_berlin_qr};

####################################################################

unshift(@Strassen::datadirs,
	"$FindBin::RealBin/../$main::datadir",
	#"$FindBin::RealBin/../BBBike/$main::datadir",
       );

use vars qw($lang $config_master $msg $msg_en);

# These must not be permanent:
undef $msg;
undef $msg_en;
undef $bbbike_root;
undef $bbbike_html;
undef $bbbike_images;
undef $warn_message;

my $google_analytics_uacct = "UA-286675-19";

$lang = "en";
$config_master = $ENV{'SCRIPT_NAME'};

my $local_lang = "";
my $selected_lang = "";
my @supported_lang = qw/da de en es fr hr nl pl pt ru zh/;

use Time::HiRes qw( gettimeofday tv_interval );
#my $time_start = time;
my $time_start = [gettimeofday];

my $is_streets;
{ my $q = new CGI;
  my $path = $q->url(-full => 0, -absolute => 1);

  # de | en | m
  if ($path =~ m#^/([a-z]{1,2})/# ) {
      $lang = $1;
      $selected_lang = $lang;

      $lang = "en" if $lang eq 'm'; # mobile
  }
  $local_lang = &my_lang($lang, 1);

  $lang = $local_lang if $local_lang && !$selected_lang;
  $is_streets = &is_streets($q);
}

# run cache requests with lower priority
{
  my $q = new CGI;

  # /streets.html
  my $all = defined $q->param('all') ? $q->param('all') : 0;

  # request from internal IP address 10.x.x.x
  my $local_host = $q->remote_host() =~ /^(10\.|127\.0\.0\.1)/ ? 1 : 0;

  if ($q->param('cache') || $all >= 2 || $local_host) {
     eval {
	require BSD::Resource;

	my $success = setpriority(0, 0, 15);
	die "cannot set priority: $$\n" if !$success;
     };
     warn "$@" if $@;
  } 
}


#warn "xxx: city: $datadir, lang: $lang, selected_lang: $selected_lang, local_lang: $local_lang\n";
warn "$datadir does not exists!\n" if ! -d "../$datadir";

#if ($config_master =~ s{^(.*)\.(en)(\.cgi)$}{$1$3}) {

$with_green_ways = 1;

# workaround for symlinks
$config_master =~ s,.*/,,;
$0 =~ m,^(.+)/,;	
$config_master = $1.'/'. $config_master;

# new directory layout
if ($config_master =~ m,/index.cgi$,) {
    $config_master = "../../etc/world.cgi";
}

warn "lang: $lang, config_master: $config_master, do $config_master.config" if $VERBOSE >= 2;
warn "YYY: $config_master.config\n" if ! -f "$config_master.config";

# XXX hier require verwenden???
eval { local $SIG{'__DIE__'};
       #warn "$config_master.config";
       do "$config_master.config" };

$no_berlinmap = 1 if $osm_data;
warn "osm_data: $osm_data, show_mini_map: $show_mini_map/$show_mini_googlemap, no_berlin_map: $no_berlinmap, enable_opensearch_suggestions: $enable_opensearch_suggestions\n" if $VERBOSE; 

if ($dos_run_timeout > 0) {
    my $run_timeout = $dos_run_timeout;
    local $SIG{ALRM} = sub { die "Runs to long, give up after $run_timeout seconds\n" };
    alarm($run_timeout);
    warn "Activate DoS handler: $run_timeout seconds\n" if $debug >= 2;
}

$slippymap_zoom = 5 if $slippymap_zoom <= 0;
$slippymap_zoom_maponly = 4 if $slippymap_zoom <= 0;
$slippymap_zoom_city = 6 if $slippymap_zoom_city <= 0;

my $local_city_name = "";
my $en_city_name = "";
my $de_city_name = "";
my $city_script;
my $region = "";
my $other_names = [];

if ($osm_data) {
    $datadir =~ m,data-osm/(.+),;
    my $city = $1;
    $city_script = $city;


    my $geo = get_geography_object();
    my $name = $geo->{city_names};

    $local_city_name = select_city_name($city, $name, $lang);
    $en_city_name = select_city_name($city, $name, "en");
    $de_city_name = select_city_name($city, $name, "de");

    unshift (@INC, "../data-osm/$city") if $city;
    require Karte::Polar;

    $region = $geo->{"region"} || "other";

    binmode (\*STDERR, ':utf8') if $use_utf8;

    if (exists $geo->{'other_names'}) {
	$other_names = $geo->{'other_names'};
    }
}

if ($lang ne "de") {
    $msg = eval { do "$FindBin::RealBin/msg/$lang" };
    $msg_en = eval { do "$FindBin::RealBin/msg/en" };
    undef $msg if $msg && ref $msg ne 'HASH';
    undef $msg_en if $msg_en && ref $msg_en ne 'HASH';

    no strict "vars";
    if ($msg && ref $msg eq 'HASH') {
	warn "decode utf8 '$lang' message\n" if $VERBOSE >= 2;

    	foreach my $key (keys %$msg) {
	   $msg->{$key} = Encode::decode("utf-8", $msg->{$key});
    	}
    }
}

$BBBikeAds::enable_google_adsense = $enable_google_adsense;
$BBBikeAds::enable_google_adsense_start = $enable_google_adsense_start;
$BBBikeAds::enable_google_adsense_street = $enable_google_adsense_street;
$BBBikeAds::enable_google_adsense_linkblock = $enable_google_adsense_linkblock;
$BBBikeAds::enable_google_adsense_street_linkblock = $enable_google_adsense_street_linkblock;


sub M ($) {
    my $key = shift;


    my $text;
    if ($msg && exists $msg->{$key}) {
	$text = $msg->{$key};
    } elsif ($msg_en && exists $msg_en->{$key}) {
	warn "Unknown translation local lang $lang: $key\n";
	$text = $msg_en->{$key};
    } else {
        warn "Unknown translation: $key\n" if $VERBOSE && $msg;
	$text = $key;
    }

    # if (!Encode::is_utf8($text)) { $text = Encode::encode("utf-8", $text); }

    return $text;
}

my $no_name = '(' . M("Stra�e ohne Namen") . ')';

# select city name by language
sub select_city_name {
    #my $self = shift;

    my $city      = shift;
    my $name      = shift or die "No city name given!\n";
    my $city_lang = shift || "en";

    #warn "city: $city, name: $name, lang: $city_lang\n" if $self->debug >= 2;

    my %hash;

    # default city name
    $hash{ALL} = $city;

    foreach my $n ( split /\s*,\s*/, $name ) {
        my ( $lang, $city_name ) = split( /!/, $n );
        if ($city_name) {
            $hash{$lang} = $city_name;
        }

        # no city language defined, use default
        else {
            $hash{ALL} = $lang;
        }
    }

    return $hash{$city_lang} || $hash{"en"} || $hash{ALL};
}


if ($VERBOSE) {
    $StrassenNetz::VERBOSE    = $VERBOSE;
    $Strassen::VERBOSE        = $VERBOSE;
    $StrassenNetz::CNetFile::VERBOSE  = $VERBOSE;
    $Kreuzungen::VERBOSE      = $VERBOSE;
}

use vars qw($cgic); # Can't use my here!
sub my_exit {
    # Seems to be necessary for CGI::Compress::Gzip to flush the
    # output buffer.
    undef $cgic;
    exit @_;
}

use vars qw($require_Karte);
$require_Karte = sub {
    require Karte;
    Karte::preload('Standard', 'Polar');
    $Karte::Standard::obj = $Karte::Standard::obj if 0; # cease -w
    undef $require_Karte;
};

$VERSION = 10.004;

use vars qw($font $delim);
$font = 'sans-serif,helvetica,verdana,arial'; # also set in bbbike.css
$delim = '!'; # wegen Mac nicht � verwenden!

@weak_cache = ('-expires' => '+6d',
               # XXX ein bi�chen soll Netscape3 auch cachen k�nnen:
	       #'-pragma' => 'no-cache',
	       '-cache-control' => 'private',
              );
@no_cache = ('-expires' => 'now',
             '-pragma' => 'no-cache',
	     '-cache-control' => 'no-cache',
            );
#XXX shared variable ! my $header_written;
use vars qw($header_written);

if (%Apache::) {
    # workaround for "use lib" problem with Apache::Registry
    'lib'->import(@extra_libs);
}

use vars qw($xgridwidth $ygridwidth $xgridnr $ygridnr $xm $ym $x0 $y0
	    $detailwidth $detailheight $nice_berlinmap $nice_abcmap
	    $start_bgcolor $via_bgcolor $ziel_bgcolor @pref_keys);
# Konstanten f�r die Imagemaps
# Die Werte (bis auf $ym) werden mit small_berlinmap.pl ausgegeben.
use vars qw($berlin_small_width $berlin_small_height $berlin_small_suffix);
if (!$use_region_image) {
    $berlin_small_width = $berlin_small_height = 200;
    $berlin_small_suffix = "";
    $xm = 228.58;
    $ym = 228.58;
    $x0 = -10849;
    $y0 = 34282.5;
} elsif (0) {
    $berlin_small_width = $berlin_small_height = 240;
    $berlin_small_suffix = "_240";
    $xm = 223.6375;
    $ym = 223.6375;
    $x0 = -19716;
    $y0 = 38448.5;
} else {
    $berlin_small_width  = 280;
    $berlin_small_height = 240;
    $berlin_small_suffix = "_280x240";
    $xm = 247.057142857143;
    $ym = 247.057142857143;
    $x0 = -25901;
    $y0 = 41258.8571428572;
}
# Die n�chsten beiden Variablen m�ssen auch in bbbike_start.js ge�ndert werden.
$xgridwidth = 20; # 20 * 10 = 200: Breite und H�he von berlin_small.gif
$ygridwidth = 20;
$xgridnr = $berlin_small_width / $xgridwidth;
$ygridnr = $berlin_small_height / $ygridwidth;
## sch�n gro�, aber passt nicht auf Seite
#$detailwidth  = 600; # mu� quadratisch sein!
#$detailheight = 600;
$detailwidth  = 500; # mu� quadratisch sein!
$detailheight = 500;
$nice_berlinmap = 0;
$nice_abcmap    = 0;

$bbbike_start_js_version = '1.18';

use vars qw(@b_and_p_plz_multi_files %is_usable_without_strassen %same_single_point_optimization);
@b_and_p_plz_multi_files = 
    #  File                   Data fmt   Usable without being in strassen
    #                                        same single point optimization
    (["Berlin.coords.data",   "PLZ",      0, 0],
     ["Potsdam.coords.data",  "PLZ",      0, 0],
     ["plaetze",              "Strassen", 0, 1], # because there are also some "sehenswuerdigkeiten" in
     # not yet: ["sehenswuerdigkeit_bp", "Strassen", 1, 1], # generated, see below
    );
for my $i (0 .. $#b_and_p_plz_multi_files) {
    $is_usable_without_strassen{$i}     = $b_and_p_plz_multi_files[$i]->[2];
    $same_single_point_optimization{$i} = $b_and_p_plz_multi_files[$i]->[3];
}

$start_bgcolor = '';
$via_bgcolor   = '';
$ziel_bgcolor  = '';
if (!$use_background_image && 0) {
    $start_bgcolor = '#f0f8ff';
    $via_bgcolor   = '#ecf4ff';
    $ziel_bgcolor  = '#e8f0ff';
}
use vars qw($speed_default);
$speed_default = 20;

use vars qw(%handicap_speed);
%handicap_speed = ("q4" => 5, # hardcoded f�r Fu�g�ngerzonen
		   "q3" => 13,
		   "q2" => 18,
		   "q1" => 25,
		   'Q'  => 8, # XXX this is for ferries, and should probably be finer granulated
		  );

@pref_keys = qw/speed cat quality ampel green specialvehicle unlit ferry elevation winter fragezeichen/;

CGI->import('-no_xhtml');

$q = new CGI;

my @cgi_param = qw/startname start2 start startplz starthnr startc startort vianame via2 via viaplz viahnr viac viaort zielname ziel2 ziel zielplz zielhnr zielc zielort/;

if (&is_forum_spam($q, @cgi_param)) {
    $q->delete ( @cgi_param);
}

sub is_ie6 {
   my $q = shift;
   $q->user_agent("MSIE 6") ? 1 : 0;
}
sub is_ie7 {
   my $q = shift;
   $q->user_agent("MSIE 7") ? 1 : 0;
}

if (&is_ie6($q)) {
   if ($gmap_api_version == 3) {
	warn "Downgrade to google maps v2 for IE6: ", $q->remote_host, " ", $q->url, " ", $q->user_agent, "\n" if 1 || $debug;
        $gmap_api_version = 2;
   }
}

# Stopp user to bookmark bbbike.cgi?begin=1
if (defined $q->param('begin')) {
    $q->delete('begin');
    print $q->redirect($q->url);
    exit(0);
}

# Used for $use_utf8=1
eval{BBBikeCGIUtil::decode_possible_utf8_params($q);};warn $@ if $@;

undef $g_str; # XXX because it may already contain landstrassen etc.
undef $net; # dito
undef $kr;
undef $comments_net; # XXX because it may or may not contain qualitaet_l

# reset per request
$now_use_apache_session = $use_apache_session;

#$str = new Strassen "strassen" unless defined $str;
#$str = new Strassen::Lazy "strassen" unless defined $str;
$cookiename = "bbbike";
#get_streets($use_umland_jwd ? "wideregion" : $use_umland ? "region" : "city");

# Maximale Anzahl der angezeigten Stra�en, wenn eine Auswahl im PLZ-Gebiet
# gezeigt wird.
$max_plz_streets = 25;

# die originale URL (f�r den Kaltstart)
$bbbike_url = BBBikeCGIUtil::my_url($q, -full=>0, -absolute=>1);
# Root-Verzeichnis und Bilder-Verzeichnis von bbbike
($bbbike_root = $bbbike_url) =~ s|[^/]*/[^/]*$|| if !defined $bbbike_root;
$bbbike_root =~ s|/$||; # letzten Slash abschneiden
$bbbike_root = "";
if (!defined $bbbike_images) {
    $bbbike_images = "$bbbike_root/" . ($use_cgi_bin_layout ? "BBBike/" : "") .
	"images";
}
if (!defined $bbbike_html) {
    $bbbike_html   = "$bbbike_root/" . ($use_cgi_bin_layout ? "BBBike/" : "") .
	"html";
}
$is_beta = $bbbike_url =~ m{bbbike\d(\.en)?\.cgi}; # bbbike2.cgi ...
$bbbike2_url = $bbbike_url;
if (!$is_beta) {
    local $^W; # $1 may be undef
    $bbbike2_url =~ s{bbbike(\.en)?\.cgi}{bbbike2$1.cgi};
}

$bbbike_url =~ s,/streets\.html$,/,;

$bbbike_script = $bbbike_url;

if (!$mapdir_url && !$mapdir_fs) {
    $mapdir_url = "$bbbike_script?tmp=";
    $mapdir_fs  = "$FindBin::RealBin/../tmp/www"; # hmmm, too much assuming about position of cgi
}

if (defined $mapdir_fs && !-d $mapdir_fs) {
    # unter der Voraussetzung, dass das Parent-Verzeichnis schon existiert
    mkdir $mapdir_fs, 0755;
}

# $mapdir_url absolut machen
if (defined $mapdir_url && $mapdir_url !~ m{^https?://}) {
    $mapdir_url = "http://" . BBBikeCGIUtil::my_server_name($q) . ($q->server_port != 80 ? ":" . $q->server_port : "") . $mapdir_url;
}

#XXX ! stay shared: my($fontstr, $fontend);
#XXX ! stay shared: my $smallform = 0;
use vars qw($smallform $fontstr $fontend);
$smallform = 0;

$header_written = 0;

if ($q->path_info ne "") {
    my $q2 = CGI->new(substr($q->path_info, 1));
    foreach my $k ($q2->param) {
	$q->param($k, $q2->param($k));
    }
}

if ($q->param("tmp")) {
    warn "YYY: image\n";

    my $file = $q->param("tmp");
    $file =~ s{/+}{}g; # one leading slash is expected
    $file = $mapdir_fs . "/" . $file;
    my($ext) = $file =~ m{\.([^\.]+)$};
    http_header(-expires => '+6d', -type => "image/$ext");

    binmode STDOUT;
    open TMP, $file or die "Can't open file $file: $!";
    local $/ = \8192;
    while(<TMP>) {
	print $_;
    }
    close TMP;
    my_exit(0);
}

# Bei Verwendung von Apache mu� die User-Info immer neu
# festgestellt werden
user_agent_info();

# XXX Do not do it automatically ...
if (0 && $bi->{'wap_browser'}) {
    exec("./wapbbbike.cgi", @ARGV);
    warn "exec failed, try redirect...";
    print $q->redirect($WAP_URL || $BBBike::BBBIKE_WAP);
    my_exit(0);
}
# Die nervigen Java-Robots... wenn sie wenigstens korrekt crawlen
# w�rden und robots.txt beachten w�rden...
if ($q->user_agent =~ m{^Java/1\.} && ($q->query_string||'') eq '') {
    print $q->redirect("$bbbike_html/bbbike_small.html");
    my_exit(0);
}

undef $bp_obj;
init_bikepower($q);

use vars qw($wettermeldung_file);
$wettermeldung_file = "$tmp_dir/wettermeldung-$<";
# Wettermeldungen so fr�h wie m�glich versuchen zu holen
if ($show_weather || $bp_obj) {
    start_weather_proc();
}

$q->delete('Dummy');
$smallform = $q->param('smallform') || $bi->{'mobile_device'} || $q->virtual_host =~ m{^m\.}; # e.g. m.bbbike.de
$got_cookie = 0;
%c = ();

if (defined $q->param('api')) {
    require BBBikeCGIAPI;
    BBBikeCGIAPI::action($q->param('api'), $q);
    my_exit(0);
}

foreach my $type (qw(start via ziel)) {
    if (defined $q->param($type . "charimg.x") and
	$q->param($type . "charimg.x") ne ""   and
	defined $q->param($type . "charimg.y") and
	$q->param($type . "charimg.y") ne "") {
	my($x, $y) = (int(($q->param($type . "charimg.x")-2)/30),
		      int(($q->param($type . "charimg.y")-2)/30));
	my $ch = $x + $y*9 + ord("A");
	$ch = ($ch > ord("Z") ? 'Z' : ($ch < ord("A") ? 'A' : chr($ch)));
	$q->param($type . "char", $ch);
	$q->delete($type . "charimg.x");
	$q->delete($type . "charimg.y");
    } elsif (defined $q->param($type . 'c_wgs84') and
	     $q->param($type . 'c_wgs84') ne '') {
	my($x,$y) = convert_wgs84_to_data(split /,/, $q->param($type . 'c_wgs84'));
	$q->param($type . 'c', "$x,$y");
	$q->delete($type . 'c_wgs84');
    }
}

{
    my($dx,$dy);
 TRY_MOVEMAP: {
	for my $ns_direction_def (['n', -1],
				  ['s', +1],
				  ['',   0],
				 ) {
	    my($ns_direction, $_dy) = @$ns_direction_def;
	    for my $ew_direction_def (['',  0 ],
				      ['e', +1],
				      ['w', -1],
				     ) {
		my($ew_direction, $_dx) = @$ew_direction_def;
		my $param_name = "movemap_" . $ns_direction . $ew_direction;
		if ($q->param($param_name)) {
		    $q->delete($param_name);
		    $dx = $_dx;
		    $dy = $_dy;
		    last TRY_MOVEMAP;
		}
	    }
	}

	# otherwise: old style with hardcoded german labels
	if (defined $q->param('movemap')) {
	    my $move = $q->param('movemap');
	    $q->delete("movemap");
	    if    ($move =~ /^nord/i) { $dy = -1 }
	    elsif ($move =~ /^s.*d/i) { $dy = +1 }
	    if    ($move =~ /west$/i) { $dx = -1 }
	    elsif ($move =~ /ost$/i)  { $dx = +1 }
	}
    }

    if ($dx || $dy) {
	my($x, $y) = ($q->param('detailmapx'),
		      $q->param('detailmapy'));
	$q->delete('detailmapx');
	$q->delete('detailmapy');
	$x += $dx;
	$y += $dy;
	draw_map('-x' => $x,
		 '-y' => $y);
	goto REQUEST_DONE;
    }
}

foreach my $type (qw(start via ziel)) {
    if (defined $q->param($type . "mapimg.x") and
	$q->param($type . "mapimg.x") ne ""   and
	defined $q->param($type . "mapimg.y") and
	$q->param($type . "mapimg.y") ne "") {
	my($x, $y) = (int($q->param($type . 'mapimg.x')/$xgridwidth),
		      int($q->param($type . 'mapimg.y')/$ygridwidth));
	$q->param('type', $type);
	$q->delete($type . "mapimg.x");
	$q->delete($type . "mapimg.y");
	draw_map('-x' => $x,
		 '-y' => $y);
	goto REQUEST_DONE;
    }
}

if (defined $q->param('detailmapx') and
    defined $q->param('detailmapy') and
    defined $q->param('detailmap.x') and
    defined $q->param('detailmap.y')
   ) {
    my $c = detailmap_to_coord($q->param('detailmapx'),
			       $q->param('detailmapy'),
			       $q->param('detailmap.x'),
			       $q->param('detailmap.y'));
    if (defined $c) {
	$q->param($q->param('type') . 'c', $c);
    } else {
	$warn_message = M("F�r diese Koordinaten konnte keine Kreuzung gefunden werden.");
    }
    $q->delete('detailmapx');
    $q->delete('detailmapy');
    $q->delete('detailmap.x');
    $q->delete('detailmap.y');
    $q->delete('type');
}

# Ziel f�r stadtplandienst-kompatible Koordinaten setzen
my $set_anyc = sub {
    my($ll, $what) = @_;
    # Ob die alte ...x...-Syntax noch unterst�tzt wird, ist fraglich...
    my($long,$lat) = ($ll =~ /^[\+\ ]/
		      ? $ll =~ /^[\+\-\ ]([0-9.]+)[\+\-\ ]([0-9.]+)/
		      : split(/x/, $ll)
		     );
    if (defined $long && defined $lat) {
	local $^W;
	my($x, $y) = convert_wgs84_to_data($long, $lat);
	new_kreuzungen(); # XXX needed in munich, here too?
	$q->param($what . "c", get_nearest_crossing_coords($x,$y));
    }
};

# allow to search with wgs84 coordinates
sub enable_latlng_search {
    my $q = shift;

    foreach my $param (qw/start ziel via/) {
	my $param_c = $param . "c";

	my $value = $q->param($param) || "";
	my $street = "";

	# ignore errors in input field if the marker is outside the area
	# [Error: outside area]
	if ($value =~ /^\[.*\]$/) {
	    $value = "";
	    $q->delete($param);
        }

	# extract latlng: Mendosa Avenue [-122.46748,37.74807] -> -122.46748,37.74807
        if ($value =~ /^(.*)\s+\[([\d\.,\-\+]+)\]\s*$/) {
	   $street = $1;
	   $value = $2;
 	}

	warn "param: $param, value: $value, street: $street\n";

    	if (!defined $q->param($param_c) && is_latlng($value, 1)) {
	   my $val = get_nearest_crossing_coords(extract_latlng($value));

	   $q->param($param_c, $val);
	   $q->delete($param);
	   $q->param("_" . $param, $street);
	   warn "Do a lat,lng search for $param, $value -> $val\n" if $debug;
    	}
    }
}

&enable_latlng_search($q) if $enable_latlng_search;

# schwache stadtplandienst-Kompatibilit�t
# Note: ";" und "&" werden von CGI.pm gleichberechtigt behandelt
if (defined $q->param('STR')) {
    $q->param('ziel', $q->param('STR'));
}
if (defined $q->param('PLZ')) {
    $q->param('zielplz', $q->param('PLZ'));
}
if (defined $q->param('LL')) {
    $set_anyc->($q->param('LL'), "ziel");
}
# XXX The following two are deprecated and will be removed some day.
if (defined $q->param('startpolar')) {
    $set_anyc->($q->param('startpolar'), "start");
}
if (defined $q->param('zielpolar')) {
    $set_anyc->($q->param('zielpolar'), "ziel");
}

# Params for opensearch
if (defined $q->param("ossp") && $q->param("ossp") !~ m{^\s*$}) {
    (my $ossp = $q->param("ossp")) =~ s{^\s*}{};
    $ossp =~ s{\s*$}{};
    my @args;
    if (eval { require Text::ParseWords; 1 }) {
	@args = Text::ParseWords::shellwords($ossp);
    } else {
	warn $@;
	@args = split /\s+/, $ossp;
    }
    if (@args == 1) {
	$q->param('start', $args[0]);
    } elsif (@args == 2) {
	$q->param('start', $args[0]);
	$q->param('ziel', $args[1]);
    } elsif (@args >= 3) {
	$q->param('start', $args[0]);
	$q->param('via', $args[1]);
	$q->param('ziel', $args[2]);
	# more params will be ignored
    }
}

if (defined $q->param('begin')) {
    $q->delete('begin');
    choose_form();
} elsif (defined $q->param('info') || $q->path_info eq '/_info') {
    $q->delete('info');
    show_info();
} elsif (defined $q->param('uploadpage') ||
	 defined $q->param('gps')) {
    $q->delete('uploadpage');
    $q->delete('gps');
    upload_button();
} elsif ($is_streets) {
    $q->delete('all');
    choose_all_form();
} elsif (defined $q->param('bikepower')) {
    $q->delete('bikepower');
    call_bikepower();
} elsif (defined $q->param('nahbereich')) {
    nahbereich();
} elsif (defined $q->param('mapserver')) {
    start_mapserver();
} elsif (defined $q->param('routefile') and
	 $q->param('routefile') ne "") {
    draw_route_from_fh($q->param('routefile'));
} elsif (defined $q->param('localroutefile') &&
	 defined $local_route_dir) {
    (my $local_route_file = $q->param('localroutefile')) =~ s/[^A-Za-z0-9._-]//g;
    die "No \$local_route_dir specified in bbbike.cgi.config" if !defined $local_route_dir;
    $local_route_file = "$local_route_dir/$local_route_file";
    open(FH, $local_route_file)
	or die "Can't open $local_route_file: $!";
    draw_route_from_fh(\*FH);
} elsif (defined $q->param('localroutefilelist') &&
	 defined $local_route_dir) {
    (my $local_route_file = $q->param('localroutefilelist')) =~ s/[^A-Za-z0-9._-]//g;
    $local_route_file = "$local_route_dir/$local_route_file";
    show_routelist_from_file($local_route_file);
} elsif (defined $q->param('coords') || defined $q->param('coordssession')) {
    if ($q->param('showroutelist')) {
	# XXX note: coordssession+showroutelist is not implemented
	show_routelist_from_coords();
    } else {
	draw_route(-cache => []);
    }
} elsif (defined $q->param('create_all_maps')) {
    # XXX Der Apache 1.3.9/FreeBSD 3.3 l�sst den Prozess nach ungef�hr
    # f�nf Karten mit "Profiling timer expired" sterben. Mit thttpd
    # gibt es zwar auch mysteri�se kills, aber es geht im Gro�en und
    # Ganzen.
    #
    # Mit dem Apache auf bbbike.de gibt es keine Probleme.
    http_header(-type => 'text/plain',
		@no_cache,
	       );
    $| = 1;
    $check_map_time = 1;
    for my $x (0 .. $xgridnr-1) {
	for my $y (0 .. $ygridnr-1) {
	    print "x=$x y=$y ...\n";
	    create_map('-x' => $x,
		       '-y' => $y,
		       '-quiet'    => 1,
		       '-logging'  => 1,
		       '-strlabel' => 1,
		       '-force'    => 0,
		     );
	}
    }
    my_exit(0);
} elsif (defined $q->param('drawmap')) {
    my($x,$y) = split /,/, $q->param('drawmap');
    my %res = create_map('-x' => $x, '-y' => $y, -strlabel => 1, -force => 0);
    print CGI->redirect(-uri => $res{imgurl});
    exit 0;
} elsif (defined $q->param('startchar')) {
    choose_ch_form($q->param('startchar'), 'start', $q->param('startort'));
} elsif (defined $q->param('viachar')) {
    choose_ch_form($q->param('viachar'), 'via', $q->param('viaort'));
} elsif (defined $q->param('zielchar')) {
    choose_ch_form($q->param('zielchar'), 'ziel', $q->param('zielort'));
} elsif (defined $q->param('startc') and
	 defined $q->param('zielc')) {
    if (!$q->param('pref_seen')) {
	# zuerst die Einstellungen f�r die Suche eingeben lassen
	get_kreuzung();
    } else {
	# und erst dann suchen
	search_coord();
    }
} elsif (((defined $q->param('startname') and $q->param('startname') ne '')
	  or
	  (defined $q->param('startc') and $q->param('startc') ne '')
 	  or
	  (defined $q->param('start') and $q->param('start') ne '')
	)
	 and
	 ((defined $q->param('zielname')  and $q->param('zielname')  ne '')
	  or
	  (defined $q->param('zielc') and $q->param('zielc') ne '')
	  or
	  (defined $q->param('ziel') and $q->param('ziel') ne '')
	 )
	 and
	 (1 || via_not_needed())
	) {
    get_kreuzung();
} elsif (defined $q->param('browser')) {
    show_user_agent_info();
} elsif (defined $q->param('init_environment')) {
    http_header(-type => 'text/plain', @no_cache);
    if ($apache_session_module eq 'Apache::Session::Counted') {
	require Apache::Session::Counted;
	# XXX make configurable, see below
	Apache::Session::CountedStore->tree_init("/tmp/bbbike-sessions-$<","1");
    }
    my_exit(0);
} else {
    choose_form();
}

undef $cgic;

REQUEST_DONE:
if ($modperl_lowmem) {
    undef $q;
    undef $g_str;
    undef $orte;
    undef $orte2;
    undef $multiorte;
    %cached_plz = ();
    undef $net;
    undef $multi_bez_str;
}

my_exit 0;

# LatLng <-> LngLat
sub swap_coords {
    my $coord = shift;

    my @c = split /,/, $coord;

    return $c[1] . "," . $c[0];
}

sub abc_link {
    my($type, %args) = @_;

    if ($bi->{'mobile_device'}) {
	# we don't need any extras
    } elsif ($bi->{'text_browser'}) {
	# This is disabled for now --- it is too cumbersome to navigate
	# to the via and goal entry fields with this link list. Maybe just
	# provide a separate link to this link list.
	if (0) {
	    for my $ch ('A' .. 'Z') {
		print "<input type=submit name="
		    . $type . "char value=" . $ch . ">";
	    }
	    print "<br>\n";
	}
    } elsif ($nice_abcmap) {
	print "<input type=hidden name=\"" . $type . "charimg.x\" value=\"\">";
	print "<input type=hidden name=\"" . $type . "charimg.y\" value=\"\">";
	print "<div id=" . $type . "charbelow style=\"position:relative; visibility:hidden\">";
	print "<img src=\"$bbbike_images/abc.gif\" border=0 width=270 height=94 alt=\"\">";
	print "</div>";
	print "<div id=" . $type . "charabove style=\"position:absolute; visibility:hidden\">";
	print "<img src=\"$bbbike_images/abc_hi.gif\" border=0 width=270 height=94 alt=\"\">";
	print "</div>";
	print <<EOF;
<script type="text/javascript"><!--
function ${type}char_init() { return any_init("${type}char"); }
function ${type}char_highlight(Evt) { return any_highlight("${type}char", Evt); }
function ${type}char_byebye(Evt) { return any_byebye("${type}char", Evt); }
function ${type}char_detail(Evt) { return any_detail("${type}char", Evt); }

// --></script>

EOF
    } elsif ($nice_abc_list) {
	print "<input type=image name=" . $type
	  . "charimg src=\"$bbbike_images/abc.gif\" class=\"charmap\" alt=\"A..Z\">";
    } else {

    }
}

# XXX fullsearch is NYI
sub fullsearch_radio {
    my($type, %args) = @_;

    # XXX default/checked?
    print <<EOF;
<div style="font-size:smaller;">
<label>
  <input type="radio" name="${type}_searchin" value="b">
  Berliner Stra�en
</label>
&nbsp;&nbsp;&nbsp;
<label>
  <input type="radio" name="${type}_searchin" value="fulltext">
  Volltext
</label>
</div>
EOF
}

sub _outer_berlin_hack {
    my($street, $bezirk) = @_;
    (my $normalized_bezirk = $bezirk) =~ s{[^A-Za-z]}{_}g;
    $normalized_bezirk = lc $normalized_bezirk;
    my $outer_berlin_file = "$tmp_dir/" . $Strassen::Util::cacheprefix . "_" . $< . "_" . $normalized_bezirk . "_strassen";
    my $outer_berlin_str = eval { Strassen->new($outer_berlin_file) };
    my $landstr0 = Strassen->new("landstrassen", NoRead => 1);
    my $plaetze0 = Strassen->new("plaetze", NoRead => 1);
    if (!$outer_berlin_str || -M $outer_berlin_file > -M $landstr0->file || -M $outer_berlin_file > -M $plaetze0->file) {
	$outer_berlin_str = Strassen->new;
	my $landstr = MultiStrassen->new("landstrassen", "plaetze");
	$landstr->init;
	while(1) {
	    my $r = $landstr->next;
	    last if !@{ $r->[Strassen::COORDS] };
	    if ($r->[Strassen::NAME] =~ /\s+\(\Q$bezirk\E\)/) {
		$outer_berlin_str->push($r);
	    }
	}
	$outer_berlin_str->write($outer_berlin_file);
    }
    my $pos = $outer_berlin_str->choose_street($street, $bezirk);
    my $name;
    if (defined $pos) {
	$name = $outer_berlin_str->get($pos)->[Strassen::NAME];
	upgrade_scope("region");
#XXX del?
# 	my $scope = $q->param("scope");
# 	if (!$scope || $scope eq "city") {
# 	    $q->param("scope", "region"); # XXX increment_scope?
# 	}
    }
    $name;
}

sub get_weather_coords {
    my @weather_coords;

    my $geo = get_geography_object();

    if ( $geo->is_osm_source && exists $geo->{'bbox_wgs84'} ) {
        my @list = @{ $geo->{'bbox_wgs84'} };
        my $area = "$list[0],$list[1]!$list[2],$list[3]";
        my @center =
          exists $geo->{'center'}
          ? @{ $geo->{'center'} }
          : @{ $geo->{'bbox_wgs84'} };
        @weather_coords = ( $center[1], $center[0] );
    }

    return @weather_coords;
}

sub get_bbox_wgs84 {
    my @box;

    my $geo = get_geography_object();

    if ( $geo->is_osm_source && exists $geo->{'bbox_wgs84'} ) {
        my @list = @{ $geo->{'bbox_wgs84'} };
	return @list;
    }
}

# extract the new streetname from input
# "old streetname -> new streetname" => new streetname
sub old_new_streetname {
   my $street = shift;

   my $s = $street;
   $street =~ s,.*?[=\-]>\s+,,;

   if ($debug && $s ne $street) {
      warn "Rewrite street name: '$s' to '$street'\n";
   }

   return $street;
}

sub Param {
    my $name = shift;

    if (&is_forum_spam($q, $name)) {
	warn caller;
	return "";
    }

    my $val = $q->param($name);
    $val = &old_new_streetname($val);
    $val =~ s/^\s+//;
    $val =~ s/\s+$//;

    return $val;
}

sub is_latlng{
   my $latlng = shift;
   my $flag = shift;

   # lat,lng,flag
   if ($flag && $latlng =~ /,.+,/) {
	$latlng =~ s/,[^,]+\s*$//;
   }
	
   return $latlng =~ /^\s*[\+\-]?[\d\.]+,[\+\-]?[\d\.]+\s*$/ ? 1 : 0;
}

sub extract_latlng{
    my $latlng = shift;

    $latlng =~ s/^\s+//;
    $latlng =~ s/\s+$//;

    my @pos = split /,/, $latlng;
    return if scalar(@pos) < 2;

    if ($pos[0] =~ /^[\+\-]?[\d\.]+$/ && $pos[1] =~ /^[\+\-]?[\d\.]+$/) {
	warn "LatLng type: $pos[2] $pos[0],$pos[1]\n" if $debug && scalar(@pos) >2;
        return join (",", $pos[0], $pos[1]);
    }
}

sub is_forum_spam {
   my $q = shift;
   my @param = @_;

   my $flag = 0;
   foreach my $param (@param) {
        my $val = $q->param($param);
    	if ($val =~ /[<]/ || $val =~ m,http://,) {
	   $flag++;
	   warn "XSS parameter: '$param'\n" if $debug;
	   $q->param($param, "");
	}
   }
   return $flag;
}

sub choose_form {

    my $startname = Param('startname') || '';
    my $start2    = Param('start2')    || '';
    my $start     = Param('start')     || '';
    my $startplz  = Param('startplz')  || '';
    my $starthnr  = Param('starthnr')  || '';
    my $startc    = Param('startc')    || '';
    my $startort  = Param('startort')  || '';

    my $vianame   = Param('vianame')   || '';
    my $via2      = Param('via2')      || '';
    my $via       = Param('via')       || ($use_via ? '' : 'NO');
    my $viaplz    = Param('viaplz')    || '';
    my $viahnr    = Param('viahnr')    || '';
    my $viac      = Param('viac')      || '';
    my $viaort    = Param('viaort')    || '';

    my $zielname  = Param('zielname')  || '';
    my $ziel2     = Param('ziel2')     || '';
    my $ziel      = Param('ziel')      || '';
    my $zielplz   = Param('zielplz')   || '';
    my $zielhnr   = Param('zielhnr')   || '';
    my $zielc     = Param('zielc')     || '';
    my $zielort   = Param('zielort')   || '';

    my $nl = sub {
	if ($bi->{'can_table'}) {
	    print "<tr><td>&nbsp;</td></tr>\n";
	} else {
	    print "<p>\n";
	}
    };
    my $tbl_center_under_inputs = sub {
	my $text = shift;
	my $align = shift || "center";
	if ($bi->{'can_table'}) {
	    print "<tr><td colspan=2 align=$align>$text</td></tr>\n";
	} else {
	    print "<center>$text</center>\n";
	}
    };

    # This is needed if the user first types a street name and then
    # chooses the detailmap:
    undef $start if $startc;
    undef $via   if $viac;
    undef $ziel  if $zielc;

    # Namen und Koordinaten der Start...orte
    # XXX This is currently broken, and probably I should remove it...
    my($startoldort, $viaoldort, $zieloldort,
       $startortc, $viaortc, $zielortc);

    # Leerzeichen am Anfang und Ende l�schen
    # �berfl�ssige Leerzeichen in der Mitte l�schen
    if (defined $start) {
	$start =~ s/^\s+//; $start =~ s/\s+$//; $start =~ s/\s{2,}/ /g;
    }	
    if (defined $via) {
	$via   =~ s/^\s+//; $via   =~ s/\s+$//; $via   =~ s/\s{2,}/ /g;
    }
    if (defined $ziel) {
	$ziel  =~ s/^\s+//; $ziel  =~ s/\s+$//; $ziel  =~ s/\s{2,}/ /g;
    }

    foreach ([\$startname, \$start2, \$startoldort, \$startortc, 'start'],
	     [\$vianame,   \$via2,   \$viaoldort,   \$viaortc,   'via'],
	     [\$zielname,  \$ziel2,  \$zieloldort,  \$zielortc,  'ziel'],
	) {
	my  (  $nameref,    $tworef,  $ortref,    $ortcref,   $type) = @$_;
	# �berpr�fen, ob eine in PLZ vorhandene Stra�e auch in
	# Strassen vorhanden ist und ggfs. $....name setzen
	if ($$nameref eq '' && $$tworef ne '') {
	    my(@s) = split(/$delim/o, $$tworef);
	    if ($s[1] eq '#ort') {
		my($ortname, $xy) = ($s[0], $s[2]);
		$$ortref  = $ortname;
		$$ortcref = $xy;
	    } else {
		my($strasse, $bezirk, $plz) = @s;
		warn "W�hle $type-Stra�e f�r $strasse/$bezirk (1st)\n" if $debug;
		if ($bezirk =~ $outer_berlin_qr) {
		    my $name = _outer_berlin_hack($strasse, $bezirk);
		    if ($name) {
			$$nameref = $name;
			$q->param($type . 'plz', $plz);
		    }
		} else {
		    my $str = get_streets();
		    my $pos = $str->choose_street($strasse, $bezirk);
		    if (!defined $pos) {
			# Can't use upgrade_scope here:
			if ($str->{Scope} eq 'city') {
			    warn "Enlarge streets for umland\n" if $debug;
			    $q->param("scope", "region");
			    $str = get_streets_rebuild_dependents(); # XXX maybe wideregion too?
			}
			$pos = $str->choose_street($strasse, $bezirk);
		    }
		    if (defined $pos) {
			$$nameref = $str->get($pos)->[0];
			$q->param($type . 'plz', $plz);
		    }
		}
	    }
	}
    }

    # Es ist alles vorhanden, keine Notwendigkeit f�r ein Formular.
  TRY: {
	if (((defined $startname && $startname ne '') ||
	     (defined $startoldort  && $startoldort ne '')) &&
	    ((defined $zielname  && $zielname ne '') ||
	     (defined $zieloldort   && $zieloldort ne ''))) {
	    last TRY if (((defined $via2 && $via2 ne '') ||
			  (defined $via  && $via  ne '' && $via ne 'NO')) &&
			 ((!defined $vianame || $vianame eq '') &&
			  (!defined $viaoldort  || $viaoldort eq '')));

	    foreach ([\$startoldort, \$startortc, \$startname, 'start'],
		     [\$viaoldort,   \$viaortc,   \$vianame,   'via'],
		     [\$zieloldort,  \$zielortc,  \$zielname,  'ziel']) {
		my $ortref  = $_->[0];
		my $ortcref = $_->[1];
		my $nameref = $_->[2];
		my $type    = $_->[3];
		if ((!defined $$ortref || $$ortref ne '') and
		    defined $$ortcref) {
		    new_kreuzungen(); # XXX needed in munich, here too?
		    my($best) = get_nearest_crossing_coords(split(/,/, $$ortcref));
		    $q->param($type . 'isort', 1);
		    $q->param($type . 'c', $best);
		    $q->param($type . 'name', $$ortref);
		    $$nameref = $$ortref;
		}
	    }

	    if (0 && # XXX preferences-seite!
		$q->param("startc") and $q->param("zielc") and
		((!defined $vianame || $vianame eq '') ||
		 ($q->param("viac")))) {
		search_coord();
	    } else {
		warn "W�hle Kreuzung f�r '$startname' und '$zielname' (1st)\n"
		    if $debug;
		get_kreuzung($startname, $vianame, $zielname);
	    }
	    return;
	}
    }

    my $prefer_png = 0;
    # Activate only for tested platforms
    # XXX what about Opera?
    if ($bi->{'can_dhtml'} && !$bi->{'dhtml_buggy'} &&
	$bi->{'can_javascript'} && !$bi->{'text_browser'}) {
	if (($bi->is_browser_version("Mozilla", 4.5, 4.9999) &&
	     $bi->{'user_agent_os'} =~ /(freebsd|linux|windows|winnt)/i) ||
	    (defined $bi->{'gecko_version'} &&
	     ($bi->{'gecko_version'} >= 20020000 ||
	      $bi->{'gecko_version'} == 0))
	   ) {
	    $nice_berlinmap = $nice_abcmap = 1;
	    $prefer_png = 1;
	} elsif ($bi->is_browser_version("MSIE", 5.0, 9999999)) { # mit IE 8 getestet
	    $nice_berlinmap = $nice_abcmap = 1;
	    # png was for long time unsupported by IE
	} elsif ($bi->is_browser_version("Opera", 9.0, 9999999)) { # mit 9.80 getestet
	    $nice_berlinmap = $nice_abcmap = 0; # the multiple street chooser would work, but cannot be set separately from $nice_berlinmap
	    $prefer_png = 1;
	} elsif ($bi->is_browser_version("Opera", 7.0, 7.9999)) { # Mit 8.x wird nur einmalig beim Enter gehighlighted
	    $prefer_png = 1;
	} elsif ($bi->is_browser_version("Konqueror", 3.0, 3.9999)) { # still broken with 3.5
	    $nice_berlinmap = $nice_abcmap = 0;
	    $prefer_png = 1;
	} elsif ($bi->is_browser_version("Safari", 419, 9999999)) {
	    $nice_berlinmap = $nice_abcmap = 1;
	    $prefer_png = 1;
	}
    }

    if ($osm_data ) {
    	$nice_berlinmap = 0;
	$nice_abcmap = 0;
    }

    my(@start_matches, @via_matches, @ziel_matches);
 MATCH_STREET:
    foreach ([\$startname,\$start,\$start2,\@start_matches,'start',\$startplz, $startort],
	     [\$vianame,  \$via,  \$via2,  \@via_matches,  'via',  \$viaplz,   $viaort],
	     [\$zielname, \$ziel, \$ziel2, \@ziel_matches, 'ziel', \$zielplz,  $zielort],
	    ) {
	my  (  $nameref,  $oneref,$tworef, $matchref,      $type,  $zipref,    $ort)=@$_;
	local $^W = 0; # too many defined checks missing...

	# Darstellung eines Vias nicht erw�nscht
	next if ($type eq 'via' and $$oneref eq 'NO');

## The idea behind this block: if only the place was selected (without
## a particular street), then choose the center of the place.
## Unfortunately this breaks currently the "Zur�ck zum
## Eingabeformular" from a abc page, so it's commented out currently.
## XXX
# 	if ($$nameref eq '' && $$oneref eq '' && defined $ort && $ort =~ $outer_berlin_qr) {
# 	    my $orte = get_orte();
# 	    my $coords;
# 	    eval {
# 		$orte->grepstreets(sub {
# 				       my($name) = $_->[Strassen::NAME] =~ m{^([^|]+)};
# 				       if ($name eq $ort) {
# 					   $coords = $_->[Strassen::COORDS][0];
# 					   die "break loop";
# 				       }
# 				   });
# 	    };
# 	    if ($coords) {
# 		$q->param($type.'c', $coords);
# 		$$nameref = $ort;
# 		next;
# 	    }
# 	}
    
    if ($osm_data ) {
	if ($$nameref eq '' && $$oneref ne '') {
	    my $str = get_streets();
            $str->{File} = "strassen";
		
	    my @res = $str->agrep($$oneref, 'utf8_database' => $osm_data, 'unique' => $osm_data, 'debug' => $debug);
	    warn "agrep result: ", Dumper(\@res), "\n" if $debug;

	    my @matches;
	    foreach my $res (@res) {
		my $ret = $str->get_by_name($res);
                if ($ret) {
                    my($street, $citypart) = Strasse::split_street_citypart($res);
                    push @matches, [$res, "", undef, undef]; #$ret->[1][0]];
                } else {
                    warn "XXX: unknown street: '$res'\n";
                }
	    }

	    if (@matches == 1) {
                $$oneref = $res[0];
                $$nameref = $res[0];

	        warn "nameref: $$nameref\n" if $debug;;
	    } else {
		@$matchref = @matches;
		warn "matches: ", Dumper(\@matches), "\n";
	    }

	    next;
	}
    }

	# �berpr�fen, ob eine Stra�e in PLZ vorhanden ist.
	if ($$nameref eq '' && $$oneref ne '') {
	    my $plz_scope = (defined $ort && $ort =~ $outer_berlin_qr ? $ort : "Berlin/Potsdam");
	    my $plz_obj = init_plz(scope => $plz_scope);
	    if (!$plz_obj) {
		# Notbehelf. PLZ sollte m�glichst installiert sein.
		my $str = get_streets();
		my @res = $str->agrep($$oneref, 'utf8_database' => $osm_data, 'uniqe' => $osm_data);
		if (@res) {
		    $$nameref = $res[0];
		}
		next;
	    }

	    warn "Suche '$$oneref' in der PLZ-DB.\n" if $debug;

	    # check for given crossings
	    my $crossing_street;
	    # XXX is it OK to change the referred value?
	    ($$oneref, $crossing_street) = Strasse::split_crossing($$oneref);

	    my @extra;
	    if ($$zipref ne '') {
		push @extra, Citypart => [ split /\s*,\s*/, $$zipref ];
	    }
	    next if $$oneref =~ /^\s*$/;
	    $$oneref = PLZ::norm_street($$oneref);
	    my @look_loop_args = (PLZ::split_street($$oneref),
				  @extra,
				  Max => $max_plz_streets,
				  MultiZIP => 1, # introduced because of Hauptstr./Friedenau vs. Hauptstr./Sch�neberg problem
				  MultiCitypart => 1, # works good with the new combine method
				  Agrep => 'default');
	    #warn "\$plz_obj->look_loop(@look_loop_args)\n";
	    my($retref, $matcherr) = $plz_obj->look_loop(@look_loop_args);
	    #require Data::Dumper; warn Data::Dumper->new([$retref, $matcherr],[qw()])->Indent(1)->Useqq(1)->Dump;

	    @$matchref = grep { defined $_->[PLZ::LOOK_COORD()] && $_->[PLZ::LOOK_COORD()] ne "" } @$retref;
	    # XXX needs more checks, but seems to work good
	    # except in the cases, where the same street has different coordinates
	    # see Ackerstr. Mitte/Wedding
	    # solution: use multi_bez_str!
	    @$matchref = map { $plz_obj->combined_elem_to_string_form($_) } $plz_obj->combine(@$matchref);
	    {
		my %seen;
		@$matchref = grep {
		    if ($same_single_point_optimization{$_->[PLZ::LOOK_INDEX()]||""}) {
			if ($seen{$_->[PLZ::LOOK_COORD()]}) {
			    0;
			} else {
			    $seen{$_->[PLZ::LOOK_COORD()]}++;
			    1;
			}
		    } else {
			1;
		    }
		} @$matchref;
	    }
	    if (@$matchref == 0 && $plz_scope eq 'Berlin/Potsdam') {
		# Nichts gefunden. In folgenden Dateien nachschauen (aber nur f�r Berlin/Potsdam)
		#   Pl�tze-Datei
		#   Strassen-Datei (weil einige Stra�en nicht in der PLZ-Datei stehen)
		#
		for my $def (
			     [sub { Strassen->new("plaetze") }, "Pl�tze-Datei"],
			     [sub { get_streets() }, "Stra�en-Datei"],
			    ) {
		    my($producer, $label) = @$def;
		    if (my $str = $producer->()) {
			warn "Suche '$$oneref' in der $label.\n" if $debug;
			my @res = $str->agrep($$oneref, 'utf8_database' => $osm_data, 'uniqe' => $osm_data);
			if (@res) {
			    my @matches;
			    for my $res (@res) {
				my $ret = $str->get_by_name($res);
				if ($ret) {
				    my($street, $citypart) = Strasse::split_street_citypart($res);
				    push @matches, [$street, $citypart, undef, $ret->[1][0]];
				}
			    }
			    if (@matches == 1) {
				$$nameref = $matches[0]->[PLZ::LOOK_NAME()];
				$q->param($type . 'c', $matches[0]->[PLZ::LOOK_COORD()]);
			    } else {
				@$matchref = @matches;
			    }

			    if (@matches) {
				last;
			    }
			}
		    }
		}

		next MATCH_STREET;
	    }

	    # If this is a crossing, then get the exact point, but don't fail
	    if (defined $crossing_street) {
		# first: get all matching Strasse objects (first part)
		my $rx = "^(" . join("|", map { quotemeta($_->[&PLZ::LOOK_NAME]) } @$matchref) . ")";
		my $str = get_streets();
		my @matches = grep {
		    $_->[Strassen::NAME] =~ /$rx/i
		} $str->get_all;
		if (@matches) {
		    all_crossings();
		    # now search for crossings
		    foreach my $r (@matches) {
			foreach my $c (@{$r->[Strassen::COORDS]}) {
			    if (exists $crossings->{$c}) {
				# is this the right crossing?
				foreach my $test_crossing_street (@{$crossings->{$c}}) {
				    if ($test_crossing_street =~ /^\Q$crossing_street\E/i) {
					$$nameref = nice_crossing_name(@{$crossings->{$c}});
					$q->param($type . 'c', $c);
					next MATCH_STREET;
				    }
				}
			    }
			}
		    }
		}
	    }

	    # �berpr�fen, ob es sich bei den gefundenen Stra�en um die
	    # gleiche Stra�e, die durch mehrere Bezirke verl�uft, handelt,
	    # oder ob es mehrere Stra�en in mehreren Bezirken sind, die nur
	    # den gleichen Namen haben.
	    if (@$matchref > 1) {
	      TRY: {
		    my $first = $matchref->[0][0];
		    for(my $i = 1; $i <= $#$matchref; $i++) {
			if ($first ne $matchref->[$i][0]) {
			    last TRY;
			}
		    }
		    # alle Stra�ennamen sind gleich
		    if (!$multi_bez_str) {
			$multi_bez_str = new MultiBezStr;
		    }
		    if ($multi_bez_str) {
			my %bezirk;
			foreach ($multi_bez_str->bezirke($first)) {
			    $bezirk{$_}++;
			}
			foreach my $match (@$matchref) {
			    my(@bezirke) = split /\s*,\s*/, $match->[1]; # may be "Britz, Buckow, Rudow"
			    for my $bezirk (@bezirke) {
				last TRY if !exists $bezirk{$bezirk};
			    }
			}
			splice @$matchref, 1;
		    }
		}
	    }

	    if ($multiorte) {
		my @orte = $multiorte->agrep($$oneref, Agrep => $matcherr, 'utf8_database' => $osm_data, 'uniqe' => $osm_data);
		if (@orte) {
		    use constant MATCHREF_ISORT_INDEX => 5;
		    push @$matchref, map { [$_, undef, undef, undef, undef, 1] } @orte;
		}
	    }

	    if (@$matchref == 1 && $is_usable_without_strassen{$matchref->[0][PLZ::LOOK_INDEX()]||""}) {
		$$nameref = $matchref->[0][PLZ::LOOK_NAME()];
		$$tworef = join($delim, @{$matchref->[0]});
		$q->param($type . 'c', $matchref->[0][PLZ::LOOK_COORD()]);
	    } elsif (@$matchref == 1) {
		my $match = $matchref->[0];
		my($strasse, $bezirk) = ($match->[PLZ::LOOK_NAME()],
					 $match->[PLZ::LOOK_CITYPART()]);
		warn "W�hle $type-Stra�e f�r $strasse/$bezirk (2nd)\n"
		    if $debug;
		if ($bezirk =~ $outer_berlin_qr) {
		    my $name = _outer_berlin_hack($strasse, $bezirk);
		    if ($name) {
			$$nameref = $name;
			$q->param($type . 'plz', $match->[PLZ::LOOK_ZIP()]);
		    } else {
			$$tworef = join($delim, @$match);
		    }
		} else {
		    my $str = get_streets();
		    my $pos = $str->choose_street($strasse, $bezirk);
		    if (!defined $pos) {
			# Can't use upgrade_scope here
			if ($str->{Scope} eq 'city') {
			    warn "Enlarge streets for umland\n" if $debug;
			    $q->param("scope", "region");
			    $str = get_streets_rebuild_dependents(); # XXX maybe wideregion too?
			}
			$pos = $str->choose_street($strasse, $bezirk);
		    }
		    if (defined $pos) {
			$$nameref = $str->get($pos)->[0];
			$q->param($type . 'plz', $match->[PLZ::LOOK_ZIP()]);
		    } else {
			$$tworef = join($delim, @$match);
		    }
		}
	    }
	}
    }

    # Es ist alles vorhanden, keine Notwendigkeit f�r ein Formular.
  TRY: {
	if ($startname ne '' && $zielname ne '') {
	    last TRY if (((defined $via2 && $via2 ne '') ||
			  (defined $via  && $via  ne '')) &&
			 (!defined $vianame || $vianame eq ''));
	    warn "W�hle Kreuzung f�r '$startname' und '$zielname' (2nd)\n"
	      if $debug;
	    get_kreuzung($startname, $vianame, $zielname);
	    return;
	}
    }

    my %header_args = @weak_cache;
    $header_args{-expires} = '+6d';
    http_header(%header_args);
    my @extra_headers;

    if ($bi->{'text_browser'} && !$bi->{'mobile_device'}) {
	push @extra_headers, -up => $BBBike::HOMEPAGE;
    }

    my $onloadscript = "";

    if ($nice_berlinmap || $nice_abcmap) {
	$onloadscript .= "init_hi(); window.onresize = init_hi; "
    }
    $onloadscript .= "focus_first(); ";
    $onloadscript .= "check_locate_me(); ";

    if ($nice_berlinmap || $nice_abcmap) {
	push @extra_headers, -onLoad => $onloadscript,
	     -script => [{-src => $bbbike_html . "/bbbike_start.js"},
			 ($nice_berlinmap
			  ? {-code => qq{set_bbbike_images_dir('$bbbike_images')}}
			  : ()
			 ),
			],
    }

    my $show_introduction;
    {
	local $^W = 0;
	$show_introduction = (#$start eq ''  && $ziel eq '' &&
			      #$start2 eq '' && $ziel2 eq '' &&
			      #$startname eq '' && $zielname eq '' &&
			      #$startc eq '' && $zielc eq '' &&
			      !$smallform &&
			      !$warn_message);
    }

    push (@extra_headers, -google_analytics_uacct => 1) if is_startpage($q);

    header(@extra_headers, -from => $show_introduction ? "chooseform-start" : "chooseform");

    print <<EOF if ($bi->{'can_table'});
<div id="routing">
<table>
<tr>
EOF

    if ($show_introduction && !$no_teaser) {
	load_teaser() if !$no_teaser_right;

	# use "make count-streets" in ../data
	print <<EOF if ($bi->{'can_table'});
<td valign="top">@{[ blind_image(120,1) ]}<br>
EOF
	# Eine Addition aller aktuellen Stra�en, die bei luise-berlin
	# aufgef�hrt sind, ergibt als Summe 10129
	# Da aber auch einige "unoffizielle" Wege in der DB sind, d�rften es an die 11000 werden
	my($bln_str, $all_bln_str, $pdm_str) = (10500, 11000, 420);
	# XXX Use format number to get a comma in between.

	my $city = ($osm_data && $datadir =~ m,data-osm/(.+),) ? $1 : 'Berlin';

	sub social_link {
	    print qq{<span id="social">\n};
	    print qq{<a href="$facebook_page" target="_new"><img class="logo" width="16" height="16" src="/images/facebook-t.png" alt="" title="}, M("Facebook Fanpage"), qq{"></a>\n} if $enable_facebook_t_link;
	    print qq{<a href="http://twitter.com/BBBikeWorld" target="_new"><img class="logo" width="16" height="16" src="/images/twitter-t.png" alt="" title="}, M("Folge uns auf twitter.com/BBBikeWorld"), qq{"></a>\n} if $enable_twitter_t_link;
	    print qq{<a class="gplus" onmouseover="javascript:google_plusone();" ><img src="/images/google-plusone-t.png" alt=""></a><g:plusone href="http://bbbike.org" size="small" count="false"></g:plusone>\n} if $enable_google_plusone_t_link;
	    print qq{</span>\n};
	}

	print qq{<span id="mobile_link">\n};
	if (is_mobile($q)) {
	    my $url = $q->url(-full=>0, -absolute=>1);
	    $url =~ s,^/m/,/,;
	    &social_link;
	    print qq{<a class="mobile_link" href="$url" title="}, M("BBBike in classic view"), qq{">[classic view]</a>\n};
        } else {
	    my $url = $q->url(-full=>0, -absolute => 1);
	    $url =~ s,^/\w\w/,/m/, || $url =~ s,/,/m/,;

	    my $class = $q->user_agent =~ /iPhone|Android|iPod|Nokia|Symbian|BlackBerry|SonyEricsson|Samsung/ ? "mobile_link_mobile" : "mobile_link";
	    &social_link;

	    print qq{<a class="$class logo" href="$url" title="}, M("BBBike for mobile devices"), qq{"><img class="logo" width="16" height="16" alt="" src="/images/phone.png">[}, M("mobil"), qq{]</a>\n};
	    print "&nbsp;" x 15;
	    print qq{<a style="font-size:small" title="}, M("Karte nach rechts schieben"), qq{" href="javascript:smallerMap(1.5)">&gt;&gt;</a>\n};
	    print qq{<a style="font-size:small" title="}, M("Karte nach links schieben"), qq{" href="javascript:smallerMap(-1.5)">&lt;&lt;</a>\n};
        }
	print qq{</span>\n};

         print "<p>\n", M("Willkommen beim Radroutenplaner BBBike! Wir helfen Dir, eine sch�ne, sichere und kurze Fahrradroute in") .
	    " <i title='$city'>$local_city_name</i> ",  
	    M("und Umgebung zu finden."), "<br></p>\n";

	print <<EOF if ($bi->{'can_table'});
</td>
<td rowspan="3" valign="top" @{[ $start_bgcolor ? "bgcolor=$start_bgcolor" : "" ]}>@{[ defined &teaser && !$bi->{'css_buggy'} ? teaser() : "" ]}</td>
</tr><tr>
EOF

	print "<td>" if ($bi->{'can_table'});

        if ($bi->{'text_browser'}) {
	    if ($lang eq 'en') {
		print "Choose ";
	    }
            printf q{<a name="navig"></a><a href="#start">%s</a>}, M("Start-");
            unless ($via eq 'NO') {
		printf q{, <a href="#via">%s</a> }, M("Via- (optional)");
	    }
	    if (defined $lang && $lang eq 'en') {
		print <<EOF;
and <a href="#ziel">Destination street</a>
and then <a href="#weiter">go on</a>:<p>
EOF
	    } else {
		print <<EOF;
und <a href="#ziel">Zielstra&szlig;e</a>
der Route ausw&auml;hlen und dann <a href="#weiter">weiter</a>:<p>
EOF
	    }
        } else {
	    if ($nice_berlinmap) {
		print "<noscript>" . M("Die Aktivierung von Javascript und CSS ist empfehlenswert, aber nicht notwendig.") . "<p></noscript>\n";
	    }

            print qq{<span id="housenumber">} . "&nbsp;" . M("Start- und Zielstra&szlig;e der Route eingeben (ohne Hausnummer!)") . ":" . "</span>\n";
	    # unless ($via eq 'NO') { print " (" . M("Via ist optional") . ")" }
	    #if ($osm_data && $datadir =~ m,data-osm/(.+),) {
	    #	print qq[, ], M("Stadt"), qq[: $1\n];
	    #}
	    #print "<br />\n";
        }

	print "</td></tr><tr>" if ($bi->{'can_table'});

    }

    if ($warn_message) {
	print "<div class='error'>".CGI::escapeHTML($warn_message)."</div>\n";
    }

    print "<td>" if ($bi->{'can_table'});

    print qq{
                        <form action="bbbike2.cgi" id="searchform"><div>
                                <input id="searchInput" name="startname" type="text" title="" value="" size="30"/>
                                <input type='submit' name="go" class="searchButton" id="searchGoButton" value="Strasse" title="Gehe direkt zu der Seite, die exakt dem eingegebenen Namen entspricht." />&nbsp;
                        </div></form>} if 0;


    print qq{<form id="searchform" action=\"$bbbike_script\" name=BBBikeForm>\n};

    # Hack for browsers which use the first button, regardless whether it's
    # image or button, for firing in a <Return> event
    # XXX Does not work for Opera, Safari and MSIE are untested...
    if ($bi->{user_agent_name} =~ /^(konqueror|safari|opera|msie)/i) {
	print <<EOF;
<input type="submit" value="@{[ M("Weiter") ]}" style="text-align:center;visibility:hidden"/>
EOF
    }

    
    print "<table id=inputtable>\n" if ($bi->{'can_table'});

    my $shown_unknown_street_helper = 0;

    foreach
      ([\$startname, \$start, \$start2, \$startoldort, \@start_matches, 'start',
	$start_bgcolor, \$startort],
       [\$vianame,   \$via,   \$via2,   \$viaoldort,   \@via_matches,   'via',
	$via_bgcolor,   \$viaort],
       [\$zielname,  \$ziel,  \$ziel2,  \$zieloldort,  \@ziel_matches,  'ziel',
	$ziel_bgcolor,  \$zielort]) {
	my($nameref,  $oneref, $tworef,  $oldortref,    $matchref,       $type,
	   $bgcolor,    $ortref) = @$_;
	my $bgcolor_s = $bgcolor ne '' ? "bgcolor=$bgcolor" : '';
	my $coord     = $q->param($type . "c");
	my $has_init_map_js;

	# Darstellung eines Vias nicht erw�nscht
	if ($type eq 'via' and $$oneref eq 'NO') {
	    print qq{<tr style="display:none"><td><input type="hidden" name="via" value="NO"></td></tr>};
	    next;
	}

	my $printtype = ucfirst($type);
	my $imagetype = "$bbbike_images/" . M($type) . "." . ($prefer_png ? "png" : "gif");
	my $tryempty  = 0;
	my $no_td     = 0;

        # print "XXX";
	if ($bi->{'can_table'}) {
	    my $style = $type eq 'via' && $enable_via_hide ? qq{ style="display:none"} : "";

	    print qq{<tr id=${type}tr $style $bgcolor_s><td align=center valign=middle width=40><a name="$type"><img } . (!$bi->{'css_buggy'} ? qq{style="padding-bottom:8px;" } : "") . qq{src="$imagetype" border=0 alt="} . M($printtype) . qq{"></a></td>};
	    my $color = {'start' => '#e0e0e0',
			 'via'   => '#c0c0c0',
			 'ziel'  => '#a0a0a0',
			}->{$type};
#XXX not yet:	    print "<td bgcolor=\"$color\">" . blind_image(1,1) . "</td>";
	} else {
	    print "<a name=\"$type\"><b>" . M($printtype) . "</b></a>: ";
	}
	if ((defined $$nameref and $$nameref ne '') ||
	    (defined $coord and $coord ne '')) {
	    print "<td valign=middle>$fontstr" if $bi->{'can_table'};
	    if (defined $coord) {
		print "<input type=hidden name=" . $type . "c value=\""
		  . $coord . "\">\n";
	    }
	    if ($q->param($type . "isort")) {
		print "<input type=hidden name=" . $type . "isort value=1>\n";
	    }
	    if (defined $coord and (!defined $$nameref or $$nameref eq '')) {
		print crossing_text($coord);
	    } else {
		print "$$nameref";
		if ($$ortref &&
		    index(reverse($$nameref), reverse("$$ortref)")) != 0 # this means: $$ortref is not at the end of $$nameref (but this seems always the case in bbbike.de/beta)
		   ) {
		    print " ($$ortref)";
		}
		print "\n";
	    }
	    print "<input type=hidden name=" . $type
	      . "name value=\"$$nameref\">\n";
	    if ($$ortref) {
		print "<input type=hidden name=" . $type
		    . "ort value=\"$$ortref\">\n";
	    }
	    if (defined $q->param($type . "plz")) {
		print "<input type=hidden name=${type}plz value=\""
		  . $q->param($type . "plz") . "\">\n";
	    }
	    if (defined $q->param($type . "hnr")) {
		print "<input type=hidden name=${type}hnr value=\""
		    . $q->param($type."hnr") . "\">\n";
	    }

	    print "$fontend</td>\n" if $bi->{'can_table'};

	    if ($nice_berlinmap && $bi->{'can_table'}) {
		print "<td>";
		if (!@$matchref) { # XXX why?
		    $matchref = [[$$nameref, undef, undef, $coord]];
		}
		require PLZ; # XXX why?
		berlinmap_with_choices($type, $matchref);
		$has_init_map_js++;
		print "</td>";
	    }

	} elsif (defined $$oldortref and $$oldortref ne '') {
	    print "<td valign=middle>$fontstr" if $bi->{'can_table'};
	    print "$$oldortref\n";
	    print "<input type=hidden name=" . $type . "2 value=\""
		  . $$tworef . "\">\n";
	    print "</td>" if $bi->{'can_table'};
	    print "<input type=hidden name=" . $type . "isort value=1>\n";
	} elsif ($$oneref ne '' && @$matchref == 0) {
	    print "<td>$fontstr" if $bi->{'can_table'};
	    print "<i>$$oneref</i> ";
	    if ($$ortref && $$ortref ne 'Berlin/Potsdam') {
		print "in <i>$$ortref</i> ";
	    }
	    print M("ist nicht bekannt") . ".<br>\n";
	    my $geo = get_geography_object();
	    if (!$geo || !$geo->is_osm_source) {
		if (!$shown_unknown_street_helper) {
		    # Check if the given streetname is completely
		    # unusable and very unlikely to contain a new
		    # street.
		    my $is_maybe_usable = ($$oneref !~ m{\b\d{5}\b} # keine PLZ
					   && $$oneref !~ m{\b(?:Berlin|Potsdam)\b}i
					   && $$oneref !~ m{,}
					  );
		    if ($lang eq 'en') {
			print <<EOF;
<p>
Checklist:
<ul>
<li>Check the correct spelling of the street name.
<li>Do not use house numbers, postcodes, place and suburb names!
<li>The BBBike database only contains streets from Berlin and Potsdam.
<li>Only most important Berlin sights are available through this interface.
</ul>
<p>
EOF
			if ($is_maybe_usable) {
			    print <<EOF;
<p>
Nothing applies? Then use the email link below and contribute information
for this street.
</p>
EOF
			}
		    } else {
			print <<EOF;
<p>
Checkliste:
<ul>
<li>Wurde der Stra�enname richtig geschrieben?
<li>Hausnummern, Bezirksnamen, Postleitzahlen und Ortsnamen d�rfen nicht angegeben werden!
<li>In der Datenbank befinden sich nur Berliner und Potsdamer Stra�en!
<li>Nur die wichtigsten Berliner Sehensw�rdigkeiten k�nnen verwendet werden.
</ul>
</p>
EOF
			if ($is_maybe_usable) {
			    print <<EOF;
<p>
Ansonsten: Informationen zu dieser Stra�e �ber den E-Mail-Link unten melden.
</p>
EOF
			}
		    }
		    $shown_unknown_street_helper = 1;
		}

		if (0) {
		    # Don't show anymore the newstreetform link in
		    # this situation, too many false entries. The user
		    # can you the contact link if he thinks otherwise.

		    my $qs = CGI->new({strname => $$oneref,
				       ($$ortref ? (ort => $$ortref) : ()),
				      })->query_string;
		    print qq{<a target="newstreetform" href="$bbbike_html/newstreetform${newstreetform_encoding}.html?$qs">} . M("Diese Stra�e neu in die BBBike-Datenbank eintragen") . qq{</a><br><br>\n} if !$osm_data;
		    print M(qq{Oder einen anderen Stra�ennamen versuchen}) . qq{:<br>\n};
		} else {
		    #warn "*** Avoid unusable newstreetform mail for <$$oneref>\n";
		    print M(qq{Einen anderen Stra�ennamen versuchen}) . qq{:<br>\n};
		}
	    } else {
	        if ($$oneref =~ /^\s*\d+\w?\s+/ || $$oneref =~ /\s+\d+\w?\s*$/ ) {
		    print M(qq{Bitte keine <b>Hausnummer</b> eingeben}) . qq{!<br>\n};
		}
		print M(qq{Einen anderen Stra�ennamen versuchen}) . qq{:<br>\n};
	    }
	    $no_td = 1;
	    $tryempty = 1;
	} elsif ($$tworef ne '') {
	    my($strasse, $bezirk, $plz, $xy, $index) = split(/$delim/o, $$tworef);
	    if ($bezirk eq 'Potsdam') {
		upgrade_scope("region");
	    }
	    print "<td>$fontstr" if $bi->{'can_table'};
	    if (defined $xy && $xy !~ /^\s*$/) {
		new_kreuzungen();
		my($best) = get_nearest_crossing_coords(split(/,/, $xy));
		my $cr = crossing_text(defined $best ? $best : $xy);
		my $qs = CGI->new({strname => $strasse,
				   bezirk => $bezirk,
				   plz => $plz,
				   coord => $xy,
				  })->query_string;
		my $report_nearest = _is_real_street($strasse) && !$is_usable_without_strassen{$index||""};
		if ($report_nearest) {
		    print qq{<i>$strasse</i> } . M("ist nicht bekannt") . qq{ (<a target="newstreetform" href="$bbbike_html/newstreetform${newstreetform_encoding}.html?$qs">} . M("diese Stra�e eintragen") . qq{</a>).<br>\n};
		} else {
		    print qq{<i>$strasse</i><br>\n};
		}
		print M("Die n�chste") . " " . ($report_nearest ? M("bekannte") . " " : "") . M("Kreuzung ist") . qq{:<br>\n};
		print "<i>$cr</i>";
		if ($report_nearest) {
		    print qq{<br>\n} . M("und wird f�r die Suche verwendet") . ".";
		}
		print qq{<br>\n};
		print "<input type=hidden name=" . $type .
		    "c value=\"$best\">";
		print "<input type=hidden name=" . $type .
		    "name value=\"$cr\">";
	    } else {
		choose_street_html($strasse,
				   $plz,
				   $type);
	    }
	    print "$fontend</td>" if $bi->{'can_table'};
	    # show point in the overview map, too
	    if ($nice_berlinmap && $bi->{'can_table'}) {
		print "<td>";
		if (!@$matchref) { # XXX why?
		    $matchref = [[$strasse, $bezirk, $plz, $xy]];
		}
		require PLZ; # XXX why?
		berlinmap_with_choices($type, $matchref);
		$has_init_map_js++;
		print "</td>";
	    }
	} elsif (@$matchref == 1) {
# XXX wann kommt man hierher?
	    print "<td>$fontstr" if $bi->{'can_table'};
	    choose_street_html($matchref->[0][0],
			       $matchref->[0][2],
			       $type);
	    print "$fontend</td>" if $bi->{'can_table'};
	} elsif (@$matchref > 1) {
	    print "<td>${fontstr}" if $bi->{'can_table'};
	    if ($lang eq 'en') {
		print "Choose exact <b>" . M("${printtype}stra&szlig;e") . "</b>:<br>\n";
	    } else {
		print "Genaue <b>" . M("${printtype}stra&szlig;e") . "</b> ausw&auml;hlen:<br>\n";
	    }

	    # Sort Potsdam streets to the end:
	    @$matchref = sort {
		if ($a->[1] eq 'Potsdam' && $b->[1] ne 'Potsdam') {
		    return +1;
		} elsif ($a->[1] ne 'Potsdam' && $b->[1] eq 'Potsdam') {
		    return -1;
		} else {
		    return 0;
		}
	    } @$matchref;

	    my $s;
	    my $checked = 0;
	    my $out_i = 0;
	    foreach $s (@$matchref) {
		last if ++$out_i > $max_matches;
		my $strasse2val;
		my $is_ort = $s->[MATCHREF_ISORT_INDEX];
		print "<label><input";
		if ($nice_berlinmap) {
		    print " onclick='set_street_in_berlinmap(\"$type\", $out_i);'";
		}
		print " type=radio name=" . $type . ($osm_data ? "" : "2");
		if ($is_ort && $multiorte) {
		    my($ret) = $multiorte->get_by_name($s->[0]);
		    my $xy;
		    if ($ret) {
			$xy = $ret->[1][0];
		    }
		    $strasse2val = join($delim, $s->[0], "#ort", $xy);
		    $s->[0] =~ s/\|/ /; # Zusatzbezeichnung von Orten
		} else {
		    $strasse2val = join($delim, @$s); # 0..3
		}
                $strasse2val = $s->[0] if $osm_data;

		print " value=\"$strasse2val\"";
		if (!$checked) {
		    print " checked";
		    $checked++;
		}
		print "> $s->[0]";
		if ((defined $s->[1] && $s->[1] ne "") ||
		    (defined $s->[2] && $s->[2] ne "")) {
		    my @cp;
		    for (1, 2) {
			push @cp, $s->[$_] if (defined $s->[$_] && $s->[$_] ne "");
		    }
		    print " (<font size=-1>" . join(", ", @cp) . "</font>)";
		}
		print "</label>";
		print "<br>\n";
	    }

	    if (defined $q->param($type . "hnr")) {
		print "<input type=hidden name=${type}hnr value=\""
		    . $q->param($type."hnr") . "\">\n";
	    }

	    if ($bi->{'can_table'}) {
		print "$fontend</td><td>";

		# show choices in the overview map, too
		if ($nice_berlinmap) {
		    berlinmap_with_choices($type, $matchref);
                    $has_init_map_js++;
		} else {
		    print "&nbsp;";
		}
		print "</td>";
	    }
	} else {
	    $tryempty = 1;
	}

	if ($tryempty) {
	    if (!$no_td) {
		# align=center was a mistake
		print "<td align=left>" if $bi->{'can_table'};
	    }

	    my $searchinput = 'suggest_' . $type;
	    print qq{<input id="$searchinput" size="30" type="text" name="$type" value="" class="ac_input" spellcheck="false" >}; # if !$no_input_streetname;

	   if ($enable_opensearch_suggestions) { 
       		my $city = $osm_data && $main::datadir =~ m,data-osm/(.+), ? $1 : 'bbbike';

		my $deferRequestBy = is_mobile($q) ? 500 : 100;
		my $maxHeight = is_mobile($q) ? 300 : 160;
		my $width = is_mobile($q) ? 400 : 300;
	    print qq|

<script type="text/javascript">
	var ac_$city = \$('#$searchinput').autocomplete( 
		{ serviceUrl: '/cgi/api.cgi?namespace=dbac;city=$city', 
		  minChars:2, 
	          maxHeight:$maxHeight, 
	          width:$width, 
		  deferRequestBy:$deferRequestBy, 
	          noCache: true, 
	          geocoder: function (address, callback) { googleCodeAddress(address, callback); } 
	        }
	);
</script>

|;
	    }



	    if ($include_outer_region) {
		print <<EOF;
 <select name="${type}ort">
  <option value="">Berlin/Potsdam</option>
EOF
		for my $place (sort @outer_berlin_places) {
		    next if $place eq 'Potsdam'; # special case, Potsdam dualism
		    my $selectedhtml = defined $$ortref && $place eq $$ortref ? ' selected' : '';
		    print <<EOF;
  <option value="$place"$selectedhtml>$place</option>
EOF
		}
		print <<EOF;
 </select>
EOF
	    } elsif ($use_mysql_db) {
		print "&nbsp;<input type=text name=${type}hnr size=4>";
	    }
	    print "<br>";
	    if (!$smallform) {
		if ($with_fullsearch_radio) {
		    fullsearch_radio();
		}

		abc_link($type, -nice => 0);
	        # warn "XXX: $nice_berlinmap $no_berlinmap\n";
		$nice_berlinmap = 0;
		$no_berlinmap = 1;

		# XXX not translated
		if ($use_special_destinations) {
		    if ($type eq 'via') {
			print "<br>";
			print qq{<select $bi->{hfill} name="${type}special">
<option value="">oder ...
<option value="viabikeshop">Fahrradladen auf der Strecke
<option value="viabankomat">Geldautomat auf der Strecke
<option value="">Stra�e
</select>
};
		    } elsif ($type eq 'ziel') {
			print "<br>";
			print qq{<select $bi->{hfill} name="${type}special">
<option value="">oder ...
<option value="nextbikeshop">n�chster Fahrradladen
<option value="nextbankomat">n�chster Geldautomat
<option value="">Stra�e
</select>
};
		    }
		}
	    }

	    if ($type eq 'start' && $bi->{'can_css'}) {
		my $transpose_dot_func = "transpose_dot_func = " . overview_map()->{TransposeJS};
		print <<EOF;
<div id="locateme" style="visibility:hidden;">
  <a href="javascript:locate_me()">@{[ M("Aktuelle Position verwenden") ]}</a>
</div>
<div id="locateme_marker" style="position:absolute; visibility:hidden;"><img src="$bbbike_images/bluedot.png" border=0 width=8 height=8></div>
<script type="text/javascript"><!--
 $transpose_dot_func
// --></script>
EOF
	    }

	    if (!$smallform) {
		print "</td><td>" if $bi->{'can_table'};
		if ($nice_berlinmap && !$no_berlinmap) {
		    print "<input type=hidden name=\"" . $type . "mapimg.x\" value=\"\">";
		    print "<input type=hidden name=\"" . $type . "mapimg.y\" value=\"\">";
		    print "<div id=" . $type . "mapbelow style=\"position:relative;visibility:hidden;\">";
		    print "<img src=\"$bbbike_images/berlin_small$berlin_small_suffix.gif\" bordeR=0 width=$berlin_small_width height=$berlin_small_height alt=\"\">";
		    print "</div>";
		    print "<div id=" . $type . "mapabove style=\"position:absolute;visibility:hidden;\">";
		    print "<img src=\"$bbbike_images/berlin_small_hi$berlin_small_suffix.gif\" bordeR=0 width=$berlin_small_width height=$berlin_small_height alt=\"\">";
		    print "</div>";
		    print <<EOF;
<script type="text/javascript"><!--
function $ {type}map_init() { return any_init("${type}map"); }
function $ {type}map_highlight(Evt) { return any_highlight("${type}map", Evt); }
function $ {type}map_byebye(Evt) { return any_byebye("${type}map", Evt); }
function $ {type}map_detail(Evt) { return any_detail("${type}map", Evt); }
// --></script>
EOF
		} elsif (!$bi->{'text_browser'} && !$no_berlinmap) {
		    print "<input type=image name=" . $type
		      . "mapimg src=\"$bbbike_images/berlin_small$berlin_small_suffix.gif\" class=\"citymap\" style=\"width:${berlin_small_width}px; height:${berlin_small_height}px\" alt=\"\">";
		}
		print "</td>" if $bi->{'can_table'};
	    }
	} elsif ($nice_berlinmap) {
	    if (!$has_init_map_js) {
		print "<script type=\"text/javascript\"><!--
function " . $type . "map_init() {}
//--></script>\n";
	    }
            print "<script type=\"text/javascript\"><!--
function " . $type . "char_init() {}
//--></script>\n";
        }
	if ($bi->{'can_table'}) {
	    if ($type eq 'ziel') { 
	    	print qq{<td id="via_message" style="font-size:small" width=40><a href="javascript:toogleVia('viatr', 'via_message')" title="}, M("Via-Punkt hinzuf&uuml;gen (optional)"), qq{">via</a></td></tr>\n};
	    } elsif ($type eq 'via') { 
	    	print qq{<td style="font-size:small" width=40><a href="javascript:toogleVia('viatr', 'via_message', 'suggest_via')" title="}, M("Via-Punkt entfernen"), qq{">off</a></td></tr>\n};
	    } else {
		print qq{<td width=40>&nbsp;</td></tr>\n};
	    }
	} else {
	    print "<p>\n";
	}
    }
    #$nl->();
    #hidden_smallform();

    {
	my $button_str = "";
	if (($start2 ne "" || $startname ne "" ||
	     $via2 ne "" || $vianame ne "" ||
	     $ziel2 ne "" || $zielname ne "") &&
	    $bi->{'can_javascript'}) {
	    $button_str .= qq{<input type=button value="&lt;&lt; } . M("Zur�ck") . qq{" onclick="history.back(1);">&nbsp;&nbsp;};
	}
	$button_str .= qq{<a name="weiter"><input};
	if ($nice_berlinmap || $nice_abcmap) {
	    $button_str .= qq{ onclick='cleanup_special_click()'};
	}
	$button_str .= qq{ type=submit value="} . M("Weiter") . qq{ &gt;&gt;"></a>};
	$tbl_center_under_inputs->($button_str);
    }

    print "</table>\n" if $bi->{'can_table'};

    # home map 
    if ($show_mini_googlemap_city) {
	    my $geo = get_geography_object();
            my $cityname = $osm_data && $main::datadir =~ m,data-osm/(.+), ? $1 : 'bbbike';
	    my @weather_coords;


            my $slippymap_url = CGI->new($q);
            $slippymap_url->param('map_menu', '0');
            $slippymap_url->param('maptype', 'mapnik');
            $slippymap_url->param('zoom', $slippymap_zoom_city);


	    if ($geo->is_osm_source && exists $geo->{'bbox_wgs84'}) {
               	my @list = @{ $geo->{'bbox_wgs84'} };
	  	my $area = "$list[0],$list[1]!$list[2],$list[3]";	
	        $slippymap_url->param( 'area', $area );
		my @center =  exists $geo->{'center'} ? @{ $geo->{'center'} } : @{ $geo->{'bbox_wgs84'} };
		@weather_coords = ( $center[1], $center[0] );
	    } 

	    elsif (exists $geo->{'center'}) {
               $slippymap_url->param( 'city_center', join(",", @{ $geo->{'center'} }) ) 
            } else {
	       warn "Cannot determine city center for '$cityname', maybe data-osm/<city>/meta.dd does not exists?\n"; 
	    }
            $slippymap_url->param('source_script', "$cityname.cgi");
            $slippymap_url->param('city', $cityname);
            #$slippymap_url->param('street', "Hauptstr.");

            my $smu = $slippymap_url->url(-query=>1, -relative=>1);
            $smu =~ s/.*?\?//;

            my $ie6hack = $slippymap_url->url(-absolute=>1);
            $ie6hack =~ s,/+[^/]+$,,;

	    print "<p></p>\n";
	
            print qq{<div style="display:none" id="streetmap"></div>\n};

	    print qq{<!-- use div.text() as local variable to map -->\n};
	    &BBBikeAds::adsense_start_page if &is_production($q) && !is_mobile($q) && !$q->param("startname");

            print qq{<div style="display:none" id="streetmap2"></div>\n};
            #print qq{<div style="display:none" id="streetmap3"></div>\n}; 

    print "<input type=hidden name=scope value='" .
	(defined $q->param("scope") ? $q->param("scope") : "") . "'>";

    print "</form>\n";
    print "</td></tr></table>\n</div>\n" if $bi->{'can_table'};

	

	    my $BBBikeGooglemap = 1;
            if (is_mobile($q)) {
		$BBBikeGooglemap = 0;
		$enable_homemap_streets = 0;

		print <<EOF;
<style type="text/css">
div#routing  	  { position: relative; font-size: xx-large; }
div#routing input { font-size: xx-large; }
div.autocomplete  { font-size: xx-large; }
input 		  { margin: 0.3em; }
</style>
EOF

	    }

	    if (0) {
	    print qq{<iframe id="iframemap" src="$ie6hack/homemap.cgi?$smu" title="slippy map" width="680" height="420" scrolling="no">xxx</iframe>\n};
            } elsif ($BBBikeGooglemap) {
		use BBBikeGooglemap;

		print qq{<div id="map_area">\n};
		&BBBikeAds::adsense_linkblock if &is_production($q) && !is_mobile($q);
		print qq{</div>\n\n};
	        my $maps = BBBikeGooglemap->new();
	        $maps->run('q' => CGI->new("$smu"), 'gmap_api_version' => $gmap_api_version, 'lang' => &my_lang($lang), 'region' => $region, 'cache' =>$q->param('cache') );
	    }

if ($enable_homemap_streets) {

   my $plot_streets = "";
   my $flag = 0;
   foreach my $param (qw/startname vianame zielname start ziel start2 ziel2/) {
       my $val = $q->param($param);
       if ($val && $val ne 'NO') {
	   my $v = CGI::escapeHTML($val);
	   $v =~ s/&lt;/</g;
	   $plot_streets .= qq{getStreet(map, city, "$v", "#0000FF", $flag);\n};
	   $flag = 1;
       }
   }

print <<'EOF';
<script type="text/javascript">
  var delay = bbbike.streetPlotDelay;

  // remember URL
  $("div#streetmap2").text( $("iframe#iframemap").attr("src") );

  $("input.ac_input").keyup( 	   function(event) { homemap_street_timer(event, delay*2) } );
  $("input.ac_input").click( 	   function(event) { homemap_street_timer(event, delay) } );
  $("div.autocomplete").mouseover( function(event) { homemap_street_timer(event, delay) } );

EOF

print <<"EOF" 
$plot_streets
</script>
EOF

}

   if ($enable_current_weather && scalar(@weather_coords) > 0 && (!is_mobile($q) || is_resultpage($q))) {
	my $weather_lang = &my_lang($lang);
print <<EOF;
<script type="text/javascript">
   display_current_weather( { lat:"$weather_coords[0]", lng:"$weather_coords[1]", lang:"$weather_lang", city:"$en_city_name", city_script:"$city_script" } );
</script>
EOF
   }
    if ($enable_current_postion) {

    my @list = get_bbox_wgs84();
    my $data;
    if (scalar(@list)) {
	$data = "[[" . "$list[0],$list[1]" . "], [" . "$list[2],$list[3]" . "]]";
    } else {
	$data = "[]";
    }

      print <<EOF;
<script type="text/javascript">
	displayCurrentPosition($data, "$lang");
</script>
EOF
   }
}

print <<EOF;
<script type="text/javascript">
    if (document.getElementById('suggest_start') != null) {
        // document.BBBikeForm.start.focus();
    }
</script>

EOF


    #print "<hr>";

    if (!$smallform) {
        my $cityname;

	my $list_all_size;
	my $geo = get_geography_object();
	if ($geo) {
	    if ($geo->can("cityname")) {
		$cityname = $geo->cityname;
		if ($cityname eq 'Berlin') {
		    # special case:
		    $cityname = "Berlin " . M("und") . " Potsdam";
		}
	    }
	    if ($geo->can("cgi_list_all_size")) {
		$list_all_size = $geo->cgi_list_all_size;
	    }
	}
 
       $cityname = $osm_data && $main::datadir =~ m,data-osm/(.+), ? $1 : 'Berlin und Potsdam';
       #print q{<div style="display:none" id="footer_links">};
       #print window_open("$bbbike_script?all=1", "BBBikeAll",
       #                  "dependent,height=500,resizable," .
       #                  "screenX=500,screenY=30,scrollbars,width=250")
	#    . M("Liste aller bekannten Stra&szlig;en") . ($cityname ? " " . M("in") . " " . $cityname : "") ."</a>";
	#	print  q{</div>};
	#print "<hr>";
    }

    print footer_as_string();

    print $q->end_html;
    exit(0);
}

sub berlinmap_with_choices {
    return if $no_berlinmap;

    my($type, $matchref) = @_;
    print "<div id=${type}mapbelow style=\"position:relative;visibility:hidden;\">";
    print "<img src=\"$bbbike_images/berlin_small$berlin_small_suffix.gif\" bordeR=0 width=$berlin_small_width height=$berlin_small_height alt=\"\">";
    print "</div>";

    my $js = "";
    my $match_nr = 0;

    my $out_i = 0;
    foreach my $s (@$matchref) {
	last if ++$out_i > $max_matches;
	$match_nr++;
 	next if $s->[MATCHREF_ISORT_INDEX];
	my $xy = $s->[PLZ::LOOK_COORD()];
	next if !defined $xy;
	my($tx,$ty) = map { int $_ } overview_map()->{Transpose}->(split /,/, $xy);
	$tx -= 4; $ty -= 4; # center reddot.gif
	my $divid = $type . "match" . $match_nr;
	my $matchimgid = $type . "matchimg" . $match_nr;
	my($a_start, $a_end) = ("", "");
	if (@$matchref > 1) {
	    $a_start = <<EOF;
<a href="#" onclick="return set_street_from_berlinmap('${type}', $match_nr);">
EOF
	    $a_end   = "</a>";
	}
	my $alt = ($s->[0]||"") . "(" . ($s->[1]||"") . ")";
	print <<EOF;
<div id="$divid" style="position:absolute; visibility:visible;">$a_start<img id="$matchimgid" src="$bbbike_images/bluedot.png" border=0 width=8 height=8 alt="$alt">$a_end</div>
EOF
	$js .= "pos_rel(\"$divid\", \"${type}mapbelow\", $tx, $ty);\nvis(\"$divid\", \"show\");\n";
    }

    print <<EOF;
<script type="text/javascript"><!--
function $ {type}map_init() {
  vis("${type}mapbelow", "show");
  $js
  set_street_in_berlinmap("$type", 1);
}
// --></script>
EOF
}

sub choose_ch_form {
    my($search_char, $search_type, $search_ort) = @_;
    my $use_javascript = ($bi->{'can_javascript'} &&
			  !$bi->{'javascript_incomplete'});
    my $printtype = ucfirst($search_type);
    my $per_char_filtering = 0;
    if (!defined $search_ort || ($search_ort eq '' || $search_ort eq 'Berlin/Potsdam')) {
	undef $search_ort;
	$per_char_filtering = 1;
    }

#XXX Diese locale-Manipulation mit choose_all_form verbinden, und Sortierung
#    in eigene Subroutine auslagern.
    use locale;
    eval {
	local $SIG{'__DIE__'};
	require POSIX;
	foreach my $locale (qw(de de_DE de_DE.ISO8859-1 de_DE.ISO_8859-1)) {
	    # Aha. Bei &POSIX::LC_ALL gibt es eine Warnung, ohne & und mit ()
	    # funktioniert es reibungslos.
	    last if POSIX::setlocale( POSIX::LC_COLLATE(), $locale);
	}
    };
    http_header(@weak_cache);
    header();

    print "<b>" . M($printtype) . "</b>";
    if ($per_char_filtering) {
	print " (" . M("Anfangsbuchstabe") . " <b>$search_char</b>)";
    }
    print "<br>\n";

    print "<form action=\"$bbbike_script\" name=Charform>\n";
    if (!$use_javascript) {
	print qq{<input type=submit value="} . M("Weiter") . qq{ &gt;&gt;"><br>};
    }
    foreach ($q->param) {
	unless ($_ eq 'startchar' || $_ eq 'viachar' || $_ eq 'zielchar' ||
		$_ eq $search_type) {
	    # Lynx-Bug (oder Feature?): hidden-Variable werden nicht von
	    # der nachfolgenden Radio-Liste �berschrieben
	    next if ($_ =~ /^$search_type/);
	    print "<input type=hidden name=$_ value=\""
	      . $q->param($_) . "\">\n";
	}
    }

    my $regex_char = "^" . ($search_char eq 'A'
			    ? '[A�]'
			    : ($search_char eq 'O'
			       ? '[O�]'
			       : ($search_char eq 'U'
				  ? '[U�]'
				  : $search_char)));
    my @strlist;
    if (defined $search_ort) {
	# Pick streets outside of Berlin/Potsdam. Show whole list, do
	# not filter by $search_char
	eval {
	    my $landstr = MultiStrassen->new('landstrassen', 'landstrassen2');
	    $landstr->init;
	    eval q{ # eval wegen /o
	    while(1) {
		my $ret = $landstr->next;
	        last if !@{$ret->[1]};
	        my $name = $ret->[0];
		next if $name !~ s{\s+\(
				     \Q$search_ort\E # search for the place
				     (?:     # without any subparts
                                      |-(.*) # or with a subpart
				     )
				   \)}{}ox;
		my $longname = defined $1 ? "$name ($1)" : undef;
		if (defined $longname) {
		    # remove Bundesstra�en name in the long name
		    $longname =~ s{\s+\(B\d+\)}{};
		}
		push @strlist, defined $longname ? { short => $name, long => $longname } : $name;
	    }
	};
	};
	warn $@ if $@;
    } else {
	{
	    # Pick streets in Berlin (or the main city) only, filtered
	    # by $search_char
	    my $str = get_streets();
	    $str->init;
	    eval q{ # eval wegen /o
	    while(1) {
	        my $ret = $str->next;
	        last if !@{$ret->[1]};
	        my $name = $ret->[0];
	        push @strlist, $name if $name =~ /$regex_char/oi;
	    }
        };
	}
	eval {
	    # Include Potsdam streets
	    # XXX Special case, look for another solution in other cities!
	    my $landstr = Strassen->new("landstrassen");
	    $landstr->init;
	    eval q{ # eval wegen /o
	    while(1) {
		my $ret = $landstr->next;
	        last if !@{$ret->[1]};
	        my $name = $ret->[0];
		next if $name !~ m{\(Potsdam\)};
		if ($name =~ /$regex_char/oi) {
		    # remove Bundesstra�en name here:
		    $name =~ s{\s+\(B\d+\)}{};
		    push @strlist, $name;
		}
	    }
	};
	};
	warn $@ if $@;
    }

    @strlist =
	map { $_->[1] }
	    sort { $a->[0] cmp $b->[0] }
		map { [ref $_ ? $_->{short} : $_, $_] }
		    @strlist;

    print
      "<label><input type=radio name=" . $search_type . "name value=\"\"" ,
      ($use_javascript ? " onclick=\"document.Charform.submit()\"" : ""),
      "> ",
      ($use_javascript ? "(" . M("Zur�ck zum Eingabeformular") . ")" : "(" . M("nicht gesetzt") . ")"),
      "</label><br>\n";

    my $seen_anchor;
    my $last_name;
    for(my $i = 0; $i <= $#strlist; $i++) {
	my $name = $strlist[$i];
	my $longname;
	if (ref $name) {
	    ($name, $longname) = @{$name}{qw(short long)};
	}
	if (defined $last_name and $name eq $last_name) {
	    next;
	} else {
	    $last_name = $name;
	}
	my $html_name = BBBikeCGIUtil::my_escapeHTML($name);
	my $html_longname;
	if (defined $longname) {
	    $html_longname = BBBikeCGIUtil::my_escapeHTML($longname);
	}	    
	if (!$per_char_filtering && !$seen_anchor && uc(substr($name,0,1)) ge $search_char) {
	    print '<a name="start"></a>';
	    $seen_anchor++;
	}
	print
	  "<label><input type=radio name=" . $search_type . "name value=\"$html_name\"",
	  ($use_javascript ? " onclick=\"document.Charform.submit()\"" : ""),
	  "> ",
	  (defined $html_longname ? $html_longname : $html_name),
	  "</label><br>\n";
    }

    print "<br>";
    if (!$use_javascript) {
	print qq{<input type=submit value="} . M("Weiter") . qq{ &gt;&gt;"><br><br>\n};
    }
    if ($per_char_filtering) {
	print M("andere") . " " . M($printtype . "stra&szlig;e") . ":<br>\n";
	abc_link($search_type);
    }
    footer();
    print "<input type=hidden name=scope value='" .
	(defined $q->param("scope") ? $q->param("scope") : "") . "'>";
    if (defined $search_ort) {
	print "<input type=hidden name=${search_type}ort value='$search_ort'>\n";
    }
    print "</form>\n";
    if ($use_javascript && $seen_anchor) {
	print <<EOF;
<script type="text/javascript"><!--
location.hash = "start";
// --></script>
EOF
    }
    print $q->end_html;
    exit(0);
}

sub is_mobile {
    my $q = shift;

    if ($q->param('skin') && $q->param('skin') =~ m,^(m|mobile)$, ||
        $q->virtual_host() =~ /^m\.|^mobile\.|^dev2/ || 
	$q->url(-full=>0, -absolute=>1) =~ m,^/m/, ) {
	return 1;
    } else {
	return 0;
    }
}

sub is_startpage {
    my $q = shift;

    return ($q->param("start") || $q->param("startname") || $q->param("ziel") || $q->param("zielname")) ? 0 : 1;
}

sub is_production {
    my $q = shift;

    return 1 if -e "/tmp/is_production";
    return $q->virtual_host() =~ /^www\.bbbike\.org$/i ? 1 : 0;
}

sub is_resultpage {
    my $q = shift;

    return ($q->param('startc') && $q->param('zielc')) ? 1 : 0;
}


sub is_streets {
    my $q = shift;

    #warn "zzz: ", $q->url(-full=>1, -rewrite => 1, -path_info => 1, -query=>1), " zzz\n";
    return (defined $q->param('all') || $q->url(-path_info =>1) =~ m,/streets\.html$,); 
}



sub get_kreuzung {
    warn "get kreuzung: ", join " ", caller(), "\n" if $debug >= 1;

    my($start_str, $via_str, $ziel_str) = @_;
    if (!defined $start_str) {
	$start_str = Param('startname') || Param('start');
    }
    if (!defined $via_str) {
	$via_str = Param('vianame') || Param('via');
    }
    if (defined $via_str && $via_str =~ /^\s*$/) {
	undef $via_str;
    }
    if (!defined $ziel_str) {
	$ziel_str  = Param('zielname') ||  Param('ziel');
    }

    my $start_plz = $q->param('startplz');
    my $via_plz   = $q->param('viaplz');
    my $ziel_plz  = $q->param('zielplz');

    my $start_c   = $q->param('startc');
    my $via_c     = $q->param('viac');
    my $ziel_c    = $q->param('zielc');

    my %is_ort;
    foreach (qw(start via ziel)) {
	$is_ort{$_} = $q->param($_ . 'isort');
    }

    my($start, $via, $ziel);
    my(@start_coords, @via_coords, @ziel_coords);

    if ($use_mysql_db) {
	my $tdb;
	foreach my $type (qw(start via ziel)) {
	    my($str_normed, $citypart);
	    my $hnr = $q->param($type."hnr");
	    if (defined $q->param($type."2") && $q->param($type."2") !~ /^\s*$/) {
		($str_normed, $citypart) = split $delim, $q->param($type."2");
	    } else {
		$str_normed = eval "\$".$type.'_str'; die $@ if $@;
	    }
	    next if (!defined $str_normed || $str_normed =~ /^\s*$/);

	    if (defined $hnr && $hnr =~ /\d/) {
		if (!$tdb) {
		    require TelbuchDBApprox;
		    $tdb = TelbuchDBApprox->new
			or die;
		}
		if (defined $q->param($type."2")) {
		    ($str_normed, $citypart) = split $delim, $q->param($type."2");
		} else {
		    $str_normed = eval "\$".$type.'_str'; die $@ if $@;
		}
		my(@res) = $tdb->search("$str_normed $hnr", undef, $citypart,
					-maxtry => TelbuchDBApprox::TRY_NO_CITYPART());
		if (@res == 1) {
		    eval "\$".$type."_c = \"$res[0]->{Coord}\""; die $@ if $@;
		}
	    }
	}
    }

    # Make sure scope is incremented to "region" if any Potsdam street
    # is used here. This may happen for instance if choosing a Potsdam
    # street from the street list.
    for my $str ($start_str, $via_str, $ziel_str) {
	next if !defined $str;
	my($str_normed, $citypart) = Strasse::split_street_citypart($str);
	if ($citypart && $citypart eq 'Potsdam') {
	    upgrade_scope("region");
	    last;
	}
    }

    my $str = get_streets();
    $str->init;
    # Abbruch kann hier nicht fr�her erfolgen, da Stra�en unterbrochen
    # sein k�nnen
    while(1) {
	my $ret = $str->next;
	last if !@{$ret->[1]};
	my $name = $ret->[0];
	if (defined $start_str && $start_str eq $name and !defined $start_c) {
	    $start   = $str->pos;
	    push @start_coords, @{$ret->[1]};
	}
	if (defined $via_str && $via_str eq $name and !defined $via_c) {
	    $via     = $str->pos;
	    push @via_coords, @{$ret->[1]};
	}
	if (defined $ziel_str && $ziel_str  eq $name and !defined $ziel_c) {
	    $ziel   = $str->pos;
	    push @ziel_coords, @{$ret->[1]};
	}
    }

    if ((!defined $start and !defined $start_c) ||
	(!defined $ziel  and !defined $ziel_c)) {
	local $^W = 0;

	## In the past, I emitted a warning if this happen. But
	## it seems that there are half-legal use cases, like specifying
	## a link with just a zielname, so don't warn anymore
	##
	#if (!defined $start and !defined $start_c) {
	#    warn "Fehler: Start <$start_str/position $start> kann nicht zugeordnet werden.\n";
	#}
	#if (!defined $ziel and !defined $ziel_c) {
	#    warn "Fehler: Ziel <$ziel_str/position $ziel> kann nicht zugeordnet werden.\n";
	#}

	# Mostly this error comes from mistyped user input, so try to do
	# the best and redirect to the start page:
	$q->param('start', $start_str);
	$q->param('via', $via_str);
	$q->param('ziel', $ziel_str);
	$q->delete($_) for (qw(startname vianame zielname));
	return choose_form();
    }

    if (0) {
	# XXX nearly good enough, just:
	#   cache $nearest_orte
	#   cache everything necessary in outside_berlin_and_potsdam
	#   do it earlier, not here!
	#   check if the crossing is nearer than the place
	#   maybe use the distinction in/bei like in bbbike/Perl/Tk
	for my $def ([\$start_c, \$start_str],
		     [\$via_c,   \$via_str],
		     [\$ziel_c,   \$ziel_str],
		    ) {
	    my($c_ref, $str_ref) = @$def;
	    next if !$$c_ref;
	    next if !outside_berlin_and_potsdam($$c_ref);
	    warn "do something with $$c_ref";
	    my $nearest_orte = Kreuzungen->new_from_strassen(Strassen => get_orte());
	    $nearest_orte->make_grid;
	    my($nearest_ort_xy) = $nearest_orte->nearest_loop(split(/,/, $$c_ref),
							      IncludeDistance => 1);
	    if ($nearest_ort_xy) {
		my $ort = $nearest_orte->get_first($nearest_ort_xy->[0]);
		warn $nearest_ort_xy->[1];
		$$str_ref = $ort;
	    }							  
	}
    }

    if (@start_coords == 1 and @ziel_coords == 1 and
	(@via_coords == 1 or !defined $via)) {
	# nur eine Kreuzung f�r alle Punkte vorhanden
	# => gleich zur Suche springen bzw. nur die Preferences anzeigen
	$q->param('startc', $start_coords[0]);
	$q->param('startname', $start_str);
	$q->param('zielc',  $ziel_coords[0]);
	$q->param('zielname', $ziel_str);
	if (defined $via) {
	    $q->param('viac',  $via_coords[0]);
	    $q->param('vianame', $via_str);
	}
	## Das hier muss man wieder herein nehmen, wenn man nicht die
	## Preferences braucht:
	# search_coord();
	# my_exit(0);
    }

    http_header(@weak_cache);
    my %header_args;
    $header_args{-script} = {-src => bbbike_result_js() };
    $header_args{-result} = M("Kreuzung");
    header(%header_args);

    if (is_mobile($q)) {
	print <<EOF;
<style type="text/css">
body, select, input { font-size: x-large }
</style>
EOF
    }

    if ((!$start_c && @start_coords != 1) ||
	(!$ziel_c  && @ziel_coords != 1) ||
	(@via_coords && !$via_c)) {
	print M("Genaue Kreuzung angeben") . ":<p>\n";
    }

    all_crossings();

    print "<form action=\"$bbbike_script\">";

    foreach my $param (qw/_start _ziel _via/) {
	if (defined $q->param($param)) {
	   print $q->hidden(-name=> $param, -default=> $q->param($param)), "\n";
	}
    }

    print "<table>\n" if ($bi->{'can_table'});

    foreach ([$start_str, \@start_coords, $start_plz, $start_c, 'start',
	      $start_bgcolor],
	     [$via_str,   \@via_coords,   $via_plz,   $via_c,   'via',
	      $via_bgcolor],
	     [$ziel_str,  \@ziel_coords,  $ziel_plz,  $ziel_c,  'ziel',
	      $ziel_bgcolor],
	    ) {
	my($strname,      $coords_ref,    $plz,       $c,       $type,
	   $bgcolor) = @$_;
	my $bgcolor_s = $bgcolor ne '' ? "bgcolor=$bgcolor" : '';
	my @coords = @$coords_ref;
	next if !@coords and !$c; # kann bei nicht definiertem Via vorkommen
	my $printtype = ucfirst($type);

	print "<tr $bgcolor_s><td>"
	    if ($bi->{'can_table'});
	print "<b>" . ucfirst(M($printtype)) . "</b>: "; # Force uppercase here
	print "</td><td>"
	    if ($bi->{'can_table'});


	if (@coords == 1) {
	    $c = $coords[0];
	}
	my $crossing_choose_html;
	if (!defined $c) {
	    $crossing_choose_html = make_crossing_choose_html($strname, $type, \@coords);
	    if (!$crossing_choose_html) {
		# cannot find meaningful crossings, fallback to middle coord
		$c = $coords[@coords/2];
	    }
	}
	if (defined $c) {
	    print "<input type=hidden name=" . $type . "c value=\"$c\">";
	}
	if (defined $c and (not defined $strname or $strname eq '')) {
	    print crossing_text($c);
	    if (my $val = $q->param("_$type")) {
		# print the typed address if it is different from the crossing (e.g. for google addresses)
		print qq{ <span class="grey">[$val]</span>\n} if $val ne crossing_text($c);
	    }
            print "<br>\n";
	} else {
	    if (defined $plz and $plz eq '') {
		print $strname;
	    } else {
		print coord_or_stadtplan_link($strname, $c || $coords[0], $plz, $is_ort{$type});
	    }
	}
	if (defined $q->param($type."hnr") && $q->param($type."hnr") ne "") {
	    print " " . $q->param($type . "hnr");
	}
	# Parameter durchschleifen...
	if (defined $strname) {
	    print "<input type=hidden name=" . $type .
	      "name value=\"$strname\">";
	}
	if (defined $q->param($type . "plz")) {
	    print "<input type=hidden name=" . $type . "plz value=\"" .
	      $q->param($type . "plz") . "\">\n";
	}
	if (defined $q->param($type."hnr") && $q->param($type."hnr") ne "") {
	    print "<input type=hidden name=" . $type . "hnr value=\"" .
	      $q->param($type . "hnr") . "\">\n";
	}
	if ($is_ort{$type}) {
	    print "<input type=hidden name=" . $type . "isort value=1>\n";
	}
	print $crossing_choose_html if $crossing_choose_html;

	if ($bi->{'can_table'}) {
	    print "</td></tr>\n";
	} else {
	    print "" . ($type ne 'ziel' ? '<hr>' : '<br><br>') . "\n";
	}

    }

    print "</table>\n" if ($bi->{'can_table'});

    hidden_smallform();


    print "<hr><p><b>" . M("Einstellungen") . "</b>:\n";
    reset_html();
    print "</p>";
    settings_html();
    print "<hr>\n";

    suche_button();
## Nahbereich ist nur verwirrend...
#      # probably tkweb - work around form submit bug
#      if ($q->user_agent !~ m|libwww-perl|) {
#  	print " <font size=\"-1\"><input type=submit name=nahbereich value=\"Nahbereich\"></font>\n";
#      }
    footer();
    print "<input type=hidden name=scope value='" .
	(defined $q->param("scope") ? $q->param("scope") : "") . "'>";
    print "</form>";
    print $q->end_html;
    exit(0);
}

#XXX hmmm... muss gr�ndlicher �berlegt werden.
#  sub crossing_map {
#      my($type, $coordsref) = @_;
#      return if !-d $mapdir_fs || !-w $mapdir_fs;
#      return if $^O eq 'MSWin32'; # no fork XXX
#      my $draw;
#      eval {
#  	local $SIG{'__DIE__'};
#  	require BBBikeDraw;
#  	BBBikeDraw->VERSION(2.26);
#  	$draw = new BBBikeDraw
#  	    Geometry => "100x100",
#  	    Draw => ['title', 'wasser', 'flaechen', 'ubahn', 'sbahn', 'str'],
#  	;
#  	die $@ if !$draw;
#      };
#      return if ($@);
#      my $basefile = "_crossing_".$$."_".$type.".".$draw->suffix;
#      if (fork == 0) {
#  	# XXX $$ is not enough for modperl!!!
#  	$draw->{Coords} = $coordsref;
#  	eval { $draw->pre_draw }; return if $@;
#  	$draw->draw_map;
#  	$draw->draw_route;
#  	open(IMG, ">$mapdir_fs/$basefile")
#  	    or die "Can't write to $mapdir_fs/$basefile: $!";
#  	binmode IMG;
#  	$draw->flush(Fh => \*IMG);
#  	close IMG;
#  	my_exit 0;
#      } else {
#  	return "$mapdir_url/$basefile";
#      }
#  }

# For a given $strname, $type (start, ziel, ...) and array ref of
# coordinates return a html snippet with either a radiobutton list or
# a select listbox with the selectable crossings. Unusable crossings
# (i.e. those with a concise name) are stripped out. If a crossed
# street has no name, then it will given the pseudo name "(street
# without name)". If no usable crossing was found, an empty string is
# returned. In this case the caller is responsible to use some
# alternative, e.g. choosing one (i.e. the middle) of the available
# coordinates automatically.
sub make_crossing_choose_html {
    my($strname, $type, $coords_ref) = @_;

    my $html = "";

    my $i = 0;
    my %used;
    my $ecke_printed = 0;
    foreach (@$coords_ref) {
	if ($used{$_}) {
	    next;
	} else {
	    $used{$_}++;
	}
	if (exists $crossings->{$_}) {
	    my @kreuzung;
	    foreach (@{$crossings->{$_}}) {
		if ($_ ne $strname) {
		    push(@kreuzung, $_);
		}
	    }
	    if (@kreuzung == 0) {
		# May happen if all street names at the crossing are the same
		next;
	    }
	    for (@kreuzung) {
		if (m{^\s*$}) {
		    $_ = $no_name;
		}
	    }
	    {
		my %seen; # make unique
		@kreuzung = grep { !$seen{$_}++ } @kreuzung;
	    }

	    unless ($ecke_printed) {
		if ($use_select) {
		    $html .= " <i title='" . M("die Strassenkreuzungen sind sortiert nach der Himmelsrichtung") . "'>" . M("Ecke") . " </i>";
		    if ($bi->{'can_table'}) {
			$html .= "</td><td>";
		    }
		    $html .= "<select $bi->{hfill} name=" . $type . "c>";
		} else {
		    $html .= " " . M("Ecke") . " ...<br>\n";
		}
		$ecke_printed++;
	    }

	    if ($use_select) {
		$html .= "<option value=\"$_\">";
	    } else {
		$html .=
		    "<input type=radio name=" . $type . "c " .
			"value=\"$_\"";
		if ($i++ == 0) {
		    $html .= " checked";
		}
		$html .= "> ";
	    }
	    $html .= join("/", map { Strasse::strip_bezirk($_) } @kreuzung);
	    $html .= "<br>" unless $use_select;
	    $html .= "\n";
	}
    }
    $html .= "</select>" if $use_select && $ecke_printed;

    $html;
}

sub get_global_cookie {
    if (!$got_cookie) {
	%c = get_cookie();
	$got_cookie = 1;
    }
}

sub get_cookie {
    $q->cookie(-name => $cookiename,
# XXX cookie seems only to be set if doing some action from the search site, not a page before. Check it!
# XXX dirname okay with backward compatibility?
	       -path => dirname(BBBikeCGIUtil::my_url($q, -absolute => 1)),
	      );
}

sub set_cookie {
    my($href) = @_;
 
    # Create a dirname and a non-dirname cookie (both for backward compat):
    [$q->cookie
     (-name => "$cookiename-dir",
      -value => $href,
      #-expires => '+1y',
      -path => dirname(BBBikeCGIUtil::my_url($q, -absolute => 1)),
     ),
     $q->cookie
     (-name => $cookiename,
      -value => $href,
      #-expires => '+1y',
      -path => BBBikeCGIUtil::my_url($q, -absolute => 1),
     ),
    ];
}

use vars qw($default_speed $default_cat $default_quality
	    $default_ampel $default_routen $default_green $default_specialvehicle
	    $default_unlit $default_ferry $default_elevation $default_winter
	    $default_fragezeichen);

sub get_settings_defaults {
    get_global_cookie();

    $default_speed   = (defined $c{"pref_speed"} && $c{"pref_speed"} != 0 ? $c{"pref_speed"}+0 : $speed_default);
    $default_cat     = (defined $c{"pref_cat"}     ? $c{"pref_cat"}     : ""); # "N_RW"
    $default_quality = (defined $c{"pref_quality"} ? $c{"pref_quality"} : ""); # "Q2"
    $default_ampel   = (defined $c{"pref_ampel"} && $c{"pref_ampel"} eq 'yes' ? 1 : 0);
    $default_routen  = (defined $c{"pref_routen"}  ? $c{"pref_routen"}  : "");
    $default_green   = (defined $c{"pref_green"}   ? $c{"pref_green"}   : ""); # "GR1"
    # Backward compatibility:
    if ($default_green eq 'yes') {
	$default_green = 2;
    }
    $default_specialvehicle = (defined $c{"pref_specialvehicle"} ? $c{"pref_specialvehicle"} : '');
    $default_unlit   = (defined $c{"pref_unlit"}   ? $c{"pref_unlit"}   : "");
    $default_ferry   = (defined $c{"pref_ferry"}   ? $c{"pref_ferry"}   : "");
    $default_elevation   = (defined $c{"pref_elevation"}   ? $c{"pref_elevation"}   : "");
    $default_winter  = (defined $c{"pref_winter"}  ? $c{"pref_winter"}  : "");
    $default_fragezeichen = (defined $c{"pref_fragezeichen"} ? $c{"pref_fragezeichen"} : "");
}

sub reset_html {
    if ($bi->{'can_javascript'}) {
	my(%strcat)    = ("" => 0, "N1" => 1, "N2" => 2, "H1" => 3, "H2" => 4);
	my(%strqual)   = ("" => 0, "Q0" => 1, "Q2" => 2);
	my(%strrouten) = ("" => 0, "RR" => 1);
	my(%strgreen)  = ("" => 0, "GR1" => 1, "GR2" => 2);
	my(%strspecialvehicle) = ('' => 0, 'trailer' => 1, 'childseat' => 2);
	my(%strunlit)  = ("" => 0, "NL" => 1);
	my(%strferry)  = ("" => 0, "use" => 1);
	my(%strelevation)  = ("" => 0, "use" => 1);
	my(%strwinter) = ("" => 0, "WI1" => 1, "WI2" => 2);

	get_settings_defaults();

	print join(" ", 
		   qq'<input class="settingsreset" type="button" value="Reset" onclick="reset_form(',
		   qq'@{[defined $default_speed ? $default_speed : "null" ]},',
		   qq'@{[defined $strcat{$default_cat} ? $strcat{$default_cat} : 0]},',
		   qq'@{[defined $strqual{$default_quality} ? $strqual{$default_quality}: 0]},',
		   qq'@{[defined $strrouten{$default_routen} ? $strrouten{$default_routen} : 0]},',
		   qq'@{[ $default_ampel?"true":"false" ]},',
		   qq'@{[defined $strgreen{$default_green} ? $strgreen{$default_green} : 0]},',
		   qq'@{[defined $strspecialvehicle{$default_specialvehicle} ? $strspecialvehicle{$default_specialvehicle} : 0]},',
		   qq'@{[defined $strunlit{$default_unlit} ? $strunlit{$default_unlit} : 0]},',
		   qq'@{[defined $strferry{$default_ferry} ? $strferry{$default_ferry} : 0]},',
		   qq'@{[defined $strelevation{$default_elevation} ? $strelevation{$default_elevation} : 0]},',
		   qq'@{[defined $strwinter{$default_winter} ? $strwinter{$default_winter} : 0]}',
		   qq'); enable_settings_buttons(); return false;">',
		  );
    }
}

sub settings_html {
    get_global_cookie();

    if ($q->param("pref_seen")) {
	foreach my $key (@pref_keys) {
	    $c{"pref_$key"} = $q->param("pref_$key");
	}
    }

    get_settings_defaults();

    my $cat_checked = sub { my $val = shift;
			    'value="' . $val . '" ' .
			    ($default_cat eq $val ? "selected" : "")
			};
    my $qual_checked = sub { my $val = shift;
			     'value="' . $val . '" ' .
			     ($default_quality eq $val ? "selected" : "")
			 };
    my $routen_checked = sub { my $val = shift;
			       'value="' . $val . '" ' .
			       ($default_routen eq $val ? "selected" : "")
			 };
    my $green_checked = sub { my $val = shift;
			      'value="' . $val . '" ' .
			      ($default_green eq $val ? "selected" : "")
			};
    my $specialvehicle_checked = sub { my $val = shift;
				       'value="' . $val . '" ' .
				       ($default_specialvehicle eq $val ? "selected" : "")
				   };
    my $unlit_checked = sub { my $val = shift;
			      'value="' . $val . '" ' .
			      ($default_unlit eq $val ? "selected" : "")
			};
    my $ferry_checked = sub { my $val = shift;
			      'value="' . $val . '" ' .
			      ($default_ferry eq $val ? "selected" : "")
			  };
    my $elevation_checked = sub { my $val = shift;
			      'value="' . $val . '" ' .
			      ($default_elevation eq $val ? "selected" : "")
			  };
    my $winter_checked = sub { my $val = shift;
			      'value="' . $val . '" ' .
			      ($default_winter eq $val ? "selected" : "")
			};

    print <<EOF;
<input type=hidden name="pref_seen" value=1>
<table>
<tr><td>@{[ M("Bevorzugte Geschwindigkeit") ]}:</td><td><input type=text maxlength=2 size=4 name="pref_speed" value="$default_speed"> km/h</td></tr>
<tr><td>@{[ M("Bevorzugter Stra�entyp") ]}:</td><td><select $bi->{hfill} name="pref_cat">
<option @{[ $cat_checked->("") ]}>@{[ M("egal") ]}
<option @{[ $cat_checked->("N1") ]}>@{[ M("Nebenstra�en bevorzugen") ]}
<option @{[ $cat_checked->("N2") ]}>@{[ M("nur Nebenstra�en benutzen") ]}
<option @{[ $cat_checked->("H1") ]}>@{[ M("Hauptstra�en bevorzugen") ]}
<option @{[ $cat_checked->("H2") ]}>@{[ M("nur Hauptstra�en benutzen") ]}
<option @{[ $cat_checked->("N_RW") ]}>@{[ M("Hauptstra�en ohne Radwege/Busspuren meiden") ]}
<option @{[ $cat_checked->("N_RW1") ]}>@{[ M("Hauptstra�en ohne Radwege meiden") ]}
</select></td></tr>
<tr><td>@{[ M("Bevorzugter Stra�enbelag") ]}:</td><td><select $bi->{hfill} name="pref_quality">
<option @{[ $qual_checked->("") ]}>@{[ M("egal") ]}
<option @{[ $qual_checked->("Q2") ]}>@{[ M("Kopfsteinpflaster und schlechte Fahrbahnen vermeiden") ]}
<option @{[ $qual_checked->("Q0") ]}>@{[ M("nur sehr gute Bel�ge bevorzugen (rennradtauglich)") ]}
</select></td></tr>
EOF
#  <!--
#  <tr><td>@{[ M("Ausgeschilderte Fahrradrouten bevorzugen") ]}:</td><td><select $bi->{hfill} name="pref_routen">
#  <option @{[ $routen_checked->("") ]}>@{[ M("egal") ]}
#  <option @{[ $routen_checked->("RR") ]}>@{[ M("ja") ]}
#  </select></td></tr>
#  -->
#  <!--XXX implement <tr><td>@{[ M("Radwege") ]}:</td><td><select $bi->{hfill} name="pref_rw">
#  <option value="">@{[ M("egal") ]}
#  <option value="R0">@{[ M("nur Radwege verwenden") ]}
#  <option value="R1">@{[ M("Hauptstra�en mit Radweg bevorzugen") ]}
#  <option value="R2">@{[ M("benutzungspflichtige Radwege vermeiden") ]}
#  </select></td></tr>-->

print qq{<tr><td>@{[ M("Ampeln vermeiden") ]}:</td><td><input type=checkbox name="pref_ampel" value="yes" @{[ $default_ampel?"checked":"" ]}></td>} 
if !$osm_data || ($datadir =~ m,data-osm/(.+), && $1 eq 'berlin');

    print <<EOF;
<tr><td>@{[ M("Unterwegs mit") ]}:</td><td><select $bi->{hfill} name="pref_specialvehicle">
<option @{[ $specialvehicle_checked->("")          ]}>@{[ M("nichts weiter") ]} <!-- expr? XXX -->
<option @{[ $specialvehicle_checked->("trailer")   ]}>@{[ M("Anh�nger") ]}
<option @{[ $specialvehicle_checked->("childseat") ]}>@{[ M("Kindersitz mit Kind") ]}
</select></td></tr>
EOF

    if ($include_outer_region) {
	print <<EOF;
<td style="font-size:smaller;">@{[ M("(nur in Berlin/Potsdam erfasst)") ]}</td>
EOF
    }
    if (1) {
	print <<EOF;
<tr><td>@{[ M("Unbeleuchtete Wege vermeiden") ]}:</td><td><input type=checkbox name="pref_unlit" value="NL" @{[ $default_unlit?"checked":"" ]}></td>
EOF
	if ($include_outer_region) {
	    print <<EOF;
<td style="font-size:smaller;">@{[ M("(nur in Berlin/Potsdam erfasst)") ]}</td>
EOF
	}
    } else {
	print <<EOF;
<input type="hidden" name="pref_unlit" value="">
EOF
    }

    if ($with_green_ways) {
    print <<EOF;
<tr><td>@{[ M("Gr�ne Wege") ]}:</td><td><select $bi->{hfill} name="pref_green">
<option @{[ $green_checked->("") ]}>@{[ M("egal") ]}
<option @{[ $green_checked->("GR1") ]}>@{[ M("bevorzugen") ]}
<option @{[ $green_checked->("GR2") ]}>@{[ M("stark bevorzugen") ]} <!-- expr? -->
</select></td></tr>
EOF
    }

    if (!$osm_data || do {
	my $geo = get_geography_object();
	$geo && $geo->can('skip_feature') && !$geo->skip_feature('faehren')
    }) {
	print <<EOF;
<tr><td>@{[ M("F�hren benutzen") ]}:</td><td><input type=checkbox name="pref_ferry" value="use" @{[ $default_ferry?"checked":"" ]}></td></tr>
EOF
    }
    if ($enable_elevation) {
	print qq|<tr><td>@{[ M("Berge vermeiden") ]}:</td><td><input type=checkbox name="pref_elevation" value="use" @{[ $default_elevation?"checked":"" ]}></td></tr>|;
    }

    if ($use_winter_optimization) {
	print <<EOF;
<tr>
 <td>@{[ M("Winteroptimierung") ]}</td><td><select $bi->{hfill} name="pref_winter" @{[ $bi->{'can_javascript'} ? "onchange='enable_settings_buttons()'" : "" ]}>
<option @{[ $winter_checked->("") ]}>@{[ M("nein") ]}
<option @{[ $winter_checked->("WI1") ]}>@{[ M("schwach") ]}
<option @{[ $winter_checked->("WI2") ]}>@{[ M("stark") ]}
</select></td>
 <td style="vertical-align:bottom">@{[ experimental_label() ]}<small><a target="BBBikeHelp" href="$bbbike_html/help.html#winteroptimization" onclick="show_help@{[ $lang ? "_$lang" : "" ]}('winteroptimization'); return false;">@{[ M("Was ist das?") ]}</a></small></td>
</tr>
EOF
    }
    if ($use_fragezeichen) {
	print <<EOF;
<tr>
 <td>@{[ M("Unbekannte Stra�en mit einbeziehen") ]}:</td>
 <td><input type=checkbox name="pref_fragezeichen" value=yes @{[ $default_fragezeichen?"checked":"" ]}></td>
 <td style="vertical-align:bottom"><small><a target="BBBikeHelp" href="$bbbike_html/help.html#fragezeichen" onclick="show_help@{[ $lang ? "_$lang" : "" ]}('fragezeichen'); return false;">@{[ M("Was ist das?") ]}</a></small></td>
</tr>
EOF
    }
    print <<EOF;
</table>
EOF
}


sub spinning_wheel {
    return qq{<span id="spinning_wheel" style="visibility:hidden">&nbsp;&nbsp;&nbsp;} . 
	M("BBBike sucht eine Fahrradroute") . " ...&nbsp;&nbsp;&nbsp;\n" . 
        qq{<img title="BBBike is searching a cycle route for you. Please wait." width="32" height="32" src="/images/spinning_wheel32.gif" alt="" >} .
    qq{</span>\n};
}

sub suche_button {
    if ($bi->{'can_javascript'}) {
	print qq{<input type=button value="&lt;&lt; } . M("Zur�ck") . qq{" onclick="history.back(1);">&nbsp;&nbsp;};
    }
    print qq{<input onclick="show_spinning_wheel();" type=submit value="} . M("Route zeigen") . qq{ &gt;&gt;"> }. &spinning_wheel .  qq{<p></p>\n};
}

sub hidden_smallform {
    # Hier die Query-Variable statt der Perl-Variablen benutzen...
    if ($q->param('smallform')) {
	print "<input type=hidden name=smallform value=\"" .
	  $q->param('smallform') . "\">\n";
    }
}

sub via_not_needed {
    my($via, $via2, $vianame) = @_;
    $via     = $q->param('via')     if !defined $via;
    $via2    = $q->param('via2')    if !defined $via2;
    $vianame = $q->param('vianame') if !defined $vianame;

    !(((defined $via2 && $via2 ne '') ||
       (defined $via  && $via  ne '' && $via ne 'NO')) &&
      (!defined $vianame || $vianame eq ''));
}

sub make_netz {
    my $lite = shift;
    if (!$net) {
	my $special_vehicle = defined $q->param('pref_specialvehicle') ? $q->param('pref_specialvehicle') : '';
	my $str = get_streets();
	$net = new StrassenNetz $str;
	# XXX This change should also go into radlstadtplan.cgi!!!
	if (defined $search_algorithm && $search_algorithm eq 'C-A*-2') {
	    $net->use_data_format($StrassenNetz::FMT_MMAP);
	    # make_net with initial -blocked is more performant
	    $net->make_net(-blocked => "gesperrt",
			   -blockedtype => [qw(einbahn sperre)],
			  );
	    $net->make_sperre('gesperrt',
			      Type => [qw(wegfuehrung)],
			      SpecialVehicle => $special_vehicle,
			      # XXX What about $special_vehicle? Is it correct here, or not possible because of the static net?
			     );
	} else {
	    # XXX �berpr�fen, ob sich der Cache lohnt...
	    # evtl. mit IPC::Shareable arbeiten (Server etc.)
	    $net->make_net(UseCache => 1);
	    if (!$lite) {
		$net->make_sperre('gesperrt',
				  Type => [qw(einbahn sperre wegfuehrung)],
				  SpecialVehicle => $special_vehicle,
				 );
	    }
	}
    }
    $net;
}

sub search_coord {
    my $startcoord  = $q->param('startc');
    my $viacoord    = $q->param('viac');
    my $zielcoord   = $q->param('zielc');
    my(@custom)     = $q->param('custom');
    my %custom      = map { ($_ => 1) } @custom;

    my $via_array = (defined $viacoord && $viacoord ne ''
		     ? [$viacoord]
		     : []);

    # Technically more correct it would be to adjust the scope
    # after fix_coords. But fix_coords already needs a built net,
    # so we ignore the hopefully small fix by fix_coords.
    #
    # adjust_scope_for_search adjust $q->param("scope")
    adjust_scope_for_search([$startcoord, @$via_array, $zielcoord]);

    my $scope = $q->param("scope") || "city";

    make_netz();

    ($startcoord, $zielcoord, @$via_array)
	= fix_coords($startcoord, $zielcoord, @$via_array);

    my %extra_args;
    if (@$via_array) {
	$extra_args{Via} = $via_array;
	# siehe Kommentar in search: Via und All bei�en sich
    } else {
	$extra_args{All} = 1;
    }

    # Tragen vermeiden
    $extra_args{Tragen} = 1;
    my $velocity_kmh = $q->param("pref_speed") || $speed_default;
    $extra_args{Velocity} = $velocity_kmh/3.6; # convert to m/s
    # XXX Anzahl der Tragestellen z�hlen...

    if ($enable_elevation && $q->param("pref_elevation") ) {
	my $elevation = new BBBikeElevation;
    	$elevation->init;
        my $extra_args = $elevation->elevation_net;

	$extra_args{"Steigung"} = $extra_args->{"Steigung"};

	warn $elevation->statistic, "\n" if $debug;
    }
	
    my @penalty_subs;

    my $disable_other_optimizations = 0;

    # Winteroptimierung
    if (defined $q->param('pref_winter') && $q->param('pref_winter') ne '') {
	if ($use_winter_optimization) {
	    $winter_hardness ||= 'snowy'; # some default
	    require Storable;
	    my $penalty;
	    for my $try (1 .. 2) {
		for my $dir ("$FindBin::RealBin/../tmp", @Strassen::datadirs) {
		    my $f = "$dir/winter_optimization.$winter_hardness.st";
		    if (-r $f && -s $f) {
			$penalty = Storable::retrieve($f);
			last;
		    }
		}
		if (!$penalty) {
		    if ($try == 2) {
			die "Can't find winter_optimization.$winter_hardness.st in @Strassen::datadirs and cannot build...";
		    } else {
			system("$FindBin::RealBin/../miscsrc/winter_optimization.pl", "-winter-hardness", $winter_hardness, "-one-instance");
		    }
		} else {
		    last;
		}
	    }

	    my $koeff = 1;
	    if ($q->param('pref_winter') eq 'WI1') {
		$koeff = 0.5;
	    }

	    push @penalty_subs, sub {
		my($pen, $next_node, $last_node) = @_;
		if (exists $penalty->{$last_node.",".$next_node}) {
		    my $this_penalty = $penalty->{$last_node.",".$next_node};
		    $this_penalty = $koeff * $this_penalty + (100-$koeff*100)
			if $koeff != 1;
		    if ($this_penalty < 1) {
			$this_penalty = 1;
		    }		# avoid div by zero or negative values
		    $pen *= (100 / $this_penalty);
		}
		$pen;
	    };
	    #XXX $disable_other_optimizations = 1;
	} else {
	    # ignore pref_winter
	}
    }

    # Ampeloptimierung
    if (!$disable_other_optimizations && defined $q->param('pref_ampel') && $q->param('pref_ampel') eq 'yes') {
	if (new_trafficlights()) {
	    $extra_args{Ampeln} = {Net     => $ampeln,
				   Penalty => 100};
	}
    }

    # Haupt/Freizeitrouten-Optimierung
    if (!$disable_other_optimizations && defined $q->param('pref_routen') && $q->param('pref_routen') ne '') { # 'RR'
	if (!$routen_net) {
	    $routen_net =
		new StrassenNetz(Strassen->new("radrouten"));
	    $routen_net->make_net;
	}
	push @penalty_subs, sub {
	    my($p, $next_node, $last_node) = @_;
	    if (!$routen_net->{Net}{$last_node}{$next_node}) {
		$p *= 2; # XXX differenzieren?
	    }
	    $p;
	};
    }

    # UserDefPenaltySubs
    if (@penalty_subs) {
	# Note: the @penalty_subs should only multiply $p, not add to
	# if there are more than one penalty sub!
	$extra_args{UserDefPenaltySub} = sub {
	    my($p, $next_node, $last_node) = @_;
	    for my $sub (@penalty_subs) {
		$p = $sub->($p, $next_node, $last_node);
	    }
	    $p;
	};
    }

    # Optimierung der gr�nen Wege
    if (!$disable_other_optimizations && defined $q->param('pref_green') && $q->param('pref_green') ne '') {
	if (!$green_net) {
	    $green_net = new StrassenNetz(Strassen->new("green"));
	    $green_net->make_net_cat;
	}
	my $penalty = ($q->param('pref_green') eq 'GR1'
		       ? { "green0" => 2,
			   "green1" => 1.5,
			   "green2" => 1,
			 }
		       : { "green0" => 3,
			   "green1" => 2,
			   "green2" => 1,
		       });
	$extra_args{Green} =
	    {Net => $green_net,
	     Penalty => $penalty,
	    };
    }

    # Optimierung der beleuchteten Wegen
    if (!$disable_other_optimizations && defined $q->param('pref_unlit') && $q->param('pref_unlit') ne '') {
	if (!$unlit_streets_net) {
	    $unlit_streets_net = new StrassenNetz(Strassen->new("nolighting"));
	    $unlit_streets_net->make_net_cat;
	}
	my $penalty = { "NL" => 4,
		      };
	$extra_args{UnlitStreets} =
	    {Net => $unlit_streets_net,
	     Penalty => $penalty,
	    };
    }

    # Handicap-Optimierung ...
    # Zurzeit nur Fu�g�ngerzonenoptimierung automatisch.
    # sowie Daten aus temp_blockings (wird unten ge-merge-t).
    # Diese Optimierung ist immer eingeschaltet, auch wenn die
    # Winteroptimierung aktiv ist (haupts�chlich wegen temp_blockings)
    if (1) {
	if (!$handicap_net) {
	    my @in_files = ('handicap_s');
	    if ($scope eq 'region' || $scope eq 'wideregion') {
		push @in_files, 'handicap_l';
	    }
	    if ($q->param('pref_ferry') && $q->param('pref_ferry') eq 'use') {
		push @in_files, 'faehren';
	    }
	    if (@in_files == 1) {
		$handicap_net = StrassenNetz->new(Strassen->new(@in_files));
	    } else {
		$handicap_net = StrassenNetz->new(MultiStrassen->new(@in_files));
	    }
	    $handicap_net->make_net_cat;
	}
	my $penalty = {};
	for my $q_cat (keys %handicap_speed) {
	    $penalty->{$q_cat} = $velocity_kmh/$handicap_speed{$q_cat};
	}
	for my $q (0 .. 4) {
	    my $q_cat = "q$q";
	    $penalty->{$q_cat} = 1 if !exists $penalty->{$q_cat} || $penalty->{$q_cat} < 1;
	}

	$extra_args{Handicap} =
	    {Net => $handicap_net,
	     Penalty => $penalty,
	    };

    }

    # Qualit�tsoptimierung
    if (!$disable_other_optimizations && defined $q->param('pref_quality') && $q->param('pref_quality') ne '') {
	# XXX landstra�en?
	if (!$qualitaet_net) {
	    if ($scope eq 'region' || $scope eq 'wideregion') {
		$qualitaet_net =
		    new StrassenNetz(MultiStrassen->new("qualitaet_s",
							"qualitaet_l"));
	    } else {
		$qualitaet_net =
		    new StrassenNetz(Strassen->new("qualitaet_s"));
	    }
	    $qualitaet_net->make_net_cat;
	}
	my %penalty;
	my %max_limit;
	if ($q->param('pref_quality') eq 'Q0') {
	    %penalty = ( "Q0" => 1,
			 "Q1" => 1.2,
			 "Q2" => 1.6,
			 "Q3" => 2 );
	    %max_limit = ( Q1 => $velocity_kmh / 25,
			   Q2 => $velocity_kmh / 16,
			   Q3 => $velocity_kmh / 10 );
	} else {
	    %penalty = ( "Q0" => 1,
			 "Q1" => 1,
			 "Q2" => 1.5,
			 "Q3" => 1.8 );
	    %max_limit = ( Q1 => $velocity_kmh / 25,
			   Q2 => $velocity_kmh / 18,
			   Q3 => $velocity_kmh / 13 );
	}
	my $min_limit = $velocity_kmh / 5;
	for my $q (keys %max_limit) {
	    if ($penalty{$q} < $max_limit{$q}) {
		$penalty{$q} = $max_limit{$q};
	    }
	}
	if ($velocity_kmh > 5) {
	    for my $q (keys %penalty) {
		if ($penalty{$q} > $min_limit) {
		    $penalty{$q} = $min_limit;
		}
	    }
	}
	$extra_args{Qualitaet} =
	    {Net => $qualitaet_net,
	     Penalty => \%penalty,
	    };

    }

    # Kategorieoptimierung
    if (!$disable_other_optimizations && defined $q->param('pref_cat') && $q->param('pref_cat') ne '') {
	my $penalty;
	my $pref_cat = $q->param('pref_cat');
	if ($pref_cat =~ m{^N_RW1?$}) {
	    if (!$radwege_strcat_net) {
		my $str = get_streets();
		$radwege_strcat_net = StrassenNetz->new($str);
		$radwege_strcat_net->make_net_cyclepath
		    (get_cyclepath_streets(), UseCache => 1);
	    }
	    $penalty = { "H"     => 4,
			 "H_Bus" => ($pref_cat eq 'N_RW1' ? 4 : 1),
			 "H_RW"  => 1,
			 "N"     => 1,
			 "N_Bus" => 1,
			 "N_RW"  => 1,
		       };
	    $extra_args{RadwegeStrcat} =
		{Net => $radwege_strcat_net,
		 Penalty => $penalty,
		};
	} else {
	    if (!$strcat_net) {
		my $str = get_streets();
		$strcat_net = new StrassenNetz $str;
		$strcat_net->make_net_cat(-usecache => 1);
	    }
	    if ($pref_cat eq 'N2') {
		$penalty = { "B"  => 4,
			     "HH" => 4,
			     "H"  => 4,
			     "NH" => 2,
			     "N"  => 1,
			     "NN" => 1 };
	    } elsif ($pref_cat eq 'N1') {
		$penalty = { "B"  => 1.5,
			     "HH" => 1.5,
			     "H"  => 1.5,
			     "NH" => 1,
			     "N"  => 1,
			     "NN" => 1 };
	    } elsif ($pref_cat eq 'H1') {
		$penalty = { "B"  => 1,
			     "HH" => 1,
			     "H"  => 1,
			     "NH" => 1,
			     "N"  => 1.5,
			     "NN" => 1.5 };
	    } elsif ($pref_cat eq 'H2') {
		$penalty = { "B"  => 1,
			     "HH" => 1,
			     "H"  => 1,
			     "NH" => 2,
			     "N"  => 4,
			     "NN" => 4 };
	    }
	    if ($penalty) {
		$extra_args{Strcat} =
		    {Net => $strcat_net,
		     Penalty => $penalty,
		    };
	    }
	}
    }

    if (defined $search_algorithm) {
	$extra_args{Algorithm} = $search_algorithm;
    }

    my $is_test_mode = (defined $q->param("test") && grep { /^(?:custom|temp)[-_]blocking/ } $q->param("test"));
    my $fake_time    = $q->param('fake_time');
    load_temp_blockings(-test => $is_test_mode || $fake_time);

    my(%custom_s, @current_temp_blocking);
    {
	my $t = $fake_time || time;
	my $index = -1;
	for my $tb (@temp_blocking) {
	    $index++;
	    next if !$tb; # undefined entry
	    if (((!defined $tb->{from} || $t >= $tb->{from}) &&
		 (!defined $tb->{until} || $t <= $tb->{until})) ||
		$is_test_mode
		) {
		push @current_temp_blocking, $tb;
		$tb->{'index'} = $index;
	    }
	}
	if (@current_temp_blocking) {
	    local @Strassen::datadirs = @Strassen::datadirs;
	    push @Strassen::datadirs,
		"$FindBin::RealBin/../BBBike/data/temp_blockings",
		"$FindBin::RealBin/../data/temp_blockings",
		;
	    for(my $i = 0; $i <= $#current_temp_blocking; $i++) {
		my $tb = $current_temp_blocking[$i];
		my $strobj;
		if (!eval {
		    if ($tb->{file}) {
			$strobj = Strassen->new($tb->{file});
		    } elsif ($tb->{data}) {
			$strobj = Strassen->new_from_data_string($tb->{data});
## XXX Funktioniert nicht so gut:
# 			if ($bbbike_temp_blockings_file) {
# 			    $strobj->{DependentFiles} = [ $bbbike_temp_blockings_file ];
# 			}
		    } else {
			die "Neither file nor data found in entry";
		    }
		}) {
		    warn $@ if $@;
		    splice @current_temp_blocking, $i, 1;
		    $i--;
		    next;
		}

		$tb->{strobj} = $strobj;
		if (@custom) {
		    if (exists $custom{'temp-blocking-' . $tb->{'index'}}) {
			my %strobj_per_type;
			$strobj->init;
			while(1) {
			    my $r = $strobj->next;
			    last if !@{ $r->[Strassen::COORDS] };
			    my $type;
			    if ($r->[Strassen::CAT] =~ m{^q}) {
				$type = 'handicap';
			    } else {
				$type = 'gesperrt';
			    }
			    if (!$strobj_per_type{$type}) {
				$strobj_per_type{$type} = Strassen->new;
			    }
			    $strobj_per_type{$type}->push($r);
			}
			while(my($type, $strobj_per_type) = each %strobj_per_type) {
			    push @{ $custom_s{$type} }, $strobj_per_type;
			}
		    }
		} else {
		    my $strobj_3    = $strobj->grepstreets(sub { $_->[Strassen::CAT] eq '3' });
		    my $strobj_non3 = $strobj->grepstreets(sub { $_->[Strassen::CAT] ne '3' });
		    my $tb_net = $tb->{net} = StrassenNetz->new($strobj_non3);
		    $tb_net->make_net_cat(-onewayhack => 1);
		    $tb_net->make_sperre($strobj_3, Type => ['wegfuehrung']);
		    # XXX What about $special_vehicle? Should it be used here?
		}
	    }

	    if (@custom) {
		while(my($type, $list) = each %custom_s) {
		    $custom_s{$type} = MultiStrassen->new(@$list);

		    if ($type eq 'gesperrt' && $custom_s{$type}) {
			$net->make_sperre($custom_s{$type}, Type => 'all');
		    } elsif ($type eq 'handicap' && $custom_s{$type}) {
			if (!$handicap_net) {
			    warn "No net for handicap defined, ignoring temp_blocking=handicap";
			} else {
			    $handicap_net->merge_net_cat($custom_s{$type});
			}
		    } else {
			warn "Unhandled temp blocking type `$type'";
		    }
		}
	    }
	}
    }

    warn "Search extra arguments: " . join (" ", keys %extra_args), "\n" if $debug >= 2;

    my($r) = $net->search($startcoord, $zielcoord,
			  AsObj => 1,
			  %extra_args);
    if ((!$r || !$r->path_list) && $r->nearest_node) {
	my $nearest_node = $r->nearest_node;
	warn "Search again with nearest node <" . $nearest_node . "> instead of wanted goal <" . $zielcoord . ">\n";
	($r) = $net->search($startcoord, $nearest_node,
			    AsObj => 1,
			    %extra_args);
	# Remember that we found just a route to the nearest node
	$r->set_to($zielcoord);
	$r->set_nearest_node($nearest_node);
    }

    display_route($r, -custom => { custom		 => \@custom,
				   custom_s		 => \%custom_s,
				   current_temp_blocking => \@current_temp_blocking,
				 });
}

sub cgi_utf8 {
    my $utf8_flag = shift;
    my $q = shift;

    my $qq =  CGI->new($q);
    return $qq if !$utf8_flag;
 
    foreach my $param ($qq->param() ) {
	my $string = $qq->param($param);

	if (!Encode::is_utf8( $string)) {
	   $string = Encode::decode( utf8 => $qq->param($param), Encode::FB_QUIET );
	   $qq->param($param, $string);
	}
    }

    return $qq;
}


sub display_route {
    my($r, %args) = @_;

    my $startcoord = $r->{From};
    my $viacoord   = $r->{Via} && @{ $r->{Via} } ? $r->{Via}[0] : undef;
    my $zielcoord  = $r->{To};

    # XXX may calculate start and ziel from route if none is provided
    my $startname   = name_from_cgi($q, 'start');
    my $vianame     = name_from_cgi($q, 'via');
    my $zielname    = name_from_cgi($q, 'ziel');

    #warn "YYY: startname: $startname, utf8: ", Encode::is_utf8($startname), " zielname: $zielname, ", Encode::is_utf8($zielname), "\n" ;
    my $real_zielname;
    if ($r && $r->nearest_node) {
	$real_zielname = crossing_text($r->nearest_node);
    } else {
	$real_zielname = $zielname;
    }

    my $routetitle  = $q->param('routetitle');

    my $starthnr    = $q->param('starthnr');
    my $viahnr      = $q->param('viahnr');
    my $zielhnr     = $q->param('zielhnr');

    my $output_as   = $q->param('output_as');
    my $printmode   = defined $output_as && $output_as eq 'print';

    my $scope = $q->param("scope") || "city";

    my $velocity_kmh = $q->param("pref_speed") || $speed_default;

    my $printwidth      = 400;
    my $printtablewidth = 400;
    if ($printmode && $q->param("printvariant") && $q->param("printvariant") eq 'normal') {
	$printtablewidth = '100%';
    }

    my @custom;
    my %custom_s;
    my @current_temp_blocking;
    if ($args{-custom}) {
	@custom                = @{ $args{-custom}->{custom} };
	%custom_s              = %{ $args{-custom}->{custom_s} };
	@current_temp_blocking = @{ $args{-custom}->{current_temp_blocking} };
    }

    my $show_settings = !$args{-hidesettings};
    my $show_wayback  = !$args{-hidewayback};

    make_netz();

    if (defined $output_as && $output_as eq 'palmdoc') {
	require BBBikePalm;
	my $filename = filename_from_route($startname, $zielname) . ".pdb";
	http_header
	    (-type => "application/x-palm-database",
	     -Content_Disposition => "attachment; filename=$filename",
	    );
	print BBBikePalm::route2palm(-net => $net, -route => $r,
				     -startname => $startname,
				     -zielname => $zielname);
	return;
    }

    my $route_to_strassen_object = sub {
	my $bbd_line;
	if ($r->path && @{ $r->path }) {
	    $bbd_line = "$startname - $zielname\tX " .
		join(" ", map { "$_->[0],$_->[1]" }
		     @{ $r->path || [] }) . "\n";
	} else {
	    $bbd_line = '';
	}
	Strassen->new_from_data($bbd_line);
    };

    if (defined $output_as && $output_as eq 'gpx-track') {
	require Strassen::GPX;
	my $filename = filename_from_route($startname, $zielname, "track") . ".gpx";
	http_header
	    (-type => "application/xml",
	     -Content_Disposition => "attachment; filename=$filename",
	    );
	my $s = $route_to_strassen_object->();
	my $s_gpx = Strassen::GPX->new($s);
	$s_gpx->{"GlobalDirectives"}->{"map"}[0] = "polar" if $data_is_wgs84;
	print $s_gpx->bbd2gpx(-as => "track");
	return;
    }

    if (defined $output_as && $output_as eq 'kml-track') {
	require Strassen::KML;
	my $filename = filename_from_route($startname, $zielname, "track") . ".kml";
	http_header
	    (-type => "application/vnd.google-earth.kml+xml",
	     -Content_Disposition => "attachment; filename=$filename",
	    );
	my $s = $route_to_strassen_object->();
	my $s_kml = Strassen::KML->new($s);
	$s_kml->{"GlobalDirectives"}->{"map"}[0] = "polar" if $data_is_wgs84;
	print $s_kml->bbd2kml(startgoalicons => 1);
	return;
    }

    if (defined $output_as && $output_as eq 'mapserver') {
	if ($r->path) {
	    $q->param('coords', join("!", map { "$_->[0],$_->[1]" }
				     @{ $r->path }));
	}
	$q->param("imagetype", "mapserver");
	draw_route();
	return;
    }

    my(@weather_res);
    if ($show_weather || $bp_obj) {
	@weather_res = gather_weather_proc() if $osm_data;
    }

    my $sess = tie_session(undef);

    my $has_fragezeichen_routelist;
    my $fragezeichen_net;
    if ($use_fragezeichen_routelist) {
	eval {
	    my $s = Strassen->new("fragezeichen");
	    $fragezeichen_net = StrassenNetz->new($s);
	    $fragezeichen_net->make_net;
	};
	warn $@ if $@;
	$has_fragezeichen_routelist = 1 if $fragezeichen_net;
    }

    my(@power) = (50, 100, 200);
    my @speeds = qw(10 15 20 25);
    if ($q->param('pref_speed')) {
	if (!grep { $_ == $q->param('pref_speed') } @speeds) {
	    push @speeds, $q->param('pref_speed');
	    @speeds = sort { $a <=> $b } @speeds;
	    if ($q->param('pref_speed') > 17) {
		shift @speeds;
	    } else {
		pop @speeds;
	    }
	}
    }

    my @out_route;
    my %speed_map;
    my %power_map;
    my @strnames;
    my @path;
    my $penalty_lost = 0;
 CALC_ROUTE_TEXT: {
	last CALC_ROUTE_TEXT if (!$r || !$r->path_list);

	my @bikepwr_time = (0, 0, 0);
	#use vars qw($wind_dir $wind_v %wind_dir $wind); # XXX oben definieren
	if ($bp_obj && @weather_res && exists $BBBikeCalc::wind_dir{lc($weather_res[4])}) {
	    BBBikeCalc::analyze_wind_dir($weather_res[4]);
	    # XXX del: $wind = 1;
	    my $wind_v = $weather_res[7];
	    my(@path) = $r->path_list;
	    for(my $i = 0; $i < $#path; $i++) {
		my($x1, $y1) = @{$path[$i]};
		my($x2, $y2) = @{$path[$i+1]};
		my($deltax, $deltay) = ($x1-$x2, $y1-$y2);
		my $etappe = sqrt(BBBikeUtil::sqr($deltax) + BBBikeUtil::sqr($deltay));
		next if $etappe == 0;
# XXX feststellen, warum hier ein Minus stehen mu�...
		my $hw = -BBBikeCalc::head_wind($deltax, $deltay);
		# XXX Doppelung mit bbbike-Code vermeiden
		my $wind; # Berechnung des Gegenwindes
		if ($hw >= 2) {
		    $wind = -$wind_v;
		} elsif ($hw > 0) { # unsicher beim Crosswind
		    $wind = -$wind_v*0.7;
		} elsif ($hw > -2) {
		    $wind = $wind_v*0.7;
		} else {
		    $wind = $wind_v;
		}
		for my $i (0 .. 2) {
		    # XXX H�henberechnung nicht vergessen
		    # XXX Doppelung mit bbbike-Code vermeiden
		    my $bikepwr_time_etappe =
		      ( $etappe / bikepwr_get_v($wind, $power[$i]));
		    $bikepwr_time[$i] += $bikepwr_time_etappe;
		}
	    }
	}

	@strnames = $net->route_to_name($r->path);

	foreach my $speed (@speeds) {
	    if ($speed == 0) {
		$speed = $speed_default; # sane default
	    }
	    my $def = {};
	    $def->{Pref} = ($q->param('pref_speed') && $speed == $q->param('pref_speed'));
	    my $time;
	    if ($handicap_net) {
		$time = 0;
		my @realcoords = @{ $r->path };
		for(my $ii=0; $ii<$#realcoords; $ii++) {
		    my $s = Strassen::Util::strecke($realcoords[$ii],$realcoords[$ii+1]);
		    my @etappe_speeds = $speed;
## XXX warum ist das hier nicht aktiviert, sieht mir sinnvoll aus?
## XXX Aus dem RCS log: das hier war nie aktiv, kein Kommentar.
## XXX Antwort: weil qualitaet_s_speed nicht definiert ist
#		    if ($qualitaet_net && (my $cat = $qualitaet_net->{Net}{join(",",@{$realcoords[$ii]})}{join(",",@{$realcoords[$ii+1]})})) {
#		    push @etappe_speeds, $qualitaet_s_speed{$cat}
#			if defined $qualitaet_s_speed{$cat};
#		}
		    if ($handicap_net && (my $cat = $handicap_net->{Net}{join(",",@{$realcoords[$ii]})}{join(",",@{$realcoords[$ii+1]})})) {
			push @etappe_speeds, $handicap_speed{$cat}
			    if defined $handicap_speed{$cat};
		    }
		    $time += ($s/1000)/min(@etappe_speeds);
		}
	    } else {
		$time = $r->len/1000/$speed;
	    }
	    $def->{Time} = $time;
	    $speed_map{$speed} = $def;
	}

	if ($bp_obj and $bikepwr_time[0]) {
	    for my $i (0 .. $#power) {
		$power_map{$power[$i]} = {Time => $bikepwr_time[$i]};
	    }
	}

	if (!defined $r->trafficlights && new_trafficlights()) {
	    $r->add_trafficlights($ampeln);
	}

	if ($with_comments) {
	    if (!$comments_net) {
		my @s;
		my @comment_files = qw(comments qualitaet_s);
		if ($scope eq 'region' || $scope eq 'wideregion') {
		    push @comment_files, "qualitaet_l";
		}
		if (@custom && grep { $_ =~ /^temp-blocking-/ } @custom &&
		    $custom_s{"handicap"}) {
		    push @s, $custom_s{"handicap"};
		} else {
		    push @comment_files, "handicap_s";
		    if ($scope eq 'region' || $scope eq 'wideregion') {
			push @comment_files, "handicap_l";
		    }
		}
		if ($q->param('pref_ferry') && $q->param('pref_ferry') eq 'use') {
		    push @comment_files, 'comments_ferry';
		}

		for my $s (@comment_files) {
		    eval {
			if ($s eq 'comments') {
			    my @ms;
			    for my $comment_file (map { "comments_$_" } grep { $_ ne "kfzverkehr" } @Strassen::Dataset::comments_types) {
				if ($comment_file eq 'comments_route') {
				    push @ms, Strassen->new($comment_file, UseLocalDirectives => 1);
				} else {
				    push @ms, Strassen->new($comment_file);
				}
			    }
			    push @s, MultiStrassen->new(@ms);
			} elsif ($s =~ /^(qualitaet|handicap)/) {
			    my $old_s = Strassen->new($s);
			    my $new_s = $old_s->grepstreets
				(sub { $_->[Strassen::CAT] !~ /^[qQ]0/ },
				 -idadd => "q1234");
			    push @s, $new_s;
			} else {
			    push @s, Strassen->new($s);
			}
		    };
		    warn "$s: $@" if $@;
		}

		if (@s) {
		    $comments_net = StrassenNetz->new(MultiStrassen->new(@s));
		    $comments_net->make_net_cat(-obeydir => 1,
						-net2name => 1,
						-multiple => 1);
		}
	    }

	    if (!$sperre_tragen || !$sperre_narrowpassage) {
		eval {
		    my $special_vehicle = $q->param('pref_specialvehicle') || '';
		    $sperre_tragen = {};
		    $sperre_narrowpassage = {};
		    StrassenNetz::make_sperre_tragen('gesperrt', $special_vehicle, $sperre_tragen, $sperre_narrowpassage, -extended => 1);
		};
		warn $@ if $@;
	    }
	    @path = $r->path_list;
	}

	my($next_entf, $ges_entf_s, $next_winkel, $next_richtung, $next_extra)
	    = (0, "", undef, "", undef);

	my $ges_entf = 0;
	for(my $i = 0; $i <= $#strnames; $i++) {
	    my $strname;
	    my $etappe_comment = '';
	    my $etappe_comment_html = '';
	    my $fragezeichen_comment = '';
	    my $entf_s = '';
	    my $raw_direction;
	    my $route_inx;
	    my $important_angle_crossing_name;
	    my($entf, $winkel, $richtung, $extra)
		= ($next_entf, $next_winkel, $next_richtung, $next_extra);
	    ($strname, $next_entf, $next_winkel, $next_richtung,
	     $route_inx, $next_extra) = @{$strnames[$i]};
	    $strname = Strasse::strip_bezirk_perfect($strname, $city);
	    if ($i > 0) {
		if (!$winkel) { $winkel = 0 }
		$winkel = int($winkel/10)*10;
		my $same_streetname_important_angle =
		    @out_route && $out_route[-1]->{Strname} eq $strname && $extra && $extra->{ImportantAngleCrossingName};
		if ($winkel < 30 && (!$extra || !$extra->{ImportantAngle})) {
		    $richtung = "";
		    $raw_direction = "";
		} else {
		    $raw_direction =
			($winkel <= 45 ? 'h' : '') .
			    ($richtung eq 'l' ? 'l' : 'r');
		    $richtung =
			($winkel <= 45 ? M('halb') : '') .
			    ($richtung eq 'l' ? M('links') : M('rechts')) .
				" ($winkel�) ";
		    if ($lang eq 'en') {
			$richtung .= "-&gt;";
		    } else {
			if ($same_streetname_important_angle) {
			    $richtung .= "weiter " . Strasse::de_artikel_genitiv($strname);
			} else {
			    $richtung .= Strasse::de_artikel($strname);
			}
		    }
		}
		if ($same_streetname_important_angle) {
		    $important_angle_crossing_name = Strasse::strip_bezirk($extra->{ImportantAngleCrossingName});
		}
		$ges_entf += $entf;
		$ges_entf_s = sprintf "%.1f km", $ges_entf/1000;
		$entf_s = sprintf M("nach") . " %.2f km", $entf/1000;
	    } elsif ($#{ $r->path } > 1) {
		my($x1,$y1) = @{ $r->path->[0] };
		my($x2,$y2) = @{ $r->path->[1] };
		$raw_direction =
		    uc(BBBikeCalc::line_to_canvas_direction
		       ($x1,$y1,$x2,$y2));
		$richtung = ($lang eq 'en' ? "towards" : "nach") . " " .
		    BBBikeCalc::localize_direction($raw_direction, $lang eq '' ? "de" : $lang);
	    }

	    if ($with_comments && $comments_net) {
		my @comment_objs;
		my %seen_comments_in_this_etappe;
		my %comments_in_whole_etappe;
		my %comments_at_beginning;
		my $is_first = 1;
		for my $i ($strnames[$i]->[4][0] .. $strnames[$i]->[4][1]) {
		    my @etappe_comment_inxs = $comments_net->get_point_comment(\@path, $i, undef, AsIndex => 1);

		    my %etappe_comments;
		    if (@etappe_comment_inxs) {
			my @etappe_comment_objs;
			for my $inx (@etappe_comment_inxs) {
			    my $etappe_comment_obj = $comments_net->{Strassen}->get($inx);
			    (my $name = $etappe_comment_obj->[Strassen::NAME()]) =~ s/^.+?:\s+//; # strip street;
			    my $dir = $comments_net->{Strassen}->get_directive($inx);
			    #                           Name   Object               URL (only first one)
			    push @etappe_comment_objs, [$name, $etappe_comment_obj, $dir->{url} ? $dir->{url}[0] : undef];
			}
			%etappe_comments = map {($_->[0],1)} @etappe_comment_objs;
			foreach my $etappe_comment_obj (@etappe_comment_objs) {
			    if (!exists $seen_comments_in_this_etappe{$etappe_comment_obj->[0]}) {
				push @comment_objs, $etappe_comment_obj;
				$seen_comments_in_this_etappe{$etappe_comment_obj->[0]}++;
			    }
			}
		    }
		    if ($is_first) {
			%comments_in_whole_etappe = %etappe_comments;
			%comments_at_beginning = %etappe_comments;
			$is_first = 0;
		    } else {
			while(my($k,$v) = each %comments_in_whole_etappe) {
			    if (!exists $etappe_comments{$k}) {
				delete $comments_in_whole_etappe{$k};
			    }
			}
		    }
		}

		for (@comment_objs) {
		    # Alle Kommentare, die sich nur auf Teilstrecken
		    # beziehen, bekommen ein Anh�ngsel. Ausnahme:
		    # PI-Anweisungen. Eigentlich m�sste alles, was
		    # sich in comments_path befindet, ausgenommen
		    # werden, aber ich bekomme zurzeit die Info nicht
		    # heraus.

		    # translate comments
	            $_->[0] = M($_->[0]);

		    if (!exists $comments_in_whole_etappe{$_->[0]}) {
			my $cat = $_->[1]->[Strassen::CAT()];
			if (#XXX del: ($cat =~ /^CP2/ && !exists $comments_at_beginning{$_->[0]}) || #XXX this looks simply too ugly (poin comment and (Teilstrecke), but I need to review all of comments_* to have good names instead, esp. including the crossing name at point
			    $cat !~ /^(CP2|PI|CP$|CP;)/) {
			    $_->[0] .= " (" . M("Teilstrecke") . ")";
			}
		    }
		}

		my @comments = map { $_->[0] } @comment_objs;
		my @comments_html = map {
		    if ($_->[2]) {
			'<a href="' . $_->[2] . '">' . $_->[0] . '</a>';
		    } else {
			$_->[0];
		    }
		} @comment_objs;

		{
		    my @penalty_comments_name;
		    my %penalty_comments_penalty;
		    my %penalty_comments_count;
		    for my $i ($strnames[$i]->[4][0] .. $strnames[$i]->[4][1]) {
			my $point = join ",", @{ $path[$i] };
			for my $sperre_hash ($sperre_tragen, $sperre_narrowpassage) {
			    if (exists $sperre_hash->{$point}) {
				my($name, $penalty) = @{ $sperre_hash->{$point} };
				push @penalty_comments_name, $name;
				$penalty_comments_penalty{$name} += $penalty;
				$penalty_comments_count{$name}++;
				last; # anyway, no point should appear in tragen AND narrowpassage
			    }
			}
		    }

		    my %seen_penalty_name;
		    for my $penalty_name (@penalty_comments_name) {
			next if $seen_penalty_name{$penalty_name};
			$seen_penalty_name{$penalty_name} = 1;

			my $label = $penalty_name;
			if ($penalty_comments_count{$penalty_name} >= 2) {
			    $label .= ' (' . $penalty_comments_count{$penalty_name} . 'x)';
			}

			my $penalty = $penalty_comments_penalty{$penalty_name};
			if ($penalty == 0) {
			    $label .= " (" . M("kein Zeitverlust") . ")";
			} elsif ($penalty == 1) {
			    $label .= " (" . M("ca. eine Sekunde Zeitverlust") . ")";
			} elsif ($penalty < 120) {
			    $label .= " (" . sprintf(M("ca. %s Sekunden Zeitverlust"), $penalty) . ")";
			} else {
			    $label .= " (" . sprintf(M("ca. %s Minuten Zeitverlust"), int($penalty/60+0.5)) . ")";
			}
			push @comments, $label;
			push @comments_html, $label;
			$penalty_lost += $penalty;
		    }
		}
		$etappe_comment = join("; ", @comments) if @comments;
		$etappe_comment_html = join("; ", @comments_html) if @comments_html;
	    }

	    if ($has_fragezeichen_routelist) {
		my @comments;
		my %seen_comments_in_this_etappe;
		for my $i ($strnames[$i]->[4][0] .. $strnames[$i]->[4][1]) {
		    my($from, $to) = (join(",", @{$path[$i]}),
				      join(",", @{$path[$i+1]}));
		    if (exists $fragezeichen_net->{Net}{$from}{$to}) {
			my($etappe_comment) = $fragezeichen_net->get_street_record($from, $to)->[Strassen::NAME()];
			if (!exists $seen_comments_in_this_etappe{$etappe_comment}) {
			    push @comments, $etappe_comment;
			    $seen_comments_in_this_etappe{$etappe_comment} = 1;
			}
		    }
		}
		$fragezeichen_comment = join("; ", @comments) if @comments;
	    }

	    my $hop_info =
		{
		 Dist => $entf,
		 DistString => $entf_s,
		 TotalDist => $ges_entf,
		 TotalDistString => $ges_entf_s,
		 Direction => $raw_direction,
		 DirectionString => $richtung,
		 Angle => $winkel,
		 Strname => $strname,
		 ImportantAngleCrossingName => $important_angle_crossing_name,
		 ($with_comments && $comments_net ?
		  (Comment => $etappe_comment,
		   CommentHtml => $etappe_comment_html,
		  ) : ()
		 ),
		 ($has_fragezeichen_routelist ?
		  (FragezeichenComment => $fragezeichen_comment) : () # XXX key label may change!
		 ),
		 Coord => join(",", @{$r->path->[$route_inx->[0]]}),
		 PathIndex => $route_inx->[0],
		};
	    push @out_route, $hop_info;
	}
	$ges_entf += $next_entf;
	$ges_entf_s = sprintf "%.1f km", $ges_entf/1000;
	my $entf_s = sprintf M("nach") . " %.2f km", $next_entf/1000;
	push @out_route, {
			  Dist => $next_entf,
			  DistString => $entf_s,
			  TotalDist => $ges_entf,
			  TotalDistString => $ges_entf_s,
			  DirectionString => M("angekommen") . "!",
			  Strname => $real_zielname,
			  Comment => '',
			  CommentHtml => '',
			  Coord => join(",", @{$r->path->[-1]}),
			  PathIndex => $#{$r->path},
			 };
    }

    my @affecting_blockings;
    if (@current_temp_blocking && !@custom && !$printmode) {
    TEMP_BLOCKING:
	for my $tb (@current_temp_blocking) {
	    my $net         = $tb->{net}{Net};
	    my $wegfuehrung = $tb->{net}{Wegfuehrung};

	    my(@path) = $r->path_list;
	    for(my $i = 0; $i < $#path; $i++) {
		my($x1, $y1) = @{$path[$i]};
		my($x2, $y2) = @{$path[$i+1]};
		my $xy1 = "$x1,$y1";
		my $xy2 = "$x2,$y2";

		# Handling "1"/"2" and "qX" types
		if ($net->{$xy1}{$xy2}) {
		    push @affecting_blockings, $tb;
		    $tb->{lost_time}{$velocity_kmh} = lost_time($r, $tb, $velocity_kmh);
		    $tb->{hop} = [$xy1, $xy2];
		    next TEMP_BLOCKING;
		}

		# Handling "3" (wegfuehrung) types
		if ($wegfuehrung && exists $wegfuehrung->{$xy2}) {
		    for my $wegfuehrung (@{ $wegfuehrung->{$xy2} }) {
		    CHECK_WEGFUEHRUNG: {
			    for(my $j=0; $j<$#$wegfuehrung; $j++) {
				last CHECK_WEGFUEHRUNG
				    if ($j > $i || join(",",@{$path[$i-$j]}) ne $wegfuehrung->[$#$wegfuehrung-1-$j]);
			    }
			    push @affecting_blockings, $tb;
			    $tb->{hop} = [$xy1, $xy2];
			    next TEMP_BLOCKING;
			}
		    }
		}
	    }
	}
    }

 OUTPUT_DISPATCHER:
    if (defined $output_as && $output_as =~ /^(xml|yaml|yaml-short|json|json-short|perldump|gpx-route)$/) {
	for my $tb (@affecting_blockings) {
	    $tb->{longlathop} = [ map { join ",", convert_data_to_wgs84(split /,/, $_) } @{ $tb->{hop} || [] } ];
	}

	my $res;
	if ($r && $r->path) {
	    $res = {
		   Route => \@out_route,
		   Len   => $r->len, # in meters
		   Trafficlights => $r->trafficlights,
		   Speed => \%speed_map,
		   Power => \%power_map,
		   ($sess ? (Session => $sess->{_session_id}) : ()),
		   Path => [ map { join ",", @$_ } @{ $r->path }],
		   LongLatPath => [ map {
		       join ",", convert_data_to_wgs84(@$_)
		   } @{ $r->path }],
		   AffectingBlockings => \@affecting_blockings,
		  };
	} else {
	    $res = {
		    Error => 'No route found',
		    LongLatPath => [],
		  };
	}

	if ($output_as eq 'perldump') {
	    require Data::Dumper;
	    my $filename = filename_from_route($startname, $zielname) . ".txt";
	    http_header
		(-type => "text/plain",
		 @no_cache,
		 -Content_Disposition => "attachment; filename=$filename",
		);
	    print Data::Dumper->new([$res], ['route'])->Dump;
	} elsif ($output_as =~ /^yaml(.*)/) {
	    my $is_short = $1 eq "-short";
	    my $yaml_dump;
	    if (!eval { require YAML::Syck; $yaml_dump = sub { local $YAML::Syck::ImplicitUnicode = 1; YAML::Syck::Dump(@_) } }) {
		$YAML::Syck::ImplicitUnicode = $YAML::Syck::ImplicitUnicode if 0; # cease -w
		require YAML; $yaml_dump = \&YAML::Dump;
	    }
	    my $filename = filename_from_route($startname, $zielname) . ".yml";
	    http_header
		(-type => "text/plain", # XXX text/yaml ?
		 @no_cache,
		 -Content_Disposition => "attachment; filename=$filename",
		);
	    if ($is_short) {
		my $short_res = {LongLatPath => $res->{LongLatPath}};
		print $yaml_dump->($short_res);
	    } else {
		print $yaml_dump->($res);
	    }
	} elsif ($output_as =~ /^json(.*)/) {
	    my $is_short = $1 eq '-short';
	    require JSON::XS;
	    http_header
		(-type => "application/json",
		 @no_cache, # XXX why?
		);
	    if ($is_short) {
		my $short_res = {LongLatPath => $res->{LongLatPath}};
		# XXX I think a temp_blockings-containing object might
		# go into the dump, which would cause JSON::XS to
		# fail. Maybe I should create a TO_JSON converter, or
		# just leave it as is (that is, allow the blessed
		# object to be converted to null)
		print JSON::XS->new->utf8->allow_blessed(1)->encode($short_res);
	    } else {
		print JSON::XS->new->utf8->allow_blessed(1)->encode($res);
	    }
	} elsif ($output_as eq 'gpx-route') {
	    require Strassen::GPX;
	    my $filename = filename_from_route($startname, $zielname) . ".gpx";
	    http_header
		(-type => "application/xml",
		 -Content_Disposition => "attachment; filename=$filename",
		);
	    my @data;
	    for my $pt (@out_route) {
		push @data, $pt->{Strname} . "\tX " . $pt->{Coord} . "\n";
	    }
	    my $s = Strassen->new_from_data(@data);

	    my $s_gpx = Strassen::GPX->new($s);
	    $s_gpx->{"GlobalDirectives"}->{"map"}[0] = "polar" if $data_is_wgs84;
	    print $s_gpx->bbd2gpx(-as => "route");
            # use Data::Dumper; warn "gpx-route: ", Dumper($s_gpx->bbd2gpx(-as => "route")), "\n";

	} else { # xml
	    require XML::Simple;
	    my $filename = filename_from_route($startname, $zielname) . ".xml";
	    http_header
		(-type => 'application/xml',
		 -charset => '', # to suppress default of iso-8859-1
		 @no_cache,
		 -Content_Disposition => "attachment; filename=$filename",
		);
	    my $new_res = {};
	    while(my($k,$v) = each %$res) {
		if ($k eq 'Path' || $k eq 'LongLatPath') {
		    $new_res->{$k} = { XY => $v };
		} elsif ($k eq 'Route') {
		    $new_res->{$k} = { Point => $v };
		} elsif ($k eq 'AffectingBlockings') {
		    $new_res->{"AffectingBlocking"} = [ map {
			+{
			  Text => $_->{text},
			  Index => $_->{index},
			  Type => $_->{type},
			  LongLatHop => { XY => $_->{longlathop} },
			 }
		    } @$v ]
		} else {
		    $new_res->{$k} = $v;
		}
	    }

	    my $xml_encoding = 'iso-8859-1';
            if ($use_utf8) {
	        binmode STDOUT, ":utf8";
		$xml_encoding = 'UTF-8';
            }

	    print XML::Simple->new
		(NoAttr => 1,
		 RootName => "BBBikeRoute",
		 XMLDecl => "<?xml version='1.0' encoding='$xml_encoding' standalone='yes'?>",
		 SuppressEmpty => 1, # e.g. Trafficlights may be undefined
		)->XMLout($new_res);
	}
	return;
    }

    %persistent = get_cookie();
    foreach my $key (@pref_keys) {
	$persistent{"pref_$key"} = $q->param("pref_$key");
	if (!defined $persistent{"pref_$key"}) {
	    #$persistent{"pref_$key"} = "";
	    delete $persistent{"pref_$key"};
	}
    }
    my $cookie = set_cookie({ %persistent });

    http_header(@weak_cache,
		-cookie => $cookie,
	       );
    my %header_args;
##XXX die Idee hierbei war: table.background ist bei Netscape der Hintergrund
## ohne cellspacing, w�hrend es beim IE mit cellspacing ist. Also f�r
## jedes td bgcolor setzen. Oder besser mit Stylesheets arbeiten. Nur wie,
## wenn man nicht f�r jedes td die Klasse setzen will?
#     if ($can_css) {
# 	$header_args{'-style'} = <<EOF;
# <!--
# $std_css
# td { background:#ffcc66; }
# -->
# EOF
#     }
    $header_args{-script} = {-src => bbbike_result_js() };
    $header_args{-printmode} = 1 if $printmode;
    $header_args{-result} = M("Route");

    header(%header_args, -onLoad => "init_search_result()");

 ROUTE_HEADER:
    if (!@out_route) {
	print M("Keine Route gefunden").".\n";
	warn "Fehler: keine Route zwischen <$startname>" . ($vianame ? ", <$vianame>" : "") . " und <$zielname> gefunden, sollte niemals passieren" . (@affecting_blockings ? " (Ausnahme: bei dieser Suche waren tempor�re Sperrungen aktiv)" : "");
    } else {
	if (@affecting_blockings) {
	    my $hidden = "";
	    foreach my $key ($q->param) {
		$hidden .= $q->hidden(-name => $key,
				      -default => [$q->param($key)]);
	    }
	    print qq{<form class="altroutebox" name="Ausweichroute" action="} .
		BBBikeCGIUtil::my_url($q) . qq{" } . (@affecting_blockings > 1 ? qq{onSubmit="return test_temp_blockings_set()"} : "") . qq{>};
	    print $hidden;
	    if ($sess) {
		print $q->hidden(-name    => 'oldcs',
				 -default => $sess->{_session_id},
				);
	    }
	    print "<b>" . M("Ereignisse, die die Route betreffen k&ouml;nnen") . "</b>:<br>";
	    for my $tb (@affecting_blockings) {
		my $lost_time_info = $tb->{lost_time}{$velocity_kmh};
		print "<input type=\"" .
		    (@affecting_blockings > 1 ? "checkbox" : "hidden") .
			"\" name=\"custom\" value=\"temp-blocking-$tb->{'index'}\"> ";
		print "$tb->{text}";
		if ($lost_time_info && $lost_time_info->{lost_time_string_de}) {
		    print " ($lost_time_info->{lost_time_string_de})";
		}
		print "<br>";
	    }
	    print <<EOF;
<input type=submit value="@{[ M("Ausweichroute suchen") ]}">
</form><p>
EOF
	}
	if (@custom && !$printmode) {
	    print "<center>";
	    my $diff_info = diff_from_old_route($r);
	    if ($diff_info->{different}) {
		print M("M�gliche Ausweichroute") . " ";
		print $diff_info->{difference} if $diff_info->{difference};
	    } else {
		print M("Eine bessere Ausweichroute wurde nicht gefunden");
	    }
	    print "</center>\n";
	}

    ROUTE_TABLE:
	if (is_mobile($q)) {
	    print qq{<span id="mobile_link">\n};
	    my $url = $q->url(-full=>0, -absolute=>1, -query=>1);
            $url =~ s,^/m/,/,;
            #&social_link;
            print qq{<a class="mobile_link" href="$url" title="}, M("BBBike in classic view"), qq{">[classic view]</a>\n};
	    print qq{</span>\n\n};

	    print <<EOF;
<style type="text/css">
body, select, input, span.slippymaplink { font-size: x-large }
a.mobile_link { font-size: xx-large; margin-top: 3em; padding-top: 3em; }
</style>
EOF
	}

	print qq{<div id="route_table">\n};
	print "<center>" unless $printmode;
	print qq{<table id="routehead" bgcolor="#ffcc66"};
	if ($printmode) {
	    print " width='$printwidth'";
	}
	my $can_jslink = $can_mapserver && !$printmode && $bi->{'can_javascript'};
	print "><tr><td>$fontstr";
	if ($routetitle) {
	    print "<b>" . CGI::escapeHTML($routetitle) . "</b>";
	} elsif (!$zielname) {
	    if (!$startname) {
		print "<b>" . M("Route") . "</b>";
	    } else {
		print "<b>" . $startname . "</b>";
	    }
	} elsif ($osm_data) {
		print M("Route von") . " <b>$startname</b> ";
		print M("&uuml;ber") . " <b>$vianame</b> " if (defined $vianame && $vianame ne '');
	    	print M("bis") . " <b>$real_zielname</b> ";
 
	} else {
	    print M("Route von") . " <b>" .
		coord_or_stadtplan_link($startname, $startcoord,
					$q->param('startplz')||"",
					$q->param('startisort')?1:0,
					(defined $starthnr && $starthnr ne '' ? $starthnr : undef),
					-jslink => $can_jslink,
				       )
		    . "</b> ";
	    if (defined $vianame && $vianame ne '') {
		print M("&uuml;ber") . " <b>" .
		    coord_or_stadtplan_link($vianame, $viacoord,
					    $q->param('viaplz')||"",
					    $q->param('viaisort')?1:0,
					    (defined $viahnr && $viahnr ne '' ? $viahnr : undef),
					    -jslink => $can_jslink,
					   )
			. "</b> ";
	    }
	    print M("bis") . " ";
	    if ($r && $r->nearest_node) {
		print "<b>" . coord_or_stadtplan_link($real_zielname, $r->nearest_node,
						      "", 0, undef,
						      -jslink => $can_jslink,
						     ) . "</b>";
		# XXX richtigen Artikel statt => einsetzen
		print " (" . M("Entfernung") . " => $zielname: " . int(Strassen::Util::strecke_s($zielcoord, $r->nearest_node)) . "m)";
	    } else {
		print "<b>" . coord_or_stadtplan_link($real_zielname, $zielcoord,
						      $q->param('zielplz')||"",
						      $q->param('zielisort')?1:0,
						      (defined $zielhnr && $zielhnr ne '' ? $zielhnr : undef),
						      -jslink => $can_jslink,
						     ) . "</b>";
	    }
	}
	print "$fontend</td></tr></table><br>\n";
	print "<table";
	if ($printmode) {
	    print " width='$printwidth'";
	}
	print ">\n";
	printf "<tr><td>${fontstr}@{[ M('L&auml;nge') ]}:$fontend</td><td>${fontstr}%.2f km$fontend</td>\n", $r->len/1000;
	print
	  "<tr><td>${fontstr}@{[ M('Fahrzeit') ]}:$fontend</td>";

	my $ampel_count;
	my $ampel_lost = 0;
	if (defined $r->trafficlights) {
	    $ampel_count = $r->trafficlights;
	    $ampel_lost = 15*$ampel_count; # XXX do not hardcode!
	}

        my $driving_time = "";
	{
	    my $i = 0;
	    my @speeds = sort { $a <=> $b } keys %speed_map;
	    for my $speed (@speeds) {
		my $def = $speed_map{$speed};
		my $bold = $def->{Pref};
		my $time = $def->{Time};
		print "<td>$fontstr" . make_time($time + $ampel_lost/3600 + $penalty_lost/3600)
		    . "h (" . ($bold ? "<b>" : "") . M("bei")." $speed km/h" . ($bold ? "</b>" : "") . ")";
		print "," if $speed != $speeds[-1];
		print "$fontend</td>";

                $driving_time .= "|" if $driving_time;
		$driving_time .= make_time($time + $ampel_lost/3600 + $penalty_lost/3600) . ':' . $speed;

		if ($i == 1) {
		    print "</tr><tr><td></td>";
		}
		$i++;
	    }
	}
	print "</tr>\n";
	if (%power_map) {
	    print "<tr><td></td>";
	    my $is_first = 1;
	    for my $power (sort { $a <=> $b } keys %power_map) {
		print "<td>";
		if (!$is_first) {
		    print ",";
		} else {
		    $is_first = 0;
		}
		print $fontstr,  make_time(($power_map{$power}->{Time} + $ampel_lost + $penalty_lost)/3600) . "h (" . M("bei") . " $power W)", $fontend, "</td>"
	    }
	    print "</tr>\n";
	}
	print "</table>\n";
	if (defined $ampel_count) {
	    print $fontstr;
	    if ($ampel_count == 0) {
		print M("Keine Ampeln");
	    } else {
		print $ampel_count . " " . M("Ampel" . ($ampel_count == 1 ? "" : "n"));
	    }
	    print " " . M("auf der Strecke");
	    if ($ampel_count) {
		print " (" . M("in die Fahrzeit einbezogen") . ")";
	    }
	    print ".$fontend<br>\n";
	}
	print "</center>\n" unless $printmode;
       
	print "<hr>";
	print "</div>\n"; # id="route_table"

	my $line_fmt;
	if (!$bi->{'can_table'}) {
	    $with_comments = 0;
	    if ($bi->{'mobile_device'}) {
		$line_fmt = "%s %s %s (ges.:%s)\n";
	    } else {
		$line_fmt = "%-13s %-24s %-31s %-8s";
##XXX does not work:
# 		if ($has_fragezeichen_routelist && !$printmode) {
# 		    $line_fmt .= " %s";
# 		}
		$line_fmt .= "\n";
	    }
	    print "<pre>";
	} else {
	    # Ist width=... bei Netscape4 buggy? Das nachfolgende Attribut
	    # ignoriert font-family.
	    #   width=\"90%\"
	    print q{<center>} unless $printmode;
	    print q{<table cellspacing="0" cellpadding="0" class='routelist};
	    #print q{<table  class='routelist};
	    if ($printmode) {
		print " print";
	    }
	    print "' id='routelist' ";
	    if ($printmode) {
#		print ' style="border: 1px solid black;"';
#		print " border=1"; # XXX ohne geht's leider nicht
		print " width='$printtablewidth'";
	    } else {
		print " align=center";
		if (1 || !$bi->{'can_css'}) { # XXX siehe Kommentar oben (css...)
#		    print ' XXXbgcolor="#ffcc66" style="background-color:#ffcc66; border-style:solid; border:white; border-width:1px;" ';
		    print ' bgcolor="#ffcc66" ';
		}
	    }
	    print "><tr><th>${fontstr}" . M("Etappe") . "$fontend</th><th>${fontstr}" . M("Richtung") . "$fontend</th><th>${fontstr}" . M("Stra&szlig;e") . "$fontend</th><th>${fontstr}" . M("Gesamt") . "$fontend</th>";
	    if ($with_comments) {
		print "<th" . ($with_cat_display && !$printmode ? " colspan=4" : "") .
	              ">${fontstr}" . M("Bemerkungen") . "$fontend</th>";
	    }
	    if ($has_fragezeichen_routelist && !$printmode) {
		print "<th></th>"; # no header for Fragezeichen
	    }
	    print "</tr>\n";
	}

	if ($with_cat_display && !$radwege_net) {
	    $radwege_net = new StrassenNetz get_cyclepath_streets();
	    $radwege_net->make_net_cat;
	}

	my %cat_to_title = ( NN => M("Weg ohne Kfz"),
			     N  => M("Nebenstra�e"),
			     NH => M("wichtige Nebenstra�e"),
			     H  => M("Hauptstra�e"),
			     HH => M("wichtige Hauptstra�e"),
			     B  => M("Bundesstra�e"),
			     fz => M("unbekannte Strecke"),
			     Q  => M("F�hre"),
			   );
	my %rw_to_title = ( RW => M("Radweg"),
			    RS => M("Radspur"),
			    FS => M("Fahrradstra�e"),
			    BS => M("Busspur"),
			    NF => M("Nebenfahrbahn"),
			  );

  	my $odd = 0;
	my $etappe_i = -1;
	for my $etappe (@out_route) {
	    $etappe_i++;
	    my($entf, $richtung, $strname, $important_angle_crossing_name, $ges_entf_s,
	       $etappe_comment_html, $fragezeichen_comment, $path_index) =
		   @{$etappe}{qw(DistString DirectionString Strname ImportantAngleCrossingName TotalDistString CommentHtml FragezeichenComment PathIndex)};
	    my $last_path_index;
	    if ($etappe_i < $#out_route) {
		$last_path_index = $out_route[$etappe_i+1]->{PathIndex} - 1;
	    }
	    if (!$bi->{'can_table'}) {
		printf $line_fmt,
		    $entf, $richtung, string_kuerzen($strname, 31), $ges_entf_s;
	    } else {
		## XXX rechter Pfeil, sieht eigentlich sch�ner aus, aber wo ist es unterst�tzt?
		#$richtung =~ s/=>/&#x2192;/g;
		print "<tr class=" . ($odd ? "odd" : "even") . "><td nowrap>$fontstr$entf$fontend</td><td>$fontstr$richtung$fontend</td><td>$fontstr";
		print "<a class=ms href='#' onclick='return ms($etappe->{Coord})'>"
		    if $can_jslink;
		print $strname;
		if ($important_angle_crossing_name) {
		    print " (" . M("Ecke") . " " . $important_angle_crossing_name . ")";
		}
		print "</a>"
		    if $can_jslink;
		print "$fontend</td><td nowrap>$fontstr$ges_entf_s$fontend</td>";
		$odd = 1-$odd;
		if ($with_comments && $comments_net) {
		    if ($with_cat_display && !$printmode) {
			# Es wird jeweils die l�ngste
			# Stra�en/Radwegekategorie f�r die Anzeige
			# verwendet.
			my($cat, $rw);
			if (defined $last_path_index) {
			    my($longest_cat, $cat_length);
			    my($longest_rw,  $rw_length);
			    for my $path_i ($path_index .. $last_path_index) {
				my $p1 = join(",", @{$r->path->[$path_i]});
				my $p2 = join(",", @{$r->path->[$path_i+1]});
				my $len = Strassen::Util::strecke_s($p1, $p2);
				if (!defined $cat_length || $cat_length < $len) {
				    my $rec = $net->get_street_record($p1, $p2);
				    if ($rec) {
					my $cat = $rec ? $rec->[Strassen::CAT] : '';
					if ($cat =~ /^\?/) {
					    $cat = 'fz';
					}
					$longest_cat = $cat;
					$cat_length = $len;
				    }
				}
				if ($radwege_net &&
				    (!defined $rw_length || $rw_length < $len)) {
				    my $rw;
				    my $rw_rec = $radwege_net->{Net}->{$p1}->{$p2};
				    if ($rw_rec) {
					if ($rw_rec =~ /^RW([1289])?$/) {
					    $rw = "RW";
					} elsif ($rw_rec =~ m{^RW[34]$}) {
					    $rw = "RS";
					} elsif ($rw_rec eq 'RW7') {
					    $rw = 'FS';
					} elsif ($rw_rec eq 'RW5') {
					    $rw = "BS"; # Busspur
					} elsif ($rw_rec eq 'RW10') {
					    $rw = "NF"; # Nebenfahrbahn
					}
				    }
				    $longest_rw = $rw;
				    $rw_length = $len;
				}
			    }
			    if ($longest_cat) {
				$cat = $longest_cat;
			    }
			    $rw = $longest_rw || "";
			}
			if ($cat) {
			    my $cat_title = $cat_to_title{$cat};
			    my $rw_title;
			    if ($rw) {
				$rw_title = $rw_to_title{$rw};
			    }
			    my $title = $cat_title;
			    if ($rw_title) {
				$title .= ", $rw_title";
			    }
			    print "<td></td><td title='$title' class='cat$cat catcell$rw'></td><td></td>";
			} else {
			    print "<td></td><td></td><td></td>";
			}
		    }
		    print "<td>$fontstr$etappe_comment_html$fontend</td>";
		}
		if ($has_fragezeichen_routelist && !$printmode && !$osm_data) {
		    if (defined $fragezeichen_comment && $fragezeichen_comment ne "") {

			# unbekannt oder unvollst�ndig
			my $is_unknown = 1;
			my $rec;
			if ($path_index < $#{ $r->path }) {
			    $rec = $net->get_street_record(join(",", @{$r->path->[$path_index]}),
							   join(",", @{$r->path->[$path_index+1]}));
			}
			if ($rec && $rec->[Strassen::CAT] !~ /^\?/) {
			    $is_unknown = 0;
			}			

			my $qs = CGI->new({strname => $fragezeichen_comment,
					   strname_html => CGI::escapeHTML($fragezeichen_comment),
					   supplied_coord => join(",", @{$r->path->[$path_index]}),
					  })->query_string;
			print qq{<td>$fontstr<a target="newstreetform" href="$bbbike_html/shortfragezeichenform${newstreetform_encoding}.html?$qs">};
			if ($is_unknown) {
			    print qq{Unbekannte Stra�e};
			} else {
			    print qq{Unvollst�ndige Daten};
			}
			print qq{, Kommentar eintragen</a>$fontend</td>};
		    } else {
			print qq{<td>&nbsp;</td>};
		    }
		}
		print "</tr>\n";
	    }
	}

	if ($bi->{'can_table'}) {
	    if (!$bi->{'text_browser'} && !$printmode) {
		my $qq_narrow = cgi_utf8($use_utf8);
		$qq_narrow->param('output_as', "print");
		my $qq_normal = cgi_utf8($use_utf8);
		$qq_normal->param('output_as', "print");
		$qq_normal->param('printvariant', "normal");

		# add a white bar
	        if (is_mobile($q)) { print qq{<tr bgcolor="white"><td>&nbsp;</td><td></td><td></td><td></td><td></td><td></td></tr>\n}; }

		print qq{<tr bgcolor="white">};
		#print qq{<td tyle="text-align:left">Route als ...</td>};
		print qq{<td colspan="};
		my $cols = 4;
		if ($with_comments && $comments_net) {
		    $cols++;
		}
		if ($with_cat_display && !$printmode) {
		    $cols += 3;
		}
		if ($has_fragezeichen_routelist && !$printmode) {
		    $cols++;
		}

		print qq{$cols" style="background-color:white; text-align:center;">};

		print
		    "<a style='padding:0 0.2cm 0 0.2cm;' title='" . M("Druckvorlage normal") . "' target=printwindow href=\"$bbbike_script?" . $qq_normal->query_string . "\">" .
		    "<img src=\"$bbbike_images/printer.gif\" " .
		    "width=16 height=16 border=0 alt='" . M("Druckvorlage normal") . "'></a>";
		print
		    "<a style='padding:0 0.2cm 0 0.2cm;' title='" . M("Druckvorlage schmal") . "' target=printwindow href=\"$bbbike_script?" . $qq_narrow->query_string . "\">" .
		    "<img src=\"$bbbike_images/printer_narrow.gif\" " .
		    "width=16 height=16 border=0 alt='" . M("Druckvorlage schmal") . "'></a>";
		if ($can_palmdoc) {
		    my $qq2 = cgi_utf8($use_utf8);
		    $qq2->param('output_as', "palmdoc");
		    my $href = $bbbike_script;
#XXX not needed anymore:
#		    if ($ENV{SERVER_SOFTWARE} !~ /Roxen/) {
#			# with Roxen there are mysterious overflow redirects...
#			$href .= "/route.pdb";
#		    }
		    print qq{<a style="padding:0 0.5cm 0 0.5cm;" href="$href?} . $qq2->query_string . qq{">PalmDoc</a>};
		}
	        print qq{\n<span><a class="mobile_link" target="" onclick='javascript:pdfLink();' href='#' title="}, M("PDF Ausdruck der Karte und Route"), qq{">PDF</a></span>\n};
		if ($can_gpx) {
		    {
		        my $qq2 = cgi_utf8($use_utf8);
			$qq2->param('output_as', "gpx-route");
			my $href = $bbbike_script;
			print qq{<a class="mobile_link" title="}, M("GPX Route mit Waypoints fuer GPS Navigation, bis zu 256 Punkte"), qq{" style="padding:0 0.5cm 0 0.5cm;" href="$href?} . $qq2->query_string . qq{">GPS (Route)</a>};
		    }
		    {
		        my $qq2 = cgi_utf8($use_utf8);
			$qq2->param('output_as', "gpx-track");
			my $href = $bbbike_script;
			print qq{<a class="mobile_link" title="}, M("GPX mit bis zu 1024 Punkten, keine Navigation"), qq{"padding:0 0.5cm 0 0.5cm;" href="$href?} . $qq2->query_string . qq{">GPS (Track)</a>};
		    }
		}
		if ($can_kml) {
		    my $qq2 = cgi_utf8($use_utf8);
		    $qq2->param('output_as', "kml-track");

		    my $href = $bbbike_script;
		    print qq{<a class="mobile_link" title="}, M("Route auf Google Earth anschauen"), qq{" style="padding:0 0.5cm 0 0.5cm;" href="$href?} . $qq2->query_string . qq{">Google Earth (KML)</a>};
		}
		if ($can_gpsies_link) {
		    my $qq2 = cgi_utf8($use_utf8);
		    $qq2->param('output_as', "gpx-track");
		    my $bbbike_script = $bbbike_script;
		    if ($bbbike_script =~ m{^https?://[^.]+/}) { # local hostname?
			$bbbike_script = $BBBike::BBBIKE_DIRECT_WWW;
		    }
		    my $href = 'http://www.gpsies.com/map.do?url=' . BBBikeCGIUtil::my_escapeHTML($qq2->url(-full=>1, -query=>1));
		    print qq{<a title="}, M("Route auf GPSies.com hochladen"), qq{" style="padding:0 0.5cm 0 0.5cm;" href="$href">GPSies.com (upload)</a>};
		}
		print qq{<a href="$facebook_page" target="_new"><img class="logo" src="/images/facebook-t.png" alt="" title="}, M("Facebook Fanpage"), qq{"><img class="logo" src="/images/facebook-like.png" alt="" title="}, M("Facebook Fanpage"), qq{"></a>\n};
	        print qq{<a class="gplus" onmouseover="javascript:google_plusone();" ><img src="/images/google-plusone-t.png"></a><g:plusone href="http://bbbike.org" size="standard" count="true"></g:plusone>\n} if $enable_google_plusone_t_link;

		if (0) { # XXX not yet
		    my $qq2 = CGI->new({});
		    $qq2->param("query", $q->query_string);
		    my $href = "bbbike_comment.cgi";
		    print qq{<a target="BBBikeComment" style="padding:0 0.5cm 0 0.5cm;" href="$href?} . $qq2->query_string . qq{">Kommentar zur Route</a>};
		}
		print "</td></tr>";

		# add a white bar
	        if (is_mobile($q)) { print qq{<tr bgcolor="white"><td>&nbsp;</td><td></td><td></td><td></td><td></td><td></td></tr>\n}; }
	    }

	    print "</table>\n";
	    print "</center>\n" unless $printmode;
	}

	if ($printmode) {
	    my $url = $q->url(-base => 1);
	    print "<hr><br>", $fontstr, qq{(&copy;) 1998-2011 <a href="$url">$url</a>\n};

	    goto END_OF_HTML;
	}

	if (!$bi->{'mobile_device'}) {
	    my $string_rep = $r->as_cgi_string;
	    my $kfm_bug = ($q->user_agent =~ m|^Konqueror/1.0|i);
            # XXX Mit GET statt POST gibt es zwar einen h��lichen GET-String
	    # und vielleicht k�nnen lange Routen nicht gezeichnet werden,
	    # daf�r gibt es keine Cache-Probleme mehr.
	    # (M�glicher Fix: timestamp mitschicken)
	    # Weiterer Vorteil: die Ergebnisse werden auch im accesslog
	    # aufgezeichnet. Ansonsten muesste ich ein weiteres Logfile
	    # anlegen.
	    my $post_bug = 0; # XXX f�r alle aktivieren
	    #$post_bug = 1 if ($kfm_bug); # XXX war mal nur f�r kfm
	    #print "<hr>";

	    print qq{<span id="slippymap_span1">\n};
            my $cityname = $osm_data && $main::datadir =~ m,data-osm/(.+), ? $1 : 'bbbike';

            my $pdf_url = CGI->new($q);
            $pdf_url->param('imagetype', 'pdf-auto');
	    $pdf_url->param( 'coords', $string_rep);
	    $pdf_url->param( 'startname', Encode::is_utf8($startname) ? $startname : Encode::encode( utf8 => $startname));
	    $pdf_url->param( 'zielname', Encode::is_utf8($zielname) ? $zielname : Encode::encode( utf8 => $zielname));
	    $pdf_url->param( 'vianame', Encode::is_utf8($vianame) ? $vianame : Encode::encode( utf8 => $vianame));
	    $pdf_url->param( -name=>'draw', -value=>[qw/str strname sbahn wasser flaechen title/]);

            my $slippymap_url = CGI->new($q);
            $slippymap_url->param('coordsystem', 'wgs84');
            $slippymap_url->param('maptype', 'cycle');
            $slippymap_url->param('city', $cityname);
            $slippymap_url->param('source_script', "$cityname.cgi");
            $slippymap_url->param('zoom', $slippymap_zoom_maponly);
	    $slippymap_url->param( 'coords', $string_rep);
	    $slippymap_url->param( 'startname', Encode::is_utf8($startname) ? $startname : Encode::encode( utf8 => $startname));
	    $slippymap_url->param( 'zielname', Encode::is_utf8($zielname) ? $zielname : Encode::encode( utf8 => $zielname));
	    $slippymap_url->param( 'vianame', Encode::is_utf8($vianame) ? $vianame : Encode::encode( utf8 => $vianame));
	    $slippymap_url->param( 'lang', $lang);
	    $slippymap_url->param( -name=>'draw', -value=>[qw/str strname sbahn wasser flaechen title/]);
	    $slippymap_url->param( 'route_length', sprintf("%2.2f", $r->len/1000));
	    $slippymap_url->param( 'driving_time', $driving_time);


	    my $area2 = '';
	    {
	    	my $geo = get_geography_object();
	    	if ($geo->is_osm_source && exists $geo->{'bbox_wgs84'}) {
               	   my @list = @{ $geo->{'bbox_wgs84'} };
	  	   my $area = "$list[0],$list[1]!$list[2],$list[3]";	
	           $slippymap_url->param( 'area', $area );
		   $area2 = $area;
	    	} 
	    }

            my $smu = $slippymap_url->url(-query=>1, -relative=>1);
           $smu =~ s/.*?\?//;

	    print <<EOF;
<script type="text/javascript"> 
    function slippymapExternal () { 
	document.slippymapFormExternal.submit(); 
    } 
    function pdfLink () { 
	document.pdfForm.submit(); 
    } 
</script>
EOF
	# IE6 & IE7 are not supported by google maps v3
	$gmapsv3 = 0 if &is_ie6($q) || &is_ie7($q);

	if (!$gmapsv3) {
	    print $q->start_form(-method=>"POST", -name => "slippymapForm", -target => "slippymapIframe", -action => "/cgi/slippymap.cgi?city=" . $slippymap_url->param('city') );
	    foreach my $name (qw/coordsystem maptype city source_script zoom startname zielname lang draw area coords route_length driving_time/) {
		print $q->hidden(-name => $name, -default => [ $slippymap_url->param($name) ]), "\n";
	    }
	    print $q->hidden('map_menu', "0");
	    print $q->end_form;
        }
	    print qq{\n</span><!-- slippymap_span1 -->\n};

	if (!$gmapsv3) {
	    print qq{<span id="slippymap_span2">\n};
	    print $q->start_form(-method=>"POST", -name => "slippymapFormExternal", -target => "_new", -action => "/cgi/slippymap.cgi?city=" . $slippymap_url->param('city') );
	    foreach my $name (qw/coordsystem maptype city source_script zoom startname zielname lang draw area coords/) {
		print $q->hidden(-name => $name, -default => [ $slippymap_url->param($name) ]), "\n";
	    }
	    print $q->hidden('map_menu', "1");
	    print $q->end_form;
	    print qq{\n</span><!-- slippymap_span2 -->\n};
	}

	    print qq{<span id="pdf_span1">\n};
	    print $q->start_form(-method=>"POST", -name => "pdfForm", -target => "_new", -action => "" );
	    foreach my $name (qw/imagetype startname zielname draw coords/) {
		print $q->hidden(-name => $name, -default => [ $pdf_url->param($name) ]), "\n";
	    }
	    print $q->end_form;
	    print qq{\n</span>\n};

	    if ($show_mini_googlemap) {
		my $qq = new CGI;
		#$qq->param( 'startname', Encode::encode( utf8 => $qq->param('startname')));
		#$qq->param( 'zielname', Encode::encode( utf8 => $qq->param('zielname')));
		my $permalink = BBBikeCGIUtil::my_escapeHTML($qq->url(-full=>1, -query=>1));

	        print qq{<div id="link_list">\n};
	        print qq{<hr>\n};

	        if (0) {
		print qq{<span class="slippymaplink"><a title="}, M("neue Anfrage"), qq{" href="}, $q->url(-absolute=>1, -query=>0), qq{">BBBike\@$local_city_name</a></span> |\n};
	        print qq{<span class="slippymaplink"><a target="" onclick='javascript:slippymapExternal();' href='#' title="Open slippy map in external window">larger map</a></span> |\n} if !$gmapsv3;
	        print qq{<span class="slippymaplink"><a target="" onclick='javascript:pdfLink();' href='#' title="}, M("PDF Ausdruck der Karte und Route"), qq{">}, M("drucken"), qq{</a></span>\n};
	        print qq{ | <span class="slippymaplink"><a href="#" onclick="togglePermaLinks(); return false;">permalink</a><span id="permalink_url" style="display:none"> $permalink</span></span>\n} if $permalink =~ /=/;
		}

	        print qq{<p></p>\n};
		print qq{</div>\n\n};

		if (is_mobile($qq)) {
		   #
		} elsif (!$gmapsv3) {
		print qq{<iframe name="slippymapIframe" title="slippy map" width="100%" height="800" scrolling="no"></iframe><p></p>};
		print qq{<script  type="text/javascript"> document.slippymapForm.submit(); </script>\n};
		} else {
		   my $maps = BBBikeGooglemap->new();
                   $maps->run('q' => CGI->new( "$smu"), 'gmap_api_version' => $gmap_api_version, 'lang' => &my_lang($lang), 'fullscreen' => 1, 'region' => $region, 'cache' => $q->param('cache') || 0, 'debug' => $debug );
		}
	    }

	    print qq{<div id="bbbike_graphic">\n};
	    print qq{<div class="box">\n};
	    print "<form name=showmap method=" .
		($post_bug ? "get" : "post");

	    my(%c) = %persistent;

	    my $default_imagetype = (defined $c{"imagetype"} ? $c{"imagetype"} : ($show_mini_googlemap ? "pdf-auto" : "png"));
	    if (($default_imagetype eq 'jpeg' && $cannot_jpeg) ||
		($default_imagetype =~ /^pdf/ && $cannot_pdf) ||
		($default_imagetype =~ /^svg$/ && $cannot_svg)) {
		$default_imagetype = "";
	    }
	    my $default_print = (defined $c{"outputtarget"} && $c{"outputtarget"} eq 'print' ? 1 : 0);
	    my $default_geometry = (defined $c{"geometry"} ? $c{"geometry"} : "1024x768");

	    my $default_draw = [];
	    for (0..99) {
		if (defined $c{"draw$_"}) {
		    push @$default_draw, $c{"draw$_"};
		} else {
		    last;
		}
	    }
	    if (!@$default_draw) {
		$default_draw = [qw/str strname title sbahn flaechen wasser/];
	    }
	    my %default_draw = map { ($_ => 1) } @$default_draw;

	    my $imagetype_checked = sub { my $val = shift;
					  'value="' . $val . '" ' .
					  ($default_imagetype eq $val ? "selected" : "")
				      };
	    my $geometry_checked = sub { my $val = shift;
					 'value="' . $val . '" ' .
					 ($default_geometry eq $val ? "checked" : "")
				      };


	    print " target=\"BBBikeGrafik\" action=\"$bbbike_script\"";
	    # show_map scheint bei OS/2 nicht zu funktionieren
	    # ... und bei weiteren Browsern (MSIE), deshalb erst einmal
	    # pauschal herausgenommen.
	    # Uns das bleibt auch so, es sei denn ich habe Zugang zu den
	    # meisten Browsern...
  	    if (0
#                 $bi->{'user_agent_name'} =~ m;(Mozilla|MSIE);i &&
# 		$bi->{'user_agent_version'} =~ m;^[4-9]; &&
# 		$bi->{'user_agent_os'} !~ m|OS/2|
#                 $bi->{'user_agent_name'} =~ m{(Mozilla)}i &&
# 		$bi->{'user_agent_version'} =~ m{^[5-9]}
               ) {
  		print " onsubmit='return show_map(\"$bbbike_html\");'";
  	    }
	    print ">\n";


            if ($show_mini_googlemap) {
	
	    } elsif ($show_mini_map) {
	    	print qq{<table><tr><td><a href="$ENV{'SCRIPT_NAME'}?center=&interactive=Show+map&imagetype=pdf-auto&coords=$string_rep&startname=}. CGI::escape($startname) . q{&zielname=} . CGI::escape($zielname) . qq{&geometry=240x180&draw=str&draw=sbahn&draw=ubahn&draw=wasser&draw=flaechen&draw=strname&draw=title&outputtarget=print&scope=" style="border=0;"><img  title="printable PDF map and route list" alt="" width="240" height="180" scrolling="no" border="0" src="$ENV{'SCRIPT_NAME'}?center=&interactive=Show+map&imagetype=png&coords=$string_rep&startname=}. CGI::escape($startname) . q{&zielname=} . CGI::escape($zielname) . qq{&geometry=240x180&draw=str&draw=sbahn&draw=wasser&draw=flaechen&draw=title&scope="></img></a></td><td>\n};

	    }

	    print "<input type=hidden name=center value=''>\n";
#XXX not yet	    print "<input type=hidden name='as_attachment' value=''>\n";
	    print qq{<input type=submit name=interactive value="@{[ M("Karte zeigen") ]}"> <font size=-1>(@{[ M("neues Fenster wird ge&ouml;ffnet") ]})</font>};
	    print " <label><input type=checkbox name=outputtarget value='print' " . ($default_print?"checked":"") . "> " . M("f&uuml;r Druck optimieren") . "</label>";
#XXX not yet	    print " <input type=checkbox name='cb_attachment'> als Download";
	    print "&nbsp;&nbsp; <span class=nobr>" . M("Ausgabe als") . ": <select name=imagetype " . ($bi->{'can_javascript'} ? "onchange='enable_size_details_buttons()'" : "") . ">\n";
	    print " <option " . $imagetype_checked->("googlemaps") . ">Google Maps\n" if $can_google_maps;
	    print " <option " . $imagetype_checked->("png") . ">PNG (" . M('Grafik') . ")\n" if $graphic_format eq 'png' && !$cannot_gif_png;
	    print " <option " . $imagetype_checked->("gif") . ">GIF\n" if ($graphic_format eq 'gif' || $can_gif) && !$cannot_gif_png;
	    print " <option " . $imagetype_checked->("jpeg") . ">JPEG\n" unless $cannot_jpeg;
	    print " <option " . $imagetype_checked->("wbmp") . ">WBMP\n" if $can_wbmp;
	    print " <option " . $imagetype_checked->("pdf-auto") . ">PDF\n" unless $cannot_pdf;
	    print " <option " . $imagetype_checked->("pdf") . ">PDF (" . M("L�ngsformat") . ")\n" unless $cannot_pdf;
	    print " <option " . $imagetype_checked->("pdf-landscape") . ">PDF (" . M("Querformat") . ")\n" unless $cannot_pdf;
	    print " <option " . $imagetype_checked->("svg") . ">SVG\n" unless $cannot_svg;
	    print " <option " . $imagetype_checked->("mapserver") . ">MapServer\n" if $can_mapserver;
	    #XXX print " <option " . $imagetype_checked->("googlemapsstatic") . ">Google Maps (static)\n" if 1;#XXXXXXXXXXXXXXXXXX
	    print " </select></span>\n";
	    print "<br>\n";

	    if ($sess) {
		$sess->{routestringrep} = $string_rep;
		$sess->{route} = \@out_route;
		print "<input type=hidden name=coordssession value=\"$sess->{_session_id}\">";
		my $sessdir = "/tmp/coordssession";
		mkdir $sessdir if !-d $sessdir;
		chmod 0777, $sessdir;
		if (open(SESS, ">> $sessdir/" . $sess->{_session_id})) {
		    require Data::Dumper;
		    print SESS Data::Dumper::Dumper
			({ date           => scalar(localtime),
			   time           => time,
			   routestringrep => $string_rep,
			   route          => \@out_route,
			   remote_ip      => $ENV{HTTP_X_FORWARDED_FOR} || $ENV{REMOTE_ADDR},
			   user_agent     => $ENV{HTTP_USER_AGENT},
			   prefs          => { map { ($_ => $q->param($_)) } grep { /^pref_/ } $q->param },
			 });
		    close SESS;
		}
		untie %$sess;
		if (defined $q->param('oldcs')) {
		    print $q->hidden(-name    => 'oldcs',
				     -default => $q->param('oldcs'));
		}
 	    } else {
		print "<input type=hidden name=coords value=\"$string_rep\">";
	    }

	    print "<input type=hidden name=startname value=\"" .
		($kfm_bug ? CGI::escape($startname) : $startname) . "\">";
	    print "<input type=hidden name=zielname value=\"" .
		($kfm_bug ? CGI::escape($zielname) : $zielname) . "\">";
	    if (@weather_res) {
		eval {
		    local $SIG{'__DIE__'};
		    require Met::Wind;
		    print "<input type=hidden name=windrichtung value=\"" .
			$weather_res[4] . "\">";
		    print "<input type=hidden name=windstaerke value=\"" .
		      Met::Wind::wind_velocity([$weather_res[5], 'm/s'],
					       'beaufort')
			  . "\">";
		};
	    }

            my @not_for;
	    push @not_for, "PDF" if !$cannot_pdf;
	    push @not_for, "SVG" if !$cannot_svg;
	    push @not_for, "Mapserver" if $can_mapserver;
	    print "<table><tr valign=top><td>$fontstr<b>" . M("Bildgr&ouml;&szlig;e") . ":</b>$fontend</td>\n";
	    foreach my $geom ("400x300", "640x480", "800x600", "1024x768", "1920x1200", "3200x2000") {
		print
		    qq{<td><label><input type="radio" name="geometry" value="$geom"},
		    ($geom eq $default_geometry ? " checked" : ""),
		    qq{>$fontstr $geom $fontend</label></td>\n};
	    }
	    if (@not_for) {
		print "<td valign=bottom><small>(" . M("nicht f�r") . ": " . join(", ", @not_for) . ")</small></td>";
	    }
	    print "</tr>\n";
	    print "<tr><td>$fontstr<b>" . M("Details") . ":</b>$fontend</td>";
	    my @draw_details =
		([M('Stra&szlig;en'),  'str',      $default_draw{"str"}],
		 [M('S-Bahn'),         'sbahn',    $default_draw{"sbahn"}],
		 [M('U-Bahn'),         'ubahn',    $default_draw{"ubahn"}],
		 [M('Gew&auml;sser'),  'wasser',   $default_draw{"wasser"}],
		 [M('Fl&auml;chen'),   'flaechen', $default_draw{"flaechen"}],
		 "-",
		 [M('Ampeln'),         'ampel',    $default_draw{"ampel"}],
		 );
	    if ($multiorte) {
		push @draw_details, [M('Orte'), 'ort', $default_draw{"ort"}];
	    }
	    push
		@draw_details,
		[M('Routendetails'),  'strname',$default_draw{"strname"}],
		[M('Titel'),          'title',  $default_draw{"title"}],
		[M('Alles'),          'all',    $default_draw{"all"}];
	    foreach my $draw (@draw_details) {
		my $text;
		if ($draw eq '-') {
		    print "</tr>\n<tr><td></td>";
		    next;
		}
		if ($draw->[0] eq 'S-Bahn' && !$bi->{'text_browser'}) {
		    $text = "<img src=\"$bbbike_images/sbahn.gif\" width=15 height=15 border=0 alt=S>-Bahn";
		} elsif ($draw->[0] eq 'U-Bahn' && !$bi->{'text_browser'}) {
		    $text = "<img src=\"$bbbike_images/ubahn.gif\" width=15 height=15 border=0 alt=U>-Bahn";
		} else {
		    $text = $draw->[0];
		}
		my $id = "draw_" . $draw->[1];
		print
		    qq{<td><span class=nobr><input id="$id" type="checkbox" name="draw" value="$draw->[1]"},
		    ($draw->[2] ? " checked" : ""),
		    ($draw->[1] eq 'all' ? qq{ onclick="all_checked()"} : ""),
		    qq{>$fontstr <label for="$id">$text</label> $fontend</span></td>\n};
	    }
	    print "</tr>\n";
##XXX Fix this without using $str
#  	    if ($str->{Scope} ne "cityXXX" || $multiorte) {
#  		# XXX scope instead???
#  		print "<input type=hidden name=draw value=umland>\n";
#  	    }
	    print "</table>\n";
	    print qq{<div class="graphfootnote">};
	    printf M(<<EOF), 15, 50, ($use_bbbikedraw_compress ? (100, 500) : (100, 3000));
Die Dateigr&ouml;&szlig;e der Grafik betr�gt je nach
Bildgr&ouml;&szlig;e, Bildformat und Detailreichtum %s bis %s kB. PDFs sind %s bis %s kB gro�.
EOF
            print window_open("$bbbike_html/legende.html", "BBBikeLegende",
			      "dependent,height=392,resizable" .
			      "screenX=400,screenY=80,scrollbars,width=440")
		. M("Legende") . ".</a>\n";



	    print "</div>";
	    print "</td></tr></table>\n" if $show_mini_map && !$show_mini_googlemap;
	}

	print "<input type=hidden name=scope value='" .
	    ($scope ne 'city' ? $scope : "") . "'>";
	print "</form>\n";
	print qq{</div>};

	if ($show_settings) {
	    #print "<hr>";
	    print qq{<div class="box">};
	    print "<form name=settings action=\"" . BBBikeCGIUtil::my_self_url($q) . "\">\n";
	    foreach my $key ($q->param) {
		next if $key =~ /^(pref_.*)$/;
		print $q->hidden(-name=>$key,
				 -default=>[$q->param($key)])
	    }
	    print "<b>" . M("Einstellungen") . ":</b>";
	    reset_html();
	    print "<p>\n";
	    settings_html();
	    print qq{<input onclick="show_spinning_wheel();" type=submit value="} . M("Route mit ge&auml;nderten Einstellungen") . qq{">\n} . &spinning_wheel;
	    print "</form>\n";
	    print qq{</div>};
	}

	if ($show_wayback) {
	    #print "<hr>";
	    print qq{<div class="box">};
	    print "<form name='search' action=\"$bbbike_script\">\n";
	    print "<input type=hidden name=startc value=\"$zielcoord\">";
	    print "<input type=hidden name=zielc value=\"$startcoord\">";
	    print "<input type=hidden name=startname value=\"$zielname\">";
	    print "<input type=hidden name=zielname value=\"$startname\">";
	    if (defined $viacoord && $viacoord ne '') {
		print "<input type=hidden name=viac value=\"$viacoord\">";
		print "<input type=hidden name=vianame value=\"$vianame\">";
	    }
	    for my $param ($q->param) {
		if ($param =~ /^pref_/) {
		    print "<input type=hidden name='$param' value=\"".
			$q->param($param) ."\">";
		}
	    }
	    print qq{<input type=submit value="} . M("R&uuml;ckweg") . qq{"><br>};
	    hidden_smallform();

	    my $button = sub {
		my($label, $query) = @_;
		my $url = $bbbike_script."?".$query;
		if ($bi->{'can_javascript'} >= 1.1) {
		    print "<input type=button value=\"$label\" " .
			"onclick=\"location.href='$url';\"> ";
		} else {
		    print "<a href=\"$url\">$label</a> ";
		}
	    };

	    if ($show_start_ziel_url) {
		my $qq = new CGI $q->query_string;
		foreach (qw(viac vianame)) {
		    $qq->delete($_);
		}
		foreach ($qq->param) {
		    if (/^pref_/) {
			$qq->delete($_);
		    }
		}

		print " " . M("Neue Anfrage") . ": ";

		my $qqq = new CGI $qq->query_string;
		foreach ($qqq->param) {
		    if (/^ziel/) {
			$qqq->delete($_);
		    }
		}
		$button->(M("Start beibehalten"), $qqq->query_string);

		$qqq = new CGI $qq->query_string;
		foreach ($qqq->param) {
		    if (/^start/) {
			$qqq->delete($_);
		    }
		}
		$button->(M("Ziel beibehalten"), $qqq->query_string);

		$button->(M("Start und Ziel neu eingeben"), "begin=1");

		$qqq = new CGI $qq->query_string;
		foreach (qw(c name plz)) {
		    $qqq->param("start$_", $qqq->param("ziel$_"));
		    $qqq->delete("ziel$_");
		}
		$button->(M("Ziel als Start"), $qqq->query_string);

		print "<br>";
	    }

	    print "</form>\n";
	    print qq{</div>\n};
	    print qq{</div>\n}; # id="bbbike_graphic">
	}

    }

    if ($enable_weather_forecast) {
	print qq{\n<div id="weather_forecast_html">\n};
	my @weather_coords = get_weather_coords();
   	if ($enable_current_weather && scalar(@weather_coords) > 0) {
		my $weather_lang = &my_lang($lang);
                my $cityname = $local_city_name; #$osm_data && $main::datadir =~ m,data-osm/(.+), ? $1 : 'bbbike';
		

		print M("Wetter f&uuml;r"), "\n";
		print qq{\n<span id="weather_forecast">\n};
print <<EOF;
<script type="text/javascript">
   display_current_weather( { lat:"$weather_coords[0]", lng:"$weather_coords[1]", lang:"$weather_lang", city:"$cityname", city_script:"$city_script"} );
</script>
EOF
		print qq{</span>\n};
        }
	print qq{<hr style="clear:left;">\n};
	print qq{</div>\n};
    } 

    elsif (@weather_res) {
	my(@res) = @weather_res;
	print "<center><table border=0 bgcolor=\"#d0d0d0\">\n";
	print "<tr><td colspan=2>${fontstr}<b>" . link_to_met() . M("Aktuelle Wetterdaten") . " ($res[0], $res[1])</a></b>$fontend</td>";
	print "<tr><td>${fontstr}" . M("Temperatur") . ":$fontend</td><td>${fontstr}$res[2] �C$fontend</td></tr>\n";
	my $wind_dir = $res[4];
	if ($lang eq 'en') {
	    $wind_dir =~ s{O$}{E}; # the only difference between de and en: east/ost
	}
	print "<tr><td>${fontstr}" . M("Windrichtung") . ":$fontend</td><td>${fontstr}$wind_dir$fontend&nbsp;</td></tr>\n";
	my($kmh, $windtext);
	eval { local $SIG{'__DIE__'};
	       require Met::Wind;
	       $kmh      = Met::Wind::wind_velocity([$res[5], 'm/s'],
						    'km/h');
	       if ($kmh >= 5) {
		   $kmh = sprintf("%d",$kmh); # keine Pseudogenauigkeit, bitte
	       }
	       $windtext = Met::Wind::wind_velocity([$res[5], 'm/s'],
						    $lang eq 'en' ? 'text_en' : 'text_de');
	   };
	print "<tr><td>${fontstr}" . M("Windgeschwindigkeit") . ":$fontend</td><td>${fontstr}";
	if (defined $kmh) {
	    print "$kmh km/h";
	} else {
	    print "$res[5] m/s";
	}
	if (defined $windtext) {
	    print " ($windtext)";
	}
	print "$fontend</td></tr>\n";
	print "</table></center>\n";
	print "<hr>\n";

    }

    footer();

  END_OF_HTML:
    print $q->end_html;
    exit(0);
}

sub user_agent_info {
    $bi = new BrowserInfo $q;
#    $bi->emulate("wap"); # XXX put your favourite emulation
    $bi->emulate_if_validator("mozilla");
    $fontstr = ($bi->{'can_css'} || $bi->{'text_browser'} ? '' : "<font face=\"$font\">");
    $fontend = ($bi->{'can_css'} || $bi->{'text_browser'} ? '' : "</font>");
    $bi->{'hfill'} = ($bi->is_browser_version("Mozilla", 5, 5.0999) ?
		      "class='hfill'" : "");
}

sub show_user_agent_info {
    print $bi->show_info('complete');
    print $bi->show_server_info;
}

sub coord_or_stadtplan_link {
    my($strname, $coords, $plz, $is_ort, $hnr, %args) = @_;
    if (defined $coords && $use_coord_link) {
	coord_link($strname, $coords, %args);
    } else {
	stadtplan_link($strname, $plz, $is_ort, $hnr);
    }
}

sub coord_link {
    my($strname, $coords, %args) = @_;
    my $coords_esc = CGI::escape($coords);
    my $strname_esc = CGI::escapeHTML($strname);
    if ($data_is_wgs84) {
	return $strname_esc; # XXX currently not useful with wgs84 data
    }
    my $jslink = $args{-jslink};
    my $out = qq{<a };

    # no links for OSM 
    return $strname_esc if $osm_data;

    if ($jslink) {
	$out .= qq{ class="ms" onclick="return ms($coords)"};
    }
    $out .= qq{ target="_blank" href="$mapserver_address_url?coords=$coords_esc">$strname_esc</a>};
    $out;
}

# XXX Is this link still active?
sub stadtplan_link {
    my($strname, $plz, $is_ort, $hnr) = @_;
    return $strname if $is_ort;
    my $stadtplan_url = "http://www.berlin.de/stadtplan/explorer";
    my @aref;
    foreach my $s (split(m|/|, $strname)) {
	# Text in Klammern entfernen:
	(my $str_plain = $s) =~ s/\s+\(.*\)$//;
	$s = CGI::escapeHTML($s);
	$str_plain = CGI::escape($str_plain);
	push @aref,
	    "<a target=\"_blank\" href=\"$stadtplan_url?adr_street=$str_plain".
		(defined $plz ? "&amp;adr_zip=$plz" : "") .
		    (defined $hnr ? "&amp;adr_house=$hnr" : "") .
			"\">$s</a>";
    }
    join("/", @aref);
}

sub string_kuerzen {
    my($strname, $len) = @_;
    if (length($strname) <= $len) {
	$strname;
    } else {
	substr($strname, 0, $len-3)."...";
    }
}

sub overview_map {
    if (!defined $overview_map) {
	require BBBikeDraw;
	$overview_map = BBBikeDraw->new
	    (ImageType => 'dummy',
	     Geometry => ($xgridwidth*$xgridnr) . "x" . ($ygridwidth*$ygridnr),
	     Lang => $lang,
	    );
	$overview_map->set_dimension($x0, $x0 + $xm*$xgridnr*$xgridwidth,
				     $y0 - $ym*$ygridnr*$ygridwidth, $y0,
				    );
	$overview_map->create_transpose;
    }
    $overview_map;
}

sub start_mapserver {
    require BBBikeMapserver;
    my $ms = BBBikeMapserver->new_from_cgi($q, -tmpdir => $tmp_dir);
    $ms->read_config("$config_master.config");
    $ms->set_coords("8593,12243"); # Brandenburger Tor
    $ms->start_mapserver(-route => 0,
			 -bbbikeurl => $bbbike_url,
			 -bbbikemail => $BBBike::EMAIL,
			);
    return;
}

sub draw_route {
    my(%args) = @_;
    my @cache = (exists $args{-cache} ? @{ $args{-cache} } : @no_cache);

    my $draw;
    my $route; # optional Route object

    my $session_is_expired;
    if (defined $q->param('coordssession')) {
	if (my $sess = tie_session($q->param('coordssession'))) {
	    # Note: the session data specified by coordssession could
	    # already be deleted. In this case all session data would be
	    # empty, especially the coords. The error will happen later,
	    # in BBBikeDraw.
	    $q->param(coords => $sess->{routestringrep});
	    $route = $sess->{route};
	} else {
	    $session_is_expired = 1;
	}
    }

    if (defined $q->param('oldcs') &&
	(my $oldsess = tie_session($q->param('oldcs')))) {
	$q->param(oldcoords => $oldsess->{routestringrep});
    }

    my $cookie;
    %persistent = get_cookie();
    if (defined $q->param("interactive")) {
	foreach my $key (qw/outputtarget imagetype geometry/) {
	    $persistent{$key} = $q->param($key);
	}
	# draw is an array;
	my $i = 0;
	foreach ($q->param("draw")) {
	    $persistent{"draw$i"} = $_;
	    $i++;
	}
	$cookie = set_cookie({ %persistent });
    }

    # XXX move to BBBikeDraw::Mapserver!
    # XXX init() does first part, flush() does start_mapserver
    # XXX and set: sub module_handles_all_cgi { 1 }
    if (defined $q->param('imagetype') &&
	$q->param('imagetype') =~ /^mapserver/) {
	require BBBikeMapserver;
	my $ms = BBBikeMapserver->new_from_cgi($q, -tmpdir => $tmp_dir);
	$ms->read_config("$config_master.config");
	my $layers;
	if (defined $q->param("layer")) { # Mapserver styled parameters
	    $layers = [ "route", $q->param("layer") ];
	} elsif (grep { $_ eq 'all' } $q->param("draw")) {
	    $layers = [ $ms->all_layers ];
	} else {
	    $layers = [ "route",
			map {
			    my $out = +{
					str => "str", # always drawn
					ubahn => "bahn",
					sbahn => "bahn",
					wasser => ["gewaesser", "faehren"],
					flaechen => "flaechen",
					ampel => "ampeln",
					fragezeichen => "fragezeichen",
					ort => "orte",
					grenzen => "grenzen",
				       }->{$_};
			    if (!defined $out) {
				();
			    } elsif (ref $out eq 'ARRAY') {
				@$out;
			    } else {
				$out;
			    }
			} $q->param('draw')
		      ];
	}
	$layers = [ grep { $_ ne "route" } @$layers ]
	    if !$ms->has_coords;

	my $scope = "all,narrowest";
	my $has_center = (defined $q->param("center") && $q->param("center") ne "");
	if ($has_center) {
	    my $width  = $q->param("width");
	    my $height = $q->param("height");
	    if (!outside_berlin_and_potsdam($q->param("center"))) {
		$q->param("width",  1000) if !defined $width  || $width eq '';
		$q->param("height", 1000) if !defined $height || $height eq '';
	    } else {
		$q->param("width",  5000) if !defined $width  || $width eq '';
		$q->param("height", 5000) if !defined $height || $height eq '';
	    }
	}

	$ms->start_mapserver
	    (-bbbikeurl => $bbbike_url,
	     -bbbikemail => $BBBike::EMAIL,
	     -scope => $scope,
	     -externshape => 1,
	     -layers => $layers,
	     -cookie => $cookie,
	     (defined $q->param("mapext")
	      ? (-mapext => $q->param("mapext"))
	      : ()
	     ),
	     ($has_center
	      ? (-center => $q->param("center"),
		 -markerpoint => $q->param("center"),
		)
	      : ()
	     ),
	     defined $q->param("width") ? (-width => $q->param("width")) : (),
	     defined $q->param("height") ? (-height => $q->param("height")) : (),
	     defined $q->param("padx") ? (-padx => $q->param("padx")) : (),
	     defined $q->param("pady") ? (-pady => $q->param("pady")) : (),
	    );
	return;
    }

    my %bbbikedraw_args;

    if (defined $q->param('imagetype')) {
	if ($q->param('imagetype') eq 'googlemaps') {
	    $bbbikedraw_args{Module} = "BBBikeGoogleMaps";
	    $bbbikedraw_args{BBBikeRoute} = $route;
	} elsif ($q->param('imagetype') eq 'googlemapsstatic') {
	    $bbbikedraw_args{Module} = "GoogleMapsStatic";
	    $q->param('imagetype', 'png'); # XXX hacky...
	} elsif ($q->param('imagetype') =~ m{^(gif|png)$}) {
	    # XXX Outline=1 looks good with smale scales, but very bad
	    # with large scales (try Friedrichshain -> Potsdam). Maybe
	    # I should introduce something like Outline=>best?
	    # $bbbikedraw_args{Outline} = 1;
	}
    }

    my @header_args = @cache;
    if ($cookie) { push @header_args, "-cookie", $cookie }

    # write content header for pdf as early as possible, because
    # output is already written before calling flush
    if (defined $q->param('imagetype') &&
	$q->param('imagetype') =~ /^pdf/) {
	my($startname, $zielname);
	if ($route) {
	    $startname = Strasse::strip_bezirk($route->[0]->{Strname});
	    $zielname  = Strasse::strip_bezirk($route->[-1]->{Strname});
	}
	my $filename = ($startname && $zielname ? filename_from_route($startname, $zielname, "bbbike") : "bbbike");
	http_header
	    (-type => "application/pdf",
	     -expires => '+6d',
	     @header_args,
	     -Content_Disposition => "inline; filename=$filename.pdf",
	    );
	if ($q->param('imagetype') =~ /^pdf-(.*)/) {
	    $q->param('geometry', $1);
	    $q->param('imagetype', 'pdf');
	}
    }

    if (defined $use_module && !$bbbikedraw_args{Module}) {
	$bbbikedraw_args{Module} = $use_module;
    }

    if ($use_bbbikedraw_compress) {
	$bbbikedraw_args{Compress} = 1;
    }

    eval {
	local $SIG{'__DIE__'};
	require BBBikeDraw;
	BBBikeDraw->VERSION(2.26);

	# Auch hier sieht dunkler besser aus:
	$draw = BBBikeDraw->new_from_cgi($q,
					 MakeNet => \&make_netz,
					 Bg => '#c5c5c5',
					 Lang => $lang,
					 Geo => get_geography_object(),
					 %bbbikedraw_args,
	     				'lang' => $lang,
					);
	die $@ if !$draw;
    };
    if ($@) {
	my $err = "Fehler in BBBikeDraw: $@";
	http_header(-type => 'text/html',
		    @no_cache,
		   );
	print "<body>$err</body>";
	die $err;
    }

    if (!$header_written && !$draw->module_handles_all_cgi) {
	http_header
	    (-type => $draw->mimetype,
		-expires => '+6d',
	     -Content_Disposition => "inline; filename=bbbike.".$draw->suffix,
	    );
    }

    eval {
	$draw->pre_draw
	    if $draw->can("pre_draw");
	$draw->draw_map    if $draw->can("draw_map");
	$draw->draw_wind   if $draw->can("draw_wind");
	$draw->draw_route  if $draw->can("draw_route");
	$draw->add_route_descr(-net => make_netz(),
			       -lang => $lang,
                          -Url => $q->url(-full=>0, -absolute=>1, -query=>0), 
                          -City_local => $local_city_name, 
                          -City_en => $en_city_name)
	    if $draw->can("add_route_descr");
	$draw->flush;
    };
    if ($@) {
	if ($session_is_expired) {
	    die "Cannot draw image because session is expired";
	} else {
	    die $@;
	}
    }
}

sub create_map {
    my(%args) = @_;

    my($part, @dim);
    my($x, $y);
    if (exists $args{'-x'} and exists $args{'-y'}) {
	($x, $y) = ($args{'-x'}, $args{'-y'});
	$part = sprintf("%02d-%02d", $x, $y);
	$part .= $berlin_small_suffix;
	@dim  = xy_to_dim($x, $y);
    } else {
	die "No x/y set";
    }

    if (!@dim) { die "No dim set" }

    my($img_url, $img_file);
    my $map_file = "$mapdir_fs/berlin_map_$part.map";

    my $create = 1;
    my $ext;
    my $_create_imagemap =
	exists $args{-imagemap} ? $args{-imagemap} : $create_imagemap;

    my $set_img_name = sub {
	$img_file = "$mapdir_fs/berlin_map_$part.$ext";
	$img_url  = "$mapdir_url/berlin_map_$part.$ext";
    };

    if (!$args{'-force'}) {
	my $str = get_streets();
	foreach (qw(png gif)) {
	    $ext = $_;
#XXX	    next if $ext eq 'png' and !$bi->{'can_png'};
	    $set_img_name->();
	    if (-s $img_file && (!$use_imagemap || -s $map_file)) {
		my(@img_file_stat)   = stat($img_file);
		if (defined $img_file_stat[9]) {
		    my(@map_file_stat)   = stat($img_file);
		    if (defined $map_file_stat[9]) {
			my(@bbbike_cgi_stat) = stat($0); # use always the "main" lang version
			for my $str_file ($str->dependent_files) {
			    my(@strassen_stat)   = stat($str_file);
			    my $to_create_time =
				min($img_file_stat[9], $map_file_stat[9]);
			    my $check_time =
				($check_map_time == 0 ? 0 :
				 ($check_map_time == 1 ? $strassen_stat[9] :
				  max($bbbike_cgi_stat[9], $strassen_stat[9])
				 ));
			    $create = ($to_create_time < $check_time);
			    if ($debug) {
				warn __LINE__ . ": time_exist=$to_create_time, " .
				    "check_time=$check_time, create=$create\n";
			    }
			    last if $create;
			}
		    } elsif ($debug) {
			warn __LINE__ . ": Can't stat $map_file: $!\n";
		    }
		} elsif ($debug) {
		    warn __LINE__ . ": Can't stat $img_file: $!\n";
		}
		last if (!$create);
	    } elsif ($debug) {
		warn __LINE__ .  ": $img_file or $img_url empty\n";
	    }
	}
    }

    if ($create || !-r $img_file || -z $img_file || !-r $map_file) {
	eval {
	    local $SIG{'__DIE__'};

	    $ext = $q->param('imagetype') || $graphic_format;
	    if ($ext eq 'gif' && !$can_gif) {
		$ext = 'png';
	    }
	    $set_img_name->();

	    require BBBikeDraw;
	    open(IMG, "> $img_file~") or do {
		print STDERR "Error code: $!\n";
		confess "Fehler: Die Karte $img_file~ konnte nicht erstellt werden.<br>\n";
	    };
	    chmod 0644, "$img_file~";
	    open(MAP, "> $map_file~") or do {
		print STDERR "Error code: $!\n";
		confess "Fehler: Die Map $map_file~ konnte nicht erstellt werden.<br>\n";
	    };
	    chmod 0644, "$map_file~";
	    $q->param('geometry', $detailwidth."x".$detailheight);
	    $q->param('draw', 'str', 'ubahn', 'sbahn', 'wasser', 'flaechen', 'ort', 'berlin');
#XXX del?	    $q->param('drawwidth', 1);
	    # XXX Argument sollte �bergeben werden (wird sowieso noch nicht
	    # verwendet, bis auf �berpr�fung des boolschen Wertes)
	    $q->param('strlabel', 'str:HH,H');#XXX if $args{-strlabel};
	    $q->param('imagetype', $ext);
	    if ($args{-module}) {
		$q->param('module', $args{-module});
	    } elsif ($detailmap_module) {
		$q->param('module', $detailmap_module);
	    }
	    $q->param("scope", "region");
	    # #c5c5c5 ist ein guter Kompromiss zwischen
	    # dem Default (#b4b4b4, schmale Wasserstra�en kaum zu erkennen)
	    # und #e1e1e1 (zu heller Hintergrund, Nebenstra�en auf einem
	    # LCD-Monitor kaum zu erkennen).
	    my $draw = BBBikeDraw->new_from_cgi($q,
						Fh => \*IMG,
						Bg => '#c5c5c5',
						Lang => $lang,
						Geo => get_geography_object(),
					       );
	    $draw->set_dimension(@dim);
	    $draw->create_transpose();
	    print "Create $img_file~...\n" if $args{-logging};
	    $draw->draw_map();
	    if ($_create_imagemap) {
		$draw->make_imagemap(\*MAP);
	    }
	    $draw->flush();
	    $q->delete('draw');
	    $q->delete('geometry');
	    close MAP;
	    close IMG;

	    if (-z "$img_file~") {
		confess "Fehler: die erzeugte Datei $img_file~ ist 0 Bytes gro�.\n";
	    }
	    rename "$map_file~", $map_file
		or confess "Fehler: Die Datei $map_file~ konnte nicht umbenannt werden ($!).<br>\n";
	    rename "$img_file~", $img_file
		or confess "Fehler: Die Datei $img_file~ konnte nicht umbenannt werden ($!).<br>\n";

	};
	die __LINE__ . ": Warnung: $@<br>\n" if $@;
    }

    (imgurl  => $img_url,
     mapfile => $map_file,
    );
}

sub draw_map {
    my(%args) = @_;
    http_header(@weak_cache);

    my %res = create_map(%args);
    my($img_url, $map_file) = @res{qw(imgurl mapfile)};
#require bbbikecgi_experiments;exit drawmap_with_open_layers(%args);#XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
    my($x, $y) = ($args{'-x'}, $args{'-y'});

    my $type = $q->param('type') || '';

    my $script = <<EOF;
function jump_to_map() {
    window.location.hash = "mapbegin";
}
EOF

    # XXX jump_to_map macht Probleme mit Opera und ist nervig mit anderen
    # Browsern.
    header(#-script => $script,
	   #-onLoad => 'jump_to_map()'
	   -from => 'map',
	  );
    if ($lang eq 'en') {
	print "Choose <b><a name='mapbegin'>" . M(ucfirst($type)) . "</a></b>:<br>\n";
    } else {
	print "<b><a name='mapbegin'>" . ucfirst($type) . "-Kreuzung</a></b> ausw&auml;hlen:<br>\n";
    }
    print "<form action=\"$bbbike_script\">\n";

    foreach ($q->param) {
	unless ($_ eq 'type') {
	    print "<input type=hidden name=$_ value=\""
		. $q->param($_) . "\">\n";
	}
    }
    print "<input type=hidden name=detailmapx value=\"$x\">\n";
    print "<input type=hidden name=detailmapy value=\"$y\">\n";
    print "<input type=hidden name=type value=\"$type\">\n";
    print "<center><table class=\"detailmap\">";

    # obere Zeile
    if ($y > 0) {
	print "<tr><td align=right>";
	if ($x > 0) {
	    print qq{<input type=submit name=movemap_nw value="} . M("Nordwest") . qq{">};
	}
	print qq{</td><td align=center><input type=submit name=movemap_n value="} . M("Nord") . qq{"></td>\n};
	if ($x < $xgridnr-1) {
	    print qq{<td align=left><input type=submit name=movemap_ne value="} . M("Nordost") . qq{"></td>};
	}
	print "</tr>\n";
    }

    # mittlere Zeile
    print "<tr><td align=right>";
    if ($x > 0) {
	print qq{<input type=submit name=movemap_w value="} . M("West") . qq{">};
    }
    print
	"</td><td><input type=image title='' name=detailmap ",
	"src=\"$img_url\" alt=\"\" border=0 ",
	($use_imagemap ? "usemap=\"#map\" " : ""),
	"align=middle width=$detailwidth height=$detailheight>",
	"</td>\n";
    if ($x < $xgridnr-1) {
	print qq{<td align=left><input type=submit name=movemap_e value="} . M("Ost") . qq{"></td>};
    }
    print "</tr>\n";

    # untere Zeile
    if ($y < $ygridnr-1) {
	print "<tr><td align=right>";
	if ($x > 0) {
	    print qq{<input type=submit name=movemap_sw value="} . M("S�dwest") . qq{">};
	}
	print qq{</td><td align=center><input type=submit name=movemap_s value="} . M("S�d") . qq{"></td>};
	if ($x < $xgridnr-1) {
	    print qq{<td align=left><input type=submit name=movemap_se value="} . M("S�dost") . qq{"></td>};
	}
	print "</tr>\n";
    }
    print "</table>";
    #print "<input type=submit name=Dummy value=\"&lt;&lt; Zur&uuml;ck\">";
    print qq{<input type=button value="&lt;&lt; } . M("Zur�ck") . qq{" onclick="history.back(1);">};
    print "</center>";
    print <<EOF;
<script type="text/javascript">
<!--
function s(text) {
  self.status=text;
  return true;
}
// -->
</script>
EOF
    if ($use_imagemap) {
	open(MAP, $map_file)
	    or confess "Fehler: Die Map $map_file konnte nicht geladen werden.\n<br>";
	while(<MAP>) {
	    print $_;
	}
	close MAP;
    }
    footer();
    print "</form>\n";
    print $q->end_html;
    exit(0);
}

# Stellt f�r den x/y-Index der berlin_small-Karte die zugeh�rige
# Dimension f�r BBBikeDraw fest.
sub xy_to_dim {
    my($x, $y) = @_;
    ($x*$xgridwidth*$xm+$x0, ($x+1)*$xgridwidth*$xm+$x0,
     $y0-($y+1)*$ygridwidth*$ym, $y0-$y*$ygridwidth*$ym,
    );
}

# F�r einen Punkt aus der Detailmap wird die am n�chsten liegende
# Kreuzung festgestellt. Zur�ckgegeben wird die Koordinate der
# Kreuzung "(x,y)".
sub detailmap_to_coord {
    my($index_x, $index_y, $map_x, $map_y) = @_;
    my($x, $y) =
      ($index_x*$xgridwidth*$xm+$x0 + ($map_x*$xm*$xgridwidth)/$detailwidth,
       $y0-$index_y*$ygridwidth*$ym - ($map_y*$ym*$ygridwidth)/$detailheight,
      );
    if (outside_berlin("$x,$y")) { # XXX should this be done generally in get_nearest_crossing_coords?
	upgrade_scope("region");
    }
    new_kreuzungen(); # XXX needed for munich, here too?
    get_nearest_crossing_coords($x,$y);
}

sub get_cyclepath_streets {
    my($scope) = shift || $q->param("scope") || "city";
    if ($scope eq 'city') {
	Strassen->new("radwege_exact");
    } else {
	MultiStrassen->new("radwege_exact", "comments_cyclepath");
    }
}

sub get_streets {
    my($scope) = shift || $q->param("scope") || "city";
    $scope =~ s/^all,//;
    if ($g_str && $g_str->{Scope} eq $scope) {
	return $g_str;
    }
    my @f = ("strassen",
	     ($scope =~ /region/ ? "landstrassen" : ()),
	     ($scope eq 'wideregion' ? "landstrassen2" : ()),
	    );

    if ($q->param("addnet")) {
	for my $addnet ($q->param("addnet")) {
	    if ($addnet =~ /^(?:  )$/x) { # no addnet support for now
		push @f, $addnet;
	    }
	}
    }

    # XXX do not use Strassen::StrassenNetz::add_faehre, so better
    # display in route list is possible
    if (defined $q->param('pref_ferry') && $q->param('pref_ferry') eq 'use') {
	push @f, 'faehren';
    }

    # Should be last:
    if (defined $q->param("pref_fragezeichen") && $q->param("pref_fragezeichen") eq 'yes') {
	push @f, "fragezeichen";
    }

    my $use_cooked_street_data = $use_cooked_street_data;
    while(1) {
	my @f = @f;
	if ($use_cooked_street_data) {
	    @f = map {
		# Note: no "cooked" version for faehren available
		$_ eq "faehren" ? $_ : "$_-cooked"
	    } @f;
	}
	eval {
	    if (@f == 1) {
		$g_str = new Strassen $f[0];
	    } else {
		$g_str = new MultiStrassen @f;
	    }
	};
	if ($@) {
	    if ($use_cooked_street_data) {
		warn qq{Maybe the "cooked" version for <@f> is missing? Try again the normal version...};
		$use_cooked_street_data = 0;
		next;
	    } else {
		die $@;
	    }
	}
	last;
    }
    $g_str->{Scope} = $scope;

    if (!$use_cooked_street_data) {
	my $i_s;
	eval { $i_s = new Strassen "inaccessible_strassen" };
	if ($i_s) {
	    $g_str = $g_str->new_with_removed_points($i_s);
	    $g_str->{Scope} = $scope;
	}
    }

    $crossings = {};

    $g_str;
}

sub get_streets_rebuild_dependents {
    $g_str = get_streets();

    if ($crossings) {
	undef $crossings;
	all_crossings();
    }
    if ($kr) {
	undef $kr;
	new_kreuzungen();
    }
    if ($net) {
	undef $net;
	make_netz();
    }

    if ($use_umland || $use_umland_jwd) {
	get_orte();
    }

    $g_str;
}

sub get_orte {
    return $multiorte if $multiorte;

    # Orte
    my @o;
    $orte = new Strassen "orte" unless defined $orte;
    push @o, $orte;
    if ($use_umland_jwd) {
	$orte2 = new Strassen "orte2" unless defined $orte2;
	push @o, $orte2;
    }
    $multiorte = new MultiStrassen @o;
    $multiorte;
}

sub all_crossings {
    if (scalar keys %$crossings == 0) {
	my $str = get_streets();
	$crossings = $str->all_crossings(RetType => 'hash',
					 UseCache => 1);
    }
}

sub new_kreuzungen {
    if (!$kr) {
	all_crossings();
	my $str = get_streets();
	$kr = new Kreuzungen(Hash => $crossings,
			     Strassen => $str);
	$kr->make_grid(UseCache => 1);
    }
    $kr;
}

sub new_trafficlights {
    if (!$ampeln) {
	eval {
	    my $lsa = new Strassen "ampeln";
	    $lsa->init;
	    while(1){
		my $ret = $lsa->next;
		last if !@{$ret->[1]};
		my($xy) = $ret->[1][0];
		$ampeln->{$xy}++;
	    }
	};
	warn $@ if $@;
    }
    $ampeln;
}

# XXX scope => "all" is wrongly implemented
# XXX but it is not yet used at all
sub init_plz {
    my(%args) = @_;
    my $scope = $args{scope} || "all";
    return $cached_plz{$scope} if $cached_plz{$scope};

    if (1) { # XXX introduce flag? (i.e. for other cities!!!)
	my $other_place_coords_data;
	if ($scope eq 'all' || $scope =~ $outer_berlin_qr) {
	    (my $file_scope = $scope) =~ s{[^A-Za-z]}{_}g;
	    $other_place_coords_data = "$tmp_dir/" . $Strassen::Util::cacheprefix . "_" . $< . "_" . $file_scope . ".coords.data";
	    my $landstr0 = Strassen->new("landstrassen", NoRead => 1);
	    if (!-r $other_place_coords_data ||
		(-r $other_place_coords_data && -M $other_place_coords_data > -M $landstr0->file)
	       ) {
		if (open(OFH, "> $other_place_coords_data")) {
		    my $landstr = Strassen->new("landstrassen");
		    $landstr->init;
		    while(1) {
			my $ret = $landstr->next;
			last if !@{$ret->[1]};
			my $name = $ret->[0];
			next if $name !~ m{(.*)\s+\(($scope(?:-[^\)]+)?)\)};
			print OFH join("|", $1, $2, "", $ret->[1][0]), "\n";
		    }
		    close OFH;
		} else {
		    warn "Cannot write to $other_place_coords_data: $!";
		}
	    }
	}
	my @files;
	if ($scope eq 'all' || $scope eq 'Berlin/Potsdam') {
	    for my $def (@b_and_p_plz_multi_files) {
		my($name, $type) = @$def;
		if ($name eq 'sehenswuerdigkeit_bp') {
		    my $sehenswuerdigkeit_bp_file = "$tmp_dir/" . $Strassen::Util::cacheprefix . "_" . $< . "_" . "sehenswuerdigkeit_bp";
		    my $sehenswuerdigkeit = Strassen->new("sehenswuerdigkeit", NoRead => 1);
		    if (!(-r $sehenswuerdigkeit_bp_file &&
			  -M $sehenswuerdigkeit_bp_file < -M $sehenswuerdigkeit->file)) {
			my $new_s = Strassen->new;
			$sehenswuerdigkeit->read_data(UseLocalDirectives => 1);
			$sehenswuerdigkeit->init;
			while(1) {
			    my $r = $sehenswuerdigkeit->next;
			    last if !@{ $r->[Strassen::COORDS()] };
			    my $dir = $sehenswuerdigkeit->get_directives;
			    my $section = $dir->{"section"};
			    next if $section && $section->[0] !~ m{^(Berlin|Potsdam)$};
			    my $aliases = $dir->{"alias"};
			    if ($aliases) {
				for my $alias (@$aliases) {
				    $new_s->push([$alias, $r->[Strassen::COORDS()], $r->[Strassen::CAT()]]);
				}
			    }
			    $new_s->push($r);
			}
			$new_s->write("$sehenswuerdigkeit_bp_file~");
			rename "$sehenswuerdigkeit_bp_file~", $sehenswuerdigkeit_bp_file
			    or die "Can't rename to $sehenswuerdigkeit_bp_file: $!";
		    }
		    push @files, Strassen->new($sehenswuerdigkeit_bp_file);
		} elsif ($type eq 'Strassen') {
		    push @files, Strassen->new($name);
		} else {
		    push @files, $name;
		}
	    }
	}
	if (($scope eq 'all' || $scope =~ $outer_berlin_qr) &&
	    $other_place_coords_data && -r $other_place_coords_data) {
	    push @files, $other_place_coords_data;
	}
	if (@files) {
	    require PLZ::Multi;
	    $cached_plz{$scope} = PLZ::Multi->new(@files, -cache => 1, -addindex => 1, -preferfirst => 1);
	} else {
	    warn "No input files";
	    return;
	}
    } else {
	require PLZ;
	PLZ->VERSION(1.26);
	$cached_plz{$scope} = new PLZ;
    }
    $cached_plz{$scope};
}

sub load_temp_blockings {
    my(%args) = @_;
    my $test_mode = $args{-test};
    if (@temp_blocking && ($temp_blocking_epoch + 3600 < time || $test_mode)) {
	warn "Invalidate cached temp_blocking...\n" if $debug;
	@temp_blocking = ();
	$temp_blocking_epoch = undef;
    }

    if (!@temp_blocking && defined $bbbike_temp_blockings_file) {
	@temp_blocking = ();
	my $use_file;
	if (!$test_mode &&
	    defined $bbbike_temp_blockings_optimized_file &&
	    -r $bbbike_temp_blockings_optimized_file &&
	    -M $bbbike_temp_blockings_optimized_file < -M $bbbike_temp_blockings_file) {
	    $use_file = $bbbike_temp_blockings_optimized_file;
	} else {
	    $use_file = $bbbike_temp_blockings_file;
	}
	do $use_file;
	if (!@temp_blocking) {
	    warn "Could not load $use_file or file is empty: $@";
	} else {
	    $temp_blocking_epoch = time;
	}
    }
}

# The combination of Strassen->nearest_point and crossing_text may
# lead to some unexpected results. Take for instance T�binger Str.
# (approx. 5426,8148): nearest_point will return a point at
# Bundesallee (5360,8197). crossing_text will calculate the nearest
# crossing from this point which would be Bundesallee/Durlacher Str.
# But the nearest crossing from 5426,8148 is actually
# Bundesallee/Wexstr.!
sub crossing_text {
    my $c = shift;
    warn "crossing_text: $c, ", join " ", caller(), "\n" if $debug >= 2;

    all_crossings();
    if (!exists $crossings->{$c}) {
	new_kreuzungen();
	my(@nearest) = $kr->nearest_coord($c);
	if (!@nearest || !exists $crossings->{$nearest[0]}) {
	    # Should not happen, but try to be smart
	    my $crossing_text = eval {
		my($px,$py) = convert_data_to_wgs84(split /,/, $c);
		"N $py / O $px";
	    };
	    if ($@) {
		warn $@;
		$crossing_text = "???";
	    }
	    return $crossing_text;
	} else {
	    $c = $nearest[0];
	}
    }
    nice_crossing_name(@{ $crossings->{$c} });
}

# Gibt den Stra�ennamen f�r type=start/via/ziel zur�ck --- entweder
# aus startname oder abgeleitet aus startc
sub name_from_cgi {
    my($q, $type) = @_;
    if (defined $q->param($type . "name") and
	$q->param($type . "name") ne '') {
	$q->param($type . "name");
    } elsif (defined $q->param($type . "c")) {
	crossing_text($q->param($type . "c"));
    } else {
	undef;
    }
}

sub make_time {
    my($h_dec) = @_;
    my $h = int($h_dec);
    my $m = int(($h_dec-$h)*60);
    sprintf "%d:%02d", $h, $m;
}

sub get_next_scopes {
    my $scope = shift;
    if (!defined $scope || $scope eq "" || $scope =~  /\bcity\b/) {
	return (qw(region wideregion));
    } elsif ($scope =~ /\bregion\b/) {
	return (qw(wideregion));
    } else {
	return ();
    }
}

# Increment scope and return the new scope, or undef if the largest scope
# is already used. Call get_streets_rebuild_dependents after.
sub increment_scope {
    my $scope = $q->param("scope");
    if ($scope eq "" || $scope eq "city") {
	$scope = "region";
    } elsif ($scope eq "region") {
	$scope = "wideregion";
    } else {
	return undef;
    }
    $q->param("scope", $scope);
    $scope;
}

# Should be called before a get_streets() call
sub upgrade_scope {
    my($target_scope) = @_;
    my $scope = $q->param("scope") || "city";
    for my $check_scope (qw(wideregion region)) {
	return if ($scope eq $check_scope);
	if ($target_scope eq $check_scope) {
	    $q->param("scope", $check_scope);
	    return;
	}
    }
}

# NOTE: this is only valid for city=b_de. Other cities should use other
# border files (XXX -> Geography::....)
sub adjust_scope_for_search {
    return if $osm_data;

    my($coordsref) = @_;
    return if $q->param("scope") && $q->param("scope") ne 'city'; # already bigger scope

    if (!eval { require VectorUtil; 1 }) {
	warn $@;
	return;
    }

    my $city_border = eval { MultiStrassen->new("berlin", "upgrade_scope_hint") };
    if (!$city_border) {
	warn "Cannot get border file (berlin and/or upgrade_scope_hint)";
	return;
    }

    my @border_polylines;
    $city_border->init;
    while() {
	my $r = $city_border->next;
	last if !@{ $r->[Strassen::COORDS()] };
	push @border_polylines, $r->[Strassen::COORDS()];
    }

    for my $i (1 .. $#$coordsref) {
	my($xfrom,$yfrom,$xto,$yto) = (split(/,/,$coordsref->[$i-1]),
				       split(/,/,$coordsref->[$i]));
	for my $border_polyline (@border_polylines) {
	    for my $pt_i (1..$#$border_polyline) {
		my($x1,$y1,$x2,$y2) = (split(/,/,$border_polyline->[$pt_i-1]),
				       split(/,/,$border_polyline->[$pt_i]));
		if (VectorUtil::intersect_lines($xfrom,$yfrom,$xto,$yto,
						$x1,$y1,$x2,$y2)) {
		    upgrade_scope("region");
		    return;
		}
	    }
	}
    }
}

# falls die Koordinaten nicht exakt existieren, wird der n�chste Punkt
# gesucht und gesetzt
sub fix_coords {
    my(@coords) = @_;

    foreach my $varref (\ (@coords)) { # the space is for emacs
	next if (!defined $$varref or
		 $$varref eq ''    or
		 exists $net->{Net}{$$varref});
	if (!defined $kr) {
	    new_kreuzungen();
	}

    TRY: {
	    if ($use_exact_streetchooser) {
		my $str = get_streets();
		my $ret = $str->nearest_point($$varref, FullReturn => 1);
		if ($ret && $ret->{Dist} < 50) {
		    $$varref = $ret->{Coord};
		    last TRY;
		} else {
		    # Try to enlarge search region
		    my @scopes = get_next_scopes($q->param("scope"));
		    if (@scopes) {
			for my $scope (@scopes) {
			    $q->param("scope", $scope); # XXX "all," gets lost
			    my $str = get_streets_rebuild_dependents();
			    my $ret = $str->nearest_point($$varref, FullReturn => 1);
			    if ($ret) {
				$$varref = $ret->{Coord};
				last TRY;
			    }
			}
		    }
		}
	    }

	    # Fallback to old, non-exact chooser
	    #
	    # This is for now buggy, because we should really use
	    # AllPoints in Kreuzungen->new and all_crossings.
	    #
	    my(@nearest) = $kr->nearest_coord($$varref, IncludeDistance => 1);
	    if (@nearest && $nearest[0]->[1] < 50) {
		$$varref = $nearest[0]->[0];
	    } else {
		# Try to enlarge search region
		$q->param("scope", "city") if !$q->param("scope");
		my @scopes = get_next_scopes($q->param("scope"));
		if (@scopes) {
		    for my $scope (@scopes) {
			$q->param("scope", $scope); # XXX "all," gets lost
			get_streets_rebuild_dependents();
			@nearest = $kr->nearest_loop_coord($$varref);
			if (@nearest) {
			    $$varref = $nearest[0];
			    last TRY;
			}
		    }
		} else {
		    @nearest = $kr->nearest_loop_coord($$varref);
		    if (@nearest) {
			$$varref = $nearest[0];
			last TRY;
		    }
		}
	    }

	    warn "Can't find nearest for $$varref. Either try to enlarge search space or add some grids for nearest_coord searching";
	}
    }
    @coords;
}

sub start_weather_proc {

    # not supported for OSM data 
    return if $osm_data;

    my(@stat) = stat($wettermeldung_file);
    if (!defined $stat[9] or $stat[9]+30*60 < time()) {
	my @weather_cmdline = (@weather_cmdline,
			       '-o', $wettermeldung_file);

	warn "Weather cmdline: ", join(" ",  @weather_cmdline), "\n" if 1 || $debug >= 2;

	if ($^O eq 'MSWin32') { # XXX Austesten
	    eval q{
		require Win32::Process;
		unlink $wettermeldung_file;
		my $proc;
		Win32::Process::Create($proc,
				       $weather_cmdline[0],
				       @weather_cmdline,
				       0, Win32::Process::CREATE_NO_WINDOW,
				       $tmp_dir);
	    };
	} else {
	    eval {
		local $SIG{'__DIE__'};
		my $weather_pid = fork();
		if (defined $weather_pid and $weather_pid == 0) {
		    eval {
			require File::Spec;
			my $devnull = File::Spec->can("devnull") ? File::Spec->devnull : "/dev/null";
			open STDIN, $devnull;
			open STDOUT, '>' . $devnull;
			open(STDERR, '>' . $devnull);
			require POSIX;
			# Can't use `exists' (for 5.00503 compat):
			POSIX::setsid() if defined &POSIX::setsid;
		    }; warn $@ if $@;
		    unlink $wettermeldung_file;
		    exec @weather_cmdline or my_exit 1;
		}
	    };
	}
    }
}

sub gather_weather_proc {
    return &gather_weather_proc_osm() if $osm_data;

    my @res;
    my(@stat) = stat($wettermeldung_file);
    if (defined $stat[9] and $stat[9]+30*60 > time()) { # Aktualit�t checken
	if (open(W, $wettermeldung_file)) {
	    chomp(my $line = <W>);
	    @res = split(/\|/, $line);
	    close W;
	}
    }
    @res;
}

sub bearing {
    my $angle = shift || 0;    #degrees
    my $lang = shift || "en";

    my %data = (
    	1 => [qw{N E S W}],
    	2 => [qw{N NE E SE S SW W NW}],
    	3 => [qw{N NNE NE ENE E ESE SE SSE S SSW SW WSW W WNW NW NNW}],
    	6 => [qw{N NNO NO ONO O OSO SO SSO S SSW SW WSW W WNW NW NNW}]
    );

    my $lang_ref = $lang eq 'de' ? 6 : 3;

    $angle += 360 while ( $angle < 0 );
    my @data = @{ $data{$lang_ref} };

    return $data[ int( $angle / 360 * @data + 0.5 ) % @data ];
}

sub gather_weather_proc_osm  {
    my $my_lang = &my_lang($lang);

    my $file = "$wettermeldung_file.$my_lang.json";

    return if ! -f $file;

    my $fh = new IO::File $file, "r" or do { 
	warn "open $file: $!\n";
	return;
    };

    my $content = "";
    while(<$fh>) {
	$content .= $_;
    }
    undef $fh;
   
    require JSON; 

    my $perl = JSON::decode_json ($content);
    my $p = $perl->{weatherObservation};
    return if ref $p ne 'HASH';

    my ($date, $time) = split(" ", $p->{datetime});
    $time =~ s,(\d\d):(\d\d):(\d\d),$1:$2,;
    $time .= " UTC";

    my @data = ( $date, $time, $p->{temperature}, $p->{hectoPascAltimeter}, 
		 bearing($p->{windDirection}, $my_lang), $p->{windSpeed}, $p->{humidity}, $p->{windSpeed}, 
		 "", $p->{weatherCondition});

    return @data;
}


sub etag {
    my $lang = 'de'; # XXX
    my $rcsversion = $VERSION;
    my $browserversion = $q->user_agent;
    my $etag = "$lang-$rcsversion-$browserversion";
    $etag =~ s;[\s\[\]\(\)]+;_;g;
    $etag =~ s|[^a-z0-9-_./]||gi;
    $etag = qq{"$etag"};
    (-ETag => $etag);
}

sub bbbike_result_js { $bbbike_html . "/bbbike_result.js" }

# Write a HTTP header (always with Etag and Vary) and maybe enabled compression
sub http_header {
    my(@header_args) = @_;

## utf-8 experiments
#     my %header_args = @header_args;
#     if (!$header_args{"-type"}) {
#	unshift @header_args, "-type" => "text/html;charset=utf-8";
#     }
    my $need_utf8_encoding;
    if ($use_utf8) {
	my %header_args = @header_args;
	if (!$header_args{"-type"}) {
	    unshift @header_args, ("-type" => "text/html; charset=utf-8");
	    $need_utf8_encoding = 1;
	}
    }

    push @header_args, etag(), (-Vary => "User-Agent");
    if ($q->param("as_attachment")) {
	push @header_args, -Content_Disposition => "attachment;file=" . $q->param("as_attachment");
    }
    if ($use_cgi_compress_gzip &&
	eval { require CGI::Compress::Gzip;
	       CGI::Compress::Gzip->VERSION(0.22);
	       package MyCGICompressGzip;
	       @MyCGICompressGzip::ISA = 'CGI::Compress::Gzip';
	       sub isCompressibleType {
		   my($self, $type) = @_;
		   # XXX removed application/pdf| because BBBikeDraw::PDF
		   # and CGI::Compress::Gzip does not work well together
		   # (the latter does not handle "print $fh" calls)
		   return $type =~ m{^(text/.*|image/svg\+xml)$};
	       }
	       1;
	   }) {
	$CGI::Compress::Gzip::global_give_reason =
	    $CGI::Compress::Gzip::global_give_reason = $debug;
	$cgic = MyCGICompressGzip->new;
	print $cgic->header(@header_args);
    } else {
	print $q->header(@header_args);
    }
    $header_written = 1;
    if ($need_utf8_encoding) {
	binmode STDOUT, ':utf8';
    }
}

sub get_google_api_key {

    my %google_api_keys = (
        'bbbike.dyndns.org' =>
"ABQIAAAAidl4U46XIm-bi0ECbPGe5hSLqR5A2UGypn5BXWnifa_ooUsHQRSCfjJjmO9rJsmHNGaXSFEFrCsW4A",

        '78.47.225.30' =>
"ABQIAAAACNG-XP3VVgdpYda6EwQUyhTTdIcL8tflEzX084lXqj663ODsaRSCKugGasYn0ZdJkWoEtD-oJeRhNw",
        'bbbike.de' =>
'ABQIAAAACNG-XP3VVgdpYda6EwQUyhRfQt6AwvKXAVZ7ZsvglWYeC-xX5BROlXoba_KenDFQUtSEB_RJPUVetw',
        'bbbike.org' =>
'ABQIAAAAX99Vmq6XHlL56h0rQy6IShRC_6-KTdKUFGO0FTIV9HYn6k4jEBS45YeLakLQU48-9GshjYiSza7RMg',
        'www.bbbike.org' =>
'ABQIAAAAX99Vmq6XHlL56h0rQy6IShRC_6-KTdKUFGO0FTIV9HYn6k4jEBS45YeLakLQU48-9GshjYiSza7RMg',
        'dev.bbbike.org' =>
'ABQIAAAAX99Vmq6XHlL56h0rQy6IShQGl2ahQNKygvI--_E2nchLqmbBhxRLXr4pQqVNorfON2MgRTxoThX1iw',
        'devel.bbbike.org' =>
'ABQIAAAAX99Vmq6XHlL56h0rQy6IShSz9Y_XkjB4bplja172uJiTycvaMBQbZCQc60GoFTYOa5aTUrzyHP-dVQ',
        'localhost' =>
'ABQIAAAAX99Vmq6XHlL56h0rQy6IShT2yXp_ZAY8_ufC3CFXhHIE1NvwkxTN4WPiGfl2FX2PYZt6wyT5v7xqcg',
    );

    my $full = URI->new( BBBikeCGIUtil::my_url( CGI->new($q), -full => 1 ) );
    my $fallback_host = "bbbike.de";
    my $host = eval { $full->host } || $fallback_host;

    # warn "Google maps API: host: $host, full: $full\n";

    my $google_api_key = $google_api_keys{$host}
      || $google_api_keys{$fallback_host};

    return $google_api_key;
}


sub my_lang {
    my $my_lang =  shift;
    my $flag = shift || 0;

    my $geo = get_geography_object();

    $my_lang = $geo->{local_language};
    my $qq = new CGI;
    my $url = $qq->url(-full=>0, -absolute => 1);

    if (!$flag && $url =~ m,^/\w\w/, ) {
       $my_lang = $lang || "en";
    }


    # validate input - XSS check
    $my_lang = "" if $my_lang !~ /^[a-zA-Z\-]{2,6}$/;
    $my_lang = "en" if $my_lang  eq "";

    return $my_lang;
}

sub header {
    my(%args) = @_;
    my $from = delete $args{-from};
    if (!exists $args{-title}) {
        my $city = $en_city_name || do { ($osm_data && $datadir =~ m,data-osm/(.+),) ? $1 : 'Berlin' };
	$args{-title} = "BBBike \@ $local_city_name" . " - " . M("Fahrrad-Routenplaner") . " $local_city_name" . ($city ne $local_city_name ? " // $city" : "");

	# other city names in this area
	if (scalar(@$other_names)) {
	    $args{-title} .= join ", " , "", @$other_names 
	}

	$args{-title2} = "BBBike\@$local_city_name";

	if ($q->url(-path_info =>1) =~ m,/streets\.html$,) {
	   $args{-title} .= " - " . M("Strassennamen");
        } elsif ( $q->param("output_as") && $q->param("output_as") eq 'print' ) {
	   $args{-title} .= " - " . ($q->param("printvariant") ? "print normal" : "print small");
	} elsif (my $result = delete $args{-result} ) {
	   $args{-title} .= " - $result";
        }
    }

    no strict;
    local *cgilink = ($CGI::VERSION <= 2.36
		      ? \&CGI::link
		      : \&CGI::Link);
    my $head = [];
    push @$head, $q->meta({-http_equiv => "Content-Script-Type",
			   -content => "text/javascript"});
    push @$head, $q->meta({-name => "language",
			   -content => $lang ? $lang : "de"});

    # should not be longer than 161 characters
    my $description =  M("Wir helfen Dir, eine sch�ne, sichere und kurze Fahrradroute in ") .
	$local_city_name . 
	M(" und Umgebung zu finden. Viele Suchoptionen f�r Radfahrer und GPX Export. OpenStreetMap Daten.");

    if ($city eq 'Berlin_DE') {
	push @$head, $q->meta({-name => "description",
			       -content => $description,
			      });
    }
    #push @$head, $q->meta({-name => 'DC.title',
    #			   -content => "BBBike - Routenplaner f�r Radfahrer in Berlin und Brandenburg"});

    # ^^^
    # Hint for search engines, to canonify the start URL
    # This handles the ?begin=1 case and bbbike.de vs. www.bbbike.de
    if (defined $from && $from eq 'chooseform-start' &&
	BBBikeCGIUtil::my_server_name($q) =~ m{^(
						   \Qwww.bbbike.de\E
					       |
						   \Qbbbike.de\E
					       )$}x) {
	push @$head, cgilink({-rel => 'canonical',
			      -href => 'http://www.bbbike.de',
			     });
    }
    push @$head, "<base target='_top'>"; # Can't use -target option here
    push @$head, $q->meta({-http_equiv => 'Content-Type', -content  => 'text/html; charset=utf-8'}) if $use_utf8;

    push @$head, cgilink({-rel  => "shortcut icon",
  			  -href => "$bbbike_images/srtbike1.ico",
  			  -type => "image/x-icon", # according to wikipedia official IANA type is image/vnd.microsoft.icon
#			  -href => "$bbbike_images/srtbike16.gif",
#			  -type => "image/gif",
			 });
    # apple touch icons
    push @$head, cgilink({-rel  => 'apple-touch-icon',
			  -href => "$bbbike_images/srtbike57.png",
			 });
    push @$head, cgilink({-rel   => 'apple-touch-icon',
			  -sizes => '72x72',
			  -href  => "$bbbike_images/srtbike72.png",
			 });
    push @$head, cgilink({-rel   => 'apple-touch-icon',
			  -sizes => '114x114',
			  -href  => "$bbbike_images/srtbike114.png",
			 });

    my($bbbike_de_script, $bbbike_en_script, $bbbike_local_script);
    {
	my $qq = CGI->new();
	my $url;

	if (!is_forum_spam($qq, qw/start via ziel/)) {
          $url = $qq->url(-full=>0, -absolute=>1, -query=>1);
	} else {
          $url = $qq->url(-full=>0, -absolute=>1, -query=>0);
	}
	$url =~ s,/\w\w/,/,;
	
	$bbbike_de_script = "/de" . $url;
	$bbbike_en_script = "/en" . $url;

        $bbbike_local_script = $url;

	# mapping ?all=3 => /streets.html, by lighttpd web server
        $bbbike_local_script =~ s,/streets.html\?all=[123]$,/streets.html,;
        $bbbike_local_script =~ s,/\?all=[123]$,/streets.html,;
    }

    if (!$smallform) {
	push @$head,
	    # cgilink({-rel => 'Help', -href => "$bbbike_script?info=1"}),
	    # cgilink({-rel => 'Home', -href => "$bbbike_script?begin=1"}),
	    # cgilink({-rel => 'Start', -hreflang => 'de', -href => "$bbbike_de_script?begin=1"}),
	    # cgilink({-rel => 'Start', -hreflang => 'en', -href => "$bbbike_en_script?begin=1"}),
	    cgilink({-rel => 'Author',
		     -href => "mailto:@{[ $BBBike::EMAIL ]}"}),
	   (defined $args{-up}
	    ? cgilink({-rel => 'Up', -href => $args{-up}}) : ()),
		;
	if ($args{-contents}) {
	    push @$head, cgilink({-rel => 'Contents',
				  -href => $args{'-contents'}});
	}

    if ($enable_opensearch_plugin) {
        my $opensearch_url = '/osp';

        #my $city2 = ($osm_data && $datadir =~ m,data-osm/(.+),) ? $1 : 'Berlin';
	push @$head, 
		cgilink({-rel  => 'search',
		         -type => "application/opensearchdescription+xml",
			 -href => "$opensearch_url/$city_script.xml",
			 -title=> "$local_city_name ($local_lang)"});
     

        for my $l (qw/en de/) {
	    next if $l eq $local_lang;
	    my $name = $l eq 'en' ? $en_city_name : $de_city_name;
	    push @$head, 
		cgilink({-rel  => 'search',
		         -type => "application/opensearchdescription+xml",
			 -href => "$opensearch_url/$city_script.$l.xml",
			 -title=> "$name ($l)"});
	}
    }

    if ($enable_rss_feed) {
	push @$head, 
		cgilink({-rel  => 'alternate',
		         -type => 'application/atom+xml',
			 -href => '/feed/bbbike-world.xml',
			 -title=> 'BBBike @ World RSS feed'});
    }


    }
    delete @args{qw(-contents -up)};
    my $printmode = delete $args{-printmode};
    if ($bi->{'can_css'} && !exists $args{-style}) {

         my @css = $printmode ? "$bbbike_html/bbbikeprint.css" : "$bbbike_html/bbbike.css";
         push (@css, "$bbbike_html/streets.css") if $is_streets;
	$args{-style} = {-src => \@css };
#XXX del:
#  <<EOF;
#  $std_css
#  EOF
    }
    if (!$bi->{'can_javascript'}) {
	delete $args{-script};
	delete $args{-onload};
    }



    # included in bbbike.css
    # <link href="/html/devbridge-jquery-autocomplete-1.1.2/styles.css" rel="stylesheet" type="text/css"> |);

    my @javascript = ();
    if ($enable_homemap_streets) {
	my $google_api_key = &get_google_api_key;

        # google maps API version
	if ($gmap_api_version == 2) {
	push(@$head, qq|\
<script src="http://maps.google.com/jsapi?key=$google_api_key" type="text/javascript"></script>
<script src="/html/maps.js" type="text/javascript"></script>|);
        } else {
            my $my_lang = &my_lang($lang);
	    my $sensor = is_mobile($q) ? 'true' : 'false';

	# http://code.google.com/apis/maps/documentation/javascript/basics.html#VersionDocs
        # google maps v=3.3 
	# Release Version (3.3) Reference (Feature-Stable)

	  if (1 || !is_mobile($q) || is_resultpage($q) ) {
	    push(@$head, qq|<script type="text/javascript" src="http://www.google.com/jsapi?hl=$my_lang"></script>|);
	    # push(@$head, qq|<script type="text/javascript" src="http://maps.google.com/maps/api/js?v=3.3&amp;sensor=$sensor&amp;language=$my_lang"></script>|);

	    my $google_maps_url = "http://maps.google.com/maps/api/js?v=3.4&amp;sensor=$sensor&amp;language=$my_lang";
	    $google_maps_url .= "&amp;libraries=panoramio" if $enable_panoramio_photos && is_resultpage($q);

	    push(@$head, qq|<script type="text/javascript" src="$google_maps_url"></script>|);
	    push @javascript, 'maps3.js';
	  }
	}

    }

    push @javascript, 'bbbike.js';
    if ($enable_opensearch_suggestions) {
	my $city = $osm_data && $datadir =~ m,data-osm/(.+), ? $1 : 'Berlin';
	push @javascript, "jquery-1.4.2.min.js", "devbridge-jquery-autocomplete-1.1.2/jquery.autocomplete.js";
    }

    if (is_production($q)) {
        push(@$head, qq|<script type="text/javascript" src="/html/bbbike-js.js"></script>|);
    } else {
    	foreach my $js (@javascript) {
	    push(@$head, qq|<script type="text/javascript" src="/html/$js"></script>|);
    	}
    }

    push (@$head, $q->meta({-name => "robots", -content => "nofollow"})) 
	if $is_streets;
	

    # ignore directory service as DMOZ, Yahoo! and MSN
    push (@$head, $q->meta({-name => "robots", -content => "noodp,noydir"}));

    $args{-head} = $head if $head && @$head;

    my @css = $printmode ? "$bbbike_html/bbbikeprint.css" : "$bbbike_html/bbbike.css";
    push (@css, "$bbbike_html/streets.css") if $is_streets;
    $args{-style} = {-src => \@css } if !$printmode;

    my $enable_google_analytics_uacct = delete $args{'-google_analytics_uacct'};
    if (!$smallform) {

	my $title2 = delete $args{-title2};	
	print $q->start_html
	    (%args,
	     #-lang => 'de-DE',
	     #-BGCOLOR => '#ffffff',
	     ($use_background_image && !$printmode ? (-BACKGROUND => "$bbbike_images/bg.jpg") : ()),
	     -meta=>{'keywords'=>'Fahrrad Route, Routenplaner, Routenplanung, Fahrradkarte, Fahrrad-Routenplaner, Radroutenplaner, Fahrrad-Navi, cycle route planner, bicycle, cycling routes, routing, bicycle navigation, Velo, Rad, Karte, map, Fahrradwege, cycle paths, cycle route' . join (", ", "", $en_city_name, @$other_names),
		     'copyright'=>'(c) 1998-2011 Slaven Rezic + Wolfram Schneider',
		    },
	     -author => $BBBike::EMAIL,
	    );
	if ($bi->{'css_buggy'}) {
	    print "<font face=\"$font\">";
	}

	if ($enable_google_analytics && is_production($q) && $enable_google_analytics_uacct) {
	    print qq{<script type="text/javascript">\nwindow.google_analytics_uacct = "$google_analytics_uacct";\n</script>\n\n};
        }

	if ($is_streets) {
	   print qq{<div id="main">\n<div id="main_border">\n};
	   print qq{<div id="top_ie">\n<div id="top">\n};
	   print qq{<div id="search_query"></div>\n};
	   print qq{<div id="ad_top">\n};
	}

	print qq{<span id="headline">\n<h2>\n};
	if ($printmode) {
	    print "$args{-title}";
	    print "<img alt=\"\" src=\"$bbbike_images/srtbike.gif\" hspace=10>";
	} else {
	    my $use_css = !$bi->{'css_buggy'};
	    my $title = $title2;
	    if ($is_beta) {
		$title = "BB<span style='font-style:italic;'>&#x03B2;</span>ike</a>";
	    }
	    print "<a href='$bbbike_url' title='" . M("Zur�ck zur Hauptseite") . "' style='text-decoration:none; color:black;'>$title";
	    print "<img";
	    if ($use_css) {
		print ' style="position:relative; top:15px; left:-15px;"';
	    }
	    print " id=\"headlogo\" alt=\"\" src=\"$bbbike_images/srtbike.gif\" border=0>";
	    print "</a>";
	}
	print "</h2>\n";
	print "</span>\n";
    } else {
	print $q->start_html(%args);
	print "<h1>BBBike</h1>";
    }
    if ($with_lang_switch && (!defined $from || $from !~ m{^(info|map)$}) && (!&is_mobile($q) || is_resultpage($q))) {
        my $query_string = cgi_utf8($use_utf8)->query_string;
	$query_string = '?' . $query_string if $query_string;

	print qq{<div id="top_right">};
        if ($enable_current_weather) {
	    print qq{\n<span id="current_weather"> </span>\n};
	}

	if (!$printmode && !&is_mobile($q)) {
	  print qq{<span id="language_switch">\n};
	
	  my $counter = 0;
	  foreach my $l (@supported_lang) {
	    print " | " if $counter++ > 0;
	    if ($l eq $lang) {
		print qq{<span class="current_language" title="}, M("aktuelle Sprache"), ": ", M($l), qq{">$l</span>\n};
	    } else {
	        print qq{<a rel="nofollow" href="/$l$bbbike_local_script" title="switch map language to }, M($l), qq{">$l</a>\n};
	    }
	  }
	  print qq{| <a href="$bbbike_local_script" title="switch map language to }, M($local_lang), qq{">local</a>\n} if $selected_lang;
	  print qq{</span>\n};
	}

	if (0) {
	if ($selected_lang && $bbbike_local_script) {
	    if (!grep { $local_lang eq $_ } @supported_lang) {
	        print qq{<a href="$bbbike_local_script" title="switch map language to }, M($local_lang), qq{">$local_lang</a>\n};
	    }
	} else {
	    if (!grep { $local_lang eq $_ } @supported_lang) {
		print qq{<span title="map language is in }, M($local_lang), qq{"><i>$local_lang</i></span>\n};
	    }
        }

	if ($lang eq 'en') {
	    print qq{<a href="$bbbike_de_script$query_string"><img class="unselectedflag" src="$bbbike_images/de_flag.png" alt="Deutsch" title="Deutsch" border="0"></a>};
	    if ($selected_lang) {
	       print qq{<img class="selectedflag" src="$bbbike_images/gb_flag.png" alt="English" title="English" border="0">\n} 
            } else {
	       print qq{<a href="$bbbike_en_script$query_string"><img class="unselectedflag" src="$bbbike_images/gb_flag.png" alt="English" title="English" border="0"></a>\n};
	    }

	} else {
	    print <<EOF;
<img class="selectedflag" src="$bbbike_images/de_flag.png" alt="Deutsch" border="0" title="Deutsch"><a href="$bbbike_en_script$query_string"><img class="unselectedflag" src="$bbbike_images/gb_flag.png" alt="English" title="English" border="0"></a>
EOF
	} 

	}

	print qq{</div>\n};

	#&adsense_linkblock if &is_production($q) && !is_mobile($q);
    }

    if ($ENV{SERVER_NAME} =~ /cs\.tu-berlin\.de/ &&
	open(U, "$FindBin::RealBin/bbbike-umzug.html")) {
	while(<U>) { print }
	close U;
    }
}

sub footer { print footer_as_string() }

sub footer_as_string {
	my $s = "";

#my $real_time = time - $time_start;
my $elapsed = tv_interval ( $time_start, [gettimeofday]);
my $real_time = int ($elapsed * 100)/100; 

my $qq = new CGI;
#$qq->param( 'startname', Encode::encode( utf8 => $qq->param('startname')));
#$qq->param( 'zielname', Encode::encode( utf8 => $qq->param('zielname')));
my $permalink = BBBikeCGIUtil::my_escapeHTML($qq->url(-full=>1, -query=>1));

my $cityname = $osm_data && $main::datadir =~ m,data-osm/(.+), ? $1 : 'Berlin und Potsdam';
my $streets = $bbbike_script =~ m,/$, ? $bbbike_script . "streets.html" : "$bbbike_script?all=1";
my $list_of_all_streets = qq{<a href="$streets" target="BBBikeAll">} 
	    . M("Liste aller bekannten Stra&szlig;en") . ($cityname ? " " . M("in") . " " . $local_city_name : "") ."</a>";
my $community_link = $lang eq 'de' ? '/community.de.html' : '/community.html';
my $donate = M("spenden");
my $livesearch = M("livesuche");
my $permalink_msg = M("permalink");
my $app = M("app");
my $help = M("hilfe");
my $mobile = M("mobile");

my $other_cities = "";
if ($osm_data) {
    my $geo = get_geography_object();
    my $name = $geo->{city_names};

    if (exists $geo->{'neighbours'} && ref $geo->{'neighbours'} eq 'ARRAY') {
	foreach my $n (@{ $geo->{'neighbours'} } ) {
		my ($distance, $city2, $city_names) = @{ $n };
		next if $city2 eq 'berlin';
	        next if $city2 eq $city_script;

		next if $distance > 3000;

		$city_names = $city2 if !$city_names;

		$other_cities .= qq{ <a href="../$city2/">} . BBBikeCGIUtil::my_escapeHTML( select_city_name($city2, $city_names, $lang) ) . "</a>\n";
	}
    }
    $other_cities .= qq{ [<a href="../">} . M("weitere St&auml;dte") . "</a>]\n";
}

my $span_debug = is_production($q) ? "" : qq{<tt><span id="debug"></span></tt>\n};

my $rss_icon = "";
$rss_icon = qq{<a href="/feed/bbbike-world.xml"><img alt="" class="logo" width="14" height="14" title="}
	    .  M('Was gibt es Neues auf BBBike.org') 
	    . qq{" src="/images/rss-icon.png" ></a>} if $enable_rss_icon;

my $permalink_text = $is_streets ? "" : qq{ | <a href="#" onclick="togglePermaLinks(); return false;">$permalink_msg</a><span id="permalink_url2" style="display:none"> $permalink</span>};
$permalink_text = "" if $permalink !~ /=/;

my $google_plusone = qq{<a class="gplus" onmouseover="javascript:google_plusone();" ><img src="/images/google-plusone-t.png" alt=""></a><g:plusone href="http://bbbike.org" size="standard" count="true"></g:plusone>\n} if $enable_google_plusone_t_link;

my $facebook_title = M("Facebook Fanpage");
my $donate_title = M("Spende an BBBike.org");
my $twitter_title = M("Folge uns auf twitter.com/BBBikeWorld");
my $s_copyright = <<EOF;

<div id="footer">
<div id="footer_top">
<a class="mobile_link" href="/">home</a> |
<a href="/help.html">$help</a> |
<a href="/app.html">$app</a> |
<a href="$community_link">$donate</a> |
<a title="search time: $real_time seconds" href="/cgi/livesearch.cgi?city=$city_script">$livesearch</a> |
$list_of_all_streets $permalink_text
$span_debug
</div>
</div>

<div id="copyright" style="text-align: center; font-size: x-small; margin-top: 1em;" >
<hr>
(&copy;) 1998-2011 <a href="http://CycleRoutePlanner.org">BBBike.org</a> by <a href="http://wolfram.schneider.org">Wolfram Schneider</a> &amp; <a href="http://www.rezic.de/eserte">Slaven Rezi&#x107;</a>  //
Map data by the <a href="http://www.openstreetmap.org/">OpenStreetMap</a> Project<br >
<div id="footer_community">
  <a href="$community_link"><img class="logo" height="19" width="64" src="/images/donate.png" alt="Flattr this" title="$donate_title" border="0"></a>
  <a href="$community_link"><img class="logo" src="/images/flattr-compact.png" alt="Flattr this" title="Flattr this" border="0"></a>
  <a href="http://twitter.com/BBBikeWorld"><img class="logo" src="/images/twitter-b.png" title="$twitter_title" alt=""></a>
  <a href="$facebook_page" target="_new"><img class="logo" src="/images/facebook-t.png" alt=""><img class="logo" src="/images/facebook-like.png" alt="" title="$facebook_title"></a>
  $google_plusone
  $rss_icon
</div>
</div>

<div id="other_cities">
$other_cities
</div>
EOF


my $s_google_analytics = <<EOF;

<script type="text/javascript">
var gaJsHost = (("https:" == document.location.protocol) ? "https://ssl." : "http://www.");
document.write(unescape("%3Cscript src='" + gaJsHost + "google-analytics.com/ga.js' type='text/javascript'%3E%3C/script%3E"));
</script>
<script type="text/javascript">
try {
var pageTracker = _gat._getTracker("$google_analytics_uacct");
pageTracker._trackPageview();
} catch(err) {}</script>

EOF

    $s .= $s_copyright;

    use URI;
    my $full = URI->new( BBBikeCGIUtil::my_url( CGI->new, -full => 1 ) );
    my $host = eval { $full->host } || "";

    $s .= $s_google_analytics if $enable_google_analytics && is_production($q);

    if ($bi->{'css_buggy'}) {
	$s .= "</font>\n";
    }

    $s .= qq{\n<span class="real_time" style="} . 
	    ($show_real_time ? "" : 'display:none') . qq{">cycle route calculated in $real_time seconds</span>\n};
    $s;
}

sub blind_image {
    my($w,$h) = @_;
    $w = 1 if !$w; $h = 1 if !$h;
    "<img src='$bbbike_images/px_1t.gif' alt='' width=$w height=$h border=0>"
}

sub complete_link_to_einstellungen {
    window_open("$bbbike_script?bikepower=1", "BikePower",
		"dependent,height=400,resizable," .
		"screenX=400,screenY=40,scrollbars,width=550") .
		    M("Einstellungen") . "</a>";
}

sub link_to_met {
## Die Berliner Wetterkarte sieht nicht so schick aus, und hat sowieso
## die gleichen Daten wie die Startseite von met.fu-berlin.de
#     if ("@weather_cmdline" =~ /parse_wetterkarte/) {
# 	qq{<a href="http://wkserv.met.fu-berlin.de/Wetter/mainframe.php">};
#     } else {
    if ($osm_data) {
	qq{<a href="http://news.bbc.co.uk/weather/">};
    } else {
	qq{<a href="http://www.met.fu-berlin.de/de/wetter/">};
    }
#     }
}

sub window_open {
    my($href, $winname, $settings) = @_;
    if ($bi->{'can_javascript'} && !$bi->{'window_open_buggy'}) {
	"<a href=\"$href\" target=\"$winname\" onclick='window.open(\"$href\", \"$winname\"" .
	  (defined $settings ? ", \"$settings\"" : "") .
	    "); return false;'>";
    } else {
	"<a href=\"$href\" target=\"$winname\">";
    }
}

sub call_bikepower {
    http_header(@no_cache);
    eval q{
	require BikePower::HTML;
	# XXX no support for css in BikePower::HTML
	print BikePower::HTML::code();
    };
    if ($@) {
	header();
	print
	  "<b>Sorry, BikePower ist anscheinend auf diesem System ",
	  "nicht installiert.</b><p>\n";
	footer();
    }
}

sub init_bikepower {
    my $q = shift;
    undef $bp_obj;
    eval {
	local $SIG{__DIE__};
	require BikePower;
	require BikePower::HTML;
	$bp_obj = BikePower::HTML::new_from_cookie($q);
	if ($bp_obj->can("make_valid")) {
	    $bp_obj->make_valid;
	} else {
	    warn "*** Cannot find make_valid method in BikePower, please consider to upgrade BikePower.pm! ***";
	}
	$bp_obj->given('P');
	BBBikeCalc::init_wind();
    };
    # XXX warn __LINE__ .  ": Warnung: $@<br>\n" if $@;
    $bp_obj;
}

# XXX Doppelung mit bbbike-Code vermeiden
sub bikepwr_get_v { # Resultat in m/s
    my($wind, $power, $grade) = @_;
    $grade = 0 if !defined $grade; # $grade wird noch nicht verwendet XXX
    $bp_obj->grade($grade);
    $bp_obj->headwind($wind);
    $bp_obj->power($power);
    $bp_obj->calc();
    my $v = $bp_obj->velocity;
    $v;
}

sub choose_street_html {
    my($strasse, $plz_number, $type) = @_;
    my $plz_obj = init_plz(scope => "all");
    my $plz_re = $plz_obj->make_plz_re($plz_number);
    my @res = $plz_obj->look($plz_re, Noquote => 1);
    my $str = get_streets();
    my @strres = $str->union(\@res);
    if (!@strres) {
	print "Keine Stra&szlig;en im PLZ-Gebiet $plz_number.<br>\n";
	print ucfirst($type) . ": <input type=text name=$type><br>\n";
    } else {
	print <<EOF;
<b>$strasse</b> ist nicht in der BBBike-Datenbank erfasst. Folgende
Stra&szlig;en sind im selben PLZ-Gebiet:<br>
EOF
        my @strname;
	for(my $i = 0; $i <= $#strres; $i++) {
	    push @strname, $str->get($strres[$i])->[0];
	    last if $i >= $max_plz_streets;
	}
	@strname = sort @strname;
	my $i = 0;
	my $strname;
	if ($use_select) {
	    print "<select $bi->{hfill} name=" . $type . "name>";
	}
	foreach $strname(@strname) {
	    if ($use_select) {
		print "<option value=\"$strname\">$strname\n";
	    } else {
		print "<input type=radio name=" . $type . "name";
		if ($i == 0) {
		    print " checked";
		}
		print " value=\"$strname\"> $strname<br>\n";
		if ($i >= $max_plz_streets && $i < $#strres) {
		    print "...<br>\n";
		    last;
		}
	    }
	    $i++;
	}
	if ($use_select) {
	    print "</select><br>\n";
	}
	print "<input type=radio name=" . $type .
	  "name value=\"\"> <input type=text name=" . $type;
	if ($bi->{'can_javascript'}) {
	    print " onFocus='document.BBBikeForm.${type}name[document.BBBikeForm.${type}name.length-1].checked = true;'";
	}
	print "><br>\n";
    }
}

sub choose_all_form {
#XXX siehe choose_ch_form
    my $locale_set = 0;
    my $old_locale;
    use locale;

    my $q = new CGI;
    my $cache_street_names = 1;
    my $force_cache_rebuild = defined $q->param('all') && $q->param('all') >= 3 ? 1 : 0;

    #
    $cache_street_names = 0 if !$cache_streets_html;

    my $street_names_files = $ENV{TMPDIR} . "/$lang.streets.html";
    my $cache_file;
    my $fh;


    if ( $cache_street_names && $ENV{TMPDIR} && -d $ENV{TMPDIR} ) {
	# read from cache if exists
	if ( !$force_cache_rebuild && -r $street_names_files && -s $street_names_files ) {
	   $fh = new IO::File $street_names_files, "r";
	   if (defined $fh) {
		binmode $fh, ":utf8";	
		binmode STDOUT, ":utf8";	

		while(<$fh>) {
		   print;
		}

		# done
		return;

	   } else {
		warn "open street name cache '$street_names_files': $!, regenerate...\n";
	   } 
	}

	# create cache entry, and write the output later to stdout
	else {
	   $cache_file = $street_names_files . ".tmp.$$";

	   $fh = new IO::File $cache_file, "w";
           if (defined $fh) {
		binmode $fh, ':utf8';
		select $fh;
           } else {
		warn "write to street name cache > '$cache_file': $!\n";
		undef $cache_file;
	   }
	}
    }

    if(0) {
    eval {
	local $SIG{'__DIE__'};
	require POSIX;
	$old_locale = &POSIX::setlocale(&POSIX::LC_COLLATE, "");
	foreach my $locale (qw(de de_DE de_DE.ISO8859-1 de_DE.ISO_8859-1)) {
	    $locale_set=1, last
		if (&POSIX::setlocale(&POSIX::LC_COLLATE, $locale));
	}
    };
    }

    http_header(@weak_cache);
    header(#too slow XXX -onload => "list_all_streets_onload()",
	   -script => {-src => $bbbike_html . "/bbbike_start.js?v=$bbbike_start_js_version",
		      },
	   -google_analytics_uacct => 1,
	  );

    my @strlist;
    my $str = get_streets();
    $str->init;
    while(1) {
	my $ret = $str->next;
	last if !@{$ret->[1]};
	push(@strlist, $ret->[0]);
    }
#XXX del:
#     my %trans = ('�' => 'A',
# 		 '�' => 'O',
# 		 '�' => 'U',
# 		 '�' => 'a',
# 		 '�' => 'o',
# 		 '�' => 'u',
# 		 '�' => 'ss',
# 		 '�' => 'e',
# 		 '�' => 'e',
# 		 '�' => 'a',
# 		);
#    my $trans_rx = "[".join("",keys %trans)."]";
    my %trans = %BBBikeUtil::uml_german_locale;

    if ($locale_set) {
	@strlist = sort @strlist;
    } else {
	@strlist = map  { $_->[1] }
	           sort { $a->[0] cmp $b->[0] }
		   map  { #XXX del:(my $s = $_) =~ s/($trans_rx)/$trans{$1}/ge;
		          (my $s = $_) =~ s/($BBBikeUtil::uml_german_locale_keys_rx)/$BBBikeUtil::uml_german_locale{$1}/ge;
			  [ $s, $_]
		      }
		       @strlist;
    }

    my $last = "";
    my $last_initial = "";

    print "<p>\n", M("Willkommen beim Radroutenplaner BBBike! Wir helfen Dir, eine sch�ne, sichere und kurze Fahrradroute in") .
	    " <i title='$city'>$local_city_name</i> ",  
	    M("und Umgebung zu finden."), "<br></p>\n";
    print qq{<p>\n}, M("Klicke auf eine Strasse oder Point of Interest (POI), um die Routensuche zu starten"), qq{:</p>\n};

    &BBBikeAds::adsense_street_linkblock if &is_production($q); # && !is_mobile($q);
    &BBBikeAds::adsense_street_page if &is_production($q); # && !is_mobile($q);

    print qq{\n<div id="a_z_list">\n};
    print "<center>";
    for my $ch ('A' .. 'Z') {
	print "<a href=\"#$ch\">$ch</a> ";
    }
#     for my $type (qw(s u)) {
# 	print qq{<a href="#${type}bhf">} . uc($type) . qq{-Bahnh�fe</a> };
#     }
    print "</center>\n</div>\n\n";

    print qq{</div>\n</div>\n</div><!-- top_ie -->\n};

    print "\n\n<div id='list'>";

    my $counter = 0;
    for(my $i = 0; $i <= $#strlist; $i++) {
	next if ($strlist[$i] =~ /^\s*['"\(\.\,<\-]/);

	next if $last eq $strlist[$i];
	$last = $strlist[$i];
	(my $strname = $strlist[$i]) =~ s/\s+/\240/g;
	my $initial = substr($strname, 0, 1);
	if (defined $last_initial and
	    $last_initial ne $initial and
	    (!defined $trans{$initial} or
	     $last_initial ne $trans{$initial})) {

	    print "</div>\n" if $counter;
	    print qq{\n<div class="street_section">\n};
	    print "<hr>\n";
	    $counter++;

	    $last_initial = ($trans{$initial} ? $trans{$initial} : $initial);
	    print "<a name=\"$last_initial\"><b>$last_initial</b></a><br>\n";
	}
	#print "$strname<br>";
        my $html_strname = BBBikeCGIUtil::my_escapeHTML($strname);
        $html_strname =~ s/&#160;/ /g;
	if (!Encode::is_utf8($html_strname)) {
            $html_strname = Encode::decode("utf-8", $html_strname);
	}
 
        print qq{<span onclick="oS(this);">$html_strname</span><br>\n};
    }

#     for my $type (qw(s u)) {
# 	my $s = Strassen->new($type . "bahnhof");
# 	my @bhf;
# 	$s->init;
# 	while(1) {
# 	    my $r = $s->next;
# 	    last if !@{ $r->[Strassen::COORDS()] };
# 	    push @bhf, $r->[Strassen::NAME()] if $r->[Strassen::CAT()] !~ /0$/;
# 	}
# 	@bhf = sort @bhf;
# 	print "<hr>\n";
# 	print qq{<a name="${type}bhf"><b>} . uc($type) . qq{-Bahnh�fe</b></a><br/>\n};
# 	print join("<br/>\n", map { uc($type) . " " . $_ } @bhf), "\n";
#     }

    print "</div>\n" if $counter;

    print "<hr>\n";
    print "</div>\n";

    &footer;

    print "</div>\n";
    print "</div>\n";

    print $q->end_html;
    exit(0);

    if (0 && $locale_set && defined $old_locale) {
	eval {
	    local $SIG{'__DIE__'};
	    &POSIX::setlocale( &POSIX::LC_COLLATE, $old_locale);
	};
	warn $@ if $@; #XXX remove?
    }

    if ($cache_file && $fh) {
	$fh->close;

	my $data;
	$fh = new IO::File $cache_file, "r";
	if (defined $fh) {
	    select STDOUT;
	    binmode $fh, ':utf8';
	    binmode STDOUT, ':utf8';

	    while (<$fh> ) {
	   	$data .= $_;
	    }
            $fh->close;
        } else {
	    die "open cache file: $cache_file: $!\n";
	}

	# rename first, then print it out (on a slow link)
	if (!rename ($cache_file, $street_names_files)) {
	   warn "rename $cache_file => street_names_files: $!\n";
	}

	print STDOUT $data;	
    }
}

sub nahbereich {
    my($startc, $zielc, $startname, $zielname) =
      ($q->param('startc'), $q->param('zielc'),
       $q->param('startname'),$q->param('zielname'));
    http_header(@weak_cache);
    header();
    print "Kreuzung im Nahbereich angeben:<p>\n";
    new_kreuzungen();
    my($startx, $starty) = split(/,/, $startc);
    my($zielx,  $ziely)  = split(/,/, $zielc);
    print "<form action=\"$bbbike_script\">";
    print "<b>Start</b>:<br>\n";
    print "<input type=hidden name=startname value=\"$startname\">";
    my $i = 0;
    foreach ($kr->nearest_loop($startx, $starty)) {
	print "<input type=radio name=startc value=\"$_\"";
	if ($i++ == 0) {
	    print " checked";
	}
	print "> ", nice_crossing_name(@{$crossings->{$_}}), "<br>\n";
    }
    print "<hr>";
    print "<input type=hidden name=zielname value=\"$zielname\">";
    print "<b>Ziel</b>:<br>\n";
    $i = 0;
    foreach ($kr->nearest_loop($zielx, $ziely)) {
	print "<input type=radio name=zielc value=\"$_\"";
	if ($i++ == 0) {
	    print " checked";
	}
	print "> ", nice_crossing_name(@{$crossings->{$_}}), "<br>\n";
    }
    print "<hr>";
    suche_button();
    footer();
    print "</form>\n";
    print $q->end_html;
    exit(0);
}

sub get_nearest_crossing_coords {
    my($x,$y) = @_;
    new_kreuzungen();
    my $xy;
    while (1) {
	if ($use_exact_streetchooser) {
	    my $str = get_streets();
	    my $ret = $str->nearest_point("$x,$y", FullReturn => 1);
	    $xy = $ret->{Coord};
	    if ($xy && !$kr->crossing_exists($xy)) {
		# This may happen, because nearest_point does also return Kurvenpointe,
		# whereas $kr has only real Kreuzungen. Find a real Kreuzung...
		my @street_coords = @{ $ret->{StreetObj}->[Strassen::COORDS()] || [] };
		# find this point in @street_coords
		my $start_index = 0;
		for(; $start_index <= $#street_coords; $start_index++) {
		    last if ($street_coords[$start_index] eq $xy);
		}
		if ($start_index > $#street_coords) {
		    # This may happen if there's really no "nearest point".
		    # Hopefully we'll get one after incrementing the scope,
		    # see below.
		} else {
		    my $before_xy;
		    my $after_xy;
		    for(my $i=$start_index-1; $i >= 0; $i--) {
			if ($kr->crossing_exists($street_coords[$i])) {
			    $before_xy = $street_coords[$i];
			    last;
			}
		    }
		    for(my $i=$start_index+1; $i <= $#street_coords; $i++) {
			if ($kr->crossing_exists($street_coords[$i])) {
			    $after_xy = $street_coords[$i];
			    last;
			}
		    }
		    if (!$before_xy && !$after_xy) {
			warn "Harmless? Cannot find any real crossing in <@street_coords>, scope is <@{[ $q->param('scope') ]}>";
		    } else {
			if ($after_xy && $before_xy) {
			    # choose nearest
			    if (Strassen::Util::strecke_s("$x,$y", $before_xy) < Strassen::Util::strecke_s("$x,$y", $after_xy)) {
				$xy = $before_xy;
			    } else {
				$xy = $after_xy;
			    }
			} elsif ($before_xy) {
			    $xy = $before_xy;
			} elsif ($after_xy) {
			    $xy = $after_xy;
			}
		    }
		}

	    }
	} else {
	    $xy = (($kr->nearest_loop($x,$y))[0]);
	}
	last if defined $xy;
	my $new_scope = increment_scope();
	last if !defined $new_scope;
	get_streets_rebuild_dependents();
    }
    $xy;
}

sub show_routelist_from_file {
    my $file = shift;

    require Route;
    my $res = eval { Route::load($file, { }, -fuzzy => 1) };
    my $err = $@;
    if ($res->{RealCoords}) {
	my $r = Route->new_from_realcoords($res->{RealCoords});
	if (!$q->param("startname")) {
	    my $base = basename($file);
	    $base =~ s{\.[^.]+$}{};
	    $q->param("startname", $base);
	}
	return display_route($r, -hidesettings => 1, -hidewayback => 1);
    }
    die $err;
}

# XXX should also implement coordssession param
sub show_routelist_from_coords {
    require Route;
    my $r = Route->new_from_cgi_string(join("!", $q->param('coords')));
    display_route($r, -hidesettings => 1, -hidewayback => 1);
}

sub draw_route_from_fh {
    my $fh = shift;

    my $file = "$tmp_dir/bbbike.cgi.upload.$$." . time;
    open(OUT, ">$file") or die "Can't write to $file: $!";
    while(<$fh>) {
	print OUT $_;
    }
    close OUT;
    close $fh;

    require Route;
    Route->VERSION(1.09);
    my $res;
    eval {
	$res = Route::load($file, { }, -fuzzy => 1);
    };
    my $err = $@;
    ## XXX unlink later...
    #unlink $file;

    if ($res->{RealCoords}) {
	$q->param('draw', 'all');
	$q->param('scope', 'wideregion');
	$q->param('geometry', "800x600") if !defined $q->param("geometry");
	# Separator war mal ";", aber CGI.pm behandelt diesen genau wie "&"
	$q->param('coords', join("!", map { "$_->[0],$_->[1]" }
				 @{ $res->{RealCoords} }));
	if (!$q->param("imagetype")) {
	    $q->param("imagetype", "png"); # XXX seems to be necessary
	}
	$q->delete('routefile');
	$q->delete('routefile_submit');
	draw_route();
    } else {
	http_header(@no_cache);
	header();
	print "Dateiformat nicht erkannt: $err";
	upload_button_html();
	footer();
	print $q->end_html;
        exit(0);
    }
}

sub upload_button {
    http_header(@no_cache); # wegen dummy
    header();
    upload_button_html();
    footer();
    print $q->end_html;
    exit(0);
}

sub upload_button_html {
    # XXX warum ist dummy notwendig???
    print $q->start_multipart_form(-method => 'post',
				   -action => "$bbbike_url?dummy=@{[ time ]}"),
          "Anzuzeigende Route-Datei (GPSman-Tracks, .ovl- oder .bbr-Dateien):<br>\n",
	  $q->filefield(-name => 'routefile'),
	  "<p>\n",
	  # hier k�nnte noch ein maxdist-Feld stehen, um die maximale
	  # Entfernung anzugeben, bei der eine Route noch als
	  # "zusammenh�ngend" betrachtet wird XXX
	  "Bildformat: ",
	  $q->popup_menu(-name => "imagetype",
			 -values => ['png',
				     ($cannot_pdf ? () : ('pdf-auto')),
				     ($cannot_svg ? () : ('svg')),
				     ($cannot_jpeg ? () : ('jpeg')),
				     ($can_mapserver ? ('mapserver') : ()),
				    ],
			 -default => 'png',
			 -labels => {'png' => 'PNG',
				     'pdf-auto' => 'PDF',
				     'svg' => 'SVG',
				     'jpeg' => 'JPEG',
				     'mapserver' => 'Mapserver'},
			),
	  "<p>\n",
	  "Bildgr��e: <small>(nicht f�r PDF, SVG und Mapserver)</small><br>\n",
	  $q->radio_group(-name => "geometry",
			  -values => ["400x300", "640x480", "800x600",
				      "1024x768", "1200x1024", "1600x1200",
				     ],
			  -linebreak => "true",
			  -default => (defined $q->param("geometry")
				       ? $q->param("geometry")
				       : "1024x768"),
			 ),
	  "<p>\n",
	  $q->checkbox(-name => "outputtarget",
		       -value => 'print',
		       -label => "f�r Druck optimieren",
		      ),
	  "<p>\n",
	  $q->submit(-name => 'routefile_submit',
		     -value => 'Anzeigen'),
	  $q->endform;
}

sub tie_session {
    my $id = shift;
    return unless $now_use_apache_session;

    if (!eval qq{ require $apache_session_module }) {
	$now_use_apache_session = $use_apache_session = undef; # permanent error
	warn $@ if $debug;
	return;
    }

    if ($apache_session_module eq 'Apache::Session::Counted') {
	return tie_session_counted($id);
    }

    my %sess;
    eval {
	tie %sess, $apache_session_module, $id,
	    { FileName => "/tmp/bbbike_sessions_" . $< . ".db", # XXX make configurable
	      LockDirectory => '/tmp',
	    } or do {
		$use_apache_session = undef; # possibly transient error
		warn $! if $debug;
		return;
	    };
    };
    if ($@) {
	if (!defined $id) {
	    # this is fatal
	    die "Cannot create new session: $@";
	} else {
	    # may happen for old sessions, e.g. in links, so
	    # do not die
	    warn "Cannot load old session, maybe already garbage-collected: $@";
	}
    }

    return \%sess;
}

sub tie_session_counted {
    my $id = shift;

    # To retrieve a session file:
    #perl -MData::Dumper -MStorable=thaw -e '$content=do{open my $fh,$ARGV[0] or die;local$/;<$fh>}; warn Dumper thaw $content' file

    #my $dirlevels = 0;
    my $dirlevels = 1;
    my @l = localtime;
    my $date = sprintf "%04d-%02d-%02d", $l[5]+1900, $l[4]+1, $l[3];
    ## Make sure a different user for cgi-bin/mod_perl operation is used
    #my $directory = "/tmp/bbbike-sessions-" . $< . "-$date";
    ## No need for per-day directories,
    ## I have /tmp/coordssessions
    my $directory = "/tmp/bbbike-sessions-" . $<;
    ## Resetting the sessions daily:
    my $counterfile = "/tmp/bbbike-counter-" . $< . "-$date";
    #my $counterfile = "/tmp/bbbike-counter-" . $<;

#     require File::Spec;
#     open(OLDOUT, ">&STDOUT") or die $!;
#     open(STDOUT, ">&STDERR") or die $!;
#     Apache::Session::CountedStore->tree_init($directory, $dirlevels);
#     close STDOUT;
#     open(STDOUT, ">&OLDOUT") or die $!;

    my %sess;
    eval {
	tie %sess, $apache_session_module, $id,
	    { Directory => $directory,
	      DirLevels => $dirlevels,
	      CounterFile => $counterfile,
	      AlwaysSave => 1,
	      #HostID => undef,
	      #HostURL => sub { undef },
	      Timeout => 10,
	    } or do {
		$use_apache_session = undef; # possibly transient error
		warn $! if $debug;
		return;
	    };
    };
    if ($@) { # I think this normally does not happen
	if (!defined $id) {
	    # this is fatal
	    die "Cannot create new session: $@";
	} else {
	    # may happen for old sessions, e.g. in links, so
	    # do not die
	    warn "Cannot load old session, maybe already garbage-collected: $@";
	}
    }
    if (defined $id && keys %sess == 1) {
	# we silently assume that the session is invalid
	$use_apache_session = undef;
	return undef;
    }

    return \%sess;
}

sub load_teaser {
    eval { local $SIG{'__DIE__'};
	   my $teaser_file = "$FindBin::RealBin/bbbike-teaser.pl";
	   if ((defined $BBBikeCGI::teaser_file_modtime &&
		(stat($teaser_file))[9] > $BBBikeCGI::teaser_file_modtime) ||
	       !defined &teaser) {
	       do $teaser_file;
	       $BBBikeCGI::teaser_file_modtime = (stat($teaser_file))[9];
	   }
       }; warn $@ if $@;
}

sub filename_from_route {
    my($startname, $zielname, $type) = @_;
    for ($startname, $zielname) {
	$_ = lc BBBikeUtil::umlauts_to_german($_);
	s{[^a-z0-9_]}{}g;
    }
    $type = "route" if !$type;
    if (!$startname || !$zielname) {
	$type; # fallback
    } else {
	$type . "_" . $startname . "_" . $zielname;
    }
}

sub outside_berlin_and_potsdam {
    return if $osm_data;
    my($c) = @_;
    my $result = 0;
    eval {
	require VectorUtil;
	my $berlin = Strassen->new("berlin");
	$berlin->count == 1 or die "Record count of berlin is not 1";
	$berlin->init;
	my $potsdam = Strassen->new("potsdam");
	$potsdam->count == 1 or die "Record count of potsdam is not 1";
	$potsdam->init;
	my $berlin_border = [ map { [split /,/] } @{ $berlin->next->[Strassen::COORDS()] } ];
	my $potsdam_border = [ map { [split /,/] } @{ $potsdam->next->[Strassen::COORDS()] } ];
	my $p = [split /,/, $c];
	$result = 1 if (!VectorUtil::point_in_polygon($p,$berlin_border) &&
			!VectorUtil::point_in_polygon($p,$potsdam_border));

    };
    warn $@ if $@;
    $result;
}

sub outside_berlin {
    return if $osm_data;
    my($c) = @_;
    my $result = 0;
    eval {
	require VectorUtil;
	my $berlin = Strassen->new("berlin");
	$berlin->count == 1 or die "Record count of berlin is not 1";
	$berlin->init;
	my $berlin_border = [ map { [split /,/] } @{ $berlin->next->[Strassen::COORDS()] } ];
	my $p = [split /,/, $c];
	$result = 1 if (!VectorUtil::point_in_polygon($p,$berlin_border));

    };
    warn $@ if $@;
    $result;
}

sub get_geography_object {
    my $maybe_meta_file = "$Strassen::datadirs[0]/meta.dd";
    if (-r $maybe_meta_file) {
	my $geo = eval {
	    require Geography::FromMeta;
	    Geography::FromMeta->load_meta($maybe_meta_file);
	};
	warn $@ if $@;
	return $geo if $geo;
    }

    return if !defined $city;

    my $geo_mod = "Geography::" . $city;
    if (eval qq{ require $geo_mod; }) {
	$geo_mod->new;
    } else {
	undef;
    }
}

sub nice_crossing_name {
    my(@c) = @_;

   
    # first part of cross is empty, switch streetsnames of corner: /foo -> foo/
    if ($osm_data) {
	my @cr = @c;
    	if ($cr[0] eq '') {
           @cr = ( $cr[1], "" );
    	}

        #my $no_name = "NN";
        @cr = map { $_ eq "" ? $no_name : $_ } @cr;
    	my $cr = join("/", @cr);
    	return $cr;
    }

    my @c_street;
    my $unique_cityparts;
    for my $c (@c) {
	my($street, @cityparts) = Strasse::split_street_citypart($c);
	my $cityparts = join(", ", @cityparts);
	if (!defined $unique_cityparts) {
	    $unique_cityparts = $cityparts;
	} elsif ($cityparts ne $unique_cityparts) {
	    return join("/", @c);
	}
	push @c_street, $street;
    }
    return join("/", @c_street) . ($unique_cityparts ne "" ? " ($unique_cityparts)" : "");
}

# XXX This could be refactored and partially go to Route::Heavy
sub lost_time {
    my($r, $tb, $velocity_kmh) = @_;
    return if $tb->{type} ne 'handicap';
    my $lost_time_s = 0;
    my $ms = kmh2ms($velocity_kmh);
    my(@path) = $r->path_list;
    for(my $i = 0; $i < $#path; $i++) {
	my($x1, $y1) = @{$path[$i]};
	my($x2, $y2) = @{$path[$i+1]};
	my $cat = $tb->{net}{Net}{"$x1,$y1"}{"$x2,$y2"};
	if ($cat && $handicap_speed{$cat}) {
	    my $handicap_speed_ms = kmh2ms($handicap_speed{$cat});
	    if ($handicap_speed_ms < $ms) {
		my $len = Strassen::Util::strecke([$x1,$y1],[$x2,$y2]);
		my $normal_time = $len / $ms;
		my $handicapped_time = $len / $handicap_speed_ms;
		$lost_time_s += ($handicapped_time - $normal_time);
	    }
	}
    }
    my $lost_time_string_de = "";
    if ($lost_time_s >= 5) {
	my $rounded_lost_time_s = $lost_time_s;
	my $mod;
	if ($lost_time_s < 55) {
	    $mod = 15;
	} else {
	    $mod = 60;
	}
	$rounded_lost_time_s += $mod/2;
	$rounded_lost_time_s /= $mod;
	$rounded_lost_time_s = int $rounded_lost_time_s;
	$rounded_lost_time_s *= $mod;
	if ($rounded_lost_time_s < 60) {
	    $lost_time_string_de = sprintf "Zeitverlust ca. %d Sekunden", $rounded_lost_time_s;
	} else {
	    my $rounded_lost_time_min = int($rounded_lost_time_s/60);
	    $lost_time_string_de = sprintf "Zeitverlust ca. %d Minute%s", $rounded_lost_time_min, $rounded_lost_time_min==1?"":"n";
	}
    }
    if (!$lost_time_s) {
	$lost_time_string_de = "kein Zeitverlust zu erwarten";
    } elsif ($lost_time_s < 5) {
	$lost_time_string_de = "kaum Zeitverlust";
    }
    return { lost_time_s         => $lost_time_s,
	     lost_time_string_de => $lost_time_string_de,
	   };
}

# XXX This could be refactored and partially go to Route::Heavy
sub diff_from_old_route {
    my($r) = @_;
    my $diff = { different => 1, old_session_not_found => 1 };
    return $diff if !$q->param('oldcs');
    my $sess = tie_session($q->param('oldcs'));
    return $diff if !$sess; # could not find old coords session, assume old one was different
    delete $diff->{old_session_not_found};
    my @path = $r->path_list;
    my $old_r = Route->new_from_cgi_string($sess->{routestringrep});
    my @old_path = $old_r->path_list;
    my $len = $r->len;
    my $old_len = $old_r->len;
    if (int($old_len) == int($len)) {
	$diff->{difference} = "(" . M("kein Unterschied in der Entfernung") . ")";
    } elsif (abs($old_len - $len) < 20) {
	$diff->{difference} = "(" . M("unbedeutender Unterschied in der Entfernung") . ")";
    } elsif ($old_len < $len) {
	$diff->{difference} = sprintf "(".M("um %d Meter l�nger").")", int($len - $old_len);
    } elsif ($old_len >= $len) {
	$diff->{difference} = sprintf "(".M("um %d Meter k�rzer").")", int($old_len - $len);
    }
    return $diff if @path != @old_path;
    for my $i (0 .. $#path) {
	return $diff if $path[$i][0] != $old_path[$i][0];
	return $diff if $path[$i][1] != $old_path[$i][1];
    }
    $diff->{different} = 0;
    return $diff;
}

sub experimental_label {
    qq{<span class="experimental">} . M("Experimentell") . qq{</span>};
}

# Make sure the supplied "data" coordinates are converted to wgs84
# coordinates
sub convert_data_to_wgs84 {
    my($x,$y) = @_;
    if ($data_is_wgs84) {
	($x,$y);
    } else {
	$require_Karte->() if $require_Karte;
	$Karte::Polar::obj->trim_accuracy($Karte::Polar::obj->standard2map($x,$y));
    }
}

# Make sure the supplied wgs84 coordinates are converted to "data"
# coordinates
sub convert_wgs84_to_data {
    my($x,$y) = @_;
    if ($data_is_wgs84) {
	($x,$y);
    } else {
	$require_Karte->() if $require_Karte;
	$Karte::Standard::obj->trim_accuracy($Karte::Polar::obj->map2standard($x,$y));
    }
}

# Is this a real street, which might is reportable via newstreetform?
sub _is_real_street {
    my $street = shift;
    require PLZ;
    # XXX hack: get_street_type needs a look result
    my $look_result = [];
    $look_result->[PLZ::LOOK_NAME()] = $street;
    # XXX hack: should get_street_type be callable as a static method?
    my $type = PLZ->get_street_type($look_result);
    $type eq 'street' || $type eq 'projected street';
}

######################################################################
#
# Information
#
sub show_info {
    http_header(@weak_cache);
    header(-from => 'info');
    my $perl_url = "http://www.perl.org/";
    my $cpan = "http://www.cpan.org/";
    my $scpan = "http://search.cpan.org/search?mode=module&amp;query=";
    print <<EOF;
<center><h2>Information</h2></center>
<ul>
 <li><a href="#tipps">Die Routensuche</a>
 <li><a href="#data">Daten</a>
 <li><a href="#link">Link auf BBBike setzen</a>
 <li><a href="#resourcen">Weitere M�glichkeiten mit BBBike</a>
  <ul>
   <li><a href="#perltk">Perl/Tk-Version</a>
   <li><a href="#beta">Beta-Version</a>
<!--   <li><a href="#pda">PDA-Version</a>-->
   <li><a href="#wap">WAP</a>
   <li><a href="#iphone">iPhone</a>
   <li><a href="#gpsupload">GPS-Upload</a>
   <li><a href="#opensearch">Suchplugin f�r Firefox und IE</a>
@{[ $can_palmdoc ? qq{<li><a href="#palmexport">Palm-Export</a>} : qq{} ]}
   <li><a href="#googlemaps">BBBike auf Google Maps</a>
  </ul>
 <li><a href="@{[ $bbbike_html ]}/presse.html">Die Presse �ber BBBike</a>
 <li><a href="http://bbbike.sourceforge.net/bbbike/doc/links.html">Links</a>
 <li><a href="#hardsoftware">Hard- und Softwareinformation</a>
 <li><a href="#disclaimer">Disclaimer</a>
 <li><a href="#autor">Kontakt</a>
</ul>
<hr>

<h3 id="tipps">Die Routensuche</h3>
Das Programm sucht den k�rzesten oder schnellsten Weg zwischen den gew�hlten Berliner Stra�en. Die Auswahl erfolgt entweder durch das Eintippen
in die Eingabefelder f�r Start und Ziel (Via ist optional), durch Auswahl
aus der Buchstabenliste oder durch Auswahl �ber die Berlin-Karte.
Stra�ennamen m�ssen nicht v�llig korrekt eingegeben werden. Gro�- und
Kleinschreibung wird ignoriert.
<p>
Bei der Suche wird auf Einbahnstra�en und zeitweilig gesperrte Stra�en
geachtet; auf Steigungen und Verkehrsdichte (noch) nicht. Stra�en mit
schlechter Oberfl�che und/oder Hauptstra�en k�nnen geringer bewertet oder
von der Suche ganz ausgeschlossen werden.
<p>
<!-- XXX not yet
Wozu werden die Sucheinstellungen verwendet?
<dl>
 <dt>Bevorzugte Geschwindigkeit
 <dd>
 <dt>Bevorzugter Stra�entyp
 <dd>
 <dt>Bevorzugter Stra�enbelag
 <dd>
 <dt>Ampeln vermeiden
 <dd>
 <dt>Gr�ne Wege bevorzugen
 <dd>
</dl>
-->
EOF
    print
      "Falls die " . complete_link_to_einstellungen() . " ",
      "f�r BikePower ausgef�llt wurden, ",
      "kann mit der " . link_to_met() . "aktuellen Windgeschwindigkeit</a> die ",
      "Fahrzeit anhand von drei Leistungsstufen (50&nbsp;W, 100&nbsp;W und 200&nbsp;W) ",
      "berechnet werden.<p>\n";
    print <<EOF;
F�r die technisch Interessierten: als Suchalgorithmus wird
A<sup>*</sup> eingesetzt<sup> <a class="pseudolink" title="@{[ footnote(1) ]}" href="#footnote1">1</a></sup>.<p>
EOF

    print <<EOF;
<hr>
<h3 id="data">Daten</h3>

Die Daten auf dem aktuellen Stand zu halten ist in einer Stadt wie
Berlin f�r einen Einzelnen eine schwere Aufgabe. Deshalb freue ich
mich �ber Feedback: neue Stra�en, ver�nderte Gegebenheiten, sowohl in
Berlin als auch im Brandenburger Umland. Anregungen bitte als <a
href="mailto:$BBBike::EMAIL">Mail</a> schicken oder <a
href="$bbbike_html/newstreetform${newstreetform_encoding}.html?frompage=info">dieses Formular</a> benutzen.

<hr>
<h3 id="link">Link auf BBBike setzen</h3>
Man kann einen Link auf BBBike mit einem
bereits vordefinierten Ziel setzen. Die Vorgehensweise sieht so aus:
<ul>
 <li>Eine beliebige Route mit dem gew�nschten Zielort suchen lassen. Dabei
     darf die Auswahl f�r den Zielort nicht �ber die Berlin-Karte erfolgen,
     sondern der Zielort muss direkt eingegeben werden.
 <li>Wenn die Route gefunden wurde, klickt man den Link "Ziel beibehalten" an.
 <li>Die URL der neuen Seite kann nun auf die eigene Homepage aufgenommen werden. Die URL m�sste ungef�hr so aussehen:
<tt>$bbbike_url?zielname=Alexanderplatz;zielplz=10178;zielc=10923%2C12779</tt>
 <li>Auf Wunsch kann <tt>zielname</tt> ver�ndert werden. Beispielsweise:
<tt>$bbbike_url?zielname=Weltzeituhr;zielc=10923%2C12779</tt><br>
     Dabei sollte <tt>zielplz</tt> gel�scht werden. Wenn im Namen Leerzeichen
     vorkommen, m�ssen sie durch <tt>+</tt> ersetzt werden.
</ul>
F�r einen vordefinierten Startort geht man genauso vor, lediglich werden alle Vorkommen von <tt>ziel</tt> durch <tt>start</tt> ersetzt.

<!-- XXX DEL:
<h4 id="mambo">BBBike-Modul f�r Mambo</h4>
F�r das CMS Mambo gibt es auf mamboforge ein <a href="http://mamboforge.net/frs/?group_id=1094">BBBike-Modul</a> von Ramiro G&#243;mez.
-->
<hr>
<p>
EOF

    print <<EOF;
<h3 id="resourcen">Weitere M�glichkeiten und Tipps</h3>
<h4 id="perltk">Perl/Tk-Version</h4>
Es gibt eine wesentlich komplexere Version von BBBike mit interaktiver Karte, mehr Kontrollm�glichkeiten �ber die Routensuche, GPS-Anbindung und den kompletten Daten. Diese Version l�uft als normales Programm (mit Perl/Tk-Interface) unter Unix, Linux, Mac OS X und Windows.
<a href="@{[ $BBBike::BBBIKE_SF_WWW ]}">Hier</a>
bekommt man dazu mehr Informationen. Als Beispiel kann man sich
<a href="@{[ $BBBike::BBBIKE_SF_WWW ]}/screenshots.de.html">Screenshots</a> der Perl/Tk-Version angucken.
<p>
Die aktuellen Daten f�r die Perl/Tk-Version k�nnen <a href="@{[ $BBBike::BBBIKE_UPDATE_DATA_CGI ]}">hier</a> heruntergeladen werden oder �ber den Men�punkt <i>Einstellungen</i> &gt; <i>Daten-Update �ber das Internet</i> aus dem Programm heraus.
<p>
Der aktuellen Snapshot der Perl/Tk-Version kann <a href="@{[ $BBBike::BBBIKE_UPDATE_DIST_CGI ]}">hier</a> heruntergeladen werden. <b>Achtung</b>: es ist m�glich, dass die Snapshotversion nicht lauff�hig ist oder Fehler enth�lt.

<h4 id="beta">Beta-Version von bbbike.de</h4>
Zuk�nftige BBBike-Features k�nnen <a href="$bbbike2_url">hier</a> getestet werden.
<!--<h4 id="pda">PDA-Version f�r iPAQ/Linux</h4>
F�r iPAQ-Handhelds mit Familiar Linux gibt es eine kleine Version von BBBike: <a href="@{[ $BBBike::BBBIKE_SF_WWW ]}">tkbabybike</a>.
-->
<h4 id="wap">WAP</h4>
BBBike kann man per WAP-Handy unter der Adresse <a href="@{[ $BBBike::BBBIKE_WAP ]}">@{[ $BBBike::BBBIKE_WAP ]}</a> nutzen.
<p>
<h4 id="iphone">iPhone</h4>
Eine Anregung, wie man BBBike auf dem iPhone verwenden kann, findet man <a href="$bbbike_html/bbbike_tracks_iphone.html">hier</a>.
<h4 id="gpsupload">GPS-Upload</h4>
Es besteht die experimentelle M�glichkeit, sich <a href="@{[ $bbbike_url ]}?uploadpage=1">GPS-Tracks oder bbr-Dateien</a> anzeigen zu lassen.<p>
<h4 id="diplom">Diplomarbeit</h4>
Das Programm wird auch in <a href="@{[ $BBBike::DIPLOM_URL ]}">meiner Diplomarbeit</a> behandelt.<p>
EOF
    if ($bi->is_browser_version("Mozilla", 5)) {
	print <<EOF;
<script type="text/javascript"><!--
function addSidebar(frm) {
    if (window && window.sidebar && window.sidebar.addPanel &&
	typeof window.sidebar.addPanel == 'function') {
	var query = "";
	if (frm) {
	    var q = [];
	    if (frm.elements.start.value != "") {
		q[q.length] = "home=" + escape(frm.elements.start.value);
	    }
	    if (frm.elements.ziel.value != "") {
		q[q.length] = "goal=" + escape(frm.elements.ziel.value);
	    }
	    query = "?" + q.join("&");
	}
	window.sidebar.addPanel("BBBike", "$bbbike_html/bbbike_sidebar.html"+query, null);
    }
    return false;
}
// --></script>
<h4 id="opensearch">Suchplugin f�r Firefox und IE</h4>
Installation des <a href="$bbbike_html/opensearch/opensearch.html">Suchplugins</a>
<h4>Mozilla-Sidebar</h4>
<form name="bbbike_add_sidebar" action="#">
<a href="#" onclick="return addSidebar(document.forms.bbbike_add_sidebar)"><!-- img src="http://developer.netscape.com/docs/manuals/browser/sidebar/add-button.gif" alt="Add sidebar" border=0 -->Add sidebar</a>, dabei folgende Adressen optional als Default verwenden:<br>
<table>
<!-- 
<tr><td><img src="$bbbike_images/flag2_bl.gif" border=0 alt="Start"> Start:</td><td> <input size=10 name="start"></td></tr>
<tr><td><img src="$bbbike_images/flag_ziel.gif" border=0 alt="Ziel"> Ziel:</td><td> <input size=10 name="ziel"></td></tr>
-->
</table>
</form>
EOF
    }
    if ($can_palmdoc) {
	print <<EOF;
<h4 id="palmexport">Palm-Export</h4>
<p>F�r den PalmDoc-Export ben�tigt man auf dem Palm einen entsprechenden
Viewer, z.B.
<a href="http://www.freewarepalm.com/docs/cspotrun.shtml">CSpotRun</a>.
F�r eine komplette Liste kompatibler Viewer siehe auch
<a href="http://www.freewarepalm.com/docs/docs_software.shtml">hier</a>.
EOF
    }
    print <<EOF;
<h4 id="googlemaps">BBBike auf Google Maps</h4>
Noch in Entwicklung: 
BBBike-Routen auf <a href="bbbikegooglemap.cgi?mapmode=search;maptype=hybrid">Google Maps</a> suchen
EOF
    print "<hr><p>\n";

    print "<h3 id='hardsoftware'>Hard- und Software</h3>\n";
    # funktioniert nur auf dem CS-Server
    my $os;
    if (open(INFO, "/usr/INFO/Rechnertabelle")) {
	my $host;
	eval q{local $SIG{'__DIE__'};
	       require Sys::Hostname;
	       $host = Sys::Hostname::hostname();
	   };
	while(<INFO>) {
	    if (/^$host:/o) {
		print "Hardware: " . (split /:/)[2] . "<p>\n";
		$os = (split /:/)[3];
		last;
	    }
	}
	close INFO;
    }
    unless (defined $os or $^O eq 'MSWin32') {
	open UNAME, "-|" or exec qw(uname -sr);
	my $uname = <UNAME>;
	close UNAME;
	if ($uname) {
	    chomp($os = "$uname");
	}
    }
    # Config ist ungenau, weil perl evtl. f�r ein anderes Betriebssystem
    # compiliert wurde.
    unless (defined $os) {
	require Config;
        $os = "\U$Config::Config{'osname'} $Config::Config{'osvers'}\E";
    }

    my $cgi_date = '$Date: 2009/04/04 11:13:58 $';
    ($cgi_date) = $cgi_date =~ m{(\d{4}/\d{2}/\d{2})};
    $cgi_date =~ s{/}{-}g;
    my $data_date;
    for (@Strassen::datadirs) {
	if (my(@s) = stat "$_/.modified") {
	    my @l = localtime $s[9];
	    $data_date = sprintf "%04d-%02d-%02d", $l[5]+1900,$l[4]+1,$l[3];
	    last;
	}
    }
    $data_date = "unbekannt" if !defined $data_date;
    print <<EOF;
Version des Programms bbbike.cgi: $VERSION ($cgi_date)<br/>
Stand der Daten: $data_date<br/>
bbbike.cgi ist Bestandteil von <a href="$BBBike::BBBIKE_SF_WWW">BBBike</a> Release $BBBike::VERSION<br/><br/>
EOF

    if (defined $os) {
        print "Betriebssystem: $os\n";
        if ($os =~ /freebsd/i) {
	    print "<a href=\"http://www.freebsd.org/\"><img align=right src=\"";
	    print "http://www.freebsd.org/gifs/powerani.gif";
	    print "\" border=0 alt='FreeBSD'></a>";
	} elsif ($os =~ /linux/i) {
	    print "<a href=\"http://www.linux.org/\"><img align=right src=\"";
	    print "http://lwn.net/images/linuxpower2.png";
	    print "\" border=0 alt='Linux'></a>";
	    if (-e "/etc/debian_version" || -e "/etc/debian-release") {
		print "<a href=\"http://www.debian.org/\"><img align=right src=\"";
		print "http://www.debian.org/logos/openlogo-nd-25.png";
		print "\" border=0 alt='Debian'></a>";
	    }
	}
        print "<p>";
    }
    if (defined $ENV{'SERVER_SOFTWARE'}) {
	print "HTTP-Server: $ENV{'SERVER_SOFTWARE'}\n";
	if ($ENV{'SERVER_SOFTWARE'} =~ /apache/i) {
	    print "<a href=\"http://www.apache.org/\"><img align=right src=\"";
	    print "http://httpd.apache.org/apache_pb.gif";
	    print "\" alt=\"apache httpd\" border=0></a>";
	} elsif ($ENV{'SERVER_SOFTWARE'} =~ /lighttpd/i) {
	    print "<a href=\"http://www.lighttpd.net/\"><img align=right src=\"";
	    print "http://www.lighttpd.net/light_button.png";
	    print "\" alt=\"lighttpd\" border=0></a>";
	}
	print "<p>";
    }
    if ($ENV{SERVER_NAME} =~ /sourceforge/) {
	print <<EOF;
<A href="http://sourceforge.net"> <IMG align=right
src="http://sourceforge.net/sflogo.php?group_id=19142"
width="88" height="31" border="0" alt="SourceForge"></A><p>
EOF
    }

    print <<EOF;
Verwendete Software:
<ul>
<li><a href="$perl_url">perl $]</a><a href="$perl_url"><img border=0 align=right src="http://www.perlfoundation.org/attachment/perl_trademark/perl_powered-1.png" alt="Perl"></a>
<li>perl-Module:<a href="$cpan"><img border=0 align=right src="http://theoryx5.uwinnipeg.ca/images/cpan.jpg" alt="CPAN"></a>
<ul>
<li><a href="${scpan}CGI">CGI $CGI::VERSION</a>
EOF
    if (defined $Apache::VERSION) {
	print <<EOF;
<li><a href="${scpan}Apache">Apache $Apache::VERSION</a> (auch bekannt als <a href="http://perl.apache.org">mod_perl</a>)
EOF
    }
    print <<EOF;
<li><a href="${scpan}GD">GD</a> f�r das Erzeugen der GIF/PNG/JPEG-Grafik
<li><a href="${scpan}PDF::Create">PDF::Create</a> f�r das Erzeugen der PDF-Grafik
<li><a href="${scpan}SVG">SVG</a> f�r das Erzeugen von SVG-Dateien
<li><a href="${scpan}Storable">Storable</a> f�r das Caching
<li><a href="${scpan}String::Approx">String::Approx</a> f�r approximatives Suchen von Stra�ennamen (anstelle von <a href="ftp://ftp.cs.arizona.edu/agrep/">agrep</a>)
<li><a href="${scpan}XML::LibXML">XML::LibXML</a> (und libxml2) zum Parsen und Erzeugen von XML
EOF
    if ($can_palmdoc) {
	print <<EOF;
<li><a href="${scpan}Palm::PalmDoc">Palm::PalmDoc</a> f�r den PalmDoc-Export
EOF
    }
    print <<EOF;
<li>u.v.a.
</ul>
EOF
    if ($can_mapserver) {
        print <<EOF;
<li><a href="http://mapserver.gis.umn.edu/">Mapserver</a>
EOF
    }
    print <<EOF;
</ul>
<hr><p>
EOF

    if ($bi || eval { require BrowserInfo }) {
	print "<h3>Browserinformation</h3><pre>";
	$bi = BrowserInfo->new($q) if !$bi;
	print $bi->show_info();
	print "</pre><hr><p>\n";
    }

    print <<EOF;
<h3 id="disclaimer">Disclaimer</h3>
Es wird keine Gew�hr f�r die Inhalte dieser Site sowie verlinkter Sites �bernommen.
<hr>

EOF

    print <<EOF;
<h3 id="autor">Kontakt</h3>
<center>
Autor: Slaven Rezic<br>
<a href="mailto:@{[ $BBBike::EMAIL ]}?subject=BBBike">E-Mail:</a> <a href="mailto:@{[ $BBBike::EMAIL ]}?subject=BBBike">@{[ $BBBike::EMAIL ]}</a><br>
<a href="@{[ $BBBike::HOMEPAGE ]}">Homepage:</a> <a href="@{[ $BBBike::HOMEPAGE ]}">@{[ $BBBike::HOMEPAGE ]}</a><br>
Telefon: @{[ CGI::escapeHTML("+49-172-1661969") ]}<br>
Slaven Rezi&#x107; (Tomi&#x107;)<br>Donji Crna&#x10d;, BiH-88220 &#x160;iroki Brijeg<br>Seumestr. 31, 10245 Berlin<br>
</center>
<p>
EOF

    # XXX Wo geh�ren die Fu�noten am besten hin?
    print <<EOF;
<p><p><p><hr>
Fu�noten:<br>
<sup id="footnote1">1</sup> @{[ footnote(1) ]}<hr><p>
EOF

    footer();

    print $q->end_html;
    exit(0);
}

sub footnote {
    my($nr) = @_;
    if ($nr == 1) {
	<<EOF;
R. Dechter and J. Pearl, Generalized
best-first search strategies and the optimality of A<sup>*</sup>,
Journal of the Association for Computing Machinery, Vol. 32, No. 3,
July 1985, Seiten 505-536.
EOF
    } else {
	"";
    }
}


=head1 AUTHOR

Slaven Rezic <slaven@rezic.de>

=head1 COPYRIGHT

Copyright (C) 1998-2011 Slaven Rezic. All rights reserved.
This is free software; you can redistribute it and/or modify it under the
terms of the GNU General Public License, see the file COPYING.

=head1 SEE ALSO

bbbike(1).

=cut

1;
