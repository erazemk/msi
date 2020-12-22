FROM alpine:latest

RUN apk update && apk add mysql-client && rm -f /var/cache/apk/*

COPY clock.sh /clock.sh

ENTRYPOINT [ "/clock.sh" ]