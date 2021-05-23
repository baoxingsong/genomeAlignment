#!/bin/bash

lastdb -P 1 col tair10.fa
faToTwoBit tair10.fa col.2bit
faSize -detailed tair10.fa > col.size



lastal col edi_0.fa > edi_0_lastal.maf
faSize -detailed edi_0.fa > edi_0.size
faToTwoBit edi_0.fa edi_0.2bit
maf-convert psl edi_0_lastal.maf > edi_0_lastal.psl
axtChain -linearGap=loose -psl edi_0_lastal.psl -faQ -faT tair10.fa edi_0.fa edi_0_lastal.chain
chainMergeSort edi_0_lastal.chain > edi_0_lastal.all.chain
chainPreNet edi_0_lastal.all.chain col.size edi_0.size edi_0_lastal.preNet
chainNet edi_0_lastal.preNet col.size edi_0.size edi_0_lastal.refTarget.net edi_0_lastal.chainNet
netToAxt edi_0_lastal.refTarget.net edi_0_lastal.preNet col.2bit edi_0.2bit stdout | axtSort stdin edi_0_lastal.axt
axtToMaf edi_0_lastal.axt col.size edi_0.size edi_0_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl edi_0_lastal_final.maf > edi_0_lastal_final_forsplit.maf
cat edi_0_lastal.maf | last-split | maf-swap | last-split | maf-swap > edi_0_lastal_split.maf
cat edi_0_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > edi_0_lastal_final_split.maf
perl lastToMafComparsion.pl edi_0_lastal_split.maf > edi_0_lastal_split_Comparator.maf
perl lastToMafComparsion.pl edi_0_lastal_final_split.maf > edi_0_lastal_final_split_Comparator.maf