# Centralized VPS (Tailscale)

## Mục tiêu

Chuyển dự án từ mô hình “hybrid/Grafana Cloud” sang mô hình **1 VPS trung tâm (Central)** để nhận dữ liệu từ nhiều **VPS common** và vẽ dashboard trực tiếp trên **Grafana OSS**.

- **Central VPS**: Prometheus + Loki + Grafana
- **Common VPS**: Nginx + Grafana Alloy
- Kết nối giữa các VPS dùng **Tailscale** (khuyến nghị bật MagicDNS)

## Luồng dữ liệu

- Metrics: Common Alloy → `remote_write` → Central Prometheus (`:9090/api/v1/write`)
- Logs: Common Alloy → `loki push` → Central Loki (`:3102/loki/api/v1/push`)
- Dashboards: lưu dạng JSON trong `central/dashboards/` và được Grafana auto-load qua provisioning.

Ghi chú quan trọng:

- Mỗi Common VPS cần set `VPS_NAME` để dữ liệu không bị trùng label `instance` khi nhiều VPS đổ về Central.

## Bước 1 — Tách repo (đã áp dụng trong cấu trúc)

Repo được tách thành 2 khối chính:

- `central/` (chạy trên Central VPS)
  - `central/prometheus/`
  - `central/loki/`
  - `central/grafana/` (provision datasources + dashboards)
  - `central/dashboards/`
- `common/` (chạy trên Common VPS)
  - `common/alloy/`
  - `common/nginx/`

Swarm stacks:

- `docker-compose.central.yml`
- `docker-compose.common.yml`

## Bước 2 — Kết nối các VPS qua Tailscale (triển khai vận hành)

Khuyến nghị:

1. Cài Tailscale trên Central và mọi Common VPS.
2. Bật MagicDNS và đặt hostname cho Central (ví dụ: `central`).
3. Thiết lập ACL để Common có thể truy cập Central các port:
   - Grafana: `3000`
   - Prometheus: `9090`
   - Loki: `3102`
4. Trên Central, **không mở public** các port trên:
   - Dùng firewall chỉ allow inbound từ `tailscale0` (hoặc từ tailnet IP range).

## Deploy nhanh

Central VPS:

```bash
make swarm
make stack_central
```

Common VPS:

```bash
make swarm
make stack_common
```

## Ghi chú

- File `.env.example` có `CENTRAL_TAILSCALE_HOST` để Common trỏ về Central qua MagicDNS.
- Lưu ý: Docker `env_file` không expand biến kiểu `http://${CENTRAL_TAILSCALE_HOST}:...`.
  Vì vậy hãy set `CENTRAL_PROM_URL` / `CENTRAL_LOKI_URL` thành URL đầy đủ (hostname/IP thật).
- Set `VPS_NAME` khác nhau trên mỗi Common VPS (ví dụ: `vps-hanoi-01`, `vps-sg-02`).
- Datasource UIDs được fix là `prometheus` và `loki` để khớp với JSON dashboards hiện có.

### Loki 400 "timestamp too old" (khi mới bật Alloy)

Khi Alloy mới chạy, `loki.source.docker` có thể đọc lại các log Docker cũ. Nếu Central Loki đang bật `reject_old_samples` (ví dụ chỉ cho phép tối đa 72h), Loki sẽ trả 400 và Alloy sẽ log kiểu "dropping data".

Repo đã cấu hình sẵn để **drop log entry cũ hơn 72h ngay tại Alloy** (xem `stage.drop { older_than = "72h" }` trong pipeline logs).

Rollout khuyến nghị:

1. Deploy/update Central như bình thường.
2. Trên từng Common VPS, update stack để Alloy nhận config mới:

```bash
make stack_common
```

Nếu bạn vẫn thấy 400 trong vài phút đầu, thường là do backlog log cũ đang được đọc; sau khi “đuổi kịp” log mới, lỗi sẽ tự hết.
