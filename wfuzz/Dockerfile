FROM alpine:edge
LABEL maintainer "Ilya Glotov <contact@ilyaglotov.com>"

RUN apk --update --no-cache add python2 \
                                py-pip \
                                curl-dev \
  && apk --virtual .deps add python2-dev \
                             git \
                             build-base \
  && pip install git+git://github.com/xmendez/wfuzz.git \
  && apk del .deps \
  && rm -rf /tmp/* /var/cache/apk/*

RUN adduser -D wfuzz

USER wfuzz

ENTRYPOINT ["wfuzz"]
