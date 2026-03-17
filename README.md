# Nginx Monitoring Stack (Centralized)

Stack giám sát Nginx theo mô hình **Centralized (Multi-VPS qua Tailscale)**:

- **Central VPS**: chạy **Prometheus + Loki + Grafana** (tập trung dữ liệu + vẽ dashboard)
- **Common VPS** (mỗi VPS ứng dụng): chạy **Nginx + Grafana Alloy** (thu thập metrics/logs và đẩy về Central)
- Kết nối giữa các VPS qua **Tailscale** (không mở public Prometheus/Loki/Grafana)

## 📂 Cấu trúc dự án

- `docker-compose.central.yml`: Swarm stack cho **Central** (Prometheus + Loki + Grafana)
- `docker-compose.common.yml`: Swarm stack cho **Common** (Nginx + Alloy)
- `central/`: thành phần chạy trên Central VPS
  - `central/prometheus/`: cấu hình Prometheus
  - `central/loki/`: cấu hình Loki + rules
  - `central/grafana/`: provisioning datasources + dashboards
  - `central/dashboards/projects/_all/`: dashboards template (có filter theo `project`)
  - `central/dashboards/projects/<PROJECT>/`: dashboards theo từng project (Grafana auto-load theo folder)
- `common/`: thành phần dùng chung cho Common
  - `common/alloy/`: cấu hình Grafana Alloy (metrics + logs)
  - `common/nginx/`: cấu hình Nginx

## 🛠 Yêu cầu

- Docker + Docker Swarm mode
- `make`
- Tailscale (Central + mọi Common VPS, bật MagicDNS)

## ✅ Chuẩn bị

1. Cấu hình Nginx:
   - `cp common/nginx/nginx_sites_available.example common/nginx/nginx_sites_available`
   - Chỉnh `common/nginx/nginx_sites_available` theo nhu cầu
   - Nếu 1 Nginx phục vụ nhiều dự án: trong mỗi `server {}` hãy set `set $project "<TEN_STACK_SWARM_CUA_PROJECT>";` để logs/metrics không bị trộn.

2. Tạo file môi trường:
   - `cp .env.example .env`
  - Điền các biến cần thiết trong `.env` (Grafana admin, endpoint đẩy dữ liệu về Central, ...)

## 🚀 Deploy

### Central VPS (Prometheus + Loki + Grafana)

Khởi tạo Swarm (chạy 1 lần nếu VPS chưa init):
```bash
make swarm
```

Deploy Central stack:
```bash
make stack_central
```

### Common VPS (Nginx + Alloy)

Khởi tạo Swarm (chạy 1 lần nếu VPS chưa init):
```bash
make swarm
```

Deploy Common stack:
```bash
make stack_common
```

## 📊 Dashboards theo project (Grafana folder)

Tạo folder dashboards cho 1 project (khuyến nghị dùng đúng tên Swarm stack):
```bash
make dashboards_project PROJECT=<TEN_STACK>
```
Lưu ý: target này sẽ luôn overwrite dashboards trong folder project để đồng bộ theo templates mới nhất.

Nếu muốn khóa luôn `System Operating` vào một VPS cụ thể:
```bash
make dashboards_project PROJECT=<TEN_STACK> VPS=<TEN_VPS>
```

Regenerate lại tất cả project folders đã có sẵn từ templates:
```bash
make dashboards_sync_all
```

Nếu muốn Grafana nhận thay đổi ngay:
```bash
make deploy_central_grafana
```

## 🔎 Truy cập dịch vụ

- Common VPS
  - Nginx Website: `http://<COMMON_VPS_IP>:80`
  - Alloy UI: `http://<COMMON_VPS_IP>:12345`
- Central VPS (truy cập qua Tailscale MagicDNS / Tailscale IP)
  - Grafana: `http://<CENTRAL_TAILSCALE_HOST>:3000`
  - Prometheus: `http://<CENTRAL_TAILSCALE_HOST>:9090`
  - Loki: `http://<CENTRAL_TAILSCALE_HOST>:3102`

## ⚙️ Thao tác chung

- Central
  - Xem services: `docker stack services monitoring_central`
  - Xem logs: `docker service logs -f monitoring_central_grafana`
- Common
  - Xem services: `docker stack services monitoring_common`
  - Reload Nginx: `make deploy_common_nginx`
  - Reload Alloy: `make deploy_common_alloy`

## 🧭 Tài liệu

- `docs/vision-simple.md`
- `docs/vision-workshop.md`
- `docs/centralized-vps.md`
