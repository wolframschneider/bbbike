#!/usr/local/bin/perl
# Copyright (c) 2009-2012 Wolfram Schneider, http://bbbike.org
#
# BBBikeWorldDB.pm - module to parse bbbike @ world city database

package BBBikeWorldDB;

use IO::File;
use Data::Dumper;
use strict;
use warnings;

our $VERSION = 0.1;

our $debug = 1;

sub new {
    my ( $class, %args ) = @_;

    my $self = {
        'database'   => 'world/etc/cities.csv',
        'debug'      => $debug,
        'lang'       => 'en',
        'local_lang' => '',
        'area'       => 'de',
        'step'       => '0.02',
        '_city'      => {},
        %args,
    };

    bless $self, $class;
    $self->parse_database;

    print Dumper($self) if $self->{'debug'} >= 2;
    return $self;
}

#
## City : Real Name : pref. language : local language : area : coord : population : step?
#Berlin:::::13.0109 52.3376 13.7613 52.6753:4500000:
#CambridgeMa:Cambridge (Massachusetts):en::other:-71.1986 42.3265 -71.0036 42.4285:1264990:
#

sub parse_database {
    my $self = shift;

    my $db = $self->{'database'};
    my $fh = new IO::File $db, "r" or die "open: $db $!\n";
    binmode $fh, ":utf8";

    my %hash;
    my %raw;
    while (<$fh>) {
        chomp;
        s/^\s+//;
        next if /^#/ || $_ eq "";

        my (
            $city,       $name, $lang,
            $local_lang, $area, $coord,
            $population, $step, $other_names
        ) = split(/:/);

        next if $city eq '';
        my $dummy = $city eq 'dummy' || $step eq 'dummy' ? 1 : 0;

        $hash{$city} = {
            city        => $city,
            name        => $name,
            lang        => $lang || "en",
            local_lang  => $local_lang || "",
            step        => $step || "0.02",
            area        => $area || "de",
            coord       => $coord,
            population  => $population || 1,
            other_names => $other_names || "",
            dummy       => $dummy,
        };

        $raw{$city} = [
            $city,       $name, $lang,
            $local_lang, $area, $coord,
            $population, $step, $other_names
        ];
    }
    close $fh;

    $self->{'_city'} = \%hash;
    $self->{'_raw'}  = \%raw;

    return $self->city;
}

sub city  { return shift->{'_city'}; }
sub raw   { return shift->{'_raw'}; }
sub debug { return shift->{'debug'}; }

sub list_cities {
    my $self = shift;

    if ( $self->city ) {
        my @list;
        foreach my $c ( keys %{ $self->city } ) {
            push( @list, $c ) if !$self->city->{$c}->{"dummy"};
        }

        @list = sort @list;
        warn join ", ", @list if $debug >= 2;

        return @list;
    }
    else {
        return;
    }
}

# select city name by language
sub select_city_name {
    my $self = shift;

    my $city      = shift;
    my $name      = shift or die "No city name given!\n";
    my $city_lang = shift || "en";

    warn "city: $city, name: $name, lang: $city_lang\n" if $self->debug >= 2;

    my %hash;
    $hash{ALL} = $city;
    foreach my $n ( split /\s*,\s*/, $name ) {
        my ( $lang, $city_name ) = split( /!/, $n );
        if ($city_name) {
            $hash{$lang} = $city_name;
        }

        # no city language defined, use default
        else {
            $hash{ALL} = $lang;
        }
    }

    #use Data::Dumper; warn Dumper( \%hash );
    return exists( $hash{$city_lang} ) ? $hash{$city_lang} : $hash{ALL};
}

