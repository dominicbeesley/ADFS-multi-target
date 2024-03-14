#!/usr/bin/env perl

use strict;

while (<>) {

	my $l = $_;

	$l =~ s/[\r\n\s]+$//;

	my $c = '';

	if ($l =~ m/^([^;]*);(.*)/) {
		$l = $1;
		$c = ";$2";
	}
	

	$l =~ s/^\.([\w_]+)\b/$1:/;

	$l =~ s/^(\s*)(IF|ELSE|ENDIF)\b/$1 . "." . lc($2)/ge;
#	$l =~ s/^(\s*)(ELIF)\b/$1.elseif/e;

	$l =~ s/&/\$/g;
	$l =~ s/\bEQUB\b/.byte/g;
	$l =~ s/\bEQUW\b/.word/g;
	$l =~ s/\bEQUS\b/.byte/g;
	$l =~ s/\binclude\b/.include/gi;

	print "$l$c\n";

}