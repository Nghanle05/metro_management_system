**THOITIET** (<ins>MSDB</ins>, TrangThai, TGCapNhat) 

**Tân từ:** Quan hệ **THOITIET** chứa thông tin về dự báo thời tiết. 
Thông tin bao gồm: mã số dự báo (MSDB), trạng thái thời tiết (TrangThai), và thời gian cập nhật dự báo (TGCapNhat). 


| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSDB | CHAR(5) | Mã dự báo thời tiết | Khóa chính |
| 2 | TrangThai | VARCHAR(50) | Trạng thái thời tiết | NOT NULL |
| 3 | TGCapNhat | DATETIME | Thời gian cập nhật | NOT NULL |
