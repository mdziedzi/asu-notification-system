#!/usr/bin/perl 

use Tk;
use strict;

my @matrix;


	my $mw = MainWindow->new;
	$mw->geometry("1400x600");
	$mw->title("Problemy uzytkownikow");

sub readFile() {
	my $filename = "zgloszenia.txt";
	open(my $fh, '<:encoding(UTF-8)', $filename)
	  or die "Could not open file '$filename' $!";

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
}

readFile();


use Tk::Table;


my $table_frame = $mw -> Frame() -> pack();
my $table = $table_frame->Table(-columns => 5,
                                -rows => 20,
                                -fixedrows => 1,
                                -scrollbars => 'oe',
                                -relief => 'raised');

 
my $tmp_label = $table->Label(-text => "STATUS", -width => 12, -relief =>'raised');
$table->put(0, 1, $tmp_label);
my $tmp_label = $table->Label(-text => "STRONA", -width => 20, -relief =>'raised');
$table->put(0, 2, $tmp_label);
my $tmp_label = $table->Label(-text => "ADRES", -width => 20, -relief =>'raised');
$table->put(0, 3, $tmp_label);
my $tmp_label = $table->Label(-text => "OPIS", -width => 80, -relief =>'raised');
$table->put(0, 4, $tmp_label);
my $tmp_label = $table->Label(-text => "KOMENTARZ", -width => 40, -relief =>'raised');
$table->put(0, 5, $tmp_label);

foreach my $row (1 .. 20)
{
  foreach my $col (1 .. 6)
  {
    my $tmp_label = $table->Label(-text => $matrix[$row - 1][$col - 1],
                                  -padx => 2,
                                  -anchor => 'w',
                                  -background => 'white',
                                  -relief => "groove");
    $table->put($row, $col, $tmp_label);
  }
}
$table->pack();
 
my $button_frame = $mw->Frame( -borderwidth => 4 )->pack();
$button_frame->Button(-text => "Exit", -command => sub {exit})->pack();


MainLoop;
