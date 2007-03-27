#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: strassennetz.t,v 1.18 2007/03/27 21:32:43 eserte Exp $
# Author: Slaven Rezic
#

use strict;
use FindBin;
use lib ("$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	 "$FindBin::RealBin/../data",
	 "$FindBin::RealBin",
	);
use Getopt::Long;
use Data::Dumper qw(Dumper);
use Storable qw(dclone);

use Strassen::Core;
use Strassen::Lazy;
use Strassen::StrassenNetz;
use Route;
use Route::Heavy;

use BBBikeTest;

BEGIN {
    if (!eval q{
	use Test::More;
	use List::Util qw(sum);
	1;
    }) {
	print "1..0 # skip: no Test::More and/or List::Util module\n";
	exit;
    }
}

plan tests => 45;

print "# Tests may fail if data changes\n";

if (!GetOptions(get_std_opts(qw(xxx)))) {
    die "usage: $0 [-xxx]";
}

my $s		  = Strassen::Lazy->new("strassen");
my $s_net	  = StrassenNetz->new($s);
$s_net->make_net(UseCache => 1);

my $qs            = Strassen::Lazy->new("qualitaet_s");
my $comments_path = Strassen::Lazy->new("comments_path");

if ($do_xxx) {
    goto XXX;
}

{
    # Melchiorstr.: m��iger Asphalt	Q1; 11726,11265 11542,11342
    my $coords = "11542,11342 11726,11265";
    my $route  = [map { [split /,/] } split /\s+/, $coords];

    {
	pass("-- Melchiorstr.: einseitige Qualit�tsangabe --");

	my $net = StrassenNetz->new($qs);
	$net->make_net_cat(-obeydir => 1, -net2name => 1);
	my $route = dclone $route;
	is($net->get_point_comment($route, 0, undef), 0, "Without multiple");
	$route = [ reverse @$route ];
	like(($net->get_point_comment($route, 0, undef))[0], qr/m��iger Asphalt/i);
    }

    {
	pass("-- Melchiorstr.: einseitige Qualit�tsangabe (dito) --");

	my $net = StrassenNetz->new($qs);
	$net->make_net_cat(-obeydir => 1, -net2name => 1, -multiple => 1);
	my $route = dclone $route;
	is(scalar $net->get_point_comment($route, 0, undef), 0, "With multiple");
	$route = [ reverse @$route ];
	like(($net->get_point_comment($route, 0, undef))[0], qr/m��iger Asphalt/i);
    }
}

{
    my $net = StrassenNetz->new($comments_path);
    $net->make_net_cat(-obeydir => 1, -net2name => 1, -multiple => 1);

    {
	pass("-- CP;-Kommentar Buchholzer/Sch�nhauser Allee --");

	no warnings qw(qw);
	my $route = [ map { [ split /,/ ] }
		      qw(
			 11055,15504 10930,15522 10917,15418
			) ];
	my $comment;
	($comment) = $net->get_point_comment($route, 0, undef);
	is($comment, undef, "No CP; comment for begin point")
	    or diag $comment;
	($comment) = $net->get_point_comment($route, 1, undef);
	like($comment, qr{auf der linken}i, "CP; comment only at middle point")
	    or diag $comment;
	($comment) = $net->get_point_comment($route, 2, undef);
	is($comment, undef, "No CP; comment for end point")
	    or diag $comment;
    }

    {
	pass("-- CP-Kommentar (beide Richtungen) Sonnenallee/Treptower --");

	no warnings qw(qw);
	my $route = [ map { [ split /,/ ] }
		      qw(
			 13478,8095 13459,8072 13376,7970
			) ];
	my $comment;

	for my $pass (1, 2) {
	    if ($pass == 2) {
		@$route = reverse @$route;
	    }

	    ($comment) = $net->get_point_comment($route, 0, undef);
	    is($comment, undef, "No CP comment for begin point, pass $pass")
		or diag $comment;
	    ($comment) = $net->get_point_comment($route, 1, undef);
	    like($comment, qr{Ampel.*benutzen}i, "CP comment only at middle point, pass $pass")
		or diag $comment;
	    ($comment) = $net->get_point_comment($route, 2, undef);
	    is($comment, undef, "No CP comment for end point, pass $pass")
		or diag $comment;
	}
    }

    {
	pass("-- CS;-Kommentar Henriettenplatz --");

	my $route = [[2702,10006], [2770,10024], [2770,9945], [3044,9621]];
	my $comment;
	($comment) = $net->get_point_comment($route, 0, undef);
	is($comment, undef, "No CS; comment for first point in route")
	    or diag $comment;
	($comment) = $net->get_point_comment($route, 1, undef);
	like($comment, qr{zufahrt}i, "CS; comment for beginning point in feature")
	    or diag $comment;
	($comment) = $net->get_point_comment($route, 2, undef);
	is($comment, undef, "No CS; comment for end point in feature")
	    or diag $comment;
	($comment) = $net->get_point_comment($route, 3, undef);
	is($comment, undef, "No CS; comment for last point in route")
	    or diag $comment;
    }

    {
	pass("-- CS-Kommentar (beide Richtungen) J�denstr. --");

	my $route =
	    [ map { [ split /,/ ] } split / /,
	      "10704,12595 10778,12493 10800,12461 10831,12371 10825,12271"
	    ];
	my $comment;

	for my $pass (1, 2) {
	    if ($pass == 2) {
		@$route = reverse @$route;
	    }

	    ($comment) = $net->get_point_comment($route, 0, undef);
	    is($comment, undef, "No CS comment for first point in route, pass $pass")
		or diag $comment;
	    ($comment) = $net->get_point_comment($route, 1, undef);
	    like($comment, qr{unbequem}i, "CS comment for first point in feature, pass $pass")
		or diag $comment;
	    ($comment) = $net->get_point_comment($route, 2, undef);
	    like($comment, qr{unbequem}i, "CS comment for second point in feature, pass $pass")
		or diag $comment;
	    ($comment) = $net->get_point_comment($route, 3, undef);
	    is($comment, undef, "No CS comment for last point in feature, pass $pass")
		or diag $comment;
	    ($comment) = $net->get_point_comment($route, 4, undef);
	    is($comment, undef, "No CS comment for last point in route, pass $pass")
		or diag $comment;
	}
    }
}

{
    pass("-- Scharnweber - Lichtenrader Damm --");

    my $c1 = "4695,17648"; # Scharnweberstr.
    my $c2 = "10524,655"; # Lichtenrader Damm
    for my $c ($c1, $c2) { # points may move ... fix it!
	$c = $s_net->fix_coords($c);
    }
    my($path) = $s_net->search($c1, $c2);
    my(@route) = $s_net->route_to_name($path);
    my $dist1 = int sum map { $_->[StrassenNetz::ROUTE_DIST] } @route;
    my(@compact_route) = $s_net->compact_route(\@route);
    my $dist2 = int sum map { $_->[StrassenNetz::ROUTE_DIST] } @compact_route;
    is($dist1, $dist2, "Distance the same after compaction");
    cmp_ok(scalar(@compact_route), "<", scalar(@route), "Actually less hops in compacted route");
}

{
    pass("-- Bug reported by Dominik --");

    $TODO = "In some strange circumstances, angle may be undef";
    my $route = <<'EOF';
#BBBike route
$realcoords_ref = [[-3011,10103],[-2761,10323],[-2766,10325],[-2761,10323],[-2571,10258]];
$search_route_points_ref = [['-3011,10103','m'],['-2766,10325','a'],['-2571,10258','a']];
EOF
    my $ret = Route::load_from_string($route);
    my $path = $ret->{RealCoords};
    my(@route) = $s_net->route_to_name($path);
    my $got_undef = 0;
    for (@route) { $got_undef++ if !defined $_->[StrassenNetz::ROUTE_ANGLE] }
    is($got_undef, 0);
}

XXX:
{
    # Bug reported by Andreas Wirsing, but was already known to me

    {
	# Wilhelmstr. - Stresemannstr.
	my $route = <<'EOF';
#BBBike route
$realcoords_ref = [[9392,10260], [9376,10393], [9250,10563]];
EOF
	my $ret = Route::load_from_string($route);
	my $path = $ret->{RealCoords};
	my(@route) = $s_net->route_to_name($path);
	is($route[0][StrassenNetz::ROUTE_EXTRA]{ImportantAngle}, '!', "Found an important angle (Wilhelmstr. -> Stresemannstr.)")
	    or diag(Dumper(\@route));

	# Add another point before start. This triggers a special case
	# in route_to_name with combinestreet set (which is default)
	unshift @$path, [9395,10233];
	(@route) = $s_net->route_to_name($path);
	is($route[0][StrassenNetz::ROUTE_EXTRA]{ImportantAngle}, '!', "Found an important angle (longer Wilhelmstr. -> Stresemannstr.)")
	    or diag(Dumper(\@route));

	# And add yet another point before start, just to see if everything
	# is right if ImportantAngle is set to the *2nd* street in route
	unshift @$path, [9401,10199];
	(@route) = $s_net->route_to_name($path);
	is($route[1][StrassenNetz::ROUTE_EXTRA]{ImportantAngle}, '!', "Found an important angle (Mehringdamm -> Wilhelmstr. -> Stresemannstr.)")
	    or diag(Dumper(\@route));
    }

    {
	# gleiche Kreuzung, Wilhelmstr. geradeaus
	my $route = <<'EOF';
#BBBike route
$realcoords_ref = [[9392,10260], [9376,10393], [9366,10541]];
EOF
	my $ret = Route::load_from_string($route);
	my $path = $ret->{RealCoords};
	my(@route) = $s_net->route_to_name($path);
	is($route[0][StrassenNetz::ROUTE_EXTRA]{ImportantAngle}, undef, "Important angle not set here (Wilhelmstr.)")
	    or diag(Dumper(\@route));
    }

    {
	# Martin-Luther-Str. -> Dominicusstr.
	my $route = <<'EOF';
#BBBike route
$realcoords_ref = [[6470,8809], [6470,8681], [6590,8469]];
EOF
	my $ret = Route::load_from_string($route);
	my $path = $ret->{RealCoords};
	my(@route) = $s_net->route_to_name($path);
	is($route[0][StrassenNetz::ROUTE_EXTRA]{ImportantAngle}, '!', "Found an important angle (Martin-Luther-Str. ->Dominicusstr.)")
	    or diag(Dumper(\@route));

	# reverse route: "geradeaus" ist OK
	@$path = reverse @$path;
	(@route) = $s_net->route_to_name($path);
	is($route[0][StrassenNetz::ROUTE_EXTRA]{ImportantAngle}, undef, "Important angle not set now (Dominicusstr. -> Martin-Luther-Str.)")
	    or diag(Dumper(\@route));

    }

    {
	# gleiche Kreuzung, Martin-Luther-Str. geradeaus
	my $route = <<'EOF';
#BBBike route
$realcoords_ref = [[6470,8809], [6470,8681], [6471,8639]];
EOF
	my $ret = Route::load_from_string($route);
	my $path = $ret->{RealCoords};
	my(@route) = $s_net->route_to_name($path);
	is($route[0][StrassenNetz::ROUTE_EXTRA]{ImportantAngle}, undef, "Important angle not set here (Martin-Luther-Str.)")
	    or diag(Dumper(\@route));
    }
}

__END__
