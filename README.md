# Nginx Monitoring Stack with Grafana Alloy & Loki

Giải pháp giám sát toàn diện cho Nginx trên Docker Swarm với hai chế độ triển khai riêng biệt.

## 📖 Mục lục

- [Nginx Monitoring Stack with Grafana Alloy \& Loki](#nginx-monitoring-stack-with-grafana-alloy--loki)
  - [📖 Mục lục](#-mục-lục)
  - [📂 Cấu trúc dự án](#-cấu-trúc-dự-án)
  - [🛠 Yêu cầu \& Chuẩn bị](#-yêu-cầu--chuẩn-bị)
    - [Yêu cầu hệ thống](#yêu-cầu-hệ-thống)
    - [Chuẩn bị môi trường](#chuẩn-bị-môi-trường)
  - [🚀 Chế độ 1: Self-hosted (Local)](#-chế-độ-1-self-hosted-local)
    - [Các bước triển khai](#các-bước-triển-khai)
    - [Truy cập dịch vụ](#truy-cập-dịch-vụ)
  - [☁️ Chế độ 2: Grafana Cloud](#️-chế-độ-2-grafana-cloud)
    - [Cấu hình kết nối Cloud](#cấu-hình-kết-nối-cloud)
    - [Các bước triển khai](#các-bước-triển-khai-1)
    - [Truy cập dịch vụ](#truy-cập-dịch-vụ-1)
  - [⚙️ Các thao tác chung](#️-các-thao-tác-chung)
    - [Kiểm tra trạng thái](#kiểm-tra-trạng-thái)
    - [Xem logs](#xem-logs)
    - [Gỡ bỏ (Undeploy)](#gỡ-bỏ-undeploy)
  - [🔧 Lệnh tiện ích (Makefile)](#-lệnh-tiện-ích-makefile)

## 📂 Cấu trúc dự án

Dự án được chia thành 3 phần chính:

1.  **`common/`**: Các thành phần dùng chung cho cả 2 chế độ.
    *   `alloy/`: Cấu hình Grafana Alloy (thu thập metrics/logs).
    *   `nginx/`: Cấu hình Nginx Web Server.
2.  **`selfhost/`**: Các thành phần chỉ dùng cho chế độ tự vận hành (Self-hosted).
    *   `grafana/`: Dashboard & Datasource provisioning.
    *   `loki/`: Cấu hình Loki local.
    *   `prometheus/`: Cấu hình Prometheus local.
3.  **`cloud/`**: Các thành phần chỉ dùng cho chế độ Grafana Cloud.
    *   `loki_rules/`: Rules alert/recording đẩy lên Cloud.
    *   `terraform/`: Quản lý Dashboards trên Cloud bằng code.

## 🛠 Yêu cầu & Chuẩn bị

### Yêu cầu hệ thống
- **Docker & Docker Compose**: Đã cài đặt và kích hoạt Swarm mode (`docker swarm init`).
- **Make**: Để chạy các lệnh tiện ích.
- **Tài nguyên**: Tối thiểu 2GB RAM nếu chạy Self-hosted stack.

### Chuẩn bị môi trường
1.  **Clone repository**:
    ```bash
    git clone <repo-url>
    cd nginx_cadvisor_prometheus_grafana
    ```
2.  **Cấu hình Nginx**:
    *   Copy file mẫu: `cp common/nginx/nginx_sites_available.example common/nginx/nginx_sites_available`
    *   Chỉnh sửa file `common/nginx/nginx_sites_available` theo nhu cầu của bạn.

---

## 🚀 Chế độ 1: Self-hosted (Local)

Chạy toàn bộ stack monitoring (Prometheus, Loki, Grafana) ngay trên server của bạn. Dữ liệu được lưu trữ cục bộ.

### Các bước triển khai

1.  **Khởi tạo Swarm (nếu chưa có):**
    ```bash
    make swarm
    ```

2.  **Deploy toàn bộ Stack (Nginx + Monitoring):**
    ```bash
    make stack_full_host
    ```
    *Lệnh này sẽ khởi chạy Nginx, Alloy, Prometheus, Loki và Grafana.*

3.  **Deploy chỉ Nginx (Không Monitoring):**
    ```bash
    make stack_nginx_host
    ```
    *Dùng khi bạn chỉ muốn chạy web server Nginx mà không cần hệ thống giám sát (tiết kiệm tài nguyên).*

4.  **Cập nhật cấu hình Nginx:**
    Sau khi sửa file `nginx.conf` hoặc `nginx_sites_available`, chạy lệnh sau để reload Nginx mà không downtime:
    ```bash
    make deploy_nginx_host
    ```

### Truy cập dịch vụ
*   **Grafana**: `http://localhost:3456` (User/Pass mặc định: `admin`/`admin`)
*   **Nginx Website**: `http://localhost:80`
*   **Alloy UI**: `http://localhost:12345`
*   **Prometheus**: `http://localhost:9090`

---

## ☁️ Chế độ 2: Grafana Cloud

Chỉ chạy Nginx và Alloy. Alloy sẽ đẩy metrics và logs lên Grafana Cloud. Không cần vận hành Prometheus/Loki/Grafana ở local.

### Cấu hình kết nối Cloud

1.  **Tạo file `.env`**:
    ```bash
    cp .env.example .env
    ```
2.  **Điền thông tin Grafana Cloud**:
    Mở file `.env` và điền các thông tin lấy từ Grafana Cloud Portal:
    ```ini
    GRAFANA_CLOUD_PROM_URL=https://prometheus-prod-xx-prod-us-central-0.grafana.net/api/v1/write
    GRAFANA_CLOUD_PROM_USER=123456
    GRAFANA_CLOUD_LOKI_URL=https://logs-prod-xx-prod-us-central-0.grafana.net/loki/api/v1/push
    GRAFANA_CLOUD_LOKI_USER=123456
    GRAFANA_CLOUD_API_KEY=glc_eyJvIjoi...
    TF_VAR_grafana_url=https://xxx.grafana.net
    TF_VAR_grafana_auth=glsa_xxxxxxx
    TF_VAR_loki_ds_name=grafanacloud-xxxx-logs
    TF_VAR_prom_ds_name=grafanacloud-xxxx-prom
    TF_VAR_folder_title=Dashboards
    ```

### Các bước triển khai

1.  **Deploy Stack (Nginx + Alloy):**
    ```bash
    make stack_full_cloud
    ```

2.  **Deploy chỉ Nginx (Không Alloy):**
    ```bash
    make stack_nginx_cloud
    ```

3.  **Cập nhật cấu hình Nginx:**
    ```bash
    make deploy_nginx_cloud
    ```

4.  **Quản lý Rules & Dashboards (Nâng cao):**
    *   **Upload Loki Rules**: `make apply_rules`
    *   **Tạo Dashboards (Terraform)**:
        ```bash
        make terraform_init
        make terraform_apply
        ```

### Truy cập dịch vụ
*   **Dashboard**: Xem tại [Grafana Cloud Console](https://grafana.com)
*   **Nginx Website**: `http://localhost:80`
*   **Alloy UI**: `http://localhost:12345` (Kiểm tra trạng thái gửi log/metric)

---

## ⚙️ Các thao tác chung

### Kiểm tra trạng thái
```bash
docker stack services monitoring_host       # Cho Self-hosted
docker stack services monitoring_cloud # Cho Cloud
```

### Xem logs
```bash
docker service logs -f monitoring_nginx
docker service logs -f monitoring_alloy
```

### Gỡ bỏ (Undeploy)
```bash
docker stack rm monitoring_host
docker stack rm monitoring_cloud
```

---

## 🔧 Lệnh tiện ích (Makefile)

| Lệnh | Chế độ | Mô tả |
| :--- | :--- | :--- |
| `make swarm` | Chung | Khởi tạo Docker Swarm mode. |
| **Self-hosted** | | |
| `make stack_full_host` | Self-host | Deploy toàn bộ stack (Nginx + Monitoring Local). |
| `make stack_nginx_host` | Self-host | **Chỉ deploy Nginx**, tắt monitoring. |
| `make deploy_nginx_host` | Self-host | Reload service Nginx (Zero downtime). |
| **Grafana Cloud** | | |
| `make stack_full_cloud` | Cloud | Deploy stack (Nginx + Alloy đẩy lên Cloud). |
| `make stack_nginx_cloud` | Cloud | **Chỉ deploy Nginx**, tắt Alloy. |
| `make deploy_nginx_cloud` | Cloud | Reload service Nginx (Zero downtime). |
| `make apply_rules` | Cloud | Upload Loki rules lên Grafana Cloud. |
| `make terraform_apply` | Cloud | Tạo/Cập nhật Dashboards trên Cloud. |

