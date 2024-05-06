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

	echo "define('WP_DEBUG', false);" >> wp-config.php
	# cat wp-config.php
	echo "COMPLETED SCRIPT"
fi

exec "$@"