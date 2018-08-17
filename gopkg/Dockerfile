FROM golang:alpine as build
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

RUN apk --update --no-cache add git ca-certificates \
  && git clone --branch=master --depth=1 https://github.com/ilyaglow/gopkg \
  && cd gopkg \
  && go build main.go page.go version.go

FROM alpine:edge

COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=build /go/gopkg/main /gopkg

ENTRYPOINT ["/gopkg"]
