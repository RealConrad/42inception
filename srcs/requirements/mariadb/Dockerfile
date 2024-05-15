# Use Alpine Linux as the base image
FROM alpine:3.19

# Install necessary packages
RUN apk update && apk add --no-cache mariadb mariadb-client openrc

RUN openrc
RUN touch /run/openrc/softlevel

# Copy configuration files and scripts
COPY conf/my.cnf /etc/my.cnf.d/my.cnf
COPY tools/startup.sh /usr/local/bin/startup.sh

RUN chmod +x /usr/local/bin/startup.sh

# Expose the default MariaDB port
RUN /etc/init.d/mariadb setup
EXPOSE 3306

# Use mysqld_safe as the default command to run
CMD [ "startup.sh" ]
