# Trên Central VPS

Central VPS chạy stack `monitoring_central`: **Prometheus + Loki + Grafana + Alloy + cloudflared**. Đây là nơi tập trung nhận metrics/logs từ các Common VPS và hiển thị dashboard.

Tài liệu này hướng dẫn mọi việc cần làm **trên máy Central VPS**, theo thứ tự:

- [1. Cài Tailscale](#1-cài-tailscale)
- [2. Chuẩn bị `.env`, Swarm, network](#2-chuẩn-bị-env-swarm-network)
- [3. Tạo Docker secret cho Cloudflare Tunnel](#3-tạo-docker-secret-cho-cloudflare-tunnel)
- [4. Deploy stack](#4-deploy-stack)
- [5. Verify](#5-verify)
- [6. Tạo dashboard khi có project app mới](#6-tạo-dashboard-khi-có-project-app-mới)
- [Logs khi cần](#logs-khi-cần)

Nếu cần hiểu vì sao thiết kế thế này: [`architecture.md`](architecture.md). Vận hành định kỳ (update config sau khi đã setup): [`README.md`](../README.md).

## 1. Cài Tailscale

Cài trên **host** (không cài trong container):

```bash
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --advertise-tags=tag:central
tailscale ip -4
```

Ghi lại IP Tailscale Central (dạng `100.x.y.z`). Common VPS sẽ dùng IP này để đẩy metrics/logs về Central.

Policy chặt (chỉ Common gọi Central ở `:9090`, `:3102`): xem [`tailscale-policy.md`](tailscale-policy.md).

## 2. Chuẩn bị `.env`, Swarm, network

```bash
cp .env.example .env
make swarm
make gateway_network
```

Sửa `.env`:

```env
VPS_NAME=<ten-central-vps>
GF_SECURITY_ADMIN_USER=<user>
GF_SECURITY_ADMIN_PASSWORD=<password>
GF_SERVER_DOMAIN=<grafana.tenmien.com>
GF_SERVER_ROOT_URL=https://<grafana.tenmien.com>
GF_SERVER_ENFORCE_DOMAIN=true
```

Không cần set `CENTRAL_PROM_URL` / `CENTRAL_LOKI_URL` ở Central — [`docker-compose.central.yml`](../docker-compose.central.yml) đã override 2 biến này thành DNS nội bộ (`http://prometheus:9090/...`, `http://loki:3102/...`).

## 3. Tạo Docker secret cho Cloudflare Tunnel

```bash
printf '%s' 'PASTE_TUNNEL_TOKEN_HERE' | docker secret create cf_tunnel_token -
```

Token lấy từ Cloudflare Zero Trust khi tạo tunnel remote-managed. Xem [`cloudflare-tunnel-grafana-production.md`](cloudflare-tunnel-grafana-production.md) cho hướng dẫn tạo tunnel + bật Cloudflare Access.

Verify secret tồn tại:

```bash
docker secret ls | grep cf_tunnel_token
```

## 4. Deploy stack

```bash
make deploy_central
```

Lệnh này đã gồm `gateway_network` và `check_cf_tunnel_secret` nên không cần chạy riêng.

## 5. Verify

```bash
docker stack services monitoring_central
```

Mở Grafana qua domain Cloudflare Tunnel (vd `https://grafana.tenmien.com`). Đăng nhập bằng `GF_SECURITY_ADMIN_USER` / `GF_SECURITY_ADMIN_PASSWORD`.

Sau khi setup xong:

- Grafana chạy nội bộ ở `grafana:3000`, public qua Cloudflare Tunnel
- Prometheus nhận `remote_write` ở `:9090` (qua Tailscale)
- Loki nhận push logs ở `:3102` (qua Tailscale)

## 6. Tạo dashboard khi có project app mới

Sau khi onboard 1 app mới trên Common VPS (xem [`common-vps.md`](common-vps.md) Phần 2), về **Central VPS** chạy:

```bash
make dashboards_project PROJECT=<TEN_STACK> VPS=<TEN_VPS_COMMON>
make deploy_central_grafana
```

Ví dụ:

```bash
make dashboards_project PROJECT=qr_code VPS=vps-app-01
make deploy_central_grafana
```

Quy ước:

- `PROJECT` **phải** là stack name khi deploy app trên Common (đã chọn ở Bước 0 trong [`common-vps.md`](common-vps.md#bước-0-chọn-tên-định-danh-cho-project)).
- `VPS` là tuỳ chọn, dùng để default filter `vps` trên dashboard.
- Mỗi project có **1 bộ** dashboard (3 file: API, Logs, System) trong `central/dashboards/projects/<TEN_STACK>/`.

Khi sửa template chung (`central/dashboards/projects/_all/`), sync lại tất cả project hiện có:

```bash
make dashboards_sync_all
make deploy_central_grafana
```

## Logs khi cần

```bash
docker service logs -f monitoring_central_grafana
docker service logs -f monitoring_central_prometheus
docker service logs -f monitoring_central_loki
docker service logs -f monitoring_central_alloy
docker service logs -f monitoring_central_cloudflared
```
