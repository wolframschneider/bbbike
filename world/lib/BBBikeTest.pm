#!/usr/local/bin/perl
#
# Copyright (c) 2012-2015 Wolfram Schneider, http://bbbike.org
#
# BBBikeTest.pm - helper function for ./world/t
#
# my $test = BBBikeTest->new('size' => 5_000);
# $test->myget("http://localhost/foobar.html")
# $test->myget_401("http://localhost/auth.html")
# $test->myget_500("http://localhost/cgi/fail.cgi")
# $test->myget_head("http://localhost/cgi/true.cgi")
#

package BBBikeTest;

use Test::More;
use LWP;
use LWP::UserAgent;

use strict;
use warnings;

binmode \*STDOUT, "utf8";
binmode \*STDERR, "utf8";

sub new {
    my $class = shift;
    my %args  = @_;

    my $self = { %args };

    bless $self, $class;
    
    $self->init;
    
    return $self;
}

sub init {
    my $self = shift;
    
    my $ua = LWP::UserAgent->new;
    $ua->agent("BBBike.org-Test/1.1");
    
    $self->{'ua'} = $ua;
}



# standard GET request
sub myget {
    my $self = shift;
    my $url  = shift;
    my $size = shift || $self->{'size'};

    $size = 10_000 if !defined $size;

    my $req = HTTP::Request->new( GET => $url );
    my $res = $self->{'ua'}->request($req);

    isnt( $res->is_success, undef, "$url is success" );
    is( $res->status_line, "200 OK", "status code 200" );

    my $content = $res->decoded_content();
    cmp_ok( length($content), ">", $size, "greather than $size for URL $url" );

    return $res;
}

# a HEAD request
sub myget_head {
    my $self = shift;
    my $url  = shift;
    my $size = shift;

    #$size = 1 if !defined $size;

    my $req = HTTP::Request->new( HEAD => $url );
    my $res = $self->{'ua'}->request($req);

    isnt( $res->is_success, undef, "$url is success" );
    is( $res->status_line, "200 OK", "status code 200" );

    my $content_length = $res->content_length;

    if (defined $size && $size) {
        cmp_ok( $content_length, ">", $size, "greather than $size, $url" );
    } else {
        is( $content_length, $size, "HEAD size check" );
    }

    return $res;
}

# GET request with HTTP 401 result
sub myget_401 {
    my $self = shift;
    my $url  = shift;
    my $size = shift || $self->{'size'};

    $size = 300 if !defined $size;

    my $req = HTTP::Request->new( GET => $url );
    my $res = $self->{'ua'}->request($req);

    isnt( $res->is_success, undef, "$url is success" );
    is(
        $res->status_line,
        "401 Unauthorized",
        "status code 401 Unauthorized - great!"
    );

    my $content = $res->decoded_content();
    cmp_ok( length($content), ">", $size, "greather than $size for URL $url" );

    return $res;
}

# GET request with HTTP 500 result
sub myget_500 {
    my $self = shift;
    my $url  = shift;
    my $size = shift || $self->{'size'};

    $size = 200 if !defined $size;

    my $req = HTTP::Request->new( GET => $url );
    my $res = $self->{'ua'}->request($req);

    isnt( $res->is_success, undef, "$url is success" );
    is( $res->status_line, "500 Internal Server Error", "status code 500" );

    my $content = $res->decoded_content();
    cmp_ok( length($content), ">", $size, "greather than $size for URL $url" );

    return $res;
}



use constant MYGET => 3;
sub myget_counter { return MYGET; }
sub myget_head_counter { return MYGET; }
sub myget_401_counter { return MYGET; }
sub myget_500_counter { return MYGET; }

1;

__DATA__;
