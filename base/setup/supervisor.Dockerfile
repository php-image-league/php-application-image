ENV SUPERVISORD_CONFIG /etc/supervisor/conf.d/supervisord.conf
RUN apt-get -yqq update && apt-get -yqq install supervisor && rm -rf /var/lib/apt/lists/*
CMD ["/usr/bin/supervisord", "-c", "$SUPERVISORD_CONFIG"]