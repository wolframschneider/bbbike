#!/usr/local/bin/perl
# Copyright (c) Sep 2012-2015 Wolfram Schneider, http://bbbike.org

use Test::More;
use Data::Dumper;
use CGI;
use JSON;
use Clone qw(clone);

use lib qw(world/lib);
use Extract::Config;

use strict;
use warnings;

my $debug = 1;

our $option;

my $test_option = {
    'debug'                     => 2,
    'homepage'                  => 'http://download3.bbbike.org/osm/extract/',
    'max_extracts'              => 50,
    'default_format'            => 'osm.pbf',
    'city_name_optional_coords' => 1,
    'max_skm'                 => 24_000_000,    # max. area in square km
    'max_size'                => 768_001,       # max area in KB size
    'email_allow_nobody'      => 2,
    'enable_google_analytics' => 1,
    'scheduler'               => {
        'user_limit' => 25,
        'ip_limit'   => 50
    },
};

my $test_option2 = {
    'debug'           => 2,
    'homepage'        => 'http://download4.bbbike.org/osm/extract/',
    'script_homepage' => 'http://extract.bbbike.org',
    'max_extracts'    => 5,
};

#################################################################################
# successfull load of config file ~/.bbbike-extract.rc
#
sub config_success {
    my ( $q, $conf ) = @_;

    diag( Dumper($conf) ) if $debug >= 2;

    $option = clone($conf);
    my $config = Extract::Config->new( 'q' => $q, 'option' => $option );
    isnt( $option, undef, "option" );

    my $email_allow_nobody = $option->{'email_allow_nobody'};
    my $homepage           = $option->{'homepage'};
    my $script_homepage    = $option->{'script_homepage'};
    my $pro                = $option->{'pro'};

    $config->load_config('.bbbike-extract.rc');
    isnt( $option, undef, "option" );
    is( $Extract::Config::spool->{'confirmed'}, "confirmed",
        "spool confirmed" );

    isnt(
        $email_allow_nobody,
        $option->{'email_allow_nobody'},
        "email_allow_nobody changed"
    );
    isnt( $homepage, $option->{'homepage'}, "homepage changed" );
    isnt( $homepage, "", "homepage not empty" );
    is( $option->{'pro'}, 0, "pro changed" );

    diag( Dumper($option) ) if $debug >= 2;
    return 7;
}

#################################################################################
# failed load of config file ~/.bbbike-extract.rc
#
sub config_failed {
    my ( $q, $conf ) = @_;

    diag( Dumper($conf) ) if $debug >= 2;
    $option = clone($conf);

    my $homepage = $option->{'homepage'};
    my $config = Extract::Config->new( 'q' => $q, 'option' => $option );
    $config->load_config();    #'/bbbike-extract.rc');
    is( $homepage, $option->{'homepage'},
        "homepage not changed for default config" );

    $config = Extract::Config->new( 'q' => $q, 'option' => $option );
    $config->load_config('/bbbike-extract.rc');
    is( $homepage, $option->{'homepage'},
        "homepage not changed for non-exist config" );

    diag( Dumper($option) ) if $debug >= 2;
    return 2;
}

#################################################################################
# successfull load of config file ~/.bbbike-extract-pro.rc
# Extract Pro Version
#

sub config_success_pro {
    my ( $q, $conf ) = @_;

    diag( Dumper($conf) ) if $debug >= 2;
    $option = clone($conf);

    my $spool_dir       = $option->{'spool_dir'};
    my $pro             = $option->{'pro'};
    my $script_homepage = $option->{'script_homepage'};
    my $planet_osm      = $option->{'planet_osm'};

    my $config = Extract::Config->new( 'q' => $q, 'option' => $option );
    $config->load_config('.bbbike-extract-pro.rc');
    isnt( $option, undef, "option" );

    isnt( $planet_osm, $option->{'planet_osm'}, "planet_osm changed" );
    isnt(
        $script_homepage,
        $option->{'script_homepage'},
        "script_homepage changed"
    );
    isnt( $script_homepage, "", "script_homepage not empty" );

    is( $spool_dir, undef, "spool_dir not empty" );
    isnt( $option->{'spool_dir'},
        $spool_dir, "spool_dir changed to $option->{'spool_dir'}" );
    is( $option->{'pro'}, 1, "pro changed" );

    diag( Dumper($option) ) if $debug >= 2;
    return 7;
}

my $counter = 0;
my $q       = new CGI;
$counter += &config_success( $q, $test_option );
$counter += &config_success_pro( $q, $test_option );
$counter += &config_failed( $q, $test_option );
$counter += &config_failed( $q, $test_option );

plan tests => $counter;

#diag(Dumper($option));
#diag (Dumper(\%INC));

__END__
