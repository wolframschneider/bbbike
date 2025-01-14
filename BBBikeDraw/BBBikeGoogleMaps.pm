# -*- perl -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 2007,2009,2013,2023 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://bbbike.de
#

package BBBikeDraw::BBBikeGoogleMaps;

use strict;
use vars qw($VERSION);
$VERSION = '1.08';

use base qw(BBBikeDraw);

require BBBikeVar;

use vars qw($bbbike_googlemaps_url $maptype);
if (!defined $bbbike_googlemaps_url) {
    # Note that this only works if there's no redirection
    # involved:
    $BBBike::BBBIKE_GOOGLEMAP_URL = $BBBike::BBBIKE_GOOGLEMAP_URL if 0; # cease -w
    $bbbike_googlemaps_url = $BBBike::BBBIKE_GOOGLEMAP_URL;
}

$maptype = "hybrid" unless $maptype;

use CGI qw(:standard);

use Karte;
Karte::preload(qw(Standard Polar));

sub module_handles_all_cgi { 1 }

sub pre_draw {
    my $self = shift;
    $self->{PreDrawCalled}++;
}

# nop, automatically drawn if coordinates exist
sub draw_route { }

# Without the need to POST:
sub flush_direct_redirect {
    my $self = shift;
    my $q = $self->{CGI} || CGI->new;
    my @wpt;
    if ($self->{BBBikeRoute}) {
	for my $wpt (@{ $self->{BBBikeRoute} }) {
	    push @wpt, join "!", $wpt->{Strname}, $wpt->{Coord};
	}
    }
    my @multi_c = @{ $self->{MultiCoords} || [] } ? @{ $self->{MultiCoords} } : @{ $self->{Coords} || [] } ? [ @{ $self->{Coords} } ] : ();
    my $q2 = CGI->new({coords  => [map { join "!", @$_ } @multi_c],
		       maptype => $maptype,
		       coordsystem => $self->guess_coord_system(),
		       (@wpt ? (wpt => \@wpt) : ()),
		       (!@multi_c && !@wpt ? (wpt => join(",", $self->get_map_center)) : ()),
		      });
    print $q->redirect($bbbike_googlemaps_url . "?" . $q2->query_string);
    return;
}

sub mimetype { "text/html" }

sub flush {
    my $self = shift;
    my $q = $self->{CGI} || CGI->new;
    my @multi_c = @{ $self->{MultiCoords} || [] } ? @{ $self->{MultiCoords} } : @{ $self->{Coords} || [] } ? [ @{ $self->{Coords} } ] : ();
    my $oldcoords =
	@{ $self->{OldCoords} || [] }
	    ? join "!", @{ $self->{OldCoords} }
		: undef;
    my @wpt;
    if ($self->{BBBikeRoute}) {
	for my $wpt (@{ $self->{BBBikeRoute} }) {
	    push @wpt, join "!", $wpt->{Strname}, $wpt->{Coord};
	}
    }

    my $fh = $self->{Fh} || \*STDOUT;

    print $fh header(-type => $self->mimetype,
		     -Vary => "User-Agent",
		    );
    print $fh start_html(-onLoad => "init()",
			 -script => <<EOF);
function init() {
    document.forms[0].submit();
}
EOF
    print $fh start_form(-action => $bbbike_googlemaps_url,
			 -method => "GET");
    for my $c (@multi_c) {
	my $coords = join "!", @$c;
	print $fh hidden("coords", $coords);
    }
    if (!@multi_c) {
	print $fh hidden("wpt", join(",", $self->get_map_center));
    }
    print $fh hidden("coordsystem", "polar");    
    print $fh hidden("oldcoords", $oldcoords) if $oldcoords;
    print $fh hidden("maptype", $maptype);
    print $fh hidden("source_script", $q->url(url(-relative=>1)));

    my $city = $q->url(url(-relative=>1));
    $city =~ s/(\.en)?\.cgi$//;

    print $fh hidden("city", $city);
    print $fh hidden("coordsystem", $self->guess_coord_system());
    for my $wpt (@wpt) {
	print $fh hidden("wpt", $wpt);
    }
    print $fh "<noscript>";
    print $fh submit("Weiterleitung auf bbbikegooglemaps");
    print $fh "</noscript>";
    print $fh end_form, end_html;
}

sub get_map_center {
    my($self) = @_;
    my $x = int(($self->{Max_x} - $self->{Min_x})/2 + $self->{Min_x});
    my $y = int(($self->{Max_y} - $self->{Min_y})/2 + $self->{Min_y});
    ($x, $y);
}

sub guess_coord_system {
    my($self) = @_;
    my $coord_system = "bbbike";
    eval {
	my $datadir = $Strassen::datadirs[0];
	my $meta_yml = $datadir . "/meta.yml";
	if ($datadir && -r $meta_yml) {
	    require BBBikeYAML;
	    my $d = BBBikeYAML::LoadFile($meta_yml);
	    if ($d->{coordsys}) {
		$coord_system = $d->{coordsys};
	    }
	}
    };
    warn "Problem loading meta.yml: $@" if $@;
    $coord_system;
}

1;

__END__
