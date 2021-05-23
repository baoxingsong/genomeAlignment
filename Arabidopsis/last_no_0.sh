#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size


lastal col no_0.fa > no_0_lastal.maf
faSize -detailed no_0.fa > no_0.size
faToTwoBit no_0.fa no_0.2bit
maf-convert psl no_0_lastal.maf > no_0_lastal.psl
axtChain -linearGap=loose -psl no_0_lastal.psl -faQ -faT tair10.fa no_0.fa no_0_lastal.chain
chainMergeSort no_0_lastal.chain > no_0_lastal.all.chain
chainPreNet no_0_lastal.all.chain col.size no_0.size no_0_lastal.preNet
chainNet no_0_lastal.preNet col.size no_0.size no_0_lastal.refTarget.net no_0_lastal.chainNet
netToAxt no_0_lastal.refTarget.net no_0_lastal.preNet col.2bit no_0.2bit stdout | axtSort stdin no_0_lastal.axt
axtToMaf no_0_lastal.axt col.size no_0.size no_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl no_0_lastal_final.maf > no_0_lastal_final_forsplit.maf
cat no_0_lastal.maf | last-split | maf-swap | last-split | maf-swap > no_0_lastal_split.maf
cat no_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > no_0_lastal_final_split.maf
perl lastToMafComparsion.pl no_0_lastal_split.maf > no_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl no_0_lastal_final_split.maf > no_0_lastal_final_split_Comparator.maf
