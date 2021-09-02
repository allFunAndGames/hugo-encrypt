FROM alpine:latest as build

LABEL org.opencontainers.image.name="Hugo Actions"
LABEL org.opencontainers.image.description="Commands to help with building Hugo based static sites"
LABEL org.opencontainers.image.authors="allfun@wearehackerone.com"

# install requisite software packages
RUN apk add --no-cache curl jq

# fetch latest hugo binary from release package
ARG HUGO_VERSION="latest"
RUN curl -sL $(curl -sL https://api.github.com/repos/gohugoio/hugo/releases/latest | \
                jq -r '.assets[].browser_download_url' | \
                grep -E hugo_[0-9]+\.[0-9]+\.[0-9]+_Linux-64bit.tar.gz) \
                --output hugo_latest.tar.gz && \
                tar xzf hugo_latest.tar.gz && \
                rm -r hugo_latest.tar.gz && \
                mv hugo /usr/bin

# fetch latest hugo-encrypt binary (not auto-found, no full release exists)
# TO-DO: perhaps a good idea to fork this repo just in case it goes away later
RUN curl -sL https://github.com/Izumiko/hugo-encrypt/releases/download/20200728/hugo-encrypt \
                --output hugo-encrypt && \
                mv hugo-encrypt /usr/bin

# add our entrypoint script and make it executable
ADD entrypoint.sh /
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
