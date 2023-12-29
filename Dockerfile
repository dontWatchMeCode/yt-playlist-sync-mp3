# builder
FROM nimlang/nim:2.0.0-alpine as builder

WORKDIR /builder

COPY . .

RUN apk update && apk add --no-cache make
RUN make build

# app
FROM alpine:3.19 AS app
WORKDIR /mnt/vdata

COPY --from=builder /builder/bin/main /usr/local/bin/yt-dl-pl-sync

RUN apk update && apk add --no-cache ffmpeg python3
RUN ln -sf python3 /usr/bin/python

RUN wget -P /usr/local/bin/ https://github.com/yt-dlp/yt-dlp/releases/download/2023.11.16/yt-dlp

RUN chmod a+rx /usr/local/bin/*
