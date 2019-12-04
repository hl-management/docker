FROM ruby:2.6.5-slim-buster

RUN apt-get update -qq && \
  apt-get install -y --no-install-recommends build-essential patch zlib1g-dev liblzma-dev pkg-config \
  libxml2-dev libxslt1-dev imagemagick libvips nkf git \
  curl default-libmysqlclient-dev libpq-dev && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update -qq && \
  apt-get install -y --no-install-recommends nodejs yarn && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

RUN gem update --system && gem update bundler
