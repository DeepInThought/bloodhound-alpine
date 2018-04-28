# TODO: Move away from Alpine images that implement linux-hardening, as this will be going away.
FROM alpine:latest
MAINTAINER Luke @ DeepIT <support@deepinthought.io> version=8.11.1 architecture="AMD64/x86_64"
# TODO: Implement multistage-builds where necessary to cut down on image size.

# ENV values for easy manipulation.
ENV NODE_VERSION=8.11.1
ENV NODE_CODENAME=carbon
ENV NPM_VERSION=3.10.10
ENV PROCESSOR_COUNT=`$(cat /proc/cpuinfo | grep 'processor' | wc -l)`

# TODO: Pull the latest file from [https://nodejs.org/download/release/latest-$NODE_CODENAME/](https://nodejs.org/download/release/latest-$NODE_CODENAME/)

# Following best practices per: [https://github.com/nodejs/node/blob/master/tools/bootstrap/README.md#linux](https://github.com/nodejs/node/blob/master/tools/bootstrap/README.md#linux)
RUN apk add git python gcc-c++ make gnupg
 && cd /tmp \
 && echo "Adding all the NodeJS Release Team's GPG keys from https://github.com/nodejs/node#release-team" \
 && echo "Colin Ihrig <cjihrig@gmail.com>" | gpg --keyserver pool.sks-keyservers.net --recv-keys 94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
 && echo "Evan Lucas <evanlucas@me.com>" | gpg --keyserver pool.sks-keyservers.net --recv-keys FD3A5288F042B6850C66B31F09FE44734EB7990E \
 && echo "Gibson Fahnestock <gibfahn@gmail.com>" | gpg --keyserver pool.sks-keyservers.net --recv-keys 71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
 && echo "Italo A. Casas <me@italoacasas.com>" | gpg --keyserver pool.sks-keyservers.net --recv-keys DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
 && echo "James M Snell <jasnell@keybase.io>" | gpg --keyserver pool.sks-keyservers.net --recv-keys C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
 && echo "Jeremiah Senkpiel <fishrock@keybase.io>" | gpg --keyserver pool.sks-keyservers.net --recv-keys B9AE9905FFD7803F25714661B63B535A4C206CA9 \
 && echo "Myles Borins <myles.borins@gmail.com>" | gpg --keyserver pool.sks-keyservers.net --recv-keys 56730D5401028683275BD23C23EFEFE93C4CFFFE \
 && echo "Rod Vagg <rod@vagg.org>" | gpg --keyserver pool.sks-keyservers.net --recv-keys 77984A986EBC2AA786BC0F66B01FBB92821C587A \
 && wget https://nodejs.org/download/release/v$NODE_VERSION/node-v$NODE_VERSION.tar.gz \
# TODO: Implement a curl or wget to retrieve the SHASUMS256.txt and verify signature prior to installation.  Will assist with continous builds with $NODE_CODENAME.
 && echo "86678028f13b26ceed08efc4b838921ca1bf514c0b7e8151bfec8ba15c5e66ad node-v$NODE_VERSION.tar.gz"  | sha256sum -c \
 && tar -zxvf node-v$NODE_VERSION.tar.gz \
 && ./configure --prefix=/srv \
# If you are experiencing issues with builds, then change to "&& make -j1 && make install \" without quotes.
 && make -j$PROCESSOR_COUNT && make install \
 && npm install -g npm@$NPM_VERSION \
 && apk del \
   git \
   python \
   gcc-c++ \
   make \
   gnupg \
 && rm -rf \
 /var/cache/apk/* \
 /tmp/* \
 
# TODO: Add some unit testing with more CI/CD pipelines and security practices.
 
# Create VOLUME for future preservation
VOLUME ["/data"]

CMD ["node", "-v"]
