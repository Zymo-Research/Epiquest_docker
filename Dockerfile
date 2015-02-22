FROM hunterchung/eg-website-docker
MAINTAINER Hunter Chung <hchung@zymoresearch.com>

RUN sed -i.dist 's,universe$,universe multiverse,' /etc/apt/sources.list
RUN apt-get update && apt-get dist-upgrade -y -q \
openjdk-7-jdk \
r-base \
samtools \
gnuplot \
libxml2-dev \
libxslt-dev \
python2.7-dev \
unzip \
tabix

# pip install
RUN pip2 install \
cython \
filechunkio \
rpy2 \
fisher \
numexpr \
bottleneck \
sqlalchemy \
# Has trouble to install lxml
# lxml \
html5lib \
beautifulsoup4 \
matplotlib-venn \
MACS2 \
# ceas \
cutadapt

# Install s3cmd 1.5.2.
ADD https://github.com/s3tools/s3cmd/archive/v1.5.2.tar.gz /tmp/
RUN tar zxvf v1.5.2.tar.gz
RUN mv /usr/share/s3cmd /usr/share/s3cmd_old
RUN mv s3cmd-1.5.2 /usr/share/
RUN ln -s /usr/share/s3cmd-1.5.2 /usr/share/s3cmd

# pytbles needs to be installed after numexpr.
RUN pip2 install \
tables

# Install Qiime 1.9.0-rc2
pip2 install https://github.com/biocore/qiime/archive/1.9.0-rc2.tar.gz
# Test Qiime
print_qiime_config.py -t

# Add Bowtie 1.1.1
RUN curl -L "http://downloads.sourceforge.net/project/bowtie-bio/bowtie/1.1.1/bowtie-1.1.1-linux-x86_64.zip?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fbowtie-bio%2Ffiles%2Fbowtie%2F1.1.1%2F&ts=1424587446&use_mirror=iweb" > bowtie-1.1.1-linux-x86_64.zip
# RUN tar zxvf v1.1.1.tar.gz
RUN unzip bowtie-1.1.1-linux-x86_64.zip
RUN mv bowtie-1.1.1 /usr/share/
RUN ln -s /usr/share/bowtie-1.1.1 /usr/share/bowtie
# Add Bowtie 2.2.4
ADD https://github.com/BenLangmead/bowtie2/archive/v2.2.4.tar.gz /tmp/
RUN tar zxvf v2.2.4.tar.gz
RUN mv bowtie2-2.2.4 /usr/share/
RUN ln -s /usr/share/bowtie2-2.2.4 /usr/share/bowtie2
# Add Bismark 0.13.1
ADD http://www.bioinformatics.bbsrc.ac.uk/projects/bismark/bismark_v0.13.1.tar.gz /tmp/
RUN tar zxvf bismark_v0.13.1.tar.gz
RUN mv bismark_v0.13.1 /usr/share/
RUN ln -s /usr/share/bismark_v0.13.1 /usr/share/bismark
# Add Trim Galore! 0.3.7
ADD http://www.bioinformatics.bbsrc.ac.uk/projects/trim_galore/trim_galore_v0.3.7.zip /tmp/
RUN unzip trim_galore_v0.3.7.zip
RUN mv trim_galore_zip /usr/share/
RUN ln -s /usr/share/trim_galore_zip /usr/share/trim_galore
# Add TopHat 2.0.13
ADD http://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.13.Linux_x86_64.tar.gz /tmp/
RUN tar zxvf tophat-2.0.13.Linux_x86_64.tar.gz
RUN mv tophat-2.0.13.Linux_x86_64 /usr/share/
RUN ln -s /usr/share/tophat-2.0.13.Linux_x86_64 /usr/share/tophat
# Add Cufflinks
ADD http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz /tmp/
RUN tar zxvf cufflinks-2.2.1.Linux_x86_64.tar.gz
RUN mv cufflinks-2.2.1.Linux_x86_64 /usr/share/
RUN ln -s /usr/share/cufflinks-2.2.1.Linux_x86_64 /usr/share/cufflinks
# Add CummeRbund

# Cleanup.
RUN rm -rf /tmp/*


# Add genomic tools from UCSC genome browser.
RUN mkdir /usr/share/genomicTools
ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bigBedToBed /usr/share/genomicTools/
ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bedToBigBed /usr/share/genomicTools/
ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bedGraphToBigWig /usr/share/genomicTools/
ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bigWigToBedGraph /usr/share/genomicTools/
ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/wigToBigWig /usr/share/genomicTools/
ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bigWigToWig /usr/share/genomicTools/
RUN chmod 755 /usr/share/genomicTools/*

# Django env path.
ENV PYTHONPATH=/var/www/EpiQuest_py
ENV DJANGO_SETTINGS_MODULE=EpiQuest_py.settings
ENV PATH=${PATH}:/usr/share/bowtie:/usr/share/bowtie2:/usr/share/genomicTools:/usr/share/bismark:/usr/share/trim_galore:/usr/share/tophat:/usr/share/cufflink:/usr/share/samtools

VOLUME /mnt
WORKDIR /mnt
