# Google OAuth Cho Grafana

Mục tiêu: PM đăng nhập Grafana bằng Google account công ty, nhưng quyền project vẫn do Grafana team/folder permission quản lý.

Luồng nên dùng trong dự án này:

```text
Admin tạo user trong Grafana với email công ty
Admin add user vào team project
PM login bằng Google với đúng email đó
Grafana map Google email vào user đã tạo
PM chỉ thấy folder project được cấp
```

## 1. Tạo Google OAuth Client

Trong Google Cloud Console:

```text
APIs & Services -> Credentials -> Create Credentials -> OAuth client ID
```

Chọn:

```text
Application type: Web application
```

Authorized JavaScript origins:

```text
https://<grafana-domain>
```

Authorized redirect URIs:

```text
https://<grafana-domain>/login/google
```

Ví dụ:

```text
https://grafana.company.com/login/google
```

Sau đó copy:

```text
Client ID
Client Secret
```

## 2. Cấu Hình `.env` Trên Central

```env
GF_SERVER_DOMAIN=grafana.company.com
GF_SERVER_ROOT_URL=https://grafana.company.com
GF_SERVER_ENFORCE_DOMAIN=true

GF_AUTH_GOOGLE_ENABLED=true
GF_AUTH_GOOGLE_CLIENT_ID=<google-client-id>
GF_AUTH_GOOGLE_CLIENT_SECRET=<google-client-secret>
GF_AUTH_GOOGLE_ALLOWED_DOMAINS=company.com
GF_AUTH_GOOGLE_ALLOW_SIGN_UP=false
GF_AUTH_OAUTH_ALLOW_INSECURE_EMAIL_LOOKUP=true
```

Ý nghĩa quan trọng:

| Biến | Ý nghĩa |
|---|---|
| `GF_AUTH_GOOGLE_ALLOW_SIGN_UP=false` | Người chưa được tạo user trước trong Grafana không tự vào được |
| `GF_AUTH_GOOGLE_ALLOWED_DOMAINS=company.com` | Chỉ cho email thuộc domain công ty |
| `GF_AUTH_OAUTH_ALLOW_INSECURE_EMAIL_LOOKUP=true` | **Bắt buộc** cho flow này, xem giải thích bên dưới |
| `GF_SERVER_ROOT_URL` | Grafana dùng URL này để tạo callback `/login/google` đúng domain public |

Các URL OAuth, scope mặc định và PKCE không cần khai báo nếu dùng Google OAuth chuẩn của Grafana.

### Vì sao cần `GF_AUTH_OAUTH_ALLOW_INSECURE_EMAIL_LOOKUP=true`

Mặc định từ Grafana 9.4 trở đi, OAuth login chỉ match user qua `auth_id` của provider (Google `sub`), không match qua email — để chặn [CVE-2023-3128](https://grafana.com/security/security-advisories/cve-2023-3128).

User admin tạo tay trong UI **chưa có** dòng `(auth_module=google, auth_id=<sub>)` trong bảng `user_auth`. Khi PM login Google lần đầu, Grafana lookup bằng `sub` → miss → vì `allow_sign_up=false` → **reject 403**.

Bật flag này cho Grafana fallback lookup bằng email khi miss `sub`. Tìm thấy user admin đã tạo → link `sub` Google vào user đó → lần sau lookup `sub` đã hit, flag không còn vai trò.

Trong setup này flag an toàn vì:

- Chỉ dùng 1 OAuth provider là Google.
- Google verify email và unique trong workspace.
- Đã giới hạn thêm bằng `GF_AUTH_GOOGLE_ALLOWED_DOMAINS`.

CVE chỉ ảnh hưởng khi dùng nhiều OAuth provider mà có provider cho user tự khai email không verify.

## 3. Deploy Lại Central

```bash
make deploy_central
```

Sau deploy, màn login Grafana sẽ có nút Google.

## 4. Onboard PM

Trong Grafana admin:

1. Tạo user với email công ty của PM.
2. Set role `Viewer`.
3. Add user vào team project tương ứng.
4. Set folder permission theo team project.

PM login bằng Google account có cùng email.

## 5. Kiểm Tra

Admin:

- Vẫn login được bằng user/password local.
- Thấy tất cả dashboard.

PM:

- Login bằng Google.
- Chỉ thấy folder project được cấp.
- Không tự signup được nếu chưa có user trong Grafana.

## 6. Docs Chính Thức

- [Grafana Google OAuth authentication](https://grafana.com/docs/grafana/latest/setup-grafana/configure-access/configure-authentication/google/)
- [Grafana authentication and email lookup](https://grafana.com/docs/grafana/latest/setup-grafana/configure-access/configure-authentication/)
