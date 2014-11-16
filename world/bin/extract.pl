#!/usr/local/bin/perl
# Copyright (c) 2011-2013 Wolfram Schneider, http://bbbike.org
#
# extract.pl - extracts areas in a batch job
#
# spool area
#   /incoming	- request to extract an area, email sent out to user
#   /confirmed	- user confirmed request by clicking on a link in the email
#   /running    - the request is running
#   /osm	- the request is done, files are saved for further usage
#   /download  	- where the user can download the files, email sent out
#  /jobN.pid	- running jobs
#
# todo:
# - xxx
#

use IO::File;
use IO::Dir;
use JSON;
use Data::Dumper;
use Encode qw/encode_utf8 decode_utf8/;
use Email::Valid;
use Digest::MD5 qw(md5_hex);
use Net::SMTP;
use CGI qw(escapeHTML);
use Getopt::Long;
use File::Basename;
use File::stat;
use GIS::Distance::Lite;
use LWP;
use LWP::UserAgent;
use Time::gmtime;
use LockFile::Simple;

use strict;
use warnings;

$ENV{'PATH'} = "/usr/local/bin:/bin:/usr/bin";
$ENV{'OSM_CHECKSUM'} = 'false';    # disable md5 checksum files

#$ENV{'BBBIKE_EXTRACT_LANG'} = 'en';       # default language

# group writable file
umask(002);

binmode \*STDOUT, ":utf8";
binmode \*STDERR, ":utf8";

our $option = {
    'max_areas'       => 8,
    'homepage'        => 'http://download.bbbike.org/osm/extract',
    'script_homepage' => 'http://extract.bbbike.org',
    'max_jobs'        => 3,
    'bcc'             => 'bbbike@bbbike.org',
    'email_from'      => 'bbbike@bbbike.org',
    'send_email'      => 1,

    # timeout handling
    'alarm'         => 210 * 60,    # extract
    'alarm_convert' => 90 * 60,     # convert

    # run with lower priority
    'nice_level' => 2,

    #'nice_level_converter' => 3,
    #'planet_osm' => "../osm/download/planet-latest.osm.pbf",
    'planet' => {
        'planet.osm' => '../osm/download/planet-latest.osm.pbf',
        'srtm-europe.osm.pbf' =>
          '../osm/download/srtm/Hoehendaten_Freizeitkarte_Europe.osm.pbf',
        'srtm-europe.garmin-srtm.zip' =>
          '../osm/download/srtm/Hoehendaten_Freizeitkarte_Europe.osm.pbf',
        'srtm-europe.obf.zip' =>
          '../osm/download/srtm/Hoehendaten_Freizeitkarte_Europe.osm.pbf',
        'srtm-europe.mapsforge-osm.zip' =>
          '../osm/download/srtm/Hoehendaten_Freizeitkarte_Europe.osm.pbf',

        'srtm.osm.pbf' => '../osm/download/srtm/planet-srtm-e40.osm.pbf',
        'srtm.garmin-srtm.zip' =>
          '../osm/download/srtm/planet-srtm-e40.osm.pbf',
        'srtm.obf.zip' => '../osm/download/srtm/planet-srtm-e40.osm.pbf',
        'srtm.mapsforge-osm.zip' =>
          '../osm/download/srtm/planet-srtm-e40.osm.pbf',
    },

    'debug' => 0,
    'test'  => 0,

    # spool directory. Should be at least 100GB large
    'spool_dir' => '/var/cache/extract',

    'file_prefix' => 'planet_',

    # reset max_jobs if load is to high
    'max_loadavg'      => 10,
    'max_loadavg_jobs' => 2,    # 0: stop running at all

    # 4196 polygones is enough for the queue
    'max_coords' => 4 * 1024,

    'language'     => "en",
    'message_path' => "world/etc/extract",

    'osmosis_options' => [ "omitmetadata=true", "granularity=10000" ],
    'osmosis_options_bounding_polygon' => ["clipIncompleteEntities=true"],

    'aws_s3_enabled' => 0,
    'aws_s3'         => {
        'bucket'      => 'bbbike',
        'path'        => 'osm/extract',
        'put_command' => 's3put',
        'homepage'    => 'http://s3.amazonaws.com',
    },

    # use web rest service for email sent out
    'email_rest_url'     => 'http://extract.bbbike.org/cgi/extract-email.cgi',
    'email_rest_enabled' => 0,

    'show_image_size' => 1,

    'pbf2pbf_postprocess' => 1,

    'bots'             => [qw/curl Wget/],
    'bots_detecation'  => 1,
    'bots_max_loadavg' => 3,

    'pbf2osm' => {
        'garmin_version'    => 'mkgmap-3334',
        'osmand_version'    => 'OsmAndMapCreator-1.1.3',
        'mapsforge_version' => 'mapsforge-0.4.3',
        'navit_version'     => 'maptool-0.5.0~svn5126',
        'shape_version'     => 'osmium2shape-1.0',
    }
};

######################################################################

my $formats = {
    'osm.pbf' => 'Protocolbuffer Binary Format (PBF)',
    'osm.gz'  => "OSM XML gzip'd",
    'osm.bz2' => "OSM XML bzip'd",
    'osm.xz'  => "OSM XML 7z/xz",
    'shp.zip' => "Shapefile (Esri)",
    'obf.zip' => "Osmand (OBF)",
    'o5m.gz'  => "o5m gzip'd",
    'o5m.bz2' => "o5m bzip'd",
    'o5m.xz'  => "o5m 7z (xz)",
    'opl.xz'  => "opl 7z (xz)",
    'csv.gz'  => "CSV gzip'd",
    'csv.bz2' => "CSV bzip'd",
    'csv.xz'  => "CSV 7z (xz)",

    'garmin-osm.zip'     => "Garmin OSM",
    'garmin-cycle.zip'   => "Garmin Cycle",
    'garmin-leisure.zip' => "Garmin Leisure",
    'garmin-bbbike.zip'  => "Garmin BBBike",
    'navit.zip'          => "Navit",
    'mapsforge-osm.zip'  => "mapsforge OSM",

    'srtm-europe.osm.pbf'           => 'SRTM Europe PBF',
    'srtm-europe.garmin-srtm.zip'   => 'SRTM Europe Garmin',
    'srtm-europe.mapsforge-osm.zip' => 'SRTM Europe Mapsforge',
    'srtm-europe.obf.zip'           => 'SRTM Europe Osmand',

    'srtm.osm.pbf'           => 'SRTM PBF',
    'srtm.garmin-srtm.zip'   => 'SRTM Garmin',
    'srtm.mapsforge-osm.zip' => 'SRTM Mapsforge',
    'srtm.obf.zip'           => 'SRTM Osmand',
};

# translations
my $msg;
my $language = $option->{'language'};

#
# Parse user config file.
# This allows to override standard config values
#
my $config_file = "$ENV{HOME}/.bbbike-extract.rc";
if ( $ENV{BBBIKE_EXTRACT_PROFILE} ) {
    $config_file = $ENV{BBBIKE_EXTRACT_PROFILE};
}
if ( -e $config_file ) {
    warn "Load config file: $config_file\n" if $option->{"debug"} >= 2;
    require $config_file;
}
else {
    warn "config file: $config_file not found, ignored\n"
      if $option->{"debug"} >= 2;
}

my $spool = {
    'incoming'  => "incoming",     # incoming request, not confirmed yet
    'confirmed' => "confirmed",    # ready to run
    'running'   => "running",      # currently running job
    'osm'       => "osm",          # cache older runs
    'download'  => "download",     # final directory for download
    'trash'     => "trash",        # keep a copy of the config for debugging
    'failed'    => "failed",       # keep record of failed runs
};

my $alarm      = $option->{"alarm"};
my $nice_level = $option->{"nice_level"};
my $email_from = $option->{"email_from"};
my $planet_osm = $option->{"planet_osm"} || $option->{"planet"}->{"planet.osm"};
my $debug      = $option->{"debug"};
my $test       = $option->{"test"};

if ( $option->{"pro"} ) {
    $option->{"osmosis_options"} = [];
}
my $osmosis_options = join( " ", @{ $option->{"osmosis_options"} } );

my $nice_level_converter =
  exists $option->{"nice_level_converter"}
  ? $option->{"nice_level_converter"}
  : $nice_level + 3;

# test & debug
$planet_osm =
  "../osm/download/geofabrik/europe/germany/brandenburg-latest.osm.pbf"
  if $test;

######################################################################
#
#

# timeout handler
sub set_alarm {
    my $time = shift;
    my $message = shift || "";

    $time = $alarm if !defined $time;

    $SIG{ALRM} = sub {
        my $pgid = getpgrp();

        warn "Time out alarm $time\n";

        # sends a hang-up signal to all processes in the current process group
        # and kill running java processes
        local $SIG{HUP} = "IGNORE";
        kill "HUP", -$pgid;
        sleep 0.5;

        local $SIG{TERM} = "IGNORE";
        kill "TERM", -$pgid;
        sleep 0.5;

        local $SIG{INT} = "IGNORE";
        kill "INT", -$pgid;
        sleep 0.5;

        warn "Send a hang-up to all childs.\n";

        #exit 1;
    };

    warn "set alarm time to: $time seconds $message\n" if $debug >= 1;
    alarm($time);
}

sub get_loadavg {
    my @loadavg = ( qx(uptime) =~ /([\.\d]+),?\s+([\.\d]+),?\s+([\.\d]+)/ );

    return $loadavg[0];
}

# get a list of json config files from a directory
sub get_jobs {
    my $dir = shift;

    my $d = IO::Dir->new($dir);
    if ( !defined $d ) {
        warn "error directory $dir: $!\n";
        return ();
    }

    my @data;
    while ( defined( $_ = $d->read ) ) {
        next if !/\.json$/;
        push @data, $_;
    }
    undef $d;

    return @data;
}

# ($lat1, $lon1 => $lat2, $lon2);
sub square_km {
    my ( $x1, $y1, $x2, $y2 ) = @_;

    my $height = GIS::Distance::Lite::distance( $x1, $y1 => $x1, $y2 ) / 1000;
    my $width  = GIS::Distance::Lite::distance( $x1, $y1 => $x2, $y1 ) / 1000;

    return int( $height * $width );
}

# 240000 -> 240,000
sub large_int {
    my $int = shift;
    my $lang = shift || "en";

    return $int if $int < 1_000;

    my $sep = $lang eq "de" ? "." : ",";

    my $number = substr( $int, 0, -3 ) . $sep . substr( $int, -3, 3 );
    return $number;
}

# fair scheduler, take one from each customer first until
# we reach the limit
sub parse_jobs {
    my %args = @_;

    my $dir   = $args{'dir'};
    my $files = $args{'files'};
    my $max   = $args{'max'};

    my ( $hash, $default_planet_osm, $counter ) = parse_jobs_planet(%args);

    # sort by user and date, newest first
    foreach my $email ( keys %$hash ) {
        $hash->{$email} =
          [ reverse sort { $a->{"time"} <=> $b->{"time"} }
              @{ $hash->{$email} } ];
    }

    # fair scheduler, take one from each customer first
    my @list;
    my $counter_coords = 0;

    # 4196 polygones is enough for the queue
    my $max_coords = $option->{max_coords};

    my $loadavg = &get_loadavg;
    while ( $counter-- > 0 ) {
        foreach my $email ( sort keys %$hash ) {
            if ( scalar( @{ $hash->{$email} } ) ) {
                my $obj  = shift @{ $hash->{$email} };
                my $city = $obj->{'city'};

                my $length_coords = 0;

                # do not add a large polygone to an existing list
                if ( $length_coords > $max_coords && $counter_coords > 0 ) {
                    warn
                      "do not add a large polygone $city to an existing list\n"
                      if $debug;
                    next;
                }

                if ( is_bot($obj) ) {
                    warn
"detect bot for area '$city', user agent: '@{[ $obj->{'user_agent'} ]}'\n"
                      if $debug;

                    if (   $option->{'bots_detecation'}
                        && $loadavg >= $option->{'bots_max_loadavg'} )
                    {
                        warn
"ignore bot request for area '$city' due high load average: $loadavg\n"
                          if $debug;
                        next;
                    }
                }

                push @list, $obj;
                $counter_coords += $length_coords;

                warn
"coords total length: $counter_coords, city=$city, length=$length_coords\n"
                  if $debug;

                # stop here, list is to long
                if ( $counter_coords > $max_coords ) {
                    warn "coords counter length for $city: ",
                      "$counter_coords > $max_coords, stop after\n"
                      if $debug;
                    return ( \@list, $default_planet_osm );
                }
            }
            last if scalar(@list) >= $max;
        }
        last if scalar(@list) >= $max;
    }

    return ( \@list, $default_planet_osm );
}

sub parse_jobs_planet {
    my %args = @_;

    my $dir   = $args{'dir'};
    my $files = $args{'files'};
    my $max   = $args{'max'};

    my $hash;
    my $default_planet_osm = "";
    my $counter            = 0;

    foreach my $f (@$files) {
        my $file = "$dir/$f";

        my $json_text = read_data($file);

        my $json = new JSON;
        my $json_perl = eval { $json->decode($json_text) };
        die "json $file $@" if $@;
        json_compat($json_perl);

        $json_perl->{"file"} = $f;

        # planet.osm file per job
        my $format = $json_perl->{"format"};
        $json_perl->{'planet_osm'} =
          exists $option->{'planet'}->{$format}
          ? $option->{'planet'}->{$format}
          : $option->{'planet'}->{'planet.osm'};

        # first jobs defines the planet.osm file
        if ( !$default_planet_osm ) {
            $default_planet_osm = $json_perl->{'planet_osm'};
        }

        # only the same planet.osm file
        if ( $json_perl->{'planet_osm'} eq $default_planet_osm ) {

            # a slot for every user
            push @{ $hash->{ $json_perl->{'email'} } }, $json_perl;
            $counter++;
        }
        else {
            warn
"Ignore job due different planet.osm file: $default_planet_osm <=> $json_perl->{'planet_osm'}\n"
              if $debug >= 1;
        }
    }

    return ( $hash, $default_planet_osm, $counter );
}

# detect bots by user agent, or other meta data
sub is_bot {
    my $obj = shift;

    my @bots       = @{ $option->{'bots'} };
    my $user_agent = $obj->{'user_agent'};

    # legacy config jobs
    if ( !defined $user_agent ) {
        $user_agent = "";
    }

    return ( grep { $user_agent =~ /$_/ } @bots ) ? 1 : 0;
}

sub json_compat {
    my $obj = shift;

    # be backward compatible with old *.json files
    if ( !( exists $obj->{'coords'} && ref $obj->{'coords'} eq 'ARRAY' ) ) {
        $obj->{'coords'} = [];
    }
    return $obj;
}

# create a unique job id for each extract request
sub get_job_id {
    my @list = @_;

    my $json = new JSON;
    my $data = "";
    foreach my $key (@list) {
        $data .= $json->encode($key);
    }

    my $key = md5_hex( encode_utf8($data) );
    return $key;
}

# file prefix depending on input PBF file, e.g. "planet_"
sub get_file_prefix {
    my $obj = shift;

    my $file_prefix = $option->{'file_prefix'};
    my $format      = $obj->{'format'};

    if ( exists $option->{'planet'}->{$format} ) {
        $format =~ s/\..*/_/;
        $file_prefix = $format if $format;
    }

    warn "Use file prefix: '$file_prefix'\n" if $debug >= 2;
    return $file_prefix;
}

# store lng,lat in file name
sub file_lnglat {
    my $obj    = shift;
    my $file   = get_file_prefix($obj);
    my $coords = $obj->{coords} || [];

    # rectangle
    if ( !scalar(@$coords) ) {
        $file .= "$obj->{sw_lng},$obj->{sw_lat}_$obj->{ne_lng},$obj->{ne_lat}";
    }

    # polygon
    else {
        my $c = join '|', ( map { "$_->[0],$_->[1]" } @$coords );
        my $first = $coords->[0];

        my $md5 =
          substr( md5_hex($c), 0, 8 )
          ;    # first 8 characters of a md5 sum is enough
        $file .= join "_", ( $first->[0], $first->[1], $md5 );
    }

    return $file;
}

#
# Create poly files based on a given list of json config files.
#
# On success, the json config files will be moved
# from the spool "confirmed" to "running"
#
sub create_poly_files {
    my %args    = @_;
    my $job_dir = $args{'job_dir'};
    my $list    = $args{'list'};

    my $spool         = $args{'spool'};
    my $osm_dir       = $spool->{'osm'};
    my $confirmed_dir = $spool->{'confirmed'};

    my @list = @$list;

    if ( -e $job_dir ) {
        warn "directory $job_dir already exists!\n";
        return;
    }

    warn "create job dir $job_dir\n" if $debug >= 1;
    mkdir($job_dir) or die "mkdir $job_dir $!\n";

    my %hash;
    my @poly;
    foreach my $job (@list) {
        my $file      = &file_lnglat($job);
        my $poly_file = "$job_dir/$file.poly";
        my $pbf_file  = "$job_dir/$file.osm.pbf";

        $job->{pbf_file} = $pbf_file;
        if ( exists $hash{$file} ) {
            warn "ignore duplicate: $file\n" if $debug;
            next;
        }
        $hash{$file} = 1;

        if ( !$file ) {
            warn "ignore job: ", Dumper($job), "\n";
            next;
        }

        # multiple equal extract request in the same batch job
        if ( -e $pbf_file && -s $pbf_file ) {
            warn "file $pbf_file already exists, skiped\n";

            #&touch_file($pbf_file);
            next;
        }

        &create_poly_file( 'file' => $poly_file, 'job' => $job );
        push @poly, $poly_file;

        $job->{poly_file} = $poly_file;
    }

    my @json;
    foreach my $job (@list) {
        my $from = "$confirmed_dir/$job->{'file'}";
        my $to   = "$job_dir/$job->{'file'}";

        warn "rename $from -> $to\n" if $debug >= 2;
        my $json = new JSON;
        my $data = $json->pretty->encode($job);

        store_data( $to, $data );
        unlink($from) or die "unlink $from: $!\n";
        push @json, $to;
    }

    if ($debug) {
        warn "number of poly files: ", scalar(@poly),
          ", number of json files: ", scalar(@json), "\n";
    }
    return ( \@poly, \@json );
}

# refresh mod time of file, to keep files in cache
sub touch_file {
    my $file      = shift;
    my $test_mode = shift;

    my @system = ( "touch", $file );

    warn "touch $file\n" if $debug;
    @system = 'true' if $test_mode;

    system(@system) == 0
      or die "system @system failed: $?";
}

# store a blob of data in a file
sub store_data {
    my ( $file, $data ) = @_;

    my $fh = new IO::File $file, "w" or die "open $file: $!\n";
    binmode $fh, ":utf8";

    print $fh $data;
    $fh->close;
}

# create a poly file which will be read by osmosis(1) to extract
# an area from planet.osm
sub create_poly_file {
    my %args = @_;
    my $file = $args{'file'};
    my $obj  = $args{'job'};

    my $data = "";

    my $city = escapeHTML( $obj->{city} );
    $data .= "$city\n";
    $data .= "1\n";

    my $counter = 0;

    # rectangle
    if ( !scalar( @{ $obj->{coords} } ) ) {
        $data .= "   $obj->{sw_lng}  $obj->{sw_lat}\n";
        $data .= "   $obj->{ne_lng}  $obj->{sw_lat}\n";
        $data .= "   $obj->{ne_lng}  $obj->{ne_lat}\n";
        $data .= "   $obj->{sw_lng}  $obj->{ne_lat}\n";
        $counter += 4;
    }

    # polygone
    else {
        my @c = @{ $obj->{coords} };

        # close polygone if not already closed
        if ( $c[0]->[0] ne $c[-1]->[0] || $c[0]->[1] ne $c[-1]->[1] ) {
            push @c, $c[0];
        }

        for ( my $i = 0 ; $i <= $#c ; $i++ ) {
            my ( $lng, $lat ) = ( $c[$i]->[0], $c[$i]->[1] );
            $data .= "   $lng  $lat\n";
        }

        $counter += $#c;
    }

    $data .= "END\n";
    $data .= "END\n";

    if ( -e $file ) {
        warn "poly file $file already exists!\n";
        return;
    }

    warn "create poly file $file with $counter elements\n" if $debug >= 2;
    store_data( $file, $data );
}

#
# extract area(s) from planet.osm with osmosis tool
#
sub run_extracts {
    my %args       = @_;
    my $spool      = $args{'spool'};
    my $poly       = $args{'poly'};
    my $planet_osm = $args{'planet_osm'};

    my $osm = $spool->{'osm'};

    warn "Poly: " . Dumper($poly) if $debug >= 3;
    return () if !defined $poly || scalar(@$poly) <= 0;

    my @data = ( "nice", "-n", $nice_level, "osmosis", "-q" );
    push @data,
      ( "--read-pbf", $planet_osm, "--buffer", "bufferCapacity=2000" );

    my @pbf;
    my $tee = 0;
    my @fixme;
    foreach my $p (@$poly) {
        my $out = $p;
        $out =~ s/\.poly$/.osm.pbf/;

        my $osm = $spool->{'osm'} . "/" . basename($out);
        if ( -e $osm ) {
            my $newer = file_mtime_diff( $osm, $planet_osm );
            if ( $newer > 0 ) {
                warn "File $osm already exists, skip\n" if $debug;
                link( $osm, $out ) or die "link $osm => $out: $!\n";

                #&touch_file($osm);
                next;
            }
            else {
                warn "file $osm already exists, ",
                  "but a new planet.osm is here since ", abs($newer),
                  " seconds. Rebuild.\n";
            }
        }

        push @pbf, "--bounding-polygon", "file=$p",
          @{ $option->{"osmosis_options_bounding_polygon"} };
        push @pbf, "--write-pbf", "file=$out",
          @{ $option->{"osmosis_options"} };

        $tee++;
        push @fixme, $out;
    }

    if (@pbf) {
        push @data, "--tee", $tee;
        push @data, @pbf;
    }
    else {

        # nothing to do
        @data = "true";
    }

    warn "Use planet.osm file $planet_osm\n" if $debug >= 1;
    warn "Run extracts: " . join( " ", @data ), "\n" if $debug >= 2;
    return ( \@data, \@fixme );
}

# compute SHA2 checksum for extract file
sub checksum {
    my $file = shift;
    my $type = shift || 'sha256';

    die "file $file does not exists\n" if !-f $file;

    my @checksum_command = $type eq 'md5' ? qw/md5sum/ : qw/shasum -a 256/;

    if ( my $pid = open( C, "-|" ) ) {
    }

    # child
    else {
        exec( @checksum_command, $file ) or die "Alert! Cannot fork: $!\n";
    }

    my $data;
    while (<C>) {
        my @a = split;
        $data = shift @a;
        last;
    }
    close C;

    return $data;
}

# SMTP wrapper
sub send_email_smtp {
    my ( $to, $subject, $text, $bcc ) = @_;
    my $mail_server = "localhost";
    my @to = split /,/, $to;

    my $from         = $email_from;
    my @bcc          = split /,/, $bcc;
    my $content_type = "Content-Type: text/plain; charset=UTF-8\n"
      . "Content-Transfer-Encoding: binary";

    my $data =
      "From: $from\nTo: $to\nSubject: $subject\n" . "$content_type\n\n$text";
    warn "send email to $to\nbcc: $bcc\n$subject\n" if $debug >= 1;
    warn "$text\n"                                  if $debug >= 2;

    my $smtp = new Net::SMTP( $mail_server, Hello => "localhost" )
      or die "can't make SMTP object";

    $smtp->mail($from) or die "can't send email from $from";
    $smtp->to(@to)     or die "can't use SMTP recipient '$to'";
    if ($bcc) {
        $smtp->bcc(@bcc) or die "can't use SMTP recipient '$bcc'";
    }
    $smtp->data($data) or die "can't email data to '$to'";
    $smtp->quit() or die "can't send email to '$to'";

    warn "\n$data\n" if $debug >= 3;
}

# email REST wrapper
sub send_email_rest {
    my ( $to, $subject, $message, $bcc ) = @_;

    my $ua = LWP::UserAgent->new;
    $ua->agent("BBBike Extract/1.0; see http://extract.bbbike.org");

    my $url = $option->{"email_rest_url"};
    warn "Use REST email service: $url\n" if $debug >= 1;

    my %form = (
        'token'   => encode_utf8( $option->{"email_token"} ),
        'to'      => encode_utf8($to),
        'subject' => encode_utf8($subject),
        'message' => encode_utf8($message),
        'bcc'     => encode_utf8($bcc),
    );
    warn Dumper( \%form ) if $debug >= 3;

    my $res = $ua->post( $url, \%form );

    # Check the outcome of the response
    if ( !$res->is_success ) {
        my $err = "HTTP error: " . $res->status_line . "\n";
        $err .= $res->content . "\n" if $debug;
        die $err;
    }

    my $content = $res->content;
    my $json    = new JSON;
    my $obj     = $json->decode($content);

    warn "$content" if $debug >= 1;
    if ( $obj->{'status'} ) {
        die $obj->{'message'} . "\n";
    }
}

# check if we need to run a pbf2osm converter
sub cached_format {
    my $file     = shift;
    my $pbf_file = shift;

    my $to = $spool->{'download'} . "/" . basename($file);
    if ( -e $file && -s $file ) {
        warn "File $file already exists, skip...\n" if $debug >= 1;
        return 1;
    }
    elsif ( -e $to && -s $to ) {

        # re-generate garmin if there is a newer PBF file
        if ( $pbf_file && -e $pbf_file ) {
            my $newer = file_mtime_diff( $to, $pbf_file );
            if ( $newer < 0 ) {
                warn "file $to already exists, ",
                  "but a new $pbf_file is here since ", abs($newer),
                  " seconds. Rebuild.\n"
                  if $debug >= 1;
                return 0;
            }
        }
        warn "Converted file $to already exists, skip...\n" if $debug >= 1;

        warn "link $file => $to\n" if $debug >= 2;
        link( $to, $file ) or die "link $to -> $file: $!\n";

        return 1;
    }

    return 0;
}

# reorder PBFs by size and compute time, smalles first
sub reorder_pbf {
    my $json      = shift;
    my $test_mode = shift;

    return @$json if $test_mode;

    my %hash;
    my %format = (
        'osm.pbf' => 0,
        'osm.gz'  => 1,
        'osm.bz2' => 1.2,
        'osm.xz'  => 2.5,

        'shp.zip'           => 1.3,
        'obf.zip'           => 10,
        'mapsforge-osm.zip' => 15,
        'navit.zip'         => 1.1,

        'garmin-osm.zip'     => 3,
        'garmin-cycle.zip'   => 3,
        'garmin-leisure.zip' => 3.5,
        'garmin-bbbike.zip'  => 3,

        'o5m.gz'  => 1.1,
        'o5m.xz'  => 0.9,
        'o5m.bz2' => 1.2,

        'opl.xz' => 1.3,

        'csv.gz'  => 0.42,
        'csv.xz'  => 0.2,
        'csv.bz2' => 0.45,

        'srtm-europe.osm.pbf'           => 1,
        'srtm-europe.garmin-srtm.zip'   => 1.5,
        'srtm-europe.obf.zip'           => 10,
        'srtm-europe.mapsforge-osm.zip' => 2,

        'srtm.osm.pbf'           => 1,
        'srtm.garmin-srtm.zip'   => 1.5,
        'srtm.obf.zip'           => 10,
        'srtm.mapsforge-osm.zip' => 2,
    );

    foreach my $json_file (@$json) {

        my $json_text = read_data($json_file);
        my $json      = new JSON;
        my $obj       = $json->decode($json_text);
        json_compat($obj);

        my $pbf_file = $obj->{'pbf_file'};
        my $format   = $obj->{'format'};

        my $st = stat($pbf_file) or die "stat $pbf_file: $!\n";
        my $size = $st->size * $format{$format};

        $hash{$json_file} = $size;
    }

    my @json = sort { $hash{$a} <=> $hash{$b} } keys %hash;
    if ( $debug >= 2 ) {
        warn "Number of json files: " . scalar(@$json) . "\n";
        warn join "\n", ( map { "$_ $hash{$_}" } @$json ), "\n";
    }

    return @json;
}

sub copy_to_trash {
    my $file = shift;

    my $trash_dir = $spool->{'trash'};

    my $to = "$trash_dir/" . basename($file);

    unlink($to);
    warn "keep copy of json file: $to\n" if $debug >= 3;
    link( $file, $to ) or die "link $file => $to: $!\n";
}

# prepare to sent mail about extracted area
sub convert_send_email {
    my %args       = @_;
    my $json       = $args{'json'};
    my $send_email = $args{'send_email'};
    my $keep       = $args{'keep'};
    my $alarm      = $args{'alarm'};
    my $test_mode  = $args{'test_mode'};
    my $planet_osm = $args{'planet_osm'};

    # all scripts are in these directory
    my $dirname = dirname($0);

    my @unlink;
    my @json = reorder_pbf( $json, $test_mode );

    my $job_counter   = 0;
    my $error_counter = 0;
    foreach my $json_file (@json) {
        my $time = time();

        eval {
            _convert_send_email(
                'json_file'  => $json_file,
                'send_email' => $send_email,
                'test_mode'  => $test_mode,
                'planet_osm' => $planet_osm,
                'alarm'      => $alarm
            );
        };

        if ($@) {
            warn "$@";
            $error_counter++;
        }
        else {
            my $obj      = get_json($json_file);
            my $pbf_file = $obj->{'pbf_file'};
            push @unlink, $pbf_file;

            $job_counter++;
            copy_to_trash($json_file) if $keep;

            # unlink json file if done right now
            unlink($json_file) or die "unlink: $json_file: $!\n";
        }

        warn "Running convert and email time: ", time() - $time, " seconds\n"
          if $#json > 0 && $debug;
    }

    # unlink temporary .pbf files after all files are proceeds
    if (@unlink) {
        unlink(@unlink) or die "unlink: @unlink: $!\n";
    }

    warn "number of email sent: $job_counter\n"
      if $send_email && $debug >= 1;

    return $error_counter;
}

sub get_json {
    my $json_file = shift;
    my $json_text = read_data($json_file);
    my $json      = new JSON;
    my $obj       = $json->decode($json_text);
    json_compat($obj);

    warn "json: $json_file\n" if $debug >= 3;
    warn "json: $json_text\n" if $debug >= 3;

    return $obj;
}

# mkgmap.jar description limit of 50 bytes
sub mkgmap_description {
    my $city = shift;
    $city = "" if !defined $city;
    my $octets = encode_utf8($city);

    # count bytes, not characters
    if ( length($octets) > 50 ) {
        my $data = substr( $octets, 0, 50 );
        $city = decode_utf8( $data, Encode::FB_QUIET );
    }

    return $city;
}

# call back URL
sub script_url {
    my $option = shift;
    my $obj    = shift;

    my $coords = "";
    if ( scalar( @{ $obj->{'coords'} } ) > 100 ) {
        $coords = "0,0,0";
        warn "Coordinates to long for URL, skipped\n" if $debug >= 2;
    }
    else {
        $coords = join '|', ( map { "$_->[0],$_->[1]" } @{ $obj->{'coords'} } );
    }
    my $layers = $obj->{'layers'} || "";
    my $city   = $obj->{'city'}   || "";
    my $lang   = $obj->{'lang'}   || "";

    my $script_url = $option->{script_homepage} . "/?";
    $script_url .=
"sw_lng=$obj->{sw_lng}&sw_lat=$obj->{sw_lat}&ne_lng=$obj->{ne_lng}&ne_lat=$obj->{ne_lat}";
    $script_url .= "&format=$obj->{'format'}";
    $script_url .= "&coords=" . CGI::escape($coords) if $coords ne "";
    $script_url .= "&layers=" . CGI::escape($layers)
      if $layers && $layers !~ /^B/;
    $script_url .= "&city=" . CGI::escape($city) if $city ne "";
    $script_url .= "&lang=" . CGI::escape($lang) if $lang ne "en" && $lang;

    return $script_url;
}

sub _convert_send_email {
    my %args       = @_;
    my $json_file  = $args{'json_file'};
    my $send_email = $args{'send_email'};
    my $alarm      = $args{'alarm'};
    my $test_mode  = $args{'test_mode'};
    my $planet_osm = $args{'planet_osm'};

    my $obj2 = get_json($json_file);
    &set_alarm( $alarm, $obj2->{'pbf_file'} . " " . $obj2->{'format'} );

    # all scripts are in these directory
    my $dirname = dirname($0);

    my @unlink;
    {
        my $obj       = get_json($json_file);
        my $format    = $obj->{'format'};
        my $pbf_file  = $obj->{'pbf_file'};
        my $poly_file = $obj->{'poly_file'};
        my $city      = mkgmap_description( $obj->{'city'} );
        my $lang      = $obj->{'lang'} || "en";
        my @system;

        # parameters for osm2XXX shell scripts
        $ENV{BBBIKE_EXTRACT_URL} = &script_url( $option, $obj );
        $ENV{BBBIKE_EXTRACT_COORDS} =
qq[$obj->{"sw_lng"},$obj->{"sw_lat"} x $obj->{"ne_lng"},$obj->{"ne_lat"}];
        $ENV{'BBBIKE_EXTRACT_LANG'} = $lang;

        $ENV{'BBBIKE_EXTRACT_GARMIN_VERSION'} =
          $option->{pbf2osm}->{garmin_version};
        $ENV{'BBBIKE_EXTRACT_OSMAND_VERSION'} =
          $option->{pbf2osm}->{osmand_version};
        $ENV{'BBBIKE_EXTRACT_MAPSFORGE_VERSION'} =
          $option->{pbf2osm}->{mapsforge_version};
        $ENV{'BBBIKE_EXTRACT_NAVIT_VERSION'} =
          $option->{pbf2osm}->{navit_version};
        $ENV{'BBBIKE_EXTRACT_SHAPE_VERSION'} =
          $option->{pbf2osm}->{shape_version};

        ###################################################################
        # converted file name
        my $file = $pbf_file;

        # convert .pbf to .osm if requested
        my @nice = ( "nice", "-n", $nice_level_converter );

        if ( $format =~ /^osm\.(xz|gz|bz2)$/ ) {
            my $ext = $1;
            $file =~ s/\.pbf$/.$ext/;
            if ( !cached_format( $file, $pbf_file ) ) {
                @system = ( @nice, "$dirname/pbf2osm", "--p$ext", $pbf_file );
                warn "@system\n" if $debug >= 2;
                @system = 'true' if $test_mode;

                system(@system) == 0 or die "system @system failed: $?";
            }
        }
        elsif ( $format =~ /^o5m\.(xz|gz|bz2)$/ ) {
            my $ext = $1;
            $file =~ s/\.pbf$/.o5m.$ext/;
            if ( !cached_format( $file, $pbf_file ) ) {
                @system =
                  ( @nice, "$dirname/pbf2osm", "--o5m-$ext", $pbf_file );
                warn "@system\n" if $debug >= 2;
                @system = 'true' if $test_mode;

                system(@system) == 0 or die "system @system failed: $?";
            }
        }
        elsif ( $format =~ /^opl\.(xz|gz|bz2)$/ ) {
            my $ext = $1;
            $file =~ s/\.pbf$/.opl.$ext/;
            if ( !cached_format( $file, $pbf_file ) ) {
                @system =
                  ( @nice, "$dirname/pbf2osm", "--opl-$ext", $pbf_file );

                warn "@system\n" if $debug >= 2;
                @system = 'true' if $test_mode;

                system(@system) == 0 or die "system @system failed: $?";
            }
        }
        elsif ( $format =~ /^csv\.(xz|gz|bz2)$/ ) {
            my $ext = $1;
            $file =~ s/\.pbf$/.csv.$ext/;
            if ( !cached_format( $file, $pbf_file ) ) {
                @system =
                  ( @nice, "$dirname/pbf2osm", "--csv-$ext", $pbf_file );

                warn "@system\n" if $debug >= 2;
                @system = 'true' if $test_mode;

                system(@system) == 0 or die "system @system failed: $?";
            }
        }

        elsif ($format =~ /^garmin-(osm|cycle|leisure|bbbike).zip$/
            || $format =~ /^[a-z\-]+\.garmin-(osm|cycle|leisure|srtm)\.zip$/ )
        {
            my $style      = $1;
            my $format_ext = $format;
            $format_ext =~ s/^[a-z\-]+\.garmin/garmin/;

            $file =~ s/\.pbf$/.$format_ext/;
            $file =~ s/.zip$/.$lang.zip/ if $lang ne "en";

            if ( !cached_format( $file, $pbf_file ) ) {
                @system = (
                    @nice, "$dirname/pbf2osm", "--garmin-$style", $pbf_file,
                    $city
                );
                warn "@system\n" if $debug >= 2;
                @system = 'true' if $test_mode;

                system(@system) == 0 or die "system @system failed: $?";
            }
        }
        elsif ( $format eq 'shp.zip' ) {
            $file =~ s/\.pbf$/.$format/;
            $file =~ s/.zip$/.$lang.zip/ if $lang ne "en";

            if ( !cached_format( $file, $pbf_file ) ) {
                @system =
                  ( @nice, "$dirname/pbf2osm", "--shape", $pbf_file, $city );

                warn "@system\n" if $debug >= 2;
                @system = 'true' if $test_mode;

                system(@system) == 0 or die "system @system failed: $?";
            }
        }
        elsif ( $format eq 'obf.zip' || $format =~ /^[a-z\-]+\.obf.zip$/ ) {
            my $format_ext = $format;
            $format_ext =~ s/^[a-z\-]+\.obf/obf/;

            $file =~ s/\.pbf$/.$format_ext/;
            $file =~ s/.zip$/.$lang.zip/ if $lang ne "en";

            if ( !cached_format( $file, $pbf_file ) ) {
                @system =
                  ( @nice, "$dirname/pbf2osm", "--osmand", $pbf_file, $city );

                warn "@system\n" if $debug >= 2;
                @system = 'true' if $test_mode;

                system(@system) == 0 or die "system @system failed: $?";
            }
        }
        elsif ( $format eq 'navit.zip' ) {
            $file =~ s/\.pbf$/.$format/;
            $file =~ s/.zip$/.$lang.zip/ if $lang ne "en";

            if ( !cached_format( $file, $pbf_file ) ) {
                @system =
                  ( @nice, "$dirname/pbf2osm", "--navit", $pbf_file, $city );

                warn "@system\n" if $debug >= 2;
                @system = 'true' if $test_mode;

                system(@system) == 0 or die "system @system failed: $?";
            }
        }
        elsif ($format =~ /^mapsforge-(osm)\.zip$/
            || $format =~ /^[a-z\-]+\.mapsforge-(osm)\.zip$/ )
        {
            my $style      = $1;
            my $format_ext = $format;
            $format_ext =~ s/^[a-z\-]+\.mapsforge/mapsforge/;

            $file =~ s/\.pbf$/.$format_ext/;
            $file =~ s/.zip$/.$lang.zip/ if $lang ne "en";

            if ( !cached_format( $file, $pbf_file ) ) {
                @system = (
                    @nice, "$dirname/pbf2osm", "--mapsforge-$style", $pbf_file,
                    $city
                );

                warn "@system\n" if $debug >= 2;
                @system = 'true' if $test_mode;

                system(@system) == 0 or die "system @system failed: $?";
            }
        }

        # cleanup poly file after successfull convert
        push @unlink, $poly_file if defined $poly_file;

        next if $test_mode;

        ###################################################################
        # keep a copy of .pbf in ./osm for further usage
        my $to = $spool->{'osm'} . "/" . basename($pbf_file);

        unlink($to);
        warn "link $pbf_file => $to\n" if $debug >= 2;
        link( $pbf_file, $to ) or die "link $pbf_file => $to: $!\n";
        aws_s3_put( 'file' => $to );

        my $file_size = file_size($to) . " MB";
        warn "file size $to: $file_size\n" if $debug >= 1;

        ###################################################################
        # copy for downloading in /download
        $to = $spool->{'download'} . "/" . basename($pbf_file);
        unlink($to);
        warn "link $pbf_file => $to\n" if $debug >= 1;
        link( $pbf_file, $to ) or die "link $pbf_file => $to: $!\n";

        ###################################################################
        # .osm.gz or .osm.bzip2 files?
        if ( $file ne $pbf_file ) {
            $to = $spool->{'download'} . "/" . basename($file);
            unlink($to);

            link( $file, $to ) or die "link $file => $to: $!\n";
            aws_s3_put( 'file' => $file );

            $file_size = file_size($to) . " MB";
            warn "file size $to: $file_size\n" if $debug >= 1;

            push @unlink, $file;
        }

        my $url = $option->{'homepage'} . "/" . basename($to);
        if ( $option->{"aws_s3_enabled"} ) {
            $url = $option->{"aws_s3"}->{"homepage"} . "/" . aws_s3_path($to);
        }

        my $checksum_sha256 = checksum( $to, "sha256" );
        my $checksum_md5    = checksum( $to, "md5" );

        # unlink temporary .pbf files after all files are proceeds
        if (@unlink) {
            warn "Unlink temp files: " . join( "", @unlink ) . "\n"
              if $debug >= 2;
            unlink(@unlink) or die "unlink: @unlink: $!\n";
        }

        $msg = get_msg( $obj->{"lang"} || "en" );

        ###################################################################
        # display uncompressed image file size
        if ( $option->{show_image_size} && $to =~ /\.zip$/ ) {
            $file_size .= " " . M("zip archive") . ", ";
            my $prog = dirname($0) . "/extract-disk-usage.sh";
            open my $fh, "$prog $to |" or die open "open $prog $to";

            my $du = -1;
            while (<$fh>) {
                warn $_;
                chomp;
                $du = $_;
            }

            $file_size .=
              file_size_mb( $du * 1024 ) . " MB " . M("uncompressed");
            warn "image file size $to: $file_size\n" if $debug >= 1;
        }

        ###################################################################
        # mail

        my $square_km = large_int(
            square_km(
                $obj->{"sw_lat"}, $obj->{"sw_lng"},
                $obj->{"ne_lat"}, $obj->{"ne_lng"}
            ),
            $obj->{'lang'}
        );

        next if !$send_email;

        my $script_url = &script_url( $option, $obj );
        my $database_update = gmctime( stat($planet_osm)->mtime ) . " UTC";

        my $text = M("EXTRACT_EMAIL");
        my $granularity;
        if ( grep { /^granularity=10000$/ } @{ $option->{"osmosis_options"} } )
        {
            $granularity = "10,000 (1.1 meters)";
        }
        elsif ( grep { /^granularity=1000$/ }
            @{ $option->{"osmosis_options"} } )
        {
            $granularity = "1,000 (11 cm)";
        }
        elsif ( grep { /^granularity=100$/ } @{ $option->{"osmosis_options"} } )
        {
            $granularity = "100 (1.1 cm)";
        }
        else {
            $granularity = "full";
        }

        my $message = sprintf( $text,
            $obj->{'city'},
            $url,
            $obj->{'city'},
qq[$obj->{"sw_lng"},$obj->{"sw_lat"} x $obj->{"ne_lng"},$obj->{"ne_lat"}],
            $script_url,
            $square_km,
            $granularity,
            $osmosis_options,
            $obj->{"format"},
            $file_size,
            $checksum_sha256,
            $checksum_md5,
            $database_update );

#        my $message = <<EOF;
#Hi,
#
#your requested OpenStreetMap area "$obj->{'city'}" was extracted from planet.osm
#To download the file, please click on the following link:
#
#  $url
#
#The file will be available for the next 48 hours. Please download the
#file as soon as possible.
#
# Name: $obj->{"city"}
# Coordinates: $obj->{"sw_lng"},$obj->{"sw_lat"} x $obj->{"ne_lng"},$obj->{"ne_lat"}
# Script URL: $script_url
# Square kilometre: $square_km
# Granularity: 10,000 (1.1 meters)
# Osmosis options: $osmosis_options
# Format: $obj->{"format"}
# File size: $file_size
# SHA256 checksum: $checksum
# Last planet.osm database update: $database_update
# License: OpenStreetMap License
#
#We appreciate any feedback, suggestions and a donation!
#You can support us via PayPal, Flattr or bank wire transfer.
#http://www.BBBike.org/community.html
#
#Sincerely, the BBBike extract Fairy
#
#--
#http://www.BBBike.org - Your Cycle Route Planner
#EOF

        my $subject =
            "BBBike extract: area '"
          . $obj->{'city'}
          . "', format="
          . $obj->{'format'}
          . " is ready for download";
        my @args = ( $obj->{'email'}, $subject, $message, $option->{'bcc'} );

        my $email_rest_enabled = $option->{"email_rest_enabled"};
        warn "email_rest_enabled: $email_rest_enabled\n" if $debug >= 2;
        if ($email_rest_enabled) {
            send_email_rest(@args);
        }
        else {
            send_email_smtp(@args);
        }
    }
}

sub aws_s3_put {
    my %args = @_;
    my $file = $args{'file'};

    if ( !$option->{"aws_s3_enabled"} ) {
        warn "AWS S3 upload disabled\n" if $debug >= 3;
        return;
    }

    if ( !defined $file || !-e $file ) {
        warn "No file '$file' given or exists for AWS S3 upload\n";
        return;
    }

    my $file_size = file_size($file) . " MB";
    warn "Upload $file with size $file_size to AWS S3\n" if $debug >= 1;

    my $sep = "/";
    my @system =
      ( $option->{"aws_s3"}->{"put_command"}, aws_s3_path($file), $file );
    warn join( " ", @system, "\n" ) if $debug >= 2;

    system(@system) == 0
      or die "system @system failed: $?";
}

sub aws_s3_path {
    my $file = shift;

    my $sep = "/";

    my $aws_path =
        $option->{"aws_s3"}->{"bucket"} 
      . $sep
      . $option->{"aws_s3"}->{"path"}
      . $sep
      . basename($file);

    return $aws_path;
}

#
# pbf2pbf postprocess
# e.g. make sure that lat,lon are in valid range -180 .. +180
#
sub fix_pbf {
    my $files     = shift;
    my $test_mode = shift;

    # all scripts are in these directory
    my $dirname = dirname($0);
    my $pbf2pbf = "$dirname/pbf2pbf";

    my @nice = ( "nice", "-n", $nice_level_converter );
    my @system;
    if ( $option->{"pbf2pbf_postprocess"} ) {
        warn "Run pbf2pbf post process\n" if $debug;

        foreach my $pbf (@$files) {
            @system = ( @nice, $pbf2pbf, $pbf );
            warn "Fix pbf $pbf\n" if $debug >= 2;
            @system = 'true' if $test_mode;

            system(@system) == 0
              or die "system @system failed: $?";
        }
    }
}

# compare 2 files and return the modification diff time in seconds
sub file_mtime_diff {
    my $file1 = shift;
    my $file2 = shift;

    my $st1 = stat($file1) or die "stat $file1: $!\n";
    my $st2 = stat($file2) or die "stat $file2: $!\n";

    return $st1->mtime - $st2->mtime;
}

# file size in x.y MB
sub file_size {
    my $file = shift;

    my $st = stat($file) or die "stat $file: $!\n";

    return file_size_mb( $st->size );
}

# sacle file size in x.y MB
sub file_size_mb {
    my $size = shift;

    foreach my $scale ( 10, 100, 1000, 10_000 ) {
        my $result = int( $scale * $size / 1024 / 1024 ) / $scale;
        return $result if $result > 0;
    }

    return "0.0";
}

# cat file
sub read_data {
    my $file = shift;

    warn "open file '$file'\n" if $debug >= 3;

    my $fh = new IO::File $file, "r" or die "open $file: $!\n";
    binmode $fh, ":utf8";
    my $data;

    while (<$fh>) {
        $data .= $_;
    }

    $fh->close;
    return $data;
}

sub create_lock {
    my %args     = @_;
    my $lockfile = $args{'lockfile'};

    warn "create lockfile: $lockfile, value: $$\n" if $debug >= 2;

    my $lockmgr = LockFile::Simple->make(
        -autoclean => 1,
        -max       => 5,
        -stale     => 1,
        -delay     => 1
    );
    if ( $lockmgr->trylock($lockfile) ) {
        return $lockmgr;
    }

    # return undefined for failure
    else {
        warn "Cannot get lockfile: $lockfile\n" if $debug >= 2;
        return;
    }
}

sub remove_lock {
    my %args = @_;

    my $lockfile = $args{'lockfile'};
    my $lockmgr  = $args{'lockmgr'};

    warn "remove lockfile: $lockfile\n" if $debug >= 2;
    $lockmgr->unlock($lockfile);

    #unlink($lockfile) or die "unlink $lockfile: $!\n";
}

sub get_msg {
    my $language = shift || $option->{'language'};

    my $file = $option->{'message_path'} . "/msg.$language.json";
    if ( !-e $file ) {
        warn "Language file $file not found, ignored\n" . qx(pwd);
        return {};
    }

    warn "Open message file $file for language $language\n" if $debug >= 1;
    my $json_text = read_data($file);

    my $json = new JSON;
    my $json_perl = eval { $json->decode($json_text) };
    die "json $file $@" if $@;

    warn Dumper($json_perl) if $debug >= 3;
    return $json_perl;
}

sub M {
    my $key = shift;

    my $text;
    if ( $msg && exists $msg->{$key} ) {
        $text = $msg->{$key};

        #} elsif ($msg_en && exists $msg_en->{$key}) {
        #    warn "Unknown translation local lang $lang: $key\n";
        #    $text = $msg_en->{$key};
    }
    else {
        if ( $debug >= 1 && $msg ) {
            warn "Unknown translation: $key\n"
              if $debug >= 2 || $language ne "en";
        }
        $text = $key;
    }

    if ( ref $text eq 'ARRAY' ) {
        $text = join "\n", @$text, "\n";
    }

    return $text;
}

sub cleanup_jobdir {
    my %args    = @_;
    my $job_dir = $args{'job_dir'};

    my $spool  = $args{'spool'};
    my $json   = $args{'json'};
    my $errors = $args{'errors'};

    # keep a copy of failed request in trash can
    my $keep = $args{'keep'} || 0;

    my $failed_dir = $spool->{'failed'};
    warn "Cleanup job dir: $job_dir\n" if $debug >= 2;

    my @system;
    if ( !-d $job_dir ) {
        warn "Oops, $job_dir not found\n";
        return;
    }

    system( 'ls', '-la', $job_dir ) if $debug >= 3;

    if ( $errors && $keep ) {
        my $to_dir = "$failed_dir/" . basename($job_dir);
        warn "Keep job dir: $to_dir\n" if $debug;

        @system = ( 'rm', '-rf', $to_dir );
        system(@system) == 0
          or die "system @system failed: $?";
        @system = ( 'mv', '-f', $job_dir, $failed_dir );
        system(@system) == 0
          or die "system @system failed: $?";

    }
    else {
        @system = ( 'rm', '-rf', $job_dir );
        system(@system) == 0
          or die "system @system failed: $?";
    }
}

sub usage () {
    <<EOF;
usage: $0 [ options ]

--debug={0..2}		debug level, default: $debug
--nice-level={0..20}	nice level for osmosis, default: $option->{nice_level}
--job={1..4}		job number for parallels runs, default: $option->{max_jobs}
--timeout=1..86400	time out, default $option->{"alarm"}
--send-email={0,1}	send out email, default: $option->{"send_email"}
--planet-osm=/path/to/planet.osm.pbf  default: $option->{"planet"}->{"planet.osm"}
--spool-dir=/path/to/spool 	      default: $option->{spool_dir}
--test-mode		do not execude commands
EOF
}

sub run_jobs {
    my %args       = @_;
    my $max_jobs   = $args{'max_jobs'};
    my $send_email = $args{'send_email'};
    my $max_areas  = $args{'max_areas'};
    my $files      = $args{'files'};
    my $test_mode  = $args{'test_mode'};

    my @files = @$files;
    my $lockfile;
    my $lockmgr;

    warn "Start job at: @{[ gmctime() ]} UTC\n" if $debug;

    #############################################################
    # semaphore for parsing the jobs
    # run only one extract.pl script at once while parsing
    #
    my $lockfile_extract = $spool->{'running'} . "/extract.pid";
    my $lockmgr_extract = &create_lock( 'lockfile' => $lockfile_extract )
      or die "Cannot get lockfile $lockfile_extract, give up\n";
    warn "Use lockfile $lockfile_extract\n" if $debug;

    &remove_lock(
        'lockfile' => $lockfile_extract,
        'lockmgr'  => $lockmgr_extract
    );

    # find a free job
    foreach my $number ( 1 .. $max_jobs ) {
        my $file = $spool->{'running'} . "/job${number}.pid";

        # lock pid
        if ( $lockmgr = &create_lock( 'lockfile' => $file ) ) {
            $lockfile = $file;
            last;
        }
    }

    # Oops, are jobs are in use, give up
    if ( !$lockfile ) {
        &remove_lock(
            'lockfile' => $lockfile_extract,
            'lockmgr'  => $lockmgr_extract
        );
        die "Cannot get lock for jobs 1..$max_jobs\n" . qx(uptime);
    }

    warn "Use lockfile $lockfile\n" if $debug;

    my ( $list, $planet_osm ) = parse_jobs(
        'files' => \@files,
        'dir'   => $spool->{'confirmed'},
        'max'   => $max_areas,
    );
    my @list = @$list;

    if ( !@list ) {
        print "Nothing to do for users\n" if $debug >= 2;
        &remove_lock(
            'lockfile' => $lockfile_extract,
            'lockmgr'  => $lockmgr_extract
        );
        exit 0;
    }

    print "run jobs: " . Dumper( \@list ) if $debug >= 3;

    my $key     = get_job_id(@list);
    my $job_dir = $spool->{'running'} . "/$key";

    my ( $poly, $json ) = create_poly_files(
        'job_dir' => $job_dir,
        'list'    => \@list,
        'spool'   => $spool,
    );

    # EOF semaphone block
    &remove_lock(
        'lockfile' => $lockfile_extract,
        'lockmgr'  => $lockmgr_extract
    );
    ############################################################

    # be paranoid, give up after N hours (java bugs?)
    &set_alarm( $alarm, "osmosis" );

    ###########################################################
    # main
    my ( $system, $new_pbf_files ) = run_extracts(
        'spool'      => $spool,
        'poly'       => $poly,
        'planet_osm' => $planet_osm
    );
    my @system = @$system;

    ###########################################################

    my $time      = time();
    my $starttime = $time;
    warn "Run ", join " ", @system, "\n" if $debug > 2;
    @system = 'true' if $test_mode;

    system(@system) == 0
      or die "system @system failed: $?";

    &fix_pbf( $new_pbf_files, $test_mode );
    warn "Running extract time: ", time() - $time, " seconds\n" if $debug;

    # send out mail
    $time = time();
    my $errors = &convert_send_email(
        'json'       => $json,
        'send_email' => $send_email,
        'alarm'      => $option->{alarm_convert},
        'test_mode'  => $test_mode,
        'planet_osm' => $planet_osm,
        'keep'       => 1
    );

    warn "Total convert and email time: ", time() - $time, " seconds\n"
      if $debug;
    warn "Total time: ", time() - $starttime,
      " seconds, for @{[ scalar(@list) ]} job(s)\n"
      if $debug;
    warn "Number of errors: $errors\n" if $errors;

    # unlock pid
    &remove_lock( 'lockfile' => $lockfile, 'lockmgr' => $lockmgr );

    &cleanup_jobdir(
        'job_dir' => $job_dir,
        'spool'   => $spool,
        'json'    => $json,
        'keep'    => 1,
        'errors'  => $errors
    );

    return $errors;
}

######################################################################
# main
#

# current running parallel job number (1..4)
my $max_jobs = $option->{'max_jobs'};
my $help;
my $timeout;
my $max_areas  = $option->{'max_areas'};
my $send_email = $option->{'send_email'};
my $spool_dir  = $option->{'spool_dir'};
my $test_mode  = 0;

GetOptions(
    "debug=i"      => \$debug,
    "nice-level=i" => \$nice_level,
    "job=i"        => \$max_jobs,
    "timeout=i"    => \$timeout,
    "max-areas=i"  => \$max_areas,
    "send-email=i" => \$send_email,
    "planet-osm=s" => \$planet_osm,
    "spool-dir=s"  => \$spool_dir,
    "help"         => \$help,
    "test-mode!"   => \$test_mode,
) or die usage;

die usage if $help;
die "Max jobs: $max_jobs out of range!\n" . &usage
  if $max_jobs < 1 || $max_jobs > 12;
die "Max areas: $max_areas out of range 1..64!\n" . &usage
  if $max_areas < 1 || $max_areas > 64;

$option->{"planet"}->{"planet.osm"} = $planet_osm;

# full path for spool directories
while ( my ( $key, $val ) = each %$spool ) {
    $spool->{$key} = "$spool_dir/$val";
}

my @files = get_jobs( $spool->{'confirmed'} );
if ( !scalar(@files) ) {
    print "Nothing to do\n" if $debug >= 2;
    exit 0;
}

if ( defined $timeout ) {
    die "Timeout: $timeout out of range!\n" . &usage
      if ( $timeout < 1 || $timeout > 86_400 );
    $alarm = $timeout;
}

my $loadavg = &get_loadavg;
if ( $loadavg > $option->{max_loadavg} ) {
    my $max_loadavg_jobs = $option->{max_loadavg_jobs};
    if ( $max_loadavg_jobs >= 1 ) {
        warn
"Load avarage $loadavg is to high, reset max jobs to: $max_loadavg_jobs\n"
          if $debug >= 1;
        $max_jobs = $max_loadavg_jobs;
    }

    else {
        die "Load avarage $loadavg is to high, give up!\n";
    }
}

my $errors = &run_jobs(
    'test_mode'  => $test_mode,
    'max_jobs'   => $max_jobs,
    'send_email' => $send_email,
    'max_areas'  => $max_areas,
    'files'      => \@files
);

exit($errors);

1;
