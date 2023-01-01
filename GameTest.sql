create database QLGAME
use QLGAME
Go
/*Tạo Game*/
set ansi_nulls on
go
create table [dbo].[game](
[ProductID] [int] identity(1,1) not null,
[Game_Type] [int] null,
[Name] [nvarchar](250) null,
[Price] [float] null,
[Game_Img] [nvarchar](250) null,
[Rating] [float] null,
[Description] [nvarchar](max) null,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/* Tao ten loai game */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[loaigame](
	[Game_Type] [int] IDENTITY(1,1) NOT NULL,
	[Type_Name] [nvarchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[Game_Type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/* Tao nguoi dung*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](500) NULL,
	[Phone] [nvarchar](10) NULL,
	[PassWord] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
 CONSTRAINT [PK_NguoiDung] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/* */
/*Test dang nhap*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[Login](@usrname nvarchar(100),@pwd nvarchar(100))
 as
 select * from Account where UserName=@usrname and PassWord=@pwd
GO
/* Lay list loai game tu csdl*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GameList]
as
select * from loaigame
GO
/* Lay game theo cac the loai*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[LayGameTheoLoai](@maloai int)
as
select [ProductID]
      ,[Game_Type]
      ,[Name]
      ,[Price] as GiaBan
      ,'http://172.29.176.1/WebAPIQLBHN11/images/'+[Game_Img] as hinh
      ,[Description] from game
where Game_Type=@maloai
GO
/* */