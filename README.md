# Nginx Monitoring Stack (Centralized)

Repo này dùng cho mô hình nhiều VPS với Docker Swarm:

- **Common VPS**: chạy `Nginx + Grafana Alloy`
- **Central VPS**: chạy `Grafana + Prometheus + Loki + Alloy + cloudflared`
- **Ingress network dùng chung**: `nginx_gateway_net`
- **Common VPS** đẩy metrics/logs về **Central VPS** qua IP Tailscale

## Docs

- Nginx nhap mon tu so 0: [`docs/nginx-from-zero.md`](docs/nginx-from-zero.md)
- Audit chi tiet Common Nginx: [`docs/nginx-common-analysis.md`](docs/nginx-common-analysis.md)
- Tong quan kien truc VPS: [`docs/centralized-vps.md`](docs/centralized-vps.md)
- Cloudflare Tunnel production cho Grafana: [`docs/cloudflare-tunnel-grafana-production.md`](docs/cloudflare-tunnel-grafana-production.md)

## Trước Khi Dùng

Chuẩn bị chung cho cả Common VPS và Central VPS:

```bash
cp .env.example .env
make swarm
make gateway_network
```

Sửa `.env`:

- `CENTRAL_PROM_URL`
- `CENTRAL_LOKI_URL`
- `VPS_NAME`
- `GF_SECURITY_ADMIN_USER`
- `GF_SECURITY_ADMIN_PASSWORD`
- `GF_SERVER_DOMAIN`
- `GF_SERVER_ROOT_URL`
- `GF_SERVER_ENFORCE_DOMAIN`

## Case 1: Setup Central VPS

1. Deploy stack Central:

Trước khi deploy, tạo Docker secret cho Cloudflare Tunnel token:

```bash
printf '%s' 'PASTE_TUNNEL_TOKEN_HERE' | docker secret create cf_tunnel_token -
```

Sau đó deploy:

```bash
make deploy_central
```

2. Kiểm tra service:

```bash
docker stack services monitoring_central
```

3. Kiểm tra logs khi cần:

```bash
docker service logs -f monitoring_central_grafana
docker service logs -f monitoring_central_prometheus
docker service logs -f monitoring_central_loki
docker service logs -f monitoring_central_alloy
docker service logs -f monitoring_central_cloudflared
```

Central VPS sau khi setup xong:

- Grafana chạy nội bộ ở `grafana:3000`
- Public Grafana đi qua **Cloudflare Tunnel**
- Prometheus nhận `remote_write` ở `:9090`
- Loki nhận push logs ở `:3102`

## Case 2: Setup Common VPS

1. Copy Nginx config cho Common:

```bash
cp common/nginx/nginx_sites_available.example common/nginx/nginx_sites_available
```

2. Sửa các `server {}` trong `common/nginx/nginx_sites_available`

Nguyên tắc:

- mỗi app public route theo service DNS Swarm
- không route qua `172.17.0.1:<port>`
- mỗi `server {}` nên có:

```nginx
set $project "<TEN_STACK_SWARM>";
```

Ví dụ upstream:

```nginx
proxy_pass http://<stack>_<service>:<port>;
```

3. Deploy stack Common:

```bash
make deploy_common
```

4. Kiểm tra service:

```bash
docker stack services monitoring_common
```

5. Kiểm tra logs khi cần:

```bash
docker service logs -f monitoring_common_nginx
docker service logs -f monitoring_common_alloy
```

## Case 3: Khi Bắt Đầu Một Dự Án Mới Trên Common VPS

Checklist cho project app mới:

1. Project app phải có Docker Swarm stack name rõ ràng, ví dụ `qr_code`
2. Service public của app phải join `nginx_gateway_net`
3. Service public của app không publish port host
4. Database, Redis, worker chỉ ở private network riêng của project
5. Common Nginx thêm `server {}` mới trỏ vào:

```text
http://<STACK_NAME>_<SERVICE_NAME>:<CONTAINER_PORT>
```

Ví dụ:

```text
http://qr_code_production_backend:3000
```

6. Nếu muốn tạo dashboard cho project:

```bash
make dashboards_project PROJECT=qr_code VPS=vps-qr-code
```

Quy ước:

- `PROJECT` phải là **stack name** khi deploy bằng `docker stack deploy`
- mỗi `project` chỉ có **1 bộ dashboard** trong folder của project đó
- nếu truyền `VPS`, repo **không đổi tên file dashboard**
- `VPS` chỉ dùng để đặt giá trị mặc định cho biến lọc `vps`
- dashboard sẽ mở ra với `vps` mặc định là máy đó và không dùng `All`
- sau khi mở dashboard, bạn vẫn có thể đổi sang VPS khác trong cùng project ngay trên filter Grafana

Ví dụ một project `cross` chạy trên 2 VPS:

```bash
make dashboards_project PROJECT=cross VPS=cross-api-sgp1-01
```

Khi đó dashboard nằm chung trong:

```text
central/dashboards/projects/cross/
```

và file vẫn giữ tên chuẩn theo project, ví dụ:

```text
system_monitoring.json
container_logs_dashboard.json
nginx_api_observability.json
```

7. Reload Grafana ở Central nếu vừa thêm dashboard:

```bash
make deploy_central_grafana
```

## Case 3A: Migrate Một Project Cũ Sang nginx_gateway_net

Nếu project đang chạy theo kiểu cũ:

- app có `ports:` public trên host
- Common Nginx đang route qua `172.17.0.1:<port>`

thì nên migrate theo 3 bước để giảm rủi ro:

### Bước 1: Deploy app với network mới, chưa bỏ port cũ

- thêm `nginx_gateway_net` vào service public của app
- tạm **giữ nguyên** `ports` cũ
- deploy lại app stack

Lưu ý:

- bước này bắt buộc phải `docker stack deploy` lại app
- `make deploy_common_nginx` không thêm network mới cho nginx hay cho app được

### Bước 2: Đổi Common Nginx sang service DNS

Ví dụ đổi từ:

```nginx
proxy_pass http://172.17.0.1:3006;
```

sang:

```nginx
proxy_pass http://qr_code_production_backend:3000;
```

Sau đó reload Nginx:

```bash
make deploy_common_nginx
```

### Bước 3: Quan sát rồi mới bỏ port cũ

Khi traffic đã chạy ổn qua `nginx_gateway_net`:

- bỏ `ports:` public khỏi app
- deploy lại app stack lần nữa

Đây là cách migrate an toàn hơn so với đổi một lần.

## Case 4: Khi Update Nginx Ở Common VPS

Sau khi sửa `common/nginx/nginx_sites_available` hoặc `common/nginx/nginx.conf`:

```bash
make deploy_common_nginx
```

Chỉ dùng cách này khi không đổi `docker-compose.common.yml`.

Nếu bạn đổi:

- network
- mount
- ports
- env
- service definition trong compose

thì phải:

```bash
make deploy_common
```

## Case 5: Khi Update Alloy Ở Common VPS

Sau khi sửa `common/alloy/config.alloy` hoặc `.env`:

```bash
make deploy_common_alloy
```

Chỉ dùng cách này khi không đổi `docker-compose.common.yml`.

Nếu đổi mount/network/compose:

```bash
make deploy_common
```

## Case 6: Khi Update Central Stack

### Update Grafana provisioning hoặc dashboard templates

```bash
make deploy_central_grafana
```

### Update Alloy trên Central

```bash
make deploy_central_alloy
```

### Update Cloudflare Tunnel service

```bash
make deploy_central_cloudflared
```

### Update Prometheus hoặc Loki compose/config

```bash
make deploy_central
```

## Case 7: Khi Regenerate Dashboard Theo Project

Tạo hoặc overwrite dashboard cho một project:

```bash
make dashboards_project PROJECT=<TEN_STACK>
```

Khóa luôn dashboard system theo một VPS:

```bash
make dashboards_project PROJECT=<TEN_STACK> VPS=<TEN_VPS>
```

Sync lại toàn bộ project folders:

```bash
make dashboards_sync_all
```

## Các Lệnh Hay Dùng

```bash
make gateway_network
make deploy_common
make deploy_central
make stack_common
make stack_central
make deploy_common_nginx
make deploy_common_alloy
make deploy_central_grafana
make deploy_central_alloy
make deploy_central_cloudflared
make dashboards_project PROJECT=my_stack
make dashboards_sync_all
```

## Quy Tắc Chọn Đúng Lệnh

- Đổi file config bên trong service đang có sẵn:
  - dùng `make deploy_common_nginx`
  - dùng `make deploy_common_alloy`
  - dùng `make deploy_central_grafana`
  - dùng `make deploy_central_alloy`
  - dùng `make deploy_central_cloudflared`
- Đổi compose-level như network, mount, port, env, replicas:
  - dùng `make deploy_common`
  - dùng `make deploy_central`
  - `make stack_common` và `make stack_central` vẫn là alias cũ

## Một Số Nguyên Tắc Quan Trọng

- App public không mở `ports` public ra host
- Common Nginx là ingress public duy nhất cho app
- Grafana public đi qua Cloudflare Tunnel
- Prometheus và Loki nhận data trực tiếp từ Alloy qua IP Tailscale của Central
- Không dùng `172.17.0.1:<published-port>` cho app traffic
- Route nội bộ theo service DNS của Swarm

## Docs

- Tài liệu topology, luồng traffic, hình minh họa, security rationale và cách dùng:
  - [`docs/centralized-vps.md`](/Users/ducpt/WorkSpace/nginx_cadvisor_prometheus_grafana/docs/centralized-vps.md)
