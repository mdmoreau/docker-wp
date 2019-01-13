# docker-wp

Basic Docker configuration for local WordPress development

## Dependencies

- [Docker](https://docs.docker.com/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Includes

- NGINX
- MariaDB
- PHP-FPM
- WP-CLI
- phpMyAdmin

## Usage

- Start: `docker compose up -d`
- Stop: `docker compose down`

## Features

### WP-CLI

- `docker-compose run php wp [command]`
- `[command]` can be any WP-CLI command, e.g. `plugin update --all`

### Fallback asset loading

- The `docker-nginx.conf` file can be edited to automatically load any missing assets from another URL
- `https://example.com/wp-content/uploads/` can be changed to your live uploads URL to avoid having to pull down assets for local development

### Accessing localhost

- When running the start command, the install will be available on http://localhost by default
- Any sort of `localhost` address will work, so it's recommended to use something like http://site.localhost to distinguish multiple installs
- Unless you change the default ports in `docker-compose.yml`, only one instance of this setup can run at a time (data still persists after stopping)
- It may also be necessary to stop anything else running on the host's port 80 (typically Apache) or change the default ports as mentioned above

### phpMyAdmin

- phpMyAdmin can be accessed at http://localhost:8080 or any other `localhost` address (e.g. http://site.localhost:8080) on port 8080 with `root:root` or `username:password`
- The port for this can be adjusted in `docker-compose.yml` as needed

## Example usage

### Tracking an entire install

- Some services like Pantheon support a `wp-config-local.php` file for a local development configuration
- This typically involves tracking an entire WordPress install in git while ignoring the local configuration file
- Most databases can be imported without needing edits as the `WP_HOME` and `WP_SITEURL` values from `wp-config-local.php` will take precedence over the `wp_options` values

```php
<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'username');
define('DB_PASSWORD', 'password');
define('DB_HOST', 'mysql');
define('WP_HOME', 'http://site.localhost');
define('WP_SITEURL', 'http://site.localhost');
```

### Whitelisting specific files

- If you only want to track specific files (e.g. your theme) in git, you can still get a development environment setup quickly with a few WP-CLI commands
- The commands will download and install WordPress along with any plugins that are required
- An initial admin user with credentials `admin:admin` will be created
- A database can be imported after this process, though the `home` and `siteurl` values will need to be updated in the `wp_options` table to match the new `localhost` URL

```
docker-compose run php wp core download
docker-compose run php wp config create --dbname=wordpress --dbuser=username --dbpass=password --dbhost=mysql
docker-compose run php wp core install --url=site.localhost --title=site.localhost --admin_user=admin --admin_password=admin --admin_email=admin@site.localhost --skip-email
docker-compose run php wp plugin install plugin-a plugin-b plugin-c
```
