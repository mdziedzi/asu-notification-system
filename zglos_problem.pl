#!/usr/bin/perl 

use Tk;
use strict;

my $mw = MainWindow->new;
$mw->geometry("400x400");
$mw->title("Zglaszanie problemu");

$mw->Label(-text => "Strona internetowa: ")->pack();
my $webPageEntry = $mw->Entry(-background => 'black', -foreground => 'white', -width => 30)->pack();

$mw->Label(-text => "Adres do korespondencji: ")->pack();
my $addressEntry = $mw->Entry(-background => 'black', -foreground => 'white', -width => 30)->pack();

$mw->Label(-text => "Opis problemu: ")->pack();
my $descriptionEntry = $mw->Entry(-background => 'black', -foreground => 'white', -width => 60)->pack();

my $sendButton = $mw->Button(-text => "Send", -command =>\&send)->pack();

sub send() {
	print "*sended*\n";
	$mw->Label(-text => "Dziekujemy za zgloszenie")->pack();
	print $webPageEntry -> get();
	print "\n";
	print $addressEntry -> get();
	print "\n";
	print $descriptionEntry -> get();
	print "\n";
	
	writeToFile();
}

sub writeToFile() {
	my $filename = 'zgloszenia.txt';
	open(my $fh, '>>', $filename) or die "Could not open file '$filename' $!";
	print $fh "NOWY", ";";
	print $fh $webPageEntry -> get(), ";";
	print $fh $addressEntry -> get(), ";";
	print $fh $descriptionEntry -> get(), ";";
	print $fh "\n";
	close $fh;
	print "done\n";
}

MainLoop;
