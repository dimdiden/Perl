#!/usr/bin/perl
use strict;
use warnings;

my ( $file, $count, $outfile ) = @ARGV;
if (( not defined $file )
    || ( not defined $count )
    || ( scalar(@ARGV) > 3 )
    || ( scalar(@ARGV) < 2 )) {
    die "Use program correctly\n";
}
open( FILE, $file ) or die "File not found\n";
my @array = <FILE>;
chomp(@array);
my @print_array = ();
my $date = `date`;
foreach my $name (@array) {
    my @job = `ping -qnc $count -i 0.5 $name`;
    my $ip = ( split( " ", $job[0] ) )[2];
    my $loss = ( split( ",", $job[3] ) )[2];
    my $time = ( split( "/", $job[4] ) )[4];
    if ( defined($time) ) {
        push @print_array, "$name$ip: $loss - $time ms\n";
    }
    else {
        push @print_array, "$name$ip: $loss - Bad connection!\n";
    }
}
if ( defined $outfile ) {
    open( my $fh, '>', "$outfile" );
    print $fh "$date @print_array";
    close $fh;
    print "$date @print_array\n";
}
else {
    print "$date@print_array\n";
}

