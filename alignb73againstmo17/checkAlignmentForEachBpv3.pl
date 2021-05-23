#!perl -w
use strict;

my %geneme;
my $seq_name="";
my $seq="";
open INPUT, "$ARGV[0]";

while( my $line=<INPUT> ){
	if( $line=~/^>(\S+)/ ){
		if( length($seq_name) >0 ){
			$seq = uc($seq);
			$geneme{$seq_name} = $seq;
		}
		$seq_name = $1;
		$seq="";
	}else{
		$line=~s/\s//g;
		$seq = $seq . $line;
	}
}
if( length($seq_name) >0 ){
	$seq = uc($seq);
	$geneme{$seq_name} = $seq;
}
close INPUT;


my $MATCH = 0;
my $MISMATCH = 0;
my $GAP = 0;
my $multiplecovered = 0;

open INPUT, "$ARGV[1]";
while( my $output_line = <INPUT>){
	if( $output_line=~/^(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/ ){
		my $thisChr = $1;
		my $thisPos = $2;
		my $thisDep = $4;
		my $thisChar = uc($5);
		$thisChar =~s/\-\d.*$//;
		$thisChar =~s/\$$//;
		$thisChar =~s/\+\d.*$//;
		$thisChar =~s/^\^\~//;
		$thisChar =~s/^\^\+//;
		$thisChar =~s/^\^\S//;
		if( $thisDep>1 ){
			$multiplecovered = $multiplecovered + 1;
		}elsif ( $thisChar eq "*") {
			$GAP = $GAP + 1;
		}elsif ( length($thisChar) == 1 ) {
			my $position = $thisPos - 1;
			if( $thisChar eq substr($geneme{$thisChr}, $position, 1) ){
				$MATCH = $MATCH + 1;
			}else{
				$MISMATCH = $MISMATCH + 1;
			}
		}else{
			print "$output_line\n";
		}
	}
}
close INPUT;

print "MATCH:$MATCH\n";
print "MISMATCH:$MISMATCH\n";
print "GAP:$GAP\n";
print "multiplecovered:$multiplecovered\n";
