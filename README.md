# Nginx + Alloy + Prometheus + Loki Stack

Stack monitoring hiện đại với Nginx, Grafana Alloy, Prometheus, Loki và Grafana. Tất cả logs và metrics được thu thập tự động, không cần sidecar hay cấu hình phức tạp.

## 🚀 Hướng Dẫn Chạy

### Bước 1: Chuẩn bị Nginx Config

```bash
# Copy file config mẫu (nếu chưa có)
cp nginx/nginx_sites_available.example nginx/nginx_sites_available

# Chỉnh sửa nginx config theo nhu cầu
vim nginx/nginx.conf
vim nginx/nginx_sites_available
```

### Bước 2: Khởi tạo Docker Swarm (lần đầu)

```bash
make swarm
```

Lệnh này sẽ chạy: `docker swarm init --advertise-addr 127.0.0.1`

### Bước 3: Deploy Stack

```bash
# Deploy toàn bộ stack
make stack

# Hoặc chỉ deploy nginx (nếu các service khác đã chạy)
make stack_nginx_only
```

Lệnh `make stack` sẽ:

- Deploy tất cả services: nginx, alloy, prometheus, loki, grafana
- Sử dụng `docker-compose.prod.yml`
- Tạo network `monitoring_swarm` (subnet: 10.0.3.0/24)

### Bước 4: Kiểm tra Services

```bash
# Xem trạng thái services
docker service ls

# Xem logs của service
docker service logs monitoring_nginx
docker service logs monitoring_alloy
docker service logs monitoring_loki

# Xem chi tiết service
docker service ps monitoring_nginx
```

### Bước 5: Truy cập Grafana

- **URL**: http://localhost:3456
- **Datasources**: Tự động provisioned (Prometheus, Loki)
- **Dashboards**: Tự động load từ `grafana/dashboards/`

## 📊 Luồng Dự Án

### 1. Luồng Metrics

```
┌─────────────────────────────────────────────────────────┐
│ HOST METRICS                                             │
├─────────────────────────────────────────────────────────┤
│ Alloy đọc từ: /proc, /sys, / (mounted read-only)       │
│ → CPU, Memory, Disk, Network                            │
│ → Scrape interval: 15s                                  │
│ → Job: "alloy_system"                                   │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ CONTAINER METRICS                                        │
├─────────────────────────────────────────────────────────┤
│ Alloy đọc từ: /var/run/docker.sock                      │
│ → CPU, Memory, Network per container                    │
│ → Scrape interval: 10s                                  │
│ → Job: "integrations/cadvisor"                          │
└─────────────────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────────────────┐
│ NGINX METRICS                                            │
├─────────────────────────────────────────────────────────┤
│ Alloy scrape: nginx-exporter:9113                       │
│ → Nginx stub status metrics                              │
│ → Job: "nginx"                                          │
└─────────────────────────────────────────────────────────┘
                    ↓
        Alloy → Prometheus (remote_write)
                    ↓
        Prometheus lưu vào prometheus_data volume
                    ↓
        Grafana query Prometheus để hiển thị
```

### 2. Luồng Logs

```
┌─────────────────────────────────────────────────────────┐
│ NGINX LOGS (Quan trọng nhất)                            │
├─────────────────────────────────────────────────────────┤
│ 1. Nginx ghi vào /dev/stdout, /dev/stderr               │
│ 2. Docker logging driver nhận                           │
│    → Lưu vào /var/lib/docker/containers/<id>/*.log     │
│    → Rotate: max-size=100m, max-file=10 (~1GB)         │
│ 3. Alloy đọc qua docker.sock                            │
│ 4. Alloy parse: extract verb, request_path, resp_code  │
│ 5. Alloy push vào Loki                                   │
│ 6. Loki lưu vào loki_data volume                          │
│ 7. Loki Compactor cleanup sau 7 ngày                    │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│ CONTAINER LOGS KHÁC                                     │
├─────────────────────────────────────────────────────────┤
│ 1. Container ghi vào stdout/stderr                      │
│ 2. Alloy đọc qua docker.sock                            │
│ 3. Alloy detect log level (error/warn/info/debug)       │
│ 4. Alloy push vào Loki                                   │
│ 5. Loki lưu và cleanup sau 7 ngày                       │
└─────────────────────────────────────────────────────────┘
```

### 3. Luồng Tổng Quan

```
┌──────────────┐
│   Nginx      │ → stdout/stderr → Docker logging driver
│  (Port 80)   │                    (rotate ~1GB)
└──────────────┘
       ↓
┌──────────────┐
│   Alloy      │ → Đọc docker.sock → Parse logs
│ (Port 12345) │ → Đọc /proc, /sys → Collect metrics
└──────────────┘
       ↓                    ↓
┌──────────────┐    ┌──────────────┐
│    Loki      │    │  Prometheus │
│ (Port 3102)  │    │ (Port 9090) │
│              │    │              │
│ Retention:   │    │ Retention:   │
│ 7 ngày       │    │ 7d hoặc 2GB  │
└──────────────┘    └──────────────┘
       ↓                    ↓
┌──────────────────────────────────┐
│         Grafana                   │
│       (Port 3456)                 │
│                                   │
│ - Query Prometheus (metrics)      │
│ - Query Loki (logs)               │
│ - Dashboards tự động load         │
└──────────────────────────────────┘
```

## 🔧 Cấu Hình

### Nginx

- **Config**: `nginx/nginx.conf`, `nginx/nginx_sites_available`
- **Logs**: Ghi vào `/dev/stdout`, `/dev/stderr` (Docker quản lý)
- **Log format**: Custom format với `$request_time`

### Alloy

- **Config**: `alloy/config.alloy`
- **Chức năng**:
  - Thu thập host metrics (CPU, Memory, Disk, Network)
  - Thu thập container metrics (cAdvisor)
  - Thu thập tất cả container logs
  - Parse NGINX logs (extract verb, request_path, resp_code)
  - Detect log level (error/warn/info/debug)

### Prometheus

- **Config**: `prometheus/prometheus.yml`
- **Retention**: 7 ngày hoặc 2GB (lấy giá trị nhỏ hơn)
- **Nhận metrics**: Từ Alloy qua remote_write

### Loki

- **Config**: `loki/local-config.yaml`
- **Retention**: 7 ngày (tự động cleanup)
- **Ingestion limit**: 10MB/s, burst 20MB
- **Compactor**: Tự động cleanup mỗi 10 phút

### Grafana

- **Datasources**: Tự động provisioned từ `grafana/provisioning/datasources/`
- **Dashboards**: Tự động load từ `grafana/dashboards/`
- **Port**: 3456 (mapped từ 3000)

## 📁 Cấu Trúc Thư Mục

```
.
├── alloy/
│   └── config.alloy              # Alloy configuration
├── grafana/
│   ├── dashboards/               # Dashboard JSON files
│   │   ├── requests_overview.json
│   │   ├── container_logs.json
│   │   └── system_overview.json
│   └── provisioning/            # Auto-provisioned configs
│       ├── datasources/
│       └── dashboards/
├── loki/
│   ├── local-config.yaml         # Loki configuration
│   └── rules_source/             # Loki rules
├── nginx/
│   ├── nginx.conf                # Nginx main config
│   ├── nginx_sites_available     # Nginx sites config
│   └── nginx_sites_available.example
├── prometheus/
│   └── prometheus.yml            # Prometheus config
├── docker-compose.prod.yml       # Docker Swarm config
├── Makefile                      # Helper commands
└── README.md
```

## 🗄️ Log Retention & Size Limits

### Nginx Logs (Quan trọng nhất)

- **Docker logging driver**: `max-size: 100m`, `max-file: 10`
- **Tổng tối đa**: ~1GB (tự động rotate)
- **Vị trí**: `/var/lib/docker/containers/<id>/*.log` (Docker quản lý)

### Prometheus

- **Retention**: 7 ngày hoặc 2GB (lấy giá trị nhỏ hơn)
- **Storage**: `prometheus_data` volume

### Loki

- **Retention**: 7 ngày (tự động cleanup bởi Compactor)
- **Ingestion limit**: 10MB/s, burst 20MB
- **Storage**: `loki_data` volume
- **Compactor**: Chạy mỗi 10 phút, tự động xóa dữ liệu > 7 ngày

### Container Logs Khác

- **Không giới hạn** Docker logging driver (logs ít)
- **Được quản lý** bởi Loki retention (7 ngày)

**Tổng dung lượng ước tính**: ~3-4GB (chủ yếu là Nginx logs)

## 🧹 Cleanup

```bash
# Xóa stack
docker stack rm monitoring

# Xóa stack + volumes (xóa tất cả data)
docker stack rm monitoring
docker volume prune -f
```

## 🌐 Ports & Access

| Service    | Port  | URL                    | Mô tả                     |
| ---------- | ----- | ---------------------- | ------------------------- |
| Nginx      | 80    | http://localhost       | Reverse proxy             |
| Grafana    | 3456  | http://localhost:3456  | Dashboards & Log Explorer |
| Prometheus | 9090  | http://localhost:9090  | Prometheus UI             |
| Loki       | 3102  | http://localhost:3102  | Loki API                  |
| Alloy      | 12345 | http://localhost:12345 | Alloy metrics endpoint    |

## 📝 Environment Variables

Khi deploy với `make stack`:

- `COMMON_REPLICAS`: Số replicas cho Alloy/Prometheus/Loki/Grafana (default: 1)
- `NGINX_REPLICAS`: Số replicas cho Nginx (default: 1)

Ví dụ:

```bash
COMMON_REPLICAS=2 NGINX_REPLICAS=2 make stack
```

## 📚 Tài Liệu Tham Khảo

- [Grafana Alloy Docs](https://grafana.com/docs/alloy/latest/)
- [Prometheus Docs](https://prometheus.io/docs/)
- [Loki Docs](https://grafana.com/docs/loki/latest/)
- [Grafana Docs](https://grafana.com/docs/grafana/latest/)
