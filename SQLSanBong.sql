﻿CREATE DATABASE QUANLYSANBONG
GO

USE QUANLYSANBONG
GO


CREATE TABLE NHANVIEN(
	IDNHANVIEN NCHAR(10) PRIMARY KEY,
	HOTENNHANVIEN NVARCHAR(100),
	GIOTINH NVARCHAR(10),
	DIACHI NVARCHAR(100),
	EMAIL NVARCHAR(100),
	SDT NVARCHAR(12),
	USERNAME NCHAR(100),
	PASS NCHAR(100)
)

CREATE TABLE KHACHHANG(
	IDKHACHHANG NCHAR(10) PRIMARY KEY,
	HOTENKHACHHANG NVARCHAR(50) NOT NULL,
	NGAYSINH DATE NOT NULL,
	GIOITINH NVARCHAR(10),
	SDT NVARCHAR(12),
	DIACHI NVARCHAR(100)
)

CREATE TABLE PHIEUDATSAN(
	IDPHIEUDATSAN NCHAR(10) PRIMARY KEY,
	IDKHACHHANG NCHAR(10),
	IDSAN NCHAR(10),
	CHECKIN DATE,
	CHECKOUT DATE,
)

CREATE TABLE SAN(
	IDSAN NCHAR(10) PRIMARY KEY,
	IDLOAISAN NCHAR(10),
	TENSAN NVARCHAR(20),
	TRANGTHAI NVARCHAR(50),
	
)

CREATE TABLE LOAISAN(
	IDLOAISAN NCHAR(10) PRIMARY KEY,
	TENLOAIAN NVARCHAR(20),
	DONGIA FLOAT
)

CREATE TABLE HOADON(
	IDHOADON NCHAR(10) PRIMARY KEY,
	IDKHACHHANG NCHAR(10),
	IDPHIEUDATSAN NCHAR(10),
	IDNHANVIEN NCHAR(10),
	NGAYLAPHOADON VARCHAR(50),
	TRANGTHAIHD NVARCHAR(20),
	TONGTIEN FLOAT
)
ALTER TABLE PHIEUDATSAN
ADD CONSTRAINT FK_IDKHACHHANG_PHIEUDATSAN FOREIGN KEY(IDKHACHHANG)
REFERENCES KHACHHANG(IDKHACHHANG)

ALTER TABLE SAN
ADD CONSTRAINT FK_IDLOAISAN_SAN FOREIGN KEY(IDLOAISAN)
REFERENCES LOAISAN(IDLOAISAN)

ALTER TABLE HOADON
ADD CONSTRAINT FK_IDPHIEUDATSAN_HOADON FOREIGN KEY(IDPHIEUDATSAN)
REFERENCES PHIEUDATSAN(IDPHIEUDATSAN)

ALTER TABLE HOADON
ADD CONSTRAINT FK_IDNHANVIEN_HOADON FOREIGN KEY(IDNHANVIEN)
REFERENCES NHANVIEN(IDNHANVIEN)

ALTER TABLE HOADON
ADD CONSTRAINT FK_IDKHACHHANG_HOADON FOREIGN KEY(IDKHACHHANG)
REFERENCES KHACHHANG(IDKHACHHANG)
--INSERT DỮ LIỆU---------------------------------------------------
INSERT INTO NHANVIEN VALUES('NV01', N'CHICUONG', 'NAM', 'TP.HCM', 'CUONG@email', '0123456789', 'CUONG', '123')
INSERT INTO NHANVIEN VALUES('NV02', N'ANLE', 'NAM', 'TP.HCM', 'AN@email', '0123456789', 'An', '123')
SELECT * FROM NHANVIEN
DELETE FROM NHANVIEN

SET DATEFORMAT DMY
INSERT INTO KHACHHANG VALUES('KH01', N'Phan Chí Cường', '24-12-2002', 'Nam',01234567, N'123 Lê Lợi, HCM')
SET DATEFORMAT DMY
INSERT INTO KHACHHANG VALUES('KH02', N'Mai Ngọc Khang', '25-12-2002', 'Nam',01234567, N'123 Lê Lợi, HCM')
SET DATEFORMAT DMY
INSERT INTO KHACHHANG VALUES('KH03', N'Lê Thành An', '26-12-2002', 'Nam',01234567, N'123 Lê Lợi, HCM')
SET DATEFORMAT DMY
INSERT INTO KHACHHANG VALUES('KH04', N'Huỳnh Gia Thuận', '27-12-2002', 'Nam',01234567, N'123 Lê Lợi, HCM')
SELECT * FROM KHACHHANG

INSERT INTO LOAISAN VALUES('LP01', N'SÂN 5', 150000)
INSERT INTO LOAISAN VALUES('LP02', N'SÂN 7', 200000)
INSERT INTO LOAISAN VALUES('LP03', N'SÂN 11', 400000)
SELECT * FROM LOAISAN

INSERT INTO SAN VALUES('S01', 'LP01', N'SÂN 101', N'Trống')
INSERT INTO SAN VALUES('S02', 'LP01', N'SÂN 102', N'Trống')
INSERT INTO SAN VALUES('S03', 'LP01', N'SÂN 103', N'Trống')
INSERT INTO SAN VALUES('S04', 'LP01', N'SÂN 104', N'Trống')

INSERT INTO SAN VALUES('P05', 'LP02', N'SÂN 105', N'Trống')
INSERT INTO SAN VALUES('P06', 'LP02', N'SÂN 106', N'Trống')
INSERT INTO SAN VALUES('P07', 'LP02', N'SÂN 107', N'Trống')
INSERT INTO SAN VALUES('P08', 'LP02', N'SÂN 108', N'Trống')

INSERT INTO SAN VALUES('P09', 'LP03', N'SÂN 109', N'Trống')
INSERT INTO SAN VALUES('P10', 'LP03', N'SÂN 110', N'Trống')
INSERT INTO SAN VALUES('P11', 'LP03', N'SÂN 111', N'Trống')
INSERT INTO SAN VALUES('P12', 'LP03', N'SÂN 112', N'Trống')
SELECT * FROM SAN

INSERT INTO PHIEUDATSAN VALUES('PH01','KH01', 'S01', '08-12-2022','12-12-2022')
INSERT INTO PHIEUDATSAN VALUES('PH02','KH02', 'S02', '04-12-2022','8-1-2022')

SELECT * FROM PHIEUDATSAN

DROP PROC TimKiemKhachHang
---------------------------
CREATE PROC TimKiemKhachHang
	 @TenKhachHang NVARCHAR(100)
AS
BEGIN
	SELECT *FROM KHACHHANG
	Where HOTENKHACHHANG LIKE '%' + @TenKhachHang + '%'
END 
EXEC TimKiemKhachHang @TenKhachHang = N'Cuong'
----------------------------
CREATE PROC XoaKhachHang @idkhachhang NVARCHAR(100)
AS
DELETE KHACHHANG WHERE IDKHACHHANG = @idkhachhang
EXEC XoaKhachHang @idkhachhang = 'KH08'
SELECT * FROM KHACHHANG
-----------------
DROP PROC TraSan
CREATE PROC TraSan
  @IDPHIEUDATSAN NVARCHAR(100),
  @CHECKOUT DATE
AS
BEGIN
 -- Cập nhật trạng thái đặt sân thành đã trả sân
   UPDATE PhieuDatSan
    SET CHECKIN = 'DaTraSan', CHECKOUT = @CheckOut
    WHERE IdPhieuDatSan = @IdPhieuDatSan
	-- Thực hiện các công việc khác sau khi trả sân (nếu cần)
    -- In thông báo hoặc trả về kết quả tương ứng
	    SELECT 'Sân đã được trả thành công' AS Result
END
CREATE PROC TimKiemPhieuDatSan @idphieu VARCHAR(100)
AS
SELECT * FROM PHIEUDATSAN	
WHERE IDPHIEUDATSAN = @idphieu
EXEC TimKiemPhieuDatSan @idphieu = 'PH01'
---------------
CREATE PROC CapNhatTinhTrangSan @idSan NVARCHAR(100)
AS
UPDATE SAN
SET TRANGTHAI = N'Trống' 
WHERE IDSAN = @idSan
EXEC CapNhatTinhTrangSan @idSan = ''
---------------
CREATE PROC CapNhatSanDaDat @idSan NVARCHAR(100)
AS
UPDATE SAN
SET TRANGTHAI = N'Có Khách' 
WHERE IDSAN = @idSan
EXEC CapNhatSANDaDat @idSAN = ''

CREATE PROC UpdateKhachHang
	@IDKHACHHANG NVARCHAR(100),
	@HOTENKHACHHANG NVARCHAR(50),
	@NGAYSINH DATE,
	@GIOITINH NVARCHAR(10),
	@SDT NVARCHAR(12),
	@DIACHI NVARCHAR(100)
AS
BEGIN
	-- Cập nhật thông tin khách hàng
	 UPDATE KhachHang
    SET HOTENKHACHHANG  = @HOTENKHACHHANG,
        DIACHI = @DiaChi,
        SDT = @SDT
    WHERE IdKhachHang = @IdKhachHang
	  -- Trả về kết quả hoặc thông báo tùy ý
    SELECT 'Thông tin khách hàng đã được cập nhật' AS Result
END
---------------
CREATE PROCEDURE nhap_kt_khachhang @IDKHACHHANG NCHAR(10),@HOTENKHACHHANG  NVARCHAR(50),@NGAYSINH  DATE,@GIOITINH NVARCHAR(10),@SDT NVARCHAR(12),@DIACHI NVARCHAR(100)
AS
BEGIN 
	 -- Kiểm tra xem khách hàng có tồn tại trong cơ sở dữ liệu hay chưa
    IF NOT EXISTS (SELECT 1 FROM KhachHang WHERE IDKhachHang = @IDKHACHHANG)
    BEGIN
        -- Thêm thông tin khách hàng mới nếu chưa tồn tại
        INSERT INTO KhachHang (IDKhachHang, HoTenKhachHang, NgaySinh, GioiTinh, SDT,DiaChi)
        VALUES (@IDKHACHHANG, @HOTENKHACHHANG, @NGAYSINH, @GIOITINH, @SDT, @DIACHI)
        
        -- Trả về kết quả hoặc thông báo tùy ý
        SELECT 'Thông tin khách hàng đã được thêm mới' AS Result
    END
    ELSE
    BEGIN
        -- Trả về thông báo nếu khách hàng đã tồn tại
        SELECT 'Khách hàng đã tồn tại trong cơ sở dữ liệu' AS Result
    END
END
---------------



---------------------------------------------------------------------






