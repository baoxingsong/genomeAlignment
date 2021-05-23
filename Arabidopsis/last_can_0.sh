#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size



lastal col can_0.fa > can_0_lastal.maf
faSize -detailed can_0.fa > can_0.size
faToTwoBit can_0.fa can_0.2bit
maf-convert psl can_0_lastal.maf > can_0_lastal.psl
axtChain -linearGap=loose -psl can_0_lastal.psl -faQ -faT tair10.fa can_0.fa can_0_lastal.chain
chainMergeSort can_0_lastal.chain > can_0_lastal.all.chain
chainPreNet can_0_lastal.all.chain col.size can_0.size can_0_lastal.preNet
chainNet can_0_lastal.preNet col.size can_0.size can_0_lastal.refTarget.net can_0_lastal.chainNet
netToAxt can_0_lastal.refTarget.net can_0_lastal.preNet col.2bit can_0.2bit stdout | axtSort stdin can_0_lastal.axt
axtToMaf can_0_lastal.axt col.size can_0.size can_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl can_0_lastal_final.maf > can_0_lastal_final_forsplit.maf
cat can_0_lastal.maf | last-split | maf-swap | last-split | maf-swap >  can_0_lastal_split.maf
cat can_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap >  can_0_lastal_final_split.maf
perl lastToMafComparsion.pl can_0_lastal_split.maf > can_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl can_0_lastal_final_split.maf > can_0_lastal_final_split_Comparator.maf
