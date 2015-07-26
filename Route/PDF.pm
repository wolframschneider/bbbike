# -*- perl -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 2002,2004,2011 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://bbbike.de
#

package Route::PDF;
use Encode;

use strict;
use vars qw($VERSION);
$VERSION = sprintf("%d.%02d", q$Revision: 1.10 $ =~ /(\d+)\.(\d+)/);

sub new {
    my $class = shift;
    my(%args) = @_;
    my $self = {};
    if ($args{-pdf}) {
	$self->{PDF} = delete $args{-pdf};
    } else {
	$self->{PDF} = new_pdf(\%args);
    }
    if (keys %args) {
	die "Too much parameters to " . __PACKAGE__ . "::new";
    }
    bless $self, $class;
}

sub new_pdf {
    my($argref) = @_;
    my($filename, $fh);
    if ($argref->{-filename}) {
	$filename = delete $argref->{-filename};
    } elsif ($argref->{-fh}) {
	$fh = delete $argref->{-fh};
    } else {
	die "Either -filename or -fh are necessary";
    }
    require PDF::Create;
    PDF::Create->VERSION(0.06);
    require PDF::Create::MyPage;
    my $pdf = PDF::Create->new
	((defined $filename ?
	  ('filename' => $filename) :
	  ('fh' => $fh)),
	 'Author' => 'Slaven Rezic',
	 'Title' => 'BBBike Route',
	 'Creator' => __PACKAGE__ . " version $Route::PDF::VERSION",
	);
    $pdf;
}

sub output {
    my $self = shift;

    require Route::Descr;

    my(%args) = @_;
    my $out = Route::Descr::convert(%args, 'unidecode' => \&_unidecode_string);

    $self->allocate_fonts;
    my $pdf = $self->{PDF};
    # XXX Maybe the MediaBox should be configurable?
    my $media_box = $pdf->get_page_size('a4');
    my(undef, undef, $page_width, $page_height) = @$media_box;
    my $page = $pdf->new_page(MediaBox => $media_box);
    $pdf->new_outline('Title' => &Route::Descr::M('Routenliste'),
		      'Destination' => $page);
    my $font = $self->{NormalFont};
    my $bold_font = $self->{BoldFont};
    my $start_y = $page_height-80;
    my $y = $start_y;

    my $url = $out->{Url} || "http://www.bbbike.org";
    $url =~ s,/+$,,;
    my $city;
    if ($url =~ m,/([^/]+)$,) {
	$city = $1;
    }

    my $title = "BBBike.org$url";
    $title .= " // " . $out->{City_en} if $city && $out->{City_en} && $city ne $out->{City_en};

    $page->stringc($font, 24, $page_width/2, $y, $title ); $y -= 24+3;

    if ($out->{Title}) {
	my $title = _unidecode_string($out->{Title});
	my $font_size = 18;
	my @str = split / /, $title;
  	my $width = $page->my_string_width($font, join(" ", @str))*$font_size;
	if ($width > $page_width-40) {
	    $page->stringc($font, $font_size, $page_width/2, $y, join(" ", @str[0 .. $#str/2])); $y -= 18+3;
	    $page->stringc($font, $font_size, $page_width/2, $y, join(" ", @str[$#str/2+1 .. $#str])); $y -= 18+3;
	} else {
	    $page->stringc($font, $font_size, $page_width/2, $y, join(" ", @str)); $y -= 18+3;
	}
    }

    my @lines = (@{ $out->{Lines} }, $out->{Footer});

    my $font_size = 10;
    my @max_width;
    for my $line (@lines) {
	my $col_i = 0;
	for my $col (@$line) {
	    $col = "" if !defined $col;
	    $col = _unidecode_string($col); # yes, change @$line!
	    my $font = ($col_i == 2 ? $bold_font : $font);
	    my $this_width = $page->my_string_width($font, $col)*$font_size;
	    if (!defined $max_width[$col_i] || $max_width[$col_i] < $this_width) {
		$max_width[$col_i] = $this_width;
	    }
	    $col_i++;
	}
    }

    my $start_x = 30;
    my $x_spacing = 10;

    for my $line (@lines) {
	my $x = $start_x;
	for my $col_i (0 .. $#$line) {
	    my $col = $line->[$col_i];
	    my $font = ($col_i == 2 ? $bold_font : $font);
	    my $width = $page->my_string_width($font, $col)*$font_size;
	    if ($x + $width > $page_width-30) {
		#XXX TODO warn "wrap!";
	    }
	    $page->string($font, $font_size, $x, $y, $col);
	    $x += $max_width[$col_i]+$x_spacing;
	    $col_i++;
	}
	$y -= $font_size+3;
	if ($y < 40) {
	    $page = $pdf->new_page(MediaBox => $media_box); $y = $start_y;
	}
    }
}

sub allocate_fonts {
    my $self = shift;
    $self->{NormalFont} = $self->{PDF}->font('Subtype'  => 'Type1',
					     'Encoding' => 'WinAnsiEncoding',
					     'BaseFont' => 'Helvetica');
    $self->{BoldFont} = $self->{PDF}->font('Subtype'  => 'Type1',
					   'Encoding' => 'WinAnsiEncoding',
					   'BaseFont' => 'Helvetica-Bold');
}

sub add_page_to_bbbikedraw {
    my(%args) = @_;
    my $bbbikedraw = delete $args{-bbbikedraw} || die "-bbbikedraw missing";
    my $rpdf = __PACKAGE__->new(-pdf => $bbbikedraw->{PDF});
    $rpdf->output(%args);
}

sub flush {
    my $self = shift;
    $self->{PDF}->close;
}

sub _unidecode_string {
    require BBBikeUnicodeUtil;
    BBBikeUnicodeUtil::unidecode_string(@_);
}

1;

__END__
