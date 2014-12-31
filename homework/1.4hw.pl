#!/usr/bin/perl
use strict;
use warnings;
# Изначально была идея разнести номера и символы по разным массивам и потом циклично обратиться к их элементам
# К сожалению сам реализовать от начала и до конца не смог - пользовался помощью форумов
# Поэтому все равно что там за оценка будет. Главное немного "ссылки" подтянул
sub save_substring;
open( FILE, "<", "../words" ) or die "File not found\n";
my @main_array = <FILE>;
chomp(@main_array);
my $string =
'97419 92425 45424 22860 50690 25188 49846 26422 44857 19374 51598 54896 47302 50629 16484 69869, 90290 46046 22470. 50690 25188 89881 50629, "52079 97825 39434 63729 49700 52242 98947 26422." 65700 32740 90276 55321 56167 90290 27842 92425 45424 40688. 84224 72297 91160 22155 18780 65831 18908 43181 45424, 92425 45424 59720 50690 97004 45838 65907 51435 91160 90290 64424 98103 16484 63751 79139. 33905 50234 50629 59715 65907 91772 22862 90262 90290 64424. 18908 38100 50690 25188 49767 91160 39434 50690 49700? 55376 56167 35694 65901 97444 66123 65004 92425 45424 26422 47079 16484 69869 54896 50690 79139.';
my %substrings = (
    number => { start => 0, length => 0 },
    string => { start => 0, length => 0 }
);
# Этот хэщ хранит два счетчика и начальные позиции в строке для символов и номеров
my ( @strings, @numbers );
# Это массивы в которые заносятся цифры и символы
my $string_length = length $string;

for ( my $pos = 0 ; $pos < $string_length ; $pos++ ) {
    my $char = substr( $string, $pos, 1 );
    if ( $char ge '0' and $char le '9' ) {
        $substrings{number}{length}++ or $substrings{number}{start} = $pos;
        save_substring( \@strings, $string, $substrings{string} );
    }
    else {
        $substrings{string}{length}++ or $substrings{string}{start} = $pos;
        save_substring( \@numbers, $string, $substrings{number} );
    }
}
# цикл перебирает каждый элемент нашего щифра.Если элемент цифра - инкрементируется счетчик симврлов.
# Если счетчик изначально имеет значение 0 то текуший элемент цикла - начальная позиция.
# Функция save_substring сохраняет элементы по массивам @strings и @numbers.
save_substring( \@strings, $string, $substrings{string} );
save_substring( \@numbers, $string, $substrings{number} );
# после прохождения цикла останется один элемент (либо символы либо цифры)
# поэтому сохраняем его уже посде цикла
sub save_substring {
    my ( $array, $string, $substring ) = @_;
    if ( $substring->{length} ) {
        push(
            @{$array},
            substr( $string, $substring->{start}, $substring->{length} )
        );
        $substring->{length} = 0;
    }

    # return;
}
# функция сохранения элементов в рабочие массивы. После сохранения обнуляет счетчик.
for ( my $i = 0 ; $i < scalar(@numbers) ; $i++ ) {
    print "$main_array[($numbers[$i]-1)]$strings[$i]";
}
# заключительный цикл который дещифрует наше задание
