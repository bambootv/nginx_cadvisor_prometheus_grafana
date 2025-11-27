# Nginx Monitoring Stack with Grafana Alloy & Loki

Dự án này cung cấp một giải pháp giám sát toàn diện cho Nginx và hệ thống, sử dụng **Grafana Alloy** để thu thập metrics và logs, sau đó đẩy dữ liệu về **Grafana Cloud** (Loki cho logs, Prometheus cho metrics).

## 📋 Tính năng

- **Nginx**: Web server với cấu hình mẫu.
- **Grafana Alloy**: Agent thu thập dữ liệu thay thế cho `node_exporter` và `cadvisor`.
  - Thu thập System metrics (CPU, RAM, Disk, Network).
  - Thu thập Container metrics.
  - Thu thập Nginx logs và metrics.
- **Grafana Cloud**: Lưu trữ và hiển thị dữ liệu.
- **Terraform**: Quản lý Dashboards trên Grafana Cloud.

## 🛠 Yêu cầu

- Docker & Docker Compose
- Make
- Tài khoản Grafana Cloud (để lấy API Key và URL)

## 🚀 Cài đặt & Cấu hình

### 1. Khởi tạo môi trường

Copy các file cấu hình mẫu:

```bash
# Copy file môi trường
cp .env.example .env

# Copy cấu hình Nginx
cp nginx/nginx_sites_available.example nginx/nginx_sites_available
```

**Lưu ý:** Cập nhật file `.env` với thông tin xác thực của Grafana Cloud:

- `GRAFANA_CLOUD_LOKI_USER`
- `GRAFANA_CLOUD_API_KEY`
- `GRAFANA_CLOUD_LOKI_RULES_URL`
- ...

### 2. Triển khai (Deployment)

Sử dụng `Makefile` để quản lý các lệnh Docker Swarm.

**Khởi tạo Docker Swarm (chạy lần đầu):**

```bash
make swarm
```

**Deploy Stack (Nginx + Alloy):**

```bash
make stack
```

**Cập nhật Nginx Service (khi sửa config):**

```bash
make deploy
```

## 📊 Quản lý Rules & Dashboards

### 1. Nạp Loki Rules (Alerting/Recording Rules)

Lệnh sau sẽ upload file `loki_rules/loki-rules.yaml` lên Grafana Cloud Loki:

```bash
docker run --rm \
  --env-file .env \
  -v "$PWD/loki_rules":/data \
  -w /data \
  --entrypoint /bin/sh \
  curlimages/curl:latest \
  -c 'curl -v -X POST -H "Content-Type: application/yaml" -u "$GRAFANA_CLOUD_LOKI_USER:$GRAFANA_CLOUD_API_KEY" --data-binary @loki-rules.yaml "$GRAFANA_CLOUD_LOKI_RULES_URL"'
```

### 2. Upload Dashboards (Terraform)

Sử dụng Terraform để tự động tạo và cập nhật Dashboards trên Grafana Cloud.

**Khởi tạo Terraform:**

```bash
docker run --rm --env-file .env -v "$PWD":/workspace -w /workspace/terraform hashicorp/terraform:light init
```

**Apply Dashboards:**

```bash
docker run --rm --env-file .env -v "$PWD":/workspace -w /workspace/terraform hashicorp/terraform:light apply -auto-approve
```

**Format code Terraform:**

```bash
docker run --rm -v "$PWD":/workspace -w /workspace/terraform hashicorp/terraform:light fmt
```

**Xóa Dashboards (Destroy):**

```bash
docker run --rm --env-file .env -v "$PWD":/workspace -w /workspace/terraform hashicorp/terraform:light destroy -auto-approve
```

## 📂 Cấu trúc thư mục

- `alloy/`: Cấu hình cho Grafana Alloy.
- `loki_rules/`: Các rules cho Loki (Alerts, Recording rules).
- `nginx/`: Cấu hình Nginx.
- `terraform/`: Mã nguồn Terraform để quản lý Dashboards.
- `docker-compose.swarm.yml`: File định nghĩa stack cho Docker Swarm.
- `Makefile`: Các lệnh shortcut.

## 🔍 Debugging

- **Grafana Alloy UI**: Truy cập `http://localhost:12345` để xem trạng thái của Alloy agent.
- **Nginx**: Truy cập `http://localhost:80`.
