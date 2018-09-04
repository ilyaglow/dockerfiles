FROM alpine:edge
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories \
  && apk --no-cache --update add yara \
                                libzip-dev \
                                zlib-dev \
  && apk --no-cache --virtual .deps add build-base \
                                        git \
  && git clone --branch=master --depth=1 https://github.com/tylabs/quicksand_lite.git \
  && cd quicksand_lite \
  && ./build.sh \
  && adduser -D quicksand \
  && apk del .deps

USER quicksand

VOLUME /data

WORKDIR /quicksand_lite

ENTRYPOINT ["./quicksand.out"]
