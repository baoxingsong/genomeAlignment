#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size



lastal col po_0.fa > po_0_lastal.maf
faSize -detailed po_0.fa > po_0.size
faToTwoBit po_0.fa po_0.2bit
maf-convert psl po_0_lastal.maf > po_0_lastal.psl
axtChain -linearGap=loose -psl po_0_lastal.psl -faQ -faT tair10.fa po_0.fa po_0_lastal.chain
chainMergeSort po_0_lastal.chain > po_0_lastal.all.chain
chainPreNet po_0_lastal.all.chain col.size po_0.size po_0_lastal.preNet
chainNet po_0_lastal.preNet col.size po_0.size po_0_lastal.refTarget.net po_0_lastal.chainNet
netToAxt po_0_lastal.refTarget.net po_0_lastal.preNet col.2bit po_0.2bit stdout | axtSort stdin po_0_lastal.axt
axtToMaf po_0_lastal.axt col.size po_0.size po_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl po_0_lastal_final.maf > po_0_lastal_final_forsplit.maf
cat po_0_lastal.maf | last-split | maf-swap | last-split | maf-swap > po_0_lastal_split.maf
cat po_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > po_0_lastal_final_split.maf
perl lastToMafComparsion.pl po_0_lastal_split.maf > po_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl po_0_lastal_final_split.maf > po_0_lastal_final_split_Comparator.maf

