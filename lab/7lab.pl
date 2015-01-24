#!/usr/bin/perl
use strict;
use warnings;

sub gen ($$$) {
    my ( $X, $Y, $P ) = @_;
    my @matrix;
    for (my $x=0; $x < $X; $x++) {
        for (my $y=0; $y < $Y; $y++) {
            $matrix[$x]->[$y] = (rand($P));
        }
    }
    return @matrix;
}

sub min_max (\@) {
    my ( $matrix ) = @_;
    my $max_cnt = 0;
    my $min_cnt = ${$matrix}[0]->[0];
    my $avr_cnt = ${$matrix}[0]->[0];
    my $sum;
    foreach my $line (@{$matrix}) {
        foreach my $column (@{$line}) {
            $sum += $column;
        }     
    }
    my $avr =  $sum/( @{$matrix} * @{${$matrix}[0]} );
    my $avr_abs_sum = abs ( $avr - ${$matrix}[0]->[0] );

    foreach my $line ( @{$matrix} ) {
        foreach my $column ( @{$line} ) {
            $max_cnt = $column if ( $column > $max_cnt );
            $min_cnt = $column if ( $column < $min_cnt );
            if ( abs ( $avr - $column ) < $avr_abs_sum ) {
                $avr_abs_sum = abs ( $avr - $column );
                $avr_cnt = $column;
            }
        }
    }
    my $result = "Max num is $max_cnt" . "\n" .  "Average num is $avr_cnt" . "\n" . "Min num is $min_cnt" . "\n";
    return $result;
}

sub print_res (\@$){
    my ($matrix, $result) = @_;
    foreach my $line (@{$matrix}) {
        foreach my $column (@{$line}){
            printf "%.3f  ", "$column";
        }
    print "\n";
    }
    print $result;
}

my @mtrx = gen ( 3, 3, 10 );
my $res = min_max (@mtrx);

print_res ( @mtrx, $res );
