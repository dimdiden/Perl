#!/usr/bin/perl
use strict;
use warnings;

open( FILE, "<", "../words" ) or die "File not found\n";
print "Enter a word: ";
my $word = <STDIN>;
chomp($word);
aaa: while (<FILE>) {
    chomp($_);
    if ( $_ eq "$word" ) {
        print "$. - $_\n";
        last 'aaa';
    }
}

