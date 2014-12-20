#!usr/bin/perl
use strict;
use warnings;

open (FILE, <STDIN>);
my @array = <FILE>;
chomp(@array);
my $string = join " ", @array;
my @job = split / /, "$string";
my $i_w = 0;
my $n_w = "";
foreach my $word (@job) {
        my $len = length ($word);
   if ($len > $i_w){
	$i_w = $len;
	$n_w = $word;
   }
}
print "$n_w - $i_w letters\n";
