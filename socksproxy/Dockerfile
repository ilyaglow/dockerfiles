FROM golang:alpine as build
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

ENV CGO_ENABLED=0

COPY main.go /go/src/socksproxy/main.go

RUN apk --update --no-cache add git ca-certificates \
  && go get github.com/armon/go-socks5 \
  && cd /go/src/socksproxy/ \
  && go build -ldflags "-s -w" -a -installsuffix cgo -o socksproxy

FROM scratch

COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/ca-certificates.crt
COPY --from=build /go/src/socksproxy/socksproxy /socksproxy

ENTRYPOINT ["/socksproxy"]
