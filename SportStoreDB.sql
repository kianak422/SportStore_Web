USE master;
GO


IF DB_ID('SportStoreDB') IS NOT NULL
BEGIN
    ALTER DATABASE SportStoreDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE SportStoreDB;
END
GO


CREATE DATABASE SportStoreDB;
GO

USE SportStoreDB;
GO

CREATE TABLE [dbo].[__EFMigrationsHistory] (
    [MigrationId]    NVARCHAR (150) NOT NULL,
    [ProductVersion] NVARCHAR (32)  NOT NULL,
    CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED ([MigrationId] ASC)
);
GO


CREATE TABLE [dbo].[Categories] (
    [CategoryID] BIGINT         IDENTITY (1, 1) NOT NULL,
    [Name]       NVARCHAR (100) NOT NULL,
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryID] ASC)
);
GO

CREATE TABLE [dbo].[Products] (
    [ProductID]   BIGINT          IDENTITY (1, 1) NOT NULL,
    [Name]        NVARCHAR (MAX)  NOT NULL,
    [Description] NVARCHAR (MAX)  NOT NULL,
    [Price]       DECIMAL (18, 2) NOT NULL,
    [ImageUrl]    NVARCHAR (MAX)  NULL,
    [CategoryID]  BIGINT          DEFAULT (CONVERT([bigint],(0))) NOT NULL,
    CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [FK_Products_Categories_CategoryID]
        FOREIGN KEY ([CategoryID]) REFERENCES [dbo].[Categories] ([CategoryID])
        ON DELETE CASCADE
);
GO

CREATE NONCLUSTERED INDEX [IX_Products_CategoryID]
    ON [dbo].[Products]([CategoryID] ASC);
GO

CREATE TABLE [dbo].[Orders] (
    [OrderID]        INT             IDENTITY (1, 1) NOT NULL,
    [Name]           NVARCHAR (100)  NOT NULL,
    [City]           NVARCHAR (50)   NULL,
    [Shipped]        BIT             DEFAULT (CONVERT([bit],(0))) NOT NULL,
    [AddressDetail]  NVARCHAR (200)  NULL,
    [CreatedDate]    DATETIME2 (7)   DEFAULT ('0001-01-01T00:00:00.0000000') NOT NULL,
    [DeliveryType]   NVARCHAR (20)   NULL,
    [District]       NVARCHAR (50)   NULL,
    [DistrictPickup] NVARCHAR (50)   NULL,
    [Email]          NVARCHAR (100)  DEFAULT (N'') NOT NULL,
    [Note]           NVARCHAR (500)  NULL,
    [Payment]        NVARCHAR (20)   NULL,
    [Phone]          NVARCHAR (20)   DEFAULT (N'') NOT NULL,
    [Province]       NVARCHAR (50)   NULL,
    [Store]          NVARCHAR (100)  NULL,
    [TotalPrice]     DECIMAL (18, 2) DEFAULT ((0.0)) NOT NULL,
    [Ward]           NVARCHAR (50)   NULL,
    [UserID]         NVARCHAR (MAX)  NULL,
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID] ASC)
);
GO

CREATE TABLE [dbo].[CartLines] (
    [CartLineID] INT             IDENTITY (1, 1) NOT NULL,
    [ProductID]  BIGINT          NOT NULL,
    [Quantity]   INT             NOT NULL,
    [OrderID]    INT             NULL,
    [OrderID1]   INT             NULL,
    [Price]      DECIMAL (18, 2) DEFAULT ((0.0)) NOT NULL,
    CONSTRAINT [PK_CartLines] PRIMARY KEY CLUSTERED ([CartLineID] ASC),
    CONSTRAINT [FK_CartLines_Orders_OrderID]
        FOREIGN KEY ([OrderID]) REFERENCES [dbo].[Orders] ([OrderID]) ON DELETE CASCADE,
    CONSTRAINT [FK_CartLines_Orders_OrderID1]
        FOREIGN KEY ([OrderID1]) REFERENCES [dbo].[Orders] ([OrderID]),
    CONSTRAINT [FK_CartLines_Products_ProductID]
        FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);
GO

CREATE NONCLUSTERED INDEX [IX_CartLines_OrderID]
    ON [dbo].[CartLines]([OrderID] ASC);
GO

CREATE NONCLUSTERED INDEX [IX_CartLines_ProductID]
    ON [dbo].[CartLines]([ProductID] ASC);
GO

CREATE NONCLUSTERED INDEX [IX_CartLines_OrderID1]
    ON [dbo].[CartLines]([OrderID1] ASC);
GO

INSERT INTO Categories (Name)
VALUES (N'Đồng hồ'), (N'Trang sức'), (N'Vòng tay');
GO

INSERT INTO Products (Name, Description, Price, ImageUrl, CategoryID)
VALUES 
(N'Đồng hồ Citizen', N'Đồng hồ Nhật chính hãng', 2500000, N'/images/citizen.jpg', 1),
(N'Nhẫn vàng 18K', N'Nhẫn nữ tinh tế sang trọng', 3500000, N'/images/ring.jpg', 2),
(N'Vòng tay phong thủy', N'Vòng đá mã não', 1800000, N'/images/bracelet.jpg', 3);
GO

PRINT '✅ Database SportStoreDB đã được tạo thành công!';
GO
