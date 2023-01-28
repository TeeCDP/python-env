FROM python:3.10.8-alpine3.17

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

COPY requirements.txt /tmp

RUN apk --no-cache add musl-dev linux-headers g++ && \
    pip install -r /tmp/requirements.txt


USER root
RUN apk add --update openjdk11 curl busybox-extras && addgroup -S nonrootgroup && adduser -S nonroot -G nonrootgroup
USER nonroot
WORKDIR /home/nonroot