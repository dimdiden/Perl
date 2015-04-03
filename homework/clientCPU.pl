#!/usr/bin/perl -w
use strict;
use Socket;
use List::Util qw(sum);

my $host_or_IP =shift @ARGV || 'localhost';
my $port = shift @ARGV || 12321;

socket ( my $remote, PF_INET, SOCK_STREAM, getprotobyname('tcp') ) or die "socket: $!\n";

my $mini_addr = inet_aton ( $host_or_IP ) or die "inet aton: $!\n";
my $packed_addr = sockaddr_in ($port, $mini_addr) or die "sockaddr_in: $!\n";


connect ( $remote, $packed_addr ) or die "connect: $!\n";
select((select($remote), $|=1)[0]);

my ($prev_idle, $prev_total) = qw(0 0);
while () {
    open(STAT, '/proc/stat') or die "WTF: $!";
    while (<STAT>) {
        next unless /^cpu\s+[0-9]+/;
        my @cpu = split /\s+/, $_;
        shift @cpu;
 
        my $idle = $cpu[3];
        my $total = sum(@cpu);
 
        my $diff_idle = $idle - $prev_idle;
        my $diff_total = $total - $prev_total;
        my $diff_usage = 100 * ($diff_total - $diff_idle) / $diff_total;
 
        $prev_idle = $idle;
        $prev_total = $total;
 
        print $remote "$diff_usage\n";
    }
    close STAT;
    sleep 1;
}
print while (<$remote>);
