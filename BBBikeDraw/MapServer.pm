# -*- perl -*-

#
# $Id: MapServer.pm,v 1.19 2005/03/21 23:16:34 eserte Exp $
# Author: Slaven Rezic
#
# Copyright (C) 2003 Slaven Rezic. All rights reserved.
# This program is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://bbbike.sourceforge.net/
#

package BBBikeDraw::MapServer;
use strict;
use base qw(BBBikeDraw);
use Strassen;
# Strassen benutzt FindBin benutzt Carp, also brauchen wir hier nicht zu
# sparen:
use Carp qw(confess);

use vars qw($VERSION $DEBUG %color %outline_color %width);

$DEBUG = 0 if !defined $DEBUG;
$VERSION = sprintf("%d.%02d", q$Revision: 1.19 $ =~ /(\d+)\.(\d+)/);

{
    package BBBikeDraw::MapServer::Conf;
    use base qw(Class::Accessor);
    __PACKAGE__->mk_accessors(qw(BbbikeDir MapserverMapDir MapserverBinDir
				 MapserverRelurl MapserverUrl TemplateMap
				 ImageSuffix FontsList));
    sub new { bless {}, shift }

    # XXX How to code the preferences better?
    sub vran_default {
	my $self = shift->new;
	my $HOME = "/home/e/eserte";
	$self->BbbikeDir("$HOME/src/bbbike");
	$self->MapserverMapDir($self->BbbikeDir . "/mapserver/brb");
	$self->MapserverBinDir("/usr/local/src/mapserver/mapserver-3.6.4");
	$self->MapserverRelurl("/~eserte/mapserver/brb");
	$self->MapserverUrl("http://www/~eserte/mapserver/brb");
	$self->TemplateMap("brb.map-tpl");
	$self->ImageSuffix("png");
	$self->FontsList("fonts-vran.list");
	$self;
    }

    sub ipaq_vran_default {
	my $self = shift->new;
	my(%args) = @_;
	my $HOME = "/home/e/eserte";
	$self->BbbikeDir("$HOME/src/bbbike");
	$self->MapserverMapDir($self->BbbikeDir . "/mapserver/brb");
	$self->MapserverBinDir("/usr/local/src/mapserver/mapserver-3.6.4");
	$self->MapserverRelurl("/~eserte/mapserver/brb");
	$self->MapserverUrl("http://www/~eserte/mapserver/brb");
	$self->TemplateMap("brb-ipaq.map-tpl");
	$self->ImageSuffix($args{ImageType} || "png");
	$self->FontsList("fonts-vran.list");
	$self;
    }

    sub radzeit_default {
	my $self = shift->new;
	my $apache_root;
	my $htdocs;
	if (-d "/var/www/domains/radzeit.de/www/BBBike/data/") {
	    # new radzeit.de
	    $apache_root = "/var/www/domains/radzeit.de/www";
	    $htdocs = "public";
	} else {
	    $apache_root = "/usr/local/apache/radzeit";
	    $htdocs = "htdocs";
	}
	$self->BbbikeDir("$apache_root/BBBike");
	$self->MapserverMapDir("$apache_root/$htdocs/mapserver/brb");
	$self->MapserverBinDir("$apache_root/cgi-bin");
	$self->MapserverRelurl("/mapserver/brb");
	$self->MapserverUrl("http://www.radzeit.de/mapserver/brb");
	$self->TemplateMap("brb.map-tpl");
	$self->ImageSuffix("png");
	$self->FontsList("fonts-radzeit.list");
	$self;
    }

    sub radzeit_herceg_de_default {
	my $self = shift->new;
	my $apache_root = "/home/e/eserte/src/bbbike/projects/www.radzeit.de";
	$self->BbbikeDir("$apache_root/BBBike");
	$self->MapserverMapDir("$apache_root/htdocs/mapserver/brb");
	#$self->MapserverBinDir("$apache_root/cgi-bin");
	$self->MapserverBinDir("/usr/local/src/mapserver/mapserver-3.6.4");
	$self->MapserverRelurl("/mapserver/brb");
	$self->MapserverUrl("http://radzeit.herceg.de/mapserver/brb");
	$self->TemplateMap("brb.map-tpl");
	$self->ImageSuffix("png");
	#$self->FontsList("fonts-radzeit.list");
	$self->FontsList("fonts-vran.list");
	$self;
    }

    sub bbbike_cgi_conf {
	my $self = shift->new;
	my(%args) = @_[1..$#_];
	# guess position of bbbike.cgi.config
	require File::Basename;
	require File::Spec;
	my $bbbike_dir = File::Spec->rel2abs(File::Basename::dirname(File::Basename::dirname($INC{"BBBikeDraw/MapServer.pm"})));
	my $bbbike_cgi_conf_path = File::Spec->catfile($bbbike_dir, "cgi", "bbbike.cgi.config");
	if (!-r $bbbike_cgi_conf_path) {
	    die "$bbbike_cgi_conf_path is not existent or readable";
	}
	require BBBikeMapserver;
	my $ms = BBBikeMapserver->new;
	$ms->read_config($bbbike_cgi_conf_path);
	$self->BbbikeDir("$bbbike_dir");
	$self->MapserverMapDir($ms->{MAPSERVER_DIR});
	if (!defined $ms->{MAPSERVER_BIN_DIR}) {
	    die "Please define \$mapserver_bin_dir in $bbbike_cgi_conf_path";
	}
	$self->MapserverBinDir($ms->{MAPSERVER_BIN_DIR});
	$self->MapserverRelurl($ms->{MAPSERVER_PROG_RELURL});
	$self->MapserverUrl($ms->{MAPSERVER_PROG_URL});
	$self->TemplateMap("brb.map-tpl");
	$self->ImageSuffix($args{ImageType} || "png");
	if (!defined $ms->{MAPSERVER_FONTS_LIST}) {
	    die "Please define \$mapserver_fonts_list in $bbbike_cgi_conf_path";
	}
	$self->FontsList($ms->{MAPSERVER_FONTS_LIST});
	$self;
    }

    sub bbbike_cgi_ipaq_conf {
	my $self = __PACKAGE__->bbbike_cgi_conf;
	my(%args) = @_[1..$#_];
	$self->TemplateMap("brb-ipaq.map-tpl");
	$self->ImageSuffix($args{ImageType} || "png");
	$self;
    }

}

{
    package BBBikeDraw::MapServer::Image;

    use base qw(Class::Accessor);
    use vars qw(@accessors @computed_accessors);
    @accessors = qw(Width Height Imagecolor Transparent BBox
		    ColorGreyBg ColorWhite ColorYellow ColorRed ColorGreen
		    ColorMiddleGreen ColorDarkGreen ColorDarkBlue
		    ColorLightBlue ColorBlack
		    OnFlaechen OnGewaesser OnStrassen OnUBahn OnSBahn OnRBahn
		    OnAmpeln OnOrte OnFaehren OnGrenzen OnFragezeichen OnObst
		    OnRoute OnStartFlag OnGoalFlag OnMarkerPoint OnTitle
		    OnRadwege OnQualitaet OnHandicap OnBlocked OnMount
		    StartFlagPoints GoalFlagPoints MarkerPoint TitleText RouteCoords
		    MapserverDir MapserverRelurl MapserverUrl
		    BbbikeDir ImageDir ImageSuffix FontsList
		   );
    @computed_accessors = qw(Conf ImageType);

    __PACKAGE__->mk_accessors(@accessors);

    sub ImageType {
	my $suffix = shift->ImageSuffix;
	uc($suffix);
    }

    sub Conf {
	my $self = shift;
	if (@_) {
	    $self->set("Conf", @_);
	} else {
	    my $conf = $self->get("Conf");
	    if (!$conf) {
		require Sys::Hostname;
		if (defined $ENV{SERVER_NAME} &&
		    $ENV{SERVER_NAME} =~ /radzeit\.de$/) {
		    $conf = BBBikeDraw::MapServer::Conf->radzeit_default;
		} elsif (defined $ENV{SERVER_NAME} &&
			 $ENV{SERVER_NAME} =~ /radzeit\.herceg\.de$/) {
		    $conf = BBBikeDraw::MapServer::Conf->radzeit_herceg_de_default;
		} elsif (Sys::Hostname::hostname() =~ /herceg\.de$/) {
		    $conf = BBBikeDraw::MapServer::Conf->vran_default;
		} else {
		    $conf = BBBikeDraw::MapServer::Conf->bbbike_cgi_conf;
		}
	    }
	    $conf;
	}
    }

    use Template;
    use File::Temp qw(tempfile);

    sub new {
	my($package, $w, $h) = @_;
	my $self = bless {}, $package;
	$self->Width($w);
	$self->Height($h);
	$self;
    }

    sub imageOut {
	my $self = shift;
	my $conf = $self->Conf;
	my($mapfh, $mapfile) = tempfile
	    (UNLINK => !$BBBikeDraw::MapServer::DEBUG,
	     SUFFIX => ".map");
	$self->BbbikeDir($conf->BbbikeDir);
	$self->ImageDir($self->BbbikeDir . "/images");
	my $mapserver_dir = $conf->MapserverMapDir;
	my $mapserver_bin_dir = $conf->MapserverBinDir;

	$self->MapserverDir($mapserver_dir);
	for my $var (qw(MapserverRelurl MapserverUrl ImageSuffix FontsList)) {
	    $self->$var($conf->$var());
	}

	my $t = Template->new(DEBUG => 0, # Can't use DEBUG=>1 with new TT
			      ABSOLUTE => 1,
			     );
	my $vars = {};
	foreach my $k (@accessors, @computed_accessors) {
	    my $v = $self->$k();
	    (my $k2 = $k) =~ s/(?<=.)([A-Z])/_$1/g;
	    $k2 = uc($k2);
	    if ($k2 =~ /^(WIDTH|HEIGHT)$/) {
		$k2 = "IMG$k2";
	    } elsif ($k2 =~ /^COLOR_/ || $k2 eq 'IMAGECOLOR') {
		$v = join(" ", @$v);
	    }
	    if ($k2 =~ /^ON_/) {
		$v = ($v ? 'ON' : 'OFF');
	    }
	    $vars->{$k2} = $v;
	}

	$t->process("$mapserver_dir/" . $conf->TemplateMap,
		    $vars, $mapfh) || die $t->error;
	close $mapfh;

	my @cmd = (
		   #"valgrind",
		   "$mapserver_bin_dir/shp2img",
		   "-m", $mapfile,
		   "-e", @{ $self->BBox },
		  );
	#warn "@cmd";
	my $buf;

#  	if ($ENV{MOD_PERL}) {
#  	    my($s2i_fh, $s2i_filename) = tempfile(UNLINK => 1,
#  						  SUFFIX => ".img");
#  	    push @cmd, "-o", $s2i_filename;
#  	    system(@cmd);
#  	    die "Command failed with $?: @cmd" if $?;
#  	    open(IMG, $s2i_filename) or die "Can't open $s2i_filename: $!";
#  	    local $/ = undef;
#  	    $buf = <IMG>;
#  	    close IMG;
#  	} else {
	    open(SHP2IMG, "-|") or do {
		{
		    exec @cmd;
		}
		die "Can't exec @cmd: $!";
	    };
	    local $/ = undef;
	    $buf = <SHP2IMG>;
	    close SHP2IMG;
#	}

	$buf;
    }
}

sub init {
    my $self = shift;

    $self->SUPER::init();

    $self->{Width}  ||= 640;
    $self->{Height} ||= 480;

    my $im;
    if ($self->{OldImage}) {
	die "No support for drawing over old images in " . __PACKAGE__;
    } else {
	$im = BBBikeDraw::MapServer::Image->new($self->{Width},$self->{Height});
    }

    $self->{Image}  = $im;
    $im->Conf($self->{Conf});

    $self->allocate_colors;
#    $self->set_category_colors;
#    $self->set_category_outline_colors;
#    $self->set_category_widths;

    $self->set_draw_elements;

    $self;
}

sub allocate_colors {
    my $self = shift;
    my $im = $self->{Image};

    $self->{'Bg'} = '' if !defined $self->{'Bg'};
    if ($self->{'Bg'} =~ /^white/) {
	# Hintergrund wei�: Nebenstra�en werden grau,
	# Hauptstra�en dunkelgelb gezeichnet
	$im->ColorGreyBg([255,255,255]);
	$im->ColorWhite ([153,153,153]);
	$im->ColorYellow([180,180,0]);
    } elsif ($self->{'Bg'} =~ /^\#([a-f0-9]{2})([a-f0-9]{2})([a-f0-9]{2})/i) {
	my($r,$g,$b) = (hex($1), hex($2), hex($3));
	$im->ColorGreyBg([$r,$g,$b]);
    } else {
	#$im->ColorGreyBg([153,153,153]); # zu dunkel
	#$im->ColorGreyBg([225,225,225]); # zu hell f�r den iPAQ
	$im->ColorGreyBg([180,180,180]);
    }
    $im->Transparent($im->ColorGreyBg) if ($self->{'Bg'} =~ /transparent$/);
    $im->Imagecolor($im->ColorGreyBg);

    $im->ColorWhite      ([255,255,255]) if !defined $im->ColorWhite;
    $im->ColorYellow     ([255,255,0])   if !defined $im->ColorYellow;
    $im->ColorRed        ([255,0,0]);
    $im->ColorGreen      ([180,255,180]); # light green
    $im->ColorDarkGreen  ([0,128,0]);
    $im->ColorDarkBlue   ([0,0,128]);
    $im->ColorLightBlue  ([0xa0,0xa0,0xff]);
    $im->ColorMiddleGreen([0, 200, 0]);
    $im->ColorBlack      ([0, 0, 0]);
}

sub draw_map {
    my $self = shift;

    $self->pre_draw if !$self->{PreDrawCalled};

    my $im        = $self->{Image};

    $im->BBox([$self->{Min_x}, $self->{Min_y},
	       $self->{Max_x}, $self->{Max_y}]);

    foreach (@{$self->{Draw}}) {
	if ($_ eq 'title') {
	    # XXX never positively tested
	    $im->OnTitle(1);
	    $im->TitleText($self->make_default_title);
	} elsif (/^ampeln?$/) {
	    $im->OnAmpeln(1);
	} elsif ($_ eq 'strname') {
	    # always on!
	} elsif ($_ eq 'str') {
	    $im->OnStrassen(1);
	} elsif ($_ eq 'wasser') {
	    $im->OnGewaesser(1);
	} elsif ($_ eq 'flaechen') {
	    $im->OnFlaechen(1);
	} elsif ($_ eq 'faehren') {
	    $im->OnFaehren(1);
	} elsif ($_ eq 'ubahn') {
	    $im->OnUBahn(1);
	} elsif (/^[usr]bahnname$/) {
	    # ignore silently
	} elsif ($_ eq 'sbahn') {
	    $im->OnSBahn(1);
	} elsif ($_ eq 'rbahn') {
	    $im->OnRBahn(1);
	} elsif ($_ eq 'berlin') {
	    $im->OnGrenzen(1);
	} elsif ($_ =~ /^orte?$/) {
	    $im->OnOrte(1);
	} elsif ($_ eq 'fragezeichen') {
	    $im->OnFragezeichen(1);
	} elsif ($_ eq 'obst') {
	    $im->OnObst(1);
	} elsif ($_ eq 'radwege') {
	    $im->OnRadwege(1);
	} elsif ($_ eq 'qualitaet') {
	    $im->OnQualitaet(1);
	} elsif ($_ eq 'handicap') {
	    $im->OnHandicap(1);
	} elsif ($_ eq 'blocked') {
	    $im->OnBlocked(1);
	} elsif ($_ eq 'mount') {
	    $im->OnMount(1);
	} else {
	    warn "Ignored: $_";
	}
    }
}

# Zeichnen des Ma�stabs
sub draw_scale {
    die "draw_scale: NYI";
#      my $self = shift;
#      my $im        = $self->{Image};
#      my $transpose = $self->{Transpose};

#      my $x_margin = 10;
#      my $y_margin = 10;
#      my $color = $black;
#      my $bar_width = 4;
#      my($x0,$y0) = $transpose->(0,0);
#      my($x1,$y1, $strecke, $strecke_label);
#      for $strecke (1000, 5000, 10000, 20000, 50000, 100000) {
#  	($x1,$y1) = $transpose->($strecke,0);
#  	if ($x1-$x0 > 30) {
#  	    $strecke_label = $strecke/1000 . "km";
#  	    last;
#  	}
#      }

#      $im->line($self->{Width}-($x1-$x0)-$x_margin,
#  	      $self->{Height}-$y_margin,
#  	      $self->{Width}-$x_margin,
#  	      $self->{Height}-$y_margin,
#  	      $color);
#      $im->line($self->{Width}-($x1-$x0)-$x_margin,
#  	      $self->{Height}-$y_margin-$bar_width,
#  	      $self->{Width}-$x_margin,
#  	      $self->{Height}-$y_margin-$bar_width,
#  	      $color);
#      $im->filledRectangle
#  	($self->{Width}-($x1-$x0)/2-$x_margin,
#  	 $self->{Height}-$y_margin-$bar_width,
#  	 $self->{Width}-$x_margin,
#  	 $self->{Height}-$y_margin,
#  	 $color);
#      $im->line($self->{Width}-($x1-$x0)/2-$x_margin,
#  	      $self->{Height}-$y_margin,
#  	      $self->{Width}-($x1-$x0)/2-$x_margin,
#  	      $self->{Height}-$y_margin-$bar_width,
#  	      $color);
#      $im->line($self->{Width}-($x1-$x0)-$x_margin,
#  	      $self->{Height}-$y_margin+2,
#  	      $self->{Width}-($x1-$x0)-$x_margin,
#  	      $self->{Height}-$y_margin-$bar_width-2,
#  	      $color);
#      $im->line($self->{Width}-$x_margin,
#  	      $self->{Height}-$y_margin+2,
#  	      $self->{Width}-$x_margin,
#  	      $self->{Height}-$y_margin-$bar_width-2,
#  	      $color);
#      $im->string(&GD::Font::Small,
#  		$self->{Width}-($x1-$x0)-$x_margin-3,
#  		$self->{Height}-$y_margin-$bar_width-2-12,
#  		"0", $color);
#      $im->string(&GD::Font::Small,
#  		$self->{Width}-$x_margin+8-6*length($strecke_label),
#  		$self->{Height}-$y_margin-$bar_width-2-12,
#  		$strecke_label, $color);
}

sub draw_route {
    my $self = shift;

    my $im = $self->{Image};
    $im->OnRoute(1);
    $im->OnStartFlag(1);
    $im->OnGoalFlag(1);
    my(@c1) = @{ $self->{C1} };
    $im->RouteCoords(join " ", map { @$_ } @c1);
    $im->StartFlagPoints(join " ", @{ $c1[0] });
    $im->GoalFlagPoints(join " ", @{ $c1[-1] });
    if ($self->{MarkerPoint}) {
	$im->OnMarkerPoint(1);
	$im->MarkerPoint(join " ", split /,/, $self->{MarkerPoint});
    }
}

# Draw this first, otherwise the filling of the circle won't work!
sub draw_wind {
    die "draw_wind NYI";
#      my $self = shift;
#      return unless $self->{Wind};
#      require BBBikeCalc;
#      BBBikeCalc::init_wind();
#      my $richtung = lc($self->{Wind}{Windrichtung});
#      if ($richtung =~ /o$/) { $richtung =~ s/o$/e/; }
#      my $staerke  = $self->{Wind}{Windstaerke};
#      my $im = $self->{Image};
#      my($radx, $rady) = (10, 10);
#      my $col = $darkblue;
#      $im->arc($self->{Width}-20, 20, $radx, $rady, 0, 360, $col);
#      $im->fill($self->{Width}-20, 20, $col);
#      if ($staerke > 0) {
#  	my %senkrecht = # im Uhrzeigersinn
#  	    ('-1,-1' => [-1,+1],
#  	     '-1,0'  => [ 0,+1],
#  	     '-1,1'  => [+1,+1],
#  	      '0,1'  => [+1, 0],
#  	      '1,1'  => [+1,-1],
#  	      '1,0'  => [ 0,-1],
#  	      '1,-1' => [-1,-1],
#  	      '0,-1' => [-1, 0],
#  	    );
#  	my($ydir, $xdir) = @{$BBBikeCalc::wind_dir{$richtung}};
#  	if (exists $senkrecht{"$xdir,$ydir"}) {
#  	    my($x2dir, $y2dir) = @{ $senkrecht{"$xdir,$ydir"} };
#  	    my($yadd, $xadd) = map { -$_*15 } ($ydir, $xdir);
#  	    $xadd = -$xadd; # korrigieren
#  	    $im->line($self->{Width}-20, 20, $self->{Width}-20+$xadd, 20+$yadd,
#  		      $col);
#  	    my $this_tic = 15;
#  	    my $i = $staerke;
#  	    my $last_is_half = 0;
#  	    if ($i%2 == 1) {
#  		$last_is_half++;
#  		$i--;
#  	    }
#  	    while ($i >= 0) {
#  		my($yadd, $xadd) = map { -$_*$this_tic } ($ydir, $xdir);
#  		$xadd = -$xadd;
#  		my $stroke_len;
#  		if ($i == 0) {
#  		    if ($last_is_half) {
#  			# half halbe Strichl�nge
#  			$stroke_len = 3;
#  		    } else {
#  			last;
#  		    }
#  		} else {
#  		    # full; volle Strichl�nge
#  		    $stroke_len = 6;
#  		}
#  		my($yadd2, $xadd2) = map { -$_*$stroke_len } ($y2dir, $x2dir);
#  		$xadd2 = -$xadd2;
#  		$im->line($self->{Width}-20+$xadd, 20+$yadd,
#  			  $self->{Width}-20+$xadd+$xadd2, 20+$yadd+$yadd2,
#  			  $col);
#  		$this_tic -= 3;
#  		last if $this_tic <= 0;
#  		$i-=2;
#  	    }
#  	}
#      }
}

sub make_imagemap {
    require BBBikeDraw::GD;
    BBBikeDraw::GD::make_imagemap(@_);
}

sub flush {
    my $self = shift;
    my %args = @_;
    my $fh = $args{Fh} || $self->{Fh};
    binmode $fh;
    print $fh $self->{Image}->imageOut;
}

sub empty_image_error {
    die "empty_image_error: NYI";
#      my $self = shift;
#      my $im = $self->{Image};
#      my $fh = $self->{Fh};

#      $im->string(GD->gdLargeFont, 10, 10, "Empty image!", $white);
#      binmode $fh if $fh;
#      if ($fh) {
#  	print $fh $im->imageOut;
#      } else {
#  	print $im->imageOut;
#      }
#      confess "Empty image";
}

1;
