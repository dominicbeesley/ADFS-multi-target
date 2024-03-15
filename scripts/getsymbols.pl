#!/usr/bin/env perl

my $ROMNO=@ARGV[0];

while (<STDIN>) {
	my $l = $_;
	chomp $l;

	if ($l =~ /^al\s+([0-9A-F]{1,6})\s+\.(.*)$/i)
	{
		my $addr=$1;
		my $sym=$2;

		$addr =~ s/^00([0-9A-F]{4})$/$1/;

		if ($ROMNO && $ROMNO ne "" && $addr =~ /^[89AB][0-9A-F]{3}/i) {
			$addr = $ROMNO . ":" . $addr;
		}


		$sym =~ s/(@|\-)/_/g;

		print "DEF $sym $addr\n";
	}
}