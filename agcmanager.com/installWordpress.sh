#!/bin/bash
# By Robbyn Rahmandaru for agcmanager.com

dbname=$1
dbuser=$2
dbpass=$3

echo "Create web domain..."
v-add-domain admin $domain $ip

echo "Setting DNS..."
v-add-dns-record admin $domain ns1 A $ip
v-add-dns-record admin $domain ns2 A $ip
v-change-dns-record admin $domain 1 "ns1.${domain}."
v-change-dns-record admin $domain 2 "ns2.${domain}."
v-change-dns-domain-soa admin $domain "ns1.${domain}"
service named restart

echo "Download and Installing Wordpress.."
cd /home/admin/web/$domain/public_html/
wget -q https://wordpress.org/latest.zip
unzip -q latest.zip
rm -f index.html robots.txt latest.zip
cd wordpress/
mv * ../
cd ..
sed "s/database_name_here/$dbname/g" wp-config-sample.php > wp-config1.php
rm wp-config-sample.php
sed "s/username_here/$dbuser/g" wp-config1.php > wp-config2.php
rm wp-config1.php
sed "s/password_here/$dbpass/g" wp-config2.php > wp-config.php
rm wp-config2.php

chown admin:admin .

echo 'Setup Complete'
