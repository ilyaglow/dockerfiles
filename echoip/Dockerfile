FROM golang:alpine as build
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

ENV CGO_ENABLED=0

RUN apk --update --no-cache add git \
  && go get -ldflags "-s -w" -a -installsuffix cgo github.com/mpolden/echoip/cmd/echoip \
  && adduser -D user

ADD https://geolite.maxmind.com/download/geoip/database/GeoLite2-City.tar.gz /geoip/GeoLite2-City.mmdb.gz
ADD https://geolite.maxmind.com/download/geoip/database/GeoLite2-Country.tar.gz /geoip/GeoLite2-Country.mmdb.gz

WORKDIR /geoip

RUN gunzip * \
  && chmod -R 744 ./

FROM alpine:edge

ENV GEOCOUNTRY="GeoLite2-Country.mmdb"
ENV GEOCITY="GeoLite2-City.mmdb"
ENV GEOCOUNTRY_PATH="/tmp/"${GEOCOUNTRY}
ENV GEOCITY_PATH="/tmp/"${GEOCITY}
ENV TRUSTED_HEADER="CF-Connecting-IP"

COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /go/bin/echoip /echoip
COPY --from=build /geoip/${GEOCOUNTRY} ${GEOCOUNTRY_PATH}
COPY --from=build /geoip/${GEOCITY} ${GEOCITY_PATH}

COPY entrypoint.sh /entrypoint.sh

USER user

ENTRYPOINT ["/entrypoint.sh"]
