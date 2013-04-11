#!/bin/sh
#sudo mv Auction.war /var/lib/tomcat7/webapps/ && sudo service tomcat7 restart
#sudo wget -O Auction.war https://github.com/StoopsArtsUnlimited4CREHST/SilentAuction/raw/master/distro/Auction.war
sudo rm -rf /var/lib/tomcat7/webapps/Auction.war /var/lib/tomcat7/webapps/Auction
sudo cp Auction.war /var/lib/tomcat7/webapps/Auction.war
sudo service tomcat7 restart
