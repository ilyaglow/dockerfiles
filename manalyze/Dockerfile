FROM ubuntu:latest
LABEL maintainer="Ilya Glotov <ilya@ilyaglotov.com>" \
      repository="https://github.com/JusticeRage/Manalyze"

ENV BUILD_DEPS="build-essential \
                git \
                libboost-regex-dev \
                libboost-program-options-dev \
                libboost-system-dev \
                libboost-filesystem-dev \
                libssl-dev \
                cmake \
                python"

RUN apt-get update \
  && apt-get install -y $BUILD_DEPS \
  && git clone --branch=master \
               --depth=1 \
               https://github.com/JusticeRage/Manalyze.git \
  && cd Manalyze \
  && cmake . \
  && make \
  && cd bin/yara_rules \
  && python update_clamav_signatures.py \
  \
  && mkdir /manalyze \
  && mv /Manalyze/bin /Manalyze/external /manalyze/ \
  && apt-get purge -y $BUILD_DEPS

FROM ubuntu:latest

RUN mkdir /manalyze

COPY --from=0 /manalyze /manalyze
COPY --from=0 /usr/lib/x86_64-linux-gnu/libicui18n.so.60 \
              /usr/lib/x86_64-linux-gnu/libicuuc.so.60 \
              /usr/lib/x86_64-linux-gnu/libicudata.so.60 \
              /usr/lib/x86_64-linux-gnu/libboost_regex.so.1.* \
              /usr/lib/x86_64-linux-gnu/libboost_system.so.1.* \
              /usr/lib/x86_64-linux-gnu/libboost_filesystem.so.1.* \
              /usr/lib/x86_64-linux-gnu/libboost_program_options.so.1.* \
              /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 \
              /usr/lib/x86_64-linux-gnu/libssl.so.1.1 /usr/lib/x86_64-linux-gnu/

RUN useradd -r manalyze \
  && chown -R manalyze /manalyze

USER manalyze

WORKDIR /manalyze/bin

ENTRYPOINT ["./manalyze"]
