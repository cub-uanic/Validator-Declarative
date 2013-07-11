#!/usr/bin/env perl
use strict;
use warnings;

package Validator::Declarative;

# ABSTRACT: Declarative parameters validation

use Module::Load;
use Error qw/ :try /;
use Data::Dumper;

my %registered_rules;

sub register_type       { _register_rules( type       => \@_ ) }
sub register_converter  { _register_rules( converter  => \@_ ) }
sub register_constraint { _register_rules( constraint => \@_ ) }

sub validate {

}

#
# INTERNALS
#

# stubs for successful/unsuccesfull validations
sub _validate_pass { my ($input) = @_; return $input; }
sub _validate_fail { throw Error::Simple('failed permanently'); }

sub _register_rules {
    my $kind  = shift;
    my $rules = shift;

    throw Error::Simple(qq|Can't register rule of kind <$kind>|)
      if $kind ne 'type'
      && $kind ne 'converter'
      && $kind ne 'constraint';

    $rules = {@$rules};

    while ( my ( $name, $code ) = each %$rules ) {

        throw Error::Simple(qq|Can't register rule without name|)
          unless defined($name) && length($name);

        throw Error::Simple(qq|Rule <$name> already registered|)
          if exists( $registered_rules{$name} );

        $registered_rules{$name} = {
            kind => $kind,
            code => $code,
        };
    }
}

sub _register_default_constraints {
    ## built-in constraints implemented inline
    $registered_rules{$_}++ for qw/ required optional not_empty /;
}

sub _load_base_rules {
    for my $plugin (qw/ SimpleType ParametrizedType /) {
        my $module = __PACKAGE__ . '::Rules::' . $plugin;
        load $module;
    }
}

_register_default_constraints();
_load_base_rules();

=head1 SYNOPSIS

    sub MakeSomethingCool {
        my $serialized_parameters;
        my ( $ace_id, $upm_id, $year, $week, $timestamp_ms ) = Validator::Declarative->validate(
            \@_ => [
                ace_id         => 'id',
                upm_id         => 'id',
                year           => 'year',
                week           => 'week',
                timestamp_ms   => [ 'to_msec', 'mdy', 'timestamp' ],
            ],
        );

        # here all parameters are validated
        # .......

    }

=head1 DESCRIPTION

=head1 METHODS

=head2 validate(\@params => \@rules)

=head2 register_type( $name => $code, ...)

=head2 register_converter( $name => $code, ...)

=head2 register_constraint( $name => $code, ...)

=head1 SEE ALSO

Inspired by Validator::LIVR - L<https://github.com/koorchik/Validator-LIVR>

=head1 AUTHOR

Oleg Kostyuk, C<< <cub at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to Github L<https://github.com/cub-uanic/Validator-Declarative>

=cut

1;    # End of Validator::Declarative

