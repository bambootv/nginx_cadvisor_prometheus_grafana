## Nginx + Alloy + Prometheus + Loki Stack

A modernized observability stack bundling Nginx, Grafana Alloy, Prometheus, Loki, Telegraf, and Grafana in a single project. Alloy collects host/container metrics while Telegraf exposes Nginx-specific metrics (stub_status and nginxlog_*) for dashboard 14900.

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
│  • nginx_logs  → nginx:/var/log/nginx, alloy:/var/log/nginx,                │
│                     telegraf:/var/log/nginx                                 │
│  • prometheus_data, grafana_data, loki_data (Compose only)                  │
│                                                                             │
│ Mounted host paths                                                          │
│  • /proc, /sys, / → alloy (for host stats)                                 │
│  • /var/run/docker.sock → alloy (for container discovery/logs)              │
│                                                                             │
│ Containers                                                                  │
│  • nginx              – reverse proxy, writes access/error logs             │
│  • alloy              – Grafana Alloy collector (metrics + logs endpoint)   │
│  • telegraf           – exports nginx stub_status + nginxlog_* metrics      │
│  • prometheus         – scrapes alloy + telegraf                            │
│  • loki               – ingests logs from alloy (port 3102)                 │
│  • grafana            – dashboards + log explorer (port 3456)               │
└─────────────────────────────────────────────────────────────────────────────┘
```

### Data Flow

```mermaid
flowchart TB
  subgraph Host["Docker Host"]
    nginx[[Nginx]] -- "access/error logs\n(nginx_logs volume)" --> alloy
    others[(Other containers)] -- "stdout/stderr\nvia docker.sock" --> alloy

    alloy[[Grafana Alloy]]
    telegraf[[Telegraf]]
    prom[[Prometheus]]
    loki[[Loki]]
    grafana[[Grafana]]
    remote[(Remote write target)]

    alloy -- "push logs" --> loki
    alloy -- "/metrics (12345)\nremote_write" --> prom
    telegraf -- "/metrics (9273)\nnginx stub_status & nginxlog_*" --> prom
  end

  prom -- "dashboards & alerts" --> grafana
  loki -- "log explorer" --> grafana
  prom -- "remote_write" --> remote

  dockerSock[/var/run/docker.sock/] -. read-only mount .-> alloy
  hostFS[/host FS:\n/proc, /sys, /\ ] -. read-only mount .-> alloy
```

### Components

- `nginx`: reverse proxy image stored in `docker-compose.dev.yml` / `docker-compose.prod.yml`; writes to `nginx_logs`. Cron + logrotate chạy bên trong container (cấu hình tại `nginx/logrotate.conf`).
- `alloy`: Grafana Alloy collector defined in both Compose files with mounts for `/var/run/docker.sock`, `/proc`, `/sys`, `/`. Handles log tailing and exposes metrics on `12345`.
- `telegraf`: reads Nginx stub status and nginxlog_* metrics from shared logs, publishes metrics on `9273`.
- `prometheus`: scrapes Alloy (`/metrics`) and Telegraf, stores data in `prometheus_data`. Remote write is enabled for Alloy forwarding.
- `loki`: receives pushes from Alloy at `http://loki:3102/loki/api/v1/push`, stores chunks in `loki_data` (Compose) or swarm-managed volume.
- `grafana`: provisions Prometheus/Loki datasources and dashboards, served on `3456`.

### Prepare Nginx Assets

```bash
cp nginx/nginx_sites_available.example nginx/nginx_sites_available
cp nginx/logrotate.conf.example nginx/logrotate.conf
```

Customize `nginx/nginx.conf`, `nginx/nginx_sites_available`, và `nginx/logrotate.conf` tùy theo nhu cầu. Giá trị mặc định `size 100M` và `rotate 7` giữ dung lượng log ở mức an toàn; chỉnh `nginx/logrotate.conf` rồi `docker compose restart nginx` là cron bên trong container sẽ đọc cấu hình mới, không cần rebuild image.


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
