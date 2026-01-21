CREATE DATABASE QLMETRO;
USE QLMETRO;

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