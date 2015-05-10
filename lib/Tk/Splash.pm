# -*- perl -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 1999,2003,2005,2014 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: srezic@cpan.org
# WWW:  http://www.rezic.de/eserte/
#

package Tk::Splash;
use Tk;
use strict;
use vars qw($VERSION @ISA);

$VERSION = 0.08;

@ISA = qw(Tk::Widget);

sub Show {
    my($pkg,
       $image_file, $image_width, $image_height, $title, $override) = @_;
    $title = $0 if !defined $title;
    my $splash_screen = {};
    $splash_screen = new MainWindow;
    $splash_screen->title($title);
    if ($override) {
	$splash_screen->overrideredirect(1);
    }
    my $splashphoto = $splash_screen->{Photo} = $splash_screen->Photo(-file => $image_file);
    my $sw = $splash_screen->screenwidth;
    my $sh = $splash_screen->screenheight;
    $image_width  = $splashphoto->width unless defined $image_width;
    $splash_screen->{ImageWidth} = $image_width;
    $image_height = $splashphoto->height unless defined $image_height;
    $splash_screen->geometry("+" . int($sw/2 - $image_width/2) .
			     "+" . int($sh/2 - $image_height/2));
    my $l = $splash_screen->Label(-image => $splashphoto, -bd => 0)->pack
      (-fill => 'both', -expand => 1);
    $splash_screen->update;
    $splash_screen->{"Exists"} = 1;
    bless $splash_screen, $pkg;
}

sub Raise {
    my $w = shift;
    if ($w->{"Exists"}) {
	Tk::catch(sub { Tk::raise($w) });
    }
}

sub Destroy {
    my $w = shift;
    if ($w->{Photo}) {
	$w->{Photo}->delete;
	undef $w->{Photo};
    }
    if ($w->{"Exists"}) {
	Tk::catch(sub { Tk::destroy($w) });
    }
}

1;

=head1 NAME

Tk::Splash - create a splash screen

=head1 SYNOPSIS

    BEGIN {
        require Tk::Splash;
        $splash = Tk::Splash->Show($image, $width, $height, $title,
                                   $overrideredirect);
    }
    ...
    use Tk;
    ...
    $splash->Destroy;
    MainLoop;

=head1 DESCRIPTION

This module is another way to create a splash screen. It is slower
than L<Tk::FastSplash>, but tries to be compatible by using standard
Tk methods for creation.

The splash screen is created with the B<Show> function. Supplied
arguments are: filename of the displayed image, width and height of
the image and the string for the title bar. I<$width> and I<$height>
may be left undefined. If I<$overrideredirect> is set to a true value,
then the splash screen will come without window manager decoration. If
something goes wrong, then B<Show> will silently ignore all errors and
continue without a splash screen. The splash screen can be destroyed
with the B<Destroy> method, best short before calling B<MainLoop>.

I<$image> should be one of the core Perl/Tk image types (gif, ppm,
bmp). For jpegs and pngs, a C<use Tk::JPEG> or C<use Tk::PNG> prior to
the call of the C<Show> method would be necessary.

=head1 NOTES

Since displaying the splash screen is done during compile time (if put
in a C<BEGIN> block, like the SYNOPSIS example shows), the splash
screen will also occur if the script is started using perl's C<-c>
(check) switch.

=head1 AUTHOR

Slaven Rezic <srezic@cpan.org>

=head1 SEE ALSO

L<Tk::FastSplash>, L<Win32::GUI::SplashScreen>.

=cut

__END__
