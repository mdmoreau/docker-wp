<?php
define( 'DB_HOST', 'database' );
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'username' );
define( 'DB_PASSWORD', 'password' );
define( 'WP_DEBUG', true );
define( 'WP_HOME', 'http://' . ($_SERVER['HTTP_HOST'] ?? 'localhost') );
define( 'WP_SITEURL', 'http://' . ($_SERVER['HTTP_HOST'] ?? 'localhost') );
define( 'WP_ENVIRONMENT_TYPE', 'local' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
