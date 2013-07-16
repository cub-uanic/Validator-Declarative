#!/usr/bin/env perl

use strict;
use warnings;

package Test::Validator::Declarative;

use Exporter;
use Test::More;
use Test::Exception;
use Validator::Declarative;

our @ISA       = qw/ Exporter /;
our @EXPORT_OK = qw/ check_type_validation /;

sub check_type_validation {
    my %param = @_;
    plan tests => 4    # for lives_ok + is_deeply
        + 1 + scalar( @{ $param{bad} } );    # throws_ok + message for each error
    check_type_validation_pass( $param{type}, $param{good} );
    check_type_validation_fail( $param{type}, $param{bad} );
}

sub check_type_validation_pass {
    my ( $type, $values ) = @_;
    my @result;

    lives_ok {
        @result = Validator::Declarative::validate( [undef] => [ "param_${type}_0" => [ 'optional', $type ] ] );
    }
    "type 'optional,$type' lives on undef";
    is_deeply( \@result, [undef], "type 'optional,$type' returns expected result" );

    lives_ok {
        @result = Validator::Declarative::validate(
            $values => [ map { sprintf( "param_${type}_%02d", $_ ) => $type, } 1 .. scalar @$values ] );
    }
    "type $type lives on correct parameters";
    is_deeply( \@result, $values, "type $type returns expected result" );
}

sub check_type_validation_fail {
    my ( $type, $values ) = @_;

    throws_ok {
        Validator::Declarative::validate(
            $values => [ map { sprintf( "param_${type}_%02d", $_ ) => $type, } 1 .. scalar @$values ] );
    }
    'Error::Simple', "type $type throws on incorrect parameters";

    my $error_text = "$@";
    for ( 1 .. scalar @$values ) {
        my $param = sprintf( "param_${type}_%02d", $_ );
        my $regexp = sprintf( "%s: .* does not satisfy %s", $param, uc($type) );
        like $error_text, qr/^$regexp/m, "message about $param";
    }
}

1;

