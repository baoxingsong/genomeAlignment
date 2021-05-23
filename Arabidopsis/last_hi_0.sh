#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size




lastal col hi_0.fa > hi_0_lastal.maf
faSize -detailed hi_0.fa > hi_0.size
faToTwoBit hi_0.fa hi_0.2bit
maf-convert psl hi_0_lastal.maf > hi_0_lastal.psl
axtChain -linearGap=loose -psl hi_0_lastal.psl -faQ -faT tair10.fa hi_0.fa hi_0_lastal.chain
chainMergeSort hi_0_lastal.chain > hi_0_lastal.all.chain
chainPreNet hi_0_lastal.all.chain col.size hi_0.size hi_0_lastal.preNet
chainNet hi_0_lastal.preNet col.size hi_0.size hi_0_lastal.refTarget.net hi_0_lastal.chainNet
netToAxt hi_0_lastal.refTarget.net hi_0_lastal.preNet col.2bit hi_0.2bit stdout | axtSort stdin hi_0_lastal.axt
axtToMaf hi_0_lastal.axt col.size hi_0.size hi_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl hi_0_lastal_final.maf > hi_0_lastal_final_forsplit.maf
cat hi_0_lastal.maf | last-split | maf-swap | last-split | maf-swap > hi_0_lastal_split.maf
cat hi_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > hi_0_lastal_final_split.maf
perl lastToMafComparsion.pl hi_0_lastal_split.maf > hi_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl hi_0_lastal_final_split.maf > hi_0_lastal_final_split_Comparator.maf
