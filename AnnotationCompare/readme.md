The genome annotation is essential to provide candidate anchors for AnchorWave, while the quality of genome annotation varies from species to species. Here we test AnchorWave with low quality genome annotation (only ab initio predictions).

# perform genome alignemnt 
##1.1 perform genome alignment and the annotation file is published on :ftp://ftp.ensemblgenomes.org/pub/plants/release-34/gff3/zea_mays/Zea_mays.AGPv4.34.gff3.gz
gunzip Zea_mays.AGPv4.34.gff3.gz

```
/usr/bin/time ./code/anchorwave proali -i Zea_mays.AGPv4.34.gff3 -as cds.fa -r Zea_mays.AGPv4.dna.toplevel.fa -a cds.sam -ar ref.sam -s Sorghum_bicolor.Sorghum_bicolor_NCBIv3.dna.toplevel.fa -n anchorwave.anchors -R 1 -Q 2 -o align1.maf -f anchorwave.f.maf 

```
## 1.2 use augustus and the maize model to predict genome annotation
```
# predict  genome annotation
augustus --species=maize Zea_mays.AGPv4.dna.toplevel.fa > test.gff
cat test.gff | sed -e '~s/\(g[0-9]\+\).t\([0-9]\+\)$/ID=\1.t\2;Parent=\1;/g' | sed -e '~s/transcript_id \"/Parent=/g' | sed -e '~s/\"\; /;/g' > test.v2.gff
#perform genome alignment
anchorwave gff2seq -i test11.gff3 -r Zea_mays.AGPv4.dna.toplevel.fa -o cds.fa
minimap2 -x splice -a -t 10 -p 0.4 -N 20 Zea_mays.AGPv4.dna.toplevel.fa cds.fa > ref.sam
minimap2 -x splice -a -t 5 -p 0.4 -N 20 Sorghum_bicolor.Sorghum_bicolor_NCBIv3.dna.toplevel.fa cds.fa > cds.sam
anchorwave proali -i test.v2.gff -as cds.fa -r Zea_mays.AGPv4.dna.toplevel.fa -a cds.sam -ar ref.sam -s Sorghum_bicolor.Sorghum_bicolor_NCBIv3.dna.toplevel.fa -n align.anchors -R 1 -Q 2 -o alignmentmaize.maf -f alignmentmaize.f.maf -IV
```

## 1.3 use augustus and the arabidopsis model to predict genome annotation

```
# predict  genome annotation
augustus --species=arabidopsis Zea_mays.AGPv4.dna.toplevel.fa > arabidosis_model_maize_genome.gff
cat arabidosis_model_maize_genome.gff | sed -e '~s/\(g[0-9]\+\).t\([0-9]\+\)$/ID=\1.t\2;Parent=\1;/g' | sed -e '~s/transcript_id \"/Parent=/g' | sed -e '~s/\"\; /;/g' > newarabidosis_model_maize_genome.gff

# perform genome alignment
anchorwave gff2seq -i newarabidosis_model_maize_genome.gff -r Zea_mays.AGPv4.dna.toplevel.fa -o cds.fa
minimap2 -x splice -a -t 10 -p 0.4 -N 20 Zea_mays.AGPv4.dna.toplevel.fa cds.fa > ref.sam
minimap2 -x splice -a -t 10 -p 0.4 -N 20 Sorghum_bicolor.Sorghum_bicolor_NCBIv3.dna.toplevel.fa cds.fa > cds.sam
anchorwave proali -i newarabidosis_model_maize_genome.gff -as cds.fa -r Zea_mays.AGPv4.dna.toplevel.fa -a cds.sam -ar ref.sam -s Sorghum_bicolor.Sorghum_bicolor_NCBIv3.dna.toplevel.fa -n align.anchors -R 1 -Q 2 -o alignmentara.maf -f alignmentara.f.maf -IV
```




## summarize the alignmetn reults
We used the following commands to count, the number of aligned sites，the number of position match sites  in maize TE regions, the number of reference sites 
being aligned and aligned as position.
We implement these scripts in different files.

```
download TE annototion files by follow step:
wget https://github.com/mcstitzer/maize_TEs/raw/master/B73.structuralTEv2.disjoined.2018-09-19.gff3.gz
gunzip B73.structuralTEv2.disjoined.2018-09-19.gff3.gz
grep -v "#" B73.structuralTEv2.disjoined.2018-09-19.gff3 | awk '{print $1"\t"$4-1"\t"$5}'  | bedtools sort | bedtools merge  > B73.structuralTEv2.disjoined.2018-09-19.bed
```

## published annotation
```
maf-convert sam align1.maf | sed 's/Sorghum_bicolor.Sorghum_bicolor_NCBIv3.dna.toplevel.fa.//g' | sed 's/Zea_mays.AGPv4.dna.toplevel.fa.//g' | samtools view -O BAM --reference Zea_mays.AGPv4.dna.toplevel.fa - | samtools sort - > anchorwave.bam
samtools mpileup anchorwave.bam | wc -l  #1867994503
samtools depth anchorwave.bam | wc -l  #1867994503
samtools depth anchorwave.bam | awk '$3>0{print $0}' | wc -l #129245594
samtools depth anchorwave.bam -b ../b73to-ara/B73.structuralTEv2.disjoined.2018-09-19.bed | wc -l #1306296703
samtools depth anchorwave.bam -b ../b73to-ara/B73.structuralTEv2.disjoined.2018-09-19.bed | awk '$3>0{print $0}' | wc -l #28441904
```

## augustus maize model predicted annotation
```
maf-convert sam alignmentara.maf | sed 's/Sorghum_bicolor.Sorghum_bicolor_NCBIv3.dna.toplevel.fa.//g' | sed 's/Zea_mays.AGPv4.dna.toplevel.fa.//g' | samtools view -O BAM --reference Zea_mays.AGPv4.dna.toplevel.fa - | samtools sort - > anchorwave.bam
samtools mpileup anchorwave.bam | wc -l  #1732110851
samtools depth anchorwave.bam | wc -l   #1732110851
samtools depth anchorwave.bam | awk '$3>0{print $0}' | wc -l #128022971
samtools depth anchorwave.bam -b B73.structuralTEv2.disjoined.2018-09-19.bed | wc -l #1206887848
samtools depth anchorwave.bam -b B73.structuralTEv2.disjoined.2018-09-19.bed | awk '$3>0{print $0}' | wc -l # 26876801
```

## augustus arabidopsis model predicted annotation
```
maf-convert sam alignmentmaize.maf | sed 's/Sorghum_bicolor.Sorghum_bicolor_NCBIv3.dna.toplevel.fa.//g' | sed 's/Zea_mays.AGPv4.dna.toplevel.fa.//g' | samtools view -O BAM --reference Zea_mays.AGPv4.dna.toplevel.fa - | samtools sort - > anchorwave.bam
samtools mpileup anchorwave.bam | wc -l  #1891858585
samtools depth anchorwave.bam | wc -l   #1891858585
samtools depth anchorwave.bam | awk '$3>0{print $0}' | wc -l#125648374
samtools depth anchorwave.bam -b ../b73to-ara/B73.structuralTEv2.disjoined.2018-09-19.bed | wc -l#1323846307
samtools depth anchorwave.bam -b ../b73to-ara/B73.structuralTEv2.disjoined.2018-09-19.bed | awk '$3>0{print $0}' | wc -l #27105038
```
