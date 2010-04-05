#!/usr/bin/perl

use MyCgiSimple;

# use warnings make the script 20% slower!
#use warnings;

use strict;

$ENV{LANG} = 'C';

# how many streets to suggestest
my $max_suggestions = 64;

# for the input less than 4 characters
my $max_suggestions_short = 10;

my $opensearch_file = 'opensearch.streetnames';
my $opensearch_dir  = '../data-osm';
my $opensearch_dir2 = '../data-opensearch-places';

my $debug         = 1;
my $match_anyware = 0;
my $match_words   = 1;

# word matching for utf8 data
my $force_utf8 = 0;

# look(1) is faster than egrep, override use_egrep option
my $use_look = 1;

# performance tuning, egrep may be faster than perl regex
my $use_egrep = 1;

sub ascii2unicode {
    my $string = shift;

    my ( $ascii, $unicode, @rest ) = split( /\t/, $string );

    warn "ascii2unicode: $unicode\n" if $debug >= 2;
    return $unicode ? $unicode : $ascii;
}

sub street_match {
    my $file   = shift;
    my $street = shift;
    my $limit  = shift;

    if ( !-e $file ) {
        warn "$!: $file\n";
        return;
    }

    if ($use_look) {
        my $look_opt = '-f';

        # linux only
        $look_opt .= 'b' if -e '/proc';

        my @command = ( 'look', $look_opt, $street, $file );

        warn join( " ", @command ), "\n" if $debug >= 2;
        open( IN, '-|' ) || exec @command;
    }

    elsif ($use_egrep) {
        my @command = ( 'egrep', '-s', '-m', '2000', '-i', $street, $file );

        warn join( " ", @command ), "\n" if $debug >= 2;
        open( IN, '-|' ) || exec @command;
    }
    else {
        if ( !open( IN, $file ) ) { warn "$!: $file\n"; return; }
    }

    # to slow
    binmode( \*IN, ":utf8" ) if $force_utf8;

    my @data;
    my @data2;
    my $len = length($street);

    my $s        = lc($street);
    my $s_length = length($s);

    while (<IN>) {
        chomp;
        my $line = lc($_);

        # match from beginning
        if ( $s eq substr( $line, 0, $s_length ) ) {
            warn "Prefix streetname match: $street\n" if $debug >= 2;
            push( @data, &ascii2unicode($_) );
        }

        elsif ( $match_words && /\b$street/i ) {
            warn "Word streetname match: $street\n" if $debug >= 2;
            push( @data, &ascii2unicode($_) );
        }

        # or for long words anyware, second class matches
        elsif ( $match_anyware && $len >= 2 && /$s/ ) {
            warn "Anywhere streetname match: $street\n" if $debug >= 2;
            push( @data2, &ascii2unicode($_) ) if scalar(@data2) <= $limit * 90;
        }

        last if scalar(@data) >= $limit * 50;
    }

    close IN;

    warn "data: ", join( " ", @data ), " data2: ", join( " ", @data2 ), "\n"
      if $debug >= 2;
    return ( \@data, \@data2 );
}

sub streetnames_suggestions_unique {
    my @list = &streetnames_suggestions(@_);

    # return unique list
    my %hash = map { $_ => 1 } @list;
    @list = keys %hash;

    return @list;
}

sub streetnames_suggestions {
    my %args   = @_;
    my $city   = $args{'city'};
    my $street = $args{'street'};
    my $limit  = (length($street) <= 3 ? $max_suggestions_short : $max_suggestions);

    $street =~ s/([()|{}\]\[])/\\$1/;

    my $file =
      $city eq 'bbbike'
      ? "../data/$opensearch_file"
      : "$opensearch_dir/$city/$opensearch_file";

    if ( !-f $file && -f "$opensearch_dir2/$city/$opensearch_file" ) {
        $file = "$opensearch_dir2/$city/$opensearch_file";
    }

    my ( $d, $d2 ) = &street_match( $file, $street, $limit );

    # no prefix match, try again with prefix match only
    if ( defined $d && scalar(@$d) == 0 && scalar(@$d2) == 0 ) {
        ( $d, $d2 ) = &street_match( $file, "^$street", $limit );
    }

    my @data  = defined $d  ? @$d  : ();
    my @data2 = defined $d2 ? @$d2 : ();

    warn "Len1: ", scalar(@data), " ", join( " ", @data ), "\n" if $debug >= 2;
    warn "Len2: ", scalar(@data2), " ", join( " ", @data2 ), "\n"
      if $debug >= 2;

    # less results
    if ( scalar(@data) + scalar(@data2) < $limit ) {
        return ( @data, @data2 );
    }

    # trim results, exact matches first
    else {

        # match words
        my @d;
        @d = grep { /$street\b/i || /\b$street/ } @data2;    # if $len >= 3;

        my @result = &strip_list( $limit, @data );
        push @result,
          &strip_list(
            $limit / ( scalar(@data) ? 2 : 1 ),
            ( scalar(@d) ? @d : @data2 )
          );
        return @result;
    }
}

sub strip_list {
    my $limit = shift;
    my @list  = @_;

    $limit = int($limit);

    my @d;
    my $step = int( scalar(@list) / $limit + 0.5 );
    $step = 1 if $step < 1;

    warn "step: $step, list: ", scalar(@list), "\n" if $debug >= 2;
    for ( my $i = 0 ; $i <= $#list ; $i++ ) {
        if ( ( $i % $step ) == 0 ) {
            warn "i: $i, step: $step\n" if $debug >= 2;
            push( @d, $list[$i] );
        }
    }
    return @d;
}

# GET /w/api.php?action=opensearch&search=berlin&namespace=0 HTTP/1.1

my $q = new MyCgiSimple;

#use CGI; my $q = new CGI;

my $action    = 'opensearch';
my $street    = $q->param('search') || $q->param('query') || $q->param('q') || 'Zähringe';
my $city      = $q->param('city') || 'Berlin';
my $namespace = $q->param('namespace') || '0';

if (   defined $q->param('debug')
    && $q->param('debug') >= 0
    && $q->param('debug') <= 3 )
{
    $debug = $q->param('debug');
}

binmode( \*STDERR, ":utf8" ) if $debug >= 1;

my $expire = $debug >= 2 ? '+1s' : '+1h';
print $q->header(
    -type    => 'text/javascript',
    -charset => 'utf-8',
    -expires => $expire,
);

binmode( \*STDOUT, ":utf8" ) if $force_utf8;

my @suggestion =
  sort &streetnames_suggestions_unique( 'city' => $city, 'street' => $street );

# plain text
if ( $namespace eq 'plain' || $namespace == 1 ) {
    print join( "\n", @suggestion ), "\n";
}

# devbridge autocomplete
elsif ( $namespace eq 'dbac' ) {
    print qq/{ query:'$street', suggestions:[/;
    print '"', join( '","', @suggestion ), '"' if scalar(@suggestion) > 0;
    print "] }";
}

# googe like
else {
    print qq/["$street",[/;
    print qq{"}, join( '","', @suggestion ), qq{"} if scalar(@suggestion) > 0;
    print qq,]],;
}

