ARG PHP_VERSION
FROM php:${PHP_VERSION}-fpm

ENV DEBIAN_FRONTEND noninteractive

INCLUDE setup/supervisor.Dockerfile
COPY php/fpm/supervisord.conf $SUPERVISORD_CONFIG

INCLUDE nginx/nginx.Dockerfile
COPY php/fpm/virtual_host.conf $NGINX_VHOST_PATH