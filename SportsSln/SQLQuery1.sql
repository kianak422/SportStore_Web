-- =======================================================
-- 0. TẠO DATABASE
-- =======================================================
IF DB_ID('SportsStoreDb') IS NOT NULL
    DROP DATABASE SportsStoreDb;
GO

CREATE DATABASE SportsStoreDb;
GO

USE SportsStoreDb;
GO

-- =======================================================
-- 1. BẢNG DANH MỤC (Categories)
-- =======================================================
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL
);
GO

-- =======================================================
-- 2. BẢNG SẢN PHẨM (Products)
-- =======================================================
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX),
    Price DECIMAL(18,2) NOT NULL,
    CategoryID INT NOT NULL,
    ImageUrl NVARCHAR(255),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);
GO

-- =======================================================
-- 3. BẢNG ĐƠN HÀNG (Orders)
-- =======================================================
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Line1 NVARCHAR(100) NOT NULL,
    Line2 NVARCHAR(100) NULL,
    Line3 NVARCHAR(100) NULL,
    City NVARCHAR(50) NOT NULL,
    State NVARCHAR(50) NULL,
    Zip NVARCHAR(20) NULL,
    Country NVARCHAR(50) NOT NULL,
    GiftWrap BIT DEFAULT 0,
    Shipped BIT DEFAULT 0,
    OrderDate DATETIME DEFAULT GETDATE()
);
GO

-- =======================================================
-- 4. BẢNG CHI TIẾT ĐƠN HÀNG (OrderLines)
-- =======================================================
CREATE TABLE OrderLines (
    OrderLineID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);
GO

-- =======================================================
-- 5. BẢNG QUẢN TRỊ (AdminUser)
-- =======================================================
CREATE TABLE AdminUser (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    UserName NVARCHAR(50) NOT NULL UNIQUE,
    RoleUser NVARCHAR(50),
    PasswordUser NVARCHAR(100) NOT NULL
);
GO

-- =======================================================
-- 6. DỮ LIỆU MẪU (SEED DATA)
-- =======================================================

-- Danh mục
INSERT INTO Categories (Name) VALUES 
(N'Thể thao'), (N'Thời trang'), (N'Phụ kiện');

-- Sản phẩm
INSERT INTO Products (Name, Description, Price, CategoryID, ImageUrl) VALUES
(N'Áo thể thao', N'Áo thể thao thấm hút mồ hôi', 250000, 1, 'images/ao.jpg'),
(N'Giày chạy bộ', N'Giày chạy bộ cao cấp', 900000, 1, 'images/giay.jpg'),
(N'Nón thời trang', N'Nón lưỡi trai trẻ trung', 150000, 2, 'images/non.jpg'),
(N'Bình nước thể thao', N'Dung tích 1L, giữ nhiệt tốt', 120000, 3, 'images/binhnuoc.jpg');

-- Tài khoản Admin mặc định
INSERT INTO AdminUser (UserName, RoleUser, PasswordUser)
VALUES (N'admin', N'Administrator', N'123');
GO
