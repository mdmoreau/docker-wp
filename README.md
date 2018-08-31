# start/stop docker
- docker-compose up -d
- docker-compose down

# download wordpress and create config
- docker-compose run php wp --path=/var/www/html core download --allow-root
- docker-compose run php wp --path=/var/www/html config create --dbname=wordpress --dbuser=username --dbpass=password --dbhost=mysql --allow-root

# return file ownership to host user
- sudo chown -R $USER .

# wp-config-local.php
```php
<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'username');
define('DB_PASSWORD', 'password');
define('DB_HOST', 'mysql');
define('WP_HOME', 'http://localhost');
define('WP_SITEURL', 'http://localhost');
```
