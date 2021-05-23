#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size


lastal col ler_0.fa > ler_0_lastal.maf
faSize -detailed ler_0.fa > ler_0.size
faToTwoBit ler_0.fa ler_0.2bit
maf-convert psl ler_0_lastal.maf > ler_0_lastal.psl
axtChain -linearGap=loose -psl ler_0_lastal.psl -faQ -faT tair10.fa ler_0.fa ler_0_lastal.chain
chainMergeSort ler_0_lastal.chain > ler_0_lastal.all.chain
chainPreNet ler_0_lastal.all.chain col.size ler_0.size ler_0_lastal.preNet
chainNet ler_0_lastal.preNet col.size ler_0.size ler_0_lastal.refTarget.net ler_0_lastal.chainNet
netToAxt ler_0_lastal.refTarget.net ler_0_lastal.preNet col.2bit ler_0.2bit stdout | axtSort stdin ler_0_lastal.axt
axtToMaf ler_0_lastal.axt col.size ler_0.size ler_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl ler_0_lastal_final.maf > ler_0_lastal_final_forsplit.maf
cat ler_0_lastal.maf | last-split | maf-swap | last-split | maf-swap > ler_0_lastal_split.maf
cat ler_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > ler_0_lastal_final_split.maf
perl lastToMafComparsion.pl ler_0_lastal_split.maf > ler_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl ler_0_lastal_final_split.maf > ler_0_lastal_final_split_Comparator.maf
