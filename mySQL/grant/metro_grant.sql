CREATE DATABASE QLMETRO;
USE QLMETRO;

-- 1. PHÂN USER VÀO ROLE 

-- Đối tượng quản lý ga 
GRANT 'qly_ga'@'localhost' TO 'qly_ga01'@'localhost';
GRANT 'qly_ga'@'localhost' TO 'qly_ga02'@'localhost';
GRANT 'qly_ga'@'localhost' TO 'qly_ga03'@'localhost';

-- Đối tượng nhân viên vé 
GRANT 'nv_ve'@'localhost' TO 'nv_ve01'@'localhost';
GRANT 'nv_ve'@'localhost' TO 'nv_ve02'@'localhost';
GRANT 'nv_ve'@'localhost' TO 'nv_ve03'@'localhost';

-- Đối tượng nhân viên bảo trì 
GRANT 'nv_baotri'@'localhost' TO 'nv_baotri01'@'localhost';
GRANT 'nv_baotri'@'localhost' TO 'nv_baotri02'@'localhost';
GRANT 'nv_baotri'@'localhost' TO 'nv_baotri03'@'localhost';

-- Đối tượng hành khách 
GRANT 'hk'@'localhost' TO 'hk01'@'localhost';
GRANT 'hk'@'localhost' TO 'hk02'@'localhost';
GRANT 'hk'@'localhost' TO 'hk03'@'localhost';

-- 2. CẤP QUYỀN CHO CÁC ĐỐI TƯỢNG 
SET DEFAULT ROLE 'qly_ga'@'localhost' TO 'qly_ga01'@'localhost';
SET DEFAULT ROLE 'qly_ga'@'localhost' TO 'qly_ga02'@'localhost';
SET DEFAULT ROLE 'qly_ga'@'localhost' TO 'qly_ga03'@'localhost';

-- Đối tượng nhân viên 
GRANT INSERT, DELETE, ALTER, UPDATE, SELECT
ON METRO.NHANVIEN
TO 'qly_ga'@'localhost';

-- Đối tượng hành khách 
GRANT SELECT
ON METRO.HANHKHACH
TO 'qly_ga'@'localhost';

--3. THU HỒI QUYỀN ĐÃ CẤP 
REVOKE INSERT, DELETE, ALTER, UPDATE
ON METRO.NHANVIEN
FROM 'qly_ga'@'localhost';

SHOW GRANTS FOR 'qly_ga01'@'localhost' USING 'qly_ga'@'localhost';