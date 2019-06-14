FROM openjdk:8 as build-env
LABEL maintainer="Ilya Glotov <contact@ilyaglotov.com>" \
      repository="https://github.com/TheHive-Project/TheHive"

ARG THEHIVE_VERSION=3.3.1

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
                        libpng-dev \
                        sudo \
                        \
  && npm install -g grunt-cli \
                    bower \
  && git -c advice.detachedHead=false \
            clone \
            --branch=$THEHIVE_VERSION \
            --depth=1 \
            https://github.com/TheHive-Project/TheHive.git \
  && echo '{"allow_root": true}' > /root/.bowerrc \
  && cd TheHive \
  && sbt clean stage \
  && mv /TheHive/target/universal/stage /opt/thehive \
  && mv /TheHive/package/docker/entrypoint /opt/thehive/entrypoint \
  && echo "play.http.secret.key=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 49)" >> /opt/thehive/conf/application.conf \
  && mkdir /var/log/thehive \
  && apt-get purge -y git \
                      sbt \
                      nodejs \
                      libpng-dev \
  && rm -rf /TheHive \
  && rm -rf /root/* \
  && rm -rf /var/lib/apt/lists/*

FROM openjdk:8
COPY --from=build-env /opt/thehive /opt/thehive
COPY --from=build-env /var/log/thehive /var/log/thehive

RUN useradd thehive \
  && chown -R thehive /opt/thehive \
                      /var/log/thehive \
  && mkdir /etc/thehive \
  && cp /opt/thehive/conf/application.conf /etc/thehive/application.conf \
  && cp /opt/thehive/conf/logback.xml /etc/thehive/logback.xml \
  && echo 'search.host = ["elasticsearch:9300"]\n\
cortex.url = ${?CORTEX_URL}\n\
cortex.key = ${?CORTEX_KEY}\n\
play.http.secret.key = ${?PLAY_SECRET}' >> /etc/thehive/application.conf \
  && chmod +x /opt/thehive/entrypoint

USER thehive

EXPOSE 9000

WORKDIR /opt/thehive

ENTRYPOINT ["./entrypoint"]
