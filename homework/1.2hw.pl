#!usr/bin/perl
use strict;
use warnings;

open (FILE, "<","/home/words" ) or die "File not found\n";
my @array = <FILE>;
chomp (@array);
my @count = ();
foreach my $word (@array){
if ($word eq reverse($word) && length($word) > 2){
	push(@count,$word);
}
}

my $size = @count;
print "Number of polyndrom word in file: $size\n";


