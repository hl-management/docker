FROM alpine:3.11

ENV ANSIBLE_VERSION=2.9

RUN set -eux && \
    apk add --no-cache bc gcc libffi-dev musl-dev openssl-dev \
      git openssh python3 python3-dev && \
    pip3 install --no-cache-dir --no-compile ansible==$ANSIBLE_VERSION \
      ansible-lint
