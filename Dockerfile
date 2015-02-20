FROM ipython/scipystack
MAINTAINER Hunter Chung <hchung@zymoresearch.com>

RUN sed -i.dist 's,universe$,universe multiverse,' /etc/apt/sources.list
RUN apt-get update && apt-get dist-upgrade -y -q \
vim \
wget \
pigz \
# Python related.
python-dev \
python-pip \
ipython \
ipython-notebook \
python-nose \
# AWS related
s3cmd \
ec2-api-tools \
ec2-ami-tools \
# database related
mysql-client \
sqlite3 \
# Others
libmysqlclient-dev \
libfreetype6-dev \
libpng-dev \
openjdk-7-jdk \
r-base \
samtools \
gnuplot
libxml2-dev \
libxslt-dev \
python2.7-dev \
unzip

# pip install
RUN pip2 install \
cython \
MySQL-python \
biopython \
xlwt \
xlrd \
django \
django-taggit \
natsort \
python-memcached \
boto \
pysam \
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

# pytbles needs to be installed after numexpr.
RUN pip2 install \
tables

# Install Qiime
pip2 install https://github.com/biocore/qiime/archive/1.9.0-rc2.tar.gz
# Test Qiime
print_qiime_config.py -t

# Add Bowtie 1.1.1
ADD https://github.com/BenLangmead/bowtie/archive/v1.1.1.tar.gz .
RUN tar zxvf v1.1.1.tar.gz
RUN rm -rf v1.1.1.tar.gz
RUN mv bowtie-1.1.1 /usr/share/
RUN ln -s /usr/share/bowtie-1.1.1 /usr/share/bowtie
# Add Bowtie 2.2.4
ADD https://github.com/BenLangmead/bowtie2/archive/v2.2.4.tar.gz .
RUN tar zxvf v2.2.4.tar.gz
RUN rm -rf /usr/share/v2.2.4.tar.gz
RUN mv bowtie2-2.2.4 /usr/share/
RUN ln -s /usr/share/bowtie2-2.2.4 /usr/share/bowtie2
# Add Bismark 0.13.1
ADD http://www.bioinformatics.bbsrc.ac.uk/projects/bismark/bismark_v0.13.1.tar.gz .
RUN tar zxvf bismark_v0.13.1.tar.gz
RUN rm -rf bismark_v0.13.1.tar.gz
RUN mv bismark_v0.13.1 /usr/share/
RUN ln -s /usr/share/bismark_v0.13.1 /usr/share/bismark
# Add Trim Galore! 0.3.7
ADD http://www.bioinformatics.bbsrc.ac.uk/projects/trim_galore/trim_galore_v0.3.7.zip .
RUN unzip trim_galore_v0.3.7.zip
RUN rm -rf trim_galore_v0.3.7.zip
RUN mv trim_galore_zip /usr/share/
RUN ln -s /usr/share/trim_galore_zip /usr/share/trim_galore
# Add TopHat 2.0.13
ADD http://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.13.Linux_x86_64.tar.gz .
RUN tar zxvf tophat-2.0.13.Linux_x86_64.tar.gz
RUN rm -rf tophat-2.0.13.Linux_x86_64.tar.gz
RUN mv tophat-2.0.13.Linux_x86_64 /usr/share/
RUN ln -s /usr/share/tophat-2.0.13.Linux_x86_64 /usr/share/tophat
# Add Cufflinks
ADD http://cole-trapnell-lab.github.io/cufflinks/assets/downloads/cufflinks-2.2.1.Linux_x86_64.tar.gz .
RUN tar zxvf cufflinks-2.2.1.Linux_x86_64.tar.gz
RUN rm -rf cufflinks-2.2.1.Linux_x86_64.tar.gz
RUN mv cufflinks-2.2.1.Linux_x86_64 /usr/share/
RUN ln -s /usr/share/cufflinks-2.2.1.Linux_x86_64 /usr/share/cufflinks
# Add CummeRbund


# Add genomic tools from UCSC genome browser.
RUN mkdir /usr/share/genomicTools
ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bigBedToBed /usr/share/genomicTools/
ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bedToBigBed /usr/share/genomicTools/
ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bedGraphToBigWig /usr/share/genomicTools/
ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bigWigToBedGraph /usr/share/genomicTools/
ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/wigToBigWig /usr/share/genomicTools/
ADD http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/bigWigToWig /usr/share/genomicTools/

# Django env path.
ENV PYTHONPATH=/var/www/EpiQuest_py
ENV DJANGO_SETTINGS_MODULE=EpiQuest_py.settings
ENV PATH=${PATH}:/usr/share/bowtie:/usr/share/bowtie2:/usr/share/genomicTools:/usr/share/bismark:/usr/share/trim_galore:/usr/share/tophat:/usr/share/cufflink:/usr/share/samtools

VOLUME /mnt
WORKDIR /mnt
