#!bin/sh

# Path where MariaDB stores its data
DATA_PATH="/var/lib/mysql"

# Initialize the database directory if not already initialized
# if [ ! -d "$DATA_PATH/mysql" ]; then
#     echo ">> Initializing database."
#     mariadb-install-db --user=mysql --datadir="$DATA_PATH"

#     # Start the MariaDB server in the background to perform initial setup
#     mysqld_safe --datadir="$DATA_PATH" &
#     pid=$!

#     # Wait for MariaDB to start
#     sleep 10

#     # Secure the installation (optional, could be replaced with custom commands)
#     echo ">> Creating new user and database."

rc-service mariadb start

while ! mysqladmin ping --silent; do
	sleep 1
done
# echo ELO1
mariadb --user=root << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

#     # Properly stop MariaDB after initialization
#     if ! kill -s TERM "$pid" || ! wait "$pid"; then
#         echo >&2 'Initialization failed.'
#         exit 1
#     fi

#     echo ">> Database initialized and user created."

# else
#     echo ">> Database already initialized."
# fi

# Start MariaDB in the foreground for Docker
rc-service mariadb stop
# echo ELO2
exec /usr/bin/mariadbd --datadir="$DATA_PATH" --user=root