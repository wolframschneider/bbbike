#!/usr/bin/perl
# -*- perl -*-

# Author: Slaven Rezic

use Test::More;
use FindBin;
use lib ( "$FindBin::RealBin/..", "$FindBin::RealBin/../lib" );
use Strassen::Core;
use Time::HiRes qw( gettimeofday tv_interval );

use strict;
use warnings;

my @search_types = ( "agrep", "String::Approx", "perl" );

my @streets = (
    [ "Dudenstr",               ["Dudenstr. (10965)"] ],
    [ "garibaldistr",           ["Garibaldistr. (13158)"] ],
    [ "Garibaldi",              ["Garibaldistr. (13158)"] ],
    [ "Really does not exist!", [] ],
);

plan tests => scalar(@streets) * 3;

my $strassen = "data-osm/Berlin/strassen";
my $s_utf8   = Strassen->new($strassen);

# agrep or perl
# String::Approx or perl

for my $search_def (@search_types) {
    local $Strassen::OLD_AGREP;
    my %args;

    if ( $search_def eq 'agrep' ) {

        # OK
    }
    else {
        $Strassen::OLD_AGREP = 1;
        if ( $search_def eq 'String::Approx' ) {

            # OK
        }
        else {
            %args = ( NoStringApprox => 1 );
        }
    }

    for my $encoding_def ( [ $s_utf8, 'utf-8' ] ) {
        my ( $s, $encoding ) = @$encoding_def;

        my $check = sub {
            my ( $supply, $expected ) = @_;
            local $Test::Builder::Level = $Test::Builder::Level + 1;
            is_deeply( [ $s->agrep( $supply, %args ) ],
                $expected, "Search for '$supply' ($search_def, $encoding)" );
        };

        foreach my $test (@streets) {
            $check->(@$test);
        }
    }
}

__END__
