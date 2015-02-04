#!/bin/bash
# Created by Robbyn
# Bash Install Phalcon for Centos 6.x VestaCP
# o-1j+2p-1c+1t-2d-2b+2m-2f-3u-3

# Install Phalcon Requirement
yum --enablerepo=remi,remi-php54 install php-devel
yum install -y gcc libtool pcre-devel git

# Install Phalcon
git clone --depth=1 git://github.com/phalcon/cphalcon.git
cd cphalcon/build
sudo ./install

# Make Phalcon Run
echo "extension=phalcon.so" >> /etc/php.d/pdo_mysql.ini
service httpd restart

# Install Phalcon Development Tools
mkdir /usr/local/phalcon && cd /usr/local/phalcon
curl -s http://getcomposer.org/installer | php
echo '{"require": {"phalcon/devtools": "dev-master"}}' > composer.json
php composer.phar install
ln -s /usr/local/phalcon/vendor/phalcon/devtools/phalcon.php /usr/bin/phalcon
chmod ugo+x /usr/bin/phalcon

# Make phpinfo() test
echo "<?php phpinfo(); ?>" > /home/admin/web/default.domain/public_html/info.php

# Create Result
myip=$(wget vestacp.com/what-is-my-ip/ -O - 2>/dev/null)
echo ""
echo "Browse to ${myip}/info.php to make sure phalcon is running. Thanks"
