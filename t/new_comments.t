#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: new_comments.t,v 1.2 2005/03/19 11:14:05 eserte Exp $
# Author: Slaven Rezic
#

use strict;
use FindBin;
use lib ("$FindBin::RealBin/../lib",
	 "$FindBin::RealBin/..",
	 "$FindBin::RealBin/../data",
	);
use Strassen;

BEGIN {
    if (!eval q{
	use Test::More;
        use YAML;
	use Strassen::StrassenNetzNew;
	require "$FindBin::RealBin/../miscsrc/XXX_new_comments.pl";
	1;
    }) {
	print "1..0 # skip: no Test::More, YAML, Strassen::StrassenNetzNew modules or new_comments script\n";
	exit;
    }
}


my @tests = (
	     ["700,1000", "1000,1600", <<EOF, "Kombination von gleichen Abschnitten"],
- ''
- 'bis K�nigsberger Str.: Route H, Parkweg, OK'
- ~
EOF

	     ["2000,1000", "1700,1300", <<EOF, "Punktkommentare"],
- ''
- Einfahrt in Hausdurchgang
- ~
EOF
	     ["2000,1000", "2000,1600", <<EOF, "Kein Punktkommentar"],
- ''
- ~
EOF
	    );

plan tests => scalar @tests;

my $str_data = <<EOF;
Foobar	N 700,1000 1000,1000
Promenade, am Teltowkanal	N 1000,1000 1000,1300 1000,1600
K�nigsberger Str.	N 700,1300 1000,1300
Frankfurter Allee	H 2000,1000 2000,1200 2000,1300 2000,1600
(Kreutziger Str. - Frankfurter Allee)	NN 1700,1300 2000,1300
EOF

my $qs_data = <<EOF;
Promenade: Route H	CS 1000,1000 1000,1300
Promenade: Parkweg, OK	Q1 1000,1000 1000,1300
Frankfurter Allee - Kreutzigerstr.: Einfahrt in Hausdurchgang	CP; 2000,1200 2000,1300 1700,1300
EOF

my $str = Strassen->new_from_data_string($str_data);
my $net = StrassenNetz->new($str);
$net->make_net;

my $qs = Strassen->new_from_data_string($qs_data);
my $qs_net = StrassenNetz->new($qs);
$qs_net->make_net_cat(-net2name => 1, -multiple => 1);

my $handicap_net = StrassenNetz->new(Strassen->new("handicap_s"));
$handicap_net->make_net_cat;

my $comments_net = $qs_net;

my $comments_points = $net->make_comments_points;

my $fragezeichen_net = StrassenNetz->new(Strassen->new("fragezeichen"));
$fragezeichen_net->make_net_cat;

NewComments::set_data($net, $qs_net);

## Setup end

for my $test (@tests) {
    my($from, $to, $expected, $desc) = @$test;
    my($route) = $net->search($from, $to,
			      AsObj => 1,
			     );

    my $res = $net->extended_route_info(Route => $route,
					City => "Berlin_DE",
					GoalName => "Ziel!",
					HandicapNet => $handicap_net,
					CommentsNet => $comments_net,
					CommentsPoints => $comments_points,
					FragezeichenNet => $fragezeichen_net,
				       );
    NewComments::process_data($res);

    my $comments = [ map { $_->{Comment} } @{$res->{Route}} ];
    is(YAML::Dump($comments), "--- #YAML:1.0\n$expected", $desc)
	or diag NewComments::output_data($res);
}

__END__
