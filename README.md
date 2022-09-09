# docker-wp

Basic Docker configuration for local WordPress development

## Includes

- Apache
- MariaDB
- PHP
- WP-CLI
- phpMyAdmin

## Dependencies

- [Docker Engine](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Configuration

- The optional `.env` file serves as a template using default values
- `UID` and `GID`: Set to the current operating system user values to avoid filesystem permission issues
- `WP_PORT` and `PMA_PORT`: Override the default ports for WordPress and phpMyAdmin
- Assumes that the install ignores `wp-config.php` as the file will be generated when it doesn't exist
- The optional `wp-config-local.php` can be used for supported installs where `wp-config.php` is tracked

## Usage

- Add `compose.yaml` to the root of the local WordPress install
- Start: `docker compose up -d`
- Visit any `localhost` address (http://localhost, http://site.localhost, etc)
- Stop: `docker compose down`

## Features

### WP-CLI

- `docker compose exec wp-cli [command]`
- `[command]` can be any WP-CLI command (`wp media regenerate`, `wp plugin update --all`, etc)

### phpMyAdmin

- phpMyAdmin can be accessed at any `localhost` address on port 8888 (http://localhost:8888, http://site.localhost:8888, etc)
- Login credentials are `root:root` or `username:password`

### Fallback asset loading

- The optional `.htaccess` file can be used to automatically load missing assets from another URL
- `https://example.com` can be changed to the live URL to avoid having to pull down assets for local development
- These directives should always come before the WordPress block
