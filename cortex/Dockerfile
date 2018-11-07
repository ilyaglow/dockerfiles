FROM openjdk:8
LABEL maintainer="Ilya Glotov <contact@ilyaglotov.com>" \
      repository="https://github.com/TheHive-Project/Cortex"

ENV CORTEX_VERSION=2.1.2 \
    CORTEX_ANALYZERS_VERSION=1.14.0 \
    BUILD_DEPS="git \
                nodejs \
                sbt"

ARG CORTEX_ANALYZERS_REPOSITORY=https://github.com/TheHive-Project/Cortex-Analyzers.git

RUN apt-get update \
  && apt-get install -y apt-transport-https \
  \
  && echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
  && apt-get update \
  && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install -y $BUILD_DEPS \
  \
  && git -c advice.detachedHead=false \
            clone \
            --branch=$CORTEX_VERSION \
            --depth=1 \
            https://github.com/TheHive-Project/Cortex.git \
  && git -c advice.detachedHead=false \
            clone \
            --branch=$CORTEX_ANALYZERS_VERSION \
            --depth=1 \
            $CORTEX_ANALYZERS_REPOSITORY \
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

FROM openjdk:8
COPY --from=0 /opt/cortex /opt/cortex
COPY --from=0 /Cortex-Analyzers /opt/Cortex-Analyzers

RUN useradd thehive \
  && mkdir /var/log/cortex \
  && chown -R thehive /opt/cortex \
                      /opt/Cortex-Analyzers \
                      /var/log/cortex \
  && echo "play.http.secret.key=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 49)" >> /opt/cortex/conf/application.conf \
  && echo -e 'search.host = ["elastic:9300"]\n\
analyzer.path = ["/opt/Cortex-Analyzers"]\n\
play.http.secret.key = ${?PLAY_SECRET}' >> /opt/cortex/conf/application.conf

VOLUME /opt/Cortex-Analyzers

EXPOSE 9001

USER thehive

ENTRYPOINT ["/opt/cortex/bin/cortex"]
