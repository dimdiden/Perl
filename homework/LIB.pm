package LIB;

my @obj;
my @del;

sub new {
    my ( $name, $author, $section, $shelf, $on_hands ) = @_;
    my $self = {};
    bless( $self, $name );
    $self->{title}    = $name;
    $self->{author}   = $author;
    $self->{section}  = $section;
    $self->{shelf}    = $shelf;
    $self->{on_hands} = $on_hands;
    push @obj, $self;
    return $self;
}

sub load_file {
    my ($file) = @_;
    my ( $title, $author, $section, $shelf, $on_hands );
    open( my $fh, "<", $file ) or die "File $file not found\n";
    while ( my $line = <$fh> ) {
        chomp $line;
        next if $line eq "";
        $title   = ( split( ": ", $line ) )[1] if ( $line =~ m/^Title:/ );
        $author  = ( split( ": ", $line ) )[1] if ( $line =~ m/^Author:/ );
        $section = ( split( ": ", $line ) )[1] if ( $line =~ m/^Section:/ );
        $shelf   = ( split( ": ", $line ) )[1] if ( $line =~ m/^Shelf:/ );
        if ( $line =~ m/^On Hands:/ ) {
            $on_hands = ( split( ": ", $line ) )[1];
            $on_hands = ( defined($on_hands) ? $on_hands : "" );
            new( "$title", $author, $section, $shelf, $on_hands );
        }
    }
    print "\nFile $file successful loaded!\n\n";
}

sub add_book {
    print "Enter a title of the book: ";
    chomp( my $title = <STDIN> );
    print "Enter an author: ";
    chomp( my $author = <STDIN> );
    print "Enter a section: ";
    chomp( my $section = <STDIN> );
    print "Enter a shelf: ";
    chomp( my $shelf = <STDIN> );
    print "Enter on_hands: ";
    chomp( my $on_hands = <STDIN> );
    new( "$title", $author, $section, $shelf, $on_hands );
    print "\nThe book was added succesful!\n\n";
}

sub search {
    if ( @_ == 1 ) {
        for my $elem (@obj) {
            print_obj($elem)
              if ( $elem->{title} =~ m/$_[0]/
                or $elem->{author}   =~ m/$_[0]/
                or $elem->{section}  =~ m/$_[0]/
                or $elem->{shelf}    =~ m/$_[0]/
                or $elem->{on_hands} =~ m/$_[0]/ );
        }
    }
    if ( @_ == 2 ) {
        for my $elem (@obj) {
            print_obj($elem)
              if ( $_[1] eq "title" and $elem->{title} =~ m/$_[0]/ );
            print_obj($elem)
              if ( $_[1] eq "author" and $elem->{author} =~ m/$_[0]/ );
            print_obj($elem)
              if ( $_[1] eq "section" and $elem->{section} =~ m/$_[0]/ );
            print_obj($elem)
              if ( $_[1] eq "shelf" and $elem->{shelf} =~ m/$_[0]/ );
            print_obj($elem)
              if ( $_[1] eq "on_hand" and $elem->{on_hand} =~ m/$_[0]/ );
        }
    }
}

sub print_obj {
    my $self = shift;
    print
"Title:$self->{title}\nAuthor:$self->{author}\nSection:$self->{section}\nShelf:$self->{shelf}\nOn hands:$self->{on_hands}\n";
    print "===================================\n";
}

sub printall {
    print_obj($_) for (@obj);
}

sub move_to_trash {
    for my $elem (@obj) {
        push @del, $elem
          if ( $elem->{title} =~ m/$_[0]/
            or $elem->{author}   =~ m/$_[0]/
            or $elem->{section}  =~ m/$_[0]/
            or $elem->{shelf}    =~ m/$_[0]/
            or $elem->{on_hands} =~ m/$_[0]/ );
    }
    print "\nRemove:\n";
    print_obj($_) for (@del);
    while (1) {
        last if ( @del == 0 );
        print
          "DO YOU WISH TO DELETE BOOK $del[0]->{title}?\nTypes: yY, nN or A\n";
        chomp( my $var = <STDIN> );
        print "\nBad command!\n\n" if ( $var !~ m/[yYnNA]/ );
        shift @del if ( $var =~ m/[nN]/ );
        if ( $var =~ m/[yY]/ ) {
            my $elem = shift @del;
            for ( my $i = 0 ; $i < @obj ; $i++ ) {
                if ( $obj[$i] eq $elem ) {
                    splice @obj, $i, 1;
                }
            }
        }
        if ( $var eq "A" ) {
            while ( my $elem = shift(@del) ) {
                for ( my $i = 0 ; $i < @obj ; $i++ ) {
                    if ( $obj[$i] eq $elem ) {
                        splice @obj, $i, 1;
                    }
                }
            }
        }
    }
}
1;
