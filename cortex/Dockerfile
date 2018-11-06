FROM openjdk:8
LABEL maintainer="Ilya Glotov <contact@ilyaglotov.com>" \
      repository="https://github.com/TheHive-Project/Cortex"

ENV CORTEX_VERSION 2.1.2
RUN apt-get update \
  && apt-get install -y apt-transport-https \
  \
  && echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
  && apt-get update \
  && apt-get install -y sbt \
  \
  && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get install -y nodejs \
                        git \
  \
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
  && echo "play.http.secret.key=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 49)" >> /opt/cortex/conf/application.conf \
  \
  && mkdir /var/log/cortex \
  \
  && rm -rf /Cortex \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /root/*

FROM openjdk:8
COPY --from=0 /opt/cortex /opt/cortex
COPY --from=0 /var/log/cortex /var/log/cortex

RUN useradd thehive \
  && chown -R thehive /opt/cortex \
                      /var/log/cortex

USER thehive

ENTRYPOINT ["/opt/cortex/bin/cortex"]
