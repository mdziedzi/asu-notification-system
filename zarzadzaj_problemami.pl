#!/usr/bin/perl 

use Tk;
use strict;
use Tk::Table;
use Tk::BrowseEntry;

# stale
my $COMMENT_ROW = 5;
my $DELETE_ROW = $COMMENT_ROW + 1;

# statusy
my @list = ( "NOWY", "ANALIZA", "WYS. WIAD.", "ZREALIZOWANE", "ODRZUCONE" );

my @data;	# Tablica dwuwymiarowa - przechowuje dane zczytane z pliku
my $n_rows;	# Liczba zgloszen

# Tablice pomocnicze przy zapisie
my @be_array;
my @label_array;
my @comment_array;

#***************************************************************************#

my $mw = MainWindow->new;
$mw->geometry("1400x600");
$mw->title("Problemy uzytkownikow");

readFile();

$n_rows = scalar @data;

my $table_frame = $mw -> Frame() -> pack();
my $table = $table_frame->Table(-columns => 6,
                                -rows => 20,
                                -fixedrows => 1,
                                -scrollbars => 'oe',
                                -relief => 'raised'
								);

createTableLabels();

fillTable();

addSaveButton();

#**************************************************************************#

sub readFile() {
	my $filename = "zgloszenia.txt";
	open(my $fh, '<:encoding(UTF-8)', $filename)
	  or die "Could not open file '$filename' $!";

	for (my $i=0; my $row = <$fh>; $i++) {

		chomp $row;

		my @fields = split ";" , $row;
		push @data, \@fields;

		print "$row\n";
	}
	print "Plik zostal wczytany\n";
}

sub createTableLabels() {
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
}

sub saveChanges() {
	my $filename = 'zgloszenia.txt';
	open(my $fh, '>>', $filename) or die "Could not open file '$filename' $!";
	unlink ('zgloszenia.txt') or die "Could not delete the file!\n";
	open(my $fh, '>>', $filename) or die "Could not open file '$filename' $!";

	foreach my $row (1 .. $n_rows) {
		print $fh $be_array[$row-1], ";";
		foreach my $col(2 .. 4) {
			print $fh $label_array[$row-1][$col-1], ";";
		}
		print $fh $comment_array[$row-1], ";";
		print $fh "\n";
		print "Zapisano\n";
	}
	
}

sub fillTable() {
	foreach my $row (1 .. $n_rows)
	{
		# fill table with BrowseEntry
		$be_array[$row -1] = $data[$row - 1][0];
		my $tmp_listbox = $table -> BrowseEntry (
			-variable => \$be_array[$row -1],
		)->pack();
		$tmp_listbox->insert('end', @list);
		$table->put($row, 1, $tmp_listbox);

		# fill table with Labels
		foreach my $col (2 .. 5)
		{
			$label_array[$row -1][$col -1] = $data[$row - 1][$col - 1];
			my $tmp_label = $table->Label (
				-text => $data[$row - 1][$col - 1],
				-padx => 2,
				-anchor => 'w',
				-background => 'white',
				-relief => "groove"
			);
			$table->put($row, $col, $tmp_label);
		}

		# fill table with Entry
		$comment_array[$row-1] = $data[$row -1][$COMMENT_ROW - 1];
		my $tmp_entry = $table->Entry ( 
			-textvariable => \$comment_array[$row-1],
			-width => 40,
			-background => 'white',
			-relief => 'groove'
		);
		$table->put($row, $COMMENT_ROW, $tmp_entry);
	}
	$table->pack();
}

sub addSaveButton() {
	my $button_frame = $mw->Frame( -borderwidth => 4 )->pack();
	$button_frame->Button(-text => "Zapisz zmiany", -command => \&saveChanges)->pack();
}

MainLoop;
