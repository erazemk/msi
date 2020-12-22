FROM alpine:latest

RUN apk update && apk add mysql-client && rm -f /var/cache/apk/*

COPY writedb.sh /writedb.sh

ENTRYPOINT [ "/writedb.sh" ]