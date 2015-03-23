#!/usr/bin/perl
use strict;
use warnings;

my $regex = shift @ARGV or die "Use program correctly\n";
my @final;
my (@read, $write);

for ( my $i = 0 ; $i < @ARGV ; $i++ ) {
    my $pid;
    pipe ($read[$i], $write);

    unless ( defined( $pid = fork ) ) {
        die "cannot fork process: $!";
    }
    
    unless ($pid) {
        close $read[$i];
        find ($ARGV[$i], $write);
        exit;
    }
    close $write;
    my $read = $read[$i];
    push @final, <$read>;
}

print $_ for @final;



sub find {
    my ( $file_in, $file_out ) = @_;
    my $final;
    if ( -e $file_in ) {
        open( my $fh, "<", "$file_in" );
        $final = "File $file_in:\n";
        my $count;
        while ( my $line = <$fh> ) {
            $count++;
            if ( $line =~ m/$regex/ ) {
                my @res;
                foreach ( ( split /\s+/, $line ) ) {
                    push @res, $_ if ( $_ =~ m/$regex/ );
                }
                if (@res) {
                    my $res = join( ', ', @res );
                    $final .= "Line $count: $res\n";
                }
            }
        }
    }
    else {
        die "$file_in don\'t exist\n";
    }
    print $file_out "Given regexp:$regex\n$final\n";
}


