#!/usr/bin/perl -w
# -*- perl -*-

#
# $Id: strassen-agrep.t,v 1.1 2009/02/15 20:49:41 eserte Exp $
# Author: Slaven Rezic
#

use strict;
use FindBin;
use lib ("$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	);

use File::Temp qw(tempfile);

BEGIN {
    if (!eval q{
	use Test::More;
	1;
    }) {
	print "1..0 # skip no Test::More module\n";
	exit;
    }
}

my $data = <<'EOF';
Dudenstr.	X 1,1
Angermünder Str.	X 1,1
Unkeallee (A)	X 1,1
Unkeallee (B)	X 1,1
Weißenseer Weg	X 1,1
Garibaldistr. (13158)	N 13.36129,52.58418 13.36138,52.58526 13.36158,52.58592 13.36188,52.58604 13.36248,52.58626 13.36337,52.58614 13.36544,52.58593 13.36688,52.58554 13.36884,52.58491
EOF
#Bergstr. (Mitte)	N 9792,13681 9718,13885 9663,14036 9399,14143

my @search_types = ("agrep", "String::Approx", "perl");
my $non_approx_tests = 9;
my $approx_tests     = 2;
my $tests_per_type = $non_approx_tests + $approx_tests;

plan tests => @search_types * 2 * $tests_per_type;

use Strassen::Core;

my $s_latin1;
{
    my($tmpfh,$tmpfile) = tempfile(SUFFIX => "teststrassen.bbd",
				   UNLINK => 1);
    print $tmpfh <<EOF;
#: encoding: iso-8859-1
#:
EOF
    print $tmpfh $data;
    close $tmpfh;
    $s_latin1 = Strassen->new($tmpfile);
}

my $s_utf8;
{
    my($tmpfh,$tmpfile) = tempfile(SUFFIX => "teststrassen_utf8.bbd",
				   UNLINK => 1);
    print $tmpfh <<EOF;
#: encoding: utf-8
#:
EOF
    binmode $tmpfh, ':encoding(utf-8)';
    print $tmpfh $data;
    close $tmpfh;
    $s_utf8 = Strassen->new($tmpfile);
}

#                    agrep or perl
#                      String::Approx or perl
for my $search_def (@search_types) {
    local $Strassen::OLD_AGREP;
    my %args;
    if ($search_def eq 'agrep') {
	# OK
    } else {
	$Strassen::OLD_AGREP = 1;
	if ($search_def eq 'String::Approx') {
	    # OK
	} else {
	    %args = (NoStringApprox => 1);
	}
    }

    for my $encoding_def ([$s_latin1, 'latin1'],
			  [$s_utf8, 'utf-8'],
			 ) {
	my($s, $encoding) = @$encoding_def;
	my $check = sub {
	    my($supply, $expected) = @_;
	    local $Test::Builder::Level = $Test::Builder::Level+1;
	    is_deeply([$s->agrep($supply, %args)], $expected, "Search for '$supply' ($search_def, $encoding)");
	};
	$check->("Dudenstr", ["Dudenstr."]);
	$check->("garibaldistr", ["Garibaldistr. (13158)"]);
	$check->("Angermünder Str", ["Angermünder Str."]);
	$check->("Weißenseer Weg", ["Weißenseer Weg"]);
	$check->("Unkeallee", ["Unkeallee (A)", "Unkeallee (B)"]);
	$check->("Garibaldi", ["Garibaldistr. (13158)"]);
	$check->("Really does not exist!", []);
	{
	    local $TODO = "Not implemented yet: substituting straße with str";
	    # see _strip_strasse and _expand_strasse in PLZ.pm
	    $check->("Dudenstraße", ["Dudenstr."]);
	    $check->("Dudenstrasse", ["Dudenstr."]);
	}
    SKIP: {
	    skip("No approx search with 'perl' search type", $approx_tests)
		if $search_def eq 'perl';
	    $check->("Dudentsr", ["Dudenstr."]);
	    $check->("Angermunder Str", ["Angermünder Str."]);
	}
    }
}

__END__
