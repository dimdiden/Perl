#!/usr/bin/perl
use strict;
use warnings;

open( FILE, "<", "../words" ) or die "File not found\n";
my @array = <FILE>;
my @count = ();
foreach my $word (@array) {
    my $len = length($word);
    if ( $len >= 15 ) {
        push( @count, $len );
    }
}
my $size = @count;
print "Number of words in file: $size\n";

