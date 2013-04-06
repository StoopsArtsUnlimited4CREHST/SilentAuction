#!/bin/sh
#sudo wget -O /var/lib/tomcat7/webapps/Auction.war https://github.com/StoopsArtsUnlimited4CREHST/SilentAuction/raw/master/distro/Auction.war && sudo service tomcat7 restart

sudo wget -O /tmp/Auction.war https://github.com/StoopsArtsUnlimited4CREHST/SilentAuction/raw/master/distro/Auction.war
sudo rm /var/lib/tomcat7/webapps/Auction.war
sudo cp /tmp/Auction.war /var/lib/tomcat7/webapps/Auction.war
sudo service tomcat7 restart