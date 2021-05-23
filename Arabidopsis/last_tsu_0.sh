#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size



lastal col tsu_0.fa > tsu_0_lastal.maf
faSize -detailed tsu_0.fa > tsu_0.size
faToTwoBit tsu_0.fa tsu_0.2bit
maf-convert psl tsu_0_lastal.maf > tsu_0_lastal.psl
axtChain -linearGap=loose -psl tsu_0_lastal.psl -faQ -faT tair10.fa tsu_0.fa tsu_0_lastal.chain
chainMergeSort tsu_0_lastal.chain > tsu_0_lastal.all.chain
chainPreNet tsu_0_lastal.all.chain col.size tsu_0.size tsu_0_lastal.preNet
chainNet tsu_0_lastal.preNet col.size tsu_0.size tsu_0_lastal.refTarget.net tsu_0_lastal.chainNet
netToAxt tsu_0_lastal.refTarget.net tsu_0_lastal.preNet col.2bit tsu_0.2bit stdout | axtSort stdin tsu_0_lastal.axt
axtToMaf tsu_0_lastal.axt col.size tsu_0.size tsu_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl tsu_0_lastal_final.maf > tsu_0_lastal_final_forsplit.maf
cat tsu_0_lastal.maf | last-split | maf-swap | last-split | maf-swap > tsu_0_lastal_split.maf
cat tsu_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > tsu_0_lastal_final_split.maf
perl lastToMafComparsion.pl tsu_0_lastal_split.maf > tsu_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl tsu_0_lastal_final_split.maf > tsu_0_lastal_final_split_Comparator.maf
