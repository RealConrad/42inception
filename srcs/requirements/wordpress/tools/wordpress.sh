#!/bin/sh

sleep 10

# Navigate to the WordPress directory
cd /var/www/html

# TESTING:
pwd
echo dbname: $WP_DB_NAME
echo dbuser: $WP_USERNAME
echo db pasword: $WP_DB_PASSWORD

# Configuring wp-config.php
wp config create --dbname="$WP_DB_NAME" --dbuser="$WP_USERNAME" \
	--dbpass="$WP_DB_PASSWORD" --dbhost=mariadb:3306

# Install WordPress
wp core install --url="https://localhost" --title="Ahhhhhh help me" \
	--admin_user="$WP_ADMIN_NAME" --admin_password="$WP_ADMIN_PASSWORD" \
	--admin_email="$WP_ADMIN_EMAIL" --skip-email

wp option update home 'https://localhost'
wp option update siteurl 'https://localhost'

# wp option update home $URL && wp option update siteurl $URL

# WP_DB_ROOT_PASSWORD:
# wp user create $WP_ADMIN_NAME $WP_ADMIN_EMAIL --role=author --user_pass=$WP_ADMIN_PASSWORD
chown -R nobody:nobody /var/www/html
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;
# Start PHP-FPM
# exec php-fpm82 -F
# exec "$@"
php-fpm82 -F
