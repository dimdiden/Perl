#!/usr/bin/perl
use strict;
use warnings;

my ( $arg_file, $arg_count, $arg_outfile ) = @ARGV;
my @array_hosts;
my @array_result;

if (   ( scalar(@ARGV) > 3 )
    || ( scalar(@ARGV) < 2 )
    || ( $arg_count =~ /[^0-9]/ ) )
{
    die "Bad arguments! Use program correctly\n";
}

sub read_hosts (\@$) {
    my ( $arr, $file ) = @_;
    open( FILE, $file ) or die "File $file not found!\n";
    @{$arr} = <FILE>;
    chomp( @{$arr} );
}

sub check (\@$\@) {
    my ( $arr, $count, $result ) = @_;
    foreach my $host ( @{$arr} ) {
        my @job  = `ping -qnc $count -i 0.5 $host`;
        my $ip   = ( split( " ", $job[0] ) )[2];
        my $loss = ( split( ",", $job[3] ) )[2];
        my $time = ( split( "/", $job[4] ) )[4];
        if ( defined($time) ) {
            push @{$result}, "$host$ip: $loss - $time ms\n";
        }
        else {
            push @{$result}, "$host$ip: $loss - Bad connection!\n";
        }
    }
}

sub print_res (\@$) {
    my ( $arr, $file ) = @_;
    my $date = `date`;
    if ( defined $file ) {
        open( my $fh, '>', "$file" );
        print $fh "$date @{$arr}";
        close $fh;
        print "$date @{$arr}\n";
    }
    else {
        print "$date @{$arr}\n";

    }
}

read_hosts( @array_hosts, $arg_file );
check( @array_hosts, $arg_count, @array_result );
print_res( @array_result, $arg_outfile );





#my ( $arg ) = @ARGV;
#my @array;
#sub read_hosts ($) {
#( my $file ) = @_;
#open( FILE, $file ) or die "File not found\n";
#my @array_hosts = <FILE>;
#chomp ( @array_hosts );
#return @array_hosts;
#}

#@array = read_hosts ( $arg );
#print "@array\n";

