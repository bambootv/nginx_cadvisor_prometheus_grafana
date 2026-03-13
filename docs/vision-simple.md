# Vision Simple

## Dự án này đang đi theo hướng nào

Theo những gì đã chốt hiện tại, dự án này nên đi theo hướng rất thực dụng:

1. Trước hết phải cho biết server có ổn không.
2. Phải thấy được Nginx đang chịu bao nhiêu request và có lỗi gì bất thường không.
3. Sau đó mới đi sâu hơn để biết API cho mobile có đang ổn không.
4. Khi có sự cố, mục tiêu quan trọng nhất là biết lỗi đang nằm ở đâu.

## Bối cảnh hiện tại

- Phía sau Nginx hiện chủ yếu là một ứng dụng Node.js.
- Hiện tại mới chỉ có 1 service, 1 app.
- Vì vậy, chưa cần nghĩ quá phức tạp như multi-service hay distributed tracing toàn hệ thống ngay từ đầu.

## Điều đó có nghĩa gì

Trong giai đoạn này, hệ thống observability nên trả lời tốt các câu hỏi cơ bản sau:

- Server có sống không?
- CPU, RAM, disk, container có ổn không?
- Nginx đang nhận bao nhiêu request?
- Request đang trả về 2xx, 4xx, 5xx ra sao?
- Khi lỗi xảy ra, nó nằm ở server, Nginx, hay app Node.js?

## Thứ tự ưu tiên hợp lý

### Ưu tiên 1

Ổn định hạ tầng cơ bản:

- Host health.
- Container health.
- Nginx traffic.
- Error rate cơ bản.

### Ưu tiên 2

Nhìn rõ hơn vào app Node.js:

- API nào chậm.
- API nào lỗi.
- App có bị crash, restart hoặc nghẽn tài nguyên không.

### Ưu tiên 3

Đi sâu hơn khi thực sự cần:

- So sánh trước và sau deploy.
- Biết dependency nào gây lỗi.
- Theo dõi chất lượng API cho mobile theo endpoint hoặc user flow.

## Một câu chốt ngắn

Tầm nhìn hiện tại không phải là xây một hệ observability quá lớn ngay từ đầu.

Tầm nhìn phù hợp hơn là: xây một hệ thống đủ đơn giản để biết server và Nginx có ổn không, sau đó mở rộng từng bước để xác định lỗi nằm ở đâu trong app Node.js phục vụ mobile.