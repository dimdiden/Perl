#!/usr/bin/perl
use strict;
use warnings;

open (FILE, "<","../words" ) or die "File not found\n";
print "Enter a word: ";
my $word = <STDIN>;
chomp ($word);
aaa: while (<FILE>){
chomp ($_);
if ($_ eq "$word"){
print "$. - $_\n";
last 'aaa';
}
}




#my @array = <FILE>;
#my @count = ();
#foreach my $word (@array) {
#	my $len = length ($word);
#if ($len >= 15){
#push(@count,$len);
#}
#}
#my $size = @count;
#print "Number of words in file: $size\n";

# if ($coment=~ /$word/i) {print "word found!"} bez registar

