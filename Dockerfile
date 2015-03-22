FROM hunterchung/eg-website-docker
MAINTAINER Hunter Chung <hchung@zymoresearch.com>

RUN sed -i.dist 's,universe$,universe multiverse,' /etc/apt/sources.list
RUN apt-get update && \
apt-get install -y \
    build-essential \
    liblapack-dev \
    # openjdk-7-jdk \
    r-base \
    samtools \
    # gnuplot \
    # libxml2-dev \
    # libxslt-dev \
    unzip \
    tabix \
    --no-install-recommends && \
rm -rf /var/lib/apt/lists/* && \
apt-get clean autoclean && \
apt-get autoremove -y

# # pip install
RUN pip install -U \
    filechunkio \
    # distribute \
    setuptools \
    fisher \
    numexpr \
    bottleneck \
    # Has trouble to install lxml
    # lxml \
    html5lib \
    beautifulsoup4 \
    MACS2 \
    scipy \
    pandas \
    scikit-learn \
    # ceas \
    cutadapt

# pytbles needs to be installed after numexpr.
RUN pip install \
    rpy2 \
    tables
    ipython \
    # isntall Qiime
    https://github.com/biocore/qiime/archive/1.9.0-rc2.tar.gz \
    # matplotlib \
    seaborn \
    matplotlib-venn

# Install packages.
ADD install_packages.sh
RUN bash install_packages.sh

# Django env path.
ENV PYTHONPATH=/var/www/EpiQuest_py
ENV DJANGO_SETTINGS_MODULE=EpiQuest_py.settings
ENV PATH=${PATH}:/usr/share/bowtie:/usr/share/bowtie2:/usr/share/genomicTools:/usr/share/bismark:/usr/share/trim_galore:/usr/share/tophat:/usr/share/cufflink:/usr/share/samtools

VOLUME /mnt
WORKDIR /mnt
