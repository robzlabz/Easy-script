#!/bin/bash
# Created by Robbyn
# Bash Install Phalcon for Centos 6.x VestaCP

# Install Phalcon Development Tools
mkdir /usr/local/phalcon && cd /usr/local/phalcon
curl -s http://getcomposer.org/installer | php
rm composer.json
echo '{' >> composer.json
echo '    "require": {' >> composer.json
echo '        "phalcon/devtools": "dev-master"' >> composer.json
echo '    }' >> composer.json
echo '}' >> composer.json
php composer.phar install
ln -s /usr/local/phalcon/vendor/phalcon/devtools/phalcon.php /usr/bin/phalcon
chmod ugo+x /usr/bin/phalcon

# Downgrade PHP to 5.3
/usr/bin/yum downgrade -y php*

# Install Phalcon Requirement
/usr/bin/yum install -y php-devel php-mysql gcc libtool
/usr/bin/yum install -y pcre pcre-devel
/usr/bin/yum install -y git

# Install Phalcon
git clone --depth=1 git://github.com/phalcon/cphalcon.git
cd cphalcon/build
sudo ./install

# Make Phalcon Run
echo "extension=phalcon.so" >> /etc/php.d/pdo_mysql.ini
service httpd restart

# Make phpinfo() test
echo "<?php phpinfo(); ?>" > /home/admin/web/default.domain/public_html/info.php

# Create Result
myip=$(wget vestacp.com/what-is-my-ip/ -O - 2>/dev/null)
echo ""
echo "Browse to ${myip}/info.php to make sure phalcon is running. Thanks"
