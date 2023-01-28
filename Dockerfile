FROM python:3.10.8-alpine3.17

COPY requirements.txt /tmp
RUN apk --no-cache add musl-dev linux-headers g++ && \
    pip install -r /tmp/requirements.txt && \
    apk del musl-dev linux-headers g++