#!/usr/bin/perl 

use Tk;
use strict;

my $COMMENT_ROW = 5;
my $DELETE_ROW = $COMMENT_ROW + 1;

my @matrix;
my $nRows;
my @be_array; #browseentry
my @label_array;
my @comment_array;


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

	#print scalar(@{ $matrix[1] });
	$nRows = scalar @matrix;
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
my $table = $table_frame->Table(-columns => 6,
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
my $tmp_label = $table->Label(-text => "USUN", -width => 8, -relief =>'raised');
$table->put(0, 6, $tmp_label);

sub comment() {
#

#
}

sub saveChanges() {

	my $filename = 'zgloszenia.txt';
	open(my $fh, '>>', $filename) or die "Could not open file '$filename' $!";
	unlink ('zgloszenia.txt') or die "Could not delete the file!\n";
	open(my $fh, '>>', $filename) or die "Could not open file '$filename' $!";

	foreach my $row (1 .. $nRows) {
		print $fh $be_array[$row-1], ";";

		foreach my $col(2 .. 4) {
			#print $fh $matrix[$row - 1][$col - 1], ;
			#my $tmp =  $table -> get($row, $col);

			print $fh $label_array[$row-1][$col-1], ";";
			
			#print $tmp-> get(), ";\n";
		}
		print $fh $comment_array[$row-1], ";";
#print $table ->get($row -1, 5) -> get();

		print $fh "\n";
		
	}
	
}

# fill table
foreach my $row (1 .. $nRows)
{
	my @list = ( "NOWY", "ANALIZA", "WYS. WIAD.", "ZREALIZOWANE", "ODRZUCONE" );
$be_array[$row -1] = $matrix[$row - 1][0];
	my $tmp_listbox = $table -> BrowseEntry (
		-variable => \$be_array[$row -1],
		#-label => $matrix[$row - 1][0]
	)->pack();
	$tmp_listbox->insert('end', @list);
	$table->put($row, 1, $tmp_listbox);

	# with labels
	foreach my $col (2 .. 5)
	{
		$label_array[$row -1][$col -1] = $matrix[$row - 1][$col - 1];
		my $tmp_label = $table->Label (
			-text => $matrix[$row - 1][$col - 1],
			#-textvariable => \$label_array[$row -1],
			-padx => 2,
			-anchor => 'w',
			-background => 'white',
			-relief => "groove"
		);
		$table->put($row, $col, $tmp_label);
	}

	# fill table with entry
	$comment_array[$row-1] = $matrix[$row -1][$COMMENT_ROW - 1];
	my $tmp_entry = $table->Entry ( 
		-textvariable => \$comment_array[$row-1],
		-width => 40,
		-background => 'white',
		-relief => 'groove'
	);
	$table->put($row, $COMMENT_ROW, $tmp_entry);

	# fill table with checkbutton
	my $deleteval;
	my $tmp_checkbutton= $table->Checkbutton (
	   -variable=>\$deleteval,
	   -indicatoron=>'1',
	   -state=>'normal',
	   -width => 1,
	   -anchor=>'nw',
	   -background => 'white',
	   -relief => 'groove', -padx=>5
	);
	$table->put($row, $DELETE_ROW, $tmp_checkbutton);
}

$table->pack();
 
my $button_frame = $mw->Frame( -borderwidth => 4 )->pack();
$button_frame->Button(-text => "Zapisz zmiany", -command => \&saveChanges)->pack();



MainLoop;
