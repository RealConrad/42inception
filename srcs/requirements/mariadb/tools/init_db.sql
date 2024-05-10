-- Create the WordPress database
CREATE DATABASE IF NOT EXISTS wordpress_db;

-- Create a new user specifically for WordPress
CREATE USER 'wordpress_user'@'%' IDENTIFIED BY 'secure_password';

-- Grant all privileges on the WordPress database to the new user
GRANT ALL PRIVILEGES ON wordpress_db.* TO 'wordpress_user'@'%';

-- Flush privileges to ensure that the changes take effect
FLUSH PRIVILEGES;