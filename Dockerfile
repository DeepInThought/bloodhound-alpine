# TODO: Move away from Alpine images that implement linux-hardening, as this will be going away in the near future.
ARG IMAGE_TAG=latest
FROM alpine:${IMAGE_TAG}
WORKDIR /srv

# ENV values for easy manipulation of buildtime variables. 
# TODO: Pull the latest file by $NODE_CODENAME i.e. https://nodejs.org/download/release/latest-$NODE_CODENAME/
ENV NODE_VERSION=8.11.1
ENV NODE_CODENAME=carbon
ENV NPM_VERSION=3.10.10
ENV PROCESSOR_COUNT $(cat /proc/cpuinfo | grep 'processor' | wc -l)

# FIX: Remove cache and tmp files.  *Possibly MOVE FOR LATER OCCURENCES*
RUN rm -rf /var/cache/apk/* && \
  rm -rf /tmp/*

# Following best practices per: https://github.com/nodejs/node/blob/master/tools/bootstrap/README.md#linux
RUN apk --update add git python gcc g++ make gnupg \
  && cd /tmp \
  # Adding all the NodeJS Release Team's GPG keys from https://github.com/nodejs/node#release-team
  gpg --receive-keys 94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
  gpg --receive-keys FD3A5288F042B6850C66B31F09FE44734EB7990E \
  gpg --receive-keys 71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
  gpg --receive-keys DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
  gpg --receive-keys C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
  gpg --receive-keys B9AE9905FFD7803F25714661B63B535A4C206CA9 \
  gpg --receive-keys 56730D5401028683275BD23C23EFEFE93C4CFFFE \
  gpg --receive-keys 77984A986EBC2AA786BC0F66B01FBB92821C587A \
  && wget https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.gz \
  # TODO: Implement a curl or wget to retrieve the SHASUMS256.txt and verify signature prior to installation.  Will assist with continous builds with $NODE_CODENAME.
  && echo "86678028f13b26ceed08efc4b838921ca1bf514c0b7e8151bfec8ba15c5e66ad node-v$NODE_VERSION.tar.gz"  | sha256sum -c - \
  && tar -zxvf node-v$NODE_VERSION.tar.gz \
  && ./configure --prefix=/srv \
  # If you are experiencing issues with builds, then change to "&& make -j1 && make install \" without quotes.
  && make -j$PROCESSOR_COUNT && make install \
  && npm install -g npm@$NPM_VERSION \
  && apk del \
  git \
  python \
  gcc \
  g++ \
  make\
  gnupg

RUN rm -rf \
  /var/cache/apk/* \
  /tmp/*

# TODO: Add some unit testing with more CI/CD pipelines and security practices.

# Construct VOLUME for future preservation of information.
RUN mkdir /data
RUN echo "Testing /data creation..." > /data/initial_volume_test
VOLUME ["/data"]

CMD ["node", "-v"]

ARG BUILD_DATE
ARG VERSION 
ARG IMAGE_TAG

LABEL maintainer="Luke@DeepIT <support@deepinthought.io>" nodejs.version=${NODE_VERSION} image.tag=$IMAGE_TAG architecture="AMD64/x86_64" \
  npm.version=${NODE_VERSION} description="An unofficial Docker project for BloodHoundAD." processor.count=${PROCESSOR_COUNT} \
  io.deepinthought.build-date=${BUILD_DATE} io.deepinthought.version=${VERSION} author="DeepIT <support@deepinthought.io>"

#*** TODO: Implement multistage-builds where necessary to cut down on image size. ****#