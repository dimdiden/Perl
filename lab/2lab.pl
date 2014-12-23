#!/usr/bin/perl
use strict;
use warnings;

my @array = ();

while (my $file = <>){
    chomp $file;
    $file = join ' ', (my @temp_arr = split '', $file);
    push (@array, "$file");
}
my $string = join ' \n ', @array; # склеиваем переносы символом \n 
my @job = split ' ', $string;     # строку в которой каждый символ и \n
                                  # разделен пробелом режем на массив  
my %hash = ();
my @srt_array = ();

foreach my $symb (@job){         # каждому одинаковому ключу в хэше
      $hash{$symb}++;            # плюсуем единицу
}
foreach my $symb (sort {$hash{$b} <=> $hash{$a}} keys %hash){ # сорт по знач.
       push (@srt_array, "$symb - found $hash{$symb} times"); # заносим в 
}                                                             # массив симв. - кол.
print "Max is: $srt_array[0]\nMin is: $srt_array[-1]\n";


