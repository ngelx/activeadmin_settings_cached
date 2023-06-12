FROM ruby:2.7-slim

ENV PHANTOMJS_VERSION 2.1.1

RUN apt-get update -qq && \
  DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends build-essential libpq-dev libsqlite3-dev python2 curl gnupg git \
  wget \
  libfreetype6 \
  libfontconfig \
  bzip2

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-key adv --refresh-keys --keyserver keyserver.ubuntu.com

RUN apt-get update -qq && apt-get install -y nodejs yarn

RUN \
  wget -q --no-check-certificate -O /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  mkdir -p /srv/var && \
  tar -xjf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /tmp && \
  rm -f /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
  mv /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/ /srv/var/phantomjs && \
  ln -s /srv/var/phantomjs/bin/phantomjs /usr/bin/phantomjs

ENV GEM_HOME /app/.bundle
ENV BUNDLE_PATH=$GEM_HOME \
  BUNDLE_APP_CONFIG=$BUNDLE_PATH \
  BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /app/bin:$BUNDLE_BIN:$PATH
ENV OPENSSL_CONF=/etc/ssl

WORKDIR /app
