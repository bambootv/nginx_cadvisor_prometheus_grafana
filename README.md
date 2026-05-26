# Nginx Monitoring Stack

Mô hình nhiều VPS:

- **Central VPS**: Grafana, Prometheus, Loki, Alloy, `cloudflared`.
- **Common VPS**: Nginx public ingress + Alloy.
- **App**: chạy trên Common VPS, public qua Nginx.
- **Tailscale**: Common Alloy đẩy metrics/logs về Central.

README này tập trung vào **vận hành định kỳ**. Lần đầu cài đặt hoặc thêm app mới: xem `docs/`.

## Docs

| Mục đích | File |
|---|---|
| Mọi việc cần làm trên Central VPS (setup + gen dashboard) | [`docs/central-vps.md`](docs/central-vps.md) |
| Mọi việc cần làm trên Common VPS (setup + thêm app + migrate) | [`docs/common-vps.md`](docs/common-vps.md) |
| Kiến trúc tổng thể | [`docs/architecture.md`](docs/architecture.md) |
| Phân quyền PM theo project trong Grafana | [`docs/grafana-project-permissions.md`](docs/grafana-project-permissions.md) |
| Đăng nhập Grafana bằng Google/Gmail | [`docs/grafana-google-oauth.md`](docs/grafana-google-oauth.md) |
| Tailscale policy chi tiết | [`docs/tailscale-policy.md`](docs/tailscale-policy.md) |
| Cloudflare Tunnel production cho Grafana | [`docs/cloudflare-tunnel-grafana-production.md`](docs/cloudflare-tunnel-grafana-production.md) |

## Lệnh Hay Dùng

| Trường hợp | Lệnh |
|---|---|
| Deploy Common lần đầu | `make swarm && make gateway_network && make deploy_common` |
| Deploy Central lần đầu | `make swarm && make gateway_network && make deploy_central` |
| Đổi Nginx config | `make deploy_common_nginx` |
| Đổi Alloy config trên Common | `make deploy_common_alloy` |
| Đổi `.env`, network, mount, ports, compose Common | `make deploy_common` |
| Đổi dashboard/Grafana provisioning | `make deploy_central_grafana` |
| Đổi Central Alloy config | `make deploy_central_alloy` |
| Restart cloudflared | `make deploy_central_cloudflared` |
| Đổi `.env`, network, mount, ports, compose Central | `make deploy_central` |
| Tạo dashboard project | `make dashboards_project PROJECT=<TEN_STACK> VPS=<TEN_VPS>` |
| Sync dashboard từ template | `make dashboards_sync_all && make deploy_central_grafana` |

Lý do tách 2 nhóm lệnh: `docker service update --force` không áp dụng thay đổi compose-level (network, mount, port, env, image, replicas). Nếu đổi `.env`, dùng `make deploy_common` / `make deploy_central`.

Tạo dashboard ví dụ:

```bash
make dashboards_project PROJECT=qr_code VPS=vps-app-01
make deploy_central_grafana
```

## Xem Service / Logs

```bash
docker stack services monitoring_common
docker stack services monitoring_central

docker service logs -f monitoring_common_nginx
docker service logs -f monitoring_common_alloy
docker service logs -f monitoring_central_grafana
docker service logs -f monitoring_central_prometheus
docker service logs -f monitoring_central_loki
docker service logs -f monitoring_central_alloy
docker service logs -f monitoring_central_cloudflared
```

## Nguyên Tắc Ngắn

- App public service join `nginx_gateway_net`.
- DB/Redis/worker **không** join `nginx_gateway_net`.
- App **không** publish ports ra host.
- App **không** cần biết Prometheus/Loki — Alloy trên Common tự đọc và đẩy về Central.
- Grafana public qua Cloudflare Tunnel, **không** publish port `3000`.
- Route nội bộ theo tên service Swarm: `http://<stack>_<service>:<port>`.
