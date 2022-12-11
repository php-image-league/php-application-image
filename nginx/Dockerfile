RUN apt-get -yqq update \
 && apt-get -yqq install nginx \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /var/www/html

ENV NGINX_VHOST_PATH /etc/nginx/sites-enabled/default
ENV NGINX_CONFIG /etc/nginx/nginx.conf