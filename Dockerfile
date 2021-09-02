FROM alpine:latest as build

# hugo-encrypt by Izumiko (https://github.com/Izumiko/)

LABEL org.opencontainers.image.name="hugo-encrypt GitHub Action"
LABEL org.opencontainers.image.description="GitHub Action for automated build of Hugo based static sites"
LABEL org.opencontainers.image.authors="allfun@wearehackerone.com"

# install required software packages
RUN apk add --no-cache curl jq

# add our binary and make it executable
RUN curl -sL https://github.com/Izumiko/hugo-encrypt/releases/download/20200728/hugo-encrypt \
                --output hugo-encrypt && \
                chmod +x hugo-encrypt && \
                mv hugo-encrypt /usr/bin/hugo-encrypt

                
# define the entrypoint
ENTRYPOINT ["/usr/bin/hugo-encrypt"]
