wget https://wordpress.org/latest.zip
unzip latest.zip
cd wordpress
mv * ../
cd ..
rm latest.zip
rmdir wordpress
read -p "Database Name : " dbname
read -p "Database User : " dbuser
read -p "Database Password : " dbpass
sed "s/database_name_here/$dbname/g" wp-config-sample.php > wp-config1.php
rm wp-config-sample.php
sed "s/username_here/$dbuser/g" wp-config1.php > wp-config2.php
rm wp-config1.php
sed "s/password_here/$dbpass/g" wp-config2.php > wp-config.php
rm wp-config2.php
chown -R admin:admin .
echo '=============='
echo 'Setup Complete'
echo '=============='
