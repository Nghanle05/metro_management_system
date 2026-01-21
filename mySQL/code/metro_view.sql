CREATE DATABASE QLMETRO;
USE QLMETRO;

-- VD1: Bảng ảo bao gồm có thông tin các thuộc tính tên hành khách, tên loại vé, thời gian mua vé, 
     -- ga đi, ga đến, trạng thái, phương thức mua của từng vé tàu 
CREATE VIEW view_thongtin_ve AS
SELECT DISTINCT TenHK, TenLoai, TGMua, G1.TenGa AS 'GaDi', G2.TenGa AS 'GaDen', TrangThai, PhuongThuc
FROM VETAU V JOIN HANHKHACH H ON H.MSHK = V.MSHK
JOIN LOAIVE L ON L.MSLoai = V.MSLoai
JOIN CHUYENDI C ON C.MSChuyen = V.MSChuyen
JOIN GATAU G1 ON G1.MSGa = C.GaDi
JOIN GATAU G2 ON G2.MSGa = C.GaDen;
SELECT * FROM view_thongtin_ve;

-- VD2: Bảng ảo gồm thông tin khách hàng mà vé ở trạng thái "Hết hiệu lực"
CREATE VIEW view_ve_hethan AS
SELECT hk.MSHK, hk.TenHK, vt.MSVe, cd.GaDi, cd.GaDen
FROM VETAU vt
JOIN HANHKHACH hk ON vt.MSHK = hk.MSHK
JOIN CHUYENDI cd ON vt.MSChuyen = cd.MSChuyen
WHERE vt.TrangThai = 'Hết hiệu lực';
SELECT * FROM view_ve_hethan;

-- VD3: Bảng ảo gồm thông tin tên nhân viên, giới tính, tên vai trò và tên đội bảo trì mà nhân viên đang tham gia 
CREATE VIEW view_nv_doibaotri AS
SELECT TenNV, GioiTinh, DiaChi, TenVT, TenDoi
FROM NHANVIEN AS NV, VAITRO AS VT, DOIBAOTRI AS D
WHERE NV.MSDoi = D.MSDoi AND NV.MSVT = VT.MSVT;
SELECT * FROM view_nv_doibaotri;

-- VD4: Bảng ảo này gồm thông tin tên tuyến, loại dự báo bị ảnh hưởng và tình trạng, thời gian ảnh hưởng
CREATE VIEW view_db_tuyen AS
SELECT TenTuyen, TrangThai, DB.TGAnhHuong, DB.TTAnhHuong
FROM THOITIET AS T, TUYENDUONG AS TD, DB_TUYEN AS DB
WHERE DB.MSDB = T.MSDB AND DB.MSTuyen = TD.MSTuyen;
SELECT * FROM view_db_tuyen;