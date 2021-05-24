# genomeAlignment
Genome alignment tools are fundamental for comparative evolutionary analysis. Unlike initial genome sequencing efforts, which concentrated on cost-effective species, the aim of [Earth Biogenome Project](https://www.earthbiogenome.org/) for sequencing a million eukaryotic reference genomes would include a lot of species with complex genomes. Aligning those genomes provides a revolutionary opportunity to understand biodiversity on earth. We developed the [AnchorWave](https://github.com/baoxingsong/anchorwave) to improve the alignment of  transposon regions and regulatory elements and provides options to use known polyploidy levels or whole-genome duplications to inform alignment.  
We are comparing the performance of AnchorWave with different genome alignment tools for aligning genomes with different diversity.  
To make our comparison could be repeated easily, we organized all the commands, plot scripts, statistics script, plot and statistics summary into [Rmarkdown](https://bookdown.org/yihui/rmarkdown/) files.  
Those html and Rmarkdown files could not be viewed online well.  
Please clone the repository:
```
git clone https://github.com/baoxingsong/genomeAlignment.git
```

Please view the `pipeline.html` file under each folder using your web browser or view the `pipeline.Rmd` using [Rstudio](https://www.rstudio.com/).
1) [Synthetic benchmark via variant calling of 18 Arabidopsis accessions](./Arabidopsis/).
2) [Synthetic benchmark via removing ~60% of LTR retrotransposons from the maize B73 v4 assembly](./maizeTE/).
3) [Alignment between the maize B73 v4 and the Mo17 CAU assembly](./alignb73againstmo17/).
4) [Alignment between the maize B73 v4 and the B73-AB10 assembly](./B73-AB10/).
5) [Alignment between the maize B73 v4 and the small-kernel (SK) assembly](./maizeSK/).
6) [Alignment between the maize B73 v4 and the sorghum assembly](./sorghum_maize/).
7) [Alignment between the human (hg38) and the mouse (mm39) genome assembly](./hg38_mm39/).
8) [Alignment between the human (hg38) and the chimpanzee (pro3) genome assembly](./humanpro3/).
9) [Alignment between the goldfish and the zebrafish (GRCz10) genome assembly](./goldfish_zebrafish/).
10) [Investigate the collinearity between the human (hg38) and the axolotl genome assembly](./huamn_axolotl/).
11) [Investigate the collinearity between among a bunch of plant genome assemblies](./checkCollinearityAcroossAbunchOfPlantGenome/).

If you have any question, please feel free to send E-mail to songbaoxing168@163.com.
