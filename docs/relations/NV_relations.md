### 1. NV_TAUDIEN

**NV_TAUDIEN** (<ins>MSTau</ins>, MSNV) 

**Tân từ:** Quan hệ **NV_TAUDIEN** chứa thông tin về các nhân viên làm việc trong các 
tàu điện. Thông tin bao gồm: mã số tàu điện (MSTau) và mã số nhân viên (MSNV). 

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSTau | CHAR(5) | Mã tàu điện | Khóa ngoại → TAUDIEN |
| 2 | MSNV | CHAR(5) | Mã nhân viên | Khóa ngoại → NHANVIEN |

### 2. NV_GATAU

**NV_GATAU** (<ins>MSGa</ins>, MSNV) 

**Tân từ:** Quan hệ **NV_GATAU** chứa thông tin về các nhân viên làm việc trong các ga 
tàu. Thông tin bao gồm: mã số ga tàu (MSGa), và mã số nhân viên (MSNV). 

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSGa | CHAR(5) | Mã ga tàu | Khóa ngoại → GATAU |
| 2 | MSNV | CHAR(5) | Mã nhân viên | Khóa ngoại → NHANVIEN |
