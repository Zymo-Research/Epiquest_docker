FROM hunterchung/eg-website-docker
MAINTAINER Hunter Chung <hchung@zymoresearch.com>

RUN sed -i.dist 's,universe$,universe multiverse,' /etc/apt/sources.list
RUN apt-get update && \
apt-get install -y \
    curl \
    build-essential \
    libkrb5-3 \
    gfortran \
    liblapack-dev \
    libhdf5-dev \
    r-base \
    samtools \
    libfreetype6-dev \
    libpng-dev \
    libreadline6 \
    libreadline6-dev \
    unzip \
    tabix \
    --no-install-recommends && \
rm -rf /var/lib/apt/lists/* && \
apt-get clean autoclean && \
apt-get autoremove -y

# Install packages.
ADD install_python_packages.sh /tmp/install_python_packages.sh
RUN bash /tmp/install_python_packages.sh

ADD install_bioinfo_packages.sh /tmp/install_bioinfo_packages.sh
RUN bash /tmp/install_bioinfo_packages.sh

# Django env path.
ENV DJANGO_SETTINGS_MODULE=EpiQuest_py.settings
ENV PATH=${PATH}:/usr/share/bowtie:/usr/share/bowtie2:/usr/share/genomicTools:/usr/share/bismark:/usr/share/trim_galore:/usr/share/tophat:/usr/share/cufflinks:/usr/share/samtools

VOLUME /mnt
WORKDIR /mnt
