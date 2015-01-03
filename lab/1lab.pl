#!/usr/bin/perl
use strict;
use warnings;
print "Enter a path to file: ";
my $file = <>;
open( FILE, $file ) or die "File not found!!\n";
my $i_w = 0;
my $n_w = "";
while ( my $line = <FILE> ) {
    chomp($line);
    my @job = split / /, $line;
    foreach my $word (@job) {
        my $len = length($word);
        if ( $len > $i_w ) {
            $i_w = $len;
            $n_w = $word;
        }
    }
}
print "$n_w - $i_w letters\n";
