FROM golang:alpine as build

ENV GO111MODULE=on

RUN apk add --update git \
  && go get github.com/caddyserver/forwardproxy/cmd/caddy

FROM alpine:latest

COPY --from=build /go/bin/caddy /caddy
COPY Caddyfile /Caddyfile

EXPOSE 8080

ENTRYPOINT ["/caddy"]
