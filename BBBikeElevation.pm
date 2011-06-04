# Author: Slaven Rezic, Wolfram Schneider
#
# Copyright (C) 1998-2011 Slaven Rezic. All rights reserved.
# This is free software; you can redistribute it and/or modify it under the
# terms of the GNU General Public License, see the file COPYING.
#
# Mail: slaven@rezic.de
# WWW:  http://bbbike.sourceforge.net
#

package BBBikeElevation;

use FindBin;
use lib (
    grep { -d } (
        "$FindBin::RealBin/..",
        "$FindBin::RealBin/../lib",

        # f<FC>r Radzeit:
        "$FindBin::RealBin/../BBBike",
        "$FindBin::RealBin/../BBBike/lib",
    )
);

use Encode;
use strict;

#use warnings;

our %hoehe = ();
our $steigung_net;
our $bp_obj;
our $net;

sub new { bless {}, shift }

######################################################################
#

my %active_speed_power;
my %steigung_penalty_env;
my $steigung_penalty;
my %extra_args;

$active_speed_power{"Type"}  = 'speed';
$active_speed_power{"Index"} = 0;

my $temperature = 20;
my @speed       = 20;

my $verbose = 1;
my @power = ( 50, 100 );

# read elevation data, set global var %hoehe
sub read_hoehe {
    my %args = @_;

    my $elevation_database = "hoehe";

    if (
        !eval {
            my $h = new Strassen($elevation_database);
            %hoehe = %{ $h->get_hashref };
            1;
        }
      )
    {
        warn $@;
        %hoehe = ();
    }
}

# Return active speed in km/h.
### AutoLoad Sub
sub get_active_speed {
    my $speed;
    if ( $active_speed_power{Type} eq 'power' ) {
        $speed = power2speed( $power[ $active_speed_power{Index} ] );
    }
    else {
        $speed = $speed[ $active_speed_power{Index} ];
    }
    if ( !$speed ) {
        $speed = 20;    # f<FC>r alle F<E4>lle
    }
    $speed;
}

# Berechnet f<FC>r die Watt-Zahl die entsprechende Geschwindigkeit
### AutoLoad Sub
sub power2speed {
    my ( $power, %args ) = @_;
    return if !$bp_obj;
    my $new_bp_obj = clone BikePower $bp_obj;
    $new_bp_obj->given('P');
    $new_bp_obj->headwind(0);
    my $grade = $args{-grade} || 0;
    $new_bp_obj->grade($grade);
    $new_bp_obj->power($power);
    $new_bp_obj->calc;
    $new_bp_obj->velocity * 3.6;
}

# Berechnet f<FC>r die angegebene Geschwindigkeit die Watt-Zahl
### AutoLoad Sub
sub speed2power {
    my ( $speed, %args ) = @_;
    return if !$bp_obj;
    my $new_bp_obj = clone BikePower $bp_obj;
    $new_bp_obj->given('v');
    $new_bp_obj->headwind(0);
    my $grade = $args{-grade} || 0;
    $new_bp_obj->grade($grade);
    $new_bp_obj->velocity( $speed / 3.6 );
    $new_bp_obj->calc;
    $new_bp_obj->power;
}

# Always use Bikepower (e.g. mandatory for Steigungsoptimierung)
my $bikepwr = 1;
if ($bikepwr) {
    eval { require BikePower; };
    if ($@) {
        status_message( Mfmt( "Kann BikePower nicht laden: %s", $@ ), 'err' );
        $bikepwr = 0;
    }
    else {
        if ( $verbose && $BikePower::has_xs ) {
            print STDERR "Verwende die XS version von BikePower\n";
        }
        $bp_obj = new BikePower;
        $bp_obj->given('P');
        $bp_obj->temperature($temperature);

        set_corresponding_power();
    }
}

# create elevation network
# set global var $steigung_net
sub elevation_net {

    if ( !$steigung_net ) {
        $steigung_net = new StrassenNetz Strassen->new;
        $steigung_net->make_net_steigung( $net, \%hoehe );
    }
    my $penalty;
    my $act_power;
    if ( $active_speed_power{Type} eq 'power' ) {
        $act_power = $power[ $active_speed_power{Index} ];
    }
    else {
        $act_power = speed2power( $speed[ $active_speed_power{Index} ] );
    }
    if ( !defined $steigung_penalty_env{ActPower}
        || $steigung_penalty_env{ActPower} != $act_power )
    {
        $steigung_penalty = {};
    }
    $steigung_penalty_env{ActPower} = $act_power;
    $extra_args{Steigung}           = {
        Net        => $steigung_net,
        Penalty    => $steigung_penalty,
        PenaltySub => sub { steigung_penalty( $_[0], $act_power ) },
    };
}

sub set_corresponding_power {
    @power = ();
    for ( my $i = 0 ; $i <= $#speed ; $i++ ) {
        my $bp_speed = new BikePower;
        $bp_speed->given('v');
        $bp_speed->velocity( $speed[$i] / 3.6 );
        $bp_speed->calc;
        push @power, int( $bp_speed->power );
    }
    if ( !@power ) {
        @power = ( 50, 100 );
    }
}

1;

