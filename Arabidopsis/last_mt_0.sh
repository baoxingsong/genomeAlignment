#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size



lastal col mt_0.fa > mt_0_lastal.maf
faSize -detailed mt_0.fa > mt_0.size
faToTwoBit mt_0.fa mt_0.2bit
maf-convert psl mt_0_lastal.maf > mt_0_lastal.psl
axtChain -linearGap=loose -psl mt_0_lastal.psl -faQ -faT tair10.fa mt_0.fa mt_0_lastal.chain
chainMergeSort mt_0_lastal.chain > mt_0_lastal.all.chain
chainPreNet mt_0_lastal.all.chain col.size mt_0.size mt_0_lastal.preNet
chainNet mt_0_lastal.preNet col.size mt_0.size mt_0_lastal.refTarget.net mt_0_lastal.chainNet
netToAxt mt_0_lastal.refTarget.net mt_0_lastal.preNet col.2bit mt_0.2bit stdout | axtSort stdin mt_0_lastal.axt
axtToMaf mt_0_lastal.axt col.size mt_0.size mt_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl mt_0_lastal_final.maf > mt_0_lastal_final_forsplit.maf
cat mt_0_lastal.maf | last-split | maf-swap | last-split | maf-swap > mt_0_lastal_split.maf
cat mt_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > mt_0_lastal_final_split.maf
perl lastToMafComparsion.pl mt_0_lastal_split.maf > mt_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl mt_0_lastal_final_split.maf > mt_0_lastal_final_split_Comparator.maf
