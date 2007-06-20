# -*- perl -*-

#
# $Id: KML.pm,v 1.1 2007/06/20 21:17:53 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 2007 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://www.rezic.de/eserte/
#

package GPS::KML;

use strict;
use vars qw($VERSION @ISA);
$VERSION = sprintf("%d.%02d", q$Revision: 1.1 $ =~ /(\d+)\.(\d+)/);

require GPS;
push @ISA, 'GPS';

use Strassen::KML;
use Route::Heavy;

sub magics { ('^<\?xml.*<kml') }

sub convert_to_route {
    my($self, $file, %args) = @_;
    my $s = Strassen::KML->new($file);
    my $route = Route->new_from_strassen($s);
    @{ $route->{Path} };
}

sub convert_from_route {
    my($self, $route, %args) = @_;
    my $s = $route->as_strassen;
    my $s_kml = Strassen::KML->new($s);
    $s_kml->bbd2kml;
}

1;

__END__
