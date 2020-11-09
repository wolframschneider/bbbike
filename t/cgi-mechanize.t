#!/usr/bin/perl -w
# -*- perl -*-

#
# Author: Slaven Rezic
#

# Expect test failures if the server returns utf-8 encoded content, but
# the test script runs under perl 5.8.7 or older.

use strict;

BEGIN {
    if (!eval q{
	use WWW::Mechanize 1.70;
	#use WWW::Mechanize::FormFiller;# not yet
	use URI::URL;
	use Test::More;
	1;
    }) {
	print "1..0 # skip no Test::More, URI::URL and/or WWW::Mechanize modules\n";
	exit;
    }
    if ($ENV{BBBIKE_TEST_ORG}) {
	print "1..0 # skip on bbbike.org\n";
	exit;
    }
}

use FindBin;
use lib ("$FindBin::RealBin",
	 "$FindBin::RealBin/..",
	);
use BBBikeTest;

use Getopt::Long;
use POSIX qw(strftime);
use URI ();
use URI::QueryParam ();

sub handle_xml_response ($);

check_cgi_testing;

my @browsers;
my $v;
my %do_xxx;
		
if (!GetOptions(get_std_opts("cgiurl", "xxx"),
		"v" => \$v,
		'browser=s@' => \@browsers,
		'xxx-petri-dank' => \$do_xxx{PETRI_DANK},
	       )) {
    die "usage: $0 [-cgiurl url] [-xxx|-xxx-petri-dank] [-v] [-browser ...]";
}

if (!@browsers) {
    @browsers
	= ("Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913",
	   "Lynx/2.8.3rel.1 libwww-FM/2.14 SSL-MM/1.4.1 OpenSSL/0.9.5a",
	   "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; [eburo v1.3]; Wanadoo 7.0 ; NaviWoo1.1)"
	  );
}
@browsers = map { "$_ BBBike-Test/1.0" } @browsers;

my $outer_berlin_tests = 36;
my $tests = 150 + $outer_berlin_tests;
plan tests => $tests * @browsers;

if ($WWW::Mechanize::VERSION == 1.32) {
    diag <<EOF;
**********************************************************************
* Expect a failed test suite with this WWW::Mechanize version ($WWW::Mechanize::VERSION)
**********************************************************************
EOF
}

######################################################################
# general testing

for my $browser (@browsers) {

    my $is_textbrowser = $browser =~ /^lynx/i;
    my $can_javascript = $browser !~ /^(lynx|dillo)/i;

    my $agent;
    #XXX my $formfiller;
    my $get_agent = sub {
	$agent = WWW::Mechanize->new(keep_alive => 1);
	$agent->agent($browser);
	#XXX $formfiller = WWW::Mechanize::FormFiller->new();
	$agent->env_proxy();
    };

    my $result_search_form_button = sub {
	my($agent, $button_value) = @_;
	if (!$can_javascript) {
	    $agent->follow_link(text => $button_value);
	} else {
	    my $form = $agent->form_name("search");
	    my($input) = grep { defined $_->{value} && $_->{value} eq $button_value } $form->inputs; # but $_->value should also work?!
	    # Extract javascript location.href=...
	    my $onclick = $input->{onclick};
	    if ($onclick =~ m{'(http://.*)'}) {
		my $new_url = $1;
		$agent->get($new_url);
	    } else {
		die "Cannot find link in <$onclick>";
	    }
	    #$agent->click_button(value => "Start beibehalten");
	}
    };

    my $like_long_data = sub {
	my($expected, $testname, $suffix) = @_;
	$suffix = ".html" if !defined $suffix;
	local $Test::Builder::Level = $Test::Builder::Level+1;
	like_long_data(get_ct($agent), $expected, $testname, $suffix)
	    or diag("URL is <" . $agent->uri . ">");
    };

    my $unlike_long_data = sub {
	my($expected, $testname, $suffix) = @_;
	$suffix = ".html" if !defined $suffix;
	local $Test::Builder::Level = $Test::Builder::Level+1;
	unlike_long_data(get_ct($agent), $expected, $testname, $suffix)
	    or diag("URL is <" . $agent->uri . ">");
    };

    my $known_on_2nd_page = sub {
	local $Test::Builder::Level = $Test::Builder::Level+1;
	$unlike_long_data->(qr/ist nicht bekannt/i, "Known street");
	$unlike_long_data->(qr/genaue kreuzung w.*hlen/i, "Exact match, no crossings");
	$like_long_data->(qr/Bevorzugte Geschwindigkeit/i, "Einstellungen page");
    };

    my $on_a_particular_page = sub {
	my($type) = @_;
	if      ($type eq 'startpage') {
	    $like_long_data->(qr/BBBike/,                     "On the start page");
	} elsif ($type eq 'crossing') {
	    $like_long_data->(qr/genaue.*kreuzung.*angeben/i, "On the crossing page");
	} elsif ($type eq 'routeresult') {
	    $like_long_data->(qr/Route/,                      "On the route result page");
	} elsif ($type eq 'settings') {
	    $like_long_data->(qr/Einstellungen/,              "On the settings page");
	} elsif ($type eq 'info') {
	    $like_long_data->(qr/Information/,                "On the info page");
	} elsif ($type eq 'streetform') {
	    $like_long_data->(qr/Neue Stra.*e f.*r BBBike/,   "On the new street form");
	} else {
	    die "Check for '$type' NYI";
	}
    };

    my $not_source_code = sub {
	$unlike_long_data->(qr{/usr/(?:local/)?bin/(?:perl|env)}, 'This is not the source code');
    };

    # -xxx... handling
    for my $key (keys %do_xxx) {
	if ($do_xxx{$key}) {
	    eval 'goto XXX_' . $key; die $@ if $@;
	}
    }
    if ($do_xxx) {
	goto XXX;
    }

    {
	$get_agent->();

	$agent->get($cgiurl);
	$like_long_data->(qr/BBBike/, "Emulating $browser, Startpage $cgiurl is not empty");
	my_tidy_check($agent);

	$agent->form_number(1) if $agent->forms and scalar @{$agent->forms};
	{
	    local $^W; $agent->current_form->value('start', 'duden');
	}
	;
	{
	    # This used to be just "sonntag", but now there are some
	    # new "Kolonien" starting with the same prefix...
	    local $^W; $agent->current_form->value('ziel', 'sonntagstr');
	}
	;
	$agent->submit();
	my_tidy_check($agent);

	$on_a_particular_page->('crossing');
	{
	    local $^W; $agent->current_form->value('startc', '8982,8781');
	}
	;			# Set Duden/Methfesselstr.
	{
	    local $^W; $agent->current_form->value('zielc', '14598,11245');
	}
	;			# Set Sonntag/B�cklinstr.
	$agent->submit();
	my_tidy_check($agent);

	$on_a_particular_page->('routeresult');
	$like_long_data->(qr/Methfesselstr.*
			     Kreuzbergstr.*
			     Mehringdamm.*
			     Bl�cherstr.*
			     Bl�cherplatz.*
			     Waterloo-Ufer.*
			     Gitschiner.Str.*
			     Wassertorplatz.*
			     Skalitzer.Str.*
			     Oppelner.Str.*
			     Oberbaumstr.*
			     Oberbaumbr�cke.*
			     Am.Oberbaum.*
			     Warschauer.Str.*
			     Revaler.Str.*
			     Libauer.Str.*
			     Kopernikusstr.*
			     W�hlischstr.*
			     Sonntagstr.
			    /xs, 'Route list between Duden..Sonntag');

	my $has_ausweichroute = ($agent->forms)[0]->attr("name") =~ /Ausweichroute/;
	{
	    my $formnr = $has_ausweichroute ? 2 : 1;
	    $agent->form_number($formnr);
	    $agent->submit();
	}

	like($agent->ct, qr{^image/}, "Content is image");
	$agent->back();

	{
	    my $formnr = $has_ausweichroute ? 4 : 3;
	    $agent->form_number($formnr);
	}
	$agent->submit();
	my_tidy_check($agent);

	$result_search_form_button->($agent, 'Start beibehalten');

	my_tidy_check($agent);

	$on_a_particular_page->('startpage');
	$like_long_data->(qr/Sonntagstr./, "... with the start street preserved");

	{
	    local $^W; $agent->current_form->value('via', 'Heerstr');
	}
	;
	{
	    local $^W; $agent->current_form->value('ziel', 'Adlergestell');
	}
	;
	$agent->submit();
	my_tidy_check($agent);

	$like_long_data->(qr/genaue/i, "expecting multiple matches");
	$agent->submit();
	my_tidy_check($agent);

	$on_a_particular_page->('crossing');
	{
	    local $^W; $agent->current_form->value('zielc', '27360,-3042');
	}
	;			# Wernsdorfer Str.
	$agent->submit();
	my_tidy_check($agent);

	$on_a_particular_page->('routeresult');
	$like_long_data->(qr/B�cklinstr.*
			     W�hlischstr.*
			     Boxhagener.Str.*
			     Marktstr.*
			     (
			      Karlshorster.Str.*
			     |
			      # Alternative route, needed since 2016-11-04 because of oneway in N�ldnerstr.
			      T�rrschmidtstr.*
			      Stadthausstr.*
			     )
			     N�ldnerstr.*
			     L�ckstr.*
			     Sewanstr.*
			     (Dathepromenade.*
			      Erieseering.*
			      Sewanstr.*
			     )? # since 2012-11-11 BBBike is choosing a straight route via Sewanstr.
			     Am.Tierpark.*
			     Richard-Kolkwitz-Weg.*
			     R�geliner.Str.*
			     # skipping some streets, because coverage not yet good here
			     # Heerstr.* # the one in Kaulsdorf # probably only crossed, so not in route list?
			     Gr�nauer.Str.*
			     Regattastr.*
			     Adlergestell
			    /xs, 'Route list between Sonntag..Adlergestell');
	{
	    my $formnr = (($agent->forms)[0]->attr("name") =~ /Ausweichroute/ ? 3 : 2);
	    $agent->form_number($formnr);
	}
	eval { local $^W; $agent->current_form->value('pref_speed', '25'); };
	is($@, "", "setting pref_speed ok");
	eval { local $^W; $agent->current_form->value('pref_cat', 'N_RW'); };
	is($@, "", "setting pref_cat ok");
	eval { local $^W; $agent->current_form->value('pref_quality', 'Q2'); };
	is($@, "", "setting pref_quality ok");
	eval { local $^W; $agent->current_form->value('pref_ampel', 'yes'); };
	is($@, "", "setting pref_ampel ok");
	eval { local $^W; $agent->current_form->value('pref_green', 'GR2'); };
	is($@, "", "setting pref_green ok");
	$agent->submit();
	my_tidy_check($agent);

	$like_long_data->(qr/Route/, "Route in content");

	######################################################################
	# exact crossings
	$result_search_form_button->($agent, 'Start und Ziel neu eingeben');
	#XXX del: $agent->follow('Start und Ziel neu eingeben');
	$agent->current_form->value('start', 'seume/simplon');
	$agent->current_form->value('ziel', 'brandenburger tor (mitte)');
	$agent->submit;
	my_tidy_check($agent);

	$on_a_particular_page->('settings');
	$unlike_long_data->(qr{genaue.*kreuzung}i, "Crossings are exact");

	######################################################################
	# go to leaflet map
	$agent->back;
	$agent->back;
	$on_a_particular_page->('routeresult'); # double check
	my $form = $agent->form_name("showmap");
	ok $form, 'Found showmap';
	my $onsubmit_val = $form->attr('onsubmit');
	ok $onsubmit_val, 'Found onsubmit attrib';
	my($leaflet_url) = $onsubmit_val =~ m{leaflet_url:"(.*?)"};
	like $leaflet_url, qr{^https?://}, 'found leaflet_url and it looks like a URL';
	$agent->get($leaflet_url);
	my_tidy_check($agent);
	$like_long_data->(qr{BBBike.*Leaflet}, 'probably on leaflet page');
	$like_long_data->(qr{<script src=".*bbbikeleaflet\.js}, 'found javascript src');
    }

    ######################################################################
    # A street in Potsdam but not in "landstrassen"

 XXX_PETRI_DANK: {

	$get_agent->();

	$agent->get($cgiurl);
	$agent->form_name("BBBikeForm");
	{
	    local $^W; $agent->current_form->value('start', 'Petri Dank');
	}
	;
	{
	    local $^W; $agent->current_form->value('ziel', 'R�mische B�der');
	}
	;
	$agent->submit();
	my_tidy_check($agent);

	# May have different results depending on $use_exact_streetchooser.
	# The first is with $use_exact_streetchooser=0, the second with
	# $use_exact_streetchooser=1. Actually the correct crossing in this case
	# should be the end of "Lenn�str.", but the find-nearest-crossing code finds
	# only real crossing, not endpoints of streets.
	{
	    local $TODO;
	    $TODO = "Known to fail with perl 5.10.0 (regexp problem)"
		if $] == 5.010;
	    $like_long_data->(
	     qr{(\QHans-Sachs-Str. (Potsdam)/Meistersingerstr. (Potsdam)\E
		|\QCarl-von-Ossietzky-Str. (Potsdam)/Lenn�str. (Potsdam)\E
		|\Q(�konomieweg, Sanssouci) (Potsdam)/(Lenn�str. - �konomieweg, Sanssouci)\E
		|\Q(�konomieweg, Sanssouci)/(Lenn�str. - �konomieweg, Sanssouci) (Potsdam)\E
		|\Q(Lenn�str. - �konomieweg, Sanssouci) (Potsdam)/Lenn�str. (Potsdam)\E
		|\Q(Lenn�str. - �konomieweg, Sanssouci) (Potsdam)/(Hans-Sachs-Str. - Lenn�str.) (Potsdam)/Lenn�str. (Potsdam)\E
		|\Q(Lenn�str. - �konomieweg, Sanssouci)/(Hans-Sachs-Str. - Lenn�str.)/Lenn�str. (Potsdam)\E
		|\QR�mische B�der\E
	       )}ix,  "Correct goal resolution (Hans-Sachs-Str. ... or Lenn�str. ... or �konomieweg ... or R�mische B�der)");
	}
	$like_long_data->(qr{(\QSchl�nitzseer Weg (Potsdam-Bornim)/Feldweg (Potsdam-Schl�nitzsee)\E
			     |\QK�nigsdamm (Grube)/Schl�nitzseer Weg (Marquardt)\E # before adding the extra point between Schl�nitzseer Weg and Feldweg
			     |\QMarquardter Damm (Marquardt)/Schl�nitzseer Weg (Marquardt)\E # before renaming Marquardter Damm -> K�nigsdamm
			     |\QMarquardter Damm/Schl�nitzseer Weg (Marquardt)\E
			     |\QK�nigsdamm/Feldweg (Potsdam-Grube)\E # after more data update work in Schl�nitzsee
			    )}ix,  "Correct goal resolution (Schl�nitzsee ...)");
                           
    }

    ######################################################################
    # test for Kaiser-Friedrich-Str. (Potsdam) problem

    {

	$get_agent->();

	$agent->get($cgiurl);
	$agent->form_name("BBBikeForm");
	{
	    local $^W; $agent->current_form->value('start', 'kaiser-friedrich-str');
	}
	;
	{
	    local $^W; $agent->current_form->value('ziel', 'helmholtzstr');
	}
	;
	$agent->submit();
	my_tidy_check($agent);

	$like_long_data->(qr/genaue.*startstr.*ausw/i, "Start is ambiguous");
	$like_long_data->(qr/genaue.*zielstr.*ausw/i,  "Goal is ambiguous");

	$agent->form_name("BBBikeForm");

	my $form = $agent->current_form;
	my $input = $form->find_input("start2");
	ok($input, "start2 input exists");
    TRY: {
	    my $testname = "Potsdam among start alternatives";
	    for my $value ($input->possible_values) {
		if ($value =~ /potsdam/i) {
		    $input->value($value);
		    pass($testname);
		    last TRY;
		}
	    }
	    fail($testname);
	    diag("Selection box is empty") if !$input->possible_values;
	}

	$input = $form->find_input("ziel2");
	ok($input, "ziel2 input exists");
    TRY: {
	    my $testname = "Potsdam among goal alternatives";
	    for my $value ($input->possible_values) {
		if ($value =~ /potsdam/i) {
		    $input->value($value);
		    pass($testname);
		    last TRY;
		}
	    }
	    fail($testname);
	    diag("Selection box is empty") if !$input->possible_values;
	}

	$agent->submit;
	my_tidy_check($agent);

	$on_a_particular_page->('crossing');
	$like_long_data->(qr/Kuhfort(er )?damm/i, "Expected start crossing");
	$like_long_data->(qr/Mangerstr/, "Expected goal crossing");

    }

    ######################################################################
    # test for Am Neuen Palais

    {

	$get_agent->();

	$agent->get($cgiurl);
	$agent->form_name("BBBikeForm");
	{
	    local $^W; $agent->current_form->value('start', 'am neuen palais');
	}
	;
	{
	    local $^W; $agent->current_form->value('ziel', 'dudenstr');
	}
	;
	$agent->submit();
	my_tidy_check($agent);

	$on_a_particular_page->('crossing');
	$like_long_data->(qr/\QAm Neuen Palais (Potsdam)/i,  "Correct start resolution (Neues Palais ...)");

    }

    ######################################################################
    # Test custom blockings

    {
	my %common_args = (
			   pref_seen  => 1,
			   pref_speed => 20,
			   output_as  => 'xml',
			   fake_time => 1338739578-3600, # to enable the blocking "'Braunschweiger Str./Karl-Marx-Str.: Abbiegen nicht m�glich (bzw. nur auf dem Gehweg) bis 31.12.2012'"
			  );
	{
	    # Wegf�hrung, r�ck
	    $get_agent->();
	    my $url = URI->new($cgiurl);
	    $url->query_form_hash({startc    => '12980,7597',
				   zielc     => '13150,7254',
				   startname => 'Karl-Marx-Str.',
				   zielname  => 'Braunschweiger Str.',
				   %common_args,
				  });
	    my $resp = $agent->get($url);
	    my $root = handle_xml_response $resp;
	SKIP: {
		skip "Missing prerequisites (XML::LibXML?) for further XML tests", 2
		    if !$root;
		my($affBlockNode) = $root->findnodes("/BBBikeRoute/AffectingBlocking");
		ok $affBlockNode, "Found AffectingBlocking node";
		like $affBlockNode->findvalue('./Text'), qr{Abbiegen nicht m.*glich}, 'Temp blockings, Wegfuehrung rueckwaerts';
	    }
	}

	{
	    # Wegf�hrung, hin
	    $get_agent->();
	    my $url = URI->new($cgiurl);
	    $url->query_form_hash({startc    => '13150,7254',
				   zielc     => '12980,7597',
				   startname => 'Braunschweiger Str.',
				   zielname  => 'Karl-Marx-Str.',
				   %common_args,
				  });
	    my $resp = $agent->get($url);
	    my $root = handle_xml_response $resp;
	SKIP: {
		skip "Missing prerequisites (XML::LibXML?) for further XML tests", 2
		    if !$root;
		my($affBlockNode) = $root->findnodes("/BBBikeRoute/AffectingBlocking");
		ok $affBlockNode, "Found AffectingBlocking node"
		    or diag $root->serialize(1);
		like $affBlockNode->findvalue('./Text'), qr{Abbiegen nicht m.*glich}, 'Temp blockings, Wegfuehrung';
	    }
	}

	{
	    # Wegf�hrung schl�gt hier *nicht* an, trotz gemeinsamer Abschnitte
	    $get_agent->();
	    my $url = URI->new($cgiurl);
	    $url->query_form_hash({startc    => '13015,7440',
				   zielc     => '13095,6926',
				   startname => 'Karl-Marx-Str.',
				   zielname  => 'Karl-Marx-Str..',
				   %common_args,
				  });
	    my $resp = $agent->get($url);
	    my $root = handle_xml_response $resp;
	SKIP: {
		skip "Missing prerequisites (XML::LibXML?) for further XML tests", 1
		    if !$root;
		my($affBlockNode) = $root->findnodes("/BBBikeRoute/AffectingBlocking");
		ok !$affBlockNode, "No AffectingBlocking found"
		    or diag "Found unexpected blocking: " . $affBlockNode->toString;
	    }
	}
    }

    {

	# Hier wird eine tempor�re baustellenbedingte Einbahnstra�e in
	# der Rixdorfer Str. getestet.
	# Diese Einschr�nkung hat das Attribut "handicap" gesetzt.

	$get_agent->();

	$agent->get($cgiurl);
	$agent->form_name("BBBikeForm");
	{
	    local $^W; $agent->current_form->value('start', 'Rixdorfer Str. (Niedersch�neweide)/schnellerstr');
	}
	;
	{
	    local $^W; $agent->current_form->value('ziel', 'Rixdorfer Str. (Niedersch�neweide)/s�dostallee');
	}
	;
	$agent->submit;

	$agent->submit;

	$like_long_data->(qr{Route von.*Schnellerstr.*bis.*S.*dostallee}, 'Route header, to');

	{
	    my $content = get_ct($agent);
	    if ($content =~ /L.*?nge:.*?([\d\.]+)\s*km/) {
		my $length = $1;
		cmp_ok($length, "<=", 1, "Short path (got $length km)")
		    or diag $content;
	    } else {
		fail("Cannot get length from content, URL is <" . $agent->uri . ">");
		diag $content;
	    }
	}

	{
	    my $url = $agent->uri;
	    $url .= ";test=custom_blockings";
	    $agent->get($url);
	}

	my_tidy_check($agent);
	$like_long_data->(qr{Ereignisse, die die Route betreffen}, "Found temp blocking hit");
	$like_long_data->(qr{\(Zeitverlust ca\. \d+ Minuten\)}, "Found Zeitverlust for handicap-typed blocking");
	$like_long_data->(qr{Ausweichroute suchen}, "Found Ausweichroute button");
	my $ausweichroute_choose_url = $agent->uri;
	my $form = $agent->form_name("Ausweichroute");
	isa_ok($form, "HTML::Form");
	for my $input ($form->inputs) {
	    if ($input->type eq 'checkbox') {
		$input->check;
	    }
	}
	$agent->submit;

	my_tidy_check($agent);
	$like_long_data->(qr{M.*gliche Ausweichroute}, "Using Ausweichroute");
	$like_long_data->(qr{\(um \d+ Meter l.*nger\)}, "Info: l�ngere Route")
	    or diag("Test is known to fail if Apache::Session::Counted is not available");
	if (get_ct($agent) =~ /L.*?nge:.*?([\d\.]+)\s*km/) {
	    my $length = $1;
	    cmp_ok($length, ">=", 1, "Longer path ($length km)");
	} else {
	    fail("Cannot get length from content");
	}
# XXX do not indent next line!
#: next_check_id: STERNDAMM-2016
	if (strftime("%Y-%m-%d %H:%M:%S", localtime) lt "2018-06-16 00:00:00") {
	    $like_long_data->(qr{Baumschulenweg}, "Expected street in Ausweichroute (while Sterndamm is blocked)");
	} else {
	    $like_long_data->(qr{Sterndamm}, "Expected street in Ausweichroute");
	}

	$agent->form_name('search');
	$agent->click_button(value => "R�ckweg");

	$unlike_long_data->(qr{Ausweichroute}, "Keine Ausweichroute mehr");

	$like_long_data->(qr{Route von.*S.*dostallee.*bis.*Schnellerstr}, 'Route header, way back');

	{
	    my $url = $ausweichroute_choose_url . ";output_as=xml";
	    my $resp = $agent->get($url);
	    my $root = handle_xml_response $resp;
	SKIP: {
		skip "Missing prerequisites (XML::LibXML?) for further XML tests", 5
		    if !$root;
		my($affBlockNode) = $root->findnodes("/BBBikeRoute/AffectingBlocking");
		ok($affBlockNode, "Found AffectingBlocking node");
		my($xy) = $affBlockNode->findvalue("./LongLatHop/XY[position()=1]");
		like($xy, qr{^13\.\d+,52\.\d+$}, "XY looks like long/lat in Berlin");
		is($affBlockNode->findvalue("./Text"), 'Rixdorfer Str. (Treptow) in beiden Richtungen zwischen S�dostallee und Schnellerstr. Baustelle, Stra�e vollst�ndig gesperrt (bis 07.08.2006 5 Uhr)', "temp blockings text");
		is($affBlockNode->findvalue("./Index"), 631, "temp blockings id");
		is($affBlockNode->findvalue("./Type"), "handicap", "temp blockings type");
	    }
	}
    }

    {
	# Ausweichroute ohne Ergebnis (weil Start und/oder Ziel im gesperrten Gebiet liegen)
	$get_agent->();
	my $url = URI->new($cgiurl);
	$url->query_form_hash({startc=>'-15820,-1146',
			       startname=>'Neues Palais (Potsdam)',
			       zielname=>'Potsdam Hauptbahnhof (Potsdam)',
			       zielc=>'-12493,-1896',
			       scope=>'region',
			       pref_speed=>20,
			       pref_seen=>1,
			      });
	my $resp = $agent->get($url);
	ok $resp->is_success, 'Neues Palais - Potsdam Hbf';
	$like_long_data->(qr{Sanssouci.*Einbruch der Dunkelheit}, 'Ausweichroutenhinweis');
	$agent->click_button(value => 'Ausweichroute suchen');
	$like_long_data->(qr{Es existiert keine Ausweichroute}, 'Ausweichroute existiert nicht');
    }

 XXX: { ; }
    {
	# Ausweichroute f�r saisonale F�hre (hier: BVG-F�hre F23)
	$get_agent->();
	my $url = URI->new($cgiurl);
	$url->query_form_hash({startc=>'29985,2917',
			       startname=>'Zur F�hre (M�ggelheim)',
			       zielname=>'Dorfstr. (Rahnsdorf)',
			       zielc=>'29998,3170',
			       scope=>'city',
			       pref_speed=>20,
			       pref_ferry=>'use',
			       pref_seen=>1,
			       output_as=>'xml',
			      });
	my $resp = $agent->get($url);
	my $root = handle_xml_response $resp;
	SKIP: {
		skip "Missing prerequisites (XML::LibXML?) for further XML tests", 2
		    if !$root;
		my($affBlockNode) = $root->findnodes("/BBBikeRoute/AffectingBlocking");
		ok($affBlockNode, "Found AffectingBlocking node");
		like($affBlockNode->findvalue("./Text"), qr{(Ruderf�hre F24: f�hrt nur samstags.*|F�hren.*F23.*: fahren nur ab .* bis .*, fahren nicht am Montag)}, "temp blockings text");
	    }
    }

    ######################################################################
    # test for a street in Berlin.coords.data but not in strassen

    {

	$get_agent->();

	$agent->get($cgiurl);
	$agent->form_name("BBBikeForm");
	{
	    local $^W; $agent->current_form->value('start', 'kleine parkstr');
	}
	;
	{
	    local $^W; $agent->current_form->value('ziel', 's hauptbahnhof');
	}
	;
	$agent->submit();
	my_tidy_check($agent);

    SKIP: {
	    skip("Street is known now!", 2); # XXX find another unknown street?
	    $like_long_data->(qr/Kleine Parkstr\..*ist nicht bekannt/i, "Street not in database");
	    $like_long_data->(qr{\Qhtml/newstreetform(utf8.)?.html?\E.*\Qstrname=Kleine%20Parkstr}i, "newstreetform link");
	}
	$like_long_data->(qr{Hauptbahnhof.*?die n�chste Kreuzung}is,  "S-Bhf.");
	$like_long_data->(qr{(Invalidenstr.|Ella-Trebe-Str.)}i,  "S-Bhf., next crossing (Invalidenstr or Ella-Trebe-Str.)");
	$like_long_data->(qr{(Minna-Cauer-Str.|Europaplatz)}i,  "S-Bhf., next crossing (Minna-Cauer-Str or Europaplatz)");

    }

    ######################################################################
    # Brandenburger Tor: in Berlin and Potsdam

    {
	$get_agent->();

	$agent->get($cgiurl);
	$agent->form_name("BBBikeForm");
	{
	    local $^W; $agent->current_form->value('start', 'brandenburger tor');
	}
	;
	{
	    local $^W; $agent->current_form->value('ziel', 'seumestr');
	}
	;
	$agent->submit();
	my_tidy_check($agent);

	$like_long_data->(qr/genaue.*startstr.*ausw/i, "Start is ambiguous");
	
	my $form = $agent->current_form;
	my $input = $form->find_input("start2");
	ok($input, "start2 input exists");
	for my $test (["Brandenburger Tor/Mitte among start alternatives",
		       qr/brandenburger tor.*mitte/i],
		      ["Brandenburger Tor/Potsdam among start alternatives",
		       qr/brandenburger tor.*potsdam/i],
		     ) {
	TRY: {
		my $testname = $test->[0];
		my $rx       = $test->[1];
		for my $value ($input->possible_values) {
		    if ($value =~ $rx) {
			pass($testname);
			last TRY;
		    }
		}
		fail($testname);
	    }
	}

	$input->value(($input->possible_values)[0]);
	$agent->submit;
	my_tidy_check($agent);

	$like_long_data->(qr/brandenburger tor.*mitte/i, "Mitte alternative selected");

	$agent->back;

	$form = $agent->current_form;
	$input = $form->find_input("start2");
	for my $value ($input->possible_values) {
	    if ($value =~ /potsdam/i) {
		$input->value($value);
		last;
	    }
	}
	$agent->submit;
	my_tidy_check($agent);

	$like_long_data->(qr/brandenburger tor.*potsdam/i, "Potsdam alternative selected");

	# Search normally
	$agent->submit;
	my_tidy_check($agent);

	## This is now the map:
	#$agent->submit;
	#my_tidy_check($agent);

	# Back to crossings form again
	$agent->back;

	######################################################################
	# winter optimization
	my %winter_len;
	for my $winter_optimization ("", "WI1", "WI2") {
	    $form = $agent->current_form;
	    $input = $form->find_input("pref_winter");
	SKIP: {
		skip("winter_optimization not available", 2) if !defined $input;
		$input->value($winter_optimization);
		$agent->submit;
		my_tidy_check($agent);
		my($len) = get_ct($agent) =~ /l.*?nge:.*?([\d\.]+)\s*km/;
		ok(defined $len, "Got length=$len with winter optimization=$winter_optimization");
		$winter_len{$winter_optimization} = $len;
		$agent->back;
	    }
	}

    SKIP: {
	    skip("winter_optimization not available", 2) if !keys %winter_len;
	    cmp_ok($winter_len{""}, "<=", $winter_len{"WI1"}, "No optimization is shortest");
	    cmp_ok($winter_len{"WI1"}, "<=", $winter_len{"WI2"}, "Strong optimization is farthest");
	}

	######################################################################
	# unlit optimization
	my %unlit_len;
	for my $unlit_value ("", "NL") {
	    $form = $agent->current_form;
	    $input = $form->find_input("pref_unlit");
	SKIP: {
		skip("unlit optimization not available", 2) if !defined $input || $input->readonly;
		if ($unlit_value ne '') {
		    $input->check;
		}
		#$input->value($unlit_value);
		$agent->submit;
		my_tidy_check($agent);
		my($len) = get_ct($agent) =~ /l.*?nge:.*?([\d\.]+)\s*km/;
		ok(defined $len, "Got length=$len with unlit optimization=$unlit_value")
		    or diag("URL is <" . $agent->uri . ">");
		$unlit_len{$unlit_value} = $len;
		$agent->back;
	    }
	}

    SKIP: {
	    skip("unlit optimization not available", 1) if !keys %unlit_len;
	    cmp_ok($unlit_len{""}, "<=", $unlit_len{"NL"}, "No optimization is shortest");
	}
    }


    ######################################################################
    # non-utf8 checks

    {
	$get_agent->();

	$agent->get($cgiurl);
	is($agent->response->code, 200, "$cgiurl returned OK");

	$agent->follow_link(text_regex => qr/Info/);
	my_tidy_check($agent);

	$on_a_particular_page->('info');
	{
	    local $^W = 0; # cease "Parsing of undecoded UTF-8 will give garbage when decoding entities" warning
	    $agent->follow_link(text_regex => qr{dieses Formular});
	}
	my_tidy_check($agent);

	$on_a_particular_page->('streetform');
	my $fragezeichenform_url = $agent->uri;
	$fragezeichenform_url =~ s{newstreetform}{fragezeichenform};
	my $shortfragezeichenform_url = $agent->uri;
	$shortfragezeichenform_url =~ s{newstreetform}{shortfragezeichenform};

	#######################
	# newstreetform
	$agent->field("strname", "TEST IGNORE");
	$agent->field("author",  "TEST IGNORE");
    SKIP: {
	    maybe_skip_mail_sending_tests 3;
	    skip("URL is hardcoded and not valid on bbbike.hosteurope.herceg.de", 3)
		if $cgiurl =~ /bbbike.hosteurope.herceg.de/;
	    $agent->submit;
	    my_tidy_check($agent);

	    $like_long_data->(qr{Danke, die Angaben.*gesendet}, "Sent comment");
	    $not_source_code->();
	}

	{
	    local $^W = 0; # cease "Parsing of undecoded UTF-8 will give garbage when decoding entities" warning
	    $agent->get($fragezeichenform_url);
	}
	my_tidy_check($agent);

	#######################
	# fragezeichenform
	$agent->field("strname",  "TEST IGNORE");
	$agent->field("comments", "TEST IGNORE with umlauts ����");
	$agent->field("author",   "TEST IGNORE");
    SKIP: {
	    maybe_skip_mail_sending_tests 3;
	    skip("URL is hardcoded and not valid on bbbike.hosteurope.herceg.de", 3)
		if $cgiurl =~ /bbbike.hosteurope.herceg.de/;
	    $agent->submit;
	    my_tidy_check($agent);

	    $like_long_data->(qr{Danke, die Angaben.*gesendet}, "Sent comment (fragezeichenform)");
	    $not_source_code->();
	}

	{
	    local $^W = 0; # cease "Parsing of undecoded UTF-8 will give garbage when decoding entities" warning
	    $agent->get($shortfragezeichenform_url);
	}
	my_tidy_check($agent);

	#######################
	# shortfragezeichenform
	$agent->field("strname",  "TEST IGNORE");
	$agent->field("comments", "TEST IGNORE with umlauts ����");
	$agent->field("author",   "TEST IGNORE");
    SKIP: {
	    maybe_skip_mail_sending_tests 3;
	    skip("URL is hardcoded and not valid on bbbike.hosteurope.herceg.de", 3)
		if $cgiurl =~ /bbbike.hosteurope.herceg.de/;
	    $agent->submit;
	    my_tidy_check($agent);

	    $like_long_data->(qr{Danke, die Angaben.*gesendet}, "Sent comment (shortfragezeichenform)");
	    $not_source_code->();
	}
    }

    ######################################################################
    # streets in plaetze in Potsdam

    {

	$get_agent->();

	$agent->get($cgiurl);
	$agent->form_name("BBBikeForm");
	{
	    local $^W; $agent->current_form->value('start', 'Schlo� Sanssouci');
	}
	;
	{
	    local $^W; $agent->current_form->value('ziel', 'Potsdam Hauptbahnhof');
	}
	;
	$agent->submit();
	my_tidy_check($agent);
	$known_on_2nd_page->();
	$like_long_data->(qr/scope.*region/i, "Scope is set to region");
	$agent->submit();
	my_tidy_check($agent);
	$on_a_particular_page->('routeresult');
	$like_long_data->(qr/Zur.Historischen.M�hle.*
			     Schopenhauerstr.*
			     Breite.Str.*
			     Lange.Br�cke
			    /xs, 'Route list between Sanssouci and Potsdam Hbf');
    }

    ######################################################################
    # outer Berlin

 SKIP: {
	# Is bbbike2.cgi available?
	my $can_bbbike2_cgi;
	my $bbbike2_url;
	if ($cgiurl =~ /bbbike2\.cgi/) {
	    $bbbike2_url = $cgiurl;
	    $can_bbbike2_cgi = 1;
	} else {
	    ($bbbike2_url = $cgiurl) =~ s{bbbike\.cgi}{bbbike2.cgi};
	    if ($bbbike2_url ne $cgiurl) {
		$get_agent->();
		my $resp = $agent->get($bbbike2_url);
		$can_bbbike2_cgi = $resp->is_success;
	    }
	}
	skip("Outer Berlin feature needs a working bbbike2.cgi", $outer_berlin_tests)
	    if !$can_bbbike2_cgi;

	{
	    $get_agent->();
	    $agent->get($bbbike2_url);
	    my $form = $agent->current_form;
	    $form->value('startort', 'Oranienburg');
	    simulate_abc_click($agent, 'start', 'A');

	    my_tidy_check($agent);
	    $like_long_data->(qr/Am B.*tzower Stadtgraben/, 'Found a place in Oranienburg');
	    $like_long_data->(qr/<a name=.start./, 'Found start anchor');
	    $form = $agent->current_form;
	    $form->value('startname', ''); # "Zur�ck zum Eingabeformular"
	    $agent->submit;

	    my_tidy_check($agent);
	    $on_a_particular_page->('startpage');
	    $form = $agent->current_form;
	    is($form->value('startort'), 'Oranienburg', 'Last ort selection was kept');
	    simulate_abc_click($agent, 'start', 'F');

	    my_tidy_check($agent);
	    $like_long_data->(qr/Falkenstr. \(Sachsenhausen\)/, 'Found a place in Oranienburg')
		or diag <<'EOF';
Make sure that bbbike2.cgi (the beta bbbike URL) is configured with

    $include_outer_region = 1;

in cgi/bbbike2.cgi.config.
EOF
	    $form = $agent->current_form;
	    $form->value('startname', 'Falkenstr. (Sachsenhausen)');
	    $agent->submit;

	    my_tidy_check($agent);
	    $like_long_data->(qr/Falkenstr. \(Oranienburg|Sachsenhausen\)/, 'Marked as start'); # We accept both: Oranienburg (currently), Sachsenhausen (maybe in future)
	    $form = $agent->current_form;
	    $form->value('zielort', 'Birkenwerder');
	    simulate_abc_click($agent, 'ziel', 'A');

	    my_tidy_check($agent);
	    $like_long_data->(qr/Am Quast/, 'Found a place in Birkenwerder');
	    $form = $agent->current_form;
	    $form->value('zielname', 'Am Quast');
	    $agent->submit;

	    my_tidy_check($agent);
	    $on_a_particular_page->('crossing');
	}

	# Test works with bbbike.cgi and bbbike2.cgi
	$get_agent->();
	$agent->get($cgiurl);
	my $form = $agent->current_form;
	$form->value('start', 'kirchsteig');
	$form->value('startort', 'K�nigs Wusterhausen');
	$form->value('via', 'kalkberger');
	$form->value('viaort', 'Sch�neiche bei Berlin');
	$form->value('ziel', 'flora');
	$form->value('zielort', 'Hohen Neuendorf');
	$agent->submit;
	my_tidy_check($agent);
	$known_on_2nd_page->();
	$like_long_data->(qr/scope.*region/i, "Scope is set to region");
	$like_long_data->(qr/Wernsdorf/, "Crossing for start");
	$like_long_data->(qr/Woltersdorfer Str/, "Crossing for via");
	$like_long_data->(qr/Invalidensiedlung/, "Crossing for goal");
	$agent->submit();
	my_tidy_check($agent);
	$on_a_particular_page->('routeresult');
	for my $expected_place (qw(Erkner Woltersdorf Dahlwitz-Hoppegarten)) {
	    $like_long_data->(qr/$expected_place/, "Expected place on route ($expected_place)");
	}

	# Test works with bbbike.cgi and bbbike2.cgi
	{
	    $get_agent->();
	    $agent->get($cgiurl);
	    my $form = $agent->current_form;
	    $form->value('start', 'bahnhofstr');
	    $form->value('startort', 'Erkner');
	    $form->value('ziel', 'bahnhofstr');
	    $form->value('zielort', 'Schwanebeck');
	    $agent->submit;
	    my_tidy_check($agent);
	    $like_long_data->(qr/\QBahnhofstr. (Erkner)/, "Start known");
	    $like_long_data->(qr{\Q<i>bahnhofstr</i> in <i>Schwanebeck</i> ist nicht bekannt}, "Unknown goal");
	}

	{
	    # Test for subplaces like "Mahlow-Waldblick"
	    $get_agent->();
	    $agent->get($bbbike2_url);
	    my $form = $agent->current_form;
	    $form->value('start', 'max-plack-str');
	    $form->value('via', 'Fritz-Reuter-Str.');
	    $form->value('ziel', 'glasower damm');
	    $form->value($_.'ort', 'Mahlow') for qw(start via ziel);
	    $agent->submit;

	    my_tidy_check($agent);
	    $on_a_particular_page->('crossing');

	    $like_long_data->(qr{\QMax-Planck-Str. (Mahlow-Waldblick)}, 'Found start in subplace (Mahlow-Waldblick)');
	    $like_long_data->(qr{\QZiethener Str.}, 'Found a crossing in subplace (Mahlow-Waldblick)');
	    $like_long_data->(qr{\QFritz-Reuter-Str. (Mahlow-Waldblick)}, 'Found via in subplace (Mahlow-Waldblick)');
	    $like_long_data->(qr{\QGlasower Damm (Mahlow)}, 'Found goal in place (Mahlow)');
	}
    }

} # for

sub get_ct {
    my($agent) = @_;
    if ($] < 5.008008) {
	$agent->content;
    } else {
	$agent->response->decoded_content;
    }
}

sub my_tidy_check {
    my($agent) = @_;
    if (!$agent->response->is_success) {
	return fail("No success for URL <" . $agent->uri . ">, status line <" . $agent->response->status_line . ">");
    }
    if ($agent->response->content_type !~ m{html}) {
	diag "WARN: the answer does not look like HTML, but is " . $agent->response->content_type . ". Expect failures!";
    }
    my $uri = $agent->uri;
    if (!$v) {
	$uri =~ s/^.*?\?/...?/;
	my $maxlen = 55;
	$uri = substr($uri, 0, $maxlen) . "..." if length($uri) > $maxlen;
    }

    my $charset;
    require HTTP::Headers::Util;
    my($ct, %ct_param);
    if (my @ct = HTTP::Headers::Util::split_header_words($agent->response->header("Content-Type"))) {
	(undef, undef, %ct_param) = @{$ct[-1]};
	$charset = $ct_param{charset};
    }
    tidy_check(get_ct($agent),
	       "HTML check: $uri",
	       -uri => $agent->uri,
	       -charset => $charset,
	      );
}

sub simulate_abc_click {
    my($agent, $type, $char) = @_;
    my $form = $agent->current_form;
    my $ord = ord($char) - ord("A");
    my $y = int($ord/9)*30 + 15;
    my $x = ($ord%9)*30 + 15;
    $form->value($type . 'charimg.x', $x);
    $form->value($type . 'charimg.y', $y);
    $agent->submit;
}

# Generates three tests, returns $root (or not, if XML::LibXML is not available)
sub handle_xml_response ($) {
    my $resp = shift;
    ok $resp->is_success, "Success for " . $resp->request->url
	or diag $resp->status_line;
    my $xml = $resp->decoded_content(charset => "none"); # using decoded_content with charset decoding is problematic
    xmllint_string($xml, "XML output OK");
    validate_bbbikecgires_xml_string($xml, 'XML validation OK');
    my $root;
    if (eval { require XML::LibXML; 1 }) {
	my $p = XML::LibXML->new;
	my $doc = eval { $p->parse_string($xml) };
	if (!$doc || $@) {
	    my $err = $@;
	    require File::Temp;
	    my($fh,$file) = File::Temp::tempfile(SUFFIX => ".xml");
	    print $fh $xml;
	    close $xml;
	    diag <<EOF;
Failed parsing XML: ${err}XML data written to $file
Following failure is expected.
EOF
	}
	$root = $doc->documentElement;
    }
    $root;
}

__END__
