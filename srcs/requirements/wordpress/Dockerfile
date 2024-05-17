# Base image
FROM alpine:3.19

# Install necessary PHP extensions for WordPress
RUN apk update && apk upgrade
RUN apk add --no-cache \
    php82 \
    php82-fpm \
    php82-mysqli \
    php82-json \
    php82-openssl \
    php82-curl \
    php82-zlib \
    php82-xml \
    php82-phar \
    php82-intl \
    php82-dom \
    php82-xmlreader \
    php82-ctype \
    php82-session \
    php82-mbstring \
    php82-zip \
    php82-cli \
    php82-gd \
    curl

# Create a symbolic link for php
RUN ln -s /usr/bin/php82 /usr/local/bin/php

# Create the directory and set correct permissions
RUN mkdir -p /var/www/html \
	&& chown -R nobody:nobody /var/www/html \
	&& chmod -R 755 /var/www/html

# Install WordPress CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp \
	&& sed -i "s/listen = 127.0.0.1:9000/listen = 0.0.0.0:9000/" /etc/php82/php-fpm.d/www.conf \
	&& wp core download --path=/var/www/html/

# Copy configuration files and scripts
COPY tools/startup_wordpress.sh /usr/local/bin/startup_wordpress.sh
RUN chmod +x /usr/local/bin/startup_wordpress.sh

# Set ownership/permissions again to be safe
RUN touch /var/log/php82/error.log \
	&& chown -R nobody:nobody /var/www/html/ \
	&& chmod -R 755 /var/www/html \
	&& chown -R nobody:nobody /var/log/php82/error.log

USER nobody

EXPOSE 9000

CMD [ "./usr/local/bin/startup_wordpress.sh" ]
