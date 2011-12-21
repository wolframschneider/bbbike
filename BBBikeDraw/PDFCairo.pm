# -*- perl -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 2011 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: eserte@users.sourceforge.net
# WWW:  http://bbbike.sourceforge.net
#

package BBBikeDraw::PDFCairo;
use strict;
use base qw(BBBikeDraw);
use Cairo;
use Strassen;
# Strassen benutzt FindBin benutzt Carp, also brauchen wir hier nicht zu
# sparen:
use Carp qw(confess);
use BBBikeUtil qw(pi is_in_path);

use vars qw($VERSION @colors %color %width %outline_color $VERBOSE);
BEGIN { @colors =
         qw($grey_bg $white $yellow $lightyellow $red $green $middlegreen $darkgreen
	    $darkblue $lightblue $rose $black $darkgrey $lightgreen);
}
use vars @colors;

$VERSION = 0.01;

# XXX hmmm, also defined in Route::PDF::Cairo...
use constant DIN_A4_WIDTH => 595;
use constant DIN_A4_HEIGHT => 842;

sub init {
    my $self = shift;

    if ($self->{Compress}) {
	if (is_in_path "pdftk") {
	    $self->{_CompressTool} = "pdftk";
	} elsif (0 && eval { require PDF::API2; require File::Temp; 1 }) {# XXX does not work, see below XXX also not supported in PDFCairo (yet? never?)
	    $self->{_CompressTool} = "PDF::API2";
	} elsif (0 && eval { require CAM::PDF; require File::Temp; 1 }) {# XXX not supported in PDFCairo (yet? never?)
	    $self->{_CompressTool} = "CAM::PDF";
	} else {
	    warn "No pdftk in PATH available, don't compress...";
	    undef $self->{Compress};
	}
	if ($self->{_CompressTool}) {
	    require File::Temp;
	    my($fh,$filename) = File::Temp::tempfile(SUFFIX => ".pdf", UNLINK => 1);
	    die "Cannot create temporary file: $!" if !$filename;
	    $self->{_CompressOriginalFilename} = $self->{Filename};
	    $self->{_CompressTemporaryFilename} = $filename;
	    $self->{Filename} = $filename;
	}
    }

    my $page_bbox = [0,0,DIN_A4_WIDTH,DIN_A4_HEIGHT];
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

    my $surface;
    if (defined $self->{Filename}) {
	$surface = Cairo::PdfSurface->create($self->{Filename}, $page_bbox->[2], $page_bbox->[3]);
    } else {
	my $fh = $self->{Fh};
	$surface = Cairo::PdfSurface->create_for_stream(sub { print $fh $_[1] }, undef, $page_bbox->[2], $page_bbox->[3]);
    }

    ## XXX no Cairo support for these, it seems
    #'Author' => 'Slaven Rezic',
    #'Title' => 'BBBike Route',
    #'Creator' => __PACKAGE__ . " version $BBBikeDraw::PDF::VERSION",
    #'CreationDate' => [ localtime ],
    #'Keywords' => 'Routenplaner Fahrrad',
    ##'PageMode' => 'UseOutlines',

    my $cr = Cairo::Context->create($surface);
    # XXX $rotate specification

    ## XXX no outline support here
    #$pdf->new_outline('Title' => (defined $self->{Lang} && $self->{Lang} eq 'en' ? 'map' : 'Karte'),
    #	      'Destination' => $page);

    $self->{PDF}      = $surface;
    $self->{Image}    = $cr; # named "Image" for GD compatibility

# XXX Following is same as in PDF.pm

    $self->{PageBBox} = $page_bbox;
    $self->{Width}    = $page_bbox->[2]-$page_bbox->[0];
    $self->{Height}   = $page_bbox->[3]-$page_bbox->[1];

    if (!defined $self->{Outline}) {
	$self->{Outline} = 1;
    }

    $self->allocate_colors_and_fonts;
    $self->set_category_colors;
    $self->set_category_outline_colors;
    $self->set_category_widths; # Note: will be called again in draw_map (with $m argument)

    # grey background (different from PDF.pm again)
    $cr->rectangle(@$page_bbox);
    $cr->set_source_rgb(@$grey_bg);
    $cr->fill;

    $self->set_draw_elements;

    $self;
}

sub allocate_colors_and_fonts {
    my $self = shift;
    $self->allocate_colors;
    # No fonts need to be allocated, this is the job of Pango
}

# XXX Same as in PDF.pm
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
    $lightyellow = [1,1,0.7] if !defined $lightyellow;
    $red         = [1,0,0];
    $green       = [0,1,0];
    $darkgreen   = [0,0.5,0];
    $darkblue    = [0,0,0.5];
    $lightblue   = [0.73,0.84,0.97];
    $middlegreen = [0,0.78,0];
    $lightgreen  = [200/256,1,200/256];
    $rose        = [map { $_/256 } 215, 184, 200];
    $black       = [0,0,0];
    $darkgrey    = [map { $_/256 } 63, 63, 63];
}

sub draw_map {
    my $self = shift;
    my $im        = $self->{Image};
    my $transpose = $self->{Transpose};

    {
	my $m = ($self->{Xk} > 0.06  ? 1   :
		 $self->{Xk} > 0.04  ? 0.8 :
		 $self->{Xk} > 0.02  ? 0.6 :
		                       0.4);
	$self->set_category_widths($m);
    }

    $self->_get_nets;
    $self->{FlaechenPass} = 1;

    my %str_draw = %{ $self->{_StrDraw} };
    my %p_draw = %{ $self->{_PDraw} };
    my $title_draw = $self->{_TitleDraw};

    my $bbox = $self->{PageBBox};

    my $restrict;
    if ($self->{Restrict}) {
	$restrict = { map { ($_ => 1) } @{ $self->{Restrict} } };
    }

    for my $layer_def (@{ $self->{_Layers} }) {
	my($strecke, $strecke_name, $is_outline) = @$layer_def;

	if ($is_outline) {
	    if ($self->{Outline}) {
		$strecke->init;
		while(1) {
		    my $s = $strecke->next;
		    last if !@{$s->[1]};
		    my $cat = $s->[2];
		    $cat =~ s{::.*}{};
		    my $is_area = 0;
		    if ($cat =~ /^F:([^|]+)/) {
			$cat = $1;
			$is_area = 1;
		    }
		    next if $restrict && !$restrict->{$cat};

		    my($ss, $bbox) = transpose_all($s->[1], $transpose);
		    next if (!bbox_in_region($bbox, $self->{PageBBox}));

		    if ($is_area) {
			$im->set_line_width(2);
		    } else {
			$im->set_line_width(($width{$cat}||1)*1+2);
		    }
		    $im->set_source_rgb(@{ $outline_color{$cat} || [0,0,0] });

		    $im->move_to(@{ $ss->[0] });
		    for my $xy (@{$ss}[1 .. $#$ss]) {
			$im->line_to(@$xy);
		    }
		    # close polygon
		    if ($is_area && "@{ $ss->[0] }" ne "@{ $ss->[-1] }") {
			$im->line_to(@{ $ss->[0] });
		    }
		    $im->stroke;
		}
	    }
	} else {
	    my $flaechen_pass = $self->{FlaechenPass};
	    for my $s ($self->get_street_records_in_bbox($strecke)) {
		my $cat = $s->[Strassen::CAT];

		my($ss, $bbox) = transpose_all($s->[Strassen::COORDS], $transpose);
		next if (!bbox_in_region($bbox, $self->{PageBBox}));
		next if ($cat =~ $BBBikeDraw::bahn_bau_rx); # Ausnahmen: in Bau

		# move to first point
		$im->move_to(@{ $ss->[0] });

		if ($cat =~ /^F:([^|]+)/) {
		    my $cat = $1;
		    next if ($strecke_name eq 'flaechen' &&
			     (($flaechen_pass == 1 && $cat eq 'Pabove') ||
			      ($flaechen_pass == 2 && $cat ne 'Pabove'))
			    );
		    $im->set_line_width(1);
		    if (my($r,$g,$b) = $cat =~ m{^\#([0-9a-f]{2})([0-9a-f]{2})([0-9a-f]{2})$}i) {
			($r,$g,$b) = (hex($r)/255,hex($g)/255,hex($b)/255);
			$im->set_source_rgb($r,$g,$b);
		    } else {
			$im->set_source_rgb(@{ $color{$cat} || [0,0,0] });
		    }
		    for my $xy (@{$ss}[1 .. $#$ss]) {
			$im->line_to(@$xy);
		    }
		    $im->fill;
		} else {
		    $cat =~ s{::.*}{};
		    next if $restrict && !$restrict->{$cat};
		    $im->set_line_width(($width{$cat} || 1) * 1);
		    $im->set_source_rgb(@{ $color{$cat} || [0,0,0] });
		    for my $xy (@{$ss}[1 .. $#$ss]) {
			$im->line_to(@$xy);
		    }
		    $im->stroke;
		}
	    }
	    if ($strecke_name eq 'flaechen') {
		$self->{FlaechenPass}++;
	    }
	}
    }

    # $self->{Xk} bezeichnet den Vergr��erungsfaktor
    # bis etwa 0.02 ist es zu un�bersichtlich, Ampeln zu zeichnen,
    # ab etwa 0.05 kann man die mittelgro�e Variante nehmen
    if ($p_draw{'ampel'} && $self->{Xk} >= 0.02) {
	my $lsa = new Strassen "ampeln";
	my $images_dir = $self->get_images_dir;
	my $suf = ($self->{Xk} >= 0.05 ? '' : '2');

	my($kl_ampel);
	my($kl_andreas);
	my($kl_zugbruecke);

	eval {
	    my $file;
	    $kl_ampel      = Cairo::ImageSurface->create_from_png("$images_dir/ampel_klein$suf.png");
	    $kl_andreas    = Cairo::ImageSurface->create_from_png("$images_dir/andreaskr_klein$suf.png");
	    $kl_zugbruecke = Cairo::ImageSurface->create_from_png("$images_dir/zugbruecke_klein.png");
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
		    my($w,$h) = ($image->get_width, $image->get_height);
		    $im->set_source_surface($image, $x-$w/2, $y-$h/2);
		    $im->paint;
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

    my $min_ort_category = ($self->{Xk} < 0.005 ? 3
 			    : ($self->{Xk} < 0.01 ? 2
 			       : ($self->{Xk} < 0.02 ? 1 : 0)));
    my %ort_font = (0 => 6,
		    1 => 7,
		    2 => 8,
 		    3 => 10,
 		    4 => 12,
 		    5 => 14,
 		    6 => 16,
 		   );
    foreach my $def (['ubahn', 'ubahnhof', 'u'],
		     ['sbahn', 'sbahnhof', 's'],
		     ['ort', 'orte',       'o'],
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
		    $image = Cairo::ImageSurface->create_from_png("$images_dir/ubahn$suffix.png");
		} elsif ($points eq 'sbahnhof') {
		    $image = Cairo::ImageSurface->create_from_png("$images_dir/sbahn$suffix.png");
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
		    my($w,$h) = ($image->get_width, $image->get_height);
		    $x1 -= $w/2;
		    $y1 -= $h/2;
		    next if $x1 < 0 || $y1 < 0 || $x1 > $self->{Width} || $y1 > $self->{Height};
		    $im->set_source_surface($image, $x1, $y1);
		    $im->paint;
 		} else {
 		    if ($cat >= $min_ort_category) {
 			my($x, $y) = &$transpose(@{$s->coord_as_list(0)});
 			my $ort = $s->name;
 			# Anh�ngsel l�schen (z.B. "b. Berlin")
 			$ort =~ s/\|.*$//;
			$im->set_source_rgb(@$black);
			$im->move_to($x, $y);
 			$im->arc($x, $y, 1, 0, 2*pi);#XXX check!
			$im->fill;
			$im->set_source_rgb(@$darkblue);
			draw_text($im, $ort_font{$cat} || 6, $x+4, $y, $ort);
 		    }
 		}
  	    }
  	}
    }

#XXXX implement here!!!
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

# Zeichnen des Ma�stabs
sub draw_scale {
    my $self = shift;
    my $im        = $self->{Image};
    my $transpose = $self->{Transpose};

    my $x_margin = 12;
    my $y_margin = $self->{Height} - 20;
    my $color = $black;
    my $bar_width = 4;
    my($x0,$y0) = $transpose->($self->standard_to_coord(0,0));
    my($x1,$y1, $strecke, $strecke_label);
    for $strecke (10, 50, 100, 500, 1000, 5000, 10000, 20000, 50000, 100000) {
	($x1,$y1) = $transpose->($self->standard_to_coord($strecke,0));
	if ($x1-$x0 > 50) {
	    if ($strecke >= 1000) {
		$strecke_label = $strecke/1000 . "km";
	    } else {
		$strecke_label = $strecke . "m";
	    }
	    last;
	}
    }

    {
	my @rect_coords = (
			   $self->{Width}-($x1-$x0)-$x_margin,
			   $y_margin,
			   ($x1-$x0)/2,
			   $bar_width
			  );
	$im->set_source_rgb(@$color);
	$im->set_line_width(1);
	$im->rectangle(@rect_coords);
	$im->stroke;

	$im->set_source_rgb(@$white);
	$im->rectangle(@rect_coords);
	$im->fill;
    }

    $im->set_source_rgb(@$color);
    $im->rectangle($self->{Width}-($x1-$x0)/2-$x_margin,
		   $y_margin,
		   ($x1-$x0)/2,
		   $bar_width);
    $im->fill;

    $im->move_to($self->{Width}-($x1-$x0)-$x_margin, $y_margin);
    $im->line_to($self->{Width}-$x_margin, $y_margin);

    $im->move_to($self->{Width}-($x1-$x0)-$x_margin, $y_margin+$bar_width);
    $im->line_to($self->{Width}-$x_margin, $y_margin+$bar_width);

    $im->move_to($self->{Width}-($x1-$x0)/2-$x_margin, $y_margin);
    $im->line_to($self->{Width}-($x1-$x0)/2-$x_margin, $y_margin+$bar_width);

    $im->move_to($self->{Width}-($x1-$x0)-$x_margin, $y_margin-2);
    $im->line_to($self->{Width}-($x1-$x0)-$x_margin, $y_margin+$bar_width+2);

    $im->move_to($self->{Width}-$x_margin, $y_margin-2);
    $im->line_to($self->{Width}-$x_margin, $y_margin+$bar_width+2);

    $im->stroke;

    my $font_size = 10;
    draw_text($im, $font_size, $self->{Width}-($x1-$x0)-$x_margin-3, $y_margin+$bar_width+$font_size, "0");
    draw_text($im, $font_size, $self->{Width}-$x_margin+8-6*length($strecke_label), $y_margin+$bar_width+$font_size, $strecke_label);
}

sub draw_route {
    my $self = shift;

    $self->pre_draw if !$self->{PreDrawCalled};

    my $im        = $self->{Image};
    my $transpose = $self->{Transpose};
    my @multi_c1 = @{ $self->{MultiC1} };
    my $strnet; # StrassenNetz-Objekt

    foreach (@{$self->{Draw}}) {
	if ($_ eq 'strname' && $self->{'MakeNet'}) {
	    $strnet = $self->{MakeNet}->('lite');
	}
    }

    $im->set_line_width(6);

    # Route
    if (@multi_c1) {
	for my $c1 (@multi_c1) {
	    my @c1 = @$c1;
	    if (@c1) {
		for my $def (
			     # Prepared to use alternate colors, but I
			     # did not found a good pair so far. Use
			     # darker red, to not conflicht with $red
			     # used in Bundesstra�en.
			     [[0.4, 0, 0], 0],
			     [[0.4, 0, 0], 7],
			    ) {
		    my($color, $phase) = @$def;
		    $im->set_source_rgb(@$color);
		    # XXX what was $phase here, can it be emulated (see PDF.pm)?
		    $im->set_dash($phase, 4, 10);
		    $im->move_to(map { sprintf "%.2f", $_ } $transpose->(@{ $c1[0] }));
		    for(my $i = 1; $i <= $#c1; $i++) {
			$im->line_to(map { sprintf "%.2f", $_ } $transpose->(@{ $c1[$i] }));
		    }
		    $im->stroke;
		}
		$im->set_dash(0);
	    }
	}
    }

    # Flags
    if (@multi_c1 > 1 || ($multi_c1[0] && @{$multi_c1[0]} > 1)) {
	if ($self->{UseFlags}) {
	    my $images_dir = $self->get_images_dir;
	    my $start_flag = Cairo::ImageSurface->create_from_png("$images_dir/flag2_bl.png");
	    if ($start_flag) {
		my($x, $y) = &$transpose(@{ $multi_c1[0][0] });
		$im->set_source_surface($start_flag, $x-4, $y-15);
		$im->paint;
	    }
	    my $end_flag = Cairo::ImageSurface->create_from_png("$images_dir/flag_ziel.png");
	    if ($end_flag) {
		my($x, $y) = &$transpose(@{ $multi_c1[-1][-1] });
		$im->set_source_surface($end_flag, $x-4, $y-15);
		$im->paint;
	    }
	}
    }

    # Ausgabe der Stra�ennnamen
    if ($strnet) {
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
	    my($s_width, $s_height) = get_text_dimensions($im, $size, $name);
	    $y-=($s_height+$pad);
	    if ($sm) {
		my($x1,$y1,$x2,$y2) = ($x-$pad, $y-$pad, $x+$s_width+$pad, $y+$s_height+$pad);
		my $r1 = $sm->nearest([$x1,$y1,$x2,$y2]);
		if (!defined $r1) {
		    warn "No space left for [$x1,$y1,$x2,$y2]";
		} else {
		    $sm->add($r1);
		    $x = $r1->[0]+$pad;
		    $y = $r1->[1]+$pad;
		}
	    }
	    $im->set_source_rgb(@$white);
	    $im->rectangle($x-$pad, $y-$pad, $s_width+$pad*2, $size+$pad);
	    $im->fill;
	    $im->set_source_rgb(@$black);
	    $im->rectangle($x-$pad, $y-$pad, $s_width+$pad*2, $size+$pad);
	    $im->stroke;
	    draw_text($im, $size, $x, $y+$size-2, $name);
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
	my $title_string = "$start " . chr(0x2190) . " $ziel";

	my $size = 20;
	my($s_width, $s_height) = get_text_dimensions($im, $size, $title_string);

	my $y_top = 7;

	$im->set_source_rgb(@$white);
	$im->set_line_width(1);
	$im->rectangle(15, $y_top, $s_width+5+5, $size+7);
	$im->fill;
	$im->set_source_rgb(@$black);
	$im->rectangle(15, $y_top, $s_width+5+5, $size+7);
	$im->stroke;

	$im->set_source_rgb(@$black);
	my $x = 20;
	my $y = $y_top + $size;
	draw_text($im, $size, $x, $y, $title_string);
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
    my @c;
    if ($self->{MultiCoords}) {
	# XXX this is a suboptimal solution!
	# Route should deal with interrupted routes!
	@c = map { [split /,/ ] } map { @$_ } @{ $self->{MultiCoords} };
    } else {
	@c = map { [split /,/ ] } @{ $self->{Coords} };
    }

    require Route::PDF::Cairo;
    require Route;

    Route::PDF::Cairo::add_page_to_bbbikedraw
	    (-bbbikedraw => $self,
	     -net => $net,
	     -route => Route->new_from_realcoords(\@c),
	     -lang => $args{'-lang'},
	    );
}

sub flush {
    my $self = shift;
    my %args = @_;
    if (!defined $self->{Filename}) {
	my $fh = $args{Fh} || $self->{Fh};
	binmode $fh;
    }
    $self->{PDF}->finish;

    if ($self->{Compress}) {
	my $compress_message = sub {
	    my($before, $after) = @_;
	    $before = ref $before ? $$before : -s $before;
	    $after  = ref $after  ? $$after  : -s $after;
	    "Compressed " . (100-int(100*($after)/($before))) .
		"% (original " . ($before) . " bytes, compressed " . ($after) . " bytes)...\n";
	};

	if ($self->{_CompressTool} eq 'pdftk') {
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
	} elsif (0 && $self->{_CompressTool} eq 'PDF::API2') {# XXX not supported in PDFCairo (yet? never?)
	    # XXX Does not work!!!
	    my $pdf = PDF::API2->open($self->{Filename});
 	    my $page = $pdf->openpage(1)
 		or die "Cannot open page 1";
	    $page->fixcontents;
	    # XXX Especially this part does not work
 	    warn("compressing"),$_->compressFlate for $page->{Contents}->elementsof;
	    if (defined $self->{_CompressOriginalFilename}) {
		$pdf->saveas($self->{_CompressOriginalFilename});
		warn eval { $compress_message->($self->{Filename}, $self->{_CompressOriginalFilename}) }
		    if $VERBOSE;
	    } else {
		my $ofh = $self->{Fh};
		my $pdf_contents = $pdf->stringify;
		print $ofh $pdf_contents;
		warn eval { $compress_message->($self->{Filename}, \length $pdf_contents) }
		    if $VERBOSE;
	    }
	    unlink $self->{_CompressTemporaryFilename};
	} elsif (0 && $self->{_CompressTool} eq 'CAM::PDF') { # XXX not supported in PDFCairo (yet? never?)
	    my $pdf = CAM::PDF->new($self->{Filename});
	    # XXX It's purely coincidence that the map drawing is objnum=3
	    # XXX But how to get it reliably?
	    $pdf->encodeObject(3, 'FlateDecode');
	    $pdf->clean;
	    if (defined $self->{_CompressOriginalFilename}) {
		$pdf->output($self->{_CompressOriginalFilename});
		warn eval { $compress_message->($self->{Filename}, $self->{_CompressOriginalFilename}) }
		    if $VERBOSE;
	    } else {
		my $ofh = $self->{Fh};
		my $pdf_contents = $pdf->toPDF;
		print $ofh $pdf_contents;
		warn eval { $compress_message->($self->{Filename}, \length $pdf_contents) }
		    if $VERBOSE;
	    }
	    unlink $self->{_CompressTemporaryFilename};
	} else {
	    die "Unhandled compression tool <$self->{_CompressTool}>";
	}
    }
}

# use Return => "string" in the constructor for this method
#XXX NYI
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

    if ($im) {
	my @error_msg = $self->empty_image_error_message;
	$im->set_source_rgb(@$black);
	my $y = 750;
	for my $line (@error_msg) {
	    draw_text($im, 24, 50, $y, $line);
	    $y -= 30;
	}
	$self->flush;
    }
    confess "Empty image";
}

# return transposed and pdf'ied "strecke" and the bbox
sub transpose_all {
    my($s, $transpose) = @_;
    # first:
    my($tx,$ty) = map { sprintf "%.2f", $_ }
	              $transpose->(@{ Strassen::to_koord_f1($s->[0]) });

    my $res = [[$tx, $ty]];
    my $bbox = [$tx,$ty,$tx,$ty];

    foreach my $xy (@{$s}[1 .. $#$s]) {
	my($tx,$ty) = map { sprintf "%.2f", $_ }
	                  $transpose->(@{ Strassen::to_koord_f1($xy) });
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

sub can_multiple_passes {
    my($self, $type) = @_;
    return $type eq 'flaechen';
}

sub patch_string {
    if (!eval { require BBBikeUnicodeUtil; 1 }) {
	$_[0];
    } else {
	BBBikeUnicodeUtil::unidecode_string($_[0]);
    }
}

sub draw_text {
    my($surface, $size, $x, $y, $string) = @_;
    if (eval { require Pango; die "Pango NYI" }) {
	# XXX
    } else {
	$string = patch_string($string);
	utf8::upgrade($string); # workaround bug in Cairo, see https://rt.cpan.org/Ticket/Display.html?id=73177
	$surface->move_to($x, $y);
	$surface->select_font_face('Sans Serif', 'normal', 'normal');
	$surface->set_font_size($size);
	$surface->show_text($string);
    }
}

sub get_text_dimensions {
    my($surface, $size, $string) = @_;
    if (eval { require Pango; die "Pango NYI" }) {
	# XXX
    } else {
	$string = patch_string($string);
	utf8::upgrade($string); # workaround bug in Cairo, see https://rt.cpan.org/Ticket/Display.html?id=73177
	$surface->select_font_face('Sans Serif', 'normal', 'normal');
	$surface->set_font_size($size);
	my $extents = $surface->text_extents($string);
	($extents->{width}, $extents->{height});
    }
}

1;
