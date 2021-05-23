#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size


lastal col rsch_4.fa > rsch_4_lastal.maf
faSize -detailed rsch_4.fa > rsch_4.size
faToTwoBit rsch_4.fa rsch_4.2bit
maf-convert psl rsch_4_lastal.maf > rsch_4_lastal.psl
axtChain -linearGap=loose -psl rsch_4_lastal.psl -faQ -faT tair10.fa rsch_4.fa rsch_4_lastal.chain
chainMergeSort rsch_4_lastal.chain > rsch_4_lastal.all.chain
chainPreNet rsch_4_lastal.all.chain col.size rsch_4.size rsch_4_lastal.preNet
chainNet rsch_4_lastal.preNet col.size rsch_4.size rsch_4_lastal.refTarget.net rsch_4_lastal.chainNet
netToAxt rsch_4_lastal.refTarget.net rsch_4_lastal.preNet col.2bit rsch_4.2bit stdout | axtSort stdin rsch_4_lastal.axt
axtToMaf rsch_4_lastal.axt col.size rsch_4.size rsch_4_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl rsch_4_lastal_final.maf > rsch_4_lastal_final_forsplit.maf
cat rsch_4_lastal.maf | last-split | maf-swap | last-split | maf-swap > rsch_4_lastal_split.maf
cat rsch_4_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > rsch_4_lastal_final_split.maf
perl lastToMafComparsion.pl rsch_4_lastal_split.maf > rsch_4_lastal_split_Comparator.maf
perl lastToMafComparsion.pl rsch_4_lastal_final_split.maf > rsch_4_lastal_final_split_Comparator.maf