ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

ENV DEBIAN_FRONTEND noninteractive

INCLUDE supervisor/Dockerfile
COPY php/fpm/supervisord.conf $SUPERVISORD_CONFIG

INCLUDE nginx/Dockerfile
COPY php/fpm/virtual_host.conf $NGINX_VHOST_PATH

INCLUDE setup/Dockerfile

INCLUDE entrypoint/Dockerfile
INCLUDE healthcheck/Dockerfile

INCLUDE composer/Dockerfile

RUN mv -f "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"