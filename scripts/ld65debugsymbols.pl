#!/usr/bin/env perl

use strict;
use Getopt::Long;

# creates a set of NOICE debug symbols from an LD65 -dbgfile dump
# if --romno is specified then addresses in the range 8000-BFFF will
# be prepended with the given rom number i.e. 4:8000

my $romno;
GetOptions("romno=s" => \$romno) or Usage("Bad options $!");

$#ARGV == 1 or Usage("Wrong number of arguments");

my ($fn_in, $fn_out) = @ARGV;

my %scopes = ();
my %syms = ();

open (my $f_in, "<", $fn_in) or die "Cannot open \"$fn_in\" for input: $!";
open (my $f_out, ">", $fn_out) or die "Cannot open \"$fn_out\" for output: $!";

while (<$f_in>) {
	my $l = $_;
	$l =~ s/[\r\n\s]*$//;

	if ($l =~ /^(\w+)\s*(.*)$/) {

		my $type = $1;
		my %stuff;
		foreach my $s (split(/\s*,\s*/, $2)) {
			my ($lbl, $val) = split(/\s*=\s*/, $s);
			$val =~ s/^\"(.*?)\"$/\1/;
			$stuff{$lbl} = $val;
		}

		if ($type eq "scope") {
			$scopes{$stuff{"id"}} = {
				id=>$stuff{"id"}, 
				name=>$stuff{"name"},
				parent=>$stuff{"parent"}
			};
		} elsif ($type eq "sym") {
			$syms{$stuff{"id"}} = {
				id=>$stuff{"id"},
				name=>$stuff{"name"},
				scope=>$stuff{"scope"},
				parent=>$stuff{"parent"},
				val=>hex($stuff{"val"})	
			};
		}
	}

}

foreach my $sid (sort { $syms{$a}->{val} <=> $syms{$b}->{val} } keys %syms) {
	my $sym = $syms{$sid};

	my $addr = $sym->{val};
	if ($romno && $addr >= 0x8000 && $addr <= 0xBFFF) {
		$addr = sprintf "%s:%04X", $romno, $addr;
	} else {
		$addr = sprintf "%04X", $addr;
	}	

	printf $f_out "DEF %s $addr\n", getsymname($sym), $addr;

}

sub getsymname($) {
	my ($sym) = @_;

	my $par="";

	my $symname = $sym->{name};

	$symname =~ s/^\@(.*)/_\1/;

	if ($sym->{parent}) {
		print "PAR:$sym->{parent}\n";
		$par = getsymname($syms{$sym->{parent}});

		if ($par) {
			return $par . "::" . $symname;
		} else {
			return $symname;
		}
	} else {
		my $sc = getscope($sym->{scope});
		if ($sc) {
			return ${sc} . "::" . $symname;
		} else {
			return $symname;
		}
	}
}

sub getscope($) {
	my ($scope_id) = @_;
	my $scope = $scopes {$scope_id};

	if (!$scope) {
		return "";
	}

	my $ps = "";
	if ($scope->{parent}) {
		 $ps = getscope($scope->{parent})

	}

	my $name = $scope->{name};

	$name =~ s/^\$anon-SCOPE-([0-9]+)/_a\1/;


	if ($ps) {
		return "${ps}::${name}";
	} else {
		return "${name}";
	}
}

sub Usage($) {
	my ($msg) = @_;

	print STDERR "ERROR: $msg\n";

	print STDERR "Usage: ld65debugsymbols.pl [--romno N] <input> <output>\n";

	exit 10;
}