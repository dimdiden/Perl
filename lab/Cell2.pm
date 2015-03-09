package Cell2;

use strict;
use parent ("Cell");
use feature "switch";

sub move {
    my $self = shift;
    my $dir  = $self->{dir};
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
    else { $self->{dir} = int rand 8; }
}

1;
