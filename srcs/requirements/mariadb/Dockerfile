# Use Alpine Linux as the base image
FROM alpine:3.18

# Install necessary packages
RUN apk update && apk add --no-cache mariadb mariadb-client mariadb-server-utils \
    && rm -rf /var/cache/apk/*

# Ensure the MariaDB directories are properly set up
RUN mkdir -p /run/mysqld /var/log/mysql /var/lib/mysql

# Copy configuration files and scripts
COPY conf/my.cnf /etc/my.cnf
COPY tools/init_db.sql /docker-entrypoint-initdb.d/init_db.sql
COPY tools/startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

# Expose the default MariaDB port
EXPOSE 3306

# Set the entrypoint script to initialize the database
ENTRYPOINT ["/usr/local/bin/startup.sh"]

# Use mysqld_safe as the default command to run
CMD ["mysqld_safe"]
