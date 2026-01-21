### 1. TAUDIEN

**TAUDIEN** (<ins>MSTau</ins>, TenTau, SLToa, TrangThai, GioKH, GioKT, MSTuyen)

**Tân từ:**  Quan hệ **TAUDIEN** lưu trữ thông tin về các tàu điện, bao gồm: mã số tàu điện, tên tàu điện, số lượng toa, trạng thái hoạt động,
giờ khởi hành, giờ kết thúc và tuyến đường mà tàu điện di chuyển.

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSTau | CHAR(5) | Mã số tàu điện | Khóa chính |
| 2 | TenTau | VARCHAR(50) | Tên tàu điện | NOT NULL |
| 3 | SLToa | INT | Số lượng toa | NOT NULL |
| 4 | TrangThai | VARCHAR(50) | Trạng thái hoạt động | NOT NULL |
| 5 | GioKH | TIME | Giờ khởi hành | NOT NULL |
| 6 | GioKT | TIME | Giờ kết thúc | NOT NULL |
| 7 | MSTuyen | CHAR(5) | Mã tuyến đường | Khóa ngoại → TUYENDUONG |
---

### 2. GATAU

**GATAU** (<ins>MSGa</ins>, TenGa, DiaChi) 

**Tân từ:** Quan hệ **GATAU** chứa thông tin về các ga  tàu. Thông tin gồm có: mã số ga tàu  (MSGa), tên ga tàu (TenGa) và địa chỉ của ga tàu (DiaChi). 

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSGa | CHAR(5) | Mã ga tàu | Khóa chính |
| 2 | TenGa | VARCHAR(50) | Tên ga tàu | NOT NULL |
| 3 | DiaChi | VARCHAR(50) | Địa chỉ ga tàu | NOT NULL |

### 3. TUYENDUONG

**TUYENDUONG** (<ins>MSTuyen</ins>, TenTuyen, ChieuDai, SLGa, GaBD, GaKT) 

**Tân từ:** Quan hệ **TUYENDUONG** chứa thông tin về các tuyến đường. Thông tin gồm có: mã số tuyến đường (MSTuyen), tên tuyến đường (TenTuyen), chiều dài tuyến (ChieuDai), số lượng ga của một tuyến (SLGa), ga bắt đầu tuyến (GaBD), ga kết thúc tuyến (GaKT).

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSTuyen | CHAR(5) | Mã tuyến đường | Khóa chính |
| 2 | TenTuyen | VARCHAR(50) | Tên tuyến đường | NOT NULL |
| 3 | ChieuDai | FLOAT | Chiều dài tuyến (km) | NOT NULL |
| 4 | SLGa | INT | Số lượng ga | NOT NULL |
| 5 | GaBD | CHAR(5) | Ga bắt đầu | Khóa ngoại → GATAU |
| 6 | GaKT | CHAR(5) | Ga kết thúc | Khóa ngoại → GATAU |

### 4.CHUYENDI 

**CHUYENDI** (<ins>MSChuyen</ins>, GaDi, GaDen, TGDiDuKien, TGDenDuKien, MSTuyen,  GiaVeLuot) 

**Tân từ:** Quan hệ **CHUYENDI** chứa thông tin về các chuyến đi. Thông tin bao gồm: mã số chuyến đi (MSChuyen), ga đi (GaDi), ga đến (GaDen), thời gian đi dự kiến của tàu (TGDiDuKien), thời gian đến dự kiến của tàu (TGDenDuKien), mã số tuyến (MSTuyen), và giá vé lượt của chuyến đi (GiaVeLuot).

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSChuyen | CHAR(5) | Mã chuyến đi | Khóa chính |
| 2 | GaDi | CHAR(5) | Ga đi | Khóa ngoại → GATAU |
| 3 | GaDen | CHAR(5) | Ga đến | Khóa ngoại → GATAU |
| 4 | TGDiDuKien | TIME | Thời gian đi dự kiến | NOT NULL |
| 5 | TGDenDuKien | TIME | Thời gian đến dự kiến | NOT NULL |
| 6 | MSTuyen | CHAR(5) | Mã tuyến | Khóa ngoại → TUYENDUONG |
| 7 | GiaVeLuot | DECIMAL(9,0) | Giá vé lượt | |
