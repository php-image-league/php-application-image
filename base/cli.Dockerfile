ARG PHP_VERSION
FROM php:${PHP_VERSION}-cli

ENV DEBIAN_FRONTEND noninteractive

INCLUDE php/composer.Dockerfile
