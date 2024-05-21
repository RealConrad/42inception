#!bin/sh

# Path where MariaDB stores its data
DATA_PATH="/var/lib/mysql"

# echo "DB_NAME: " $DB_NAME
# echo "DB_USERNAME: " $DB_USERNAME
# echo "DB_PASSWORD: " $DB_PASSWORD

rc-service mariadb start

while ! mysqladmin ping --silent; do
	echo "Checking if mariadb server started..."
	sleep 1
done

mariadb --user=root << EOF
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $DB_NAME;
CREATE USER IF NOT EXISTS '$DB_USERNAME'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USERNAME'@'%';
FLUSH PRIVILEGES;
EOF

rc-service mariadb stop

echo "MariaDB successfully setup..."

exec /usr/bin/mariadbd --datadir="$DATA_PATH" --user=root
