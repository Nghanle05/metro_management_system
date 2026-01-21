**DB_TUYEN** (<ins>MSTuyen, MSDB</ins>, TGAnhHuong, TTAnhHuong)  

**Tân từ:** Quan hệ **DB_TUYEN** chứa thông tin về dự báo thời tiết ảnh hưởng lên tuyến 
đường. Thông tin bao gồm: mã số tuyến đường (MSTuyen), mã số dự báo thời tiết 
(MSDB), thời gian bị ảnh hưởng bởi thời tiết (TGAnhHuong), tình trạng hoạt động 
của tuyến khi bị ảnh hưởng (TTAnhHuong). 

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSTuyen | CHAR(5) | Mã tuyến đường | Khóa ngoại → TUYENDUONG |
| 2 | MSDB | CHAR(5) | Mã dự báo thời tiết | Khóa ngoại → THOITIET |
| 3 | TGAnhHuong | DATETIME | Thời gian ảnh hưởng | |
| 4 | TTAnhHuong | VARCHAR(50) | Tình trạng ảnh hưởng | |
