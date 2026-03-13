# Vision Workshop

## Các quyết định đã chốt

### 1. Mục tiêu chính

Mục tiêu đi theo 2 lớp:

1. Trước hết hệ thống phải cho biết server có ổn không, chịu bao nhiêu request, Nginx có vấn đề gì không.
2. Sau đó mới mở rộng để biết API cho mobile có ổn không.

### 2. Điều quan trọng nhất khi có sự cố

Khi có sự cố, điều quan trọng nhất là biết lỗi đang nằm ở đâu.

Nói cách khác, hệ thống observability phải giúp phân biệt được tương đối rõ:

- lỗi ở server,
- lỗi ở Nginx,
- hay lỗi ở app Node.js phía sau.

### 3. Bối cảnh hệ thống hiện tại

- Backend chính: Node.js.
- Số service: 1.
- Số app: 1.

Điều này rất quan trọng vì nó có nghĩa là giai đoạn đầu chưa cần thiết kế như một platform observability cho hàng chục microservices.

## Kết luận định hướng hiện tại

Định hướng phù hợp nhất ở thời điểm này là:

- Bắt đầu từ server + Nginx visibility.
- Bổ sung khả năng nhìn vào app Node.js khi cần tìm nguyên nhân lỗi.
- Chưa ưu tiên các thành phần phức tạp nếu chưa giúp trả lời tốt hơn câu hỏi “lỗi đang nằm ở đâu?”.

## Những gì nên làm tốt trong giai đoạn đầu

### Must-have

- Biết host có sống không.
- Biết CPU, RAM, disk, network có bất thường không.
- Biết Nginx đang chịu bao nhiêu request.
- Biết tỷ lệ 2xx, 4xx, 5xx.
- Biết container hoặc app có bị restart không.
- Có đủ logs để khi lỗi xảy ra còn điều tra được.

### Nên có tiếp theo

- Biết endpoint nào ở app Node.js chậm.
- Biết endpoint nào lỗi nhiều.
- Có thể so sánh trước và sau deploy.
- Có thể khoanh vùng lỗi nhanh hơn giữa Nginx và app.

## Những thứ chưa cần ưu tiên quá sớm

- Multi-service observability phức tạp.
- Distributed tracing toàn diện.
- Các thành phần nặng chỉ để phục vụ tương lai xa.
- Dashboard quá nhiều khi câu hỏi gốc vẫn còn đơn giản.

## Các câu hỏi còn cần chốt thêm

1. Trong app Node.js hiện tại, 3 API nào là quan trọng nhất?
2. Bạn muốn biết nhiều hơn về request count, error rate hay latency?
3. Bạn có muốn theo dõi riêng thời điểm deploy để đối chiếu lỗi không?
4. App Node.js hiện có dùng DB, Redis hay external API nào quan trọng không?

## Câu tóm tắt để làm input cho kiến trúc

Xây một hệ thống quan sát đơn giản, đủ để biết server và Nginx có ổn không, và đủ để khoanh vùng lỗi giữa hạ tầng, Nginx và một app Node.js duy nhất đứng sau Nginx.