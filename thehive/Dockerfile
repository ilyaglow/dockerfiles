FROM openjdk:8 as build-env
LABEL maintainer="Ilya Glotov <contact@ilyaglotov.com>" \
      repository="https://github.com/TheHive-Project/TheHive"

ENV THEHIVE_VERSION=3.1.2 \
    BUILD_DEPS="sbt \
                nodejs \
                git \
                libpng-dev"

RUN apt-get update \
  && apt-get install -y apt-transport-https \
  \
  && echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
  && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
  && apt-get update \
  && apt-get install -y sudo \
                        $BUILD_DEPS \
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
  && apt-get purge -y $BUILD_DEPS \
  && rm -rf /TheHive \
  && rm -rf /root/* \
  && rm -rf /var/lib/apt/lists/*

FROM openjdk:8
COPY --from=build-env /opt/thehive /opt/thehive

RUN useradd thehive \
  && mkdir /var/log/thehive \
  && chown -R thehive /opt/thehive \
                      /var/log/thehive \
  && echo "play.http.secret.key=$(tr -dc 'A-Za-z0-9' < /dev/urandom | head -c 49)" >> /opt/thehive/conf/application.conf \
  && echo -e 'search.host = ["elastic:9300"]\n\
play.http.secret.key = ${?PLAY_SECRET}' >> /opt/thehive/conf/application.conf

USER thehive

EXPOSE 9000

ENTRYPOINT ["/opt/thehive/bin/thehive"]
