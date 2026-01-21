### 1. LOAIVE

**LOAIVE** (<ins>MSLoai</ins>, TenLoai, GiaVe) 

**Tân từ:** Quan hệ **LOAIVE** chứa thông tin về các vé của từng chuyến đi. 
Thông tin bao gồm: mã số loại vé (MSLoai), loại vé (TenLoai) và giá vé (GiaVe). 

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSLoai | CHAR(5) | Mã loại vé | Khóa chính |
| 2 | TenLoai | VARCHAR(50) | Tên loại vé | NOT NULL |
| 3 | GiaVe | DECIMAL(9,0) | Giá vé | |

### 2. VETAU

**VETAU** (<ins>MSVe</ins>, MSHK, MSChuyen, MSLoai, TGMua, TGHieuLuc, TrangThai, PhuongThuc) 

**Tân từ:** Quan hệ **VETAU** chứa thông tin về các hành khách thực hiện chuyến đi. 
Thông tin bao gồm: mã số vé tàu (MSVe), mã số hành khách (MSHK), mã số chuyến (MSChuyen), mã số loại (MSLoai), thời gian mua (TGMua), 
thời gian hiệu lực (TGHieuLuc), trạng thái của vé tàu (TrangThai), phương thức thanh toán (PhuongThuc). 

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSVe | CHAR(5) | Mã vé tàu | Khóa chính |
| 2 | MSHK | CHAR(5) | Mã hành khách | Khóa ngoại → HANHKHACH |
| 3 | MSChuyen | CHAR(5) | Mã chuyến đi | Khóa ngoại → CHUYENDI |
| 4 | MSLoai | CHAR(5) | Mã loại vé | Khóa ngoại → LOAIVE |
| 5 | TGMua | DATETIME | Thời gian mua vé | |
| 6 | TGHieuLuc | DATETIME | Thời gian hiệu lực | |
| 7 | TrangThai | VARCHAR(50) | Trạng thái vé | |
| 8 | PhuongThuc | VARCHAR(50) | Phương thức thanh toán | |

