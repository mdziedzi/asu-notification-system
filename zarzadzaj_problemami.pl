#!/usr/bin/perl 

use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("400x400");
$mw->title("Problemy uzytkownikow");

my $filename = "zgloszenia.txt";
open(my $fh, '<:encoding(UTF-8)', $filename)
  or die "Could not open file '$filename' $!";

my @matrix;
 
for (my $i=0; my $row = <$fh>; $i++) {

	chomp $row;

	my @fields = split ";" , $row;
	push @matrix, \@fields;

	print "$row\n";
}
print "done\n";
print $matrix[0][0];
print $matrix[0][1];
print $matrix[0][2];
print $matrix[0][3];
print $matrix[1][0];
print $matrix[1][1];
print $matrix[1][2];
print $matrix[1][3];

MainLoop;
