#!/usr/bin/perl -w
# -*- mode:perl; coding:utf-8; -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 2012,2013,2016,2017,2018 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://www.rezic.de/eserte/
#

use strict;
use utf8;
use FindBin;
use lib (
	 "$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	 "$FindBin::RealBin/../miscsrc", # für ReverseGeocoding.pm
	 $FindBin::RealBin,
	);

use Cwd qw(realpath);
use File::Basename qw(basename);
use Getopt::Long;
use POSIX qw(strftime);
use Time::Local qw(timelocal);
use URI::Escape qw(uri_escape_utf8);

use BBBikeBuildUtil qw(get_pmake);
use BBBikeUtil qw(int_round bbbike_root);
use Karte::Polar;
use Karte::Standard;
use Strassen::Util ();
use StrassenNextCheck;

use constant ORG_MODE_HEADLINE_LENGTH => 77; # used for tag alignment

sub _temp_blockings_id_to_line ($$);

my $with_dist = 1;
my $max_dist_km;
my $dist_dbfile;
my $centerc;
my $center2c;
my $plan_dir;
my $with_searches_weight;
my $with_nextcheckless_records = 1;
my $expired_statistics_logfile;
my $debug;
GetOptions(
	   "with-dist!" => \$with_dist,
	   'max-dist=f' => \$max_dist_km,
	   "dist-dbfile=s" => \$dist_dbfile,
	   "centerc=s" => \$centerc,
	   "center2c=s" => \$center2c,
	   "plan-dir=s" => \$plan_dir,
	   "with-searches-weight!" => \$with_searches_weight,
	   "with-nextcheckless-records!" => \$with_nextcheckless_records,
	   'expired-statistics-logfile=s' => \$expired_statistics_logfile,
	   "debug" => \$debug,
	  )
    or die "usage: $0 [--nowith-dist] [--max-dist km] [--dist-dbfile dist.db] [--centerc X,Y [--center2c X,Y]] [--plan-dir directory] [--with-searches-weight] [--nowith-nextcheckless-records] bbdfile ...";

# --with-dist requires one or two reference positions. Use from
# cmdline arguments, or look into the user's bbbike config.
if ($with_dist && !$centerc) {
    my $config_file = "$ENV{HOME}/.bbbike/config";
    if (!-e $config_file) {
	warn "WARNING: disabling --with-dist option, $config_file does not exist.\n";
	$with_dist = 0;
    } else {
	require Safe;
	my $config = Safe->new->rdo($config_file);
	if (!$config) {
	    warn "WARNING: disabling --with-dist option, cannot load $config_file.\n";
	    $with_dist = 0;
	} else {
	    if (!$config->{centerc}) {
		warn "WARNING: disabling --with-dist option, no centerc option in $config_file set.\n";
		$with_dist = 0;
	    } else {
		$centerc = $config->{centerc};
		if ($config->{center2c}) {
		    $center2c = $config->{center2c};
		}
	    }
	}
    }
}

my $dists_are_exact;
if ($with_dist) {
    $dists_are_exact = $dist_dbfile ? 1 : 0;
}

# Find bbr files with planned survey tours, and store it in
# $planned_points, so fragezeichen records touching these tours may be
# set with "PLAN" instead of "TODO" keyword.
my $planned_points;
if ($plan_dir) {
    require File::Glob;
    require Route;
    require Route::Heavy;
    require Strassen::MultiStrassen;
    require Strassen::StrassenNetz;
    require Strassen::CoreHeavy;
    my @str;
    for my $route_file (File::Glob::bsd_glob("$plan_dir/*.bbr")) {
	my $route = Route->load_as_object($route_file);
	my $name = $route_file;
	push @str, $route->as_strassen(name => $name);
    }
    my $s = MultiStrassen->new(@str);
    $planned_points = $s->as_reverse_hash;
}

# The "weighted" bbd file usually contains the number of route
# searches per street section, which will be used for "importance"
# sorting later.
my $searches_weight_net;
my $latest_weighted_bbd;
if ($with_searches_weight) {
    require File::Glob;
    require Strassen::StrassenNetz;
    require Strassen::Core;
    my $monthly_glob = "20??-??_weighted*.bbd";
    # my $yearly_glob = "20??_weighted*.bbd";
    ($latest_weighted_bbd) = reverse File::Glob::bsd_glob(bbbike_root . "/tmp/weighted/" . $monthly_glob);
    my $s = Strassen->new($latest_weighted_bbd);
    $searches_weight_net = StrassenNetz->new($s);
    $searches_weight_net->make_net;
}

# Some bbd files don't have street/crossing information. Build
# $str_net (for street names) and $crossings (for crossing names) to
# add this information.
my $str_net;
my $crossings;
{
    require Strassen::Core;
    require Strassen::Kreuzungen;
    require Strassen::MultiStrassen;
    require Strassen::StrassenNetz;
    my $ms = MultiStrassen->new(qw(strassen landstrassen landstrassen2));
    $str_net = StrassenNetz->new($ms);
    $str_net->make_net(UseCache => 1);
    $crossings = Kreuzungen->new(UseCache => 1, Strassen => $ms, WantPos => 1);
}

# Usually all -orig and bbbike-temp-blockings files should be supplied
# here. See data/Makefile.
my @files = @ARGV
    or die "Please specify bbd file(s)";

my @records;

# gracefully exit, so DistDB may flush computed things
$SIG{INT} = sub { exit };

my %files_add_street_name = map{($_,1)} ('radwege', 'ampeln', 'vorfahrt');

my $today = strftime "%Y-%m-%d", localtime;

for my $file (@files) {
    debug("$file...\n");
    my $abs_file = realpath $file;
    my $basename = basename($file);
    (my $basebasename = $basename) =~ s{-orig$}{}; # without "-orig"
    my $is_fragezeichen_file = $basebasename eq 'fragezeichen';
    my $do_add_street_name = $files_add_street_name{$basebasename};

    my $s = StrassenNextCheck->new_stream($file);
    $s->read_stream_nextcheck_records
	(sub {
	     # We handle two kind of records here
	     # - all records with a next_check entry, these will have date set in @records
	     # - all records which look like a outdoor fragezeichen entry
	     #   (all outdoor records in fragezeichen or fragezeichen-orig,
	     #    and records in other files marked with add_fragezeichen, XXX,
	     #    or similar), these won't have date set in @records
	     my($r, $dir) = @_;
	     my $where;
	     if ($abs_file =~ m{^(.*)/tmp/bbbike-temp-blockings-optimized\.bbd$}) {
		 my $non_optimized_src_file = "$1/data/temp_blockings/bbbike-temp-blockings.pl";
		 my $id = $dir->{id} ? $dir->{id}->[0] : undef;
		 my $linenumber = _temp_blockings_id_to_line($id, $non_optimized_src_file);
		 if (!$linenumber) {
		     warn "Cannot get linenumber for id '$id' in '$non_optimized_src_file'...\n";
		     $where = "${abs_file}::$. (generated file)";
		 } else {
		     $where = "${non_optimized_src_file}::${linenumber}";
		 }
	     } else {
		 $where = "${abs_file}::$.";
	     }
	     my $has_nextcheck = $dir->{_nextcheck_date} && $dir->{_nextcheck_date}[0];
	     if (!$has_nextcheck) {
		 return if !$with_nextcheckless_records;

		 # XXX this is taken from
		 # create_fragezeichen_nextcheck.pl, probably should
		 # be refactored into a function!
		 # --- only $door_mode eq 'out' handled here
		 if ($is_fragezeichen_file) {
		     return if (exists $dir->{XXX_prog} || exists $dir->{XXX_indoor});
		 } else {
		     return if (!exists $dir->{add_fragezeichen} &&
				!exists $dir->{XXX} &&
				!exists $dir->{temporary}
			       );
		 }
	     }

	     my $nextcheck_date;
	     my $nextcheck_wd;
	     if ($has_nextcheck) {
		 if (my($y,$m,$d) = $dir->{_nextcheck_date}[0] =~ m{^(\d{4})-(\d{2})-(\d{2})$}) {
		     my $epoch = eval { timelocal 0,0,0,$d,$m-1,$y };
		     if ($@) {
			 warn "ERROR: Invalid day '$dir->{_nextcheck_date}[0]' ($@) in file '$file', line '" . $r->[Strassen::NAME] . "', skipping...\n";
			 return;
		     } else {
			 $nextcheck_wd = [qw(Su Mo Tu We Th Fr Sa)]->[(localtime($epoch))[6]];
			 $nextcheck_date = "$y-$m-$d";
		     }
		 } else {
		     warn "ERROR: Cannot parse date '$dir->{_nextcheck_date}[0]' (file $file), skipping...\n";
		     return;
		 }
	     }

	     # The "subject" of the record, usually the bbd record
	     # name. For some file types (radwege, ampeln, see above)
	     # the street or crossing name is prepended.
	     my $subject = $r->[Strassen::NAME] || _get_first_XXX_directive($dir) || "(" . $file . "::$.)";
	     if ($do_add_street_name) {
		 my $add_street_name;
		 my @c = @{ $r->[Strassen::COORDS] };
		 if (@c == 1) {
		     $add_street_name = $crossings->get_crossing_name($c[0]);
		 } elsif (@c > 1) {
		     my $rec = $str_net->get_street_record($c[0], $c[1]);
		     if ($rec) {
			 $add_street_name = $rec->[Strassen::NAME];
		     }
		 } # else: should not happen
		 if ($add_street_name) {
		     $subject = $add_street_name . ': ' . $subject;
		 }
	     }

	     # Exact or as-the-bird-flies distance calculation
	     my $dist_tag = '';
	     my $any_dist; # either one way or two way dist in meters
	     if ($centerc) {
		 my $dist_m = _get_dist($centerc, $r->[Strassen::COORDS]);
		 $dist_tag = ':' . _make_dist_tag($dist_m) . ':';
		 if ($center2c) {
		     my $dist2_m = _get_dist($center2c, $r->[Strassen::COORDS]);
		     $dist2_m += $dist_m;
		     $dist_tag .= _make_dist_tag($dist2_m) . ':';
		     $any_dist = $dist2_m;
		 } else {
		     $any_dist = $dist_m;
		 }
	     }

	     my @extra_url_defs;

	     # WGS84 coordinates
	     my($px,$py) = do {
		 my $middle = $r->[Strassen::COORDS][$#{$r->[Strassen::COORDS]}/2];
		 $Karte::Polar::obj->standard2map(split /,/, $middle);
	     };

	     # OSM URL
	     push @extra_url_defs, ['OSM', 'http://www.openstreetmap.org/#map=17/'.$py.'/'.$px];

	     # URLs from also_indoor directives
	     if ($dir->{also_indoor}) {
		 for my $also_indoor_dir (@{ $dir->{also_indoor} }) {
		     if      ($also_indoor_dir =~ m{^traffic\b}) {
			 push @extra_url_defs, ['Traffic', "https://mc.bbbike.org/mc/?lon=$px&lat=$py&zoom=15&profile=traffic"];
		     } elsif ($also_indoor_dir =~ m{^search\b}) {
			 (my $search_term = $also_indoor_dir) =~ s{^search\s+}{};
			 if ($search_term) {
			     push @extra_url_defs, ['Search', qq{https://start.duckduckgo.com/?q="@{[ uri_escape_utf8($search_term) ]}"&df=m}];
			 } else {
			     warn "WARN: 'also_indoor: search' without search term\n";
			 }
		     } elsif ($also_indoor_dir =~ m{^(url)\s+(https?://\S+)}) {
			 my $type = uc $1;
			 my $url = $2;
			 push @extra_url_defs, [$type, $url];
		     } else {
			 warn "WARN: unsupported 'also_indoor' directive '$also_indoor_dir'\n";
		     }
		 }
	     }
	     # Further URLs which work as good as also_indoor directives
	     if ($dir->{by}) {
		 for my $by (@{ $dir->{by} }) {
		     if ($by =~ m{(https?://www.bvg.de/de/Fahrinfo/Verkehrsmeldungen/\S+)}) {
			 push @extra_url_defs, ['BVG', $1];
		     }
		 }
	     }

	     # Getting priority
	     my $prio;
	     if ($prio = $dir->{priority}) {
		 $prio = $prio->[0];
		 if ($prio !~ m{^#[ABCD]$}) {
		     warn "WARN: priority should be #A..#D, not '$prio', ignoring...\n";
		     undef $prio;
		 }
	     }

	     if ($dir->{prio}) {
		 # happens too often, so make it a fatal error
		 die "Wrong directive 'prio' detected, maybe you mean 'priority' at $where\n";
	     }

	     # Get the number of route searches from the "weighted"
	     # bbd file. Note that the maximum number for all street
	     # sections is taken.
	     my $searches;
	     if ($searches_weight_net) {
		 my $max_searches = 0;
		 my $update_max_searches = sub {
		     my($p1, $p2) = @_;
		     my $found_rec_hin   = $searches_weight_net->get_street_record($p1, $p2, -obeydir => 1);
		     my $found_rec_rueck = $searches_weight_net->get_street_record($p2, $p1, -obeydir => 1);
		     my $this_searches = 0;
		     for ($found_rec_hin, $found_rec_rueck) {
			 if ($_ && $_->[Strassen::NAME] =~ m{^(\d+)}) {
			     $this_searches += $1;
			 }
		     }
		     if ($this_searches > $max_searches) {
			 $max_searches = $this_searches;
		     }
		 };
		 my @c = @{ $r->[Strassen::COORDS] };
		 if (@c == 1) {
		     for my $neighbor (keys %{ $searches_weight_net->{Net}{$c[0]} }) {
			 $update_max_searches->($c[0], $neighbor);
		     }
		 } else {
		     for my $c_i (1 .. $#c) {
			 my($p1, $p2) = @c[$c_i-1, $c_i];
			 $update_max_searches->($p1, $p2);
		     }
		 }
		 $searches = $max_searches;
	     }

	     # Get list of planned survey tours, if any
	     my @planned_route_files;
	     if ($planned_points) {
		 my %planned_route_files;
		 for my $c (@{ $r->[Strassen::COORDS] }) {
		     if (my $route_files = $planned_points->{$c}) {
			 for my $route_file (@$route_files) {
			     $planned_route_files{$route_file} = 1;
			 }
		     }
		 }
		 @planned_route_files = sort keys %planned_route_files;

		 _add_to_planned_route_importance
		     (
		      \@planned_route_files,
		      priority => $prio,
		      searches => $searches,
		      expired => $nextcheck_date && $nextcheck_date le $today,
		     );
	     }

	     # the todo state depends if there are planned survey
	     # tours here: then it's "PLAN", otherwise it's "TODO"
	     #
	     # build first the org-mode headline, and then the
	     # complete org-mode item ($body)
	     my $todo_state = @planned_route_files ? 'PLAN' : 'TODO'; # make sure all states have four characters
	     my $headline = "** $todo_state " .
		 (defined $nextcheck_date ? "<$nextcheck_date $nextcheck_wd> " : "                ") .
		     ($prio ? "[$prio] " : "") .
			 $subject;
	     if ($dir->{osm_watch}) {
		 $headline .= " (+osm_watch)";
		 for my $osm_watch (@{ $dir->{osm_watch} }) {
		     if ($osm_watch =~ m{^(\S+)\s+id="(\d+)"}) {
			 my($type, $id) = ($1, $2);
			 my $url = "https://www.openstreetmap.org/$type/$id";
			 push @extra_url_defs, ["OSM-Watch", $url];
		     } elsif ($osm_watch =~ m{^note\s+(\d+)}) {
			 my($id) = ($1);
			 my $url = "https://www.openstreetmap.org/note/$id";
			 push @extra_url_defs, ["OSM-Note", $url];
		     } else {
			 warn "Cannot parse osm_watch directive '$osm_watch'\n";
		     }
		 }
	     }
	     if ($dir->{add_fragezeichen} || ($file =~ m{fragezeichen} && !$dir->{ignore})) {
		 $headline .= " (+public)";
	     }
	     if (defined $searches) {
		 $headline .= " ($searches)";
	     }
	     if ($dist_tag) {
		 if (length($headline) + 1 + length($dist_tag) < ORG_MODE_HEADLINE_LENGTH) {
		     $headline .= " " x (ORG_MODE_HEADLINE_LENGTH-length($headline)-length($dist_tag));
		 } else {
		     $headline .= " ";
		 }
		 $headline .= $dist_tag;
	     }

	     my $body = <<EOF;
$headline
EOF
	     $body .= join("", map { "   : " . $_ . "\n" } _get_all_XXX_directives($dir));
	     $body .= <<EOF;
   : $r->[Strassen::NAME]\t$r->[Strassen::CAT] @{$r->[Strassen::COORDS]}
EOF

	     # Links (bbbike data, OSM and other extra URLs)
	     $body .= "   [[$where][$basebasename]]";
	     if (@extra_url_defs) {
		 $body .= " " . join(" ", map { "[[$_->[1]][$_->[0]]]" } @extra_url_defs);
	     }
	     $body .= "\n";

	     if (@planned_route_files) {
		 $body .= "\n   Planned in\n";
		 for my $planned_route_file (@planned_route_files) {
		     $body .= "   * [[shell:bbbikeclient $planned_route_file]]\n";
		 }
	     }

	     push @records, {
			     body => $body,
			     dist => $any_dist,
			     (defined $nextcheck_date ? (date     => $nextcheck_date) : ()),
			     (defined $searches       ? (searches => $searches)       : ()),
			    };
	 }, passthru_without_nextcheck => 1);
}

my @all_records_by_date = sort {
    my $cmp = $b->{date} cmp $a->{date};
    return $cmp if $cmp != 0;
    if (defined $a->{dist} && defined $b->{dist}) {
	return $b->{dist} <=> $a->{dist};
    } else {
	0;
    }
} grep { defined $_->{date} } @records;

my @expired_sort_by_dist_records; # may be cropped!
my $cropped_count_because_of_max_dist;
if ($centerc) {
    @expired_sort_by_dist_records = grep { !defined $_->{date} || $_->{date} le $today } @records;
    if (defined $max_dist_km) {
	@expired_sort_by_dist_records = grep {
	    if (defined $_->{dist} && $_->{dist}/1000 <= $max_dist_km) {
		1;
	    } else {
		$cropped_count_because_of_max_dist++;
		0;
	    }
	} @expired_sort_by_dist_records;
    }
    @expired_sort_by_dist_records = sort {
	my $cmp = 0;
	if (defined $a->{dist} && defined $b->{dist}) {
	    $cmp = $a->{dist} <=> $b->{dist};
	}
	return $cmp if $cmp != 0;
	if (defined $a->{date} && defined $b->{date}) {
	    return $b->{date} cmp $a->{date};
	} else {
	    return 0;
	}
    } @expired_sort_by_dist_records;
}

my @expired_searches_weight_records;
if ($with_searches_weight) {
    @expired_searches_weight_records = sort {
	$b->{searches} <=> $a->{searches}
    } grep { (!defined $_->{date} || $_->{date} le $today) && $_->{searches} } @records;
}

my %monthly_stats;
{
    my $today = strftime '%F', localtime;
    my $this_month = strftime '%Y-%m', localtime;
    # initialize, otherwise monthly stats output is wrong on 1st of this month
    $monthly_stats{"$this_month-AA"} = 0;
    $monthly_stats{"$this_month-ZZ"} = 0;
    for (@records) {
	if (defined $_->{date}) {
	    if ($_->{date} =~ m{^\Q$this_month}) {
		if ($_->{date} lt $today) {
		    $monthly_stats{"$this_month-AA"}++; # XXX better label? (but at least it's automatically sorted)
		} else {
		    $monthly_stats{"$this_month-ZZ"}++; # XXX better label? (but at least it's automatically sorted)
		}
	    } elsif (my($ym) = $_->{date} =~ m{^(\d{4}-\d{2})}) {
		$monthly_stats{$ym}++;
	    } else {
		warn "WARN (unexpected): Cannot parse $_->{date}";
	    }
	}
    }
}

binmode STDOUT, ':utf8';
print "fragezeichen/nextcheck\t\t\t-*- mode:org; coding:utf-8 -*-\n\n";

{
    my $has_header_explanation_lines;

    if ($with_dist) {
	require ReverseGeocoding;
	my $rh = ReverseGeocoding->new;
	if ($centerc) {
	    my($px,$py) = $Karte::Polar::obj->standard2map(split /,/, $centerc);
	    print "1st reference point for distances: ". $rh->find_closest("$px,$py", "road"), "\n";
	    if ($center2c) {
		my($p2x,$p2y) = $Karte::Polar::obj->standard2map(split /,/, $center2c);
		print "2nd reference point for distances: ". $rh->find_closest("$p2x,$p2y", "road"), "\n";
	    }
	    $has_header_explanation_lines = 1;
	}
    }

    if ($latest_weighted_bbd && $searches_weight_net) {
	print "Route search numbers from $latest_weighted_bbd\n";
	$has_header_explanation_lines = 1;
    }

    if ($has_header_explanation_lines) {
	print "\n";
    }
}

print "* future\n";
print_org_visibility('children');
my $today_printed = 0;
for my $record (@all_records_by_date) {
    if (!$today_printed && $record->{date} le $today) {
	print "* until today\n";
	print_org_visibility('children');
	$today_printed = 1;
    }
    print $record->{body};
}

if (@expired_searches_weight_records) {
    print "* expired " . ($with_nextcheckless_records ? "and open " : "") . "records, sort by number of route searches\n";
    print_org_visibility('children');
    for my $expired_searches_weight_record (@expired_searches_weight_records) {
	print $expired_searches_weight_record->{body};
    }
}

if (@expired_sort_by_dist_records) {
    print "* expired " . ($with_nextcheckless_records ? "and open " : "") . "records, sort by dist\n";
    print_org_visibility('children');
    for my $expired_record (@expired_sort_by_dist_records) {
	print $expired_record->{body};
    }
    if ($cropped_count_because_of_max_dist) {
	print "** ...cropped $cropped_count_because_of_max_dist record(s) because of --max-dist=$max_dist_km...\n";
    }
}

print _get_planned_route_importance_output();

if (%monthly_stats) {
    print <<'EOF';
* monthly stats
EOF
    print_org_visibility('folded');

    my %monthly_stats_past_or_future;

    my $sum_past = 0;
    {
	my $seen_today;
	for my $date (reverse sort keys %monthly_stats) {
	    if ($date =~ /AA/) {
		$seen_today = 1;
	    }
	    if ($seen_today) {
		$sum_past += $monthly_stats{$date};
		$monthly_stats_past_or_future{$date} = $sum_past;
	    }
	}
    }

    my $sum_future = 0;
    {
	my $seen_today;
	for my $date (sort keys %monthly_stats) {
	    if ($date =~ /ZZ/) {
		$seen_today = 1;
	    }
	    if ($seen_today) {
		$sum_future += $monthly_stats{$date};
		$monthly_stats_past_or_future{$date} = $sum_future;
	    }
	}
    }

    for my $date (reverse sort keys %monthly_stats) {
	printf "** %-10s %3d %4d\n", $date, $monthly_stats{$date}, $monthly_stats_past_or_future{$date};
    }

}

if ($expired_statistics_logfile) {
    require Tie::File;
    tie my @lines, 'Tie::File', $expired_statistics_logfile
	or die "Error while opening $expired_statistics_logfile: $!";
    my $today = strftime '%F', localtime;
    my $new_log_line = "$today\t" . scalar(@expired_sort_by_dist_records);
    if (!@lines) {
	push @lines, $new_log_line;
    } else {
	my($last_line_date) = $lines[-1] =~ m{^(\S+)};
	if ($last_line_date eq $today) {
	    if ($lines[-1] ne $new_log_line) {
		$lines[-1] = $new_log_line;
	    }
	} else {
	    push @lines, $new_log_line;
	}
    }
}

{
    my $pmake = get_pmake;
    print <<"EOF";
* settings
#+SEQ_TODO: TODO | PLAN | DONE
#+OPTIONS: ^:nil
#+OPTIONS: *:nil
#+OPTIONS: toc:1
#+OPTIONS: num:nil
# Local variables:
# compile-command: "(cd ../data && $pmake fragezeichen-nextcheck.org-exact-dist HOME=$ENV{HOME})"
# End:
EOF
    # Alternative compile command (without using the dist.db):
    ## compile-command: "(cd ../data && make ../tmp/fragezeichen-nextcheck.org)"
}

sub _get_first_XXX_directive {
    my $dir = shift;
    for my $dirkey (qw(add_fragezeichen XXX temporary)) {
	if (exists $dir->{$dirkey}) {
	    my $val = join(" ", @{ $dir->{$dirkey} });
	    if (defined $val && length $val) {
		return $val;
	    }
	}
    }
    undef;
}

sub _get_all_XXX_directives { # as an array
    my $dir = shift;
    my @res;
    for my $dirkey (qw(add_fragezeichen XXX temporary)) {
	if (exists $dir->{$dirkey}) {
	    for my $val (@{ $dir->{$dirkey} }) {
		if (defined $val && length $val) {
		    push @res, "#: $dirkey: $val";
		}
	    }
	}
    }
    @res;
}

sub _get_dist {
    my($p1, $p2s) = @_;
    my $inacc_hash = $dist_dbfile ? _get_innaccessible_points() : {};
    my($min_dist, $min_p);
    for my $this_p (@$p2s) {
	next if $inacc_hash->{$this_p};
	next if $this_p eq '*'; # may happen in gesperrt-orig: entries with category="3" may have a "*" coordinate at the beginning or end
	my $this_dist = Strassen::Util::strecke_s($p1, $this_p);
	if (!$min_dist || $min_dist > $this_dist) {
	    $min_dist = $this_dist;
	    $min_p    = $this_p;
	}
    }
    if (!$dist_dbfile) {
	return $min_dist;
    }

    if (!$min_p) {
	# May happen if all points for this street are inaccessible (a
	# rare case in bbbike data). So we cannot do a real search. In
	# this case, just choose the first one for as-the-bird-flies
	# distance, and multiply with a factor (1.5), so distance is
	# not too low.
	return Strassen::Util::strecke_s($p1, $p2s->[0]) * 1.5;
    }

    # $min_p is only an approximation for the nearest point from $p1
    my $dist_db = _get_distdb();
    my $dist = eval { $dist_db->get_dist($p1, $min_p) };
    if ($@) {
	die "Failed to get distance between $p1 and $min_p: $@";
    }
    $dist;
}

sub _get_innaccessible_points {
    our $inacc_hash;
    return $inacc_hash if $inacc_hash;

    require Strassen::Core;
    my $s = Strassen->new("inaccessible_landstrassen");
    $inacc_hash = $s->get_hashref;
}

sub _get_distdb {
    our $dist_db;
    return $dist_db if $dist_db;
    require DistDB;
    $dist_db = DistDB->new($dist_dbfile);
}

sub _make_dist_tag {
    my $dist_m = shift;
    ($dists_are_exact ? '' : '~') . int_round($dist_m/1000) . 'km';
}

{
    my $id_to_line;
    sub _temp_blockings_id_to_line ($$) {
	my $id = shift;
	if (!$id_to_line) {
	    my $file = shift;
	    $id_to_line = {};
	    # XXX Partially taken from BBBikeEdit::edit_temp_blockings
	    if (open my $TEMP_BLOCKINGS, $file) {
		my $record = 0;
		my $linenumber = 1;
		while(<$TEMP_BLOCKINGS>) {
		    if (m<^\s*\{> || m<^\s*undef,>) {
			$id_to_line->{$record} = $linenumber;
			$record++;
		    }
		    $linenumber++;
		}
	    } else {
		warn "Can't open $file, cannot create id-to-line mapping: $!";
	    }
	}
	$id_to_line->{$id};
    }
}

{
    my %planned_route_to_numbers;

    sub _add_to_planned_route_importance {
	my($planned_route_files_ref, %opts) = @_;
	my $priority = delete $opts{priority};
	my $searches = delete $opts{searches};
	my $expired  = delete $opts{expired};
	die "Unhandled options: " . join(" ", %opts) if %opts;

	my $priority_points =
	    {
	     '#A' => 4,
	     '#B' => 3,
	     '#C' => 2,
	     '#D' => 1,
	     ''   => 2, # no priority -> same as #C
	    }->{$priority||''};

	for my $planned_route_file (@$planned_route_files_ref) {
	    my $numbers = ($planned_route_to_numbers{$planned_route_file} ||= { expired_count => 0,
										expired_priority_points => 0,
									      });
	    $numbers->{total_count}++;
	    $numbers->{expired_count}++ if $expired;
	    $numbers->{priority_points} += $priority_points;
	    $numbers->{expired_priority_points} += $priority_points if $expired;
	    $numbers->{searches} += $searches;
	}
    }

    sub _get_planned_route_importance_output {
	my $out = '';
	if (%planned_route_to_numbers) {
	    $out .= "* planned route importance\n";
	    for my $sort_def (
			      [qw(expired_priority_points expired_count searches)],
			      [qw(expired_count expired_priority_points searches)],
			      [qw(searches expired_priority_points expired_count)],
			     ) {
		my @sort_keys = @$sort_def;
		my $custom_sort = sub {
		    my($x, $y) = @_;
		    for my $sort_key (@sort_keys) {
			my $cmp = $y->{$sort_key} <=> $x->{$sort_key};
			return $cmp if $cmp;
		    }
		    return 0;
		};
		$out .= "** sorted by $sort_keys[0]\n";
		for my $planned_route_file (sort { $custom_sort->($planned_route_to_numbers{$a}, $planned_route_to_numbers{$b}) } keys %planned_route_to_numbers) {
		    my $numbers = $planned_route_to_numbers{$planned_route_file};
		    $out .= "*** $planned_route_file (expired_prio=$numbers->{expired_priority_points} expired_count=$numbers->{expired_count} total_count=$numbers->{total_count} searches=$numbers->{searches})\n";
		}
	    }
	}
	$out;
    }
}

sub debug {
    return if !$debug;
    my $msg = shift;
    print STDERR $msg;
}

sub print_org_visibility {
    my($visibility) = @_;
    print <<EOF;
  :PROPERTIES:
  :VISIBILITY: $visibility
  :END:
EOF
}

__END__

=head1 NAME

fragezeichen2org - create org-mode file from date-based fragezeichen records

=head1 SYNOPSIS

    ./miscsrc/fragezeichen2org.pl data/*-orig tmp/bbbike-temp-blockings-optimized.bbd > tmp/fragezeichen-nextcheck.org

=head1 DESCRIPTION

B<fragezeichen2org.pl> creates an emacs org-mode compatible file from
all "fragezeichen" entries with an last_checked/next_check date found
in the given bbbike data files.

The records are sorted by date. Records from the same date are
additionally sorted by distance (if the C<--centerc> option is given).
A special marker C<<--- TODAY --->> is created between past and future
entries.

Expired entries are additionally listed the following two sections:

=over

=item section "expired records, sort by dist"

This section is sorted by distance only.

=item section "expired records, sort by number of route searches"

This section is sorted by number of route searches of the latest
month. It's only created if the C<--with-searches-weight> option is
set.

=back

=head2 OPTIONS

=over

=item C<--with-dist> (set by default)

Add distance tags to every fragezeichen record. Distance is the
as-the-bird-flies distance from the "centerc" point (see below) to the
fragezeichen record.

=item C<--nowith-dist>

Disable the generation of distance tags.

=item C<--max-dist I<kilometers>>

In the "expired and open records, sort by dist" section, show only
entries up to the given maximum distance. If not given, show all
entries.

=item C<--dist-dbfile >I</path/to/dist.db>

Specify a F<dist.db> for use with L<DistDB>. Using this option
automatically enables exact distance calculation.

Be prepared, first-time calculation of exact distances is quite slow.
Subsequent calls of the script are B<much> faster thank to the
distance database (unless you delete the F<dist.db>, of course).

Note that it's possible that the route search might find no route for
a coordinate pair (e.g. because of inaccessible points not covered by
F<inaccessible_landstrassen>). In this case the script stops. So this
option is not yet suitable for unattended batch jobs.

=item C<--centerc I<x,y>>

The home coordinate (in BBBike coord system, not WGS84) for the
L</--with-dist> calculation. If not given, then the value is taken
from F<~/.bbbike/config> (which is usually written by the Perl/Tk
app). If the value is not defined there, either, then the distance
tags are disabled.

=item C<--center2c I<x,y>>

A 2nd home coordinate for the distance tag generation. This is used
for a 2nd tag, which is the as-the-bird-flies distance from the 1st
coordinate to the fragezeichen record to the 2nd coordinate.

Note that the <center2c> config option needs to be set manually in
F<~/.bbbike/config>; it's not possible to do this with the option
editor of the Perl/Tk app.

=item C<--with-searches-weight>

Create another section with expired records, sorted by number of route
searches. This requires that a "weighted" bbd is created as described
in L<weight_bbd/EXAMPLES>.

=item C<--nowith-nextcheckless-records>

If this option is not set, then additionally to expired records also
fragezeichen-like records without an expiration date are parsed. Such
records only appear in the two additional sections (sort by dist, and
sort by number of route searches).

=back

=cut
