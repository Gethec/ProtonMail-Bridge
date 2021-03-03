FROM golang:alpine AS build
ARG BRIDGE_VERSION="v1.6.3"

WORKDIR /build/
RUN apk --update add gcc git libsecret-dev linux-headers make musl-dev &&\
    git clone https://github.com/ProtonMail/proton-bridge.git && \
    cd proton-bridge && \
    git checkout ${BRIDGE_VERSION} && \
    make build-nogui


FROM alpine
ARG S6_VERSION="v2.2.0.3"

ADD https://github.com/just-containers/s6-overlay/releases/download/${S6_VERSION}/s6-overlay-amd64-installer /tmp/s6-overlay
COPY --from=build /build/proton-bridge/proton-bridge /usr/bin
COPY root/ /
WORKDIR /root/
RUN apk --update add --no-cache socat pass libsecret && \
    chmod u+x /tmp/s6-overlay && \
    /tmp/s6-overlay / && \
    rm -rf /var/cache/apk/* /tmp/*

ENTRYPOINT [ "/init" ]
CMD [ "proton-bridge", "--cli" ]