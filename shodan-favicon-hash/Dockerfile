FROM python:alpine
LABEL maintainer "Ilya Glotov <ilya@ilyaglotov.com>"

RUN python3 -m ensurepip \
  && pip install pymmh3 \
                 requests \
                 shodan

COPY script.py /script.py

ENTRYPOINT ["python", "/script.py"]
