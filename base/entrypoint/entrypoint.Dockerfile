ENV PROVISIONERS_DIR /usr/local/bin/provisioners
COPY entrypoint/provisioners/*.sh $PROVISIONERS_DIR

COPY entrypoint/entrypoint $GLOBAL_BINARIES/entrypoint
RUN chmod +x "$GLOBAL_BINARIES/entrypoint"

ENTRYPOINT $GLOBAL_BINARIES/entrypoint