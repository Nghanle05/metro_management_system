# metro_management_system
Quản lý thông tin và thiết kế lược đồ ERD cho hệ thống quản lý Metro 

### CÁC THÀNH VIÊN ĐÓNG GÓP 
----------
- 23520285 - Lương Kiều Diễm
- 23520415 - Trần Thanh Hà
- 23520430 - Lê Thị Ngọc Hân

### TỔNG QUAN HỆ THỐNG 
----------
Hệ thống Quản lý Metro được xây dựng nhằm hỗ trợ quản lý và vận hành hệ thống tàu điện Metro trong bối cảnh đô thị hóa nhanh, mật độ dân cư cao và tình trạng ùn tắc giao thông nghiêm trọng tại các thành phố lớn ở Việt Nam như TP.HCM và Hà Nội. Hệ thống góp phần giảm tải giao thông đường bộ, hạn chế ô nhiễm môi trường và nâng cao chất lượng di chuyển của người dân.

Ngoài các chức năng quản lý vận hành cơ bản, hệ thống còn tích hợp dữ liệu thời tiết để hỗ trợ dự đoán tình trạng hoạt động của các tuyến Metro trong điều kiện thời tiết xấu (tạm hoãn, hủy chuyến, không ảnh hưởng), giúp hành khách và đơn vị quản lý chủ động hơn trong việc điều phối và di chuyển.

Trong đồ án lần này, nhóm sẽ thiết kế hệ thống quản lý toàn bộ hoạt động vận hành của Metro, bao gồm:
- Ga tàu, tuyến đường và tàu điện
- Lịch trình và chuyến đi
- Vé tàu và hành khách
- Nhân viên và hoạt động bảo trì
- Dự báo thời tiết và ảnh hưởng đến tuyến Metro
Điểm nổi bật của hệ thống là tích hợp dự báo thời tiết, giúp nâng cao khả năng hỗ trợ ra quyết định và trải nghiệm người dùng.

### CÁC ĐỐI TƯỢNG HƯỚNG ĐẾN 
----------
Hệ thống phục vụ nhiều nhóm người dùng với quyền hạn khác nhau:
- Quản trị viên: Quản lý toàn bộ hệ thống Metro (tàu, ga, tuyến, chuyến đi, nhân viên, hành khách), thực hiện các thao tác xem, thêm, sửa, xóa và cập nhật dữ liệu.
- Quản lý ga: Quản lý nhân viên, bảo trì ga và theo dõi thông tin liên quan đến ga, tàu, tuyến và chuyến đi.
- Nhân viên bán vé: Quản lý vé và thông tin hành khách; tra cứu thông tin tàu, ga, tuyến và chuyến đi.
- Nhân viên bảo trì: Theo dõi thông tin bảo trì liên quan đến ga, tuyến, tàu và chuyến đi được phân công.
- Hành khách: Tra cứu thông tin tàu, ga, tuyến, lịch trình, vé, lịch bảo trì và tình trạng ảnh hưởng bởi thời tiết.

### LƯỢC ĐỒ ERD 
----------
![ERD hệ thống](images/ERD.png)

### CÁC CÔNG CỤ SỬ DỤNG 
----------
- Hệ quản trị cơ sở dữ liệu MySQL và Excel: được sử dụng để thu thập lưu trữ dữ liệu 
- DrawDB và Draw.io: được sử dụng để phân tích và thiết kế sơ đồ

### KHẢO SÂT
-----------
1. [Railway Management System _Group10]([url](https://github.com/fuboki10/Railway-Management-System/tree/master))
2. [McMahon, P., Zhang, T., & Dwight, R. (2020). Requirements for big data adoption for railway asset management. IEEE Access, 8, 15543–15564](url) 
