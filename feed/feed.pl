#!/usr/bin/perl

use XML::Atom::SimpleFeed;

my $homepage = $ENV{'BBBIKE_HOMEPAGE'} || 'http://www.bbbike.org';

my $feed = XML::Atom::SimpleFeed->new(
    title => 'BBBike @ World - a Cycle Route Planner',
    link  =>  $homepage,
    link  => {
        rel  => 'self',
        href => $homepage . '/feed/bbbike-world.xml',
    },
    icon     => $homepage . '/images/srtbike.ico',
    updated  => '2010-03-13T18:30:02Z',
    author   => 'Wolfram Schneider',
    subtitle =>
'BBBike is a route planner for cyclists in Berlin. It is now ported to other cities around the world - thanks to the OpenStreetMap project!',
    id => 'urn:uuid:60a76c80-d399-11d9-b93C-0003939e0af6',
);

$feed->add_entry(
    title => 'New cities for BBBike @ world',
    link  =>  $homepage,
    id    => '81ebeaf0506f9d6a518be2ab38ec243f',

    content => {
        type => 'text',
        content => qq{BBBike @ world supports now 125 cities world wide.}
    },

    updated  => '2010-03-13T18:30:02Z',
    category => 'News',
);

$feed->add_entry(
    title => 'Updated BBBike @ Berlin packages for MacOS',
    link  =>  'http://bbbike.sourceforge.net/downloads.en.html',
    id    => '81ebeaf0506f9d6a518be2ab38ec243f',

    content => {
        type => 'text',
        content => qq{The BBBike @ Berlin package for MacOS are updated. See http://bbbike.sourceforge.net/downloads.en.html}
    },

    updated  => '2010-03-13T18:30:02Z',
    category => 'News',
);

$feed->print;

