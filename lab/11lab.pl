#!/usr/bin/perl
use strict;
use warnings;
print "Enter a Date: ";
my $file = <>;
my $jan  = '(?:01|Jan)(?:-|\s)(?:[0-2][1-9]|3[01])';
my $feb  = '(?:02|Feb)(?:-|\s)(?:[0-2][1-9])';
my $mar  = '(?:03|Mar)(?:-|\s)(?:[0-2][1-9]|3[01])';
my $apr  = '(?:04|Apr)(?:-|\s)(?:[0-2][1-9]|30)';
my $may  = '(?:05|May)(?:-|\s)(?:[0-2][1-9]|3[01])';
my $jun  = '(?:06|Jun)(?:-|\s)(?:[0-2][1-9]|30)';
my $jul  = '(?:07|Jul)(?:-|\s)(?:[0-2][1-9]|3[01])';
my $aug  = '(?:08|Aug)(?:-|\s)(?:[0-2][1-9]|3[01])';
my $sept = '(?:09|Sept)(?:-|\s)(?:[0-2][1-9]|30)';
my $oct  = '(?:10|Oct)(?:-|\s)(?:[0-2][1-9]|3[01])';
my $nov  = '(?:11|Nov)(?:-|\s)(?:[0-2][1-9]|30)';
my $dec  = '(?:12|Dec)(?:-|\s)(?:[0-2][1-9]|3[01])';

unless ( $file =~
m/^(?:$jan|$feb|$mar|$apr|$may|$jun|$jul|$aug|$sept|$oct|$nov|$dec)(?:-|\s)(?:19[0-9]{2}|2[0-9]{3})$/i ) {
    print "Wrong Data!";
}
else {
    print "Good Data!";
}

