package Mods::matrix;

require Exporter;
our @ISA    = qw(Exporter);
our @EXPORT = qw(gen min_max print_res);

use strict;
use warnings;

sub gen ($$$) {
    my ( $X, $Y, $P ) = @_;
    my @matrix;
    for ( my $x = 0 ; $x < $X ; $x++ ) {
        for ( my $y = 0 ; $y < $Y ; $y++ ) {
            $matrix[$x]->[$y] = ( rand($P) );
        }
    }
    return @matrix;
}

sub min_max (\@) {
    my ($matrix) = @_;
    my $max_cnt  = 0;
    my $min_cnt  = $matrix->[0][0];
    my $avr_cnt  = $matrix->[0][0];
    my $sum;
    foreach my $line ( @{$matrix} ) {
        foreach my $column ( @{$line} ) {
            $sum += $column;
            $max_cnt = $column if ( $column > $max_cnt );
            $min_cnt = $column if ( $column < $min_cnt );
        }
    }
    my $avr = $sum / ( @{$matrix} * @{ ${$matrix}[0] } );
    my @result =
      ( "Max num is $max_cnt", "Average is $avr", "Min num is $min_cnt" );
    return @result;
}

sub print_res (\@\@) {
    my ( $matrix, $result ) = @_;
    foreach my $line ( @{$matrix} ) {
        foreach my $column ( @{$line} ) {
            printf "%.3f ", "$column";
        }
        print "\n";
    }
    foreach my $line ( @{$result} ) {
        print "$line\n";
    }
}

