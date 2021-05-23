#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size


lastal col sf_2.fa > sf_2_lastal.maf
faSize -detailed sf_2.fa > sf_2.size
faToTwoBit sf_2.fa sf_2.2bit
maf-convert psl sf_2_lastal.maf > sf_2_lastal.psl
axtChain -linearGap=loose -psl sf_2_lastal.psl -faQ -faT tair10.fa sf_2.fa sf_2_lastal.chain
chainMergeSort sf_2_lastal.chain > sf_2_lastal.all.chain
chainPreNet sf_2_lastal.all.chain col.size sf_2.size sf_2_lastal.preNet
chainNet sf_2_lastal.preNet col.size sf_2.size sf_2_lastal.refTarget.net sf_2_lastal.chainNet
netToAxt sf_2_lastal.refTarget.net sf_2_lastal.preNet col.2bit sf_2.2bit stdout | axtSort stdin sf_2_lastal.axt
axtToMaf sf_2_lastal.axt col.size sf_2.size sf_2_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl sf_2_lastal_final.maf > sf_2_lastal_final_forsplit.maf
cat sf_2_lastal.maf | last-split | maf-swap | last-split | maf-swap > sf_2_lastal_split.maf
cat sf_2_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > sf_2_lastal_final_split.maf
perl lastToMafComparsion.pl sf_2_lastal_split.maf > sf_2_lastal_split_Comparator.maf
perl lastToMafComparsion.pl sf_2_lastal_final_split.maf > sf_2_lastal_final_split_Comparator.maf