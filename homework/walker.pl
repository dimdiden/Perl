#!/usr/bin/perl
use strict;
use warnings;
use File::Basename;
use Getopt::Long qw(GetOptions);

my $pattrn;
my $size;
my $tree;
my $path;
GetOptions(
    'path=s' => \$path,
    'find=s' => \$pattrn,
    'size'   => \$size,
    'tree'   => \$tree
  )
  or die
"Usage: $0 --path PATH_TO_FILE or/and --find PATTRN or/and --size or/and --tree\n";

my @arr  = ();
my @pref = ();

#MAIN
#Главный код
#Проверяет заданный путь, обрезает слэш в конце (необходимо для дальнейшей логики)
#Выполняется рекурсия и набивается @arr с которым потом и идет работа для tree
#Выполняется набивка @pref который содержит префиксы ко всем элементам @arr для tree

if ($path) {
    $path =~ s/(^.*)(\/)$/$1/ if ( $path ne "/" );
}
else {
    $path = '.';
}
if ($tree) {
    recurs($path);
    @arr = sort { lc($a) cmp lc($b) } @arr;
    prefix( \@arr );
    print "$arr[0]\n";
    for ( my $i = 1 ; $i < @arr ; $i++ ) {
        my $name = basename( $arr[$i] );
        if ( lonely( $arr[$i] ) ) {
            print "$pref[$i]└──$name\n";
        }
        else {
            print "$pref[$i]├──$name\n";
        }
    }
}
print "Dirrectory size:" . total_size($path) . "\n" if ($size);
find($path) if ($pattrn);

#TOTAL_SIZE
#Выводит размер папки рекурсивно в байтах
#На вход подаем путь к папке

sub total_size {
    my ($top) = @_;
    my $total = -s $top;
    return $total if -f $top;
    opendir my $dh, $top or die;
    while ( my $sub = readdir $dh ) {
        next if $sub eq '.' or $sub eq '..';
        $total += total_size("$top/$sub");
    }
    closedir $dh;
    return $total;
}

#FIND
#Ищет совпадения $pattrn рекурсивно
#На вход подаем путь к папке

sub find {
    my ($top) = @_;
    return if not -d $top;
    opendir my $dh, $top or die;
    while ( my $sub = readdir $dh ) {
        next if $sub eq '.' or $sub eq '..';
        if ( $sub =~ m/$pattrn/ ) {
            print "File matched: $sub\n";
        }
        find("$top/$sub");
    }
    closedir $dh;
}

#RECURS
#Набивка @arr для последующей обработки следующими сабинами
#На вход подаем путь к папке

sub recurs {
    my ($elem) = shift;
    push @arr, "$elem";
    return if not -d $elem;
    opendir my $dh, $elem or die;
    while ( my $sub = readdir $dh ) {
        next if $sub eq '.' or $sub eq '..';
        recurs("$elem/$sub");
    }
    closedir $dh;
}

#LEVEL
#Находит уровень вложенности элемента по кол-ву слэшей

sub level {
    my ($elem) = @_;
    $elem =~ s/($path)(.*)/$2/;
    my $level = () = $elem =~ m/\//g;
    --$level;
    return $level;
}

#LONELY
#Выводит 1 если элемент "последний" в папке

sub lonely {
    my ($elem) = @_;
    my $name   = basename($elem);
    my @arr    = ();
    my $res;
    my $levelup = $elem;
    $levelup =~ s/(.*)(\/.*)/$1/;
    return 0 if not -d $levelup;
    opendir my $dh, $levelup or die;

    while ( my $sub = readdir $dh ) {
        next if $sub eq '.' or $sub eq '..';
        push @arr, "$sub";
    }
    @arr = sort { lc($a) cmp lc($b) } @arr;
    if ( $name eq $arr[-1] ) {
        $res = 1;
    }
    else {
        $res = 0;
    }
    closedir $dh;
    return $res;
}

#BACK_LEVEL
#Находит ближайший предыдущий индекс элемента @arr который имеет уровень вложенности такой же как и текущий

sub back_level {
    my ($index) = @_;
    my $res;
    for ( my $i = $index - 1 ; $i > 0 ; $i-- ) {
        if ( level( $arr[$index] ) == level( $arr[$i] ) ) {
            $res = $i;
            last;
        }
    }
    return $res;
}

#PREFIX
#Если уровень вложенности нулевой то префикса нет
#Если ур.вл. больше предыдущего и предыдущий не последний - префикс "|  " конкантинируется к предущему префиксу
#Если ур.вл. больше предыдущего и предыдущий последний - префикс "   " конкантинируется к предущему префиксу
#Если ур.вл. равен предыдущему - префикс равен предущему префиксу
#Если ур.вл. меньше предыдущего - префикс равен префиксу ближайшего предыдущего элемента с таким же ур.вл. что и у текущего

sub prefix {
    my ($arr) = shift;
    $pref[0] = "";
    for ( my $i = 1 ; $i < @$arr ; $i++ ) {
        $pref[$i] = "" if ( level( $arr[$i] ) == 0 );
        $pref[$i] = "$pref[$i-1]│  "
          if (  level( $arr[$i] ) != 0
            and level( $arr[$i] ) > level( $arr[ $i - 1 ] )
            and !lonely( $arr[ $i - 1 ] ) );
        $pref[$i] = "$pref[$i-1]   "
          if (  level( $arr[$i] ) != 0
            and level( $arr[$i] ) > level( $arr[ $i - 1 ] )
            and lonely( $arr[ $i - 1 ] ) );
        $pref[$i] = $pref[ $i - 1 ]
          if (  level( $arr[$i] ) != 0
            and level( $arr[$i] ) == level( $arr[ $i - 1 ] ) );
        $pref[$i] = $pref[ back_level($i) ]
          if (  level( $arr[$i] ) != 0
            and level( $arr[$i] ) < level( $arr[ $i - 1 ] ) );
    }
}
