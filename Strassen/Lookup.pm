# -*- perl -*-

#
# Author: Slaven Rezic
#
# Copyright (C) 2014,2016 Slaven Rezic. All rights reserved.
# This package is free software; you can redistribute it and/or
# modify it under the same terms as Perl itself.
#
# Mail: slaven@rezic.de
# WWW:  http://www.rezic.de/eserte/
#

package Strassen::Lookup;

use strict;
use vars qw($VERSION);
$VERSION = '0.03';

use Hash::Util qw(lock_keys);
use Unicode::Collate ();

use Strassen::Core ();

=head1 NAME

Strassen::Lookup - fast lookups in sorted bbd files

=head1 SYNOPSIS

    use Strassen::Lookup;
    my $s = Strassen::Lookup->new($bbdfile);
    my $rec = $s->search_first("First Avenue");
    $rec = $s->search_next

=head1 DESCRIPTION

B<Strassen::Lookup> provides fast lookups in sorted bbd files.
Currently this is implemented using the core perl module
L<Search::Dict>, which is doing binary searches in files.

=head2 CONSTRUCTOR

The C<new()> constructor takes the name of a sorted bbd file as
parameter. The bbd file may contain global directives (e.g. to specify
an encoding or coordinate system), but should not contain local
directives or comments.

=cut

sub new {
    my($class, $file, %opts) = @_;
    my $sub_separator = delete $opts{SubSeparator};
    die "Unhandled options: " . join(" ", %opts) if %opts;

    my @entries;
    if ($sub_separator) {
	push @entries, sprintf "%04x ; [.%04x]\n", (ord $sub_separator)x2;
    }
    if (0) { # TBD XXX
	push @entries, ("002D  ; [.020D.0020.0002.002D] # HYPHEN-MINUS, made significant\n");
    }
    my $collator = Unicode::Collate->new
	(
	 normalization => undef, # we need the index() method below, so normalization cannot be used
	 level         => 1,     # be case insensitive
	 ($sub_separator ? (entry => sprintf "%04x ; [.%04x]\n", (ord $sub_separator)x2) : ()),
	 entry         => join('', @entries),
	);

    my $self = {
		File => $file,
		Fh => undef,
		GlobalDirectives => undef,
		Offset => undef,
		CurrentSearchString => undef,
		CurrentIsDelimited => undef,
		Collator => $collator,
	       };
    bless $self, $class;
    lock_keys %$self;
    $self->_scan;
    $self;
}

sub _scan {
    my($self) = @_;
    my $file = $self->{File};
    my $s = Strassen->new($file, NoRead => 1);
    my $offset;
    $s->read_data(ReadOnlyGlobalDirectives => 1, ReturnSeekPosition => \$offset);
    $self->{Offset} = $offset;
    $self->{GlobalDirectives} = $s->get_global_directives;
}

=head2 LOW-LEVEL METHODS

=head3 look($search_string)

Calls L<Search::Dict/look> on the bbd file used in the constructor.
Returns the same as C<look>, that is, -1 on errors. The internal
filehandle is seeked to the nearest position to the search string.
Note that the search string does not have to be in the file at all.

=cut

sub look {
    my($self, $search_string, $delimited) = @_;
    require Tie::Handle::Offset;
    require Search::Dict;
    require Symbol;
    my $fh = Symbol::gensym();
    my $layer_string = $self->{GlobalDirectives}->{encoding} ? ":encoding($self->{GlobalDirectives}->{encoding}->[0])" : '';
    if ($^O eq 'MSWin32') {
	$layer_string = ':raw' . $layer_string;
    }
    tie *$fh, 'Tie::Handle::Offset', "<$layer_string", $self->{File}, { offset => $self->{Offset} }
	or die "Can't tie: $!";
    $self->{CurrentSearchString} = $search_string;
    $self->{Fh} = $fh;

    my @warnings;
    my $res = do {
	# cease possible warnings, see https://rt.cpan.org/Ticket/Display.html?id=97188
	local $SIG{__WARN__} = sub { push @warnings, grep { !/(?:utf8|UTF-8) .* does not map to Unicode/ } @_ };
	my $collator = $self->{Collator};
	Search::Dict::look($fh, $collator->getSortKey($search_string) . ($delimited ? "\t" : ''), { xfrm => sub { $collator->getSortKey($_[0]) } });
    };
    if (@warnings) {
	warn $_ for @warnings;
    }
    $res;
}

=head3 get_next()

Return the bbd record where the current seek position points to. See
L<Strassen::Core> for the elements of the returned array reference.

=cut

sub get_next {
    my($self) = @_;
    my $fh = $self->{Fh};
    chomp(my $line = <$fh>);
    my $rec = Strassen::parse($line);
    $rec;
}

=head2 HIGH-LEVEL METHODS

=head3 search_first($search_string, $delimited)

Search the given string and return a bbd record (see L<Strassen::Core>
for the format), or undef if the searched string could not be found.

If C<$delimited> is set to a true value, then the search string is
expected to be complete (i.e. not right truncated).

=cut

sub search_first {
    my($self, $search_string, $delimited) = @_;
    if ($self->look($search_string) != -1) {
	$self->{CurrentIsDelimited} = $delimited;
	$self->search_next($delimited);
    } else {
	undef;
    }
}

=head3 search_next()

Return the next bbd record with the previously given search string in
L</search_first>, or undef.

=cut

sub search_next {
    my($self) = @_;
    my $rec = $self->get_next;
    my $delimited = $self->{CurrentIsDelimited};
    my $collator = $self->{Collator};
    my $check;
    if ($delimited) {
	$check = $collator->eq($rec->[Strassen::NAME], $self->{CurrentSearchString});
    } else {
	$check = $collator->index($rec->[Strassen::NAME], $self->{CurrentSearchString}) == 0;
    }

    if ($check) {
	$rec;
    } else {
	undef;
    }
}

=head2 CREATION METHODS

=head3 convert_to_lookup($destpath)

For the bbd file as given in C<new()> create a bbd file which is
sorted and has no local directives or comments anymore. This file is
written to C<$destpath> and is suitable for use with this module.

=cut

sub convert_for_lookup {
    my($self, $dest) = @_;
    my @data;
    my $s = Strassen->new($self->{File}, UseLocalDirectives => 0);
    @{ $s->{Data} } = $self->{Collator}->sort(@{ $s->{Data} });
    $s->set_global_directive(strassen_lookup_suitable => 'yes');
    $s->set_global_directive(encoding => 'utf-8');
    $s->write($dest);
}

1;

__END__

=head1 AUTHOR

Slaven Rezic <srezic@cpan.org>

=head1 SEE ALSO

L<Search::Dict>, L<Strassen::Core>.

=cut
