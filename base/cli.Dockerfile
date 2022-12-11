ARG PHP_VERSION
FROM php:${PHP_VERSION}-cli

ENV DEBIAN_FRONTEND noninteractive

INCLUDE setup/env.Dockerfile

INCLUDE php/composer.Dockerfile
