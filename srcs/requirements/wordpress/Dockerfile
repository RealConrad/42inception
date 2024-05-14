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
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Install WordPress using WP-CLI
RUN wp core download --allow-root --path=/var/www/html --version=6.4.2

# Copy configuration files and scripts
COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
# COPY tools/index.php /var/www/localhost/htdocs/
COPY tools/wordpress.sh /usr/local/bin/wordpress.sh

RUN chmod +x /usr/local/bin/wordpress.sh

# Set ownership/permissions again to be safe
RUN chown -R nobody:nobody /var/www/html \
    && chmod -R 755 /var/www/html

# Define the entry point and command
# ENTRYPOINT [ "/usr/local/bin/wordpress.sh" ]
EXPOSE 9000
# CMD ["/usr/sbin/php-fpm82", "-F"]
CMD ./usr/local/bin/wordpress.sh