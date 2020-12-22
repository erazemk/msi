#!/bin/sh

[ ! -d /date ] && mkdir /date
[ ! -f /date/date.html ] && touch /date/date.html

# Init
sleep 10
while ! mysql --user=mysql --password=password --host=database -P 3306 --silent --execute 'SELECT 1;' >/dev/null 2>&1; do
    echo "MySQL is not ready yet, waiting"
    sleep 5
done

echo "Creating table 'time'"
mysql --user=mysql --password=password --host=database -P 3306 -s <<EOF
USE time;
CREATE TABLE time (id INT AUTO_INCREMENT PRIMARY KEY, time VARCHAR(32) NOT NULL);
EOF

while true; do
    # --- Pisanje v bazo ---
    DATE_IN="$(date '+%H:%M:%S (%A, %d. %m. %y)')"
    echo "Writing to database"
    mysql --user=mysql --password=password --host=database time -e "INSERT INTO time (time) VALUES ('${DATE_IN}')" -P 3306 -s

    # --- Branje iz baze ---
    echo "Reading from database"
    DATE_OUT="$(mysql --user=mysql --password=password --host=database time -e "SELECT time from time ORDER BY id DESC LIMIT 1" -P 3306 -s | cut -d" " -f2)"
    # Overwrites the file every time, otherwise scrolling messes things up
    echo '<meta http-equiv="refresh" content="1">' > /date/date.html
    echo "${DATE_OUT}" >> /date/date.html
    sleep 1
done