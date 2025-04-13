-- Create users with passwords
CREATE USER 'Rajab'@'%' IDENTIFIED BY 'RajabSecure123!';
GRANT ALL PRIVILEGES ON Bookstore.* TO 'Rajab'@'%' WITH GRANT OPTION;

CREATE USER 'Woo'@'%' IDENTIFIED BY 'WooPass456!';
GRANT ALL PRIVILEGES ON Bookstore.* TO 'Woo'@'%' WITH GRANT OPTION;

-- Apply the changes
FLUSH PRIVILEGES;
