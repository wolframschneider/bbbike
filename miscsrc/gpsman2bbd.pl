#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: gpsman2bbd.pl,v 2.11 2007/09/06 23:35:00 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 2002,2003 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://www.rezic.de/eserte/
#

# Convert from gpsman to bbd data

package BBBike::GpsmanConv;

use strict;

BEGIN {
    if (!caller(2)) { # (...) because of BEGIN block XXX 2 is correct?
	eval <<'EOF';
use FindBin;
use lib ("$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	);
EOF
        die $@ if $@;
    }
}

use GPS::GpsmanData;
use Strassen::Core;
use Getopt::Long;
use Karte;
use File::Basename;
use File::Spec;

Karte::preload(qw(Polar Standard));

sub gpsman2bbd {
    local @ARGV = @_;

    my $destdir = "/tmp";
    # XXX should not be hardcoded...
    my $deststreets = "streets.bbd";
    my $destpoints = "points.bbd";
    my $breakmin = 5;
    my $breakdist = 0;
    my @pcat  = (qw(GPSp GPSp~ GPSp~~ GPSp?));
    my @scat  = (qw(GPSs GPSs~ GPSs~~ GPSs?));
    my $destmaptoken = "standard";
    my $add_prefix;
    my $prefix = "";
    my $force_points;
    my $update;
    my $fail = 1;

    if (!GetOptions("destdir=s" => \$destdir,
		    "deststreets=s" => \$deststreets,
		    "destpoints=s" => \$destpoints,
		    "breakmin=f" => \$breakmin,
		    "breakdist=i" => \$breakdist,
		    "pcat=s" => \$pcat[0],
		    "scat=s" => \$scat[0],
		    "scat1=s" => \$scat[1],
		    "scat2=s" => \$scat[2],
		    "destmap=s" => \$destmaptoken,
		    "addprefix!" => \$add_prefix,
		    "prefix=s" => \$prefix,
		    "forcepoints" => \$force_points,
		    "update" => \$update,
		    "fail!" => \$fail,
		   )) {
	die <<EOF;
Usage: $0 [-destdir directory] [-deststreets basename.bbd]
          [-destpoints basename.bbd] [-breakmin minutes]
          [-breakdist meters]
	  [-destmap maptoken] [-addprefix]
          [-pcat cat] [-scat cat] [-scat1 cat] [-scat2 cat]
	  [-forcepoints] [-update] [-[no]fail]
	  gpsmanfiles ...

-destdir:     destination directory, default: $destdir
-deststreets: basename of destination file for streets, default: $deststreets
-destpoints:  basename of destination file for points, default: $destpoints
-breakmin:    break lines if gap greater than (by default) $breakmin minutes
-breakdist:   break lines if gap greater than ... meters (by default: disabled)
-pcat:        category (or color #rrggbb) for points
-scat:        category (or color #rrggbb) for streets
-scat1:       category for inaccurate streets (-scat2 for more inaccuracy)
-destmap:     token of destination coord system (default: $destmaptoken)
              may be also of the format file:\$filename
-addprefix:   add map token to coordinates
-forcepoints: force creation of points file for tracks
-update:      update, should be faster if only some files changed
-[no]fail:    (do not) fail on non existing source files
EOF

    }

    my $s = Strassen->new;
    my $p = Strassen->new;

    if (!@ARGV) {
	die "No source files given";
    }

    my $destmap;
    my $gkk_zone;
    if ($destmaptoken eq 'etrs89') {
	require Karte::ETRS89;
	require Karte::UTM;
    } elsif ($destmaptoken =~ /^gkk(\d+)/) {
	require Karte::UTM;
	$gkk_zone = $1;
    } elsif ($destmaptoken ne 'standard') {
	Karte::preload(":all");
    }
    if ($destmaptoken =~ /^file:(.*)/) {
	my $file = $1;
	$destmap = Karte::object_from_file($file);
	die "Can't get object from $file" if !$destmap;
    } else {
	$destmap = $Karte::map{$destmaptoken};
    }
    if ($add_prefix) {
	$prefix = $destmap->coordsys;
    }

    my $deststreetspath = File::Spec->file_name_is_absolute($deststreets) ? $deststreets : File::Spec->catfile($destdir, $deststreets);
    my $destpointspath  = File::Spec->file_name_is_absolute($destpoints) ? $destpoints : File::Spec->catfile($destdir, $destpoints);

    if ($update && (!-e $deststreetspath || !-e $destpointspath)) {
	$update = 0;
	warn "Turning off -update";
    }

    foreach my $f (@ARGV) {
	print STDERR "$f...";
	if ($update) {
	    # XXX use ->Type instead of looking at the extension ...
	    # but this means I have to use ->load, which is expensive
	    if (-e $deststreetspath && $f =~ /\.trk$/ && -M $f > -M $deststreetspath) {
		print STDERR " is current, skipping\n";
		next;
	    }
	    if (-e $destpointspath && $f =~ /\.wpt$/ && -M $f > -M $destpointspath) {
		print STDERR " is current, skipping\n";
		next;
	    }
	}
	print STDERR "\n";

	my $base = basename $f;
	my $gps_multi;
	eval {
	    $gps_multi = GPS::GpsmanMultiData->new;
	    $gps_multi->load($f);
	};
	if ($@) {
	    if ($fail) {
		die $@;
	    } else {
		warn $@;
		next;
	    }
	}

	my $vehicle; # remember vehicle across chunks
	my %brand;   # vehicle -> brand

	for my $gps (@{ $gps_multi->Chunks }) {
	    #XXX $gps->convert_all("DDD");

	    my $brand;

	    my $curr_s;
	    if ($gps->Type eq GPS::GpsmanData::TYPE_TRACK()) {
	        $curr_s = $s;
		if ($gps->TrackAttrs->{"srt:vehicle"}) {
		    $vehicle = $gps->TrackAttrs->{"srt:vehicle"};
		}
		$brand = $gps->TrackAttrs->{"srt:brand"};
		if (!$brand) {
		    if ($brand{$vehicle}) {
			$brand = $brand{$vehicle}; # remember from last
		    }
		} else {
		    $brand{$vehicle} = $brand;
		}
	    } else {
	        $curr_s = $p;
	    }

	    my @street_coords;
	    my $last_is_inaccurate = 0;
	    my $push_streets = sub {
		if (@street_coords) {
		    my $name = $base;
		    if ($vehicle) { # XXX yes? no? && $vehicle ne 'bike') {
			$name .= " ($vehicle";
			if ($brand) {
			    $name .= "/$brand";
			}
			$name .= ")";
		    }
		    $s->push([$name, [@street_coords], $scat[$last_is_inaccurate]]);
		    @street_coords = ();
		    $last_is_inaccurate = 0;
		}
	    };

	    my $last_wpt;
	    foreach my $wpt (@{ $gps->Points }) {
		# XXX hmmm... maybe allow float values everywhere???
		my($x,$y);
		if ($destmaptoken eq 'etrs89') {
		    my @utm = Karte::UTM::DegreesToUTM
			($wpt->Latitude, $wpt->Longitude);
		    ($x,$y) = map { int } Karte::ETRS89::UTMToETRS89(@utm);
		} elsif (defined $gkk_zone) {
		    my(@gkk) = Karte::UTM::DegreesToGKK
			($wpt->Latitude, $wpt->Longitude, undef, $gkk_zone);
		    ($x, $y) = map { int } @gkk[1,2];
		} else {
		    ($x,$y) = map { $destmaptoken eq 'polar' ? $_ : int }
			$Karte::map{"polar"}->map2map
			    ($destmap, $wpt->Longitude, $wpt->Latitude);
		}
		my $alt = $wpt->Altitude;
		my $inaccurate = $wpt->Accuracy;

		if ($curr_s eq $p) {
		    my $l = [$base . "/" . $wpt->Ident . "/" . $wpt->Comment . (defined $alt ? " alt=".sprintf("%.1fm",$alt) : ""), ["$prefix$x,$y"], $pcat[0]];
		    $p->push($l);
	        } elsif ($force_points) {
		    my $ident = $wpt->Ident;
		    if ($ident eq '') {
			if ($wpt->Comment eq '31-Dec-1989 01:00:00') {
			    $ident = $alt;
			} else {
			    $ident = $wpt->Comment;
			}
		    }
		    my $l = [$base . "/" . $ident, ["$prefix$x,$y"], $pcat[0]];
		    $p->push($l);
		}

	        if ($curr_s eq $s) {
		    my $time = $wpt->Comment_to_unixtime;
		    if (defined $time && $last_wpt) {
			my($last_x,$last_y,$last_time) = @$last_wpt;
		        my $legtime = $time-$last_time;
			if (abs($legtime) > 60*$breakmin) {
			    $push_streets->();
		        } else {
			    if (defined $last_x && $breakdist) {
			        my $dist = sqrt(sqr($x-$last_x)+sqr($y-$last_y));
			        if ($dist > $breakdist) {
				    $push_streets->();
				}
			    }
		        }
		        if ($last_is_inaccurate == 0 && $inaccurate != $last_is_inaccurate) {
			    my $last_coord = $street_coords[-1];
			    $push_streets->();
			    push @street_coords, $last_coord
				if defined $last_coord;
		        }
		        push @street_coords, "$prefix$x,$y";
		        if ($last_is_inaccurate != 0 && $inaccurate != $last_is_inaccurate) {
			    $push_streets->();
			    push @street_coords, "$prefix$x,$y";
		        }
		        $last_is_inaccurate = $inaccurate;
		    } else { # first point
			push @street_coords, "$prefix$x,$y";
			$last_is_inaccurate = $inaccurate;
		    }
		    $last_wpt = [$x,$y,$time];
	        }
	    }
	    $push_streets->();
        }
    }

    if ($update) {
	# remember all new files
	my(%new_s, %new_p);
	$s->init;
	while (1) {
	    my $r = $s->next;
	    last if !@{ $r->[Strassen::COORDS()] };
	    my($filename) = $r->[Strassen::NAME()] =~ m{^(\S+)};
	    $new_s{$filename}++;
	}
	$p->init;
	while (1) {
	    my $r = $p->next;
	    last if !@{ $r->[Strassen::COORDS()] };
	    my($filename) = $r->[Strassen::NAME()] =~ m|^([^/]+)|;
	    $new_p{$filename}++;
	}

	# load old data
	my $old_s = Strassen->new($deststreetspath) or die "Can't load $deststreetspath";
	my $old_p = Strassen->new($destpointspath) or die "Can't load $destpointspath";

	# merge old and new
	$old_s->init;
	while (1) {
	    my $r = $old_s->next;
	    last if !@{ $r->[Strassen::COORDS()] };
	    my($filename) = $r->[Strassen::NAME()] =~ m{^(\S+)};
	    if (!$new_s{$filename}) {
		$s->push($r);
	    }
	}
	$old_p->init;
	while (1) {
	    my $r = $old_p->next;
	    last if !@{ $r->[Strassen::COORDS()] };
	    my($filename) = $r->[Strassen::NAME()] =~ m|^([^/]+)|;
	    if (!$new_p{$filename}) {
		$p->push($r);
	    }
	}
    }

    $s->write($deststreetspath);
    $p->write($destpointspath);

}

# REPO BEGIN
# REPO NAME sqr /home/e/eserte/src/repository 
# REPO MD5 846375a266b4452c6e0513991773b211
sub sqr { $_[0] * $_[0] }
# REPO END

return 1 if caller;

local $^W = 0; #XXX ja?
BBBike::GpsmanConv::gpsman2bbd(@ARGV);

__END__
