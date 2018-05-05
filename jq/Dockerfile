FROM alpine:edge
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

RUN apk --update \
        --no-cache \
        --virtual .deps add build-base \
                            oniguruma-dev \
                            automake \
                            autoconf \
                            libtool \
                            git \
  && git clone --branch=master \
               --depth=1 \
               https://github.com/stedolan/jq.git \
  && cd /jq \
  && autoreconf -fi \
  && ./configure --disable-valgrind --enable-all-static --disable-docs --prefix=/usr/local \
  && make -j8 \
  && make install \
  && apk del .deps \
  && rm -rf /jq

RUN adduser -D jq

USER jq

ENTRYPOINT ["/usr/local/bin/jq"]
