## Content

- [Content](#content)
- [Design](#design)
- [Environment](#environment)
- [Docker setup](#docker-setup)
- [Migrate and seed data](#migrate-and-seed-data)
- [Deployment](#deployment)

## Design

- API
- Database
- Dashboard

## Environment

- Docker
- Nginx

## Docker setup

```bash
  apt install make

  cp nginx/logrotate.conf.example nginx/logrotate.conf
  cp nginx/nginx_sites_available.example nginx/nginx_sites_available

  make build
  make up
  make dev
```

## Migrate and seed data

## Deployment

```bash
make build
make swarm
make stack
make deploy
```
