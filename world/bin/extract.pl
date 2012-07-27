#!/usr/local/bin/perl
# Copyright (c) 2011-2012 Wolfram Schneider, http://bbbike.org
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
use Encode qw/encode_utf8/;
use Email::Valid;
use Digest::MD5 qw(md5_hex);
use Net::SMTP;
use CGI qw(escapeHTML);
use Getopt::Long;
use File::Basename;
use File::stat;
use GIS::Distance::Lite;

use strict;
use warnings;

$ENV{'PATH'} = "/usr/local/bin:/bin:/usr/bin";

# group writable file
umask(002);

binmode \*STDOUT, ":utf8";
binmode \*STDERR, ":utf8";

our $option = {
    'max_areas'       => 6,
    'homepage'        => 'http://download.bbbike.org/osm/extract',
    'script_homepage' => 'http://extract.bbbike.org',
    'max_jobs'        => 3,
    'bcc'             => 'bbbike@bbbike.org',
    'email_from'      => 'bbbike@bbbike.org',
    'send_email'      => 1,

    # timeout handling
    'alarm' => 3 * 60 * 60,

    # run with lower priority
    'nice_level' => 2,

    'planet_osm' => "../osm-streetnames/download/planet-latest.osm.pbf",
    'debug'      => 0,
    'test'       => 0,

    # spool directory. Should be at least 100GB large
    'spool_dir' => '/var/cache/extract',

    'file_prefix' => 'planet_',

    # reset max_jobs if load is to high
    'max_loadavg'      => 8,
    'max_loadavg_jobs' => 2,    # 0: stop running at all
};

my $formats = {
    'osm.pbf'            => 'Protocolbuffer Binary Format (PBF)',
    'osm.gz'             => "OSM XML gzip'd",
    'osm.bz2'            => "OSM XML bzip'd",
    'osm.xz'             => "OSM XML 7z/xz",
    'osm.shp.zip'        => "OSM Shape",
    'osm.obf.zip'        => "Osmand (OBF)",
    'garmin-osm.zip'     => "Garmin OSM",
    'garmin-cycle.zip'   => "Garmin Cycle",
    'garmin-leisure.zip' => "Garmin Leisure",
};

#
# Parse user config file.
# This allows to override standard config values
#
my $config_file = "$ENV{HOME}/.bbbike-extract.rc";
if ( -e $config_file ) {
    require $config_file;
}

my $spool_dir = $option->{"spool_dir"};
my $spool     = {
    'incoming'  => "$spool_dir/incoming",  # incoming request, not confirmed yet
    'confirmed' => "$spool_dir/confirmed", # ready to run
    'running'   => "$spool_dir/running",   # currently running job
    'osm'       => "$spool_dir/osm",       # cache older runs
    'download'  => "$spool_dir/download",  # final directory for download
    'trash'  => "$spool_dir/trash",    # keep a copy of the config for debugging
    'failed' => "$spool_dir/failed",   # keep record of failed runs

    # 'jobN'  => "$spool_dir/job1.pid",     # lock file for current job
};

my $alarm           = $option->{"alarm"};
my $nice_level      = $option->{"nice_level"};
my $email_from      = $option->{"email_from"};
my $planet_osm      = $option->{"planet_osm"};
my $debug           = $option->{"debug"};
my $test            = $option->{"test"};
my $osmosis_options = "omitmetadata=true granularity=10000";    # message

# test & debug
$planet_osm =
"/home/wosch/projects/osm-streetnames/download/geofabrik/europe/germany/brandenburg.osm.pbf"
  if $test;

######################################################################
#
#

# timeout handler
sub set_alarm {
    my $time = shift;

    $time = $alarm if !defined $time;

    $SIG{ALRM} = sub {

        warn "Time out alarm $time\n";

        # sends a hang-up signal to all processes in the current process group
        # and kill running java processes
        local $SIG{HUP} = "IGNORE";
        kill 1, -$$;

        sleep 1;
        local $SIG{TERM} = "IGNORE";
        kill 15, -$$;

        warn "Send a hang-up to all childs. Exit\n";
        exit 1;
    };

    warn "set alarm time to: $time seconds\n" if $debug >= 1;
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

    return $int if $int < 1_000;

    my $number = substr( $int, 0, -3 ) . "," . substr( $int, -3, 3 );
    return $number;
}

# fair scheduler, take one from each customer first until
# we reach the limit
sub parse_jobs {
    my %args = @_;

    my $dir   = $args{'dir'};
    my $files = $args{'files'};
    my $max   = $args{'max'};

    my $hash;
    foreach my $f (@$files) {
        my $file = "$dir/$f";

        my $fh = new IO::File $file, "r" or die "open $file: $!\n";
        binmode $fh, ":utf8";

        my $json_text;
        while (<$fh>) {
            $json_text .= $_;
        }
        $fh->close;

        my $json = new JSON;
        my $json_perl = eval { $json->decode($json_text) };
        die "json $file $@" if $@;

        $json_perl->{"file"} = $f;

        # a slot for every user
        push @{ $hash->{ $json_perl->{'email'} } }, $json_perl;
    }

    # sort by user and date, oldest first
    foreach my $email ( keys %$hash ) {
        $hash->{$email} =
          [ sort { $a->{"time"} <=> $b->{"time"} } @{ $hash->{$email} } ];
    }

    # fair scheduler, take one from each customer first
    my @list;
    my $counter = $max;
    while ( $counter-- > 0 ) {
        foreach my $email ( sort keys %$hash ) {
            if ( scalar( @{ $hash->{$email} } ) ) {
                my $obj = shift @{ $hash->{$email} };
                push @list, $obj;
            }
            last if scalar(@list) >= $max;
        }
        last if scalar(@list) >= $max;
    }

    return @list;
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

# store lat,lng in a file name
sub file_latlng {
    my $obj  = shift;
    my $file = "";

    $file = $option->{'file_prefix'}
      . "$obj->{sw_lat},$obj->{sw_lng}_$obj->{ne_lat},$obj->{ne_lng}";

    return $file;
}

# store lng,lat in file name
sub file_lnglat {
    my $obj  = shift;
    my $file = "";

    $file = $option->{'file_prefix'}
      . "$obj->{sw_lng},$obj->{sw_lat}_$obj->{ne_lng},$obj->{ne_lat}";

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
            &touch_file($pbf_file);
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
    my $file = shift;

    my @system = ( "touch", $file );

    warn "touch $file\n" if $debug;
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

    $data .= "   $obj->{sw_lng}  $obj->{sw_lat}\n";
    $data .= "   $obj->{ne_lng}  $obj->{sw_lat}\n";
    $data .= "   $obj->{ne_lng}  $obj->{ne_lat}\n";
    $data .= "   $obj->{sw_lng}  $obj->{ne_lat}\n";

    $data .= "END\n";
    $data .= "END\n";

    if ( -e $file ) {
        warn "poly file $file already exists!\n";
        return;
    }

    warn "create poly file $file\n" if $debug >= 2;
    store_data( $file, $data );
}

#
# extract area(s) from planet.osm with osmosis tool
#
sub run_extracts {
    my %args  = @_;
    my $spool = $args{'spool'};
    my $poly  = $args{'poly'};

    my $osm = $spool->{'osm'};

    warn Dumper($poly) if $debug >= 3;
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
            my $newer = file_mtime_diff( $osm, $option->{planet_osm} );
            if ( $newer > 0 ) {
                warn "File $osm already exists, skip\n" if $debug;
                link( $osm, $out ) or die "link $osm => $out: $!\n";
                &touch_file($osm);
                next;
            }
            else {
                warn "file $osm already exists, ",
                  "but a new planet.osm is here since ", abs($newer),
                  " seconds. Rebuild.\n";
            }
        }

        push @pbf, "--bp", "file=$p";
        push @pbf, "--write-pbf", "file=$out", "omitmetadata=true";
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

    warn join( " ", @data ), "\n" if $debug >= 2;
    return (\@data, \@fixme);
}

# compute SHA2 checksum for extract file
sub checksum {
    my $file = shift;
    die "file $file does not exists\n" if !-f $file;

    my @checksum_command = qw/shasum -a 256/;

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
sub _send_email {
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

# check if we need to run a pbf2osm converter
sub cached_format {
    my $file = shift;

    my $to = $spool->{'download'} . "/" . basename($file);
    if ( -e $file && -s $file ) {
        warn "File $file already exists, skip...\n" if $debug >= 1;
        return 1;
    }
    elsif ( -e $to && -s $to ) {
        warn "Converted file $to already exists, skip...\n" if $debug >= 1;

        warn "link $file => $to\n" if $debug >= 2;
        link( $to, $file ) or die "link $to -> $file: $!\n";

        return 1;
    }

    return 0;
}

# prepare to sent mail about extracted area
sub send_email {
    my %args       = @_;
    my $json       = $args{'json'};
    my $send_email = $args{'send_email'};

    # all scripts are in these directory
    my $dirname = dirname($0);

    my @unlink;
    foreach my $json_file (@$json) {
        my @system;

        my $json_text = read_data($json_file);
        my $json      = new JSON;
        my $obj       = $json->decode($json_text);
        my $format    = $obj->{'format'};

        warn "json: $json_file\n" if $debug >= 3;
        warn "json: $json_text\n" if $debug >= 3;

        my $pbf_file = $obj->{'pbf_file'};

        ###################################################################
        # converted file name
        my $file = $pbf_file;

        # convert .pbf to .osm if requested
        my @nice = ( "nice", "-n", $nice_level );
        if ( $format eq 'osm.bz2' ) {
            $file =~ s/\.pbf$/.bz2/;
            if ( !cached_format($file) ) {
                @system = ( @nice, "$dirname/pbf2osm", "--bzip2", $pbf_file );

                warn "@system\n" if $debug >= 2;
                system(@system) == 0 or die "system @system failed: $?";
            }
        }
        elsif ( $format eq 'osm.gz' ) {
            $file =~ s/\.pbf$/.gz/;
            if ( !cached_format($file) ) {
                @system = ( @nice, "$dirname/pbf2osm", "--gzip", $pbf_file );

                warn "@system\n" if $debug >= 2;
                system(@system) == 0 or die "system @system failed: $?";
            }
        }
        elsif ( $format eq 'osm.xz' ) {
            $file =~ s/\.pbf$/.xz/;
            if ( !cached_format($file) ) {
                @system = ( @nice, "$dirname/pbf2osm", "--xz", $pbf_file );

                warn "@system\n" if $debug >= 2;
                system(@system) == 0 or die "system @system failed: $?";
            }
        }
        elsif ( $format =~ /^garmin-(osm|cycle|leisure).zip$/ ) {
	    my $style = $1;
            $file =~ s/\.pbf$/.$format/;
            if ( !cached_format($file) ) {
                @system = ( @nice, "$dirname/pbf2osm", "--garmin-$style", $pbf_file );
                warn "@system\n" if $debug >= 2;
                system(@system) == 0 or die "system @system failed: $?";
            }
        }
        elsif ( $format eq 'osm.shp.zip' ) {
            $file =~ s/\.osm\.pbf$/.$format/;
            if ( !cached_format($file) ) {
                @system = ( @nice, "$dirname/pbf2osm", "--shape", $pbf_file );

                warn "@system\n" if $debug >= 2;
                system(@system) == 0 or die "system @system failed: $?";
            }
        }
        elsif ( $format eq 'osm.obf.zip' ) {
            $file =~ s/\.osm\.pbf$/.$format/;
            if ( !cached_format($file) ) {
                @system = ( @nice, "$dirname/pbf2osm", "--osmand", $pbf_file );

                warn "@system\n" if $debug >= 2;
                system(@system) == 0 or die "system @system failed: $?";
            }
        }

        ###################################################################
        # keep a copy of .pbf in ./osm for further usage
        my $to = $spool->{'osm'} . "/" . basename($pbf_file);

        unlink($to);
        warn "link $pbf_file => $to\n" if $debug >= 2;
        link( $pbf_file, $to ) or die "link $pbf_file => $to: $!\n";

        my $file_size = file_size($to) . " MB";
        warn "file size $to: $file_size\n" if $debug >= 1;

        ###################################################################
        # copy for downloading in /download
        $to = $spool->{'download'} . "/" . basename($pbf_file);
        unlink($to);
        warn "link $pbf_file => $to\n" if $debug >= 1;
        link( $pbf_file, $to ) or die "link $pbf_file => $to: $!\n";

        push @unlink, $pbf_file;

        ###################################################################
        # .osm.gz or .osm.bzip2 files?
        if ( $file ne $pbf_file ) {
            $to = $spool->{'download'} . "/" . basename($file);
            unlink($to);

            link( $file, $to ) or die "link $file => $to: $!\n";

            $file_size = file_size($to) . " MB";
            warn "file size $to: $file_size\n" if $debug >= 1;
        }

        my $url = $option->{'homepage'} . "/" . basename($to);

        my $checksum = checksum($to);

        ###################################################################
        # mail

        my $square_km = large_int(
            square_km(
                $obj->{"sw_lat"}, $obj->{"sw_lng"},
                $obj->{"ne_lat"}, $obj->{"ne_lng"}
            )
        );

        next if !$send_email;

        my $script_url =
            $option->{script_homepage}
          . "/?sw_lng=$obj->{sw_lng}&sw_lat=$obj->{sw_lat}&ne_lng=$obj->{ne_lng}&ne_lat=$obj->{ne_lat}"
          . "&format=$obj->{'format'}";

        my $message = <<EOF;
Hi,

your requested OpenStreetMap area "$obj->{'city'}" was extracted 
from planet.osm

 Name: $obj->{"city"}
 Coordinates: $obj->{"sw_lng"},$obj->{"sw_lat"} x $obj->{"ne_lng"},$obj->{"ne_lat"}
 Script URL: $script_url
 Square kilometre: $square_km
 Granularity: 10,000 (1.1 meters)
 Osmosis options: $osmosis_options
 Format: $obj->{"format"}
 File size: $file_size
 SHA256 checksum: $checksum
 License: OpenStreetMap License

To download the file, please click on the following link:

  $url

The file will be available for the next 48 hours. Please 
download the file as soon as possible.

Sincerely, your BBBike admin

--
http://www.BBBike.org - Your Cycle Route Planner
We appreciate any feedback, suggestions and a donation! 
EOF

        eval {
            _send_email( $obj->{'email'},
                "Extracted area is ready for download: " . $obj->{'city'},
                $message, $option->{'bcc'} );
        };

        if ($@) {
            warn "$@";
            return 0;
        }

    }

    # unlink temporary .pbf files after all files are proceeds
    unlink(@unlink) or die "unlink: @unlink: $!\n";

    warn "number of email sent: ", scalar(@$json), "\n"
      if $send_email && $debug >= 1;
}

# prepare to sent mail about extracted area
sub fix_pbf {
    my $files       = shift;

    # all scripts are in these directory
    my $dirname = dirname($0);
    my $pbf2pbf = "$dirname/pbf2pbf";

    my @system;    
    foreach my $pbf (@$files) {
        @system = ($pbf2pbf, $pbf);
            system(@system) == 0
          or die "system @system failed: $?";
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

    foreach my $scale ( 10, 100, 1000, 10_000 ) {
        my $result = int( $scale * $st->size / 1024 / 1024 ) / $scale;
        return $result if $result > 0;
    }

    return "0.0";
}

# cat file
sub read_data {
    my ($file) = @_;

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
    my %args = @_;

    my $lockfile = $args{'lockfile'};

    if ( -e $lockfile ) {
        my $pid = read_data($lockfile);
        if ( kill( 0, $pid ) ) {
            warn "$pid is still running\n";
            return 0;
        }
        else {
            warn "$pid is no longer running\n";
            remove_lock( 'lockfile' => $lockfile );
        }
    }

    warn "create lockfile: $lockfile\n" if $debug >= 2;
    store_data( $lockfile, $$ );
    return 1;
}

sub remove_lock {
    my %args = @_;

    my $lockfile = $args{'lockfile'};

    warn "remove lockfile: $lockfile\n" if $debug >= 2;
    unlink($lockfile) or die "unlink $lockfile: $!\n";
}

sub cleanup_jobdir {
    my %args    = @_;
    my $job_dir = $args{'job_dir'};

    my $spool = $args{'spool'};
    my $json  = $args{'json'};

    # keep a copy of the config file for a request in trash can
    my $keep = $args{'keep'} || 0;

    my $trash_dir = $spool->{'trash'};
    if ($keep) {
        warn "Keep copy of json config files\n" if $debug >= 2;

        foreach my $file (@$json) {
            my $to = "$trash_dir/" . basename($file);
            unlink($to);
            warn "keep copy of json file: $to\n" if $debug >= 3;
            link( $file, $to ) or die "link $file => $to: $!\n";
        }
    }

    warn "remove job dir: $job_dir\n" if $debug >= 2;

    if ( -d $job_dir ) {
        my @system = ( 'rm', '-rf', $job_dir );
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
EOF
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

GetOptions(
    "debug=i"      => \$debug,
    "nice-level=i" => \$nice_level,
    "job=i"        => \$max_jobs,
    "timeout=i"    => \$timeout,
    "max-areas=i"  => \$max_areas,
    "send-email=i" => \$send_email,
    "help"         => \$help,
) or die usage;

die usage if $help;
die "Max jobs: $max_jobs out of range!\n" . &usage
  if $max_jobs < 1 || $max_jobs > 12;
die "Max areas: $max_areas out of range!\n" . &usage
  if $max_areas < 1 || $max_areas > 30;

my $loadavg = &get_loadavg;
if ( $loadavg > $option->{max_loadavg} ) {
    my $max_loadavg_jobs = $option->{max_loadavg_jobs};
    if ( $max_loadavg_jobs >= 1 ) {
        warn
"Load avarage $loadavg is to high, reset max jobs to: $max_loadavg_jobs\n";
        $max_jobs = $max_loadavg_jobs;
    }
    else {
        die "Load avarage $loadavg is to high, give up!\n";
    }
}

if ( defined $timeout ) {
    die "Timeout: $timeout out of range!\n" . &usage
      if ( $timeout < 1 || $timeout > 86_400 );
    $alarm = $timeout;
}

my @files = get_jobs( $spool->{'confirmed'} );

if ( !scalar(@files) ) {
    print "Nothing to do\n" if $debug >= 2;
    exit;
}

{
    my $lockfile;

    # find a free job
    foreach my $number ( 1 .. $max_jobs ) {
        my $file = "$spool_dir/job${number}.pid";

        # lock pid
        if ( &create_lock( 'lockfile' => $file ) ) {
            $lockfile = $file;
            last;
        }
    }

    # Oops, are jobs are in use, give up
    die "Cannot get lock for jobs 1..$max_jobs\n"
      if !$lockfile;
    warn "Use lockfile $lockfile\n" if $debug;

    my @list = parse_jobs(
        'files' => \@files,
        'dir'   => $spool->{'confirmed'},
        'max'   => $max_areas,
    );
    print Dumper( \@list ) if $debug >= 3;

    my $key     = get_job_id(@list);
    my $job_dir = $spool->{'running'} . "/$key";

    my ( $poly, $json ) = create_poly_files(
        'job_dir' => $job_dir,
        'list'    => \@list,
        'spool'   => $spool,
    );

    # be paranoid, give up after N hours (java bugs?)
    &set_alarm($alarm);

    ###########################################################
    # main
    my ($system, $new_pbf_files) = run_extracts( 'spool' => $spool, 'poly' => $poly );
    my @system = @$system;
    
    ###########################################################

    my $time      = time();
    my $starttime = $time;
    warn "Run ", join " ", @system, "\n" if $debug > 2;
    system(@system) == 0
      or die "system @system failed: $?";

    &fix_pbf($new_pbf_files);
    warn "Running extract time: ", time() - $time, " seconds\n" if $debug;

    # send out mail
    $time = time();
    &send_email( 'json' => $json, 'send_email' => $send_email );

    warn "Running convert and email time: ", time() - $time, " seconds\n"
      if $debug;
    warn "Total time: ", time() - $starttime,
      " seconds, for @{[ scalar(@list) ]} jobs\n"
      if $debug;

    # unlock pid
    &remove_lock( 'lockfile' => $lockfile );

    &cleanup_jobdir(
        'job_dir' => $job_dir,
        'spool'   => $spool,
        'json'    => $json,
        'keep'    => 1
    );
}

1;
