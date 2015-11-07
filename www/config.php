<?php

// General Config Information //
const CMW_USING_DB = true;
const CMW_USING_MYSQL = true;		// True if MySQL, PerconaDB, and MariaDB
//const CMW_USING_MARIADB = true;
//const CMW_USING_PDO = true;		// Default Database is MySQL. Enable this to use PDO.
const CMW_USING_APCU = true;
const CMW_USING_MEMCACHED = true;
const CMW_USING_REDIS = true;
const CMW_USING_MAGICK = true;
const CMW_USING_IMAGEMAGICK = true;
//const CMW_USING_GRAPHICSMAGICK = true;

// Database Config //
const CMW_DB_HOST = 'localhost';
const CMW_DB_NAME = 'scotchbox';
const CMW_DB_LOGIN = 'root';
const CMW_DB_PASSWORD = 'root';
//const CMW_DB_PORT = 3306;

const CMW_TABLE_PREFIX = 'cmw_';

// Memcached Config //
const CMW_MEMCACHED_HOST = 'localhost';
const CMW_MEMCACHED_PORT = 11211;

// Redis Config //
const CMW_REDIS_HOST = 'localhost';

// Debug Flags //
const CMW_PHP_DEBUG = true;			// PHP Debug Mode: Extra logging, query debug features.
const CMW_CSS_DEBUG = true;			// CSS Debug Mode: Not minified, src includes.
const CMW_JS_DEBUG = true;			// JavaScript Debug Mode: Not minified, src includes.

// Paths //
const CMW_STATIC_DIR = '/public-static';
define("CMW_STATIC_URL",'//'.$_SERVER['SERVER_ADDR'].':8080');
const CMW_THEME_BASE = '/themes';

// Access Permission Whitelist (Can be arrays on PHP 5.6+) //
const CMW_ACCESS_DATA = "192.168.48.1";

// API Keys //
const GOOGLE_API_KEY = '';
const TWITCH_API_KEY = '';
const TWITTER_API_KEY = '';
const FACEBOOK_API_KEY = '';
const INSTAGRAM_API_KEY = '';
const TUMBLR_API_KEY = '';

?>
