#!perl -w
use strict;
open INPUT, "$ARGV[1]";
my $totalNUmber = 0;
my $goodnumber = 0;
while( my $line=<INPUT> ){
	$line =~ s/^\s+//;
	$line =~ s/\s+$//;
	my @words = split /\s+/, $line;
	my $chr = $words[0];
	my $start = $words[1];
	$start = $start + 1;
	my $end = $words[2];
	my $teLength = $end - $start + 1;

	$start = $start - 35;
	$end = $end + 35;
	my $good = 0;
	
	opendir my $dir, "./" or die "Cannot open directory: $!";
	my @files = readdir $dir;
	closedir $dir;
	for my $bamFile ( @files ){
		if( $bamFile=~/^$ARGV[0]$/){
			my $maximumGapLength = 0;
			my $maximumGapPreNonGapLength = 0;
			my $maximumGapPostNonGapLength = -1;

			my $thisGapLength = 0;
			my $thisNonGapLength = 0;
			my $lastGap = 0;

			#my $result = `samtools depth -r $chr:$start-$end $ARGV[0]`;
			my $result = `samtools mpileup -r $chr:$start-$end $bamFile`;
#			print "samtools mpileup -r $chr:$start-$end $bamFile\n";
			my @lines = split /\n+/, $result;

			my $lastPosition = $start - 1;
			
			my $numberOfLines = scalar(@lines);
			my $nonZoroCoverage = 0;
			for my $eachline (@lines){
				my @elements = split /\s+/, $eachline;
				# for( my $i= $lastPosition+1; $i<$elements[1]; $i = $i + 1){
				# 	if( $lastGap ){
				# 		$thisGapLength = $thisGapLength + 1;
				# 	}else{
				# 		if( $maximumGapPostNonGapLength == -1 ){
				# 			$maximumGapPostNonGapLength = $thisNonGapLength;
				# 		}
				# 		$thisGapLength = 1;
				# 	}
				# 	$lastGap = 1;
				# 	$numberOfLines = $numberOfLines + 1;
				# }
				$lastPosition = $elements[1];

				#if ( $elements[2] != 0 ){
				if ( $elements[4] ne "*" ){
					$nonZoroCoverage = $nonZoroCoverage + 1;
					
					if( $lastGap ){
						if( $thisGapLength > $maximumGapLength ){
							$maximumGapLength = $thisGapLength;
							$maximumGapPreNonGapLength = $thisNonGapLength;
							$maximumGapPostNonGapLength = -1;
						}
						$thisNonGapLength = 1;
					}else{
						$thisNonGapLength = $thisNonGapLength + 1;
						
					}
					$lastGap = 0;
				}else{
					if( $lastGap ){
						$thisGapLength = $thisGapLength + 1;
					}else{
						if( $maximumGapPostNonGapLength == -1 ){
							$maximumGapPostNonGapLength = $thisNonGapLength;
						}
						$thisGapLength = 1;
					}
					$lastGap = 1;
				}
			}
			if( $maximumGapPostNonGapLength == -1 ){
				$maximumGapPostNonGapLength = $thisNonGapLength;
			}
			if( $thisGapLength > $maximumGapLength ){
				$maximumGapLength = $thisGapLength;
				$maximumGapPostNonGapLength = 0;
			}


			if( ($teLength + 70) > $numberOfLines ){
			}elsif( $maximumGapPostNonGapLength == 0 || $maximumGapPreNonGapLength == 0 ){
			}elsif ( $maximumGapLength < $teLength && ($teLength - $maximumGapLength) < 35 ){
				$good = $good + 1;
			}elsif ( $maximumGapLength < $teLength ){
			}elsif ( $maximumGapLength > $teLength && ($maximumGapLength - $teLength) < 35 ){
				$good = $good + 1;
			}elsif ( $maximumGapLength > $teLength ){
				
			}elsif ( $maximumGapPostNonGapLength > 0 && $maximumGapPreNonGapLength > 0 ){
				$good = $good + 1;
			}else{
			}
		}
	}
	if( $good > 0 ){
		$goodnumber = $goodnumber + 1;
	}
	$totalNUmber = $totalNUmber + 1;
}
close INPUT;

print "totalNUmber:$totalNUmber\n";
print "goodnumber:$goodnumber\n";
