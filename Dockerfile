ARG BASE_OS="alpine"
ARG BASE_OS_VERSION="3"

FROM ${BASE_OS}:${BASE_OS_VERSION}

ARG CATT_VERSION=0.12.9

LABEL maintainer="garrett.peavy@gmail.com" \
    version="{CATT_VERSION}" \
    repo="github.com/gpeavy/docker-catt"

RUN apk add --no-cache python3 py3-pip && \
    pip3 install catt==${CATT_VERSION} && \
    rm -rf /root/.cache/pip

ENTRYPOINT ["catt"]
