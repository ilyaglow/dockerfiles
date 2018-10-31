FROM alpine:edge
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

RUN apk --update --no-cache add dcron \
                                curl \
  && crontab -d

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
