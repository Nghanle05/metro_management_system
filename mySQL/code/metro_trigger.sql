CREATE DATABASE QLMETRO;
USE QLMETRO;

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