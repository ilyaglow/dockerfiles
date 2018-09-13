FROM debian:jessie
LABEL maintainer "Ilya Glotov <contact@ilyaglotov.com>"

COPY sign3.c /tmp/sign3.c

RUN apt-get update \
  && apt-get -y install gcc \
                        libxmlsec1-dev \
                        libxml2-dev \
                        libxslt1-dev \
  && cd /tmp \
  && gcc -I/usr/include/libxml2 -lxml2 -D__XMLSEC_FUNCTION__=__FUNCTION__ -DXMLSEC_NO_SIZE_T -DXMLSEC_NO_GOST=1 -DXMLSEC_NO_XKMS=1 -DXMLSEC_NO_CRYPTO_DYNAMIC_LOADING=1 -I/usr/include/xmlsec1 -I/usr/include/libxml2 -DXMLSEC_OPENSSL_100=1 -DXMLSEC_CRYPTO_OPENSSL=1 -DXMLSEC_CRYPTO=openssl -L/usr/lib -lxmlsec1-openssl -lxmlsec1 -lxslt -lxml2 -lssl -lcrypto -o sign sign3.c \
  && apt-get -y purge gcc \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/*

VOLUME /data

ENTRYPOINT ["/tmp/sign"]
