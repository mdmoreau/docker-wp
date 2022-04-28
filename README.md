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
- See environment variables below for configuration options

## Features

### WP-CLI

- `docker compose run php wp [command]`
- `[command]` can be any WP-CLI command, e.g. `plugin update --all`

### Fallback asset loading

- The `docker-nginx.conf` file can be edited to automatically load any missing assets from another URL
- `https://example.com/wp-content/uploads/` can be changed to your live uploads URL to avoid having to pull down assets for local development

### Accessing localhost

- When running the start command, the install will be available on http://localhost by default
- Any sort of `localhost` address will work, so it's recommended to use something like http://site.localhost to distinguish multiple installs
- Unless you change the default port via environment variables, only one instance of this setup can run at a time (data still persists after stopping)
- It may also be necessary to stop anything else running on the host's port 80 (typically Apache) or change the default port via environment variables

### phpMyAdmin

- phpMyAdmin can be accessed at http://localhost:8888 or any other `localhost` address (e.g. http://site.localhost:8888) on port 8888 with `root:root` or `username:password`
- The port for this can be adjusted as an environment variable

### Environment variables

- Environment variables can be added to a `.env` file in the project root to override default values as needed
- The following snippet shows what a `.env` file would look like while using all default values

```
UID=1000
GID=1000
NGINX_PORT=80
PMA_PORT=8888
```

- `UID` and `GID`: Set to your current OS user values to avoid filesystem permission issues
	- Can be typically found by running `id` from a terminal
- `NGINX_PORT` and `PMA_PORT`: Override the default ports for NGINX and phpMyAdmin
	- Useful if you already have other things running on the default ports
- Stopping Docker and running `docker compose build` after changing these values will ensure changes take effect

## Example usage

### Tracking an entire install

- This typically involves tracking an entire WordPress install in git while ignoring the configuration file
- Things like the uploads and cache directories are normally ignored as well
- A `wp-config.php` file can created by using the code block underneath as a template
- Most databases can be imported without needing edits as the `WP_HOME` and `WP_SITEURL` will take precedence over the `wp_options` values

```php
<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'username');
define('DB_PASSWORD', 'password');
define('DB_HOST', 'mysql');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
define('WP_HOME', 'http://' . ($_SERVER['HTTP_HOST'] ?? 'localhost'));
define('WP_SITEURL', 'http://' . ($_SERVER['HTTP_HOST'] ?? 'localhost'));

$table_prefix = 'wp_';

if (!defined('ABSPATH')) {
	define('ABSPATH', dirname(__FILE__) . '/');
}

require_once(ABSPATH . 'wp-settings.php');
```

- Some services like Pantheon support a `wp-config-local.php` file for a local development configuration
- This can use a trimmed down version of the above code block, as seen below

```php
<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'username');
define('DB_PASSWORD', 'password');
define('DB_HOST', 'mysql');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');
define('WP_HOME', 'http://' . ($_SERVER['HTTP_HOST'] ?? 'localhost'));
define('WP_SITEURL', 'http://' . ($_SERVER['HTTP_HOST'] ?? 'localhost'));
```

### Whitelisting specific files

- If you only want to track specific files (e.g. your theme) in git, you can still get a development environment setup quickly with a few WP-CLI commands
- The commands will download and install WordPress along with any plugins that are required
- An initial admin user with credentials `admin:admin` will be created
- A database can be imported after this process, though the `home` and `siteurl` values will need to be updated in the `wp_options` table to match the new `localhost` URL

```
docker compose run php wp core download
docker compose run php wp config create --dbname=wordpress --dbuser=username --dbpass=password --dbhost=mysql
docker compose run php wp core install --url=site.localhost --title=site.localhost --admin_user=admin --admin_password=admin --admin_email=admin@site.localhost --skip-email
docker compose run php wp plugin install plugin-a plugin-b plugin-c
```
