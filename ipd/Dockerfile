FROM golang:alpine as build
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

ENV CGO_ENABLED=0

RUN apk --update --no-cache add git \
  && go get -ldflags "-s -w" -a -installsuffix cgo github.com/mpolden/ipd/cmd/ipd

FROM scratch

COPY --from=build /go/bin/ipd /ipd

ENTRYPOINT ["/ipd"]
