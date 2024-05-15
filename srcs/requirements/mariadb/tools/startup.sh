#!bin/sh

# Path where MariaDB stores its data
DATA_PATH="/var/lib/mysql"

rc-service mariadb start

while ! mysqladmin ping --silent; do
	sleep 1
done
# echo ELO1
mariadb --user=root << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS ${DB_NAME};
CREATE USER IF NOT EXISTS '${DB_USERNAME}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USERNAME}'@'%';
FLUSH PRIVILEGES;
EOF

rc-service mariadb stop
exec /usr/bin/mariadbd --datadir="$DATA_PATH" --user=root
