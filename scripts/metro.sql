CREATE DATABASE QLMETRO;
USE QLMETRO;

CREATE TABLE TAUDIEN
(
	MSTau CHAR(5) NOT NULL,
    TenTau VARCHAR(50) NOT NULL,
    SLToa INT NOT NULL,
    TrangThai VARCHAR(50) NOT NULL,
    GioKH TIME NOT NULL,
    GioKT TIME NOT NULL,
    MSTuyen CHAR(5) NOT NULL,
    CONSTRAINT PRIMARY KEY (MSTau),
    CONSTRAINT FOREIGN KEY (MSTuyen) REFERENCES TUYENDUONG(MSTuyen)
);
CREATE TABLE GATAU
(
	MSGa CHAR(5) NOT NULL,
    TenGa VARCHAR(50) NOT NULL,
    DiaChi VARCHAR(50) NOT NULL,
    CONSTRAINT PRIMARY KEY (MSGa)
);
CREATE TABLE TUYENDUONG
(
	MSTuyen CHAR(5) NOT NULL,
    TenTuyen VARCHAR(50) NOT NULL,
    ChieuDai FLOAT NOT NULL,
    SLGa INT NOT NULL,
    GaBD CHAR(5) NOT NULL,
    GaKT CHAR(5) NOT NULL,
    CONSTRAINT PRIMARY KEY (MSTuyen),
    CONSTRAINT fk_gabd_td FOREIGN KEY (GaBD) REFERENCES GATAU(MSGa),
    CONSTRAINT fk_gakt_td FOREIGN KEY (GaKT) REFERENCES GATAU(MSGa)
);
CREATE TABLE GADIQUA
(
	MSTuyen CHAR(5) NOT NULL,
    MSGa CHAR(5) NOT NULL,
    ThuTu INT,
    CONSTRAINT pk_mstuyen_msga_gdq PRIMARY KEY (MSTuyen, MSGa),
    CONSTRAINT fk_mstuyen_gdq FOREIGN KEY (MSTuyen) REFERENCES TUYENDUONG(MSTuyen),
    CONSTRAINT fk_msga_gdq FOREIGN KEY (MSGa) REFERENCES GATAU(MSGa)
);
CREATE TABLE VAITRO
(
	MSVT CHAR(5) NOT NULL,
    TenVT VARCHAR(50) NOT NULL,
    CONSTRAINT PRIMARY KEY (MSVT)
);
CREATE TABLE NHANVIEN
(
	MSNV CHAR(5) NOT NULL,
    TenNV VARCHAR(50) NOT NULL,
    GioiTinh VARCHAR(5) NOT NULL,
    DiaChi VARCHAR(50) NOT NULL,
    SoDT VARCHAR(10),
    MSVT CHAR(5) NOT NULL,
    MSDoi CHAR(5),
    CONSTRAINT PRIMARY KEY (MSNV),
    CONSTRAINT fk_msvt_nv FOREIGN KEY (MSVT) REFERENCES VAITRO(MSVT),
    CONSTRAINT fk_msdoi_nv FOREIGN KEY (MSDoi) REFERENCES DOIBAOTRI(MSDoi)
);					
CREATE TABLE NV_TAUDIEN
(
	MSTau CHAR(5) NOT NULL,
    MSNV CHAR(5) NOT NULL,
    CONSTRAINT pk_mstau_msnv_nvtd PRIMARY KEY (MSTau, MSNV),
    CONSTRAINT fk_mstau_nvtd FOREIGN KEY (MSTau) REFERENCES TAUDIEN(MSTau),
    CONSTRAINT fk_msnv_nvtd FOREIGN KEY (MSNV) REFERENCES NHANVIEN(MSNV)
);
CREATE TABLE NV_GATAU
(
	MSGa CHAR(5) NOT NULL,
    MSNV CHAR(5) NOT NULL,
    CONSTRAINT pk_msga_msnv_nvgt PRIMARY KEY (MSGa, MSNV),
    CONSTRAINT fk_msga_nvgt FOREIGN KEY (MSGa) REFERENCES GATAU(MSGa),
    CONSTRAINT fk_msnv_nvgt FOREIGN KEY (MSNV) REFERENCES NHANVIEN(MSNV)
);
CREATE TABLE HANHKHACH
(
	MSHK CHAR(5) NOT NULL,
    TenHK VARCHAR(50),
    GioiTinh VARCHAR(5),
    CCCD CHAR(12),
    SoDT VARCHAR(10),
    CONSTRAINT PRIMARY KEY (MSHK)
);				
CREATE TABLE LOAIVE
(
	MSLoai CHAR(5) NOT NULL,
    TenLoai VARCHAR(50) NOT NULL,
    GiaVe DECIMAL(9,0),
    CONSTRAINT PRIMARY KEY (MSLoai)
);
CREATE TABLE CHUYENDI
(
	MSChuyen CHAR(5) NOT NULL,
    GaDi CHAR(5) NOT NULL,
    GaDen CHAR(5) NOT NULL,
    TGDiDuKien TIME NOT NULL,
    TGDenDuKien TIME NOT NULL,
    MSTuyen CHAR(5) NOT NULL,
    GiaVeLuot DECIMAL(9,0),
    CONSTRAINT PRIMARY KEY (MSChuyen),
    CONSTRAINT fk_gadi_cd FOREIGN KEY (GaDi) REFERENCES GATAU(MSGa),
    CONSTRAINT fk_gaden_cd FOREIGN KEY (GaDen) REFERENCES GATAU(MSGa),
    CONSTRAINT fk_mstuyen_cd FOREIGN KEY (MSTuyen) REFERENCES TUYENDUONG(MSTuyen)
);
CREATE TABLE VETAU
(
	MSVe CHAR(5) NOT NULL,
    MSHK CHAR(5) NOT NULL,
    MSChuyen CHAR(5) NOT NULL,
    MSLoai CHAR(5) NOT NULL,
    TGMua DATETIME NOT NULL,
    TGHieuLuc DATETIME NOT NULL,
    TrangThai VARCHAR(50),
    PhuongThuc VARCHAR(50),
    CONSTRAINT PRIMARY KEY (MSVe),
    CONSTRAINT fk_mshk_vt FOREIGN KEY (MSHK) REFERENCES HANHKHACH(MSHK),
    CONSTRAINT fk_mschuyen_vt FOREIGN KEY (MSChuyen) REFERENCES CHUYENDI(MSChuyen),
    CONSTRAINT fk_msloai_vt FOREIGN KEY (MSLoai) REFERENCES LOAIVE(MSLoai)
);
CREATE TABLE DOIBAOTRI
(
	MSDoi CHAR(5) NOT NULL,
    TenDoi VARCHAR(50) NOT NULL,
    SLThanhVien INT,
    CONSTRAINT PRIMARY KEY (MSDoi)
);
CREATE TABLE BT_TAU
(
	MSDoi CHAR(5) NOT NULL,
    MSTau CHAR(5) NOT NULL,
    NgayBD DATE,
    TrangThai VARCHAR(50),
    CONSTRAINT ok_msdoi_mstau_bttau PRIMARY KEY (MSDoi, MSTau),
    CONSTRAINT fk_msdoi_bttau FOREIGN KEY (MSDoi) REFERENCES DOIBAOTRI(MSDoi),
    CONSTRAINT fk_mstau_bttau FOREIGN KEY (MSTau) REFERENCES TAUDIEN(MSTau)
);
CREATE TABLE BT_TUYEN
(
	MSDoi CHAR(5) NOT NULL,
    MSTuyen CHAR(5) NOT NULL,
    NgayBD DATE,
    TrangThai VARCHAR(50),
    CONSTRAINT pk_msdoi_mstuyen_bttuyen PRIMARY KEY (MSDoi, MSTuyen),
    CONSTRAINT fk_msdoi_bttuyen FOREIGN KEY (MSDoi) REFERENCES DOIBAOTRI(MSDoi),
    CONSTRAINT fk_mstuyen_bttuyen FOREIGN KEY (MSTuyen) REFERENCES TUYENDUONG(MSTuyen)
);
CREATE TABLE BT_GA
(
	MSDoi CHAR(5) NOT NULL,
    MSGa CHAR(5) NOT NULL,
    NgayBD DATE,
    TrangThai VARCHAR(50),
    CONSTRAINT pk_msdoi_msga_btg PRIMARY KEY (MSDoi, MSGa),
    CONSTRAINT fk_msdoi_btg FOREIGN KEY (MSDoi) REFERENCES DOIBAOTRI(MSDoi),
    CONSTRAINT fk_msga_btg FOREIGN KEY (MSGa) REFERENCES GATAU(MSGa)
);
CREATE TABLE THOITIET
(
	MSDB CHAR(5) NOT NULL,
    TrangThai VARCHAR(50) NOT NULL,
    TGCapNhat DATETIME NOT NULL,
    CONSTRAINT PRIMARY KEY (MSDB)
);
CREATE TABLE DB_TUYEN
(
	MSDB CHAR(5),
    MSTuyen CHAR(5),
    TGAnhHuong DATE,
    TTAnhHuong VARCHAR(50),
    CONSTRAINT pk_mstuyen_msdb_dbt PRIMARY KEY (MSDB, MSTuyen),
    CONSTRAINT fk_msdb_dbt FOREIGN KEY (MSDB) REFERENCES THOITIET(MSDB),
	CONSTRAINT fk_mstuyen_dbt FOREIGN KEY (MSTuyen) REFERENCES TUYENDUONG(MSTuyen)
);

-- THỦ TỤC LƯU TRỮ
-- VD1: Tạo thủ tục cho biết thông tin các ga tàu mà đội bảo trì đó bảo trì   
DELIMITER //
CREATE PROCEDURE proc_gabaotri (IN tendoi VARCHAR(50))
BEGIN
	SELECT DISTINCT TenGa 
    FROM DOIBAOTRI BT JOIN BT_GA BG ON BT.MSDoi = BG.MSDoi
    JOIN GATAU GT ON GT.MSGa = BG.MSGa
    WHERE BT.TenDoi = tendoi;
END; //
DELIMITER ;
CALL proc_gabaotri ('Đội ga 2');
CALL proc_gabaotri ('Đội ga 4');

-- VD2: Tạo thủ tục cho biết giá vé khi biết thông tin mã số của vé đó  
DELIMITER //
CREATE PROCEDURE proc_laygiave(IN msve CHAR(5))
BEGIN
    DECLARE gia_ve DECIMAL(9,0);
    SELECT L.GiaVe INTO gia_ve
    FROM VETAU V 
    JOIN LOAIVE L ON V.MSLoai = L.MSLoai
    WHERE V.MSVe = msve;
    IF gia_ve IS NULL THEN
        SELECT C.GiaVeLuot INTO gia_ve
        FROM VETAU V 
        JOIN CHUYENDI C ON V.MSChuyen = C.MSChuyen
        WHERE V.MSVe = msve;
    END IF;
    SELECT gia_ve AS GiaVe;
END; //
DELIMITER ;
CALL proc_laygiave('VE017');
CALL proc_laygiave('VE008');

-- VD3: Tạo thủ tục cho biết các thông tin của tàu điện khi biết tên của tàu điện đó  
DELIMITER //
CREATE PROCEDURE proc_thongtin_tdien (IN ten_tau VARCHAR(50))
BEGIN
	SELECT TrangThai, GioKH, GioKT, TenTuyen
    FROM TAUDIEN TDi JOIN TUYENDUONG TDu ON TDi.MSTuyen = TDu.MSTuyen
    WHERE TenTau = ten_tau;
END; //
DELIMITER ;
CALL proc_thongtin_tdien ('Tàu số 1');
CALL proc_thongtin_tdien ('Tàu số 2');
CALL proc_thongtin_tdien ('Tàu số 3');

-- VD4: Tạo thủ tục thêm nhân viên vào đội bảo trì  
DELIMITER //
CREATE PROCEDURE proc_them_nvbaotri (IN p_MSNV CHAR(5), 
									IN p_TenNV VARCHAR(50), 
                                    IN p_GioiTinh VARCHAR(5),
									IN p_DiaChi VARCHAR(50), 
                                    IN p_SoDT VARCHAR(10), 
                                    IN p_MSVT CHAR(5), 
                                    IN p_MSDoi CHAR(5))
BEGIN
	IF EXISTS (SELECT * FROM VAITRO WHERE MSVT = p_MSVT) THEN 
		IF EXISTS (SELECT * FROM DOIBAOTRI WHERE MSDoi = p_MSDoi) THEN
			IF NOT EXISTS (SELECT * FROM NHANVIEN where MSNV = p_MSNV) THEN
				INSERT INTO NHANVIEN VALUES (p_MSNV, p_TenNV, p_GioiTinh, p_DiaChi, 
											p_SoDT, p_MSVT, p_MSDoi);
				UPDATE DOIBAOTRI
                SET SLThanhVien = SLThanhVien + 1
                WHERE MSDoi = p_MSDoi;
			ELSE 
				SELECT 'Đã tồn tại mã số nhân viên' AS ThongBao;
			END IF;
		ELSE 
			SELECT 'Đội bảo trì chưa tồn tại' AS ThongBao;
		END IF;
	ELSE 
		SELECT 'Không tồn tại mã vai trò này' AS ThongBao;
	END IF;
END; //
DELIMITER ;
CALL proc_them_nvbaotri ('NV700', 'Lý Lữ Ca', 'Nam', 'An Giang', '0817839291', 'VT004', 'D0011');
CALL proc_them_nvbaotri ('NV779', 'Lý Lữ Ca', 'Nam', 'An Giang', '0817839291', 'VT009', 'D0011');
CALL proc_them_nvbaotri ('NV700', 'Lý Lữ Ca', 'Nam', 'An Giang', '0817839291', 'VT004', 'D0030');
CALL proc_them_nvbaotri ('NV779', 'Lý Lữ Ca', 'Nam', 'An Giang', '0817839291', 'VT004', 'D0011');

-- VD5: Tạo thủ tục tính tổng tiền vé mà hành khách đã mua khi đi tàu   
DELIMITER //
CREATE PROCEDURE proc_hk_tongve (IN p_MSHK CHAR(5), OUT p_TongTien DECIMAL(9,0))
BEGIN
	DECLARE Tong_Luot DECIMAL(9,0) default 0;
    DECLARE Tong_Khac DECIMAL(9,0) default 0;
    
	IF EXISTS (SELECT * FROM HANHKHACH WHERE MSHK = p_MSHK) THEN
		SELECT sum(GiaVeLuot) INTO Tong_Luot
        FROM VETAU AS V JOIN LOAIVE AS L ON V.MSLoai = L.MSLoai
						JOIN CHUYENDI AS C ON V.MSChuyen = C.MSChuyen
        WHERE V.MSHK = p_MSHK AND V.MSLoai = 'LV001';
        SELECT SUM(Giave) INTO Tong_Khac
        FROM (
				SELECT V.MSLoai, TGMua, GiaVe
                FROM VETAU AS V JOIN LOAIVE AS L ON V.MSLoai = L.MSLoai
				WHERE V.MSHK = p_MSHK AND L.MSLoai IN ('LV002', 'LV003', 'LV004')
			) AS Ve_khac;
            SET p_TongTien = cast(Tong_Luot AS DECIMAL(9,0)) + CAST(Tong_Khac AS DECIMAL(9,0));
    ELSE
    BEGIN
		SET p_TongTien = 0;
		SELECT 'Hành khách không tồn tại' AS ThongBao;
	END;
	END IF;
END; //
DELIMITER ;
CALL proc_hk_tongve ('HK095', @p_TongTien);
SELECT @p_TongTien;
CALL proc_hk_tongve ('HK096', @p_TongTien);


-- LẬP TRÌNH TRIGGER
-- VD1: Tạo Trigger thỏa mãn ràng buộc số điện thoại của hnahf khách phải có đủ 10 số 
DELIMITER //
CREATE TRIGGER trig_kiemtra_sdt
BEFORE INSERT ON HANHKHACH
FOR EACH ROW
BEGIN
	IF LENGTH(NEW.SoDT) != 10 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Số điện thoại không hợp lệ';
	END IF;
END; //
DELIMITER ;
INSERT INTO HANHKHACH VALUES ('HK101', 'Trần', 'Nữ', '031357001268', '09452378111');	
INSERT INTO HANHKHACH VALUES ('HK102', 'Trần', 'Nữ', '031357001269', '094523781');	
INSERT INTO HANHKHACH VALUES ('HK103', 'Trần', 'Nữ', '031357001260', '0945237811');	

-- VD2: Tạo Trigger thỏa mãn điều kiện khi nhập dữ liệu vé tàu, nếu trạng thái vé là null thì sẽ tự động cập nhật “Chưa sử dụng”
DELIMITER //
CREATE TRIGGER trig_trangthaive
BEFORE INSERT ON VETAU
FOR EACH ROW
BEGIN
	IF NEW.TrangThai IS NULL THEN
		SET NEW.TrangThai = 'Chưa sử dụng';
	END IF;
END; //
DELIMITER ;
INSERT INTO VETAU VALUES ('VE141', 'HK095', 'C0057', 'LV005', '2025-03-25 09:12:10', '2025-03-26 09:12:10', null, null);	
INSERT INTO VETAU VALUES ('VE142', 'HK095', 'C0057', 'LV005', '2025-03-26 10:34:20', '2025-03-26 10:34:20', 'Hết hạn', null);	

-- VD3: Tạo Trigger thỏa mãn điều kiện khi thêm một nhân viên bảo trì thì số lượng thành viên của đội mà nhân viên tham gia sẽ tự động thay đổi 
DELIMITER //
CREATE TRIGGER trig_insert_sltv
BEFORE INSERT ON NHANVIEN
FOR EACH ROW
BEGIN
    IF NOT EXISTS (SELECT * FROM NHANVIEN WHERE NEW.MSNV = MSNV) THEN
        IF NEW.MSDoi IS NOT NULL THEN
            UPDATE DOIBAOTRI
            SET SLThanhVien = SLThanhVien + 1
            WHERE MSDoi = NEW.MSDoi;

            IF ROW_COUNT() = 0 THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Lỗi: Đội bảo trì không tồn tại';
            END IF;
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Mã số hành khách đã tồn tại';
    END IF;
END; //
DELIMITER ;
INSERT INTO NHANVIEN VALUES ('NV779', 'Hoang Ha', 'Nam', 'An Giang', '0999585663', 'VT004', 'D0001');	
INSERT INTO NHANVIEN VALUES ('NV780', 'Hoang Ha', 'Nam', 'An Giang', '0999585663', 'VT004', null);	
INSERT INTO NHANVIEN VALUES ('NV781', 'Hoang Ha', 'Nam', 'An Giang', '0999585663', 'VT004', 'D0020');	

-- VD4: Tạo Trigger thỏa mãn điều kiện khi xóa một nhân viên bảo trì thì số lượng thành viên của đội mà nhân viên tham gia sẽ tự động thay đổi 
DELIMITER //
CREATE TRIGGER trig_delete_sltv
BEFORE DELETE ON NHANVIEN
FOR EACH ROW
BEGIN
    IF EXISTS (SELECT * FROM NHANVIEN WHERE OLD.MSNV = MSNV) THEN
        IF OLD.MSDoi IS NOT NULL THEN
            UPDATE DOIBAOTRI
            SET SLThanhVien = SLThanhVien - 1
            WHERE MSDoi = OLD.MSDoi;

            IF ROW_COUNT() = 0 THEN
                SIGNAL SQLSTATE '45000'
                SET MESSAGE_TEXT = 'Lỗi: Đội bảo trì không tồn tại';
            END IF;
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Mã số hành khách chưa tồn tại';
    END IF;
END; //
DELIMITER ;
DELETE FROM NHANVIEN WHERE MSNV = 'NV779';

-- VD5: Tạo Trigger thỏa mãn ràng buộc khi mua vé, thời gian hiệu lực phải lớn hơn thời gian mua
DELIMITER //
CREATE TRIGGER trig_ktra_tgian 
BEFORE INSERT ON VETAU
FOR EACH ROW
BEGIN
	IF NOT EXISTS (SELECT * FROM VETAU WHERE MSVe = NEW.MSVe) THEN
		IF (NEW.TGHieuLuc <= NEW.TGMua) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Lỗi: Thời gian mua lớn hơn thời gian hiệu lực';
		END IF;
        ELSE
        SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Lỗi: Mã vé đã tồn tại';
	END IF;
END; //
DELIMITER ;
INSERT INTO VETAU VALUES ('VE150', 'HK095', 'C0039', 'LV001', '2025-04-14 15:24:43', '2025-04-13 15:24:43', 'Chưa sử dụng', 'Ví điện tử');	
INSERT INTO VETAU VALUES ('VE149', 'HK095', 'C0039', 'LV001', '2025-03-06 09:06:10', '2025-03-07 09:06:10', 'Chưa sử dụng', 'Ví điện tử');	
INSERT INTO VETAU VALUES ('VE150', 'HK095', 'C0039', 'LV001', '2025-03-06 09:06:10', '2025-03-07 09:06:10', 'Chưa sử dụng', 'Ví điện tử');	

-- VD6: Tạo Trigger thỏa mãn ràng buộc không được thêm bảo trì với tình trạng ‘Hoàn thành’ khi dữ liệu bảo trì của tàu với tình trạng chưa bắt đầu
DELIMITER //
CREATE TRIGGER trig_insert_bttau
BEFORE INSERT ON BT_TAU
FOR EACH ROW
BEGIN
    DECLARE tt_cuoi VARCHAR(50);
    SELECT TrangThai
    INTO tt_cuoi
    FROM BT_TAU
    WHERE NEW.MSTau = MSTau
    ORDER BY NgayBD DESC
    LIMIT 1;
    IF (tt_cuoi = 'Chưa bắt đầu') THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Đội bảo trì vẫn chưa bắt đầu';    
    END IF;
END; //
DELIMITER ;
INSERT INTO BT_TAU VALUES ('D0010', 'T0009', '2025-06-09', 'Hoàn thành');	

-- VD7: Tạo Trigger thỏa mãn điều kiện số lượng nhân viên của mỗi tàu ít nhất phải 3 người
DELIMITER //
CREATE TRIGGER trig_nv_tau
BEFORE DELETE ON NV_TAUDIEN
FOR EACH ROW
BEGIN
    IF (SELECT COUNT(*) FROM NV_TAUDIEN WHERE MSTau = OLD.MSTau) < 4 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Thiếu nhân viên';    
    END IF;
END; //
DELIMITER ;
DELETE FROM NV_TAUDIEN WHERE MSNV = 'NV014' AND MSTau = 'T0004';

-- VD8: Tạo Trigger thỏa mãn điều kiện khi xóa một hành khách thì sẽ xóa toàn bộ thông tin hành khách đó
DELIMITER //
CREATE TRIGGER trig_xoa_hk
BEFORE  DELETE ON HANHKHACH
FOR EACH ROW
BEGIN
	DELETE FROM VETAU WHERE MSHK = OLD.MSHK;
END; //
DELIMITER ;
DELETE FROM HANHKHACH WHERE MSHK = 'HK020';

-- VD9: Tạo Trigger thỏa mãn điều kiện khi thêm một hành khách mới thì thông tin hành khách không được trùng với thông tin hành khách trước
DELIMITER //
CREATE TRIGGER trig_ktthem_hk
BEFORE INSERT ON HANHKHACH
FOR EACH ROW
BEGIN
    DECLARE cccd_count INT;
    SELECT COUNT(*) INTO cccd_count
    FROM HANHKHACH
    WHERE CCCD = NEW.CCCD AND CCCD IS NOT NULL;
    IF cccd_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Hành khách với CCCD này đã tồn tại';
    END IF;
END; //
DELIMITER ;
INSERT INTO HANHKHACH VALUES ('HK150', 'Trần Thị Yến', 'Nữ', '079394174538', '0945237825');

-- VD10: Tạo Trigger thỏa mãn điều kiện một nhân viên chỉ có thể thuộc 1 đội bảo trì
DELIMITER //
CREATE TRIGGER trig_before_insert_nhanvien
BEFORE INSERT ON NHANVIEN
FOR EACH ROW
BEGIN
    DECLARE doi_count INT;
    SELECT COUNT(*) INTO doi_count FROM NHANVIEN
    WHERE MSNV = NEW.MSNV
    AND MSDoi IS NOT NULL
    AND MSDoi != NEW.MSDoi;
    IF doi_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nhân viên đã thuộc một đội bảo trì khác';
    END IF;
    IF NEW.MSDoi IS NOT NULL THEN
        SELECT COUNT(*) INTO doi_count
        FROM DOIBAOTRI
        WHERE MSDoi = NEW.MSDoi;
        IF doi_count = 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Mã đội bảo trì không tồn tại trong bảng DOIBAOTRI.';
        END IF;
    END IF;
END; //
DELIMITER ;
INSERT INTO NHANVIEN VALUES ('NV004', 'Vũ Đức Anh', 'Nam', 'HCM', '0834677812', 'VT004', 'D0004');

-- LẬP TRÌNH HÀM
-- VD1: Hàm đếm số lượng nhân viên trong một vai trò cụ thể
DELIMITER //
CREATE FUNCTION func_slnv_vaitro(maVaiTro CHAR(5)) 
RETURNS INT
READS SQL DATA
BEGIN
    DECLARE soLuong INT;
    SELECT COUNT(*) INTO soLuong
    FROM NHANVIEN
    WHERE MSVT = maVaiTro;
    RETURN soLuong;
END; //
DELIMITER ;
SELECT func_slnv_vaitro('VT001');
SELECT func_slnv_vaitro('VT004');

-- VD2: Hàm trả về các thông tin của tuyến đường
DELIMITER //
CREATE FUNCTION func_thongtin_tduong(tentuyen VARCHAR(50))
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE ketqua TEXT;
    DECLARE ten_tuyen VARCHAR(50);
    DECLARE chieudai FLOAT;
    DECLARE slga INT;
    DECLARE ga_bd VARCHAR(10);
    DECLARE ga_kt VARCHAR(10);
    DECLARE trangthai VARCHAR(50);
    SELECT TD.ChieuDai, TD.SLGa, TD.GaBD, TD.GaKT, TD.MSTuyen
    INTO chieudai, slga, ga_bd, ga_kt, ten_tuyen FROM TUYENDUONG TD WHERE TD.TenTuyen = tentuyen;
    SELECT T1.TTAnhHuong INTO trangthai FROM DB_TUYEN T1 WHERE T1.MSTuyen = ten_tuyen
    ORDER BY STR_TO_DATE(T1.TGAnhHuong, '%Y-%m-%d') DESC
    LIMIT 1;
    SET ketqua = CONCAT(
        'Chiều dài tuyến: ', chieudai, ' km\n',
        'Số lượng ga: ', slga, '\n',
        'Trạng thái hiện tại: ', IFNULL(trangthai, 'Không có dữ liệu'), '\n',
        'Ga bắt đầu: ', ga_bd, ' -> Ga kết thúc: ', ga_kt );
    RETURN ketqua;
END; //
DELIMITER ;
SELECT func_thongtin_tduong('Tuyến 1') AS 'Thông tin tuyến đường';

-- VD3: Hàm trả về tên các ga chung của hai tuyến đường
DELIMITER //
CREATE FUNCTION func_gachung_haituyen(tentuyen1 VARCHAR(50), tentuyen2 VARCHAR(50))
RETURNS TEXT
DETERMINISTIC
BEGIN
    DECLARE ketqua TEXT;
    SELECT IFNULL(GROUP_CONCAT(DISTINCT GT.TenGa ORDER BY G1.ThuTu SEPARATOR ', '), 'Không có')
    INTO ketqua
    FROM GATAU GT JOIN GADIQUA G1 ON GT.MSGa = G1.MSGa
    JOIN TUYENDUONG T1 ON G1.MSTuyen = T1.MSTuyen
    JOIN GADIQUA G2 ON GT.MSGa = G2.MSGa
    JOIN TUYENDUONG T2 ON G2.MSTuyen = T2.MSTuyen
    WHERE T1.TenTuyen = tentuyen1 AND T2.TenTuyen = tentuyen2;
    RETURN ketqua;
END; //
DELIMITER ;
SELECT func_gachung_haituyen('Tuyến 1', 'Tuyến 2') AS 'Các ga chung'

-- VD4: Hàm trả về thông tin của ga tàu khi biết tên của ga tàu đó
DELIMITER //
CREATE FUNCTION func_thongtin_ga(TenGa VARCHAR(50))
RETURNS TEXT
DETERMINISTIC
BEGIN
	DECLARE ketqua TEXT;
    SELECT IFNULL(CONCAT (
		'Địa chỉ: ', GT.DiaChi , '\n',
        'Thuộc tuyến đường: ', GROUP_CONCAT(DISTINCT TD.TenTuyen SEPARATOR ', ')
		), 'Không có'
        )
    INTO ketqua
    FROM TUYENDUONG TD JOIN GADIQUA G ON TD.MSTuyen = G.MSTuyen
    JOIN GATAU GT ON GT.MSGa = G.MSGa
    WHERE GT.TenGa = tenga
    GROUP BY GT.MSGa, GT.TenGa;
    RETURN ketqua;
END; //
DELIMITER ;
SELECT func_thongtin_ga('Bến Thành') AS 'Thông tin ga';

-- LẬP TRÌNH VIEW
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
