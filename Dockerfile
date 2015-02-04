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
python2.7-dev

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
