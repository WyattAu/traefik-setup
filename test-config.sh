#!/bin/bash
# test-config.sh
# Script to validate configuration locally

set -e

echo "Testing Traefik Configuration"

# Create test directories if they don't exist
mkdir -p test-data test-logs config/dynamic

# Copy env file if it doesn't exist
if [ ! -f .env ]; then
  cp .env.example .env
  echo "Created .env from .env.example - Please update with your values"
fi

# Validate docker-compose
echo "Validating docker-compose.yml..."
docker-compose config > /dev/null
echo "✓ docker-compose.yml is valid"

# Validate Traefik configuration
echo "Validating Traefik static configuration..."
docker run --rm \
  -v "$(pwd)/config":/etc/traefik \
  -v "$(pwd)/test-data":/data \
  -v "$(pwd)/test-logs":/logs \
  traefik:${TRAEFIK_VERSION:-v2.10} \
  traefik --configFile=/etc/traefik/traefik.yml > /dev/null
echo "✓ Traefik static configuration is valid"

echo "All configurations are valid!"