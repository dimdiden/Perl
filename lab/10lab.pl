#!/usr/bin/perl
use strict;
use warnings;

use Mods::matrix;

die "Enter matrix parametrs correctly\n"
  if ( @ARGV != 3
    or int $ARGV[0] != $ARGV[0]
    or int $ARGV[1] != $ARGV[1]
    or int $ARGV[2] != $ARGV[2] );

my @mtrx = gen( $ARGV[0], $ARGV[1], $ARGV[2] );
my @res = min_max(@mtrx);
print_res( @mtrx, @res );

