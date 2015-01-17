#!/usr/bin/perl
use strict;
use warnings;
my %hash;
my @max_res;
my @min_res;

#Блок открытия чтения содержимого файлов
#и инкрементации хэша по кол-ву найденных одинаковых элементов
while ( my $file = <> ) {
    my @arr = split '', $file;
    while ( my $symb = shift @arr ) {
        if ( $symb =~ /\n/ ) {
            chomp $symb;
            $symb = '\n';
        }
        $hash{$symb}++;
    }
}
my @array = ( sort { $hash{$b} <=> $hash{$a} } keys %hash );

#инициализация счетчиков и значений
my $max_cnt = 0;
my $max_nm;
my $min_nm;
my $min_cnt = $hash{ $array[0] };

#Блок нахождения большего и меньшего значения хэша
foreach my $elem (@array) {
    if ( $hash{$elem} > $max_cnt ) {
        $max_cnt = $hash{$elem};
    }
    if ( $hash{$elem} < $min_cnt ) {
        $min_cnt = $hash{$elem};
    }
}

#Блок проверки одинаковых значений максимума и минимума
foreach my $elem (@array) {
    if ( $hash{$elem} == $max_cnt ) {
        push @max_res, $elem;
    }
    if ( $hash{$elem} == $min_cnt ) {
        push @min_res, $elem;
    }
}

my $max_string = join ", ", @max_res;
my $min_string = join ", ", @min_res;

print "$max_string found $max_cnt times;\n";
print "$min_string found $min_cnt times;\n";

