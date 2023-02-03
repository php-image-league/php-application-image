ENV PROVISIONERS_DIR /usr/local/bin/provisioners
RUN mkdir -p "$PROVISIONERS_DIR"

COPY entrypoint/entrypoint $GLOBAL_BINARIES/entrypoint
RUN chmod +x "$GLOBAL_BINARIES/entrypoint"

RUN mkdir /status && chown www-data:www-data /status

ENTRYPOINT $GLOBAL_BINARIES/entrypoint
