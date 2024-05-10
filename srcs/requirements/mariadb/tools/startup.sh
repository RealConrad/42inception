#!/bin/sh

# Check if the initial database setup needs to be done
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "CLOWN>> Database is not initialized. Initializing database."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql

    # Start the MariaDB server in the background
    mysqld_safe --datadir="/var/lib/mysql" &
    pid=$!

    # Wait for MariaDB to start
    sleep 10

	# Fill the secrets
	sed -i "s/wordpress_db/$WP_DB_NAME/g" /docker-entrypoint-initdb.d/init_db.sql
	sed -i "s/wordpress_user/$WP_USERNAME/g" /docker-entrypoint-initdb.d/init_db.sql
	sed -i "s/secure_password/$WP_DB_PASSWORD/g" /docker-entrypoint-initdb.d/init_db.sql
    
	# Run SQL statements from the init file
    if [ -f "/docker-entrypoint-initdb.d/init_db.sql" ]; then
        mysql < /docker-entrypoint-initdb.d/init_db.sql
    fi

    # Properly stop MariaDB after initialization
    if ! kill -s TERM "$pid" || ! wait "$pid"; then
        echo >&2 'MariaDB init process failed.'
        exit 1
    fi
else
    echo "CLOWN>> Database already initialized"
fi
# Now, start MariaDB in the foreground
exec mysqld_safe --datadir="/var/lib/mysql"
