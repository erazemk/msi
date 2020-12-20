#!/bin/sh

[ ! -d /date ] && mkdir /date
[ ! -f /date/date.html ] && touch /date/date.html

while true; do
    # Overwrites the file every time, otherwise scrolling messes things up
    printf "%s\n" '<meta http-equiv="refresh" content="1">' > '/date/date.html'
    printf "%s\n" "$(date '+%H:%M:%S (%A, %d. %m. %y)')" >> '/date/date.html'
    sleep 1
done