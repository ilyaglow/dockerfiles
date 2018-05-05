FROM alpine:edge
LABEL maintainer "Ilya Glotov <contact@ilyaglotov.com>"

RUN apk --update --no-cache add python2 \
                                py-curl \
  && apk --no-cache add git \
  && git clone --branch=master \
               --depth=1 \
               https://github.com/xmendez/wfuzz.git \
               \
  && apk del git \
  && rm -rf /wfuzz/.git /var/cache/apk/*

RUN adduser -D wfuzz

USER wfuzz

WORKDIR /wfuzz

ENTRYPOINT ["./wfuzz"]
