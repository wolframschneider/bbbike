#!perl

use strict;
use warnings;
use FindBin;

use Plack::Builder;
use Plack::Middleware::Static;
use Plack::App::WrapCGI;

use Cwd 'cwd', 'realpath';
use File::Basename 'dirname';
use File::Spec::Functions 'catfile', 'catpath';

my $root = dirname(realpath($FindBin::RealBin));
my $cgidir = catpath $root, 'cgi';

builder {

    enable "Plack::Middleware::Static",
	path => sub { s!^/BBBike/!! }, root => $root, encoding => 'iso-8859-1';

    enable "Plack::Middleware::Static",
	path => sub { s!^/bbbike/(html/opensearch/)!$1! }, root => $root, encoding => 'utf-8';

    enable "Plack::Middleware::Static",
	path => sub { s!^/bbbike/(html|images/)!$1! }, root => $root, encoding => 'iso-8859-1';

    my $app;
    for my $cgidef (
		    ['bbbike.cgi', 'bbbike2.cgi'],
		    ['bbbike.en.cgi', 'bbbike2.en.cgi'],
		    ['bbbikegooglemap.cgi', 'bbbikegooglemap2.cgi'],
		    'bbbike-data.cgi',
		    'bbbike-snapshot.cgi',
		    'bbbike-test.cgi',
		    'mapserver_address.cgi',
		    'mapserver_comment.cgi',
		    'mapserver_setcoord.cgi',
		    'wapbbbike.cgi',
		   ) {
	my $fs_file;
	if (ref $cgidef eq 'ARRAY') {
	    $fs_file = $cgidef->[0];
	} else {
	    $fs_file = $cgidef;
	}
	$fs_file = catfile($root, 'cgi', $fs_file);
	for my $cgi (ref $cgidef eq 'ARRAY' ? @$cgidef : $cgidef) {
	    $app = mount "/bbbike/cgi/$cgi" => Plack::App::WrapCGI->new(
                script  => $fs_file,
	        execute => 1,
	    )->to_app;
	}
    }
    $app;

};

__END__

=head1 NAME

bbbike.psgi - Plack adapter for BBBike

=head1 SYNOPSIS

    plackup [options] bbbike.psgi

=head1 DESCRIPTION

If running under C<bbbike.psgi> with defaults, then BBBike is
available at L<http://localhost:5000/bbbike/cgi/bbbike.cgi>.

=head1 PREREQUISITES

Plack 0.9981 (at least 0.9941 does not work)

CGI::Emulate::PSGI

CGI::Compile

=head1 SEE ALSO

L<plackup>.

=head1 AUTHOR

Slaven Rezic

=cut
