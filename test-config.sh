#!/bin/bash
# Script to validate configuration locally

set -e

echo "Testing Traefik v3.5 Configuration"

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
echo "Validating Traefik v3.5 configuration..."
docker run --rm \
  -v "$(pwd)/config":/etc/traefik \
  -v "$(pwd)/test-data":/data \
  -v "$(pwd)/test-logs":/logs \
  traefik:v3.5 \
  traefik --configFile=/etc/traefik/traefik.yml > /dev/null
echo "✓ Traefik v3.5 configuration is valid"

echo "All configurations are valid!"