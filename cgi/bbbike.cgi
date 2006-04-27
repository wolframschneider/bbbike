#!/usr/bin/env perl
## Use this shebang on cs.tu-berlin.de:
#!/usr/perl5/5.00503/bin/perl
#!/usr/local/bin/perl
# -*- perl -*-

#
# $Id: bbbike.cgi,v 8.12 2006/04/26 20:20:10 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 1998-2005 Slaven Rezic. All rights reserved.
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
    open(STDERR, ">/home/groups/b/bb/bbbike/bbbike.log")
	if $ENV{SERVER_NAME} =~ /sourceforge/ && -w "/home/groups/b/bb/bbbike";
    $^W = 1 if $ENV{SERVER_NAME} =~ /herceg\.de/i;
}
use vars qw(@extra_libs);
BEGIN { delete $INC{"FindBin.pm"} }
use FindBin;
BEGIN {
#     if ($ENV{SERVER_NAME} =~ /(radzeit\.de|radzeit.herceg.de)$/) {
# 	# Make it easy to switch between versions:
# 	if ($FindBin::Script =~ /bbbike2/) {
# 	    @extra_libs =
# 		("$FindBin::RealBin/../BBBike2",
# 		 "$FindBin::RealBin/../BBBike2/lib",
# 		);
# 	} else {
# 	    @extra_libs =
# 		("$FindBin::RealBin/../BBBike",
# 		 "$FindBin::RealBin/../BBBike/lib",
# 		);
# 	}
#     } else
    {
	# Achtung: evtl. ist auch ~/lib/ f�r GD.pm notwendig (z.B. CS)
	@extra_libs =
	    (#"/home/e/eserte/src/bbbike",
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
use BBBikeUtil qw(is_in_path min max);
use BBBikeCGIUtil;
use File::Basename qw(dirname);
use CGI;
use CGI::Carp; # Nur zum Debuggen verwenden --- manche Web-Server machen bei den kleinsten Kleinigkeiten Probleme damit: qw(fatalsToBrowser);
use BrowserInfo 1.47;
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
	    $comments_points $green_net
	    $crossings $kr $plz $net $multi_bez_str
	    $overview_map $city
	    $use_umland $use_umland_jwd $use_special_destinations
	    $use_fragezeichen $use_fragezeichen_routelist
	    $check_map_time $use_cgi_bin_layout
	    $show_weather $show_start_ziel_url @weather_cmdline
	    $bp_obj $bi $use_select
	    $graphic_format $use_mysql_db $use_exact_streetchooser
	    $use_module
	    $cannot_gif_png $cannot_jpeg $cannot_pdf $cannot_svg $can_gif
	    $can_wbmp $can_palmdoc $can_gpx $can_berliner_stadtplan_post
	    $can_google_maps
	    $can_mapserver $mapserver_address_url
	    $mapserver_init_url $no_berlinmap $max_plz_streets $with_comments
	    $with_cat_display
	    $use_coord_link
	    @weak_cache @no_cache %proc
	    $bbbike_script $cgi $port
	    $search_algorithm $use_background_image
	    $use_apache_session $apache_session_module $cookiename
	    $bbbike_temp_blockings_file $bbbike_temp_blockings_optimized_file
	    @temp_blocking
	    $use_cgi_compress_gzip $max_matches
	    $use_winter_optimization
	    $with_fullsearch_radio
	    $with_lang_switch
	   );
# XXX This may be removed one day
use vars qw($use_cooked_street_data);

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

=head2 Imagemaps, graphic creation

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

=item $can_mapserver

Set this to a true value if mapserver can be used. Default: false. See
below for special mapserver variables.

=cut

$can_mapserver = 0;

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

$no_berlinmap = 0;

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
"Stadtplan" link. Default: true:

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

$VERBOSE = 0;

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

=back

=cut

# XXX document: # show max n matches in start form
$max_matches = 20;

####################################################################

unshift(@Strassen::datadirs,
	"$FindBin::RealBin/../data",
	"$FindBin::RealBin/../BBBike/data",
       );

use vars qw($lang $config_master $msg);
$config_master = $0;
$lang = "";
if ($config_master =~ s{^(.*)\.(en)(\.cgi)$}{$1$3}) {
    $lang = $2;
}
# XXX hier require verwenden???
eval { local $SIG{'__DIE__'};
       #warn "$config_master.config";
       do "$config_master.config" };

undef $msg;
if ($lang ne "") {
    $msg = eval { do "$FindBin::RealBin/msg/$lang" };
    if ($msg && ref $msg ne 'HASH') {
	undef $msg;
    }
}

sub M ($) {
    my $key = shift;
    $msg && exists $msg->{$key} ? $msg->{$key} : $key;
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

$VERSION = sprintf("%d.%02d", q$Revision: 8.12 $ =~ /(\d+)\.(\d+)/);

use vars qw($font $delim);
$font = 'sans-serif,helvetica,verdana,arial'; # also set in bbbike.css
$delim = '!'; # wegen Mac nicht � verwenden!

@weak_cache = ('-expires' => '+1d',
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

if (defined %Apache::) {
    # workaround for "use lib" problem with Apache::Registry
    'lib'->import(@extra_libs);
}

use vars qw($xgridwidth $ygridwidth $xgridnr $ygridnr $xm $ym $x0 $y0
	    $detailwidth $detailheight $nice_berlinmap $nice_abcmap
	    $start_bgcolor $via_bgcolor $ziel_bgcolor @pref_keys);
# Konstanten f�r die Imagemaps
# Die n�chsten beiden Variablen m�ssen auch in bbbike_start.js ge�ndert werden.
$xgridwidth = 20; # 20 * 10 = 200: Breite und H�he von berlin_small.gif
$ygridwidth = 20;
$xgridnr = 10;
$ygridnr = 10;
# Diese Werte (bis auf $ym) werden mit small_berlinmap.pl ausgegeben.
$xm = 228.58;
$ym = $xm;
$x0 = -10849;
$y0 = 34867;
## sch�n gro�, aber passt nicht auf Seite
#$detailwidth  = 600; # mu� quadratisch sein!
#$detailheight = 600;
$detailwidth  = 500; # mu� quadratisch sein!
$detailheight = 500;
$nice_berlinmap = 0;
$nice_abcmap    = 0;

$start_bgcolor = '';
$via_bgcolor   = '';
$ziel_bgcolor  = '';
if (!$use_background_image) {
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
		  );

@pref_keys = qw/speed cat quality ampel green winter fragezeichen/;

CGI->import('-no_xhtml');

$q = new CGI;
# XXX Hack for proxy_html problems on bbbike.radzeit.de
eval{BBBikeCGIUtil::encode_possible_utf8_params($q);};warn $@ if $@;

undef $g_str; # XXX because it may already contain landstrassen etc.
undef $net; # dito

#$str = new Strassen "strassen" unless defined $str;
#$str = new Strassen::Lazy "strassen" unless defined $str;
$cookiename = "bbbike";
#get_streets($use_umland_jwd ? "wideregion" : $use_umland ? "region" : "city");

# Maximale Anzahl der angezeigten Stra�en, wenn eine Auswahl im PLZ-Gebiet
# gezeigt wird.
$max_plz_streets = 25;

# die originale URL (f�r den Kaltstart)
$bbbike_url = BBBikeCGIUtil::my_url($q);
# Root-Verzeichnis und Bilder-Verzeichnis von bbbike
($bbbike_root = $bbbike_url) =~ s|[^/]*/[^/]*$|| if !defined $bbbike_root;
$bbbike_root =~ s|/$||; # letzten Slash abschneiden
if (!defined $bbbike_images) {
    $bbbike_images = "$bbbike_root/" . ($use_cgi_bin_layout ? "BBBike/" : "") .
	"images";
}
if (!defined $bbbike_html) {
    $bbbike_html   = "$bbbike_root/" . ($use_cgi_bin_layout ? "BBBike/" : "") .
	"html";
}
$is_beta = $bbbike_url =~ m{bbbike\d\.cgi}; # bbbike2.cgi ...
$bbbike2_url = $bbbike_url;
if (!$is_beta) {
    $bbbike2_url =~ s{bbbike\.cgi}{bbbike2.cgi};
}

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
    $mapdir_url = "http://" . $q->server_name . ($q->server_port != 80 ? ":" . $q->server_port : "") . $mapdir_url;
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
    my $file = $q->param("tmp");
    $file =~ s{/+}{}g; # one leading slash is expected
    $file = $mapdir_fs . "/" . $file;
    my($ext) = $file =~ m{\.([^\.]+)$};
    http_header(-type => "image/$ext",
		@no_cache);
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

undef $bp_obj;
init_bikepower($q);

use vars qw($wettermeldung_file);
$wettermeldung_file = "$tmp_dir/wettermeldung-$<";
# Wettermeldungen so fr�h wie m�glich versuchen zu holen
if ($show_weather || $bp_obj) {
    start_weather_proc();
}

$q->delete('Dummy');
$smallform = $q->param('smallform') || $bi->{'mobile_device'};
$got_cookie = 0;
%c = ();

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
    }
}

if (defined $q->param('movemap')) {
    my $move = $q->param('movemap');
    my($x, $y) = ($q->param('detailmapx'),
		  $q->param('detailmapy'));
    if    ($move =~ /^nord/i) { $y-- }
    elsif ($move =~ /^s�d/i)  { $y++ }
    if    ($move =~ /west$/i) { $x-- }
    elsif ($move =~ /ost$/i)  { $x++ }
    $q->delete('detailmapx');
    $q->delete('detailmapy');
    $q->delete('movemap');
    draw_map('-x' => $x,
	     '-y' => $y);
    goto REQUEST_DONE;
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
    require Karte;
    Karte::preload("Standard", "Polar");
    # Ob die alte ...x...-Syntax noch unterst�tzt wird, ist fraglich...
    my($long,$lat) = ($ll =~ /^[\+\ ]/
		      ? $ll =~ /^[\+\-\ ]([0-9.]+)[\+\-\ ]([0-9.]+)/
		      : split(/x/, $ll)
		     );
    if (defined $long && defined $lat) {
	local $^W;
	my($x, $y) = $Karte::Polar::obj->map2standard($long, $lat);
	new_kreuzungen(); # XXX needed in munich, here too?
	$q->param($what . "c", get_nearest_crossing_coords($x,$y));
    }
};

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
if (defined $q->param('startpolar')) {
    $set_anyc->($q->param('startpolar'), "start");
}
if (defined $q->param('zielpolar')) {
    $set_anyc->($q->param('zielpolar'), "ziel");
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
} elsif (defined $q->param('all')) {
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
    $local_route_file = "$local_route_dir/$local_route_file";
    open(FH, $local_route_file)
	or die "Can't open $local_route_file: $!";
    draw_route_from_fh(\*FH);
} elsif (defined $q->param('coords') || defined $q->param('coordssession')) {
    draw_route(-cache => []);
} elsif (defined $q->param('create_all_maps')) {
    # XXX Der Apache 1.3.9/FreeBSD 3.3 l�sst den Prozess nach
    # ungef�hr f�nf Karten mit "Profiling timer expired" sterben.
    # Mit thttpd gibt es zwar auch mysteri�se kills, aber es geht im
    # Gro�en und Ganzen.
    http_header(-type => 'text/plain',
		@no_cache,
	       );
    $| = 1;
    $check_map_time = 1;
    for my $x (0 .. 9) {
	for my $y (0 .. 9) {
	    print "x=$x y=$y ...\n";
	    draw_map('-x' => $x,
		     '-y' => $y,
		     '-quiet'    => 1,
		     '-logging'  => 1,
		     '-strlabel' => 1,
		     '-force'    => 0,
		    );
	}
    }
    my_exit(0);
} elsif (defined $q->param('startchar')) {
    choose_ch_form($q->param('startchar'), 'start');
} elsif (defined $q->param('viachar')) {
    choose_ch_form($q->param('viachar'), 'via');
} elsif (defined $q->param('zielchar')) {
    choose_ch_form($q->param('zielchar'), 'ziel');
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
	  (defined $q->param('startc') and $q->param('startc') ne ''))
	 and
	 ((defined $q->param('zielname')  and $q->param('zielname')  ne '')
	  or
	  (defined $q->param('zielc') and $q->param('zielc') ne ''))
	 and
	 via_not_needed()
	) {
    get_kreuzung();
} elsif (defined $q->param('browser')) {
    show_user_agent_info();
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
    undef $plz;
    undef $net;
    undef $multi_bez_str;
}

my_exit 0;

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

    } else {
	print "<input type=image name=" . $type
	  . "charimg src=\"$bbbike_images/abc.gif\" class=\"charmap\" alt=\"A..Z\">";
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

sub _potsdam_hack {
    my $street = shift;
    my $potsdam_file = "$tmp_dir/" . $Strassen::Util::cacheprefix . "_" . $< . "_potsdam_strassen";
    my $potsdam_str = eval { Strassen->new($potsdam_file) };
    if (!$potsdam_str) {
	$potsdam_str = Strassen->new;
	my $landstr = Strassen->new("landstrassen");
	$landstr->init;
	while(1) {
	    my $r = $landstr->next;
	    last if !@{ $r->[Strassen::COORDS] };
	    if ($r->[Strassen::NAME] =~ /\s+\(Potsdam\)/) {
		$potsdam_str->push($r);
	    }
	}
	$potsdam_str->write($potsdam_file);
    }
    my $pos = $potsdam_str->choose_street($street, "Potsdam");
    my $name;
    if (defined $pos) {
	$name = $potsdam_str->get($pos)->[Strassen::NAME];
	my $scope = $q->param("scope");
	if (!$scope || $scope eq "city") {
	    $q->param("scope", "region"); # XXX increment_scope?
	}
    }
    $name;
}

sub choose_form {
    my $startname = $q->param('startname') || '';
    my $start2    = $q->param('start2')    || '';
    my $start     = $q->param('start')     || '';
    my $startplz  = $q->param('startplz')  || '';
    my $starthnr  = $q->param('starthnr')  || '';
    my $startc    = $q->param('startc')    || '';

    my $vianame   = $q->param('vianame')   || '';
    my $via2      = $q->param('via2')      || '';
    my $via       = $q->param('via')       || '';
    my $viaplz    = $q->param('viaplz')    || '';
    my $viahnr    = $q->param('viahnr')    || '';
    my $viac      = $q->param('viac')      || '';

    my $zielname  = $q->param('zielname')  || '';
    my $ziel2     = $q->param('ziel2')     || '';
    my $ziel      = $q->param('ziel')      || '';
    my $zielplz   = $q->param('zielplz')   || '';
    my $zielhnr   = $q->param('zielhnr')   || '';
    my $zielc     = $q->param('zielc')     || '';

    my $nl = sub {
	if ($bi->{'can_table'}) {
	    print "<tr><td>&nbsp;</td></tr>\n";
	} else {
	    print "<p>\n";
	}
    };
    my $tbl_center = sub {
	my $text = shift;
	my $align = shift || "center";
	if ($bi->{'can_table'}) {
	    print "<tr><td colspan=4 align=$align>$text</td></tr>\n";
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
    my($startort, $viaort, $zielort,
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

    foreach ([\$startname, \$start2, \$startort, \$startortc, 'start'],
	     [\$vianame,   \$via2,   \$viaort,   \$viaortc,   'via'],
	     [\$zielname,  \$ziel2,  \$zielort,  \$zielortc,  'ziel'],
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
		if ($bezirk eq "Potsdam") {
		    my $name = _potsdam_hack($strasse);
		    if ($name) {
			$$nameref = $name;
			$q->param($type . 'plz', $plz);
		    }
		} else {
		    my $str = get_streets();
		    my $pos = $str->choose_street($strasse, $bezirk);
		    if (!defined $pos) {
			if ($str->{Scope} eq 'city') {
			    warn "Enlarge streets for umland\n" if $debug;
			    $q->param("scope", "region");  # XXX increment_scope?
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
	     (defined $startort  && $startort ne '')) &&
	    ((defined $zielname  && $zielname ne '') ||
	     (defined $zielort   && $zielort ne ''))) {
	    last TRY if (((defined $via2 && $via2 ne '') ||
			  (defined $via  && $via  ne '' && $via ne 'NO')) &&
			 ((!defined $vianame || $vianame eq '') &&
			  (!defined $viaort  || $viaort eq '')));

	    foreach ([\$startort, \$startortc, \$startname, 'start'],
		     [\$viaort,   \$viaortc,   \$vianame,   'via'],
		     [\$zielort,  \$zielortc,  \$zielname,  'ziel']) {
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
		warn "W�hle Kreuzung f�r $startname und $zielname\n"
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
	} elsif ($bi->is_browser_version("MSIE", 5.0, 5.4999)) {
	    $nice_berlinmap = $nice_abcmap = 1;
	} elsif ($bi->is_browser_version("Opera", 7.0, 7.9999)) { # Mit 8.x wird nur einmalig beim Enter gehighlighted $nice_berlinmap = $nice_abcmap = 1;
	    $prefer_png = 1;
	} elsif ($bi->is_browser_version("Konqueror", 3.0, 3.9999)) { # andere nicht getestet
	    $nice_berlinmap = $nice_abcmap = 0;
	    $prefer_png = 1;
	}
    }

    my(@start_matches, @via_matches, @ziel_matches);
 MATCH_STREET:
    foreach ([\$startname,\$start,\$start2,\@start_matches,'start',\$startplz],
	     [\$vianame,  \$via,  \$via2,  \@via_matches,  'via',  \$viaplz],
	     [\$zielname, \$ziel, \$ziel2, \@ziel_matches, 'ziel', \$zielplz],
	    ) {
	my  (  $nameref,  $oneref,$tworef, $matchref,      $type,  $zipref)=@$_;
	local $^W = 0; # too many defined checks missing...

	# Darstellung eines Vias nicht erw�nscht
	next if ($type eq 'via' and $$oneref eq 'NO');

	# �berpr�fen, ob eine Stra�e in PLZ vorhanden ist.
	if ($$nameref eq '' && $$oneref ne '') {
	    if (!$plz) {
		$plz = init_plz();
	    }
	    if (!$plz) {
		# Notbehelf. PLZ sollte m�glichst installiert sein.
		my $str = get_streets();
		my @res = $str->agrep($$oneref);
		if (@res) {
		    $$nameref = $res[0];
		}
		next;
	    }

	    warn "Suche $$oneref in der PLZ-DB.\n" if $debug;

	    # check for given crossings
	    my $crossing_street;
	    # XXX is it OK to change the referred value?
	    ($$oneref, $crossing_street) = Strasse::split_crossing($$oneref);

	    my @extra;
	    if ($$zipref ne '') {
		push @extra, Citypart => $$zipref;
	    }
	    next if $$oneref =~ /^\s*$/;
	    $$oneref = PLZ::norm_street($$oneref);
	    my($retref, $matcherr) =
		$plz->look_loop(PLZ::split_street($$oneref),
				@extra,
				Max => $max_plz_streets,
				MultiZIP => 1, # introduced because of Hauptstr./Friedenau vs. Hauptstr./Sch�neberg problem
				MultiCitypart => 1, # works good with the new combine method
				Agrep => 'default');
	    @$matchref = grep { defined $_->[PLZ::LOOK_COORD()] && $_->[PLZ::LOOK_COORD()] ne "" } @$retref;
	    # XXX needs more checks, but seems to work good
	    # except in the cases, where the same street has different coordinates
	    # see Ackerstr. Mitte/Wedding
	    # solution: use multi_bez_str!
	    @$matchref = map { $plz->combined_elem_to_string_form($_) } $plz->combine(@$matchref);

	    if (@$matchref == 0) {
		# Nichts gefunden. In der Pl�tze-Datei nachschauen.
		if (my $platz = new Strassen "plaetze") {
		    warn "Suche $$oneref in der Pl�tze-Datei.\n" if $debug;
		    my @res = $platz->agrep($$oneref);
		    if (@res) {
			my $ret = $platz->get_by_name($res[0]);
			if ($ret) {
			    $$nameref = $res[0];
			    $q->param($type . 'c', $ret->[1][0]);
			}
		    }
		}

		if (@$matchref == 0 && !defined $$nameref) {
		    # Noch immer ohne Erfolg. In der Strassen-Datei
		    # nachschauen, weil einige Stra�en nicht in der PLZ-Datei
		    # stehen.
		    warn "Suche $$oneref in der Stra�en-Datei.\n" if $debug;
		    my $str = get_streets();
		    my @res = $str->agrep($$oneref);
		    if (@res) {
			my $ret = $str->get_by_name($res[0]);
			if ($ret) {
			    $$nameref = $res[0];
			    $q->param($type . 'c', $ret->[1][0]);
			}
		    }
		}

		next;
	    }

	    # If this is a crossing, then get the exact point, but don't fail
	    if (defined $crossing_street) {
		# first: get all matching Strasse objects (first part)
		my $rx = "^" . join("|", map { quotemeta($_->[&PLZ::LOOK_NAME]) } @$matchref);
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
					$$nameref = join("/", @{$crossings->{$c}});
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
		my @orte = $multiorte->agrep($$oneref, Agrep => $matcherr);
		if (@orte) {
		    use constant MATCHREF_ISORT_INDEX => 4;
		    push @$matchref, map { [$_, undef, undef, undef, 1] } @orte;
		}
	    }

	    if (@$matchref == 1) {
		my($strasse, $bezirk) = ($matchref->[0][0],
					 $matchref->[0][1]);
		warn "W�hle $type-Stra�e f�r $strasse/$bezirk (2nd)\n"
		    if $debug;
		if ($bezirk eq "Potsdam") {
		    my $name = _potsdam_hack($strasse);
		    if ($name) {
			$$nameref = $name;
			$q->param($type . 'plz', $matchref->[0][2]);
		    } else {
			$$tworef = join($delim, @{ $matchref->[0] });
		    }
		} else {
		    my $str = get_streets();
		    my $pos = $str->choose_street($strasse, $bezirk);
		    if (!defined $pos) {
			if ($str->{Scope} eq 'city') {
			    warn "Enlarge streets for umland\n" if $debug;
			    $q->param("scope", "region");  # XXX increment_scope?
			    $str = get_streets_rebuild_dependents(); # XXX maybe wideregion too?
			}
			$pos = $str->choose_street($strasse, $bezirk);
		    }
		    if (defined $pos) {
			$$nameref = $str->get($pos)->[0];
			$q->param($type . 'plz', $matchref->[0][2]);
		    } else {
			$$tworef = join($delim, @{ $matchref->[0] });
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
	    warn "W�hle Kreuzung f�r $startname und $zielname\n"
	      if $debug;
	    get_kreuzung($startname, $vianame, $zielname);
	    return;
	}
    }

    my %header_args = @weak_cache;
    $header_args{-expires} = '+1d';
    http_header(%header_args);
    my @extra_headers;
    if ($bi->{'text_browser'} && !$bi->{'mobile_device'}) {
	push @extra_headers, -up => $BBBike::HOMEPAGE;
    }
    my $onloadscript = "";
    if ($nice_berlinmap || $nice_abcmap) {
	$onloadscript .= "init_hi(); window.onResize = init_hi; "
    }
    if ($nice_berlinmap || $nice_abcmap) {
	push @extra_headers, -onLoad => $onloadscript,
	     -script => [{-src => $bbbike_html . "/bbbike_start.js?v=1.11"},
			 ($nice_berlinmap
			  ? {-code => qq{set_bbbike_images_dir('$bbbike_images')}}
			  : ()
			 ),
			],
    }
    my $show_introduction;
    {
	local $^W = 0;
	$show_introduction = ($start eq ''  && $ziel eq '' &&
			      $start2 eq '' && $ziel2 eq '' &&
			      $startname eq '' && $zielname eq '' &&
			      $startc eq '' && $zielc eq '' &&
			      !$smallform);
    }
    header(@extra_headers, -from => $show_introduction ? "chooseform-start" : "chooseform");

    print <<EOF if ($bi->{'can_table'});
<table>
<tr>
EOF

    if ($show_introduction) {
	load_teaser();
	# use "make count-streets" in ../data
	print <<EOF if ($bi->{'can_table'});
<td valign="top">@{[ blind_image(420,1) ]}<br>
EOF
	my($bln_str, $all_bln_str, $pdm_str) = (5200, 10000, 180);
	# XXX Use format number to get a comma in between.
	if ($lang eq 'en') {
	    print <<EOF;
This is a route planner for cyclists in Berlin.
Of the $all_bln_str streets in Berlin more than $bln_str are available for searching, also
$pdm_str streets in Potsdam. If a street is not available, then the
nearest crossing will be used automatically. There is no support
for street numbers.
EOF
	} else {
	    print <<EOF;
Dieses Programm sucht (Fahrrad-)Routen in Berlin.
Es sind ca. $bln_str von $all_bln_str Berliner Stra&szlig;en
sowie ca. $pdm_str Potsdamer Stra&szlig;en erfasst (alle Hauptstra&szlig;en und wichtige
Nebenstra&szlig;en). Bei nicht erfassten Stra�en wird automatisch die
n�chste bekannte verwendet. Hausnummern k&ouml;nnen nicht angegeben werden.<br><br>
EOF
	}
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
            print "&nbsp;" . M("Start- und Zielstra&szlig;e der Route ausw&auml;hlen");
	    unless ($via eq 'NO') { print " (" . M("Via ist optional") . ")" }
	    print ": <p>\n";
        }

	print "</td></tr><tr>" if ($bi->{'can_table'});

    }

    print "<td>" if ($bi->{'can_table'});
    print "<form action=\"$bbbike_script\" name=BBBikeForm>\n";

    # Hack for browsers which use the first button, regardless whether it's
    # image or button, for firing in a <Return> event
    # XXX Does not work for Opera, Safari and MSIE are untested...
    if ($bi->{user_agent_name} =~ /^(konqueror|safari|opera|msie)/i) {
	print <<EOF;
<input type="submit" value="@{[ M("Weiter") ]}" style="text-align:center;visibility:hidden"/>
EOF
    }

    print "<table id=inputtable>\n" if ($bi->{'can_table'});

    foreach
      ([\$startname, \$start, \$start2, \$startort, \@start_matches, 'start',
	$start_bgcolor],
       [\$vianame,   \$via,   \$via2,   \$viaort,   \@via_matches,   'via',
	$via_bgcolor],
       [\$zielname,  \$ziel,  \$ziel2,  \$zielort,  \@ziel_matches,  'ziel',
	$ziel_bgcolor]) {
	my($nameref,  $oneref, $tworef,  $ortref,    $matchref,       $type,
	   $bgcolor) = @$_;
	my $bgcolor_s = $bgcolor ne '' ? "bgcolor=$bgcolor" : '';
	my $coord     = $q->param($type . "c");
	my $has_init_map_js;

	# Darstellung eines Vias nicht erw�nscht
	if ($type eq 'via' and $$oneref eq 'NO') {
	    print "<input type=hidden name=via value=NO>";
	    next;
	}

	my $printtype = ucfirst($type);
	my $imagetype = "$bbbike_images/" . M($type) . "." . ($prefer_png ? "png" : "gif");
	my $tryempty  = 0;
	my $no_td     = 0;

	if ($bi->{'can_table'}) {
	    print qq{<tr id=${type}tr $bgcolor_s><td align=center valign=middle width=40><a name="$type"><img } . (!$bi->{'css_buggy'} ? qq{style="padding-bottom:8px;" } : "") . qq{src="$imagetype" border=0 alt="} . M($printtype) . qq{"></a></td>};
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
		print "$$nameref\n";
	    }
	    print "<input type=hidden name=" . $type
	      . "name value=\"$$nameref\">\n";
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

	} elsif (defined $$ortref and $$ortref ne '') {
	    print "<td valign=middle>$fontstr" if $bi->{'can_table'};
	    print "$$ortref\n";
	    print "<input type=hidden name=" . $type . "2 value=\""
		  . $$tworef . "\">\n";
	    print "</td>" if $bi->{'can_table'};
	    print "<input type=hidden name=" . $type . "isort value=1>\n";
	} elsif ($$oneref ne '' && @$matchref == 0) {
	    print "<td>$fontstr" if $bi->{'can_table'};
	    print "<i>$$oneref</i> " . M("ist nicht bekannt") . ".<br>\n";
	    my $qs = CGI->new({strname => $$oneref})->query_string;
	    print qq{<a target="newstreetform" href="$bbbike_html/newstreetform.html?$qs">} . M("Diese Stra�e eintragen") . qq{</a><br>\n};
	    $no_td = 1;
	    $tryempty = 1;
	} elsif ($$tworef ne '') {
	    my($strasse, $bezirk, $plz, $xy) = split(/$delim/o, $$tworef);
	    print "<td>$fontstr" if $bi->{'can_table'};
	    if (defined $xy) {
		new_kreuzungen();
		my($best) = get_nearest_crossing_coords(split(/,/, $xy));
		my $cr = crossing_text(defined $best ? $best : $xy);
		my $qs = CGI->new({strname => $strasse,
				   bezirk => $bezirk,
				   plz => $plz,
				   coord => $xy,
				  })->query_string;
		my $report_nearest = $strasse !~ /^[su]-bhf/i;
		if ($report_nearest) {
		    print qq{<i>$strasse</i> } . M("ist nicht bekannt") . qq{ (<a target="newstreetform" href="$bbbike_html/newstreetform.html?$qs">} . M("diese Stra�e eintragen") . qq{</a>).<br>\n};
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
		print "<label><input onclick='set_street_in_berlinmap(\"$type\", $out_i);' type=radio name=" . $type . "2";
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
		print " value=\"$strasse2val\"";
		if (!$checked) {
		    print " checked";
		    $checked++;
		}
		print "> $s->[0]";
		if (defined $s->[1] && defined $s->[2]) {
		    print " (<font size=-1>$s->[1]" . ($s->[2] ne "" ? ", $s->[2]" : "") . "</font>)";
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
	    print "<input type=text name=$type>";
	    if ($use_mysql_db) {
		print "&nbsp;<input type=text name=${type}hnr size=4>";
	    }
	    print "<br>";
	    if (!$smallform) {
		if ($with_fullsearch_radio) {
		    fullsearch_radio();
		}

		abc_link($type, -nice => 1);

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

		print "</td><td>" if $bi->{'can_table'};
		if ($nice_berlinmap && !$no_berlinmap) {
		    print "<input type=hidden name=\"" . $type . "mapimg.x\" value=\"\">";
		    print "<input type=hidden name=\"" . $type . "mapimg.y\" value=\"\">";
		    print "<div id=" . $type . "mapbelow style=\"position:relative;visibility:hidden;\">";
		    print "<img src=\"$bbbike_images/berlin_small.gif\" border=0 width=200 height=200 alt=\"\">";
		    print "</div>";
		    print "<div id=" . $type . "mapabove style=\"position:absolute;visibility:hidden;\">";
		    print "<img src=\"$bbbike_images/berlin_small_hi.gif\" border=0 width=200 height=200 alt=\"\">";
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
		      . "mapimg src=\"$bbbike_images/berlin_small.gif\" class=\"citymap\" alt=\"\">";
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
	    print "<td width=40>&nbsp;</td></tr>\n";
	} else {
	    print "<p>\n";
	}
    }
    $nl->();

    hidden_smallform();

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
	$tbl_center->($button_str);
    }

    print "</table>\n" if $bi->{'can_table'};

    print "<input type=hidden name=scope value='" .
	(defined $q->param("scope") ? $q->param("scope") : "") . "'>";

    print "</form>\n";
    print "</td></tr></table>\n" if $bi->{'can_table'};

    print "<hr>";

    if (!$smallform) {
	print window_open("$bbbike_script?all=1", "BBBikeAll",
			  "dependent,height=500,resizable," .
			  "screenX=500,screenY=30,scrollbars,width=250")
	    . M("Liste aller bekannten Stra&szlig;en") . "</a> (ca. 100 kB)";
	print "<hr>";
    }

    print footer_as_string();

    print $q->end_html;
}

sub berlinmap_with_choices {
    my($type, $matchref) = @_;
    print "<div id=${type}mapbelow style=\"position:relative;visibility:hidden;\">";
    print "<img src=\"$bbbike_images/berlin_small.gif\" border=0 width=200 height=200 alt=\"\">";
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
	print <<EOF;
<div id="$divid" style="position:absolute; visibility:show;">$a_start<img id="$matchimgid" src="$bbbike_images/bluedot.png" border=0 width=8 height=8 alt="$s->[0] ($s->[1])">$a_end</div>
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
    my($search_char, $search_type) = @_;
    my $use_javascript = ($bi->{'can_javascript'} &&
			  !$bi->{'javascript_incomplete'});
    my $printtype = ucfirst($search_type);

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
    print " (" . M("Anfangsbuchstabe") . " <b>$search_char</b>)<br>\n";
    my $next_char =
      (ord($search_char) < ord('Z') ? chr(ord($search_char)+1) : undef);
    my $prev_char =
      (ord($search_char) > ord('A') ? chr(ord($search_char)-1) : undef);
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
    {
	my $str = get_streets();
	$str->init;
	eval q{ # eval wegen /o
	    while(1) {
	        my $ret = $str->next;
	        last if !@{$ret->[1]};
	        my $name = $ret->[0];
	        push(@strlist, $name) if $name =~ /$regex_char/oi;
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
		    push(@strlist, $name);
		}
	    }
	};
    };
    warn $@ if $@;

    @strlist = sort @strlist;

    print
      "<label><input type=radio name=" . $search_type . "name value=\"\"" ,
      ($use_javascript ? " onclick=\"document.Charform.submit()\"" : ""),
      "> ",
      ($use_javascript ? "(" . M("Zur�ck zum Eingabeformular") . ")" : "(" . M("nicht gesetzt") . ")"),
      "</label><br>\n";

    my $last_name;
    for(my $i = 0; $i <= $#strlist; $i++) {
	my $name = $strlist[$i];
	if (defined $last_name and $name eq $last_name) {
	    next;
	} else {
	    $last_name = $name;
	}
	print
	  "<label><input type=radio name=" . $search_type . "name value=\"$name\"",
	  ($use_javascript ? " onclick=\"document.Charform.submit()\"" : ""),
	  "> ",
	  $name,
	  "</label><br>\n";
    }

    print "<br>";
    if (!$use_javascript) {
	print qq{<input type=submit value="} . M("Weiter") . qq{ &gt;&gt;"><br><br>\n};
    }
    print M("andere") . " " . M($printtype . "stra&szlig;e") . ":<br>\n";
    abc_link($search_type);
    footer();
    print "<input type=hidden name=scope value='" .
	(defined $q->param("scope") ? $q->param("scope") : "") . "'>";
    print "</form>\n";
    print $q->end_html;
}

sub get_kreuzung {
    my($start_str, $via_str, $ziel_str) = @_;
    if (!defined $start_str) {
	$start_str = $q->param('startname');
    }
    if (!defined $via_str) {
	$via_str = $q->param('vianame');
    }
    if (defined $via_str && $via_str =~ /^\s*$/) {
	undef $via_str;
    }
    if (!defined $ziel_str) {
	$ziel_str  = $q->param('zielname');
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
	warn "Fehler: Start <$start_str/position $start> und/oder Ziel <$ziel_str/position $ziel> k�nnen nicht zugeordnet werden.<br>\n";
	# Mostly this error comes from mistyped user input, so try to do
	# the best and redirect to the start page:
	$q->param('start', $start_str);
	$q->param('via', $via_str);
	$q->param('ziel', $ziel_str);
	$q->delete($_) for (qw(startname vianame zielname));
	return choose_form();
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
    $header_args{-script} = {-src => $bbbike_html . "/bbbike_result.js",
			    };
    header(%header_args);

    if ((!$start_c && @start_coords != 1) ||
	(!$ziel_c  && @ziel_coords != 1) ||
	(@via_coords && !$via_c)) {
	print M("Genaue Kreuzung angeben") . ":<p>\n";
    }

    all_crossings();

    print "<form action=\"$bbbike_script\">";

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
	if (defined $c) {
	    print "<input type=hidden name=" . $type . "c value=\"$c\">";
	}
	if (defined $c and (not defined $strname or $strname eq '')) {
	    print crossing_text($c) . "<br>\n";
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
	if (!defined $c) {
	    my $i = 0;
	    my %used;
	    my $ecke_printed = 0;
	    foreach (@coords) {
		unless ($ecke_printed) {
		    if ($use_select) {
			print " " . M("Ecke") . " ";
			if ($bi->{'can_table'}) {
			    print "</td><td>";
			}
			print "<select $bi->{hfill} name=" . $type . "c>";
		    } else {
			print " " . M("Ecke") . " ...<br>\n";
		    }
		    $ecke_printed++;
		}
		if ($used{$_}) {
		    next;
		} else {
		    $used{$_}++;
		}
		if (exists $crossings->{$_}) {
		    if ($use_select) {
			print "<option value=\"$_\">";
		    } else {
			print
			  "<input type=radio name=" . $type . "c ",
			  "value=\"$_\"";
			if ($i++ == 0) {
			    print " checked";
			}
			print "> ";
		    }
		    my @kreuzung;
		    foreach (@{$crossings->{$_}}) {
			if ($_ ne $strname) {
			    push(@kreuzung, $_);
			}
		    }
		    if (@kreuzung == 0) {
			print "..."; # XXX bessere Loesung?
		    } else {
			print join("/", map { Strasse::strip_bezirk($_) } @kreuzung);
		    }
		    print "<br>" unless $use_select;
		    print "\n";
		}
	    }
	    print "</select>" if $use_select && $ecke_printed;

#XXX
#  	    my $img_url = crossing_map($type, \@coords);
#  	    if ($img_url) {
#  		print "<img src=\"$img_url\">";
#  	    }
	}
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
      -expires => '+1y',
      -path => dirname(BBBikeCGIUtil::my_url($q, -absolute => 1)),
     ),
     $q->cookie
     (-name => $cookiename,
      -value => $href,
      -expires => '+1y',
      -path => BBBikeCGIUtil::my_url($q, -absolute => 1),
     ),
    ];
}

use vars qw($default_speed $default_cat $default_quality
	    $default_ampel $default_routen $default_green $default_winter
	    $default_fragezeichen);

sub get_settings_defaults {
    get_global_cookie();

    $default_speed   = (defined $c{"pref_speed"} && $c{"pref_speed"} != 0 ? $c{"pref_speed"}+0 : $speed_default);
    $default_cat     = (defined $c{"pref_cat"}     ? $c{"pref_cat"}     : "");
    $default_quality = (defined $c{"pref_quality"} ? $c{"pref_quality"} : "");
    $default_ampel   = (defined $c{"pref_ampel"} && $c{"pref_ampel"} eq 'yes' ? 1 : 0);
    $default_routen  = (defined $c{"pref_routen"}  ? $c{"pref_routen"}  : "");
    $default_green   = (defined $c{"pref_green"}   ? $c{"pref_green"}   : "");
    # Backward compatibility:
    if ($default_green eq 'yes') {
	$default_green = 2;
    }
    $default_winter   = (defined $c{"pref_winter"}   ? $c{"pref_winter"}   : "");
    $default_fragezeichen = (defined $c{"pref_fragezeichen"} ? $c{"pref_fragezeichen"} : "");
}

sub reset_html {
    if ($bi->{'can_javascript'}) {
	my(%strcat)    = ("" => 0, "N1" => 1, "N2" => 2, "H1" => 3, "H2" => 4);
	my(%strqual)   = ("" => 0, "Q0" => 1, "Q2" => 2);
	my(%strrouten) = ("" => 0, "RR" => 1);
	my(%strgreen)  = ("" => 0, "GR1" => 1, "GR2" => 2);
	my(%strwinter) = ("" => 0, "WI1" => 1, "WI2" => 2);

	get_settings_defaults();

	print <<EOF
<input class="settingsreset" type=button value="Reset" onclick="reset_form(@{[defined $default_speed ? $default_speed : "null" ]}, @{[defined $strcat{$default_cat} ? $strcat{$default_cat} : 0]}, @{[defined $strqual{$default_quality} ? $strqual{$default_quality}: 0]}, @{[defined $strrouten{$default_routen} ? $strrouten{$default_routen} : 0]}, @{[ $default_ampel?"true":"false" ]}, @{[defined $strgreen{$default_green} ? $strgreen{$default_green} : 0]}, @{[defined $strwinter{$default_winter} ? $strwinter{$default_winter} : 0]}); enable_settings_buttons(); return false;">
EOF
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
</select></td></tr>
<tr><td>@{[ M("Bevorzugter Stra�enbelag") ]}:</td><td><select $bi->{hfill} name="pref_quality">
<option @{[ $qual_checked->("") ]}>@{[ M("egal") ]}
<option @{[ $qual_checked->("Q2") ]}>@{[ M("Kopfsteinpflaster vermeiden") ]}
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
    print <<EOF;
<tr><td>@{[ M("Ampeln vermeiden") ]}:</td><td><input type=checkbox name="pref_ampel" value=yes @{[ $default_ampel?"checked":"" ]}></td>
<tr><td>@{[ M("Gr�ne Wege") ]}:</td><td><select $bi->{hfill} name="pref_green">
<option @{[ $green_checked->("") ]}>@{[ M("egal") ]}
<option @{[ $green_checked->("GR1") ]}>@{[ M("bevorzugen") ]}
<option @{[ $green_checked->("GR2") ]}>@{[ M("stark bevorzugen") ]} <!-- expr? -->
</select></td></tr>
EOF
    if ($use_winter_optimization) {
	print <<EOF;
<tr>
 <td>@{[ M("Winteroptimierung") ]}</td><td><select $bi->{hfill} name="pref_winter" @{[ $bi->{'can_javascript'} ? "onchange='enable_settings_buttons()'" : "" ]}>
<option @{[ $winter_checked->("") ]}>@{[ M("nein") ]}
<option @{[ $winter_checked->("WI1") ]}>@{[ M("schwach") ]}
<option @{[ $winter_checked->("WI2") ]}>@{[ M("stark") ]}
</select></td>
 <td style="vertical-align:bottom"><span class="experimental">@{[ M("Experimentell") ]}</span><small><a target="BBBikeHelp" href="$bbbike_html/help.html#winteroptimization" onclick="show_help('winteroptimization'); return false;">@{[ M("Was ist das?") ]}</a></small></td>
</tr>
EOF
    }
    if ($use_fragezeichen) {
	print <<EOF;
<tr>
 <td>@{[ M("Unbekannte Stra�en mit einbeziehen") ]}:</td>
 <td><input type=checkbox name="pref_fragezeichen" value=yes @{[ $default_fragezeichen?"checked":"" ]}></td>
 <td style="vertical-align:bottom"><small><a target="BBBikeHelp" href="$bbbike_html/help.html#fragezeichen" onclick="show_help('fragezeichen'); return false;">@{[ M("Was ist das?") ]}</a></small></td>
</tr>
EOF
    }
    print <<EOF;
</table>
EOF
}

sub suche_button {
    if ($bi->{'can_javascript'}) {
	print qq{<input type=button value="&lt;&lt; } . M("Zur�ck") . qq{" onclick="history.back(1);">&nbsp;&nbsp;};
    }
    print qq{<input type=submit value="} . M("Route zeigen") . qq{ &gt;&gt;">\n};
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
			     );
	} else {
	    # XXX �berpr�fen, ob sich der Cache lohnt...
	    # evtl. mit IPC::Shareable arbeiten (Server etc.)
	    $net->make_net(UseCache => 1);
	    if (!$lite) {
		$net->make_sperre('gesperrt',
				  Type => [qw(einbahn sperre wegfuehrung)]);
	    }
	}
    }
    $net;
}

sub search_coord {
    my $startcoord  = $q->param('startc');
    my $viacoord    = $q->param('viac');
    my $zielcoord   = $q->param('zielc');
    my $startname   = name_from_cgi($q, 'start');
    my $vianame     = name_from_cgi($q, 'via');
    my $zielname    = name_from_cgi($q, 'ziel');
    my $starthnr    = $q->param('starthnr');
    my $viahnr      = $q->param('viahnr');
    my $zielhnr     = $q->param('zielhnr');
    my(@custom)     = $q->param('custom');
    my %custom      = map { ($_ => 1) } @custom;
    my $output_as   = $q->param('output_as');
    my $printmode   = defined $output_as && $output_as eq 'print';

    my $printwidth  = 400;

    make_netz();

    ($startcoord, $viacoord, $zielcoord)
      = fix_coords($startcoord, $viacoord, $zielcoord);

    my $scope = $q->param("scope") || "city";

    my $via_array = (defined $viacoord && $viacoord ne ''
		     ? [$viacoord]
		     : []);

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

    my @penalty_subs;

    my $disable_other_optimizations = 0;

    # Winteroptimierung
    if (defined $q->param('pref_winter') && $q->param('pref_winter') ne '') {
	if ($use_winter_optimization) {
	    require Storable;
	    my $penalty;
	    for my $try (1 .. 2) {
		for my $dir ("$FindBin::RealBin/../tmp", @Strassen::datadirs) {
		    my $f = "$dir/winter_optimization.st";
		    if (-r $f && -s $f) {
			$penalty = Storable::retrieve($f);
			last;
		    }
		}
		if (!$penalty) {
		    if ($try == 2) {
			die "Can't find winter_optimization.st in @Strassen::datadirs and cannot build...";
		    } else {
			system("$FindBin::RealBin/../miscsrc/winter_optimization.pl", "-one-instance");
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
	    $disable_other_optimizations = 1;
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

    # Handicap-Optimierung ...
    # Zurzeit nur Fu�g�ngerzonenoptimierung automatisch.
    # sowie Daten aus temp_blockings (wird unten ge-merge-t).
    # Diese Optimierung ist immer eingeschaltet, auch wenn die
    # Winteroptimierung aktiv ist (haupts�chlich wegen temp_blockings)
    if (1) {
	if (!$handicap_net) {
	    if ($scope eq 'region' || $scope eq 'wideregion') {
		$handicap_net =
		    new StrassenNetz(MultiStrassen->new("handicap_s",
							"handicap_l"));
	    } else {
		$handicap_net =
		    new StrassenNetz(Strassen->new("handicap_s"));
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
	my $penalty;
	if ($q->param('pref_quality') eq 'Q0') {
	    $penalty = { "Q0" => 1,
			 "Q1" => 1.2,
			 "Q2" => 1.6,
			 "Q3" => 2 };
	} else {
	    $penalty = { "Q0" => 1,
			 "Q1" => 1,
			 "Q2" => 1.5,
			 "Q3" => 1.8 };
	}
	$extra_args{Qualitaet} =
	    {Net => $qualitaet_net,
	     Penalty => $penalty,
	    };

    }

    # Kategorieoptimierung
    if (!$disable_other_optimizations && defined $q->param('pref_cat') && $q->param('pref_cat') ne '') {
	my $penalty;
	if ($q->param('pref_cat') eq 'N_RW') {
	    if (!$radwege_strcat_net) {
		my $str = get_streets();
		$radwege_strcat_net = new StrassenNetz $str;
		$radwege_strcat_net->make_net_cyclepath
		    (get_cyclepath_streets(),
		     'N_RW', UseCache => 0, # UseCache => 1 for munich
		    );
	    }
	    $penalty = { "H"    => 4,
			 "H_RW" => 1,
			 "N"    => 1,
			 "N_RW" => 1 };
	    $extra_args{RadwegeStrcat} =
		{Net => $radwege_strcat_net,
		 Penalty => $penalty,
		};
	} else {
	    if (!$strcat_net) {
		my $str = get_streets();
		$strcat_net = new StrassenNetz $str;
		$strcat_net->make_net_cat(-usecache => 0); # 1 for munich
	    }
	    if ($q->param('pref_cat') eq 'N2') {
		$penalty = { "B"  => 4,
			     "HH" => 4,
			     "H"  => 4,
			     "N"  => 1,
			     "NN" => 1 };
	    } elsif ($q->param('pref_cat') eq 'N1') {
		$penalty = { "B"  => 1.5,
			     "HH" => 1.5,
			     "H"  => 1.5,
			     "N"  => 1,
			     "NN" => 1 };
	    } elsif ($q->param('pref_cat') eq 'H1') {
		$penalty = { "B"  => 1,
			     "HH" => 1,
			     "H"  => 1,
			     "N"  => 1.5,
			     "NN" => 1.5 };
	    } elsif ($q->param('pref_cat') eq 'H2') {
		$penalty = { "B"  => 1,
			     "HH" => 1,
			     "H"  => 1,
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

    load_temp_blockings();

    my(%custom_s, @current_temp_blocking);
    {
	my $t = time;
	my $index = -1;
	for my $tb (@temp_blocking) {
	    $index++;
	    next if !$tb; # undefined entry
	    if (((!defined $tb->{from} || $t >= $tb->{from}) &&
		 (!defined $tb->{until} || $t <= $tb->{until})) ||
		(defined $q->param("test") && grep { /^(?:custom|temp)[-_]blocking/ } $q->param("test"))) {
		my $type = $tb->{type} || 'gesperrt';
		push @current_temp_blocking, $tb;
		$tb->{'index'} = $index;
	    }
	}
	if (@current_temp_blocking) {
	    push @Strassen::datadirs,
		"$FindBin::RealBin/../BBBike/data/temp_blockings",
		"$FindBin::RealBin/../data/temp_blockings",
		# XXX obsolete locations
		"$FindBin::RealBin/../BBBike/misc/temp_blockings",
		"$FindBin::RealBin/../misc/temp_blockings",
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
			my $type = $tb->{type} || 'gesperrt';
			push @{ $custom_s{$type} }, $strobj;
		    }
		} else {
		    $tb->{net} = StrassenNetz->new($strobj);
		    $tb->{net}->make_net_cat;
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

    my($r) = $net->search($startcoord, $zielcoord,
			  AsObj => 1,
			  %extra_args);

    if (defined $output_as && $output_as eq 'palmdoc') {
	require BBBikePalm;
	http_header
	    (-type => "application/x-palm-database",
	     -Content_Disposition => "attachment; filename=route.pdb",
	    );
	print BBBikePalm::route2palm(-net => $net, -route => $r,
				     -startname => $startname,
				     -zielname => $zielname);
	return;
    }

    if (defined $output_as && $output_as eq 'gpx-track') {
	require Strassen::GPX;
	http_header
	    (-type => "application/xml",
	     -Content_Disposition => "attachment; filename=track.gpx",
	    );
	my $s = Strassen->new_from_data("$startname - $zielname\tX " .
					join(" ", map { "$_->[0],$_->[1]" }
					     @{ $r->path }) . "\n");
	print $s->Strassen::GPX::bbd2gpx(-as => "track");
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
	@weather_res = gather_weather_proc();
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

		for my $s (@comment_files) {
		    eval {
			if ($s eq 'comments') {
			    push @s, MultiStrassen->new
				(map { "comments_$_" } grep { $_ ne "kfzverkehr" } @Strassen::Dataset::comments_types);
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
	    if (!$comments_points) {
		$comments_points = {};
		eval {
		    my $s = Strassen->new("gesperrt");
		    $s->init;
		    while(1) {
			my $rec = $s->next;
			last if !@{ $rec->[Strassen::COORDS] };
			if ($rec->[Strassen::CAT] =~ /^0(?::(\d+))?/) {
			    my $name = $rec->[Strassen::NAME];
			    if (defined $1) {
				my $verlust = $1;
				$name .= " (" . sprintf(M("ca. %s Sekunden Zeitverlust"), $verlust) . ")";
			    }
			    $comments_points->{$rec->[Strassen::COORDS][0]}
				= $name;
			}
		    }
		};
		warn $@ if $@;
	    }
	    @path = $r->path_list;
	}

	my($next_entf, $ges_entf_s, $next_winkel, $next_richtung);
	($next_entf, $ges_entf_s, $next_winkel, $next_richtung)
	    = (0, "", undef, "");

	my $ges_entf = 0;
	for(my $i = 0; $i <= $#strnames; $i++) {
	    my $strname;
	    my $etappe_comment = '';
	    my $fragezeichen_comment = '';
	    my $entf_s;
	    my $raw_direction;
	    my $route_inx;
	    my($entf, $winkel, $richtung)
		= ($next_entf, $next_winkel, $next_richtung);
	    ($strname, $next_entf, $next_winkel, $next_richtung,
	     $route_inx) = @{$strnames[$i]};
	    $strname = Strasse::strip_bezirk_perfect($strname, $city);
	    if ($i > 0) {
		if (!$winkel) { $winkel = 0 }
		$winkel = int($winkel/10)*10;
		if ($winkel < 30) {
		    $richtung = "";
		    $raw_direction = "";
		} else {
		    $raw_direction =
			($winkel <= 45 ? 'h' : '') .
			    ($richtung eq 'l' ? 'l' : 'r');
		    $richtung =
			($winkel <= 45 ? M('halb') : '') .
			    ($richtung eq 'l' ? M('links') : M('rechts')) .
				" ($winkel�) " . ($lang eq 'en' ? "-&gt;" : Strasse::de_artikel($strname));
		}
		$ges_entf += $entf;
		$ges_entf_s = sprintf "%.1f km", $ges_entf/1000;
		$entf_s = sprintf M("nach") . " %.2f km", $entf/1000;
	    } elsif ($#{ $r->path } > 1) {
		# XXX main:: ist haesslich
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
		    my @etappe_comment_objs = $comments_net->get_point_comment(\@path, $i, undef, AsObj => 1);
		    my %etappe_comments;
		    if (@etappe_comment_objs) {
			for (@etappe_comment_objs) {
			    (my $name = $_->[Strassen::NAME()]) =~ s/^.+?:\s+//; # strip street;
			    $_ = [$name, $_];
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
		    if (!exists $comments_in_whole_etappe{$_->[0]}) {
			my $cat = $_->[1]->[Strassen::CAT()];
			if (($cat =~ /^CP2/ && !exists $comments_at_beginning{$_->[0]}) ||
			    $cat !~ /^(CP2|PI|CP$|CP;)/) {
			    $_->[0] .= " (" . M("Teilstrecke") . ")";
			}
		    }
		}

		my @comments = map { $_->[0] } @comment_objs;

		for my $i ($strnames[$i]->[4][0] .. $strnames[$i]->[4][1]) {
		    my $point = join ",", @{ $path[$i] };
		    if (exists $comments_points->{$point}) {
			my $etappe_comment = $comments_points->{$point};
			# XXX not yet: problems with ... Sekunden Zeitverlust
			#if (!exists $seen_comments_in_this_etappe{$etappe_comment}) {
			push @comments, $etappe_comment;
			#} else {
			#} # XXX better solution for multiple point comments: use (2x), (3x) ...
		    }
		}
		$etappe_comment = join("; ", @comments) if @comments;
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

	    push @out_route, {
			      Dist => $entf,
			      DistString => $entf_s,
			      TotalDist => $ges_entf,
			      TotalDistString => $ges_entf_s,
			      Direction => $raw_direction,
			      DirectionString => $richtung,
			      Angle => $winkel,
			      Strname => $strname,
			      ($with_comments && $comments_net ?
			       (Comment => $etappe_comment) : ()
			      ),
			      ($has_fragezeichen_routelist ?
			       (FragezeichenComment => $fragezeichen_comment) : () # XXX key label may change!
			      ),
			      Coord => join(",", @{$r->path->[$route_inx->[0]]}),
			      PathIndex => $route_inx->[0],
			     };
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
			  Strname => $zielname,
			  Coord => join(",", @{$r->path->[-1]}),
			  PathIndex => $#{$r->path},
			 };
    }

 OUTPUT_DISPATCHER:
    if (defined $output_as && $output_as =~ /^(xml|yaml|yaml-short|perldump|gpx-route)$/ && $r && $r->path) {
	require Karte;
	Karte::preload(qw(Polar Standard));
	my $res = {
		   Route => \@out_route,
		   Len   => $r->len, # in meters
		   Trafficlights => $r->trafficlights,
		   Speed => \%speed_map,
		   Power => \%power_map,
		   ($sess ? (Session => $sess->{_session_id}) : ()),
		   Path => [ map { join ",", @$_ } @{ $r->path }],
		   LongLatPath => [ map {
		       join ",", $Karte::Polar::obj->trim_accuracy($Karte::Polar::obj->standard2map(@$_))
		   } @{ $r->path }],
		  };
	if ($output_as eq 'perldump') {
	    require Data::Dumper;
	    http_header
		(-type => "text/plain",
		 @no_cache,
		 -Content_Disposition => "attachment; filename=route.txt",
		);
	    print Data::Dumper->new([$res], ['route'])->Dump;
	} elsif ($output_as =~ /^yaml(.*)/) {
	    my $is_short = $1 eq "-short";
	    require YAML;
	    http_header
		(-type => "text/plain", # XXX text/yaml ?
		 @no_cache,
		 -Content_Disposition => "attachment; filename=route.yml",
		);
	    if ($is_short) {
		my $short_res = {LongLatPath => $res->{LongLatPath}};
		print YAML::Dump($short_res);
	    } else {
		print YAML::Dump($res);
	    }
	} elsif ($output_as eq 'gpx-route') {
	    require Strassen::GPX;
	    http_header
		(-type => "application/xml",
		 -Content_Disposition => "attachment; filename=route.gpx",
		);
	    my @data;
	    for my $pt (@out_route) {
		push @data, $pt->{Strname} . "\tX " . $pt->{Coord} . "\n";
	    }
	    my $s = Strassen->new_from_data(@data);
	    print $s->Strassen::GPX::bbd2gpx(-as => "route");
	} else { # xml
	    require XML::Simple;
	    http_header
		(-type => "text/xml",
		 @no_cache,
		 -Content_Disposition => "attachment; filename=route.xml",
		);
	    my $new_res = {};
	    while(my($k,$v) = each %$res) {
		if ($k eq 'Path' || $k eq 'LongLatPath') {
		    $new_res->{$k} = { XY => $v };
		} elsif ($k eq 'Route') {
		    $new_res->{$k} = { Point => $v };
		} else {
		    $new_res->{$k} = $v;
		}
	    }
	    print XML::Simple->new
		(NoAttr => 1,
		 RootName => "BBBikeRoute",
		 XMLDecl => "<?xml version='1.0' encoding='iso-8859-1' standalone='yes'?>",
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
    $header_args{-script} = {-src => $bbbike_html . "/bbbike_result.js",
			    };
    $header_args{-printmode} = 1 if $printmode;
    header(%header_args, -onLoad => "init_search_result()");

 ROUTE_HEADER:
    if (!@out_route) {
	print M("Keine Route gefunden").".\n";
    } else {
	if (@current_temp_blocking && !@custom && !$printmode) {
	    my @affecting_blockings;
	TEMP_BLOCKING:
	    for my $tb (@current_temp_blocking) {
		my(@path) = $r->path_list;
		for(my $i = 0; $i < $#path; $i++) {
		    my($x1, $y1) = @{$path[$i]};
		    my($x2, $y2) = @{$path[$i+1]};
		    if ($tb->{net}{Net}{"$x1,$y1"}{"$x2,$y2"}) {
			push @affecting_blockings, $tb;
			next TEMP_BLOCKING;
		    }
		}
	    }
	    if (@affecting_blockings) {
		my $hidden = "";
		foreach my $key ($q->param) {
		    $hidden .= $q->hidden(-name => $key,
					  -default => [$q->param($key)]);
		}
		print qq{<center><form name="Ausweichroute" action="} . BBBikeCGIUtil::my_self_url($q) . qq{" } . (@affecting_blockings > 1 ? qq{onSubmit="return test_temp_blockings_set()"} : "") . qq{>};
		print $hidden;
		print M("Ereignisse, die die Route betreffen k&ouml;nnen") . ":<br>";
		for my $tb (@affecting_blockings) {
		    print "<input type=\"" .
			(@affecting_blockings > 1 ? "checkbox" : "hidden") .
			    "\" name=\"custom\" value=\"temp-blocking-$tb->{'index'}\"> ";
		    print "$tb->{text}<br>";
		}
		print <<EOF;
$hidden
<input type=submit value="@{[ M("Ausweichroute suchen") ]}"><hr>
</form></center><p>
EOF
            }
	}
	if (@custom && !$printmode) {
	    print "<center>" . M("M�gliche Ausweichroute") . "</center>\n";
	}

    ROUTE_TABLE:
	print "<center>" unless $printmode;
	print qq{<table id="routehead" bgcolor="#ffcc66"};
	if ($printmode) {
	    print " width=$printwidth";
	}
	my $can_jslink = $can_mapserver && !$printmode && $bi->{'can_javascript'};
	print "><tr><td>${fontstr}" . M("Route von") . " <b>" .
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
	print M("bis") . " <b>" .
	    coord_or_stadtplan_link($zielname, $zielcoord,
				    $q->param('zielplz')||"",
				    $q->param('zielisort')?1:0,
				    (defined $zielhnr && $zielhnr ne '' ? $zielhnr : undef),
				    -jslink => $can_jslink,
				   )
		. "</b>$fontend</td></tr></table><br>\n";
	print "<table";
	if ($printmode) {
	    print " width=$printwidth";
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
	{
	    my $i = 0;
	    my @speeds = sort { $a <=> $b } keys %speed_map;
	    for my $speed (@speeds) {
		my $def = $speed_map{$speed};
		my $bold = $def->{Pref};
		my $time = $def->{Time};
		print "<td>$fontstr" . make_time($time + $ampel_lost/3600)
		    . "h (" . ($bold ? "<b>" : "") . M("bei")." $speed km/h" . ($bold ? "</b>" : "") . ")";
		print "," if $speed != $speeds[-1];
		print "$fontend</td>";
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
		print $fontstr,  make_time(($power_map{$power}->{Time} + $ampel_lost)/3600) . "h (" . M("bei") . " $power W)", $fontend, "</td>"
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
	    print " " . M("auf der Strecke") . " (" . M("in die Fahrzeit einbezogen") . ").$fontend<br>\n";
	}
	print "</center>\n" unless $printmode;
	print "<hr>";

	my $line_fmt;
	if (!$bi->{'can_table'}) {
	    $with_comments = 0;
	    if ($bi->{'mobile_device'}) {
		$line_fmt = "%s %s %s (ges.:%s)\n";
	    } else {
		$line_fmt = "%-13s %-24s %-31s %-8s";
		if ($has_fragezeichen_routelist && !$printmode) {
		    $line_fmt .= " %s";
		}
		$line_fmt .= "\n";
	    }
	    print "<pre>";
	} else {
	    # Ist width=... bei Netscape4 buggy? Das nachfolgende Attribut
	    # ignoriert font-family.
	    #   width=\"90%\"
	    print "<center>" unless $printmode;
	    print "<table class='routelist";
	    if ($printmode) {
		print " print";
	    }
	    print "' id='routelist' ";
	    if ($printmode) {
#		print ' style="border: 1px solid black;"';
#		print " border=1"; # XXX ohne geht's leider nicht
		print " width=$printwidth";
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

  	my $odd = 0;
	my $etappe_i = -1;
	for my $etappe (@out_route) {
	    $etappe_i++;
	    my($entf, $richtung, $strname, $ges_entf_s,
	       $etappe_comment, $fragezeichen_comment, $path_index) =
		   @{$etappe}{qw(DistString DirectionString Strname TotalDistString Comment FragezeichenComment PathIndex)};
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
					if ($rw_rec =~ /^RW([1234789])?$/) {
					    $rw = "RW";
					} elsif ($rw_rec eq 'RW5') {
					    $rw = "BS"; # Busspur
					} elsif ($rw_rec eq 'RW10') {
					    $rw = "NS"; # Nebenstra�e
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
			    my $cat_title = { NN => "Nebenstra�e ohne Kfz",
					      N  => "Nebenstra�e",
					      H  => "Hauptstra�e",
					      HH => "wichtige Hauptstra�e",
					      B  => "Bundesstra�e",
					      fz => "unbekannte Strecke",
					    }->{$cat};
			    my $rw_title;
			    if ($rw) {
				$rw_title = { RW => "Radweg/spur",
					      BS => "Busspur",
					      NS => "Nebenstra�e",
					    }->{$rw};
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
		    print "<td>$fontstr$etappe_comment$fontend</td>";
		}
		if ($has_fragezeichen_routelist && !$printmode) {
		    if ($fragezeichen_comment ne "") {

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
					  })->query_string;
			print qq{<td>$fontstr<a target="newstreetform" href="$bbbike_html/fragezeichenform.html?$qs">};
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
		my $qq = new CGI $q->query_string;
		$qq->param('output_as', "print");
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
		print qq{$cols" style="background-color:white; text-align:right;">};
		print
		    "<a title=Druckvorlage target=printwindow href=\"$bbbike_script?" . $qq->query_string . "\">" .
		    "<img src=\"$bbbike_images/printer.gif\" " .
		    "width=16 height=16 border=0 alt=Druckvorlage></a>";
		if ($can_palmdoc) {
		    my $qq2 = new CGI $q->query_string;
		    $qq2->param('output_as', "palmdoc");
		    my $href = $bbbike_script;
#XXX not needed anymore:
#		    if ($ENV{SERVER_SOFTWARE} !~ /Roxen/) {
#			# with Roxen there are mysterious overflow redirects...
#			$href .= "/route.pdb";
#		    }
		    print qq{<a style="padding:0 0.5cm 0 0.5cm;" href="$href?} . $qq2->query_string . qq{">PalmDoc</a>};
		}
		if ($can_gpx) {
		    {
			my $qq2 = new CGI $q->query_string;
			$qq2->param('output_as', "gpx-route");
			my $href = $bbbike_script;
			print qq{<a style="padding:0 0.5cm 0 0.5cm;" href="$href?} . $qq2->query_string . qq{">GPX (Route)</a>};
		    }
		    {
			my $qq2 = new CGI $q->query_string;
			$qq2->param('output_as', "gpx-track");
			my $href = $bbbike_script;
			print qq{<a style="padding:0 0.5cm 0 0.5cm;" href="$href?} . $qq2->query_string . qq{">GPX (Track)</a>};
		    }
		    print qq{<span class="experimental">} . M("Experimentell") . qq{</span>};
		}
		if (0) { # XXX not yet
		    my $qq2 = CGI->new({});
		    $qq2->param("query", $q->query_string);
		    my $href = "bbbike_comment.cgi";
		    print qq{<a target="BBBikeComment" style="padding:0 0.5cm 0 0.5cm;" href="$href?} . $qq2->query_string . qq{">Kommentar zur Route</a>};
		}
		print "</td></tr>";
	    }

	    print "</table>\n";
	    print "</center>\n" unless $printmode;
	}

	if ($printmode) {
	    print
	      "<hr><br>", $fontstr,
	      "BBBike by Slaven Rezic: ",
	      "<a href=\"$bbbike_url\">$bbbike_url</a><br>\n",
	      "<script type=\"text/javascript\"><!--\nprint();\n",
              "// --></script>\n";
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
	    my $post_bug = 1; # XXX f�r alle aktivieren
	    #$post_bug = 1 if ($kfm_bug); # XXX war mal nur f�r kfm
	    #print "<hr>";
	    print qq{<div class="box">};
	    print "<form name=showmap method=" .
		($post_bug ? "get" : "post");

	    my(%c) = %persistent;

	    my $default_imagetype = (defined $c{"imagetype"} ? $c{"imagetype"} : "png");
	    if (($default_imagetype eq 'jpeg' && $cannot_jpeg) ||
		($default_imagetype =~ /^pdf/ && $cannot_pdf) ||
		($default_imagetype =~ /^svg$/ && $cannot_svg)) {
		$default_imagetype = "";
	    }
	    my $default_print = (defined $c{"outputtarget"} && $c{"outputtarget"} eq 'print' ? 1 : 0);
	    my $default_geometry = (defined $c{"geometry"} ? $c{"geometry"} : "640x480");
	    my $default_draw = [];
	    for (0..99) {
		if (defined $c{"draw$_"}) {
		    push @$default_draw, $c{"draw$_"};
		} else {
		    last;
		}
	    }
	    if (!@$default_draw) {
		$default_draw = ["str", "title"];
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
	    print "<input type=hidden name=center value=''>\n";
#XXX not yet	    print "<input type=hidden name='as_attachment' value=''>\n";
	    print qq{<input type=submit name=interactive value="@{[ M("Karte zeigen") ]}"> <font size=-1>(@{[ M("neues Fenster wird ge&ouml;ffnet") ]})</font>};
	    print " <label><input type=checkbox name=outputtarget value='print' " . ($default_print?"checked":"") . "> " . M("f&uuml;r Druck optimieren") . "</label>";
#XXX not yet	    print " <input type=checkbox name='cb_attachment'> als Download";
	    print "&nbsp;&nbsp; <span class=nobr>" . M("Ausgabe als") . ": <select name=imagetype " . ($bi->{'can_javascript'} ? "onchange='enable_size_details_buttons()'" : "") . ">\n";
	    print " <option " . $imagetype_checked->("png") . ">PNG\n" if $graphic_format eq 'png';
	    print " <option " . $imagetype_checked->("gif") . ">GIF\n" if $graphic_format eq 'gif' || $can_gif;
	    print " <option " . $imagetype_checked->("jpeg") . ">JPEG\n" unless $cannot_jpeg;
	    print " <option " . $imagetype_checked->("wbmp") . ">WBMP\n" if $can_wbmp;
	    print " <option " . $imagetype_checked->("pdf-auto") . ">PDF\n" unless $cannot_pdf;
	    print " <option " . $imagetype_checked->("pdf") . ">PDF (" . M("L�ngsformat") . ")\n" unless $cannot_pdf;
	    print " <option " . $imagetype_checked->("pdf-landscape") . ">PDF (" . M("Querformat") . ")\n" unless $cannot_pdf;
	    print " <option " . $imagetype_checked->("svg") . ">SVG\n" unless $cannot_svg;
	    print " <option " . $imagetype_checked->("mapserver") . ">MapServer\n" if $can_mapserver;
	    print " <option " . $imagetype_checked->("berlinerstadtplan") . ">www.berliner-stadtplan.com\n" if $can_berliner_stadtplan_post;
	    print " <option " . $imagetype_checked->("googlemaps") . ">Google Maps (experimentell!!!)\n" if $can_google_maps;
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
		    print SESS Data::Dumper::Dumper({ date           => scalar(localtime),
						      time           => time,
						      routestringrep => $string_rep,
						      route          => \@out_route,
						      remote_ip      => $ENV{HTTP_X_FORWARDED_FOR} || $ENV{REMOTE_ADDR},
						    });
		    close SESS;
		}
		untie %$sess;
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
	    foreach my $geom ("400x300", "640x480", "800x600", "1024x768") {
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
	    printf M(<<EOF), 15, 50, 100, 400;
Die Dateigr&ouml;&szlig;e der Grafik betr�gt je nach
Bildgr&ouml;&szlig;e, Bildformat und Detailreichtum %s bis %s kB. PDFs sind %s bis %s kB gro�.
EOF
            print window_open("$bbbike_html/legende.html", "BBBikeLegende",
			      "dependent,height=392,resizable" .
			      "screenX=400,screenY=80,scrollbars,width=440")
		. M("Legende") . ".</a>\n";
	    print "</div>";
	}

	print "<input type=hidden name=scope value='" .
	    ($scope ne 'city' ? $scope : "") . "'>";
	print "</form>\n";
	print qq{</div>};

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
	print qq{<input type=submit value="} . M("Route mit ge&auml;nderten Einstellungen") . qq{">\n};
	print "</form>\n";
	print qq{</div>};

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
	print qq{</div>};

    }

    if (@weather_res) {
	my(@res) = @weather_res;
	print "<center><table border=0 bgcolor=\"#d0d0d0\">\n";
	print "<tr><td colspan=2>${fontstr}<b>" . link_to_met() . "Aktuelle Wetterdaten ($res[0], $res[1])</a></b>$fontend</td>";
	print "<tr><td>${fontstr}Temperatur:$fontend</td><td>${fontstr}$res[2] �C$fontend</td></tr>\n";
	print "<tr><td>${fontstr}Windrichtung:$fontend</td><td>${fontstr}$res[4]$fontend&nbsp;</td></tr>\n";
	my($kmh, $windtext);
	eval { local $SIG{'__DIE__'};
	       require Met::Wind;
	       $kmh      = Met::Wind::wind_velocity([$res[5], 'm/s'],
						    'km/h');
	       if ($kmh >= 5) {
		   $kmh = sprintf("%d",$kmh); # keine Pseudogenauigkeit, bitte
	       }
	       $windtext = Met::Wind::wind_velocity([$res[5], 'm/s'],
						    'text_de');
	   };
	print "<tr><td>${fontstr}Windgeschwindigkeit:$fontend</td><td>${fontstr}";
	if (defined $kmh) {
	    print "$kmh km/h";
	} else {
	    print "$res[5] m/s";
	}
	if (defined $windtext) {
	    print " ($windtext)";
	}
	print "$fontend</td></tr>\n";
	print "</table></center><hr>";
    }

    footer();

  END_OF_HTML:
    print $q->end_html;
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
    my $jslink = $args{-jslink};
    my $out = qq{<a };
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

    if (defined $q->param('coordssession') &&
	(my $sess = tie_session($q->param('coordssession')))) {
	$q->param(coords => $sess->{routestringrep});
	$route = $sess->{route};
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
					orte => "orte",
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

	my $scope = $q->param('scope');
	if (!defined $scope || $scope eq "") {
	    $scope = 'all,city' # "all", so switching between reference maps is possible
	}
	if ($scope !~ /^all/) {
	    $scope = "all,$scope";
	}
	my $has_center = (defined $q->param("center") && $q->param("center") ne "");
	if ($has_center) {
	    my $width  = $q->param("width");
	    my $height = $q->param("height");
	    if ($scope =~ /city/) {
		$q->param("width",  1000) if !defined $q->param("width");
		$q->param("height", 1000) if !defined $q->param("height");
	    } else {
		$q->param("width",  5000) if !defined $q->param("width");
		$q->param("height", 5000) if !defined $q->param("height");
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

    if (defined $q->param('imagetype') &&
	$q->param('imagetype') eq 'googlemaps') {
	my @wpt;
	if ($route) {
	    for my $wpt (@$route) {
		push @wpt, join "!", $wpt->{Strname}, $wpt->{Coord};
	    }
	}
	my $q2 = CGI->new({coords => $q->param("coords"),
			   wpt    => \@wpt});
	print $q->redirect($BBBike::BBBIKE_GOOGLEMAP_URL . "?" . $q2->query_string);
	return;
    }

    my @header_args = @cache;
    if ($cookie) { push @header_args, "-cookie", $cookie }

    # write content header for pdf as early as possible, because
    # output is already written before calling flush
    if (defined $q->param('imagetype') &&
	$q->param('imagetype') =~ /^pdf/) {
	http_header
	    (-type => "application/pdf",
	     @header_args,
	     -Content_Disposition => "inline; filename=bbbike.pdf",
	    );
	if ($q->param('imagetype') =~ /^pdf-(.*)/) {
	    $q->param('geometry', $1);
	    $q->param('imagetype', 'pdf');
	}
    }

    if (defined $q->param('imagetype') &&
	$q->param('imagetype') eq 'berlinerstadtplan') {
	$q->param("module", "BerlinerStadtplan");
    }

    if (defined $use_module) {
	$q->param("module", $use_module);
    }

    eval {
	local $SIG{'__DIE__'};
	require BBBikeDraw;
	BBBikeDraw->VERSION(2.26);
	$draw = BBBikeDraw->new_from_cgi($q,
					 MakeNet => \&make_netz
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
	     @header_args,
	     -Content_Disposition => "inline; filename=bbbike.".$draw->suffix,
	    );
    }

    $draw->pre_draw
	if $draw->can("pre_draw");
    $draw->draw_map    if $draw->can("draw_map");
    $draw->draw_wind   if $draw->can("draw_wind");
    $draw->draw_route  if $draw->can("draw_route");
    $draw->add_route_descr(-net => make_netz())
	if $draw->can("add_route_descr");
    $draw->flush;
}

sub draw_map {
    my(%args) = @_;
    my($part, @dim);
    my($x, $y);
    if (exists $args{'-x'} and exists $args{'-y'}) {
	($x, $y) = ($args{'-x'}, $args{'-y'});
	$part = sprintf("%02d-%02d", $x, $y);
	@dim  = xy_to_dim($x, $y);
    } else {
	die "No x/y set";
    }

    http_header(@weak_cache) unless $args{-quiet};

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

    if ($create) {
	$ext = $graphic_format;
	$set_img_name->();
    }

    if ($create || !-r $img_file || -z $img_file || !-r $map_file) {
	eval {
	    local $SIG{'__DIE__'};
	    require BBBikeDraw;
	    open(IMG, ">$img_file") or confess "Fehler: Die Karte $img_file konnte nicht erstellt werden.<br>\n";
	    chmod 0644, $img_file;
	    open(MAP, ">$map_file") or confess "Fehler: Die Map $map_file konnte nicht erstellt werden.<br>\n";
	    chmod 0644, $map_file;
	    $q->param('geometry', $detailwidth."x".$detailheight);
	    $q->param('draw', 'str', 'ubahn', 'sbahn', 'wasser', 'flaechen', 'orte', 'berlin');
	    $q->param('drawwidth', 1);
	    # XXX Argument sollte �bergeben werden (wird sowieso noch nicht
	    # verwendet, bis auf �berpr�fung des boolschen Wertes)
	    $q->param('strlabel', 'str:HH,H');#XXX if $args{-strlabel};
	    if (!$q->param('imagetype')) {
		if (!$can_gif) {
		    $q->param('imagetype', 'png');
		} else {
		    $q->param('imagetype', 'gif');
		}
	    }
	    if ($args{-module}) {
		$q->param('module', $args{-module});
	    } elsif ($detailmap_module) {
		$q->param('module', $detailmap_module);
	    }
	    my $draw = BBBikeDraw->new_from_cgi($q, Fh => \*IMG);
	    $draw->set_dimension(@dim);
	    $draw->create_transpose();
	    print "Create $img_file...\n" if $args{-logging};
	    $draw->draw_map();
	    if ($_create_imagemap) {
		$draw->make_imagemap(\*MAP);
	    }
	    $draw->flush();
	    $q->delete('draw');
	    $q->delete('geometry');
	    close MAP;
	    close IMG;
	};
	die __LINE__ . ": Warnung: $@<br>\n" if $@;
    }

    unless ($args{-quiet}) {

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
		print qq{<input type=submit name=movemap value="} . M("Nordwest") . qq{">};
	    }
	    print qq{</td><td align=center><input type=submit name=movemap value="} . M("Nord") . qq{"></td>\n};
	    if ($x < $xgridnr-1) {
		print qq{<td align=left><input type=submit name=movemap value="} . M("Nordost") . qq{"></td>};
	    }
	    print "</tr>\n";
	}

	# mittlere Zeile
	print "<tr><td align=right>";
	if ($x > 0) {
	    print qq{<input type=submit name=movemap value="} . M("West") . qq{">};
 	}
	print
	  "</td><td><input type=image title='' name=detailmap ",
	  "src=\"$img_url\" alt=\"\" border=0 ",
	  ($use_imagemap ? "usemap=\"#map\" " : ""),
	  "align=middle width=$detailwidth height=$detailheight>",
	  "</td>\n";
	if ($x < $xgridnr-1) {
	    print qq{<td align=left><input type=submit name=movemap value="} . M("Ost") . qq{"></td>};
 	}
	print "</tr>\n";

	# untere Zeile
	if ($y < $ygridnr-1) {
	    print "<tr><td align=right>";
	    if ($x > 0) {
		print qq{<input type=submit name=movemap value="} . M("S�dwest") . qq{">};
	    }
	    print qq{</td><td align=center><input type=submit name=movemap value="} . M("S�d") . qq{"></td>};
	    if ($x < $xgridnr-1) {
		print qq{<td align=left><input type=submit name=movemap value="} . M("S�dost") . qq{"></td>};
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
    }
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
    if ($g_str) {
	return $g_str
	    if (($scope eq 'city'       && $g_str->{Scope} eq 'city') ||
		($scope eq 'region'     && $g_str->{Scope} eq 'region') ||
		($scope eq 'wideregion' && $g_str->{Scope} eq 'wideregion')
	       );
    }
    my @f = ("strassen",
	     ($scope =~ /region/ ? "landstrassen" : ()),
	     ($scope eq 'wideregion' ? "landstrassen2" : ()),
	    );

    if (defined $q->param("pref_fragezeichen") && $q->param("pref_fragezeichen") eq 'yes') {
	push @f, "fragezeichen";
    }

    if ($q->param("addnet")) {
	for my $addnet ($q->param("addnet")) {
	    if ($addnet =~ /^(?:  )$/x) { # no addnet support for now
		push @f, $addnet;
	    }
	}
    }

    my $use_cooked_street_data = $use_cooked_street_data;
    while(1) {
	my @f = @f;
	if ($use_cooked_street_data) {
	    @f = map { $_ eq "fragezeichen" ? $_ : "$_-cooked" } @f;
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
		warn 'Maybe the "cooked" version is missing? Try again the normal version...';
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

sub init_plz {
    if (1) { # XXX introduce flag? (i.e. for other cities!!!)
	require PLZ::Multi;
	$plz = PLZ::Multi->new("Berlin.coords.data",
			       "Potsdam.coords.data",
			       Strassen->new("plaetze"), # because there are also some "sehenswuerdigkeiten" in
			       -cache => 1,
			      );
    } else {
	require PLZ;
	PLZ->VERSION(1.26);
	$plz = new PLZ;
    }
    $plz;
}

sub load_temp_blockings {
    if (!@temp_blocking && defined $bbbike_temp_blockings_file) {
	@temp_blocking = ();
	if (defined $bbbike_temp_blockings_optimized_file &&
	    -e $bbbike_temp_blockings_optimized_file &&
	    -M $bbbike_temp_blockings_optimized_file < -M $bbbike_temp_blockings_file) {
	    do $bbbike_temp_blockings_optimized_file;
	} else {
	    do $bbbike_temp_blockings_file;
	}
	if (!@temp_blocking) {
	    warn "Could not load $bbbike_temp_blockings_file/$bbbike_temp_blockings_optimized_file or file is empty: $@";
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
    all_crossings();
    if (exists $crossings->{$c}) {
	join("/", @{ $crossings->{$c} });
    } else {
	new_kreuzungen();
	my(@nearest) = $kr->nearest_coord($c);
	if (@nearest and exists $crossings->{$nearest[0]}) {
	    join("/", @{ $crossings->{$nearest[0]} });
	} else {
	    "???";
	}
    }
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

# falls die Koordinaten nicht exakt existieren, wird der n�chste Punkt
# gesucht und gesetzt
sub fix_coords {
    my($startcoord, $viacoord, $zielcoord) = @_;

    foreach my $varref (\$startcoord, \$viacoord, \$zielcoord) {
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
    ($startcoord, $viacoord, $zielcoord);
}

sub start_weather_proc {
    my(@stat) = stat($wettermeldung_file);
    if (!defined $stat[9] or $stat[9]+30*60 < time()) {
	my @weather_cmdline = (@weather_cmdline,
			       '-o', $wettermeldung_file);
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

# Write a HTTP header (always with Etag and Vary) and maybe enabled compression
sub http_header {
    my(@header_args) = @_;
## utf-8 experiments
#     my %header_args = @header_args;
#     if (!$header_args{"-type"}) {
# 	unshift @header_args, "-type" => "text/html;charset=utf-8";
#     }
    push @header_args, etag(), (-Vary => "User-Agent");
    if ($q->param("as_attachment")) {
	push @header_args, -Content_Disposition => "attachment;file=" . $q->param("as_attachment");
    }
    if ($use_cgi_compress_gzip &&
	eval { require CGI::Compress::Gzip;
	       CGI::Compress::Gzip->VERSION(0.16);
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
}

sub header {
    my(%args) = @_;
    my $from = delete $args{-from};
    if (!exists $args{-title}) {
	$args{-title} = "BBBike";
    }
    no strict;
    local *cgilink = ($CGI::VERSION <= 2.36
		      ? \&CGI::link
		      : \&CGI::Link);
    my $head = [];
    push @$head, $q->meta({-http_equiv => "Content-Script-Type",
			   -content => "text/javascript"});
    # XXX check the standards:
    push @$head, $q->meta({-name => 'revisit-after',
			   -content => "7 days"});
    push @$head, "<base target='_top'>"; # Can't use -target option here
    push @$head, cgilink({-rel  => "shortcut icon",
#  			  -href => "$bbbike_images/favicon.ico",
#  			  -type => "image/ico",
			  -href => "$bbbike_images/srtbike16.gif",
			  -type => "image/gif",
			 });
    if (!$smallform) {
	push @$head,
	    cgilink({-rel => 'Help',
		     -href => "$bbbike_script?info=1"}),
	    cgilink({-rel => 'Home',
		     -href => "$bbbike_script?begin=1"}),
	    cgilink({-rel => 'Start',
		     -href => "$bbbike_script?begin=1"}),
	    cgilink({-rel => 'Author',
		     -href => "mailto:@{[ $BBBike::EMAIL ]}"}),
	   (defined $args{-up}
	    ? cgilink({-rel => 'Up', -href => $args{-up}}) : ()),
		;
	if ($args{-contents}) {
	    push @$head, cgilink({-rel => 'Contents',
				  -href => $args{'-contents'}});
	}
    }
    delete @args{qw(-contents -up)};
    my $printmode = delete $args{-printmode};
    if ($bi->{'can_css'} && !exists $args{-style}) {
	$args{-style} = {-src => "$bbbike_html/" . ($printmode ? "bbbikeprint" : "bbbike") . ".css"};
#XXX del:
#  <<EOF;
#  $std_css
#  EOF
    }
    if (!$bi->{'can_javascript'}) {
	delete $args{-script};
	delete $args{-onload};
    }

    $args{-head} = $head if $head && @$head;

    if (!$smallform) {
	print $q->start_html
	    (%args,
	     -lang => 'de-DE',
	     -BGCOLOR => '#ffffff',
	     ($use_background_image && !$printmode ? (-BACKGROUND => "$bbbike_images/bg.jpg") : ()),
	     -meta=>{'keywords'=>'berlin fahrrad route bike karte suche cycling route routing routenplaner routenplanung fahrradroutenplaner radroutenplaner',
		     'copyright'=>'(c) 1998-2005 Slaven Rezic',
		    },
	     -author => $BBBike::EMAIL,
	    );
	if ($bi->{'css_buggy'}) {
	    print "<font face=\"$font\">";
	}
	print "<h1>\n";
	if ($printmode) {
	    print "$args{-title}";
	    print "<img alt=\"\" src=\"$bbbike_images/srtbike.gif\" hspace=10>";
	} else {
	    my $use_css = !$bi->{'css_buggy'};
	    my $title = $args{-title};
	    if ($is_beta) {
		$title = "BB<span style='font-style:italic;'>&#x03B2;</span>ike</a>";
	    }
	    print "<a href='$bbbike_url?begin=1' title='" . M("Zur�ck zur Hauptseite") . "' style='text-decoration:none; color:black;'>$title";
	    print "<img";
	    if ($use_css) {
		print ' style="position:relative; top:15px; left:-15px;"';
	    }
	    print " alt=\"\" src=\"$bbbike_images/srtbike.gif\" border=0>";
	    print "</a>";
	}
	print "</h1>\n";
    } else {
	print $q->start_html;
	print "<h1>BBBike</h1>";
    }
    if ($with_lang_switch && defined $from && $from eq 'chooseform-start') {
	print qq{<div style="position:absolute; top:5px; right:10px;">};
	if ($lang eq 'en') {
	    (my $de_script = $bbbike_script) =~ s{\.en\.cgi}{.cgi};
	    print <<EOF;
<a href="$de_script"><img class="unselectedflag" src="http://bbbike.sourceforge.net/images/de_flag.png" alt="Deutsch" border="0"></a>
<img class="selectedflag" src="http://bbbike.sourceforge.net/images/gb_flag.png" alt="English" border="0">
EOF
	} else {
	    (my $en_script = $bbbike_script) =~ s{\.cgi}{.en.cgi};
	    print <<EOF;
<img class="selectedflag" src="http://bbbike.sourceforge.net/images/de_flag.png" alt="Deutsch" border="0">
<a href="$en_script"><img class="unselectedflag" src="http://bbbike.sourceforge.net/images/gb_flag.png" alt="English" border="0"></a>
EOF
	}
	print qq{</div>\n};
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
# ?begin anscheinend notwendig (Bug in Netscape3, Solaris2?)
    my $smallformstr = ($q->param('smallform')
			? '&smallform=' . $q->param('smallform')
			: '');
    $s .= qq{<center } . (!$bi->{'css_buggy'} ? qq{style="padding-top:5px;" } : "") . qq{><table };
    if (1 || !$bi->{'can_css'}) { # XXX siehe oben Kommentar am Anfang von "sub search_*" bzgl. css
	$s .= "bgcolor=\"#ffcc66\" ";
    }
    $s .= "cellpadding=3>\n";
    $s .= <<EOF;
<tr>
<td align=center>${fontstr}bbbike.cgi $VERSION${fontend}</td>
<td align=center>${fontstr} <a target="_top" href="mailto:@{[ $BBBike::EMAIL ]}?subject=BBBike">@{[ M("E-Mail") ]}</a>${fontend}</td>
<td align=center>$fontstr<a target="_top" href="$bbbike_script?begin=1$smallformstr">@{[ M("Neue Anfrage") ]}</a>${fontend}</td>
EOF
    $s .= <<EOF;
<td align=center>$fontstr<a target="_top" href="$bbbike_script?info=1$smallformstr">@{[ M("Kontakt, Info &amp; Disclaimer") ]}</a>${fontend}</td>
EOF
    $s .= "<td align=center>$fontstr";
    $s .= complete_link_to_einstellungen();
    $s .= "${fontend}</td>\n";
    if ($can_mapserver) {
        $s .= "<td><a href=\"$bbbike_script?mapserver=1\">Mapserver</a></td>";
    } elsif (defined $mapserver_init_url) {
        $s .= "<td><a href=\"$mapserver_init_url\">Mapserver</a></td>";
    }
    if ($ENV{SERVER_NAME} =~ /radzeit/i) {
        $s .= "<td><a href=\"http://www.radzeit.de\">Radzeit.de</a></td>";
    }
    $s .= <<EOF;
</tr>
</table>
</center>
EOF
    if ($bi->{'css_buggy'}) {
	$s .= "</font>\n";
    }
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
    #qq{<a href="http://www.met.fu-berlin.de/deutsch/Wetter/meldungen.html">};
    qq{<a href="http://www.met.fu-berlin.de/de/wetter/">};
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
    $plz = init_plz();
    my $plz_re = $plz->make_plz_re($plz_number);
    my @res = $plz->look($plz_re, Noquote => 1);
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
    eval {
	local $SIG{'__DIE__'};
	require POSIX;
	$old_locale = &POSIX::setlocale(&POSIX::LC_COLLATE, "");
	foreach my $locale (qw(de de_DE de_DE.ISO8859-1 de_DE.ISO_8859-1)) {
	    $locale_set=1, last
		if (&POSIX::setlocale(&POSIX::LC_COLLATE, $locale));
	}
    };

    http_header(@weak_cache);
    header(#too slow XXX -onload => "list_all_streets_onload()",
	   -script => {-src => $bbbike_html . "/bbbike_start.js",
		      },
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

    print "<center>";
    for my $ch ('A' .. 'Z') {
	print "<a href=\"#$ch\">$ch</a> ";
    }
#     for my $type (qw(s u)) {
# 	print qq{<a href="#${type}bhf">} . uc($type) . qq{-Bahnh�fe</a> };
#     }
    print "</center><div id='list'>";

    for(my $i = 0; $i <= $#strlist; $i++) {
	next if ($strlist[$i] =~ /^\(/);
	next if $last eq $strlist[$i];
	$last = $strlist[$i];
	(my $strname = $strlist[$i]) =~ s/\s+/\240/g;
	my $initial = substr($strname, 0, 1);
	if (defined $last_initial and
	    $last_initial ne $initial and
	    (!defined $trans{$initial} or
	     $last_initial ne $trans{$initial})) {
	    print "<hr>";
	    $last_initial = ($trans{$initial} ? $trans{$initial} : $initial);
	    print "<a name=\"$last_initial\"><b>$last_initial</b></a><br>";
	}
	print "$strname<br>";
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

    print "</div>";

    print $q->end_html;

    if ($locale_set && defined $old_locale) {
	eval {
	    local $SIG{'__DIE__'};
	    &POSIX::setlocale( &POSIX::LC_COLLATE, $old_locale);
	};
	warn $@ if $@; #XXX remove?
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
	print "> ", join("/", @{$crossings->{$_}}), "<br>\n";
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
	print "> ", join("/", @{$crossings->{$_}}), "<br>\n";
    }
    print "<hr>";
    suche_button();
    footer();
    print "</form>\n";
    print $q->end_html;
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
    }
}

sub upload_button {
    http_header(@no_cache); # wegen dummy
    header();
    upload_button_html();
    footer();
    print $q->end_html;
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
    return unless $use_apache_session;

    if (!eval qq{ require $apache_session_module }) {
	$use_apache_session = undef;
	warn $@ if $debug;
	return;
    }

    if ($apache_session_module eq 'Apache::Session::Counted') {
	return tie_session_counted($id);
    }

    tie my %sess, $apache_session_module, $id,
	{ FileName => "/tmp/bbbike_sessions_" . $< . ".db", # XXX make configurable
	  LockDirectory => '/tmp',
	} or do {
	    $use_apache_session = undef;
	    warn $! if $debug;
	    return;
	};

    return \%sess;
}

sub tie_session_counted {
    my $id = shift;

    # To retrieve a session file:
    #perl -MData::Dumper -MStorable=thaw -e '$content=do{open my $fh,$ARGV[0] or die;local$/;<$fh>}; warn Dumper thaw $content' file

    #my $dirlevels = 1;
    my $dirlevels = 0;
    my @l = localtime;
    my $date = sprintf "%04d-%02d-%02d", $l[5]+1900, $l[4]+1, $l[3];
    # Make sure a different user for cgi-bin/mod_perl operation is used
    my $directory = "/tmp/bbbike-sessions-" . $< . "-$date";

#     require File::Spec;
#     open(OLDOUT, ">&STDOUT") or die $!;
#     open(STDOUT, ">&STDERR") or die $!;
#     Apache::Session::CountedStore->tree_init($directory, $dirlevels);
#     close STDOUT;
#     open(STDOUT, ">&OLDOUT") or die $!;

    tie my %sess, $apache_session_module, $id,
	{ Directory => $directory,
	  DirLevels => $dirlevels,
	  CounterFile => "/tmp/bbbike-counter-" . $< . "-$date",
	  AlwaysSave => 1,
	  HostID => undef,
	  HostURL => sub { undef },
	  Timeout => 10,
	} or do {
	    $use_apache_session = undef;
	    warn $! if $debug;
	    return;
	};

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

######################################################################
#
# Information
#
sub show_info {
    http_header(@weak_cache);
    header();
    my $perl_url = "http://www.perl.org/";
    my $cpan = "http://www.cpan.org/";
    my $scpan = "http://search.cpan.org/search?mode=module&query=";
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
   <li><a href="#pda">PDA-Version</a>
   <li><a href="#wap">WAP</a>
   <li><a href="#gpsupload">GPS-Upload</a>
@{[ $can_palmdoc ? qq{<li><a href="#palmexport">Palm-Export</a>} : qq{} ]}
  </ul>
 <li><a href="@{[ $bbbike_html ]}/presse.html">Die Presse �ber BBBike</a>
 <li><a href="#hardsoftware">Hard- und Softwareinformation</a>
 <li><a href="#disclaimer">Disclaimer</a>
 <li><a href="#autor">Kontakt</a>
</ul>
<hr>

<a name="tipps"><h3>Die Routensuche</h3></a>
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
<a name="data"><h3>Daten</h3></a>

Die Daten auf dem aktuellen Stand zu halten ist in einer Stadt wie
Berlin f�r einen Einzelnen eine schwere Aufgabe. Deshalb freue ich
mich �ber Feedback: neue Stra�en, ver�nderte Gegebenheiten, sowohl in
Berlin als auch im Brandenburger Umland. Anregungen bitte als <a
href="mailto:$BBBike::EMAIL">Mail</a> schicken oder <a
href="$bbbike_html/newstreetform.html?frompage=info">dieses Formular</a> benutzen.

<hr>
<a name="link"><h3>Link auf BBBike setzen</h3></a>
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

<a name="mambo"><h4>BBBike-Modul f�r Mambo</h4></a>
F�r das CMS Mambo gibt es auf mamboforge ein <a href="http://mamboforge.net/frs/?group_id=1094">BBBike-Modul</a> von Ramiro G&#243;mez.
<hr>
<p>
EOF

    print <<EOF;
<a name="resourcen"><h3>Weitere M�glichkeiten und Tipps</h3></a>
<a name="perltk"><h4>Perl/Tk-Version</h4></a>
Es gibt eine wesentlich komplexere Version von BBBike mit interaktiver Karte, mehr Kontrollm�glichkeiten �ber die Routensuche, GPS-Anbindung und den kompletten Daten. Diese Version l�uft als normales Programm (mit Perl/Tk-Interface) unter Unix, Linux, Mac OS X und Windows.
<a href="@{[ $BBBike::BBBIKE_SF_WWW ]}">Hier</a>
bekommt man dazu mehr Informationen. Als Beispiel kann man sich
<a href="@{[ $BBBike::BBBIKE_SF_WWW ]}/screenshots.de.html">Screenshots</a> der Perl/Tk-Version angucken.
<a name="beta"><h4>Beta-Version</h4></a>
Zuk�nftige BBBike-Features k�nnen <a href="$bbbike2_url">hier</a> getestet werden.
<a name="pda"><h4>PDA-Version f�r iPAQ/Linux</h4></a>
F�r iPAQ-Handhelds mit Familiar Linux gibt es eine kleine Version von BBBike: <a href="@{[ $BBBike::BBBIKE_SF_WWW ]}">tkbabybike</a>.
<a name="wap"><h4>WAP</h4></a>
BBBike kann man per WAP-Handy unter der Adresse <a href="@{[ $BBBike::BBBIKE_WAP ]}">@{[ $BBBike::BBBIKE_WAP ]}</a> nutzen.
<p>
<a name="gpsupload"><h4>GPS-Upload</h4></a>
Es besteht die experimentelle M�glichkeit, sich <a href="@{[ $bbbike_url ]}?uploadpage=1">GPS-Tracks oder bbr-Dateien</a> anzeigen zu lassen.<p>
<h4>Diplomarbeit</h4>
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
<h4>Mozilla-Sidebar</h4>
<form name="bbbike_add_sidebar">
<a href="#" onclick="return addSidebar(document.forms.bbbike_add_sidebar)"><!-- img src="http://developer.netscape.com/docs/manuals/browser/sidebar/add-button.gif" alt="Add sidebar" border=0 -->Add sidebar</a>, dabei folgende Adressen optional als Default verwenden:<br>
<table>
<tr><td><img src="$bbbike_images/flag2_bl.gif" border=0 alt="Start"> Start:</td><td> <input size=10 name="start"></td></tr>
<tr><td><img src="$bbbike_images/flag_ziel.gif" border=0 alt="Ziel"> Ziel:</td><td> <input size=10 name="ziel"></td></tr>
</table>
</form>
EOF
    }
    if ($can_palmdoc) {
	print <<EOF;
<a name="palmexport"><h4>Palm-Export</h4></a>
<p>F�r den PalmDoc-Export ben�tigt man auf dem Palm einen entsprechenden
Viewer, z.B.
<a href="http://www.freewarepalm.com/docs/cspotrun.shtml">CSpotRun</a>.
F�r eine komplette Liste kompatibler Viewer siehe auch
<a href="http://www.freewarepalm.com/docs/docs_software.shtml">hier</a>.
EOF
    }
    print "<hr><p>\n";

    print "<a name='hardsoftware'><h3>Hard- und Software</h3></a>\n";
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

    my $cgi_date = '$Date: 2006/04/26 20:20:10 $';
    ($cgi_date) = $cgi_date =~ m{(\d{4}/\d{2}/\d{2})};
    my $data_date;
    for (@Strassen::datadirs) {
	if (my(@s) = stat "$_/.modified") {
	    my @l = localtime $s[9];
	    $data_date = sprintf "%04d/%02d/%02d", $l[5]+1900,$l[4]+1,$l[3];
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
	    print "\" border=0></a>";
	} elsif ($os =~ /linux/i) {
	    print "<a href=\"http://www.linux.org/\"><img align=right src=\"";
	    print "http://lwn.net/images/linuxpower2.png";
	    print "\" border=0></a>";
	}
        print "<p>";
    }
    if (defined $ENV{'SERVER_SOFTWARE'}) {
	print "HTTP-Server: $ENV{'SERVER_SOFTWARE'}\n";
	if ($ENV{'SERVER_SOFTWARE'} =~ /apache/i) {
	    print "<a href=\"http://www.apache.org/\"><img align=right src=\"";
	    print "http://httpd.apache.org/apache_pb.gif";
	    print "\" border=0></a>";
	}
	print "<p>";
    }
    if ($ENV{SERVER_NAME} =~ /sourceforge/) {
	print <<EOF;
<A href="http://sourceforge.net"> <IMG align=right
src="http://sourceforge.net/sflogo.php?group_id=19142"
width="88" height="31" border="0" alt="SourceForge Logo"></A><p>
EOF
    }

    print <<EOF;
Verwendete Software:
<ul>
<li><a href="$perl_url">perl $]</a><a href="$perl_url"><img border=0 align=right src="http://www.perlfoundation.org/images/perl_powered.png"></a>
<li>perl-Module:<a href="$cpan"><img border=0 align=right src="http://theoryx5.uwinnipeg.ca/images/cpan.jpg"></a>
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
<h3><a name="disclaimer">Disclaimer</a></h3>
Es wird keine Gew�hr f�r die Inhalte dieser Site sowie verlinkter Sites �bernommen.
<hr>

EOF

    print <<EOF;
<h3><a name="autor">Kontakt</a></h3>
<center>
Autor: Slaven Rezic<br>
<a href="mailto:@{[ $BBBike::EMAIL ]}">E-Mail:</a> <a href="mailto:@{[ $BBBike::EMAIL ]}">@{[ $BBBike::EMAIL ]}</a><br>
<a href="@{[ $BBBike::HOMEPAGE ]}">Homepage:</a> <a href="@{[ $BBBike::HOMEPAGE ]}">@{[ $BBBike::HOMEPAGE ]}</a></a><br>
Telefon: @{[ CGI::escapeHTML("+49-172-1661969") ]}<br>
Donji Crna&#x10d; 81, BiH-88220 &#x160;iroki Brijeg<br>
</center>
<p>
EOF

    # XXX Wo geh�ren die Fu�noten am besten hin?
    print <<EOF;
<p><p><p><hr>
Fu�noten:<br>
<a name="footnote1"><sup>1</sup> @{[ footnote(1) ]}<hr><p>
EOF

    footer();

    print $q->end_html;
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

Copyright (C) 1998-2005 Slaven Rezic. All rights reserved.
This is free software; you can redistribute it and/or modify it under the
terms of the GNU General Public License, see the file COPYING.

=head1 SEE ALSO

bbbike(1).

=cut

