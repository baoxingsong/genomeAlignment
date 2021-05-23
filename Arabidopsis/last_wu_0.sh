#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size


lastal col wu_0.fa > wu_0_lastal.maf
faSize -detailed wu_0.fa > wu_0.size
faToTwoBit wu_0.fa wu_0.2bit
maf-convert psl wu_0_lastal.maf > wu_0_lastal.psl
axtChain -linearGap=loose -psl wu_0_lastal.psl -faQ -faT tair10.fa wu_0.fa wu_0_lastal.chain
chainMergeSort wu_0_lastal.chain > wu_0_lastal.all.chain
chainPreNet wu_0_lastal.all.chain col.size wu_0.size wu_0_lastal.preNet
chainNet wu_0_lastal.preNet col.size wu_0.size wu_0_lastal.refTarget.net wu_0_lastal.chainNet
netToAxt wu_0_lastal.refTarget.net wu_0_lastal.preNet col.2bit wu_0.2bit stdout | axtSort stdin wu_0_lastal.axt
axtToMaf wu_0_lastal.axt col.size wu_0.size wu_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl wu_0_lastal_final.maf > wu_0_lastal_final_forsplit.maf
cat wu_0_lastal.maf | last-split | maf-swap | last-split | maf-swap > wu_0_lastal_split.maf
cat wu_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > wu_0_lastal_final_split.maf
perl lastToMafComparsion.pl wu_0_lastal_split.maf > wu_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl wu_0_lastal_final_split.maf > wu_0_lastal_final_split_Comparator.maf