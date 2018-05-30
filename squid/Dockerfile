FROM alpine:edge

RUN apk --update --no-cache add squid

USER squid

EXPOSE 3128

ENTRYPOINT ["squid", "-N"]
