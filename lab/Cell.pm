package Cell;

use feature "switch";

our @obj;
my ( $glob_x, $glob_y ) = ( 20, 40 );

sub new {
    my $name = shift;
    my ( $x, $y, $build ) = @_;
    my $self = {};
    bless( $self, $name );
    $self->{x}     = $x;
    $self->{y}     = $y;
    $self->{build} = $build;
    $self->{dir}   = int rand 8;
    push @obj, $self;
    return $self;
}

sub print_point {
    my $self = shift;
    print "$self->{x} - $self->{y}\n";
}

sub print_all_points {
    for (@obj) {
        $_->print_point;
    }
}

sub check_cell {
    my $self = shift;
    my ( $x, $y ) = @_;
    return 1
      unless ( ( $x < $glob_x )
        and ( $x > 0 )
        and ( $y < $glob_y )
        and ( $y > 0 ) );
    for (@obj) {
        if ( ( $x == $_->{x} ) and ( $y == $_->{y} ) ) { return 1 }
    }
    return 0;
}

sub print_all {
    my $matrix;

    for my $i ( 0 .. $glob_x ) {
        for my $j ( 0 .. $glob_y ) {
            $matrix->[$i][$j] = ".";
        }
    }

    for (@obj) {
        if ( $_->{build} ) {
            $matrix->[ $_->{x} ][ $_->{y} ] = 'o';
        }
        else {
            $matrix->[ $_->{x} ][ $_->{y} ] = 'x';
        }
    }

    print "\033[2J";

    for (@$matrix) {
        for (@$_) {
            print "$_";
        }
        print "\n";
    }
}

sub move {
    my $self = shift;
    my $dir  = int rand 8;
    my ( $new_x, $new_y );
    given ($dir) {

        when (0) { $new_x = $self->{x} + 1; $new_y = $self->{y}; }
        when (1) { $new_x = $self->{x} + 1; $new_y = $self->{y} + 1; }
        when (2) { $new_x = $self->{x} + 1; $new_y = $self->{y} - 1; }
        when (3) { $new_x = $self->{x} - 1; $new_y = $self->{y}; }
        when (4) { $new_x = $self->{x} - 1; $new_y = $self->{y} + 1; }
        when (5) { $new_x = $self->{x} - 1; $new_y = $self->{y} - 1; }
        when (6) { $new_x = $self->{x};     $new_y = $self->{y} + 1; }
        when (7) { $new_x = $self->{x};     $new_y = $self->{y} - 1; }

    }
    unless ( $self->check_cell( $new_x, $new_y ) ) {
        $self->{x} = $new_x;
        $self->{y} = $new_y;
    }
}

sub move_all {
    for (@obj) {
        $_->move();
    }
}

1;
