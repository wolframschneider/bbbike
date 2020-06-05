#!/usr/bin/perl -w
# -*- mode:cperl;coding:raw-text; -*-

#
# Author: Slaven Rezic
#

use strict;

use FindBin;
use lib ("$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	 "$FindBin::RealBin/../data",
	 "$FindBin::RealBin",
	);
use Data::Dumper qw(Dumper);
use Getopt::Long;

use BBBikeUtil qw(is_in_path);
use BBBikeTest;
use Strassen::Core;
use Strassen::Dataset;
use Strassen::MultiStrassen;
use Strassen::StrassenNetz;
eval q{ use BBBikeXS; };

BEGIN {
    if (!eval q{
	use Test::More;
	use File::Temp qw(tempfile);
	1;
    }) {
	print "1..0 # skip no Test::More and/or File::Temp module(s)\n";
	exit;
    }
}

my $pdfinfo_tests = 5;
plan tests => (2+$pdfinfo_tests)*2;

my $lang;
my $Route_PDF_class = 'Route::PDF';
my $debug;
my($start_coord, $via_coord, $goal_coord);
my $use_pango = 1;
if (!GetOptions("lang=s" => \$lang,
		"class=s" => \$Route_PDF_class,
		"pango!" => \$use_pango,
		"debug" => \$debug,
		"start=s" => \$start_coord,
		"via=s" => \$via_coord,
		"goal=s" => \$goal_coord,
		get_std_opts(qw(display pdfprog)),
	       )) {
    die "usage: $0 [-lang lang] [-debug] [-pdfprog pdfviewer] [-display] [-class Route::PDF::...] [-nopango] [-start ... -goal ... [-via ...]]";
}

if (!$use_pango) {
    no warnings 'once';
    $Route::PDF::Cairo::DONT_USE_PANGO = 1;
}

if ($start_coord || $via_coord || $goal_coord) {
    if (!$start_coord) {
	die "-start is mandatory if any of -via and -goal is used.\n";
    }
    if (!$goal_coord) {
	die "-goal is mandatory if any of -start and -via is used.\n";
    }
}

if (!eval 'use ' . $Route_PDF_class . '; 1') {
    die $@;
}

my(undef, $pdffile) = tempfile(SUFFIX => "_test.pdf",
			       UNLINK => 1);

my @arg = (-filename => $pdffile);

my $s = Strassen->new("strassen");
my $inacc = Strassen->new("inaccessible_strassen");
my $inacc_hash = $inacc->get_hashref;

my $net = StrassenNetz->new($s);
$net->make_net;

my $via_name;
if (!$start_coord) {
    for my $coordref (\$start_coord, \$via_coord, \$goal_coord) {
	while(1) {
	    my $r = $s->get(rand($#{$s->{Data}}));
	    $$coordref = $r->[Strassen::COORDS][0];
	    if ($coordref == \$via_coord) {
		$via_name = $r->[Strassen::NAME];
	    }
	    last if (!exists $inacc_hash->{$$coordref});
	}
    }
}

BBBikeTest::report_on_error({debug => \$debug}, start => $start_coord, via => $via_coord, goal => $goal_coord);

my($route) = $net->search($start_coord, $goal_coord,
			  ($via_coord ? (Via => [$via_coord]) : ()),
			  AsObj => 1);

my $comments_net;
{
    my @s;
    for my $s ((map { "comments_$_" } @Strassen::Dataset::comments_types),
	       qw(handicap_s qualitaet_s)) {
	eval {
	    push @s, Strassen->new($s);
	};
	warn "$s: $@" if $@;
    }
    if (@s) {
	$comments_net = StrassenNetz->new(MultiStrassen->new(@s));
	$comments_net->make_net_cat(-net2name => 1, -multiple => 1);
    }
}

my $rp = $Route_PDF_class->new(@arg);
$rp->output(($lang ? (-lang => $lang) : ()),
	    ($via_name ? (-vianame => $via_name) : ()),
	    -commentsnet => $comments_net,
	    -net => $net,
	    -route => $route,
	   );
$rp->flush;

maybe_display($pdffile);
trivial_pdf_test($pdffile);
pdfinfo_test($pdffile);

{
    # testing with UTF-8 encoding
    # note on renderers:
    # - PDF::Create does not handle full set of Unicode, instead Text::Unidecode is used
    # - Cairo+Pango support much of Unicode, i.e. all of the following test cases look fine
    my(undef, $pdffile) = tempfile(SUFFIX => "_test.pdf",
				   UNLINK => 1);
    my $s = Strassen->new_from_data_string(<<EOF);
#: encoding: utf-8
#:
Dudenstraße	X 100,100 200,200 300,300
Trg bana Jelačića	X 300,300 400,400 500,500
# Moskva, cyrillic:
Москва	X 500,500 600,600
# Jerusalem, hebrew:
ירושלים	X 600,600 700,700
# Jerusalem, arabic:
‏القدس‎	X 700,700 800,800
# Tokyo:
東京	X 800,800 900,900
EOF
    my $start = $s->get(0)          ->[Strassen::COORDS()]->[0];
    my $goal  = $s->get($s->count-1)->[Strassen::COORDS()]->[-1];

    my $net = StrassenNetz->new($s);
    $net->make_net;
    my($route) = $net->search($start, $goal, AsObj => 1);
    my $rp = $Route_PDF_class->new(-filename => $pdffile);
    $rp->output(($lang ? (-lang => $lang) : ()),
		-net => $net,
		-route => $route,
	       );
    $rp->flush;
    maybe_display($pdffile);
    trivial_pdf_test($pdffile);
    pdfinfo_test($pdffile);
}

sub maybe_display {
    my $pdffile = shift;
    if ($do_display) {
	do_display($pdffile);
	sleep 5; # for the displaying program to settle, otherwise the temporary file might be already deleted
    }
}

sub trivial_pdf_test {
    my $pdffile = shift;
    ok(-s $pdffile, "$pdffile is non-empty");
    open my $PDF, $pdffile or die "Can't open $pdffile: $!";
    my $firstline = <$PDF>;
    like($firstline, qr/^%PDF-1\.\d+/, "PDF magic in $pdffile");
}

sub pdfinfo_test {
    my $pdffile = shift;
 SKIP: {
	my $info = pdfinfo $pdffile;
	skip 'No pdfinfo available', $pdfinfo_tests
	    if !$info;

	my $info_like = sub {
	    my($k,$rx) = @_;
	    my $v = $info->{$k} || '';
	    like $v, $rx, "Check for $k"
		or do { $debug && diag Dumper($info) };
	};
	$info_like->('Page size', qr{A4});
	{
	    local $TODO;
	    if ($Route_PDF_class eq 'Route::PDF::Cairo') {
		$TODO = 'Cannot set Author, or Title with cairo';
	    }
	    $info_like->('Title', qr{BBBike Route});
	    $info_like->('Author', qr{Slaven Rezic});
	}
	if ($Route_PDF_class eq 'Route::PDF::Cairo') {
	SKIP: {
		skip "CPAN::Version not available", 1
		    if !eval { require CPAN::Version; 1 };
		my($cairo_version) = $info->{Producer} =~ m{^cairo (\d+\.\d+\.\d+)};
		if (CPAN::Version->vge($cairo_version, "1.15.4")) {
		    local $TODO = "cairo 1.15.4+ has pdf metadata support, but not yet supported by the perl module";
		    $info_like->('Creator', qr{^BBBikeDraw::PDFCairo version \d+\.\d+});
		} else {
		    $info_like->('Creator', qr{^cairo \d+\.\d+\.\d+});
		}
	    }
	    $info_like->('Producer', qr{^cairo\s+\d+\.\d+\.\d+});
	} else {
	    $info_like->('Creator', qr{Route::PDF version \d+\.\d+});
	    $info_like->('Producer', qr{PDF::Create version \d+\.\d+});
	}
    }
}

__END__
