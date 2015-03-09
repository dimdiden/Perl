#!/usr/bin/env perl 
use strict;
use warnings;

use Cell3;

for (1 .. 3) { Cell::new("Cell", int rand 20, int rand 40, 0); }
for (1 .. 3) { Cell::new("Cell2", int rand 20, int rand 40, 0); }

for (0 .. 40) {
    Cell::new("Cell3",0, $_, 1);
    Cell::new("Cell3",20, $_, 1);
}

for (0 .. 20) {
    Cell::new("Cell3",$_, 0, 1);
    Cell::new("Cell3",$_, 40, 1);
}

for (1 .. 20) {Cell::new("Cell3",10, $_, 1);}


for (;;) {
    Cell::move_all();
    Cell::print_all;
    select (undef,undef,undef,0.1);
}

