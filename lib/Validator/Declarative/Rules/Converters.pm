#!/usr/bin/env perl
use strict;
use warnings;

package Validator::Declarative::Rules::Converters;

# ABSTRACT: Declarative parameters validation - default converter rules

require Validator::Declarative;

#
# INTERNALS
#

sub _assume_true {
    my ($input) = @_;
    return ( defined($input) && $input =~ /^\s*(0|no|n|false|f|off)\s*$/i ) ? 0 : 1;
}

sub _assume_false {
    my ($input) = @_;
    return ( defined($input) && $input =~ /^\s*(1|yes|y|true|t|on)\s*$/i ) ? 1 : 0;
}

sub _register_default_converters {
    Validator::Declarative::register_converter(
        assume_true  => \&_assume_true,
        assume_false => \&_assume_false,
    );
}

_register_default_converters();

=head1 DESCRIPTION

Internally used by Validator::Declarative.

=head1 METHODS

There is no public methods.

=head1 SEE ALSO

L<Validator::Declarative>

=head1 AUTHOR

Oleg Kostyuk, C<< <cub at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to Github L<https://github.com/cub-uanic/Validator-Declarative>

=cut

1;    # End of Validator::Declarative::Rules::Converters

