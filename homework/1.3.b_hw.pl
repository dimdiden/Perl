#!/usr/bin/perl
use strict;
use warnings;

open (FILE, "<","../words" ) or die "File not found\n";
print "Enter a word: ";
my $opt = <STDIN>;
chomp ($opt);
my @array = <FILE>;
chomp (@array);
my $i = -1;
foreach my $word (@array){
	$i = $i+1;
if ( $word eq "$opt"){
	my $real_i = $i+1;
	print "$real_i - $array[$i]\n";
	last;
}
}

