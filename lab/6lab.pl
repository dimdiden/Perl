#!/usr/bin/perl
use strict;
use warnings;

my @array1 = qw/lala lolol ililil/;
my @array2 = qw/rr ttt yyyy lalalal/;
my @array3 = qw/tt ip54huhai laptelnik/;

sub find {
    my @res_list;
    my $arr;
    while ( defined( $arr = shift @_ ) ) {
        my $i = 0;
        my $y;
        my $word;
        while ( defined( $word = shift @{$arr} ) ) {
            my $len = length $word;
            if ( $len > $i ) {
                $i = $len;
                $y = $word;
            }
        }
        push @res_list, $y;
    }
    return @res_list;
}

my @result = find( \@array1, \@array2, \@array3 );
print "@result\n";

## Вариант с foreach

#sub find {
#    my @res_list;
#    foreach my $arr (@_) {
#        my $i = 0;
#        my $y;
#        foreach my $word ( @{$arr} ) {
#            my $len = length $word;
#            if ( $len > $i ) {
#                $i = $len;
#                $y = $word;
#            }
#        }
#        push @res_list, $y;
#    }
#    return @res_list;
#}

#my @result = find( \@array1, \@array2, \@array3 );
#print "@result\n";

