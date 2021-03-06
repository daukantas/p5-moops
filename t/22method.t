=pod

=encoding utf-8

=head1 PURPOSE

Check that the C<method> keyword works.

=head1 AUTHOR

Toby Inkster E<lt>tobyink@cpan.orgE<gt>.

=head1 COPYRIGHT AND LICENCE

This software is copyright (c) 2013-2014 by Toby Inkster.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=cut

use strict;
use warnings;
use Test::More;
use Test::Fatal;

use Moops;

class Foo {
	method foo (Int $a) { return $a * 2 }
}

role Bar {
	method bar (Int $a) { return $a * 2 }
}

is(Foo->foo(21), 42);
is(Bar->bar(21), 42);

like($_, qr{Undef did not pass type constraint "Int"}) for (
	exception { Foo->foo(undef) },
	exception { Bar->bar(undef) },
);

ok not eval q[ use Moops; namespace Baz { method baz (Int $a) { return $a * 2 } }; 1 ];
ok not 'Baz'->can('baz');

done_testing;
