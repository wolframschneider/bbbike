# -*- perl -*-

package Bundle::BBBike_small;

$VERSION = sprintf("%d.%02d", q$Revision: 1.3 $ =~ /(\d+)\.(\d+)/);

1;

__END__

=head1 NAME

Bundle::BBBike_small - A bundle to install only mandatory dependencies of BBBike

=head1 SYNOPSIS

 perl -I`pwd` -MCPAN -e 'install Bundle::BBBike_small'

=head1 CONTENTS


Tk 800.000	- das absolute Muss!

Tk::ExecuteCommand	- Bessere Fehlerberichte im temp_blockings-Editor

Algorithm::Diff	- Unterschiede im temp_blockings-Editor anzeigen


=head1 DESCRIPTION

Dieses BE<uuml>ndel listet nur die notwendigen Module
fE<uuml>r BBBike auf.

This bundle lists only mandatory perl modules for BBBike.

=head1 AUTHOR

Slaven Rezic <slaven@rezic.de>

=cut
