<?php
define( 'DB_NAME', 'wordpress' );
define( 'DB_USER', 'username' );
define( 'DB_PASSWORD', 'password' );
define( 'DB_HOST', 'database' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
define( 'WP_HOME', 'http://' . ($_SERVER['HTTP_HOST'] ?? 'localhost') );
define( 'WP_SITEURL', 'http://' . ($_SERVER['HTTP_HOST'] ?? 'localhost') );
