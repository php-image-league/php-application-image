INCLUDE php/$SERVER/Dockerfile

INCLUDE setup/env.Dockerfile

INCLUDE entrypoint/entrypoint.Dockerfile
INCLUDE healthcheck/healthcheck.Dockerfile

INCLUDE php/composer.Dockerfile

RUN mv -f "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"