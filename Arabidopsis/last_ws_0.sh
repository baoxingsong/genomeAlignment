#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size


lastal col ws_0.fa > ws_0_lastal.maf
faSize -detailed ws_0.fa > ws_0.size
faToTwoBit ws_0.fa ws_0.2bit
maf-convert psl ws_0_lastal.maf > ws_0_lastal.psl
axtChain -linearGap=loose -psl ws_0_lastal.psl -faQ -faT tair10.fa ws_0.fa ws_0_lastal.chain
chainMergeSort ws_0_lastal.chain > ws_0_lastal.all.chain
chainPreNet ws_0_lastal.all.chain col.size ws_0.size ws_0_lastal.preNet
chainNet ws_0_lastal.preNet col.size ws_0.size ws_0_lastal.refTarget.net ws_0_lastal.chainNet
netToAxt ws_0_lastal.refTarget.net ws_0_lastal.preNet col.2bit ws_0.2bit stdout | axtSort stdin ws_0_lastal.axt
axtToMaf ws_0_lastal.axt col.size ws_0.size ws_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl ws_0_lastal_final.maf > ws_0_lastal_final_forsplit.maf
cat ws_0_lastal.maf | last-split | maf-swap | last-split | maf-swap > ws_0_lastal_split.maf
cat ws_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > ws_0_lastal_final_split.maf
perl lastToMafComparsion.pl ws_0_lastal_split.maf > ws_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl ws_0_lastal_final_split.maf > ws_0_lastal_final_split_Comparator.maf
