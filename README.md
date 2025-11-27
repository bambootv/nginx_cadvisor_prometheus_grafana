# Nginx Monitoring Stack with Grafana Alloy & Loki

Giải pháp giám sát toàn diện cho Nginx trên Docker Swarm với hai chế độ triển khai:

1. **Self-hosted:** Alloy ghi metrics/logs về Prometheus, Loki và Grafana tự vận hành.
2. **Grafana Cloud:** Alloy đẩy dữ liệu thẳng lên Prometheus + Loki Cloud, sử dụng Grafana Cloud UI.

## 📖 Mục lục

- [📋 Tính năng](#-tính-năng)
- [🛠 Yêu cầu](#-yêu-cầu)
- [⚙️ Chuẩn bị](#-chuẩn-bị)
  - [1. Sao chép cấu hình mẫu](#1-sao-chép-cấu-hình-mẫu)
  - [2. Hay đổi `.env` (nếu dùng Cloud)](#2-hay-đổi-env-nếu-dùng-cloud)
  - [3. Lấy thông tin Grafana Cloud](#3-lấy-thông-tin-grafana-cloud)
- [🚀 Triển khai](#-triển-khai)
  - [A. Self-hosted Stack (Prometheus + Loki + Grafana)](#a-self-hosted-stack-prometheus--loki--grafana)
  - [B. Grafana Cloud Stack (Alloy → Cloud)](#b-grafana-cloud-stack-alloy--cloud)
  - [C. Lệnh tiện ích](#c-lệnh-tiện-ích)
- [📂 Cấu trúc thư mục](#-cấu-trúc-thư-mục)
- [🔍 Debugging](#-debugging)

## 📋 Tính năng

- **Nginx**: service mẫu với `stub_status` và log cấu trúc.
- **Grafana Alloy**: thay thế cho `node_exporter` + `cAdvisor` + Fluentd.
  - Thu thập system metrics, container metrics và log Docker.
  - Parse và enrich Nginx access log (GeoIP, histogram latency, label level).
- **Prometheus/Loki/Grafana**: chạy nội bộ hoặc sử dụng Grafana Cloud.
- **Terraform**: quản lý dashboards dưới dạng code, có thể push lên Cloud.

## 🛠 Yêu cầu

- Docker & Docker Compose (hoặc Docker Desktop có Swarm mode).
- Make.
- **Chỉ khi chạy chế độ Cloud:** tài khoản Grafana Cloud + API Key (Metrics & Logs).

## ⚙️ Chuẩn bị

### 1. Sao chép cấu hình mẫu

```bash
cp .env.example .env                    # Bắt buộc cho chế độ Cloud
cp nginx/nginx_sites_available.example nginx/nginx_sites_available
```

### 2. Hay đổi `.env` (nếu dùng Cloud)

Bổ sung các biến Grafana Cloud (không bắt buộc cho self-hosted):

- `GRAFANA_CLOUD_PROM_URL`, `GRAFANA_CLOUD_PROM_USER`
- `GRAFANA_CLOUD_LOKI_URL`, `GRAFANA_CLOUD_LOKI_USER`
- `GRAFANA_CLOUD_API_KEY`, `GRAFANA_CLOUD_LOKI_RULES_URL`
- `TF_VAR_*` nếu muốn Terraform deploy dashboards lên Cloud.

### 3. Lấy thông tin Grafana Cloud

1. **Đăng nhập** [grafana.com](https://grafana.com) → Grafana Cloud → chọn stack.
2. **Prometheus**
   - Remote write endpoint → `GRAFANA_CLOUD_PROM_URL`
   - Username (ID dạng số) → `GRAFANA_CLOUD_PROM_USER`
3. **Loki**
   - Push URL → `GRAFANA_CLOUD_LOKI_URL`
   - Username (ID dạng số) → `GRAFANA_CLOUD_LOKI_USER`
4. **API Key**
   - Grafana Cloud Portal → API Keys → tạo token với quyền Admin → `GRAFANA_CLOUD_API_KEY`
5. **Loki Rules URL (optional)**
   - Trong Grafana Cloud, mở **Loki → Alerting → Alert rules → Configure** (hoặc “Manage rules” ở giao diện cũ).
   - Chọn namespace bạn muốn upload rules (ví dụ `grafanacloud-<tên>-logs`), nhấn dấu ⋮ → **Show API info**.
   - Copy endpoint `https://logs-prod-.../api/v1/rules/<namespace>` → `GRAFANA_CLOUD_LOKI_RULES_URL`.
6. **Terraform**
   - `TF_VAR_grafana_url`: URL của Grafana Cloud (`https://<workspace>.grafana.net`)
   - `TF_VAR_grafana_auth`: API token có quyền quản lý dashboards (Viewer/Editor)
   - `TF_VAR_loki_ds_name`, `TF_VAR_prom_ds_name`: trùng tên datasource Grafana Cloud tạo sẵn

## 🚀 Triển khai

Toàn bộ lệnh đã được gom trong `Makefile`.

### A. Self-hosted Stack (Prometheus + Loki + Grafana)

```bash
make swarm       # Khởi tạo Docker Swarm (chạy 1 lần duy nhất)
make stack_host  # Deploy nginx + alloy + prometheus + loki + grafana
make deploy      # Rolling update service nginx sau khi đổi config
```

### B. Grafana Cloud Stack (Alloy → Cloud)

```bash
make terraform_init   # (khuyến nghị) chuẩn bị provider & modules cho dashboards
make terraform_apply  # tạo datasource + dashboards trên Grafana Cloud
make apply_rules      # upload Loki recording rules lên Grafana Cloud
make stack_cloud      # Deploy nginx + alloy, bắt đầu đẩy dữ liệu lên Grafana Cloud
make deploy_cloud     # Update riêng service nginx trong stack cloud
```

> Cả hai stack cùng dùng `alloy/config.alloy`. Chế độ Cloud cần các biến `GRAFANA_CLOUD_*` trong `.env`. Stack self-host tự khai báo sẵn giá trị mặc định qua `docker-compose.yml`, nên không phải tạo `.env`.

### C. Lệnh tiện ích

- `make stack_nginx`: chỉ redeploy service nginx (COMMON_REPLICAS=0).
- `make apply_rules`: upload `loki_rules/loki-rules.yaml` lên Grafana Cloud Loki.
- `make terraform_init|apply|destroy|fmt`: chạy Terraform trong container `hashicorp/terraform:light`.

## 📂 Cấu trúc thư mục

- `alloy/`
  - `config.alloy`: pipeline duy nhất, tự động remote write về Prometheus/Loki nội bộ hoặc Grafana Cloud tùy biến môi trường.
- `loki_rules/`: recording rules để Alloy upload lên Cloud.
- `nginx/`: cấu hình Nginx, bao gồm `nginx.conf` + `nginx_sites_available`.
- `terraform/`: mã nguồn dashboards (sử dụng container Terraform).
- `docker-compose.yml`: stack self-host.
- `docker-compose.cloud.yml`: stack Grafana Cloud.
- `Makefile`: tập hợp các lệnh tiện ích.

## 🔍 Debugging

- Grafana Alloy UI: `http://localhost:12345`
- Nginx: `http://localhost:80`
- (Self-host) Grafana UI: `http://localhost:3456`
