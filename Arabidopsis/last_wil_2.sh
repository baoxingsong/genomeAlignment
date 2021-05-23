#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size



lastal col wil_2.fa > wil_2_lastal.maf
faSize -detailed wil_2.fa > wil_2.size
faToTwoBit wil_2.fa wil_2.2bit
maf-convert psl wil_2_lastal.maf > wil_2_lastal.psl
axtChain -linearGap=loose -psl wil_2_lastal.psl -faQ -faT tair10.fa wil_2.fa wil_2_lastal.chain
chainMergeSort wil_2_lastal.chain > wil_2_lastal.all.chain
chainPreNet wil_2_lastal.all.chain col.size wil_2.size wil_2_lastal.preNet
chainNet wil_2_lastal.preNet col.size wil_2.size wil_2_lastal.refTarget.net wil_2_lastal.chainNet
netToAxt wil_2_lastal.refTarget.net wil_2_lastal.preNet col.2bit wil_2.2bit stdout | axtSort stdin wil_2_lastal.axt
axtToMaf wil_2_lastal.axt col.size wil_2.size wil_2_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl wil_2_lastal_final.maf > wil_2_lastal_final_forsplit.maf
cat wil_2_lastal.maf | last-split | maf-swap | last-split | maf-swap > wil_2_lastal_split.maf
cat wil_2_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > wil_2_lastal_final_split.maf
perl lastToMafComparsion.pl wil_2_lastal_split.maf > wil_2_lastal_split_Comparator.maf
perl lastToMafComparsion.pl wil_2_lastal_final_split.maf > wil_2_lastal_final_split_Comparator.maf
