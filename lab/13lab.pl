#!/usr/bin/perl
use strict;
use warnings;

my @arr;
my $res;

$SIG{USR1} = sub {
    if ( @arr == 10 ) {
        print "Avarege number of process: $res\n";
    }
    else {
        print "Information available after 10 seconds!\n";
    }
};

$SIG{USR2} = sub {
    my @arr = `vmstat`;
    my $mem = ( split( " ", $arr[2] ) )[3];
    print "Free memory: $mem\n";
};

$SIG{INT} = sub { kill 'USR1', $$; exit; };

while (1) {
    my $sum;
    my $num = `ps aux --noheading | wc -l`;
    push @arr, $num if ( @arr <= 10 );
    if ( @arr > 10 ) {
        shift @arr;
        for (@arr) {
            $sum += $_;
            $res = $sum / @arr;
        }
    }
    sleep 1;
}

