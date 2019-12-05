FROM ubuntu:xenial

LABEL maintainer 'Haruka TSUKAGOSHI <haruka.tsukagoshi@hmi.ousin.jp>'

# env
ENV ORMASTER_PASSWORD=ormaster \
    ORCA_DISTRIBUTION=xenial50 \
    DEBIAN_FRONTEND=noninteractive

# set timezone to JST
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# install ORCA
RUN apt-get update \
    && apt-get -y install --no-install-recommends sudo wget ca-certificates gnupg expect \
    && apt-get -y dist-upgrade \
    && wget -q https://ftp.orca.med.or.jp/pub/ubuntu/archive.key -O - \
      | apt-key add - \
    && wget -q -O /etc/apt/sources.list.d/jma-receipt-$ORCA_DISTRIBUTION.list \
      https://ftp.orca.med.or.jp/pub/ubuntu/jma-receipt-$ORCA_DISTRIBUTION.list \
    && apt-get update \
    && apt-get -y install --no-install-recommends jma-receipt jma-receipt-pusher \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && wget http://ftp.orca.med.or.jp/pub/etc/install_modules_for_ftp.tgz -O - | tar xvzf - -C /tmp \
    && sudo -u orca bash -c 'cd /tmp/install_modules_for_ftp; ./install_modules.sh' \
    && rm -rf /tmp/install_modules_for_ftp

# setup ORCA
RUN service postgresql start \
    && jma-setup \
    && expect -c " \
spawn sudo -u orca /usr/lib/jma-receipt/bin/passwd_store.sh; \
expect \":\"; send \"${ORMASTER_PASSWORD}\n\"; \
expect \":\"; send \"${ORMASTER_PASSWORD}\n\"; \
expect eof;"

# setup postgresql
RUN echo "listen_addresses = '*'" >> /etc/postgresql/9.5/main/postgresql.conf \
    && sed -i -e 's/127\.0\.0\.1\/32/0.0.0.0\/0/g' /etc/postgresql/9.5/main/pg_hba.conf

# copy docker-entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# shared volume
VOLUME [ "/etc/jma-receipt", "/var/lib/jma-receipt", "/var/log/jma-receipt", "/var/lib/postgresql/9.5/main"]

# expose (orca api & postgresql)
EXPOSE 8000 9400 5432

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "tail", "-f", "/dev/null"]
