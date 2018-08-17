FROM golang:alpine as build
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

RUN apk --update --no-cache add git ca-certificates \
  && go get rsc.io/go-import-redirector

FROM alpine:edge

COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=build /go/bin/go-import-redirector /go-import-redirector

ENTRYPOINT ["/go-import-redirector"]
