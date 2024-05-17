# Use Alpine Linux as the base image
FROM alpine:3.19

# Install necessary packages
RUN apk update && apk add --no-cache mariadb mariadb-client openrc

RUN openrc
RUN touch /run/openrc/softlevel

# Copy configuration files and scripts
COPY conf/my.cnf /etc/my.cnf.d/my.cnf
COPY tools/startup_mariadb.sh /usr/local/bin/startup_mariadb.sh

RUN chmod +x /usr/local/bin/startup_mariadb.sh

RUN /etc/init.d/mariadb setup

# Expose the default MariaDB port
EXPOSE 3306

CMD [ "startup_mariadb.sh" ]
