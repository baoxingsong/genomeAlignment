#!/bin/bash
lastdb -P 1 B73v4 Zea_mays.AGPv4.dna.toplevel.fa
faToTwoBit Zea_mays.AGPv4.dna.toplevel.fa B73v4.2bit
faSize -detailed Zea_mays.AGPv4.dna.toplevel.fa > B73v4.size
lastal B73v4 B73V4.pseudomolecule.subtract1.fa > subtract1_lastal.maf
faSize -detailed B73V4.pseudomolecule.subtract1.fa > subtract.size
faToTwoBit B73V4.pseudomolecule.subtract1.fa subtract.2bit
python2 /programs/last-932/bin/maf-convert psl subtract1_lastal.maf > subtract1_lastal.psl
axtChain -linearGap=loose -psl subtract1_lastal.psl -faQ -faT Zea_mays.AGPv4.dna.toplevel.fa B73V4.pseudomolecule.subtract1.fa subtract1_lastal.chain
chainMergeSort subtract1_lastal.chain > subtract1_lastal.all.chain
chainPreNet subtract1_lastal.all.chain B73v4.size subtract.size subtract1_lastal.preNet
chainNet subtract1_lastal.preNet B73v4.size subtract.size subtract1_lastal.refTarget.net subtract1_lastal.chainNet
netToAxt subtract1_lastal.refTarget.net subtract1_lastal.preNet B73v4.2bit subtract.2bit stdout | axtSort stdin subtract1_lastal.axt
axtToMaf subtract1_lastal.axt B73v4.size subtract.size subtract1_lastal_final.maf -qPrefix=query. -tPrefix=col.
perl lastFinalToSplit.pl subtract1_lastal_final.maf > subtract1_lastal_lastal_final_forsplit.maf
cat subtract1_lastal.maf | last-split | maf-swap | last-split | maf-swap  > subtract1_lastal_split.maf
cat subtract1_lastal_lastal_final_forsplit.maf | last-split | maf-swap | last-split | maf-swap > subtract1_lastal_final_split.maf
perl lastToMafComparsion.pl subtract1_lastal_split.maf > subtract1_lastal_lastal_split_Comparator.maf
perl lastToMafComparsion.pl subtract1_lastal_final_split.maf > subtract1_lastal_final_split_Comparator.maf
