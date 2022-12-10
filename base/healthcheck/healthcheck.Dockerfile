COPY healthcheck/entrypoint_status $GLOBAL_BINARIES/entrypoint_status
RUN chmod +x $GLOBAL_BINARIES/entrypoint_status
HEALTHCHECK --start-period=1m --interval=30s --timeout=1s --retries=3 CMD $GLOBAL_BINARIES/entrypoint_status >> /dev/null