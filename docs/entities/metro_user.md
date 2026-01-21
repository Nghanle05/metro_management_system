### 1. VAITRO 

**VAITRO** (<ins>MSVT</ins>, TenVT) 

**Tân từ:** Quan hệ **VAITRO** chứa thông tin về các vai trò của một nhân viên. Thông tin gồm có: mã số vai trò (MSVT), và tên vai trò (TenVT). 

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSVT | CHAR(5) | Mã vai trò | Khóa chính |
| 2 | TenVT | VARCHAR(50) | Tên vai trò | NOT NULL |

### 2. NHANVIEN

**NHANVIEN** (<ins>MSNV</ins>, HoTen, GioiTinh, DiaChi, SoDT, MSVT, MSDoi) 

**Tân từ:** Quan hệ NHANVIEN chứa thông tin về các nhân viên. Thông tin gồm có: mã số nhân viên (MSNV), họ tên nhân viên (HoTen), giới tính nhân viên (GioiTinh), 
địa chỉ (DiaChi), số điện thoại (SoDT), mã số vai trò của nhân viên (MSVT) và mã số đội bảo trì mà nhân viên bảo trì tham gia vào (MSDoi). 

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSNV | CHAR(5) | Mã nhân viên | Khóa chính |
| 2 | TenNV | VARCHAR(50) | Họ tên nhân viên | NOT NULL |
| 3 | GioiTinh | VARCHAR(5) | Giới tính | NOT NULL |
| 4 | DiaChi | VARCHAR(50) | Địa chỉ | NOT NULL |
| 5 | SoDT | VARCHAR(10) | Số điện thoại | |
| 6 | MSVT | CHAR(5) | Mã vai trò | Khóa ngoại → VAITRO |
| 7 | MSDoi | CHAR(5) | Mã đội bảo trì | Khóa ngoại → DOIBAOTRI |

### 3. DOIBAOTRI

**DOIBAOTRI** (<ins>MSDoi</ins>, TenDoi, SLThanhVien) 

**Tân từ:** Quan hệ **DOIBAOTRI** chứa thông tin về các đội bảo trì. Thông tin bao gồm: mã số đội bảo trì (MSDoi), tên đội bảo trì (TenDoi), 
và số lượng thành viên trong đội (SLThanhVien). 

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSDoi | CHAR(5) | Mã đội bảo trì | Khóa chính |
| 2 | TenDoi | VARCHAR(50) | Tên đội bảo trì | NOT NULL |
| 3 | SLThanhVien | INT | Số lượng thành viên | |

### 4. HANHKHACH

**HANHKHACH** (<ins>MSHK</ins>, TenHK, GioiTinh, CCCD, SoDT) 

**Tân từ:** Quan hệ **HANHKHACH** chứa thông tin về các hành khách. Thông tin bao gồm: mã số hành khách (MSHK), họ tên hành khách (TenHK), 
giới tính hành khách (GioiTinh), số căn cước công dân (CCCD) và số điện thoại (SoDT). 

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSHK | CHAR(5) | Mã hành khách | Khóa chính |
| 2 | TenHK | VARCHAR(50) | Họ tên hành khách | NOT NULL |
| 3 | GioiTinh | VARCHAR(5) | Giới tính | NOT NULL |
| 4 | SoDT | VARCHAR(10) | Số điện thoại | |
| 5 | CCCD | CHAR(12) | Căn cước công dân | |
