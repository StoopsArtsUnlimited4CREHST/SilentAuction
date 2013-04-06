#!/bin/sh
wget -O schema.sql https://github.com/StoopsArtsUnlimited4CREHST/SilentAuction/raw/master/MySQL/schema.sql && sudo /usr/bin/mysql -u root -p < schema.sql && sudo service mysql restart
