FROM alpine:3.18

# Install NGINX and OpenSSL
RUN apk --no-cache add nginx openssl

# Create directory for SSL certificates
RUN mkdir /etc/nginx/ssl

# Generate SSL certificate and key
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt \
	-subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com"

# Copy the NGINX configuration file into the container
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Exose port 443
EXPOSE 443

# Run NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
