FROM ruby:2.3-alpine

RUN apk --update --no-cache add git \
  && git clone --branch=master \
               --depth=1 \
               https://github.com/urbanadventurer/WhatWeb.git \
  && rm -rf /WhatWeb/.git \
  && apk del git \
  && adduser -D whatweb

USER whatweb

WORKDIR /WhatWeb

ENTRYPOINT ["./whatweb"]
