#!/usr/bin/perl
use strict;
use warnings;
use LIB;

while (1) {
    print
"=>Usage: load <file>, add, search, search <pattern>, delete <pattern>, printall\nEnter command>";
    chomp( my $var = <STDIN> );
    print "\nBad command, try again\n\n"
      if ( $var !~ m/(?:load .+)|search|add|printall|(?:delete .+)/ );
    LIB::add_book if ( $var =~ m/add/ );
    LIB::load_file( ( split( " ", $var ) )[1] ) if ( $var =~ m/(?:load .+)/ );
    if ( $var =~ m/^search .+/ ) {
        my $search = ( split( " ", $var ) )[1];
        LIB::search($search);
    }
    if ( $var =~ m/^search$/ ) {
        print
"Enter one of the folowing criterias:\ntitle, author, section, shelf, on_hands";
        print ">";
        chomp( my $crit = <STDIN> );
        print "\nWrong criteria\n\n"
          if ( $crit !~ m/title|author|section|shelf|on_hands/ );
        if ( $crit eq "title" ) {
            print "Enter a pattern for search: ";
            chomp( my $search = <STDIN> );
            LIB::search( $search, "title" );
        }
        if ( $crit eq "author" ) {
            print "Enter a pattern for search: ";
            chomp( my $search = <STDIN> );
            LIB::search( $search, "author" );
        }
        if ( $crit eq "section" ) {
            print "Enter a pattern for search: ";
            chomp( my $search = <STDIN> );
            LIB::search( $search, "section" );
        }
        if ( $crit eq "shelf" ) {
            print "Enter a pattern for search: ";
            chomp( my $search = <STDIN> );
            LIB::search( $search, "shelf" );
        }
        if ( $crit eq "on_hands" ) {
            print "Enter a pattern for search: ";
            chomp( my $search = <STDIN> );
            LIB::search( $search, "on_hands" );
        }
    }
    if ( $var =~ m/printall/ ) {
        print "Library:\n-----------------------------------\n";
        LIB::printall;
    }
    if ( $var =~ m/^delete .+/ ) {
        my $search = ( split( " ", $var ) )[1];
        LIB::move_to_trash($search);
    }
}

1;
