FROM traefik:v3.5

# Add custom configuration
COPY config/ /etc/traefik/

# Create directories with permissions
RUN mkdir -p /data /logs && \
    touch /data/acme.json && \
    chmod 600 /data/acme.json

# Set user
USER 65532:65532

# Healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD traefik healthcheck --ping

EXPOSE 80 443 443/udp

ENTRYPOINT ["traefik"]
CMD ["--configFile=/etc/traefik/traefik.yml"]