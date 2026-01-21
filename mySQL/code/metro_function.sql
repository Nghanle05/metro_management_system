CREATE DATABASE QLMETRO;
USE QLMETRO;

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