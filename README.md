# Traefik Setup

[![CI](https://github.com/your-organization/traefik-setup/actions/workflows/ci.yml/badge.svg)](https://github.com/your-organization/traefik-setup/actions)

Simple Traefik setup originally use for TrueNAS.

## Features

- Automatic HTTPS with Let's Encrypt
- HTTP/3 and QUIC support
- Dashboard with authentication
- Security headers and rate limiting
- JSON logging
- Health checks
- External volume support
- CI/CD validation
- Dependency updates

## Prerequisites

1. Docker and Docker Compose
2. Domain name pointing to your server

## Setup

1. Clone this repository:

```bash
git clone https://github.com/your-organization/traefik-setup.git
cd traefik-setup
```

2. Create required directories:

```bash
mkdir -p /mnt/tank/docker/traefik/{config,data,logs,config/dynamic}
chown -R 1000:1000 /mnt/tank/docker/traefik
```

3. Copy and configure environment file:

```bash
cp .env.example .env
Edit .env with your values
```

4. Generate dashboard credentials:

```bash
echo $(htpasswd -nb admin yourpassword) | sed -e s/\\$/\\$\\$/g
```

5. Add `traefik.yml` to `TRAEFIK_CONFIG/config`
6. create `TRAEFIK_CONFIG/config/dynamic` folder

7. Deploy with Docker Compose:

```bash
docker-compose up -d
```
