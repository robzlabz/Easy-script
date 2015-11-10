#!/bin/bash
# By Robbyn Rahmandaru for agcmanager.com

dbname=$1
dbuser=$2
dbpass=$3

v-add-web-domain admin $domain $ip
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

echo 'Setup Complete'
