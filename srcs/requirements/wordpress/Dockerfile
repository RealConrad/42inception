# Base image
FROM alpine:3.18

# Set working directory
WORKDIR /var/www/html

# InstallPHP and necessart extensions for wordpress
RUN apk update && apk upgrade
RUN apk add php82 php82-fpm php82-mysqli curl \
php \
php82 \
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
php82-gd

# RUN apk info -L php82-fpm
# RUN which php82-fpm || ls -l /usr/sbin/

# Install wordpress
RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xzf latest.tar.gz \
	&& mv wordpress/* . \
	&& rm -f latest.tar.gz

# Install WordPress CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /bin/wp

COPY conf/www.conf /etc/php82/php-fpm.d/www.conf
COPY tools/index.php /var/www/localhost/htdocs/
COPY tools/wordpress.sh /usr/local/bin/wordpress.sh

RUN chmod +x /usr/local/bin/wordpress.sh

# Set ownership/permissions
RUN chown -R nobody:nobody /var/www/html \
	&& chmod -R 755 /var/www/html

ENTRYPOINT [ "/usr/local/bin/wordpress.sh" ]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm82", "-F"]
