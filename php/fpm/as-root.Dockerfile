# todo use env var for paths
RUN sed -i -e 's/user = www-data/user = root/g' /usr/local/etc/php-fpm.d/www.conf \
 && sed -i -e 's/group = www-data/user = root/g' /usr/local/etc/php-fpm.d/www.conf