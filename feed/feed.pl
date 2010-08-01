#!/usr/bin/perl

use XML::Atom::SimpleFeed;

my $homepage = $ENV{'BBBIKE_HOMEPAGE'} || 'http://www.bbbike.org';

my $feed = XML::Atom::SimpleFeed->new(
    title   => 'BBBike @ World - a Cycle Route Planner',
    link    => $homepage,
    link    => { rel => 'self', href => $homepage . '/feed/bbbike-world.xml' },
    icon    => $homepage . '/images/srtbike.ico',
    updated => '2010-03-03T18:30:02Z',
    author  => 'Wolfram Schneider',
    subtitle =>
'BBBike is a route planner for cyclists in Berlin. It is now ported to other cities around the world - thanks to the OpenStreetMap project!',
    id => 'urn:uuid:60a76c80-d399-11d9-b93C-0003939e0af6',
);

######################################################################

$feed->add_entry(
    title => 'Redesign of BBBike',
    id    => '9bcb8fcbc414515b4ad98ca3d1dac9f4',

    content => {
        type    => 'text',
        content => qq{Redesign of BBBike @ world search page.},
    },

    updated  => '2010-07-31T18:30:02Z',
    category => 'News',
);


$feed->add_entry(
    title => 'More cities supported: Bamberg',
    id    => '5906fa459866ba81323e4b5ba6411588',

    content => {
        type    => 'text',
        content => qq{Added new cities: Bamberg},
    },

    updated  => '2010-07-23T18:30:02Z',
    category => 'News',
);

$feed->add_entry(
    title => 'More cities supported',
    id    => '74ce830fecbcbe6fe07c3f61df1f5176',

    content => {
        type    => 'text',
        content => qq{Added new cities: Victoria},
    },

    updated  => '2010-06-15T18:30:02Z',
    category => 'News',
);

$feed->add_entry(
    title => 'Elevation chart',
    link  => $homepage,
    id    => '81ebeaf0506f9d6a518be2ab38ec243f',

    content => {
        type => 'text',
        content =>
          qq{BBBike @ World displays the elevation chart for the route.}
    },

    updated  => '2010-04-11T18:30:03Z',
    category => 'News',
);

$feed->add_entry(
    title => 'More cities supported',
    id    => '82ebeaf0506f9d6a518be2ab38ec242d',

    content => {
        type => 'text',
        content =>
qq{Added new cities: Nuernberg, Muenchen, Kiel, Oldenburg, Genf, Warschau, Magdeburg, Posen, Breslau, Kattowitz, and Gleiwitz.},
    },

    updated  => '2010-03-12T18:30:02Z',
    category => 'News',
);

$feed->add_entry(
    title => 'New design for BBBike @ world search',
    link  => $homepage,
    id    => '3954a6fca12368526e8c790e38bcb743',

    content => {
        type    => 'text',
        content => qq{New design for BBBike @ world search}
    },

    updated  => '2010-03-06T18:30:02Z',
    category => 'News',
);

$feed->add_entry(
    title => 'New cities for BBBike @ world',
    link  => $homepage,
    id    => '81ebeaf0506f9d6a518be2ab38ec243f',

    content => {
        type    => 'text',
        content => qq{BBBike @ World supports now 125 cities world wide.}
    },

    updated  => '2010-03-06T18:30:03Z',
    category => 'News',
);

$feed->add_entry(
    title => 'Updated BBBike @ Berlin packages for MacOS',
    link  => 'http://bbbike.sourceforge.net/downloads.en.html',
    id    => '81ebeaf0506f9d6a518be2ab38ec243e',

    content => {
        type    => 'text',
        content => qq{The BBBike @ Berlin package for MacOS are updated.}
    },

    updated  => '2010-03-06T18:30:04Z',
    category => 'News',
);

$feed->add_entry(
    title => 'OpenSearch search plugins',
    id    => '81ebeaf0506f9d6a518be2ab38ec243d',

    content => {
        type => 'text',
        content =>
          qq{Added support for OpenSearch search plugins for all cities.},
    },

    updated  => '2010-03-05T18:30:02Z',
    category => 'News',
);

$feed->add_entry(
    title => 'Slippymap supports cycle map',
    id    => '81ebeaf0506f9d6a518be2ab38ec242d',

    content => {
        type    => 'text',
        content => qq{Added support for cycle map layer.},
    },

    updated  => '2010-01-03T18:30:02Z',
    category => 'News',
);

$feed->print;

