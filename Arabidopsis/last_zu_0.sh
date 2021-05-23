#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size




lastal col zu_0.fa > zu_0_lastal.maf
faSize -detailed zu_0.fa > zu_0.size
faToTwoBit zu_0.fa zu_0.2bit
maf-convert psl zu_0_lastal.maf > zu_0_lastal.psl
axtChain -linearGap=loose -psl zu_0_lastal.psl -faQ -faT tair10.fa zu_0.fa zu_0_lastal.chain
chainMergeSort zu_0_lastal.chain > zu_0_lastal.all.chain
chainPreNet zu_0_lastal.all.chain col.size zu_0.size zu_0_lastal.preNet
chainNet zu_0_lastal.preNet col.size zu_0.size zu_0_lastal.refTarget.net zu_0_lastal.chainNet
netToAxt zu_0_lastal.refTarget.net zu_0_lastal.preNet col.2bit zu_0.2bit stdout | axtSort stdin zu_0_lastal.axt
axtToMaf zu_0_lastal.axt col.size zu_0.size zu_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl zu_0_lastal_final.maf > zu_0_lastal_final_forsplit.maf
cat zu_0_lastal.maf | last-split | maf-swap | last-split | maf-swap > zu_0_lastal_split.maf
cat zu_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > zu_0_lastal_final_split.maf
perl lastToMafComparsion.pl zu_0_lastal_split.maf > zu_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl zu_0_lastal_final_split.maf > zu_0_lastal_final_split_Comparator.maf
