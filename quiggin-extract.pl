#!/usr/bin/perl

use warnings;
use strict;
use utf8;

binmode(STDIN, ":utf8");
binmode(STDOUT, ":utf8");

my %cite = (
	'Atk' => 'atkinsons', # Atkinson's Glossary to the Passions and Homilies from Leabhar Breac.
	'Cl. S' => 'claidheamh_soluis', # Claidheamh Soluis.
	'Craig, Iasg' => 'craig', # Craig, Iasgaireacht Sheumais Bhig, Dublin 1904.
	'D. P' => 'derry_people', # Derry People.
	'Di' => 'dinneen', # Dinneen's Dictionary.
	'Dinneen' => 'dinneen', # Dinneen's Dictionary.
	'Diss' => 'die_lautliche_geltung', # Die lautliche Geltung der vortonigen Wörter und Silben in der Book of Leinster Version der Tāin bō Cualnge, Greifswald 1900.
	'Finck' => 'finck', # Die Araner Mundart i, ii.
	'G. J' => 'gaelic_journal', # Gaelic Journal.
	'Henebry' => 'henebry', # A contribution to the phonology of Desi-Irish.
	'Hogan' => 'hogan', # Luibhleabhrán, Dublin 1900.
	'Macbain' => 'macbain', # Etymological Gaelic Dictionary.
	'Meyer' => 'meyer', # Contributions to Irish Lexicography.
	'Molloy' => 'molloy', # Grammar of the Irish Language, Dublin 1867.
	'Pedersen' => 'pedersen', # Aspiration i Irsk.
	'Rhys' => 'rhys', # Outlines of Manx Phonology.
	'Sg. Fearn' => 'lloyd', # Lloyd, Sgeulaidhe Fearnmhuighe.
	'Spir. Rose' => 'spiritual_rose', # Spiritual Rose, Monaghan 1825
	'O’R' => 'oreilly', # Edward O’Reilly, Irish-English Dictionary
	'Wi' => 'irische_text', # Ernst Windisch, Irische Texte mit Wörterbuch
);

my $citations = join('|', keys %cite);

my $cur_sect = '';
my $prev_phn = '';
while(<>) {
	chomp;
	s/\r//;
	s/  +/ /g;
	# kï̃vαd, ‘to watch, look at’, Di. coimhéad, Wi. comét
	if(/^# .*§ ([0-9]+)$/) {
		$cur_sect = $1;
	} elsif(/^!(.*)$/) {
		my $verbatim = $1;
		$verbatim =~ s/^:::/      /;
		$verbatim =~ s/^::/    /;
		$verbatim =~ s/^:/  /;
		print "$verbatim\n";
	} elsif (/^>eg:([^,]+), ‘([^’]+)’$/) {
		my $eg = $1;
		my $en = $2;
		print "  examples:\n";
		print "    - phonetic: \"$eg\"\n      english: \"$en\"\n"; 
	} elsif (/^>proverb: ?([^,]+), ‘([^’]+)’$/) {
		my $eg = $1;
		my $en = $2;
		print "  proverb:\n    phonetic: \"$eg\"\n    english: \"$en\"\n"; 
	} elsif (/([^>][^,]+), ‘([^’]+)’$/) {
		my $phn = $1;
		my $en = $2;
		print "\"$phn\":\n";
		$prev_phn = $phn;
		print "  section: $cur_sect\n";
		print "  english: \"$en\"\n";
	} elsif (/^([^,]+), ‘([^’]+)’, cp\. M\.Ir\. ([a-zA-ZÁÉÍÓÚáéíóú]+)$/) {
		my $phn = $1;
		my $en = $2;
		my $mi = $3;
		print "\"$phn\":\n";
		$prev_phn = $phn;
		print "  section: $cur_sect\n";
		print "  english: \"$en\"\n  compare:\n    middle_irish: \"$mi\"\n";
	} elsif (/^([^,]+), ‘([^’]+)’, M\.Ir\. ([a-zA-ZÁÉÍÓÚáéíóú]+)$/) {
		my $phn = $1;
		my $en = $2;
		my $mi = $3;
		print "\"$phn\":\n";
		$prev_phn = $phn;
		print "  section: $cur_sect\n";
		print "  english: \"$en\"\n  middle_irish: \"$mi\"\n";
	} elsif (/^([^,]+), ‘([^’]+)’, cp\. O\.Ir\. ([a-zA-ZÁÉÍÓÚáéíóú]+)$/) {
		my $phn = $1;
		my $en = $2;
		my $oi = $3;
		print "\"$phn\":\n";
		$prev_phn = $phn;
		print "  section: $cur_sect\n";
		print "  english: \"$en\"\n  compare:\n    old_irish: \"$oi\"\n";
	} elsif (/^([^,]+), ‘([^’]+)’, O\.Ir\. ([a-zA-ZÁÉÍÓÚáéíóú]+)$/) {
		my $phn = $1;
		my $en = $2;
		my $oi = $3;
		print "\"$phn\":\n";
		$prev_phn = $phn;
		print "  section: $cur_sect\n";
		print "  english: \"$en\"\n  old_irish: \"$oi\"\n";
	} elsif (/^([^,]+), ‘([^’]+)’, ($citations)\.? ([^,]+), ($citations)\. ([a-zA-ZÁÉÍÓÚáéíóú]+)$/) {
		my $phn = $1;
		my $en = $2;
		my $c1 = $3;
		my $c1word = $4;
		my $c2 = $5;
		my $c2word = $6;
		print "\"$phn\":\n";
		$prev_phn = $phn;
		print "  section: $cur_sect\n";
		print "  english: \"$en\"\n  headwords:\n    $cite{$c1}: \"$c1word\"\n    $cite{$c2}: \"$c2word\"\n";
	} elsif (/^([^,]+), ‘([^’]+)’, ($citations)\.? ([a-zA-ZÁÉÍÓÚáéíóú’]+)$/) {
		my $phn = $1;
		my $en = $2;
		my $c1 = $3;
		my $c1word = $4;
		print "\"$phn\":\n";
		$prev_phn = $phn;
		print "  section: $cur_sect\n";
		print "  english: \"$en\"\n  headwords:\n    $cite{$c1}: \"$c1word\"\n";
	} elsif (/^([^,]+), ‘([^’]+)’$/) {
		my $phn = $1;
		my $en = $2;
		print "\"$phn\":\n";
		$prev_phn = $phn;
		print "  section: $cur_sect\n";
		print "  english: \"$en\"\n";
	} else {
		print "# $_\n";
	}
}