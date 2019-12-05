FROM ubuntu:latest
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

ENV DEPS build-essential git

RUN apt-get update \
  && apt-get install -y python3 \
                        python3-pip \
                        libncurses5-dev \
                        $DEPS \
  && pip3 install capstone \
                  git+https://github.com/netleibi/fastchunking.git \
                  future==0.16.0 \
  && git clone --branch=master --depth=1 https://github.com/google/rekall.git \
  && cd rekall \
  && pip3 install . \
  && useradd -ms /bin/bash rekall \
  && apt-get purge -y $DEPS \
  && rm -rf /rekall

USER rekall

ENTRYPOINT ["rekall"]
