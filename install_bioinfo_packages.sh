#!/usr/bin/env bash

wget "http://downloads.sourceforge.net/project/bowtie-bio/bowtie/1.1.1/bowtie-1.1.1-linux-x86_64.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fbowtie-bio%2Ffiles%2Fbowtie%2F1.1.1%2F&ts=1424587446&use_mirror=iweb" -O bowtie-1.1.1-linux-x86_64.zip
unzip bowtie-1.1.1-linux-x86_64.zip
rm bowtie-1.1.1-linux-x86_64.zip
mv bowtie-1.1.1 /usr/share/
ln -s /usr/share/bowtie-1.1.1 /usr/share/bowtie
# Add Bowtie 2.2.4
wget "http://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.5/bowtie2-2.2.5-linux-x86_64.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fbowtie-bio%2Ffiles%2Fbowtie2%2F2.2.5%2F&ts=1430783011&use_mirror=hivelocity" -O bowtie2-2.2.5-linux-x86_64.zip
unzip bowtie2-2.2.5-linux-x86_64.zip
rm bowtie2-2.2.5-linux-x86_64.zip
mv bowtie2-2.2.5 /usr/share/
ln -s /usr/share/bowtie2-2.2.5 /usr/share/bowtie2
# Add Bismark 0.13.1
wget http://www.bioinformatics.bbsrc.ac.uk/projects/bismark/bismark_v0.13.1.tar.gz
tar zxvf bismark_v0.13.1.tar.gz
rm bismark_v0.13.1.tar.gz
mv bismark_v0.13.1 /usr/share/
ln -s /usr/share/bismark_v0.13.1 /usr/share/bismark
# Add Trim Galore! 0.3.7
wget http://www.bioinformatics.bbsrc.ac.uk/projects/trim_galore/trim_galore_v0.3.7.zip
unzip trim_galore_v0.3.7.zip
rm trim_galore_v0.3.7.zip
mv trim_galore_zip /usr/share/
ln -s /usr/share/trim_galore_zip /usr/share/trim_galore
# Add TopHat 2.0.13
wget http://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.13.Linux_x86_64.tar.gz
tar zxvf tophat-2.0.13.Linux_x86_64.tar.gz
rm tophat-2.0.13.Linux_x86_64.tar.gz
mv tophat-2.0.13.Linux_x86_64 /usr/share/
ln -s /usr/share/tophat-2.0.13.Linux_x86_64 /usr/share/tophat
# Add Cufflinks
wget http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz
tar zxvf cufflinks-2.2.1.Linux_x86_64.tar.gz
rm cufflinks-2.2.1.Linux_x86_64.tar.gz
mv cufflinks-2.2.1.Linux_x86_64 /usr/share/
ln -s /usr/share/cufflinks-2.2.1.Linux_x86_64 /usr/share/cufflinks
# Add CummeRbund

# Add genomic tools from UCSC genome browser.
mkdir /usr/share/genomicTools
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bigBedToBed -O /usr/share/genomicTools/bigBedToBed
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bedToBigBed -O /usr/share/genomicTools/bedToBigBed
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bedGraphToBigWig -O /usr/share/genomicTools/bedGraphToBigWig
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bigWigToBedGraph -O /usr/share/genomicTools/bigWigToBedGraph
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/wigToBigWig -O /usr/share/genomicTools/wigToBigWig
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bigWigToWig -O /usr/share/genomicTools/bigWigToWig
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bedSort -O /usr/share/genomicTools/bedSort
chmod 755 /usr/share/genomicTools/*
