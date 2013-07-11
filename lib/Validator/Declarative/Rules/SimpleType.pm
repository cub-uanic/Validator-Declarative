#!/usr/bin/env perl
use strict;
use warnings;

package Validator::Declarative::Rules::SimpleType;

# ABSTRACT: Declarative parameters validation - default simple types rules

use Error qw/ :try /;
require Validator::Declarative;

#
# INTERNALS
#

sub _register_default_simple_types {
    Validator::Declarative::register_type(
        ## generic types
        any      => \&Validator::Declarative::_validate_pass,    # \&validate_any,
        string   => \&Validator::Declarative::_validate_pass,    # \&validate_any,
        bool     => \&Validator::Declarative::_validate_pass,    # \&validate_bool,
        float    => \&Validator::Declarative::_validate_pass,    # \&validate_float,
        int      => \&Validator::Declarative::_validate_pass,    # \&validate_int,
        integer  => \&Validator::Declarative::_validate_pass,    # \&validate_int,
        positive => \&Validator::Declarative::_validate_pass,    # \&validate_positive,
        negative => \&Validator::Declarative::_validate_pass,    # \&validate_negative,
        id       => \&Validator::Declarative::_validate_pass,    # \&validate_id,
        email    => \&Validator::Declarative::_validate_pass,    # \&validate_email,
        ## datetime- like types
        year      => \&Validator::Declarative::_validate_pass,    # \&validate_year,
        week      => \&Validator::Declarative::_validate_pass,    # \&validate_week,
        month     => \&Validator::Declarative::_validate_pass,    # \&validate_month,
        day       => \&Validator::Declarative::_validate_pass,    # \&validate_day,
        ymd       => \&Validator::Declarative::_validate_pass,    # \&validate_ymd,
        mdy       => \&Validator::Declarative::_validate_pass,    # \&validate_mdy,
        time      => \&Validator::Declarative::_validate_pass,    # \&validate_time,
        hhmm      => \&Validator::Declarative::_validate_pass,    # \&validate_hhmm,
        timestamp => \&Validator::Declarative::_validate_pass,    # \&validate_float,
        msec      => \&Validator::Declarative::_validate_pass,    # \&validate_float,
    );
}

_register_default_simple_types();

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

1;    # End of Validator::Declarative::Rules::SimpleType

