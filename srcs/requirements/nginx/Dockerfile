# Use alpine as the base image for docker image
FROM alpine:3.19

# Install NGINX and OpenSSL, do not cache index locally -> keep image size small
RUN apk --no-cache add nginx openssl

# Create directory within in the container for SSL certificates
RUN mkdir /etc/nginx/ssl

# Generate SSL certificate and key
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
	-subj "/C=DE/ST=BW/L=Heilbronn/O=42Heilbronn/CN=cwenz.42.fr"

# Copy the NGINX configuration file into the container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# COPY tools/index.html /var/www/localhost/htdocs/index.html

# Exose port 443
EXPOSE 443

# Run NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
