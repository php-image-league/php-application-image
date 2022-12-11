COPY --from=composer:latest /usr/bin/composer $GLOBAL_BINARIES/composer

COPY composer/provisioner.sh $PROVISIONERS_DIR/10_composer_intall.sh

RUN apt-get -yqq update && apt-get -yqq install git zip && rm -rf /var/lib/apt/lists/*