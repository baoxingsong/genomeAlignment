#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size




lastal col ct_1.fa > ct_1_lastal.maf
faSize -detailed ct_1.fa > ct_1.size
faToTwoBit ct_1.fa ct_1.2bit
maf-convert psl ct_1_lastal.maf > ct_1_lastal.psl
axtChain -linearGap=loose -psl ct_1_lastal.psl -faQ -faT tair10.fa ct_1.fa ct_1_lastal.chain
chainMergeSort ct_1_lastal.chain > ct_1_lastal.all.chain
chainPreNet ct_1_lastal.all.chain col.size ct_1.size ct_1_lastal.preNet
chainNet ct_1_lastal.preNet col.size ct_1.size ct_1_lastal.refTarget.net ct_1_lastal.chainNet
netToAxt ct_1_lastal.refTarget.net ct_1_lastal.preNet col.2bit ct_1.2bit stdout | axtSort stdin ct_1_lastal.axt
axtToMaf ct_1_lastal.axt col.size ct_1.size ct_1_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl ct_1_lastal_final.maf > ct_1_lastal_final_forsplit.maf
cat ct_1_lastal.maf | last-split | maf-swap | last-split | maf-swap >  ct_1_lastal_split.maf
cat ct_1_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap >  ct_1_lastal_final_split.maf
perl lastToMafComparsion.pl ct_1_lastal_split.maf > ct_1_lastal_split_Comparator.maf
perl lastToMafComparsion.pl ct_1_lastal_final_split.maf > ct_1_lastal_final_split_Comparator.maf
