CREATE DATABASE QLMETRO;
USE QLMETRO;

--  TẠO USER VÀ ROLE 

-- Đối tượng quản trị viên 
CREATE USER 'qtv'@'localhost' IDENTIFIED BY 'quantrivien';

-- Đối tượng quản lý ga 
CREATE ROLE 'qly_ga'@'localhost';
CREATE USER 'qly_ga01'@'localhost' IDENTIFIED BY 'qlyga01';
CREATE USER 'qly_ga02'@'localhost' IDENTIFIED BY 'qlyga02';
CREATE USER 'qly_ga03'@'localhost' IDENTIFIED BY 'qlyga03';

-- Đối tượng nhân viên vé 
CREATE ROLE 'nv_ve'@'localhost';
CREATE USER 'nv_ve01'@'localhost' IDENTIFIED BY 'nvve01';
CREATE USER 'nv_ve02'@'localhost' IDENTIFIED BY 'nvve02';
CREATE USER 'nv_ve03'@'localhost' IDENTIFIED BY 'nvve03';

-- Đối tượng nhân viên bảo trì 
CREATE ROLE 'nv_baotri'@'localhost';
CREATE USER 'nv_baotri01'@'localhost' IDENTIFIED BY 'nvbaotri01';
CREATE USER 'nv_baotri02'@'localhost' IDENTIFIED BY 'nvbaotri02';
CREATE USER 'nv_baotri03'@'localhost' IDENTIFIED BY 'nvbaotri03';

-- Đối tượng hành khách 
CREATE ROLE 'hk'@'localhost';
CREATE USER 'hk01'@'localhost' IDENTIFIED BY 'hk01';
CREATE USER 'hk02'@'localhost' IDENTIFIED BY 'hk02';
CREATE USER 'hk03'@'localhost' IDENTIFIED BY 'hk03';