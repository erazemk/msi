FROM alpine:latest

RUN apk update && apk add mysql-client && rm -f /var/cache/apk/*

COPY readdb.sh /readdb.sh

ENTRYPOINT [ "/readdb.sh" ]