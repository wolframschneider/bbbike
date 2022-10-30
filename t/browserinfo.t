#!/usr/bin/perl -w
# -*- perl -*-

#
# Copyright (C) 2005,2012,2013,2014,2017,2018,2022 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Author: Slaven Rezic
#

use strict;

use FindBin;
use lib ($FindBin::RealBin,
	 "$FindBin::RealBin/../lib",
	);

use File::Temp qw(tempdir);
use Getopt::Long;

use BrowserInfo;

BEGIN {
    if (!eval q{
	use Test::More;
	1;
    }) {
	print "1..0 # skip no Test::More module\n";
	exit;
    }
}

BEGIN { plan tests => 91 }

GetOptions()
    or die "usage: $0\n";

{
    local $ENV{HTTP_USER_AGENT} = "Nokia6630/1.0";
    my $bi = BrowserInfo->new;
    my($w,$h) = @{ $bi->{display_size} };
    is($w, 164, "Nokia6630 width");
    is($h, 144, "Nokia6630 height");
    ok($bi->{can_table}, "Nokia6630 can tables");
}

{
    local $ENV{HTTP_USER_AGENT} = "UnknownDevice/1.0";
    my $bi = BrowserInfo->new;
    is("@{ $bi->{display_size} }", "750 590", "Fallback for unknown device");
}

{
    local $ENV{HTTP_USER_AGENT} = "UnknownDevice/1.0 (with something)";
    my @warnings;
    local $SIG{__WARN__} = sub { push @warnings, @_ };
    my $bi = BrowserInfo->new;
    is "@warnings", "", 'No warnings';
}

{
    local $ENV{HTTP_USER_AGENT} = undef;
    my @warnings;
    local $SIG{__WARN__} = sub { push @warnings, @_ };
    my $bi = BrowserInfo->new;
    is "@warnings", "", 'No warnings for empty user agent';
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (iPad; CPU OS 5_1_1 like Mac OS X) AppleWebKit/534.46 (KHTML, like Gecko) Version/5.1 Mobile/9B206 Safari/7534.48.3";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Safari';
    is $bi->{user_agent_os}, 'iOS';
    # is $bi->{mobile_device}, 1 oder 0? # Was mache ich zur Zeit mit dem Wert? -> es wird z.B. auf m.bbbike.de geschaltet
    ok $bi->{can_table};
    ok $bi->{can_dhtml};
    ok $bi->{can_css};
    ok $bi->{can_javascript};
    ok !$bi->{text_browser};
    ok !$bi->{gecko_version}, "It's not a gecko, it's just like gecko";
    ok $bi->is_browser_version('Safari', 5.0, 6.0);
    ok $bi->is_browser_version('Safari', 5.0);
    ok $bi->is_browser_version('Safari');
    ok !$bi->is_browser_version('SomethingElse');
    ok !$bi->is_browser_version('SomethingElse', 1);
    ok !$bi->is_browser_version('SomethingElse', 2, 3);
    ok !$bi->is_browser_version('Safari', 6.0, 7.0);
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Linux; U; Android 4.0.3; de-de; GT-P5110 Build/IML74K) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Safari/534.30";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Safari';
    is $bi->{user_agent_version}, '4.0';
    is $bi->{user_agent_os}, 'Android';
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (iPhone; CPU iPhone OS 12_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0 Mobile/15E148 Safari/604.1";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Safari';
    is $bi->{user_agent_version}, '12.0';
    ok $bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; de-de) AppleWebKit/312.9 (KHTML, like Gecko) Safari/312.6";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Safari';
    is $bi->{user_agent_version}, '1.3';
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; de-de) AppleWebKit/419 (KHTML, like Gecko) Safari/419.3";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Safari';
    is $bi->{user_agent_version}, '2.0';
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'MSIE', 'MSIE 11 detection (name)';
    is $bi->{user_agent_version}, '11.0', 'MSIE 11 detection (version)';
    is $bi->{user_agent_os}, 'Windows NT 6.3', 'MSIE 11 detection (os)';
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/35.0.1916.153 Safari/537.36";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Chrome', 'Chrome detection (name)';
    is $bi->{user_agent_version}, '35.0', 'Chrome detection (version)';
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Chrome', 'Chrome detection (name) (googlebot)';
    is $bi->{user_agent_version}, '41.0', 'Chrome detection (version) (googlebot)';
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (iPod touch; CPU iPhone OS 7_0_6 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) Mobile/11B651";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'AppleWebKit', 'AppleWebKit detection (name)';
    is $bi->{user_agent_version}, '537.51', 'AppleWebKit detection (version)';
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'MSIE', 'MSIE 11 detection (name)';
    is $bi->{user_agent_version}, '11.0', 'MSIE 11 detection (version)';
    ok $bi->{can_dhtml};
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Windows NT 6.1; Win64; x64; Trident/7.0; rv:11.0) like Gecko";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'MSIE', 'MSIE 11 detection (name) (variation: another bit before Trident/...)';
    is $bi->{user_agent_version}, '11.0', 'MSIE 11 detection (version)';
    ok $bi->{can_dhtml};
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; Touch; rv:11.0) like Gecko";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'MSIE', 'MSIE 11 detection (name) (variation: another bit between Trident/... and rv:...)';
    is $bi->{user_agent_version}, '11.0', 'MSIE 11 detection (version)';
    ok $bi->{can_dhtml};
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Edge', 'Edge detection (name)';
    is $bi->{user_agent_version}, '17.17134', 'Edge detection (version)';
    ok $bi->{can_dhtml};
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 OPR/57.0.3098.106";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Opera', 'Opera detection (name)';
    is $bi->{user_agent_version}, '57.0', 'Opera detection (version)';
    ok $bi->{can_dhtml};
    ok $bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Opera/9.80 (Windows NT 5.1; U; de) Presto/2.8.131 Version/11.11";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Opera', 'Opera detection (name)';
    is $bi->{user_agent_version}, '11.11', 'Opera detection (version) (Version at end)';
    ok $bi->{can_dhtml};
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Opera/9.0 (Windows NT 5.1; U; en)";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Opera', 'Opera detection (name)';
    is $bi->{user_agent_version}, '9.0', 'Opera detection (version)';
    ok $bi->{can_dhtml};
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Linux; U; Android 4.0.1; de-de; Galaxy Nexus Build/ITL41F) AppleWebKit/535.7 (KHTML, like Gecko) CrMo/16.0.912.77 Mobile Safari/535.7";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Chrome', 'Chrome detection (name) (CrMo)';
    is $bi->{user_agent_version}, '16.0', 'Chrome detection (version)';
    ok $bi->{can_dhtml};
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Linux; U; Android 4.0.3; de-de; GT-P7510 Build/IML74K) AppleWebKit/535.7 (KHTML, like Gecko) CrMo/16.0.912.77  Safari/535.7";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Chrome', 'Chrome detection (name) (CrMo, another one)';
    is $bi->{user_agent_version}, '16.0', 'Chrome detection (version)';
    ok $bi->{can_dhtml};
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:63.0) Gecko/20100101 Firefox/63.0";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Firefox', 'Firefox detection (name) (new one)';
    is $bi->{user_agent_version}, '63.0', 'Firefox detection (version)';
    ok $bi->{can_dhtml};
    ok $bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Mozilla/5.0 (Windows; U; Windows NT 5.1; pt-PT; rv:1.9.1.2) Gecko/20090729 Firefox/3.5.2 (.NET CLR 3.5.30729)";
    my $bi = BrowserInfo->new;
    is $bi->{user_agent_name}, 'Firefox', 'Firefox detection (name) (old one)';
    is $bi->{user_agent_version}, '3.5', 'Firefox detection (version)';
    ok $bi->{can_dhtml};
    ok !$bi->{'geolocation.secure_context_required'};
}

{
    local $ENV{HTTP_USER_AGENT} = "Bad search_robot .*google.*  (compatible; )";
    my @warnings; local $SIG{__WARN__} = sub { push @warnings, @_ };
    my $bi = BrowserInfo->new;
    is "@warnings", "";
}

__END__
