# Trên Common VPS

Common VPS chạy stack `monitoring_common`: **Nginx (ingress public) + Alloy (đẩy metrics/logs về Central)**. Trên Common VPS bạn cũng deploy các app project (qr_code, blog, ...) — mỗi app là 1 Docker Swarm stack riêng, public qua Common Nginx.

Tài liệu này hướng dẫn mọi việc cần làm **trên máy Common VPS**, theo 3 phần:

- [Phần 1: Setup lần đầu Common VPS](#phần-1-setup-lần-đầu-common-vps)
- [Phần 2: Thêm 1 project app mới](#phần-2-thêm-1-project-app-mới)
- [Phần 3: Migrate project cũ sang `nginx_gateway_net`](#phần-3-migrate-project-cũ-sang-nginx_gateway_net)

Pre-req: Central VPS đã setup xong (xem [`central-vps.md`](central-vps.md)) và bạn đã biết `CENTRAL_TAILSCALE_IP`.

Vận hành định kỳ (update Nginx config, update Alloy config sau khi đã setup): xem [`README.md`](../README.md).

## Phần 1: Setup lần đầu Common VPS

Làm 1 lần khi dựng Common VPS mới.

### 1.1. Cài Tailscale

Cài trên **host** (không cài trong container):

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --advertise-tags=tag:common
tailscale status
```

Verify gọi được Central qua Tailscale (Central đã deploy xong):

```bash
curl -sS http://<CENTRAL_TAILSCALE_IP>:9090/-/ready
curl -sS http://<CENTRAL_TAILSCALE_IP>:3102/ready
```

Cả 2 phải trả về readiness. Nếu fail → kiểm tra Tailscale policy ([`tailscale-policy.md`](tailscale-policy.md)) hoặc firewall provider chặn port `9090`/`3102`.

### 1.2. Chuẩn bị `.env`, Swarm, network

```bash
cp .env.example .env
make swarm
make gateway_network
```

Sửa `.env`:

```env
VPS_NAME=<ten-common-vps>
CENTRAL_PROM_URL=http://<CENTRAL_TAILSCALE_IP>:9090/api/v1/write
CENTRAL_LOKI_URL=http://<CENTRAL_TAILSCALE_IP>:3102/loki/api/v1/push
```

### 1.3. Tạo file vhost Nginx (rỗng trước, sẽ thêm app sau)

```bash
cp common/nginx/nginx_sites_available.example common/nginx/nginx_sites_available
```

Để file template như có sẵn — `server {}` cụ thể của từng app sẽ thêm ở Phần 2.

### 1.4. Deploy stack monitoring

```bash
make deploy_common
```

### 1.5. Verify

```bash
docker stack services monitoring_common
```

Mở Grafana (qua Cloudflare Tunnel của Central), Explore datasource Prometheus:

```promql
up{vps="<ten-common-vps>"}
```

Thấy data → Common Alloy đã đẩy về Central thành công.

## Phần 2: Thêm 1 Project App Mới

Mỗi lần thêm app mới (qr_code, blog, ...) làm theo các bước này. Phần lớn chạy trên Common VPS; **Bước 3 chạy trên Central VPS**.

### Bước 0: Chọn tên định danh cho project

Trước khi làm gì, chọn **1 cái tên** cho project. Tên này dùng nguyên xi ở 3 chỗ trong các bước sau, và **phải trùng khớp** ở cả 3.

Ví dụ trong tài liệu này:

```text
Tên project (định danh):  qr_code
Domain public:            qr.example.com
Common VPS chạy app:      vps-app-01
Service backend của app:  production_backend  (port 3000)
```

3 chỗ sẽ dùng tên `qr_code`:

```bash
# 1. Stack name khi deploy (Bước 1, trên Common VPS)
docker stack deploy -c docker-compose.yml qr_code

# 2. set $project trong vhost Nginx (Bước 2, trên Common VPS)
set $project "qr_code";

# 3. Tham số PROJECT khi gen dashboard (Bước 3, trên Central VPS)
make dashboards_project PROJECT=qr_code
```

Vì sao phải trùng: Alloy gán label `project` cho container metrics từ stack name, và cho Nginx access log từ `set $project`. Script dashboard khoá filter theo `PROJECT`. Nếu 3 chỗ này lệch nhau (kể cả lệch 1 ký tự — `qr_code` ≠ `qr-code` ≠ `QrCode`), Grafana sẽ thấy thành 2 "project khác nhau" hoặc dashboard lọc trống.

### Bước 1: Deploy app stack (trên Common VPS)

Trong compose của app, tách network theo vai trò:

| Network | Service nào join | Mục đích |
|---|---|---|
| `nginx_gateway_net` | Chỉ service public cần nhận traffic từ Nginx | Cho Common Nginx gọi app |
| Project private network | Backend, DB, Redis, worker nội bộ | Giao tiếp nội bộ app |

Ví dụ compose app:

```yaml
services:
  production_backend:
    image: your-registry/qr-code-backend:latest
    networks:
      - app_private
      - nginx_gateway_net
    deploy:
      replicas: 1

  redis:
    image: redis:7
    networks:
      - app_private

networks:
  app_private:
    driver: overlay
  nginx_gateway_net:
    external: true
    name: nginx_gateway_net
```

Quy tắc:

- Service public của app join `nginx_gateway_net`.
- DB/Redis/worker **không** join `nginx_gateway_net`.
- Service public **không** publish `ports:` ra host.

Deploy:

```bash
docker stack deploy -c docker-compose.yml qr_code
```

Tên service Swarm sẽ là `<stack>_<service>`, ví dụ `qr_code_production_backend`.

### Bước 2: Thêm `server {}` vào Common Nginx (trên Common VPS)

Sửa [`common/nginx/nginx_sites_available`](../common/nginx/nginx_sites_available), thêm vhost cho domain app:

```nginx
server {
    listen 80;
    server_name qr.example.com;

    set $project "qr_code";

    location / {
        proxy_pass http://qr_code_production_backend:3000;
        proxy_http_version 1.1;
        proxy_set_header Connection "";
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Điểm quan trọng:

- `server_name` là domain public của app.
- `set $project` trùng stack name. Thiếu hoặc lệch → label `project` rơi vào `unknown` trên dashboard API.
- `proxy_pass` dùng DNS Swarm `<stack>_<service>:<port>`. Không dùng `172.17.0.1:<port>` hoặc `127.0.0.1:<port>`.

Reload Nginx:

```bash
make deploy_common_nginx
```

Lệnh này chỉ force rolling update Nginx. Nếu đổi compose-level (network, mount, port), dùng `make deploy_common`.

### Bước 3: Tạo dashboard cho project (trên Central VPS)

SSH sang **Central VPS**, chạy:

```bash
make dashboards_project PROJECT=qr_code VPS=vps-app-01
make deploy_central_grafana
```

Quy ước:

- `PROJECT` phải là stack name đã dùng ở Bước 1.
- `VPS` là tuỳ chọn — default filter `vps` trên dashboard sẽ là VPS đó (vẫn đổi được trên Grafana).

Sau lệnh này, Grafana có folder `qr_code` với 3 dashboard:

- `[qr_code] API` — Nginx API observability
- `[qr_code] Logs` — container logs
- `[qr_code] Operating System` — system + container metrics

Biến `project` trong dashboard bị khoá thành constant `qr_code`, nên dashboard chỉ thấy dữ liệu project đó.

### Bước 4: Verify

Cần có **traffic thật** qua Nginx mới sinh access log. Nếu chưa có request nào, các panel API như request rate, latency, top API sẽ trống.

Trên Grafana Explore với datasource Prometheus:

```promql
container_cpu_usage_seconds_total{project="qr_code"}
loki_nginx_requests_rate{project="qr_code"}
loki_process_custom_nginxlog_request_duration_seconds_count{project="qr_code"}
```

Với datasource Loki:

```logql
{project="qr_code"}
{job="nginx", project="qr_code"}
```

Diễn giải:

| Query | Nếu có data nghĩa là |
|---|---|
| `container_cpu_usage_seconds_total{project="qr_code"}` | Alloy đã thấy container của stack app |
| `{project="qr_code"}` trong Loki | Alloy đã đẩy container logs của project |
| `{job="nginx", project="qr_code"}` trong Loki | Nginx đã có access log đúng project |
| `loki_nginx_requests_rate{project="qr_code"}` | Loki ruler đã tạo metric từ Nginx logs |
| `loki_process_custom_nginxlog_request_duration_seconds_count{project="qr_code"}` | Alloy histogram đã tạo metric latency |

Nếu chỉ thấy container metrics mà không thấy Nginx metrics, thường là:

- App chưa có traffic qua Nginx
- Nginx `server {}` chưa set đúng `$project`
- `proxy_pass` không đi qua Common Nginx (vd app vẫn được gọi qua port host)
- Access log Nginx bị tắt
- Loki ruler chưa chạy hoặc chưa remote_write metric về Prometheus

## Phần 3: Migrate Project Cũ Sang `nginx_gateway_net`

Áp dụng khi project đang chạy kiểu cũ:

- App có `ports:` public trên host
- Common Nginx đang route qua `172.17.0.1:<port>`

Nên migrate theo **3 bước** để giảm rủi ro mất traffic.

### Bước 1: Deploy app với network mới, GIỮ port cũ

Trong compose app:

- Thêm `nginx_gateway_net` vào service public
- **Tạm giữ nguyên** `ports:` cũ

Deploy lại app stack:

```bash
docker stack deploy -c docker-compose.yml qr_code
```

Lưu ý: bước này **bắt buộc phải `docker stack deploy`** lại app. `make deploy_common_nginx` không thêm network mới cho app được.

### Bước 2: Đổi Common Nginx sang tên service Swarm

Trong `common/nginx/nginx_sites_available`, đổi từ:

```nginx
proxy_pass http://172.17.0.1:3006;
```

sang:

```nginx
proxy_pass http://qr_code_production_backend:3000;
```

Đồng thời thêm `set $project "qr_code";` nếu chưa có.

Reload Nginx:

```bash
make deploy_common_nginx
```

### Bước 3: Quan sát rồi mới bỏ port cũ

Khi traffic đã chạy ổn qua `nginx_gateway_net`:

- Bỏ `ports:` public khỏi compose app
- Deploy lại app stack lần nữa:

```bash
docker stack deploy -c docker-compose.yml qr_code
```

Sau bước này, app không còn lộ port ra host. Mọi public traffic phải đi qua Common Nginx.

Tách 3 bước an toàn hơn đổi một lần vì:

- Bước 1 không phá traffic hiện tại (port cũ vẫn còn)
- Bước 2 đổi route Nginx; nếu lỗi, rollback chỉ là sửa file Nginx và reload
- Bước 3 chỉ thực hiện khi đã chắc route mới chạy ổn

## Logs khi cần

```bash
docker service logs -f monitoring_common_nginx
docker service logs -f monitoring_common_alloy
```
