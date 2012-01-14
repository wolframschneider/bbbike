#!/usr/local/bin/perl 
# Copyright (c) 2009-2012 Wolfram Schneider, http://bbbike.org
#
# test if all perl modules are installed
#
# sudo /opt/local/bin/cpan HTML::TagCloud

use Text::Unidecode;
use HTML::TagCloud;
use XML::Atom::SimpleFeed;
use URI;
use JSON;
use XML::Simple;
use XML::LibXML::Reader;
use Tie::IxHash;
use YAML::Syck;
use YAML;
use Perl::Tidy;
use BSD::Resource;

# not used yet
#use GPS::Point;
#use Geo::Inverse;

# extract.cgi
#use GIS::Distance::Lite;
#use use Email::Valid;

1;

