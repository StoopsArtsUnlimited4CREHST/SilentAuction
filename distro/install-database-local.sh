#!/bin/sh
sudo /usr/bin/mysql -u root -p < schema.sql && sudo service mysql restart
