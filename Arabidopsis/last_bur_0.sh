#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size


lastal col bur_0.fa > bur_0_lastal.maf
faSize -detailed bur_0.fa > bur_0.size
faToTwoBit bur_0.fa bur_0.2bit
maf-convert psl bur_0_lastal.maf > bur_0_lastal.psl
axtChain -linearGap=loose -psl bur_0_lastal.psl -faQ -faT tair10.fa bur_0.fa bur_0_lastal.chain
chainMergeSort bur_0_lastal.chain > bur_0_lastal.all.chain
chainPreNet bur_0_lastal.all.chain col.size bur_0.size bur_0_lastal.preNet
chainNet bur_0_lastal.preNet col.size bur_0.size bur_0_lastal.refTarget.net bur_0_lastal.chainNet
netToAxt bur_0_lastal.refTarget.net bur_0_lastal.preNet col.2bit bur_0.2bit stdout | axtSort stdin bur_0_lastal.axt
axtToMaf bur_0_lastal.axt col.size bur_0.size bur_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl bur_0_lastal_final.maf > bur_0_lastal_final_forsplit.maf
cat bur_0_lastal.maf | last-split | maf-swap | last-split | maf-swap > bur_0_lastal_split.maf
cat bur_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > bur_0_lastal_final_split.maf
perl lastToMafComparsion.pl bur_0_lastal_split.maf > bur_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl bur_0_lastal_final_split.maf > bur_0_lastal_final_split_Comparator.maf
