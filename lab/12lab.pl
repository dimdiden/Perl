#!/usr/bin/perl
use strict;
use warnings;

die "Use path to html file!\n" if ( !$ARGV[0] );

open( my $file, $ARGV[0] ) or die "File $ARGV[0] not found\n";
while ( my $line = <$file> ) {
    if ( $line =~ /.*<body.*>/ ... $line =~ /.*<\/body>.*/ ) {
        $line =~ s/<.*?$|^.*?>|<.*?>/ /g;
        $line =~ s/^\s+//;
        my @arr = split /\s+/, $line;
        while ( my $word = shift @arr ) {
            print "$1\n"
              if ( $word =~ /^\W*(\w*(\w)\2\w*)\W*$/ and $word !~ /\d+/ );
        }
    }
}

