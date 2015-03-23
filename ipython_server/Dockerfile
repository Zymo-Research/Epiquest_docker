FROM hunterchung/epiquest-docker
MAINTAINER Hunter Chung <hchung@zymoresearch.com>

EXPOSE 8888

# You can mount your own SSL certs as necessary here
ENV PEM_FILE /key.pem
# $PASSWORD will get `unset` within notebook.sh, turned into an IPython style hash
ENV PASSWORD Dont make this your default
ENV USE_HTTP 0

ADD notebook.sh /
RUN chmod u+x /notebook.sh

VOLUME /mnt
WORKDIR /mnt

CMD ["/notebook.sh"]
