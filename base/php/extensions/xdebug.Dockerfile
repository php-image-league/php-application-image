RUN pecl install xdebug && docker-php-ext-enable xdebug
# todo use env var for paths
COPY php/extensions/xdebug/php.ini $PHP_INI_DIR/conf.d/xdebug.ini