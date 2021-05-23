#!/bin/bash
lastdb -P 1 maize Zea_mays.AGPv4.dna.toplevel.fa
faToTwoBit Zea_mays.AGPv4.dna.toplevel.fa maize.2bit
faSize -detailed Zea_mays.AGPv4.dna.toplevel.fa > maize.size
lastal maize Sorghum_bicolor.Sorghum_bicolor_NCBIv3.dna.toplevel.fa > sorghum_lastal.maf
faSize -detailed Sorghum_bicolor.Sorghum_bicolor_NCBIv3.dna.toplevel.fa > sorghum.size
faToTwoBit Sorghum_bicolor.Sorghum_bicolor_NCBIv3.dna.toplevel.fa sorghum.2bit
python2 /programs/last-932/bin/maf-convert psl sorghum_lastal.maf > sorghum_lastal.psl

axtChain -linearGap=loose -psl sorghum_lastal.psl -faQ -faT Zea_mays.AGPv4.dna.toplevel.fa Sorghum_bicolor.Sorghum_bicolor_NCBIv3.dna.toplevel.fa sorghum_lastal.chain
chainMergeSort sorghum_lastal.chain > sorghum_lastal.all.chain
chainPreNet sorghum_lastal.all.chain maize.size sorghum.size sorghum_lastal.preNet
chainNet sorghum_lastal.preNet maize.size sorghum.size sorghum_lastal.refTarget.net sorghum_lastal.chainNet
netToAxt sorghum_lastal.refTarget.net sorghum_lastal.preNet maize.2bit sorghum.2bit stdout | axtSort stdin sorghum_lastal.axt
axtToMaf sorghum_lastal.axt maize.size sorghum.size sorghum_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl sorghum_lastal_final.maf > sorghum_lastal_final_forsplit.maf

cat sorghum_lastal.maf | last-split > sorghum_lastal_split.maf
cat sorghum_lastal_final_forsplit.maf | last-split > sorghum_lastal_final_split.maf
perl lastToMafComparsion.pl sorghum_lastal_split.maf > sorghum_lastal_split_Comparator.maf
perl lastToMafComparsion.pl sorghum_lastal_final_split.maf > sorghum_lastal_final_split_Comparator.maf


cat sorghum_lastal.maf | last-split | python2 /programs/last-932/bin/maf-swap | last-split | python2 /programs/last-932/bin/maf-swap > sorghum_lastal_split_swap_split.maf
cat sorghum_lastal_final_forsplit.maf | last-split | python2 /programs/last-932/bin/maf-swap | last-split | python2 /programs/last-932/bin/maf-swap > sorghum_lastal_final_split_swap_split.maf
cat sorghum_lastal.maf | last-split > sorghum_lastal_split.maf
cat sorghum_lastal_final_forsplit.maf | last-split > sorghum_lastal_final_split.maf




