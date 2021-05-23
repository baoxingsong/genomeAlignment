#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size



lastal col kn_0.fa > kn_0_lastal.maf
faSize -detailed kn_0.fa > kn_0.size
faToTwoBit kn_0.fa kn_0.2bit
python2 /programs/last-932/bin/maf-convert psl kn_0_lastal.maf > kn_0_lastal.psl
axtChain -linearGap=loose -psl kn_0_lastal.psl -faQ -faT tair10.fa kn_0.fa kn_0_lastal.chain
chainMergeSort kn_0_lastal.chain > kn_0_lastal.all.chain
chainPreNet kn_0_lastal.all.chain col.size kn_0.size kn_0_lastal.preNet
chainNet kn_0_lastal.preNet col.size kn_0.size kn_0_lastal.refTarget.net kn_0_lastal.chainNet
netToAxt kn_0_lastal.refTarget.net kn_0_lastal.preNet col.2bit kn_0.2bit stdout | axtSort stdin kn_0_lastal.axt
axtToMaf kn_0_lastal.axt col.size kn_0.size kn_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl kn_0_lastal_final.maf > kn_0_lastal_final_forsplit.maf
cat kn_0_lastal.maf | last-split | maf-swap | last-split | maf-swap > kn_0_lastal_split.maf
cat kn_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > kn_0_lastal_final_split.maf
perl lastToMafComparsion.pl kn_0_lastal_split.maf > kn_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl kn_0_lastal_final_split.maf > kn_0_lastal_final_split_Comparator.maf
