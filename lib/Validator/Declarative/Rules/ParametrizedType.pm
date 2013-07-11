#!/usr/bin/env perl
use strict;
use warnings;

package Validator::Declarative::Rules::ParametrizedType;

# ABSTRACT: Declarative parameters validation - default simple types rules

use Error qw/ :try /;
require Validator::Declarative;

#
# INTERNALS
#

sub _register_default_parametrized_types {
    Validator::Declarative::register_type(
        ## simple parametrized types
        min    => \&Validator::Declarative::_validate_pass,    # \&validate_min,
        max    => \&Validator::Declarative::_validate_pass,    # \&validate_max,
        ref    => \&Validator::Declarative::_validate_pass,    # \&validate_ref,
        class  => \&Validator::Declarative::_validate_pass,    # \&validate_class,
        enum   => \&Validator::Declarative::_validate_pass,    # \&validate_any_of,
        any_of => \&Validator::Declarative::_validate_pass,    # \&validate_any_of,

        ## complex/recursive parametrized types
        list_of => \&Validator::Declarative::_validate_pass,    # undef,
        hash_of => \&Validator::Declarative::_validate_pass,    # undef,
        hash    => \&Validator::Declarative::_validate_pass,    # undef,
        date    => \&Validator::Declarative::_validate_pass,    # undef,
    );
}

_register_default_parametrized_types();

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

1;    # End of Validator::Declarative::Rules::ParametrizedType

