FROM alpine:edge
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

ENV SSDEEP 2.14.1

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories \
  && apk add --update --no-cache python3 \
                                 python3-dev \
                                 py-lxml \
                                 jpeg-dev \
                                 yara \
                                 zlib-dev \
  && apk add --no-cache --virtual .deps git \
                                        build-base \
  && wget https://github.com/ssdeep-project/ssdeep/releases/download/release-$SSDEEP/ssdeep-$SSDEEP.tar.gz \
  -O /tmp/ssdeep-$SSDEEP.tar.gz \
  && cd /tmp \
  && tar xzf ssdeep-$SSDEEP.tar.gz \
  && cd ssdeep-$SSDEEP \
  && ./configure \
  && make \
  && make install \
  \
  && git clone --branch=master --depth=1 https://github.com/MISP/misp-modules.git /misp-modules \
  && cd /misp-modules \
  && pip3 install -I -r REQUIREMENTS \
  && pip3 install maec \
                  lief \
                  python-magic \
                  wand \
                  yara \
                  git+https://github.com/kbandla/pydeep.git \
                  stix2 \
  && pip3 install -e . \
  && adduser -D misp \
  && chown -R misp:misp /misp-modules \
  && rm -rf /tmp/ssdeep* \
  && apk del .deps

COPY entrypoint.sh /tmp/entrypoint.sh

RUN chmod +x /tmp/entrypoint.sh

USER misp

ENTRYPOINT /tmp/entrypoint.sh
