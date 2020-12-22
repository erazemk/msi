#!/bin/sh

[ ! -d /date ] && mkdir /date
[ ! -f /date/date.html ] && touch /date/date.html

# Wait for the database to initialize
sleep 20

while true; do
    DATE="$(mysql --user=mysql --password=password --host=database time -e "SELECT time from time ORDER BY id DESC LIMIT 1" -P 3306 | cut -d" " -f2)"
    # Overwrites the file every time, otherwise scrolling messes things up
    echo '<meta http-equiv="refresh" content="1">' > /date/date.html
    echo "${DATE}" >> /date/date.html
    sleep 1
done