# Nginx Monitoring Stack (Hybrid)

Stack giám sát Nginx trên Docker Swarm theo mô hình **Hybrid (Multi-VPS)**:

- Mỗi VPS chạy: **Nginx + Grafana Alloy + Prometheus + Loki + PDC Agent**
- Dữ liệu (Prom/Loki) lưu local trên từng VPS
- Dashboard tập trung trên **Grafana Cloud** thông qua **Private Data Source Connect (PDC)**

## 📂 Cấu trúc dự án

- `docker-compose.hybrid.yml`: Compose cho chế độ Hybrid (Swarm stack)
- `common/`: thành phần dùng chung
  - `common/alloy/`: cấu hình Grafana Alloy (metrics + logs)
  - `common/nginx/`: cấu hình Nginx
  - `common/dashboards/`: dashboard JSON (được Terraform upload lên Cloud)
- `hybrid/`: thành phần chỉ dùng cho Hybrid
  - `hybrid/prometheus/`: cấu hình Prometheus local
  - `hybrid/loki/`: cấu hình Loki + rules
  - `hybrid/terraform/`: tạo Folder/Datasource/Dashboard trên Grafana Cloud

## 🛠 Yêu cầu

- Docker + Docker Swarm mode
- `make`
- Có tài khoản Grafana Cloud (để dùng PDC + API token)

## ✅ Chuẩn bị

1. Cấu hình Nginx:
   - `cp common/nginx/nginx_sites_available.example common/nginx/nginx_sites_available`
   - Chỉnh `common/nginx/nginx_sites_available` theo nhu cầu

2. Tạo file môi trường:
   - `cp .env.example .env`
   - Điền các biến Hybrid (PDC + Terraform) trong `.env`

## 🌐 Hybrid (Multi-VPS)

### 1) Tạo PDC Cluster trên Grafana Cloud

- Grafana Cloud → Connections → Private Data Source Connect
- Tạo cluster mới và lấy: `Token`, `Cluster ID`, `Hosted Grafana ID`

### 2) Tạo Service Account Token (cho Terraform)

- Grafana Cloud → Administration → Service Accounts
- Tạo token (Admin/Editor) và set vào `TF_VAR_grafana_auth`

### 3) Khởi chạy Terraform (tạo Datasource/Dashboard trên Cloud)

```bash
make hybrid_terraform_init
make hybrid_terraform_apply
```

Terraform sẽ tạo (theo `TF_VAR_vps_name`):
- Folder: `VPS Monitoring (<vps_name>)`
- Datasource: `Prometheus-<vps_name>`, `Loki-<vps_name>`
- Dashboards: System Monitoring, Nginx API Observability, Container Logs

### 4) Bật PDC cho Datasource (thủ công 1 lần)

- Grafana Cloud → Connections → Data Sources
- Chọn datasource `Prometheus-<vps_name>` → phần “Connect via private data source connect” → chọn cluster → Save & Test
- Lặp lại với `Loki-<vps_name>`

### 5) Deploy stack lên VPS

Khởi tạo Swarm (chạy 1 lần nếu VPS chưa init):
```bash
make swarm
```

Deploy full stack (Nginx + Monitoring):
```bash
make stack_full_hybrid
```

Deploy chỉ Nginx:
```bash
make stack_nginx_hybrid
```

Reload Nginx sau khi đổi config:
```bash
make deploy_nginx_hybrid
```

## 🔎 Truy cập dịch vụ

- Nginx Website: `http://<VPS_IP>:80`
- Alloy UI: `http://<VPS_IP>:12345`
- Prometheus (local VPS): `http://<VPS_IP>:9090`
- Loki (local VPS): `http://<VPS_IP>:3102`
- Grafana Cloud: `https://<your-stack>.grafana.net` → folder `VPS Monitoring (<vps_name>)`

## ⚙️ Thao tác chung

- Xem service trong stack:
  - `docker stack services monitoring_hybrid`
- Xem logs:
  - `docker service logs -f monitoring_hybrid_nginx`
  - `docker service logs -f monitoring_hybrid_alloy`
- Gỡ stack:
  - `docker stack rm monitoring_hybrid`

## 🧭 Tài liệu

- `docs/vision-simple.md`
- `docs/vision-workshop.md`
- `docs/monitoring-options-comparison.md`
