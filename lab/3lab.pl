#!/usr/bin/perl
use strict;
use warnings;

open (FILE, "/etc/services");
my @array = <FILE>;
chomp (@array);
my %hash = ();
foreach my $line (@array){
if (($line !~ m/^#.*$/) and ($line ne "")){ #исключаем комментарии и
       $line =~ s/\/.*$//;                  #пустые строки 
       chomp $line;
       my $serv = (split " ", $line)[0];  
       my $port = (split " ", $line)[1];  # формируем хэш, незадест.
       $port = 0 if (not defined $port);  # сервису присваем нулевой порт
       $hash{$port} = $serv;                  
} 
}
if ((scalar (@ARGV) == 2)and($ARGV[0]<$ARGV[1])){
for($ARGV[0]..$ARGV[1]){
       print "$_  -  $hash{$_}" . "\n" if (exists $hash{$_}); # перебирам диапазон совпадений
}                                                             # аргументов и ключей
}
else{
       print "$ARGV[0]  -  $hash{$ARGV[0]}" . "\n" if (exists $hash{$ARGV[0]}); #выводим только 
}                                                                               #по первому аргументу
