#!/bin/sh

# echo "-------START :: Starting WordPress Configuration :: START-------"
# echo "Database Name: ${WP_DB_NAME}"
# echo "Database User: ${WP_USERNAME}"
# echo "Database Password: ${WP_DB_PASSWORD}"
# echo "Database Host: ${WP_DB_HOST}"
# echo "-------END :: Starting WordPress Configuration :: END-------"

if [ ! -f "wp-config.php" ]; then
	cp wp-config-sample.php wp-config.php
	sed -i "s/database_name_here/${WP_DB_NAME}/g" wp-config.php
	sed -i "s/username_here/${WP_USERNAME}/g" wp-config.php
	sed -i "s/password_here/${WP_DB_PASSWORD}/g" wp-config.php
	sed -i "s/localhost/${WP_DB_HOST}/g" wp-config.php

	# sed -i "s/define( 'WP_DEBUG', false );/define( 'WP_DEBUG', true );/g" wp-config.php
	# echo "define('WP_DEBUG_LOG', true);" >> wp-config.php
	# cat wp-config.php
	echo "COMPLETED SCRIPT"
fi
sleep 10

ln -s /usr/bin/php82 /usr/bin/php
# Install WordPress if not already installed
# if ! $(wp core is-installed --allow-root); then
    wp core install --url="${WP_DOMAIN}" --title="Clown God" --admin_user="${WP_ADMIN_NAME}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="cwenz@clown.god" --allow-root
# fi
sleep 10
wp user create "clown" "clown@clown.clown" --role=author --user_pass="clown" --allow-root

exec "$@"