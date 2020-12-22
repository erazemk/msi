#!/bin/sh

# Wait for the database to initialize
sleep 15

mysql --user=mysql --password=password --host=database -P 3306 <<EOF
USE time;
CREATE TABLE time (id INT AUTO_INCREMENT PRIMARY KEY, time VARCHAR(32) NOT NULL);
EOF

while true; do
    DATE="$(date '+%H:%M:%S (%A, %d. %m. %y)')"
    mysql --user=mysql --password=password --host=database time -e "INSERT INTO time (time) VALUES (\'${DATE}\')" -P 3306
    sleep 1
done