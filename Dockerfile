FROM hunterchung/eg-website-docker
MAINTAINER Hunter Chung <hchung@zymoresearch.com>

RUN sed -i.dist 's,universe$,universe multiverse,' /etc/apt/sources.list
RUN apt-get update && \
apt-get install -y \
    build-essential \
    gfortran \
    liblapack-dev \
    libhdf5-7 \
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
ADD install_python_packages.sh /tmp/install_python_packages.sh
RUN bash install_python_packages.sh

# Install packages.
ADD install_bioinfo_packages.sh /tmp/install_bioinfo_packages.sh
RUN bash install_bioinfo_packages.sh

# Django env path.
ENV PYTHONPATH=/var/www/EpiQuest_py
ENV DJANGO_SETTINGS_MODULE=EpiQuest_py.settings
ENV PATH=${PATH}:/usr/share/bowtie:/usr/share/bowtie2:/usr/share/genomicTools:/usr/share/bismark:/usr/share/trim_galore:/usr/share/tophat:/usr/share/cufflink:/usr/share/samtools

VOLUME /mnt
WORKDIR /mnt
