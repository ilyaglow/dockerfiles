FROM golang:alpine as build
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

ENV CGO_ENABLED=0

RUN apk --update --no-cache add git ca-certificates \
  && go get -ldflags "-s -w" -a -installsuffix cgo github.com/snail007/goproxy

FROM scratch

COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=build /go/bin/goproxy /goproxy

ENTRYPOINT ["/goproxy"]
