#!/usr/bin/perl

use strict;
use warnings;
use 5.010;

my $RUNS = 5000;    # Number of random documents to create
my $DEEP = 5;       # Max depth level of embedded hashes
my $KEYS = 20;      # Number of keys per hash

use Test::More;

plan tests => $RUNS;

use lib '../lib'; #TODO
use BSON qw/encode decode/;

srand;

my $level = 0;
my @codex = (
    \&int32, \&int64, \&doub, \&str, \&hash, \&arr,  \&dt,   \&bin,
    \&re,    \&oid,   \&min,  \&max, \&ts,   \&null, \&bool, \&code
);

for my $count (1 .. $RUNS) {
    my $ar = hash($KEYS);
    my $bson = encode($ar);
    my $ar1 = decode($bson);
    is_deeply( $ar, $ar1 );
}

sub int32 {
    return int( rand( 2**32 / 2 ) ) * ( int(rand(2)) ? -1 : 1 );
}

sub int64 {
    return int( rand( 2**32 / 2 ) + 2**32 ) * ( int(rand(2)) ? -1 : 1 );
}

sub doub {
    return rand( 2**64 ) * ( int(rand(2)) ? -1 : 1 );
}

sub str {
    my $len = int( rand(255) ) + 1;
    my @a   = map {
        ( 'a' .. 'z', 'A' .. 'Z', '0' .. '9', ' ' )[ rand( 26 + 26 + 10 + 1 ) ]
    } 1 .. $len;
    return join '', @a;
}

sub dt  { BSON::Time->new( abs( int32() ) ) }
sub bin { BSON::Binary->new( str(), int( rand(5) ) ) }
sub re  { qr/\w\a+\s$/i }

sub oid { BSON::ObjectId->new }
sub min { BSON::MinKey->new }
sub max { BSON::MaxKey->new }

sub ts { BSON::Timestamp->new( abs( int32() ), abs( int32() ) ) }

sub null { undef }
sub bool { BSON::Bool->new( int( rand(2) ) ) }
sub code { BSON::Code->new( str(), hash() ) }

sub arr { 
    my $len = int( rand(20) ) + 1;
    my @a = ();
    for ( 1 .. $len ) {
        my $what = $codex[ int(rand(@codex)) ];
        push @a, $what->();
    }
    return \@a;
}

sub hash {
    my $count = shift || $KEYS;
    return {} if $level++ >= $DEEP;
    my $hash = {};
    for my $idx ( 1 .. $count ) {
        my $what = $codex[ int(rand(@codex)) ];
        $hash->{"key_$idx"} = $what->();
    }
    $level--;
    return $hash;
}

