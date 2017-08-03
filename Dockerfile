FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    apt-transport-https \
    curl \
    xz-utils \
    unzip \
    bzip2 \
    wget \
    && rm -rf /var/lib/apt/lists/*

#==========
# Chrome
#==========
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb https://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install google-chrome-unstable \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

ENV NPM_CONFIG_LOGLEVEL info
ENV NODE_VERSION 8.1.4

#==========
# NodeJS
#==========
RUN curl -SLO https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz \
  && tar -xJf node-v$NODE_VERSION-linux-x64.tar.xz -C /usr/local --strip-components=1 \
  && rm node-v$NODE_VERSION-linux-x64.tar.xz \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

ENTRYPOINT bash
