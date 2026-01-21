### 1. BT_TAU

**BT_TAU** (<ins>MSDoi, MSTau</ins>, NgayBD, TrangThai) 

**Tân từ:** Quan hệ **BT_TAU** chứa thông tin về các đội bảo đảm nhiệm vụ bảo trì tàu điện. 
Thông tin bao gồm: mã số đội (MSDoi), mã số tàu (MSTau), ngày bắt đầu bảo trì (NgayBD), và trạng thái thực hiện (TrangThai). 

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSDoi | CHAR(5) | Mã đội bảo trì | Khóa ngoại → DOIBAOTRI |
| 2 | MSTau | CHAR(5) | Mã tàu điện | Khóa ngoại → TAUDIEN |
| 3 | NgayBD | DATE | Ngày bắt đầu bảo trì | NOT NULL |
| 4 | TrangThai | VARCHAR(50) | Trạng thái bảo trì | NOT NULL |

### 2. BT_TUYEN

**BT_TUYEN** (<ins>MSDoi, MSTuyen</ins>, NgayBD, TrangThai) 

**Tân từ:** Quan hệ **BT_TUYEN** chứa thông tin về các đội bảo đảm nhiệm vụ bảo trì tuyến đường. 
Thông tin bao gồm: mã số đội (MSDoi), mã số tuyến (MSTuyen), ngày bắt đầu bảo trì (NgayBD), và trạng thái thực hiện (TrangThai).

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSDoi | CHAR(5) | Mã đội bảo trì | Khóa ngoại → DOIBAOTRI |
| 2 | MSTuyen | CHAR(5) | Mã tuyến đường | Khóa ngoại → TUYENDUONG |
| 3 | NgayBD | DATE | Ngày bắt đầu bảo trì | NOT NULL |
| 4 | TrangThai | VARCHAR(50) | Trạng thái bảo trì | NOT NULL |

### 3. BT_GA

**BT_GA** (<ins>MSDoi, MSGa</ins>, NgayBD, TrangThai) 

**Tân từ:** Quan hệ **BT_GA** chứa thông tin về các đội bảo đảm nhiệm vụ bảo trì ga tàu. 
Thông tin bao gồm: mã số đội (MSDoi), mã số ga (MSGa), ngày bắt đầu bảo trì (NgayBD), và trạng thái thực hiện (TrangThai).

| STT | Thuộc tính | Kiểu dữ liệu | Ý nghĩa | Ràng buộc |
| --- | ---------- | ------------ | ------- | ---------- |
| 1 | MSDoi | CHAR(5) | Mã đội bảo trì | Khóa ngoại → DOIBAOTRI |
| 2 | MSGa | CHAR(5) | Mã ga tàu | Khóa ngoại → GATAU |
| 3 | NgayBD | DATE | Ngày bắt đầu bảo trì | NOT NULL |
| 4 | TrangThai | VARCHAR(50) | Trạng thái bảo trì | NOT NULL |
