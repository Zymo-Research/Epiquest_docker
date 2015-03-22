pip install -U distribute

pip install -U \
    cython \
    filechunkio \
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
pip install \
    rpy2 \
    tables \
    ipython \
    matplotlib \
    seaborn \
    matplotlib-venn \
    qiime
