# Use Alpine Linux as the base image
FROM alpine:3.19

# Install necessary packages
RUN apk update && apk add --no-cache mariadb mariadb-client openrc

RUN openrc
RUN touch /run/openrc/softlevel
# Ensure the MariaDB directories are properly set up
# RUN mkdir -p /run/mysqld /var/log/mysql /var/lib/mysql

# Copy configuration files and scripts (Make sure to have these files in your context)
COPY conf/my.cnf /etc/my.cnf.d/my.cnf
COPY tools/startup.sh /usr/local/bin/startup.sh
# Initialize the database
# RUN mariadb-install-db

RUN chmod +x /usr/local/bin/startup.sh

# Expose the default MariaDB port
RUN /etc/init.d/mariadb setup
EXPOSE 3306

# Set the entrypoint script to initialize the database
# ENTRYPOINT ["/usr/local/bin/startup.sh"]

# Use mysqld_safe as the default command to run
CMD [ "startup.sh" ]
