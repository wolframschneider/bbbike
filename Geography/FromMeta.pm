# -*- perl -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 2009,2019 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: srezic@cpan.org
# WWW:  http://www.bbbike.de
#

package Geography::FromMeta;

use strict;

sub load_meta {
    my($class, $metafile) = @_;
    if (open METAFH, $metafile) {
	local $/ = undef;
	my $metastring = <METAFH>;
	close METAFH;
	$metastring =~ s{^\$meta\s*=\s*}{};
	my $meta = eval $metastring;
	if ($@) {
	    warn "Cannot read meta data from $metafile: $@\nContents:\n$metastring";
	} else {
	    my $self = bless { %$meta }, $class; # XXX or fake class into something using the city/country name?
	    return $self;
	}
    }
    undef;
}

# cityname in native or common language
# XXX Note that osm2bbd currently does not set mapname
sub cityname {
    my $self = shift;
    $self->{mapname};
}

sub center {
    my $self = shift;
    if ($self->{center} || $self->{bbox}) {
	my($cx,$cy);
	if ($self->{center}) {
	    ($cx,$cy) = @{ $self->{center} };
	} else {
	    require Strassen::Util;
	    ($cx,$cy) = Strassen::Util::middle(@{ $self->{bbox} });
	}
	join ",", $cx, $cy;
    } else {
	undef;
    }
}
sub center_wgs84 {
    my $self = shift;
    if ($self->{center_wgs84}) {
	join ",", @{ $self->{center_wgs84} };
    } elsif ($self->{coordsys} eq 'wgs84') {
	join ",", @{ $self->{center} };
    } else {
	require Karte::Polar;
	$Karte::Polar::obj = $Karte::Polar::obj if 0; # cease -w
	$Karte::Polar::obj->standard2map_s($self->center);
    }
}

sub center_name { shift->{center_name} }

sub bbox { shift->{bbox} }
sub bbox_wgs84 { shift->{bbox_wgs84} }
sub skip_features { %{ shift->{skip_features} || {} } }
sub skip_feature {
    my($self, $feature) = @_;
    return if !$self->{skip_features};
    $self->{skip_features}->{$feature};
}    

sub is_osm_source { (shift->{source}||'') eq 'osm' }

sub coord_to_standard {
    my($self, $x, $y) = @_;
    if (($self->{coordsys}||'') eq 'wgs84') {
	require Karte::Polar;
	$Karte::Polar::obj->map2standard($x,$y);
    } else {
	($x, $y);
    }
}

sub coord_to_standard_s {
    my($self, $xy) = @_;
    if (($self->{coordsys}||'') eq 'wgs84') {
	require Karte::Polar;
	join ",", $Karte::Polar::obj->map2standard(split /,/, $xy);
    } else {
	$xy;
    }
}

sub standard_to_coord {
    my($self, $x, $y) = @_;
    if (($self->{coordsys}||'') eq 'wgs84') {
	require Karte::Polar;
	$Karte::Polar::obj->standard2map($x,$y);
    } else {
	($x, $y);
    }
}

sub standard_to_coord_s {
    my($self, $xy) = @_;
    if (($self->{coordsys}||'') eq 'wgs84') {
	require Karte::Polar;
	join ",", $Karte::Polar::obj->standard2map(split /,/, $xy);
    } else {
	$xy;
    }
}

sub _bbox_standard_coordsys {
    my $self = shift;
    my($x1,$y1,$x2,$y2) = @{ $self->bbox };
    ($x1,$y1) = $self->coord_to_standard($x1,$y1);
    ($x2,$y2) = $self->coord_to_standard($x2,$y2);
    [$x1, $y1, $x2, $y2];
}

sub _center_standard_coordsys {
    my $self = shift;
    my $xy = $self->center;
    $self->coord_to_standard_s($xy);
}

# sub datadir {
#     require File::Basename;
#     my $pkg = __PACKAGE__;
#     $pkg =~ s|::|/|g; # XXX other oses?
#     $pkg .= ".pm";
#     if (exists $INC{$pkg}) {
# 	return File::Basename::dirname(File::Basename::dirname($INC{$pkg}))
# 	    . "/data";
#     }
#     undef; # XXX better solution?
# }

1;

__END__
