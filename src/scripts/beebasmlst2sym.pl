#!/bin/perl

# make noice symbols file from a beebasm .lst file
# -r N then all ROM addresses prepended with N

sub usage($) {
	my ($msg) = @_;
	if ($msg) {
		print STDERR "$msg\n"
	}
	die "beebasmlst2sym.pl [-r N]\n";
}

my $romno=-1;

while (scalar @ARGV && @ARGV[0] =~ /^-/) {
	my $sw = shift;
	if ($sw == '-r') {
		$romno = shift; 
		defined $romno || usage "missing argument";
		$romno = hex($romno);
	} else {
		usage "unknown switch $sw"
	}
}

my $lbl=undef;

while (<>) {
	if (/^(SYMBOLS\s*=\s*)?\[\{([^\}]*)}\]/)
	{
		my @all = split(/\,/, $2);

		foreach my $a (@all) {
			if ($a =~ /^\'(\w+)\':([0-9]+)L/) {
				my $lbl = $1, $addr = $2;
				if ($romno >= 0 && $addr >= 0x8000 && $addr <= 0xBFFF) {
					printf "DEF %s %01X:%04X\n", $lbl, $romno, $addr;
				} else {
					printf "DEF %s %04X\n", $lbl, $addr;
				}
			}
		}

	}
}