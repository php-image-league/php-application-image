COPY healthcheck/healthcheck $GLOBAL_BINARIES/healthcheck
COPY healthcheck/wait_for_healthy $GLOBAL_BINARIES/wait_for_healthy
RUN chmod +x $GLOBAL_BINARIES/healthcheck $GLOBAL_BINARIES/wait_for_healthy
HEALTHCHECK --start-period=1m --interval=30s --timeout=1s --retries=3 CMD $GLOBAL_BINARIES/healthcheck >> /dev/null