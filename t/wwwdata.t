#!/usr/bin/perl -w
# -*- perl -*-

#
# Author: Slaven Rezic
#

use strict;

use FindBin;
use lib ("$FindBin::RealBin/..",
	 "$FindBin::RealBin/../lib",
	);

BEGIN {
    if (!eval q{
	use Test::More;
	use LWP::UserAgent;
	use Image::Info;
	1;
    }) {
	print "1..0 # skip no Test::More, Image::Info and/or LWP::UserAgent module\n";
	exit;
    }
}

use Getopt::Long;
use Image::Info qw(image_info);

use Strassen::Core;

plan tests => 47;

my $htmldir = $ENV{BBBIKE_TEST_HTMLDIR};
if (!$htmldir) {
    $htmldir = "http://localhost/bbbike";
}

GetOptions("htmldir=s" => \$htmldir)
    or die "usage?";

my $ua = LWP::UserAgent->new;
$ua->parse_head(0); # too avoid confusion with Content-Type in http header and meta tags
$ua->agent('BBBike-Test/1.0');

my $ua316 = LWP::UserAgent->new;
$ua316->parse_head(0);
$ua316->agent('bbbike/3.16 (Http/4.01) BBBike-Test/1.0');

my $datadir = "$htmldir/data";

my %contents;

for my $do_accept_gzip (0, 1) {
    my $basic_tests = sub {
	my($url, %args) = @_;
	my $ua = $args{ua} || $ua;
	my $contentcompare = exists $args{contentcompare} ? $args{contentcompare} : 1;
	$ua->default_header('Accept-Encoding' => $do_accept_gzip ? "gzip" : undef);
	my $resp = $ua->get($url);
	ok($resp->is_success, "GET $url " . ($do_accept_gzip ? "(Accept gzipped)" : "(uncompressed)"))
	    or diag $resp->status_line;
	my $content = $resp->decoded_content;
	ok(length $content, "Non-empty content");
	if ($contentcompare) {
	    $contents{$url}{$do_accept_gzip} = $content; # remember for later checks
	}
	($resp, $content);
    };

    {
	my $url = "$datadir/.modified";
	my($resp, $content) = $basic_tests->($url);
	my @error_lines;
	for my $line (split /\n/, $content) {
	    if ($line !~ m{^data/\S+\s+\d+\s+[a-fA-F0-9]+$}) {
		push @error_lines, $line;
	    }
	}
	is(@error_lines, 0, "Check data in .modified")
	    or diag "Found unexpected lines in .modified\n@error_lines[0..9]";
    }

    {
	my $url = "$datadir/strassen";
	my($resp, $content) = $basic_tests->($url);
	my $s = eval { Strassen->new_from_data_string($content) };
	is($@, "", "No error while parsing bbd data");
	cmp_ok(@{$s->data}, ">=", 100, "Reasonable number of lines found in data (" . scalar @{$s->data} . ")");
    }

    {
	my $url = "$datadir/sehenswuerdigkeit_img/fernsehturm.gif";
	my($resp, $content) = $basic_tests->($url);
	my $image_info = image_info(\$content);
	ok(!$image_info->{error}, "No error detected while looking at image content");
	is($image_info->{file_media_type}, $resp->header("Content-Type"), "Expected mime type");
	is $resp->header("content-encoding")||'', '', 'No compression for images'
	    or diag <<'EOF';
If mod_deflate is used, then something like

     SetEnvIfNoCase Request_URI \.(?:gif|jpe?g|png)$ no-gzip dont-vary

should be put into the Apache configuration for
the bbbike/data location; or an equivalent solution
for other systems is necessary.
EOF
    }

    {
	my $url = "$htmldir/html/newstreetform.html";
	my($resp, $content) = $basic_tests->($url);
	like($content, qr{<html}, "Could be html content");
	# Note that HTTP header (usually without charset) and meta
	# value (usually with) may contradict, but this is probably no
	# issue. See also parse_head setting above.
	like($resp->header("content-type"), qr{^text/html(;\s*charset=iso-8859-1)?$}, "Content-type check")
	    or diag($resp->as_string);
    }

    # Simulate old BBBike application
    {
	my $url = "$datadir/strassen";
	my($resp, $content) = $basic_tests->($url,
					     ua => $ua316,
					     contentcompare => 0, # do not check data/strassen twice
					    );
	my $s = eval { Strassen->new_from_data_string($content) };
	is($@, "", "No error while parsing bbd data");
	my $count_NH = 0;
	$s->init;
	while () {
	    my $ret = $s->next;
	    last if !@{ $ret->[Strassen::COORDS] };
	    $count_NH++ if $ret->[Strassen::CAT] eq 'NH';
	}
	is $count_NH, 0, 'No cat=NH found for old client';
	is $resp->header('X-BBBike-Hacks'), 'NH', 'NH hack in HTTP header';
    }
}

{
    my $resp = $ua316->get("$datadir/label", 'If-Modified-Since' => 'Wed, 18 May 2033 05:33:20 GMT');
    ok $resp->code==304 || $resp->code==200, 'Probably data/label hack'
	or diag $resp->as_string;
}

while(my($url,$v) = each %contents) {
    ok $v->{0} eq $v->{1}, "Same contents for $url";
}

__END__
