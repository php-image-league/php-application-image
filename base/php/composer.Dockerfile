COPY --from=composer:latest /usr/bin/composer $GLOBAL_BINARIES/composer
RUN apt-get -yqq update && apt-get -yqq install git zip && rm -rf /var/lib/apt/lists/*