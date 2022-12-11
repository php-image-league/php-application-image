INCLUDE fpm.Dockerfile

INCLUDE nginx/as-root.Dockerfile
INCLUDE php/fpm/as-root.Dockerfile

INCLUDE php/extensions/xdebug.Dockerfile

RUN apt-get -yqq update && apt-get -yqq install wget vim && rm -rf /var/lib/apt/lists/*

RUN mv -f "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"