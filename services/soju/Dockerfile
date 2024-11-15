FROM golang:1.23-alpine as builder
ARG VERSION=0.8.2

WORKDIR /src
RUN apk add --no-cache \
    "gcc>=13.2.1_git20240309-r0" \
    "make>=4.4.1-r2"\
    "musl-dev>=1.2.5-r0"
RUN wget https://codeberg.org/emersion/soju/releases/download/v${VERSION}/soju-${VERSION}.tar.gz \
    && tar -xzf soju-${VERSION}.tar.gz --strip-components=1 \
    && rm soju-${VERSION}.tar.gz
RUN make soju


FROM scratch
COPY --from=builder /src/soju /src/sojudb /usr/local/bin/
ENTRYPOINT [ "soju" ]
