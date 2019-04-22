FROM golang:alpine
LABEL mantainer "Ilya Glotov <ilya@ilyaglotov.com>"

ENV CGO_ENABLED=0

RUN apk --update --no-cache add git \
  && go get golang.org/x/tools/cmd/present \
  && cd /go/src/golang.org/x/tools/cmd/present \
  && go build -ldflags="-s -w" -a -installsuffix static -o /present \
  && mkdir /data /temp

FROM scratch
COPY --from=0 /data /data
COPY --from=0 /temp /tmp
COPY --from=0 /present /present
COPY --from=0 /go/src/golang.org/x/tools/cmd/present /go/src/golang.org/x/tools/cmd/present

VOLUME /data
WORKDIR /data

ENTRYPOINT ["/present", "-http", ":3999", "-base", "/go/src/golang.org/x/tools/cmd/present"]
