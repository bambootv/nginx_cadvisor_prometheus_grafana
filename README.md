## Nginx + Alloy + Prometheus + Loki Stack

A modernized observability stack bundling Nginx, Grafana Alloy, Prometheus, Loki, and Grafana in a single project. Alloy collects host/container metrics plus all container logs (forwarded to Loki). Request-level dashboards read directly from Loki, so no extra Telegraf/sidecar is required.

### Table of Contents

- [Architecture](#architecture)
- [Data Flow](#data-flow)
- [Components](#components)
- [Prepare Nginx Assets](#prepare-nginx-assets)
- [Run with Docker Compose](#run-with-docker-compose)
- [Run with Docker Swarm](#run-with-docker-swarm)
- [Grafana Provisioning](#grafana-provisioning)
- [Directory Layout](#directory-layout)
- [Customize Alloy](#customize-alloy)
- [Cleanup](#cleanup)

### Architecture

```
                                   Docker Host
┌─────────────────────────────────────────────────────────────────────────────┐
│ Shared volumes                                                             │
│  • prometheus_data, grafana_data, loki_data (Compose only)                  │
│                                                                             │
│ Mounted host paths                                                          │
│  • /proc, /sys, / → alloy (for host stats)                                 │
│  • /var/run/docker.sock → alloy (for container discovery/logs)              │
│                                                                             │
│ Containers                                                                  │
│  • nginx              – reverse proxy, logs to stdout/stderr                │
│  • alloy              – Grafana Alloy collector (metrics + logs endpoint)   │
│  • prometheus         – scrapes Alloy metrics & receives remote_write       │
│  • loki               – ingests logs from Alloy (port 3102)                 │
│  • grafana            – dashboards + log explorer (port 3456)               │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Data Flow

```mermaid
flowchart TB
  subgraph Host["Docker Host"]
    nginx[[Nginx]] -- "stdout/stderr\n(Docker logging driver)" --> alloy
    others[(Other containers)] -- "stdout/stderr\nvia docker.sock" --> alloy

    alloy[[Grafana Alloy]]
    prom[[Prometheus]]
    loki[[Loki]]
    grafana[[Grafana]]
    remote[(Remote write target)]

    alloy -- "push logs" --> loki
    alloy -- "/metrics (12345)\nremote_write" --> prom
  end

  prom -- "dashboards & alerts" --> grafana
  loki -- "log explorer + LogQL metrics" --> grafana
  prom -- "remote_write" --> remote

  dockerSock[/var/run/docker.sock/] -. read-only mount .-> alloy
  hostFS[/host FS:\n/proc, /sys, /\ ] -. read-only mount .-> alloy
```

### Components

- `nginx`: reverse proxy image stored in `docker-compose.dev.yml` / `docker-compose.prod.yml`; logs are streamed to stdout/stderr so Docker can enforce `max-size`/`max-file`.
- `alloy`: Grafana Alloy collector defined in both Compose files with mounts for `/var/run/docker.sock`, `/proc`, `/sys`, `/`. Handles log tailing, host/container metrics, and exposes `/metrics` on `12345`.
- `prometheus`: scrapes Alloy (`/metrics`) and receives Alloy remote write; stores data in `prometheus_data`.
- `loki`: receives pushes from Alloy at `http://loki:3102/loki/api/v1/push`, stores chunks in `loki_data` (Compose) or swarm-managed volume.
- `grafana`: provisions Prometheus/Loki datasources and dashboards, served on `3456`.

### Prepare Nginx Assets

```bash
cp nginx/nginx_sites_available.example nginx/nginx_sites_available
```

Customize `nginx/nginx.conf` và `nginx/nginx_sites_available` tùy theo nhu cầu. Dung lượng log được quản lý bởi Docker logging driver (xem `docker-compose.*.yml` để chỉnh `max-size`/`max-file`). Request-level charts đọc trực tiếp từ Loki, nên không cần translator phụ cho access log.


### Run with Docker Swarm

```bash
make swarm          # init swarm (first time)
make stack          # deploy `monitoring` stack (uses docker-compose.prod.yml)
```

Useful environment variables:

- `COMMON_REPLICAS`: shared replica count for Alloy/Prom/Loki/Grafana.
- `NGINX_REPLICAS`: replica count for Nginx.

### Grafana Provisioning

- Prometheus & Loki datasources are provisioned automatically in `grafana/provisioning/datasources`.
- Sample dashboards live in `grafana/dashboards` (for example `nginx_overview.json`).

### Directory Layout

- `alloy/` – collector configuration.
- `grafana/provisioning/` – provisioned datasources and dashboards.
- `grafana/dashboards/` – dashboard JSON files.
- `loki/` – Loki configuration.
- `prometheus/` – Prometheus configuration that scrapes Alloy.
- `nginx/` – Nginx configuration.

### Customize Alloy

The `alloy/config.alloy` file defines the pipeline. Enable more integrations or forward metrics/logs to another destination by adding the relevant blocks, then run `docker compose restart alloy`.

### Cleanup

```bash
docker compose down -v
```

The command removes containers and volumes (including Prometheus/Loki/Grafana data). Drop `-v` if you want to keep the data.
