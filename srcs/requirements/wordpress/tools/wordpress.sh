#!/bin/sh

sleep 10

# Navigate to the WordPress directory
cd /var/www/html

# TESTING:
echo TESTING
pwd
echo dbname: $DB_NAME
echo dbuser: $DB_USERNAME
echo db pasword: $DB_PASSWORD
echo wp admin name: $WP_ADMIN_NAME
echo wp admin password: $WP_ADMIN_PASSWORD
echo wp admin email: $WP_ADMIN_EMAIL
echo END TESTINGn\n

# Configuring wp-config.php
wp config create --dbname="$DB_NAME" --dbuser="$DB_USERNAME" \
	--dbpass="$DB_PASSWORD" --dbhost=mariadb:3306

# Install WordPress
wp core install --url="https://localhost" --title="Ahhhhhh help me" \
	--admin_user="$WP_ADMIN_NAME" --admin_password="$WP_ADMIN_PASSWORD" \
	--admin_email="$WP_ADMIN_EMAIL" --skip-email

wp option update home 'https://localhost'
wp option update siteurl 'https://localhost'

# wp user create $WP_ADMIN_NAME $WP_ADMIN_EMAIL --role=author --user_pass=$WP_ADMIN_PASSWORD
chown -R nobody:nobody /var/www/html
find . -type d -exec chmod 755 {} \;
find . -type f -exec chmod 644 {} \;

php-fpm82 -F
