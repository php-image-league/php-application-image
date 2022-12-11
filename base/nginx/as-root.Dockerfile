# todo use env var for paths
RUN sed -i -e 's/user www-data;/user root root;/g' "$NGINX_CONFIG"