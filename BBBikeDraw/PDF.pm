# -*- perl -*-

#
# $Id: PDF.pm,v 2.43 2006/10/28 12:04:54 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 2001,2004 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: eserte@users.sourceforge.net
# WWW:  http://bbbike.sourceforge.net
#

package BBBikeDraw::PDF;
use strict;
use base qw(BBBikeDraw);
use PDF::Create;
BEGIN {
    my $needed_version = "0.06";
    if (!eval { PDF::Create->VERSION($needed_version) }) {
	die <<EOF;
You have PDF::Create $PDF::Create::VERSION installed, but at least version
$needed_version is necessary to run @{[ __PACKAGE__ ]}. Unfortunately this module
version is NOT available from CPAN, but only from SourceForge from the
URL http://sourceforge.net/projects/perl-pdf/ or use the direct download link
http://prdownloads.sourceforge.net/perl-pdf/perl-pdf-0.06.1b.tar.gz?download

EOF
    }
}
use PDF::Create::MyPage; # additional methods
use Strassen;
# Strassen benutzt FindBin benutzt Carp, also brauchen wir hier nicht zu
# sparen:
use Carp qw(confess);

use vars qw($VERSION @colors %color %width %outline_color
	    $sansserif $symbolfont $VERBOSE);
BEGIN { @colors =
         qw($grey_bg $white $yellow $red $green $middlegreen $darkgreen
	    $darkblue $lightblue $rose $black $darkgrey $lightgreen);
}
use vars @colors;

$VERSION = sprintf("%d.%02d", q$Revision: 2.43 $ =~ /(\d+)\.(\d+)/);

sub init {
    my $self = shift;

    if ($self->{Compress}) {
	require BBBikeUtil;
	if (BBBikeUtil::is_in_path("pdftk")) {
	    require File::Temp;
	    my($fh,$filename) = File::Temp::tempfile(SUFFIX => ".pdf", UNLINK => 1);
	    die "Cannot create temporary file: $!" if !$filename;
	    $self->{_CompressOriginalFilename} = $self->{Filename};
	    $self->{_CompressTemporaryFilename} = $filename;
	    $self->{Filename} = $filename;
	} else {
	    warn "No pdftk in PATH available, don't compress...";
	    undef $self->{Compress};
	}
    }

    my $pdf = PDF::Create->new
	((defined $self->{Filename} ?
	  ('filename' => $self->{Filename}) :
	  ('fh' => $self->{Fh})
	 ),
	 'Author' => 'Slaven Rezic',
	 'Title' => 'BBBike Route',
	 'Creator' => __PACKAGE__ . " version $BBBikeDraw::PDF::VERSION",
	 'CreationDate' => [ localtime ],
	 'Keywords' => 'Routenplaner Fahrrad',
	 #'PageMode' => 'UseOutlines',
	);
    my $page_bbox = $pdf->get_page_size("a4");
    my $rotate;
    my $geometry = $self->{Geometry} || '';
    if ($geometry eq 'auto') {
	$self->dimension_from_route if !defined $self->{Max_y}; # XXX clean enough?
	my $route_height = ($self->{Max_y}-$self->{Min_y});
	$route_height = 20 if (!$route_height); # avoid division by 0
	if (($page_bbox->[2]-$page_bbox->[0])/($page_bbox->[3]-$page_bbox->[1]) <
	    ($self->{Max_x}-$self->{Min_x})/$route_height) {
	    $geometry = "landscape";
	} else {
	    $geometry = "portrait";
	}
    }
    if ($geometry eq 'landscape') {
	@$page_bbox[2,3] = @$page_bbox[3,2];
	#XXX jeht nicht:	$rotate = 90; # oder -90
    }

    my $page = $pdf->new_page('MediaBox' => $page_bbox,
			      (defined $rotate ? ('Rotate' => $rotate) : ()),
			     );
    $pdf->new_outline('Title' => 'Karte',
		      'Destination' => $page);

    $self->{PDF}      = $pdf;
    $self->{PageBBox} = $page_bbox;
    $self->{Image}    = $page; # named "Image" for GD compatibility
    $self->{Width}    = $page_bbox->[2]-$page_bbox->[0];
    $self->{Height}   = $page_bbox->[3]-$page_bbox->[1];

    if (!defined $self->{Outline}) {
	$self->{Outline} = 1;
    }

    $self->allocate_colors_and_fonts;
    $self->set_category_colors;
    $self->set_category_outline_colors;
    $self->set_category_widths;

    # grey background
    $page->rectangle(@$page_bbox);
    $page->set_fill_color(@$grey_bg);
    $page->fill;

    $self->set_draw_elements;

    $self;
}

sub allocate_colors_and_fonts {
    my $self = shift;
    $self->allocate_colors;
    $self->allocate_fonts;
}

sub allocate_colors {
    my $self = shift;
    my $im = $self->{Image};

    $self->{'Bg'} = '' if !defined $self->{'Bg'};
    if ($self->{'Bg'} eq '' || $self->{'Bg'} =~ /^white/) {
	# Hintergrund wei�: Nebenstra�en werden grau,
	# Hauptstra�en dunkelgelb gezeichnet
	$grey_bg   = [0.9,0.9,0.9];
	$white     = [1,1,1];
    } elsif ($self->{'Bg'} =~ /^\#([a-f0-9]{2})([a-f0-9]{2})([a-f0-9]{2})/i) {
	$grey_bg   = [hex($1)/255, hex($2)/255, hex($3)/255];
    } else {
	$grey_bg   = [0.6,0.6,0.6];
    }

    $white       = [1,1,1] if !defined $white;
    $yellow      = [1,1,0] if !defined $yellow;
    $red         = [1,0,0];
    $green       = [0,1,0];
    $darkgreen   = [0,0.5,0];
    $darkblue    = [0,0,0.5];
    $lightblue   = [0.73,0.84,0.97];
    $middlegreen = [0,0.78,0];
    $lightgreen  = [200/256,1,200/256];
    $rose        = [map { $_/256} 215, 184, 200];
    $black       = [0,0,0];
}

sub allocate_fonts {
    my $self = shift;
    my $im = $self->{Image};

    $sansserif = $self->{PDF}->font('Subtype'  => 'Type1',
				    'Encoding' => 'WinAnsiEncoding',
				    'BaseFont' => 'Helvetica'
				   );
    $symbolfont = $self->{PDF}->font('Subtype'  => 'Type1',
				     'Encoding' => 'Symbol',
				     'BaseFont' => 'Symbol'
				   );
}


sub draw_map {
    my $self = shift;
    my $im        = $self->{Image};
    my $transpose = $self->{Transpose};

    $self->_get_nets;
    $self->{FlaechenPass} = 1;

    my @netz = @{ $self->{_Net} };
    my @outline_netz = @{ $self->{_OutlineNet} };
    my @netz_name = @{ $self->{_NetName} };
    my %str_draw = %{ $self->{_StrDraw} };
    my %p_draw = %{ $self->{_PDraw} };
    my $title_draw = $self->{_TitleDraw};

    my $bbox = $self->{PageBBox};

    my $restrict;
    if ($self->{Restrict}) {
	$restrict = { map { ($_ => 1) } @{ $self->{Restrict} } };
    }

    if ($self->{Outline}) {
	foreach my $strecke (@outline_netz) {
	    $strecke->init;
	    while(1) {
		my $s = $strecke->next;
		last if !@{$s->[1]};
		my $cat = $s->[2];
		next if $restrict && !$restrict->{$cat};

		my($ss, $bbox) = transpose_all($s->[1], $transpose);
		next if (!bbox_in_region($bbox, $self->{PageBBox}));

		$im->set_line_width(($width{$cat}||1)*1+2);
		$im->set_stroke_color(@{ $outline_color{$cat} || [0,0,0] });

		$im->moveto(@{ $ss->[0] });
		for my $xy (@{$ss}[1 .. $#$ss]) {
		    $im->lineto(@$xy);
		}
		$im->stroke;
	    }
	}
    }

    foreach my $strecke_i (0 .. $#netz) {
	my $strecke = $netz[$strecke_i];
	my $strecke_name = $netz_name[$strecke_i];
	my $flaechen_pass = $self->{FlaechenPass};
	for my $s ($self->get_street_records_in_bbox($strecke)) {
	    my $cat = $s->[Strassen::CAT];

	    my($ss, $bbox) = transpose_all($s->[Strassen::COORDS], $transpose);
	    next if (!bbox_in_region($bbox, $self->{PageBBox}));
	    next if ($cat =~ $BBBikeDraw::bahn_bau_rx); # Ausnahmen: in Bau

	    # move to first point
	    $im->moveto(@{ $ss->[0] });

	    if ($cat =~ /^F:(.*)/) {
		my $cat = $1;
		next if ($strecke_name eq 'flaechen' &&
			 (($flaechen_pass == 1 && $cat eq 'Pabove') ||
			  ($flaechen_pass == 2 && $cat ne 'Pabove'))
			);
		$im->set_line_width(1);
		$im->set_stroke_color(@{ $color{$cat} || [0,0,0] });
		$im->set_fill_color  (@{ $color{$cat} || [0,0,0] });
		for my $xy (@{$ss}[1 .. $#$ss]) {
		    $im->lineto(@$xy);
		}
		$im->fill;
	    } else {
		next if $restrict && !$restrict->{$cat};
		$im->set_line_width(($width{$cat} || 1) * 1);
		$im->set_stroke_color(@{ $color{$cat} || [0,0,0] });
		for my $xy (@{$ss}[1 .. $#$ss]) {
		    $im->lineto(@$xy);
		}
		$im->stroke;
	    }
	}
	if ($strecke_name eq 'flaechen') {
	    $self->{FlaechenPass}++;
	}
    }

    # $self->{Xk} bezeichnet den Vergr��erungsfaktor
    # bis etwa 0.02 ist es zu un�bersichtlich, Ampeln zu zeichnen,
    # ab etwa 0.05 kann man die mittelgro�e Variante nehmen
if(1||$self->{Width} < $self->{Height}){#XXX scheint sonst undefinierbare Probleme mit Acrobat Reader zu machen (nur beim Querformat/Landscape?)
    if ($p_draw{'ampel'} && $self->{Xk} >= 0.02) {
	my $lsa = new Strassen "ampeln";
	my $images_dir = $self->get_images_dir;
	my $suf = ($self->{Xk} >= 0.05 ? '' : '2');

	my($kl_ampel);
	my($kl_andreas);
	my($kl_zugbruecke);

	eval {
	    my $file;
	    $file = get_8bit_gif("$images_dir/ampel_klein$suf.gif");
	    $kl_ampel = $self->{PDF}->image($file);
	    $file = get_8bit_gif("$images_dir/andreaskr_klein$suf.gif");
	    $kl_andreas = $self->{PDF}->image($file);
	    $file = get_8bit_gif("$images_dir/zugbruecke_klein.gif");
	    $kl_zugbruecke = $self->{PDF}->image($file);
	}; warn $@ if $@;
	if ($kl_andreas && $kl_ampel) {
	    $lsa->init;
	    while(1) {
		my $s = $lsa->next_obj;
		last if $s->is_empty;
		my $cat = $s->category;
		my($x, $y) = &$transpose(@{$s->coord_as_list(0)});
		if ($x < $bbox->[0] || $x > $bbox->[2] ||
		    $y < $bbox->[1] || $y > $bbox->[3]) {
		    next;
		}
		my $image;
		if ($cat =~ m{^(B|B0)$}) {
		    $image = $kl_andreas;
		} elsif ($cat =~ m{^(X|F)$}) {
		    $image = $kl_ampel;
		} elsif ($cat =~ m{^Zbr$}) {
		    $image = $kl_zugbruecke;
		}
		if ($image) {
		    $im->image(image => $image, xpos => $x, ypos => $y,
			       xalign => 1, yalign => 1);
		}
	    }
	}
    }
}

# XXXX hier wird $small_display und $xw/$yw nicht beachtet!
    my($xw, $yw);
    my $small_display = 0;
    if ($self->{Width} < 200 ||	$self->{Height} < 150) {
	($xw, $yw) = (1, 1);
	$small_display = 1;
    } else {
	my($xw1, $yw1) = &$transpose(0, 0);
	my($xw2, $yw2) = &$transpose(60, 60);
#	($xw, $yw) = ($xw2-$xw1, $yw2-$yw1);
	($xw, $yw) = (5, 5);
    }

# XXX verschiedene Zeichensatzgr��en f�r die Orte
#      my $min_ort_category = ($self->{Xk} < 0.005 ? 4
#  			    : ($self->{Xk} < 0.01 ? 3
#  			       : ($self->{Xk} < 0.02 ? 2
#  				  : ($self->{Xk} < 0.03 ? 1 : 0))));
#      my %ort_font = (0 => &GD::Font::Tiny,
#  		    1 => &GD::Font::Small,
#  		    2 => &GD::Font::Small,
#  		    3 => &GD::Font::Large, # MediumBold sieht fetter aus
#  		    4 => &GD::Font::Large,
#  		    5 => &GD::Font::Giant,
#  		    6 => &GD::Font::Giant,
#  		   );
    foreach my $def (['ubahn', 'ubahnhof', 'u'],
		     ['sbahn', 'sbahnhof', 's'],
#  			['ort', 'orte',       'o'],
		    ) {
	my($lines, $points, $type) = @$def;
  	if ($str_draw{$lines}) {
  	    my $p = ($lines eq 'ort'
  		     ? $self->_get_orte
  		     : new Strassen $points);

	    my $images_dir = $self->get_images_dir;
	    my $image;
	    my $suffix;
	    if ($self->{Xk} < 0.05) {
		$suffix = "_mini";
	    } elsif ($self->{Xk} < 0.2) {
		$suffix = "_klein";
	    } else {
		$suffix = "";
	    }

	    eval {
		if ($points eq 'ubahnhof') {
		    my $file = get_8bit_gif("$images_dir/ubahn$suffix.gif");
		    $image = $self->{PDF}->image($file);
		} elsif ($points eq 'sbahnhof') {
		    my $file = get_8bit_gif("$images_dir/sbahn$suffix.gif");
		    $image = $self->{PDF}->image($file);
		}
	    };
	    warn $@ if $@;

  	    $p->init;
  	    while(1) {
  		my $s = $p->next_obj;
  		last if $s->is_empty;
  		my $cat = $s->category;
  		next if $cat =~ $BBBikeDraw::bahn_bau_rx;
  		my($x0,$y0) = @{$s->coord_as_list(0)};
  		# Bereichscheck (XXX ist nicht ganz korrekt wenn der Screen breiter ist als die Route)
#  		next if (!(($x0 >= $self->{Min_x} and $x0 <= $self->{Max_x})
#  			   and
#  			   ($y0 >= $self->{Min_y} and $y0 <= $self->{Max_y})));
		if ($image) {
		    my($x1, $y1) = &$transpose($x0, $y0);
		    $im->image(image => $image, xpos => $x1, ypos => $y1,
			       xalign => 1, yalign => 1);
		} elsif ($type eq 'u' || ($type eq 's' && $small_display)) {
  		    my($x1,$x2,$y1,$y2);
#    		    if (!$small_display) {
#    			($x1, $y1) = &$transpose($x0-30, $y0-30);
#    			($x2, $y2) = &$transpose($x0+30, $y0+30);
#    		    } else {
  			($x1, $y1) = &$transpose($x0, $y0);
#    			($x2, $y1) = ($x1+$xw, $y2+$yw);
#    			($x1, $y2) = ($x1-$xw, $y2-$yw);
#    		    }
  		    # XXX Farbe bei small_display && s-bahn
		    $im->set_fill_color(@$darkblue);
  		    $im->rectangle($x1-2, $y1-2, 5, 5);
		    $im->fill;
		} elsif ($type eq 's') {
		    # XXX ausgef�llten Kreis zeichnen
		    my($x, $y) = &$transpose(@{$s->coord_as_list(0)});
		    $im->set_fill_color(@$darkgreen);
		    $im->circle($x, $y, 4);
		    $im->fill;
		}
#  		} else {
#  		    if ($cat >= $min_ort_category) {
#  			my($x, $y) = &$transpose(@{$s->coord_as_list(0)});
#  			my $ort = $s->name;
#  			# Anh�ngsel l�schen (z.B. "b. Berlin")
#  			$ort =~ s/\|.*$//;
#  			$im->arc($x, $y, 3, 3, 0, 360, $black);
#  			outline_text($im, $ort_font{$cat} || &GD::Font::Small,
#  				     $x+4, $y,
#  				     patch_string($ort), $white, $darkblue);
#  		    }
#  		}
  	    }
  	}
    }

#XXX no angle/rotate support with PDF::Create
#      if (ref $self->{StrLabel}) {
#  	my $fontsize = 10;

#  	my $draw_sub = sub {
#  	    my($x,$y) = &$transpose($_[0], $_[1]);
#  	    if (defined $_[4] and defined $_[5]) {
#  		$x -= $_[4];
#  		$y -= $_[5];
#  	    }
#  	    $im->$ft_method($black, $ttf, $fontsize, -$_[3], $x, $y, $_[2]);
#  	    };
#  	    my $extent_sub = sub {
#  		my(@b) = GD::Image->$ft_method($black, $ttf, $fontsize, -$_[3],
#  					       &$transpose($_[0], $_[1]),
#  					       $_[2]);
#  		($b[2]-$b[0], $b[3]-$b[1]);
#  	    };

#  	    my $strecke = $multistr;
#  	    $strecke->init;
#  	    while(1) {
#  		my $s = $strecke->next;
#  		last if !@{$s->[1]};
#  		my $cat = $s->[2];
#  		next unless $cat eq 'HH' || $cat eq 'H';

#  		my($x1, $y1, $xe, $ye) = (@{Strassen::to_koord1($s->[1][0])},
#  					  @{Strassen::to_koord1($s->[1][-1])});
#  		next if (!(($x1 >= $self->{Min_x} and $xe <= $self->{Max_x}) and
#  			   ($y1 >= $self->{Min_y} and $ye <= $self->{Max_y})));
#  		my $str = Strassen::strip_bezirk($s->[0]);
#  		my $coordref = [ map { (split(/,/, $_)) } @{ $s->[1] } ];
#  		Tk::RotFont::rot_text_smart($str, $coordref,
#  					    -drawsub   => $draw_sub,
#  					    -extentsub => $extent_sub,
#  					    -transpose => $transpose,
#  					   );
#  	    }
#  	};
#  	warn $@ if $@;
#      }

    $self->{TitleDraw} = $title_draw;

    $self->draw_scale unless $self->{NoScale};
}

# This function forces the gif to have a LZW minimum code
# size of 8, because PDF::Create does not support other
# sizes. This is done by extending the palette to 256
# colors. The image is cached in /tmp. There is a last
# fallback to .jpg (which are ugly and have no
# transparency).
sub get_8bit_gif {
    my($file) = @_;
    eval {
	require File::Basename;
	require GD;
	my $file_8bit = "/tmp/bbbikedraw_" . $< . "_pdf_8bit_" . File::Basename::basename($file);
	if (-r $file_8bit) {
	    $file = $file_8bit;
	} else {
	    my $img = GD::Image->newFromGif($file)
		or die "Can't read $file as image: $!";
	    for my $i ($img->colorsTotal .. 256) {
		$img->colorAllocate(0,0,0);
	    }
	    open(OFH, ">$file_8bit")
		or die "Can't write to $file_8bit: $!";
	    binmode OFH;
	    print OFH $img->gif
		or die $!;
	    close OFH
		or die $!;
	    $file = $file_8bit;
	}
    };
    if ($@) {
	warn $@;
	$file =~ s{\.gif$}{.jpg};
    }
    $file;
}

# Zeichnen des Ma�stabs
sub draw_scale {
    my $self = shift;
    my $im        = $self->{Image};
    my $transpose = $self->{Transpose};

    my $x_margin = 10;
    my $y_margin = 10;
    my $color = $black;
    my $bar_width = 4;
    my($x0,$y0) = $transpose->(0,0);
    my($x1,$y1, $strecke, $strecke_label);
    for $strecke (10, 50, 100, 500, 1000, 5000, 10000, 20000, 50000, 100000) {
	($x1,$y1) = $transpose->($strecke,0);
	if ($x1-$x0 > 50) {
	    if ($strecke >= 1000) {
		$strecke_label = $strecke/1000 . "km";
	    } else {
		$strecke_label = $strecke . "m";
	    }
	    last;
	}
    }

    $im->set_stroke_color(@$color);
    $im->set_line_width(1);

    $im->set_fill_color(@$white);
    $im->rectangle($self->{Width}-($x1-$x0)-$x_margin,
		   $y_margin,
		   ($x1-$x0)/2,
		   $bar_width);
    $im->fill;

    $im->set_fill_color(@$color);
    $im->rectangle($self->{Width}-($x1-$x0)/2-$x_margin,
		   $y_margin,
		   ($x1-$x0)/2,
		   $bar_width);
    $im->fill;

    $im->line($self->{Width}-($x1-$x0)-$x_margin,
	      $y_margin,
	      $self->{Width}-$x_margin,
	      $y_margin);

    $im->line($self->{Width}-($x1-$x0)-$x_margin,
	      $y_margin+$bar_width,
	      $self->{Width}-$x_margin,
	      $y_margin+$bar_width);

    $im->line($self->{Width}-($x1-$x0)/2-$x_margin,
	      $y_margin,
	      $self->{Width}-($x1-$x0)/2-$x_margin,
	      $y_margin+$bar_width);
    $im->line($self->{Width}-($x1-$x0)-$x_margin,
	      $y_margin-2,
	      $self->{Width}-($x1-$x0)-$x_margin,
	      $y_margin+$bar_width+2);
    $im->line($self->{Width}-$x_margin,
	      $y_margin-2,
	      $self->{Width}-$x_margin,
	      $y_margin+$bar_width+2);

    $im->string($sansserif, 10,
		$self->{Width}-($x1-$x0)-$x_margin-3,
		$y_margin+$bar_width+4,
		"0");
    $im->string($sansserif, 10,
		$self->{Width}-$x_margin+8-6*length($strecke_label),
		$y_margin+$bar_width+4,
		$strecke_label);
}

sub draw_route {
    my $self = shift;

    $self->pre_draw if !$self->{PreDrawCalled};

    my $im        = $self->{Image};
    my $transpose = $self->{Transpose};
    my(@c1)       = @{ $self->{C1} };
    my $strnet; # StrassenNetz-Objekt

    foreach (@{$self->{Draw}}) {
	if ($_ eq 'strname' && $self->{'MakeNet'}) {
	    $strnet = $self->{MakeNet}->('lite');
	}
    }

##XXX gestrichelte Route
#      my $brush; # should be *outside* the next block!!!
#      my $line_style;
#      if ($self->{RouteWidth}) {
#  	# fette Routen f�r die WAP-Ausgabe (B/W)
#  	$brush = GD::Image->new($self->{RouteWidth}, $self->{RouteWidth});
#  	$brush->colorAllocate($im->rgb($black));
#  	$im->setBrush($brush);
#  	$line_style = GD::gdBrushed();
#      } elsif ($brush{Route}) {
#  	$im->setBrush($brush{Route});
#  	$line_style = GD::gdBrushed();
#      } else {
#  	# Vorschlag von Rainer Scheunemann: die Route in blau zu zeichnen,
#  	# damit Rot-Gr�n-Blinde sie auch erkennen k�nnen. Vielleicht noch
#  	# besser: rot-gr�n-gestrichelt
#  	$im->setStyle($darkblue, $darkblue, $darkblue, $red, $red, $red);
#  	$line_style = GD::gdStyled();
#      }

    $im->set_stroke_color(@$red);
    $im->set_line_width(4);

    # Route
    if (@c1) {
	$im->moveto(map { sprintf "%.2f", $_ } $transpose->(@{ $c1[0] }));
	for(my $i = 1; $i <= $#c1; $i++) {
	    $im->lineto(map { sprintf "%.2f", $_ } $transpose->(@{ $c1[$i] }));
	}
	$im->stroke;
    }

    # Flags
    if (@c1 > 1) {
$self->{UseFlags} = 0; # XXX don't use this because of missing transparency information in .jpg
	if ($self->{UseFlags}) {
	    my $images_dir = $self->get_images_dir;
	    my $start_flag = $self->{PDF}->image("$images_dir/flag2_bl.jpg");
	    if ($start_flag) {
		my($x, $y) = &$transpose(@{ $c1[0] });
		$im->image(image => $start_flag, xpos => $x-5, ypos => $y-15,
			   xalign => 1, yalign => 1);
	    }
	    my $end_flag = $self->{PDF}->image("$images_dir/flag_ziel.jpg");
	    if ($end_flag) {
		my($x, $y) = &$transpose(@{ $c1[-1] });
		$im->image(image => $end_flag, xpos => $x-5, ypos => $y-15,
			   xalign => 1, yalign => 1);
	    }
	}
    }

    # Ausgabe der Stra�ennnamen
    if ($strnet) {
	$im->set_stroke_color(@$black);
	$im->set_line_width(1);
	my(@strnames) = $strnet->route_to_name
	    ([ map { [split ','] } @{ $self->{Coords} } ]);
	my $size = (@strnames >= 30 ? 7 :
		    @strnames >= 20 ? 8 :
		    @strnames >= 15 ? 9 :
		    10
		   );
	my $pad = 2;
	my $sm = eval { require Geo::SpaceManager; Geo::SpaceManager->new($self->{PageBBox}) };
	#warn $@ if $@;
	foreach my $e (@strnames) {
	    my $name = Strassen::strip_bezirk($e->[0]);
	    my $f_i  = $e->[4][0];
	    my($x,$y) = &$transpose(split ',', $self->{Coords}[$f_i]);
	    my $s_width = $im->my_string_width($sansserif, $name) * $size;
	    if ($sm) {
		my($x1,$y1,$x2,$y2) = ($x-$pad, $y-$pad, $x+$s_width+$pad, $y+$size);
		my $r1 = $sm->nearest([$x1,$y1,$x2,$y2]);
		if (!defined $r1) {
		    warn "No space left for [$x1,$y1,$x2,$y2]";
		} else {
		    $sm->add($r1);
		    $x = $r1->[0]+$pad;
		    $y = $r1->[1]+$pad;
		}
	    }
	    $im->set_fill_color(@$white);
	    $im->rectangle($x-$pad, $y-$pad, $s_width+$pad*2, $size+$pad);
	    $im->fill;
	    $im->rectangle($x-$pad, $y-$pad, $s_width+$pad*2, $size+$pad);
	    $im->stroke;
	    $im->set_fill_color(@$black);
	    $im->string($sansserif, $size, $x, $y, $name);
	}
    }

    if ($self->{TitleDraw}) {
	my $start = $self->{Startname};
	my $ziel  = $self->{Zielname};
	foreach my $s (\$start, \$ziel) {
	    # Text in Klammern entfernen, damit der Titel k�rzer wird
	    my(@s) = split(m|/|, $$s);
	    foreach (@s) {
		s/\s+\(.*\)$//;
	    }
	    $$s = join("/", @s);
	}
	my @s = ("$start ",
		 chr(174), # left arrow
		 " $ziel"
		);

	my $size = 20;
	my @s_width = ($im->my_string_width($sansserif, $s[0]) * $size,
		       20, # no width mapping for Symbol font: $im->my_string_width($symbolfont, $s[1]) * $size,
		       $im->my_string_width($sansserif, $s[2]) * $size,
		      );
	my $s_width = $s_width[0] + $s_width[1] + $s_width[2];

	my $y_top = $self->{PageBBox}[3];
	$y_top -= 37;

	$im->set_stroke_color(@$black);
	$im->set_fill_color(@$white);
	$im->set_line_width(1);
	$im->rectangle(15, $y_top, $s_width+5+5, $size+7);
	$im->fill;
	$im->rectangle(15, $y_top, $s_width+5+5, $size+7);
	$im->stroke;

	$im->set_stroke_color(@$black);
	$im->set_fill_color(@$black);
	my $x = 20;
	my $y = $y_top + 5;
	$im->string($sansserif, $size, $x, $y, $s[0]);
	$x += $s_width[0];
	$im->string($symbolfont, $size, $x, $y, $s[1]);
	$x += $s_width[1];
	$im->string($sansserif, $size, $x, $y, $s[2]);
    }

}

# Draw this first, otherwise the filling of the circle won't work!
sub draw_wind {
    return; # not yet XXXX
    my $self = shift;
    return unless $self->{Wind};
    require BBBikeCalc;
    BBBikeCalc::init_wind();
    my $richtung = lc($self->{Wind}{Windrichtung});
    if ($richtung =~ /o$/) { $richtung =~ s/o$/e/; }
    my $staerke  = $self->{Wind}{Windstaerke};
    my $im = $self->{Image};
    my($rad) = 10;
    my $col = $darkblue;
    $im->set_stroke_color(@$col);
    $im->set_fill_color(@$col);
    $im->circle($self->{Width}-20, 20, $rad);
    $im->fill;
    if ($staerke > 0) {
	my %senkrecht = # im Uhrzeigersinn
	    ('-1,-1' => [-1,+1],
	     '-1,0'  => [ 0,+1],
	     '-1,1'  => [+1,+1],
	      '0,1'  => [+1, 0],
	      '1,1'  => [+1,-1],
	      '1,0'  => [ 0,-1],
	      '1,-1' => [-1,-1],
	      '0,-1' => [-1, 0],
	    );
	my($ydir, $xdir) = @{$BBBikeCalc::wind_dir{$richtung}};
	if (exists $senkrecht{"$xdir,$ydir"}) {
	    my($x2dir, $y2dir) = @{ $senkrecht{"$xdir,$ydir"} };
	    my($yadd, $xadd) = map { -$_*15 } ($ydir, $xdir);
	    $xadd = -$xadd; # korrigieren
	    $im->line($self->{Width}-20, 20, $self->{Width}-20+$xadd, 20+$yadd);
	    my $this_tic = 15;
	    my $i = $staerke;
	    my $last_is_half = 0;
	    if ($i%2 == 1) {
		$last_is_half++;
		$i--;
	    }
	    while ($i >= 0) {
		my($yadd, $xadd) = map { -$_*$this_tic } ($ydir, $xdir);
		$xadd = -$xadd;
		my $stroke_len;
		if ($i == 0) {
		    if ($last_is_half) {
			# half halbe Strichl�nge
			$stroke_len = 3;
		    } else {
			last;
		    }
		} else {
		    # full; volle Strichl�nge
		    $stroke_len = 6;
		}
		my($yadd2, $xadd2) = map { -$_*$stroke_len } ($y2dir, $x2dir);
		$xadd2 = -$xadd2;
		$im->line($self->{Width}-20+$xadd, 20+$yadd,
			  $self->{Width}-20+$xadd+$xadd2, 20+$yadd+$yadd2);
		$this_tic -= 3;
		last if $this_tic <= 0;
		$i-=2;
	    }
	}
    }
}

sub add_route_descr {
    my $self = shift;
    my(%args) = @_;
    my $net = $args{-net} || die "-net is missing";
    my(@c) = map { [split /,/ ] } @{ $self->{Coords} };

    require Route::PDF;
    require Route;

    Route::PDF::add_page_to_bbbikedraw
	    (-bbbikedraw => $self,
	     -net => $net,
	     -route => Route->new_from_realcoords(\@c),
	    );
}

sub flush {
    my $self = shift;
    my %args = @_;
    if (!defined $self->{Filename}) {
	my $fh = $args{Fh} || $self->{Fh};
	binmode $fh;
    }
    $self->{PDF}->close;

    if ($self->{Compress}) {
	my $compress_message = sub {
	    my($before, $after) = @_;
	    "Compressed " . (100-int(100*(-s $after)/(-s $before))) .
		"% (original " . (-s $before) . " bytes, compressed " . (-s $after) . " bytes)...\n";
	};

	if (defined $self->{_CompressOriginalFilename}) {
	    system("pdftk", $self->{Filename}, "output", $self->{_CompressOriginalFilename}, "compress");
	    warn eval { $compress_message->($self->{Filename}, $self->{_CompressOriginalFilename}) }
		if $VERBOSE;
	    unlink $self->{_CompressTemporaryFilename};
	} else {
	    require File::Temp;
	    my($fh,$filename) = File::Temp::tempfile(SUFFIX => ".pdf", UNLINK => 1);
	    system("pdftk", $self->{Filename}, "output", $filename, "compress");
	    seek $fh, 0, 0;
	    local $/ = \4096;
	    my $ofh = $self->{Fh};
	    while(<$fh>) {
		print $ofh $_;
	    }
	    close $fh;
	    warn eval { $compress_message->($self->{Filename}, $filename) }
		if $VERBOSE;
	    unlink $filename;
	    unlink $self->{_CompressTemporaryFilename};
	}
    }
}

# use Return => "string" in the constructor for this method
sub string {
    my($self, %args) = @_;
    $self->flush(%args);
    if (defined $self->{Filename}) {
	open(F, $self->{Filename}) or die "Can't open $self->{Filename}: $!";
	local $/ = undef;
	my $buf = scalar <F>;
	close F;
	$buf;
    } else {
	$ {$self->{Fh}->string_ref };
    }
}

sub empty_image_error {
    my $self = shift;
    my $im = $self->{Image};
    my $fh = $self->{Fh};

    $im->stringc($sansserif, 24, 300, 400, "Empty image!") if $im;
    $self->{PDF}->close if $self->{PDF};
    confess "Empty image";
}

# return transposed and pdf'ied "strecke" and the bbox
sub transpose_all {
    my($s, $transpose) = @_;
    # first:
    my($tx,$ty) = map { sprintf "%.2f", $_ }
	              $transpose->(@{ Strassen::to_koord1($s->[0]) });

    my $res = [[$tx, $ty]];
    my $bbox = [$tx,$ty,$tx,$ty];

    foreach my $xy (@{$s}[1 .. $#$s]) {
	my($tx,$ty) = map { sprintf "%.2f", $_ }
	                  $transpose->(@{ Strassen::to_koord1($xy) });
	push @$res, [ $tx, $ty ];

	$bbox->[0] = $tx if ($tx < $bbox->[0]);
	$bbox->[2] = $tx if ($tx > $bbox->[2]);
	$bbox->[1] = $ty if ($ty < $bbox->[1]);
	$bbox->[3] = $ty if ($ty > $bbox->[3]);
    }

    ($res, $bbox);
}

# return true if the union is not empty
sub bbox_in_region {
    my($bbox, $region) = @_;
    return 0 if ($bbox->[0] > $region->[2] ||
		 $bbox->[1] > $region->[3] ||
		 $bbox->[2] < $region->[0] ||
		 $bbox->[3] < $region->[1]);
    1;
}

sub origin_position { "sw" }

sub can_multiple_passes {
    my($self, $type) = @_;
    return $type eq 'flaechen';
}

1;
