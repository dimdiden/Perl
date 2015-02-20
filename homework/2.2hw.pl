#!/usr/bin/perl
use strict;
use warnings;

die "Use path to html file!\n" if ( !$ARGV[0] );

open( my $file, $ARGV[0] ) or die "File $ARGV[0] not found\n";

my %hash_wrd;
my %hash_tag;

while ( my $line = <$file> ) {
    while ( $line =~ m/<(\w+?)(?:\s.+[^\/])?>/g ) {
        $hash_tag{$1}++;
    }

    if ( $line =~ /.*<body.*>/ ... $line =~ /.*<\/body>.*/ ) {
        $line =~ s/<.*?$|^.*?>|<.*?>/ /g;
        $line =~ s/^\s+//;
        my @arr = split /\s+/, $line;
        while ( my $word = shift @arr ) {
            if ( $word =~ m/^\W*(\w+)\W*$/ ) {
                $hash_wrd{$1}++;
            }
        }
    }

}

print "=====Ten the most frequent words in $ARGV[0]=====\n";
print "$_\n"
  for ( ( sort { $hash_wrd{$b} <=> $hash_wrd{$a} } keys %hash_wrd )[ 0 .. 9 ] );

print "=====Ten the most frequent tags in $ARGV[0]=====\n";
print "<$_>\n"
  for ( ( sort { $hash_tag{$b} <=> $hash_tag{$a} } keys %hash_tag )[ 0 .. 9 ] );

