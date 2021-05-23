#!/bin/bash

lastdb -P 1 b73 Zea_mays.AGPv4.dna.toplevel.fa
faToTwoBit Zea_mays.AGPv4.dna.toplevel.fa b73.2bit
faSize -detailed Zea_mays.AGPv4.dna.toplevel.fa > b73.size


lastal b73 Zm-Mo17-REFERENCE-CAU-1.0.fa > mo17_lastal.maf
faSize -detailed Zm-Mo17-REFERENCE-CAU-1.0.fa > mo17.size
faToTwoBit Zm-Mo17-REFERENCE-CAU-1.0.fa mo17.2bit
maf-convert psl mo17_lastal.maf > mo17_lastal.psl
axtChain -linearGap=loose -psl mo17_lastal.psl -faQ -faT Zea_mays.AGPv4.34.gff3 Zm-Mo17-REFERENCE-CAU-1.0.fa mo17_lastal.chain
chainMergeSort mo17_lastal.chain > mo17_lastal.all.chain
chainPreNet mo17_lastal.all.chain b73.size mo17.size mo17_lastal.preNet
chainNet mo17_lastal.preNet b73.size mo17.size mo17_lastal.refTarget.net mo17_lastal.chainNet
netToAxt mo17_lastal.refTarget.net mo17_lastal.preNet b73.2bit mo17.2bit stdout | axtSort stdin mo17_lastal.axt
axtToMaf mo17_lastal.axt b73.size mo17.size mo17_lastal_final.maf -qPrefix=mo17. -tPrefix=b73.
perl lastFinalToSplit.pl mo17_lastal_final.maf > mo17_lastal_final_forsplit.maf
cat mo17_lastal.maf | last-split | python2 maf-swap | last-split | python2 maf-swap > mo17_lastal_split.maf
cat mo17_lastal_final_forsplit.maf | last-split | python2 maf-swap | last-split | python2 maf-swap > mo17_lastal_final_split.maf
perl lastToMafComparsion.pl mo17_lastal_split.maf > mo17_lastal_split_Comparator.maf
perl lastToMafComparsion.pl mo17_lastal_final_split.maf > mo17_lastal_final_split_Comparator.maf
