# genomeAlignment
Genome alignment tools are fundamental for comparative evolutionary analysis. Unlike initial genome sequencing efforts, which concentrated on cost-effective species, the aim of [Earth Biogenome Project](https://www.earthbiogenome.org/) for sequencing a million eukaryotic reference genomes would include a lot of species with complex genomes. Aligning those genomes provides a revolutionary opportunity to understand biodiversity on earth. We developed the [AnchorWave](https://github.com/baoxingsong/anchorwave) to improve the alignment of  transposon regions and regulatory elements and provides options to use known polyploidy levels or whole-genome duplications to inform alignment.  
We are comparing the performance of AnchorWave with different genome alignment tools for aligning genomes with different diversity.  
To make our comparison could be repeated easily, we organized all the commands, plot scripts, statistics script, plot and statistics summary into [Rmarkdown](https://bookdown.org/yihui/rmarkdown/) files.  

1) [Synthetic benchmark via variant calling of 18 Arabidopsis accessions](./Arabidopsis/).
2) [Synthetic benchmark via removing ~60% of LTR retrotransposons from the maize B73 v4 assembly](./maizeTE/).
3) [Alignment between the maize B73 v4 and the Mo17 CAU assembly](./alignb73againstmo17/).
4) [Alignment between the maize B73 v4 and the B73-AB10 assembly](./B73-AB10/).
5) [Alignment between the maize B73 v4 and the sorghum assembly](./sorghum_maize/).

If you have any questions please feel free to send E-mail to songbaoxing168@163.com.
