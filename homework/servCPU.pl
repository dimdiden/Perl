#!/usr/bin/perl
use warnings;
use strict;
use utf8;
use Socket;
use Term::ANSIColor;
use Term::ReadKey;

my $port = shift @ARGV || 12321;
socket ( my $server, PF_INET, SOCK_STREAM, getprotobyname('tcp') ) or die "socket: $!\n";
my $packet_addr = sockaddr_in ($port, INADDR_ANY) or die "sockaddr_in: $!\n";
bind ($server, $packet_addr) or die "bind: $!\n";
listen ($server, SOMAXCONN) or die "bind: $!\n";

my ($w, $h) = GetTerminalSize();
$w = int(0.5 * $w);
$h = int(0.3 * $h);

my @mtrx;

while ( my $mega_addr = accept ( my $client, $server) ) { 
    select((select($server), $|=1)[0]);
    while (my $diff_usage = <$client>) {
        print "\033[2J";
        chomp $diff_usage;
        my @arr = shkala ($diff_usage);
        my $ref = \@arr;
        push @mtrx, $ref if (@mtrx < $h);
        if (@mtrx == $h) {
            shift @mtrx;
            push @mtrx, $ref;
        }
   
        print "CPUsage beta 0.1\n";
        print color('bold blue');
        foreach (@mtrx) {
            foreach (@$_) {
                print "$_"; 
            }   
            print "\n";
        }
        print color('reset');
        printf "CPU: %0.2f%%  \n", $diff_usage;   
     }
     close $client;
     exit;
}


sub shkala {
    my ($perc) = shift;
    my @arr;
    my $black = int (($perc/100)*$w); 
    my $white = $w - $black;
    push @arr, "\xe2\x97\xbc" for (1 .. $black);
    push @arr, "\xe2\x97\xbb" for (1 .. $white);
    return @arr;
}


