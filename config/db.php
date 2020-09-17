<?php
/**
 * Database Configuration
 *
 * All of your system's database connection settings go in here. You can see a
 * list of the available settings in vendor/craftcms/cms/src/config/DbConfig.php.
 *
 * @see craft\config\DbConfig
 */

return [
    'driver' => getenv('APPSETTING_DB_DRIVER'),
    'server' => getenv('APPSETTING_DB_SERVER'),
    'user' => getenv('APPSETTING_DB_USER'),
    'password' => getenv('APPSETTING_DB_PASSWORD'),
    'database' => getenv('APPSETTING_DB_DATABASE'),
    'schema' => getenv('APPSETTING_DB_SCHEMA'),
    'tablePrefix' => getenv('APPSETTING_DB_TABLE_PREFIX'),
    'port' => getenv('APPSETTING_DB_PORT')
];
