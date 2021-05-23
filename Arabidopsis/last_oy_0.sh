#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size


lastal col oy_0.fa > oy_0_lastal.maf
faSize -detailed oy_0.fa > oy_0.size
faToTwoBit oy_0.fa oy_0.2bit
maf-convert psl oy_0_lastal.maf > oy_0_lastal.psl
axtChain -linearGap=loose -psl oy_0_lastal.psl -faQ -faT tair10.fa oy_0.fa oy_0_lastal.chain
chainMergeSort oy_0_lastal.chain > oy_0_lastal.all.chain
chainPreNet oy_0_lastal.all.chain col.size oy_0.size oy_0_lastal.preNet
chainNet oy_0_lastal.preNet col.size oy_0.size oy_0_lastal.refTarget.net oy_0_lastal.chainNet
netToAxt oy_0_lastal.refTarget.net oy_0_lastal.preNet col.2bit oy_0.2bit stdout | axtSort stdin oy_0_lastal.axt
axtToMaf oy_0_lastal.axt col.size oy_0.size oy_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl oy_0_lastal_final.maf > oy_0_lastal_final_forsplit.maf
cat oy_0_lastal.maf | last-split | maf-swap | last-split | maf-swap > oy_0_lastal_split.maf
cat oy_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > oy_0_lastal_final_split.maf
perl lastToMafComparsion.pl oy_0_lastal_split.maf > oy_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl oy_0_lastal_final_split.maf > oy_0_lastal_final_split_Comparator.maf