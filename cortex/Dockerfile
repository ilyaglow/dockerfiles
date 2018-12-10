FROM openjdk:8 as builder
LABEL maintainer="Ilya Glotov <contact@ilyaglotov.com>" \
      repository="https://github.com/TheHive-Project/Cortex"

ENV CORTEX_VERSION=2.1.2 \
    BUILD_DEPS="git \
                nodejs \
                sbt \
                libpng-dev \
                build-essential"

RUN apt-get update \
  && apt-get install -y apt-transport-https \
  \
  && echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
  && apt-get update \
  && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install -y $BUILD_DEPS \
  \
  && npm install -g bower \
  && echo '{ "allow_root": true }' > ~/.bowerrc \
  && git -c advice.detachedHead=false \
            clone \
            --branch=$CORTEX_VERSION \
            --depth=1 \
            https://github.com/TheHive-Project/Cortex.git \
  && cd Cortex \
  && sbt clean stage \
  && mv /Cortex/target/universal/stage /opt/cortex \
  && mv /opt/cortex/conf/application.sample \
        /opt/cortex/conf/application.conf \
  \
  && apt-get purge -y $BUILD_DEPS \
  && rm -rf /Cortex \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /root/*

FROM debian:stretch as analyzers

ENV CORTEX_ANALYZERS_VERSION=1.14.4 \
    CORTEX_ANALYZERS_REPOSITORY=https://github.com/TheHive-Project/Cortex-Analyzers.git \
    DEPS="git \
          build-essential"

COPY requirements.txt /tmp/requirements.txt

RUN apt-get update \
  && apt-get install -y $DEPS \
                        python2.7-dev \
                        python-pip \
                        python3-pip \
                        python3-dev \
                        ssdeep \
                        libfuzzy-dev \
                        libfuzzy2 \
                        libimage-exiftool-perl \
                        libmagic1 \
                        libssl-dev \
  && git -c advice.detachedHead=false \
            clone \
            --branch=$CORTEX_ANALYZERS_VERSION \
            --depth=1 \
            $CORTEX_ANALYZERS_REPOSITORY \
            /opt/Cortex-Analyzers \
  && cd /opt \
  && for i in $(find Cortex-Analyzers -name 'requirements.txt'); do pip2 install -r $i; done \
  && for i in $(find Cortex-Analyzers -name 'requirements.txt'); do pip3 install -r $i || true; done \
  && pip2 install -r /tmp/requirements.txt \
  && pip3 install -r /tmp/requirements.txt

FROM openjdk:8 as final
COPY --from=builder /opt/cortex /opt/cortex
COPY --from=analyzers /opt/Cortex-Analyzers /opt/Cortex-Analyzers
COPY --from=analyzers /usr/local/lib/python* /usr/local/lib/

RUN apt-get update \
  && apt-get install -y python2.7-dev \
                        python3-pip \
                        python3-dev \
                        ssdeep \
                        libfuzzy-dev \
                        libfuzzy2 \
                        libimage-exiftool-perl \
                        libmagic1 \
                        libssl-dev \
  && useradd cortex \
  && mkdir /var/log/cortex \
  && chown -R cortex /opt/cortex \
                      /opt/Cortex-Analyzers \
                      /var/log/cortex \
  && echo "play.http.secret.key = $(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 49)" >> /opt/cortex/conf/application.conf \
  && echo 'search.host = ["elasticsearch:9300"]\n\
analyzer.path = ["/opt/Cortex-Analyzers/analyzers"]\n\
responder.path = ["/opt/Cortex-Analyzers/responders"]\n\
play.http.secret.key = ${?PLAY_SECRET}' >> /opt/cortex/conf/application.conf

VOLUME /opt/Cortex-Analyzers

EXPOSE 9001

USER cortex

ENTRYPOINT ["/opt/cortex/bin/cortex"]
