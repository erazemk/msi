#!/bin/sh

[ ! -d /date ] && mkdir /date
[ ! -f /date/date.html ] && touch /date/date.html

while true; do
    printf "%s\n" "$(date)" >> "/date/date.html"
    sleep 1
done