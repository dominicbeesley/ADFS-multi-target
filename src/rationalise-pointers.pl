#!/bin/perl

use Text::Tabs;

$tabstop = 8;

my %locs=();

sub repl1 ($) {
	my ($in) = @_;

	$in = hex($in);

	if ($in >= 0xC000 and $in < 0xCE00) {
		$in -= 0xC000;
	} elsif ($in >= 0xE00 and $in < 0x1C00) {
		$in -= 0xE00;
	} else {
		die "bad hex number $in";
	}

	my $base = "WKSP_BASE";
	my $len = 0;
	my $lbl = "";

	if (int($in/256) == 0) {
		$base = "WKSP_ADFS_000_FSM_S0";
	}
	elsif (int($in/256) == 1) {
		$base = "WKSP_ADFS_100_FSM_S1";
	}
	elsif (int($in/256) == 2 || int($in/256) == 3) {
		$lbl = sprintf("WKSP_ADFS_%03.03X", $in);

		$locs{$lbl} = fix57($lbl) . sprintf("\t\t= WKSP_BASE + &%04.04X", $in);
	}
	elsif (int($in/256) == 4) {
		$base = "WKSP_ADFS_400_DIR_BUFFER";
	}
	elsif (int($in/256) == 5) {
		$base = "WKSP_ADFS_500_DIR_BUFFER";
	}
	elsif (int($in/256) == 6) {
		$base = "WKSP_ADFS_600_DIR_BUFFER";
	}
	elsif (int($in/256) == 7) {
		$base = "WKSP_ADFS_700_DIR_BUFFER";
	}
	elsif (int($in/256) == 8) {
		$base = "WKSP_ADFS_800_DIR_BUFFER";
	}
	elsif (int($in/256) == 9) {
		$base = "WKSP_ADFS_900_RND_BUFFER";
	}
	elsif (int($in/256) == 10) {
		$base = "WKSP_ADFS_A00_RND_BUFFER";
	}
	elsif (int($in/256) == 11) {
		$base = "WKSP_ADFS_B00_RND_BUFFER";
	}
	elsif (int($in/256) == 12) {
		$base = "WKSP_ADFS_C00_RND_BUFFER";
	}
	elsif (int($in/256) == 13) {
		$base = "WKSP_ADFS_D00_RND_BUFFER";
	}
	else {
		die "unknown range $in";
	}

	if ($lbl) {
		return $lbl;
	} elsif ($base) {
		return sprintf("$base + &%02.02X", int($in % 256));
	} else {
		return sprintf("WKSP_BASE + &%04.04X", $in);
	}
}

sub repl ($) {

	my ($in) = @_;

	$in =~ s/\&((C0|C1|C2|C3|C4|C5|C6|C7|C8|C9|CA|CB|CC|CD)[0-9A-F][0-9A-F]|(E|F|0E|0F|10|11|12|13|14|15|16|17|18|19|1A|1B)[0-9A-F][0-9A-F])\b/repl1($1)/eg;

	return $in;	
}

sub fix57 ($) {
	my ($in) = @_;

	$in =~ s/\s*$//;

	my $lenin = length(expand($in));

	if ($lenin >= 56) {
		return $in;
	} else {
		my $out = $in;
		while ($lenin < 56)
		{
			$out = $out . "\t";
			$lenin+=8;
		}
		return $out;
	}
}

while (<>) {

	chomp;
	s/[\s\r\n]+$//;

	if (/^[^;]*=/) {
		#skip EQU lines
		print "$_\n";
	} elsif (/^\s*;/) {
		print "$_\n";
	}
	elsif (/^(\s*[^\s;]+[^;]*);\s*(.*)/) {
		my $op=$1, $cmt=$2;

		print fix57(repl($op));

		print "; $cmt\n";
	} else {
		print repl($_) . "\n";
	}

}


foreach my $k (sort keys(%locs)) {
	print "${locs{$k}}\n";
}