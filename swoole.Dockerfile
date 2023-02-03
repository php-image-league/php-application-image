ARG PHP_VERSION=8.1
FROM php:${PHP_VERSION}-cli

ENV DEBIAN_FRONTEND noninteractive

RUN pecl install openswoole && docker-php-ext-enable openswoole

INCLUDE supervisor/Dockerfile
COPY php/swoole/supervisord.conf $SUPERVISORD_CONFIG

INCLUDE nginx/Dockerfile
COPY php/swoole/virtual_host.conf $NGINX_VHOST_PATH
# todo use env var for paths
RUN sed -i 's/user nginx;/user www-data;/' "$NGINX_CONFIG"

RUN chown www-data:www-data /status

INCLUDE setup/Dockerfile

INCLUDE entrypoint/Dockerfile
INCLUDE healthcheck/Dockerfile

INCLUDE composer/Dockerfile

RUN mv -f "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# clean up permissions since we are gonna run as non-root
RUN chown -R www-data:www-data $PROJECT_ROOT /var/log
