#!/usr/bin/perl
use strict;
use warnings;

open( FILE, "/etc/services" );
my @array = <FILE>;
chomp(@array);
my %hash = ();
foreach my $line (@array) {

    # исключаем комментарии и пустые строки
    if ( ( $line !~ m/^#.*$/ ) and ( $line ne "" ) ) {
        $line =~ s/\/.*$//;
        chomp $line;

# формируем хэш, незадейств. сервису присваиваем нулевой порт
        my $serv = ( split " ", $line )[0];
        my $port = ( split " ", $line )[1];
        $port = 0 if ( not defined $port );
        $hash{$port} = $serv;
    }
}
if ( ( scalar(@ARGV) == 2 ) and ( $ARGV[0] < $ARGV[1] ) ) {
    for ( $ARGV[0] .. $ARGV[1] ) {

# перебираем диапазон совпадений аргументов и ключей
        print "$_  -  $hash{$_}" . "\n" if ( exists $hash{$_} );
    }
}
else {

# выводим результат только по первому аргументу
    print "$ARGV[0]  -  $hash{$ARGV[0]}" . "\n" if ( exists $hash{ $ARGV[0] } );
}
