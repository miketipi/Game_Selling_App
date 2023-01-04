create database QLGAME
use QLGAME
Go
CREATE TYPE [dbo].[Cart] AS TABLE(
	[Product_ID] [real] NULL,
	[Price] [real] NULL,
	[Total] [real] NULL
)
GO
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
[Status] [bit] null,
[Platform] [nvarchar](50),
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
	[Game_Type] [int] IDENTITY(1,1) not null,
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
	[UserID] [int] IDENTITY(1,1) not null,
	[UserName] [nvarchar](500) NULL,
	[RealName] [nvarchar](500) null,
	[Phone] [nvarchar](10) NULL,
	[PWD] [nvarchar](100) NULL,
	[Email] [nvarchar](100) NULL,
 CONSTRAINT [PK_NguoiDung] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/*Tạo CT DonHang */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTDonHang](
	[Ma_CTDH] [int] IDENTITY(1,1) not null,
	[Ma_DH] [int] NULL,
	[ProductID] [int] NULL,
	[So_Luong] [int] NULL,
	[Price] [real] NULL,
	[Total] [real] NULL,
 CONSTRAINT [PK_CTDonHang] PRIMARY KEY CLUSTERED 
(
	[Ma_CTDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/* Đơn hàng */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Don_Hang](
	[SoDH] [int] IDENTITY(1,1) not null,
	[UserID] [int] NULL,
	[Ngay_Mua] [datetime] NULL,
	[Tinh_Trang_Don_Hang] [bit] NULL,
 CONSTRAINT [PK_Don_Hang] PRIMARY KEY CLUSTERED 
(
	[SoDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] 
GO
/*Test dang nhap*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create proc [dbo].[Login](@usrname nvarchar(100),@pwd nvarchar(100))
 as
 select * from Account where UserName=@usrname and PWD=@pwd
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
/* Lay tat ca game tu CSDL*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[LoadGame]
as
select * from game
GO
/****** Object:  StoredProcedure [dbo].[AddUser]  */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[AddUser](@realname nvarchar(500),@usrname nvarchar(100),@pwd nvarchar(100),@email nvarchar(100),@CurrentID int output)
as
if(exists(select * from Account where UserName=@usrname or Email=@Email))
 begin
 set @CurrentID=-1
 return
 end
 insert into Account(RealName,UserName,PWD,Email) values(@realname,@usrname,@pwd,@Email)
 set @CurrentID=@@IDENTITY
GO
<<<<<<< HEAD
SET IDENTITY_INSERT game ON;
Go
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1000','1','Left 4 dead 2','120000','','3.5',N'là một trò chơi bắn súng góc nhìn thứ nhất','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1001','1','Counter-strike Global Offensive',N'350000','','4.5',N'là một trò chơi bắn súng fps','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1002','2','Risk of rain 2','180000','','4.0',N'bắn súng góc nhìn thứ ba giống người thật được phát triển bởi Hopoo Games','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1003','3','GTA V','500000','','3.8',N'Grand Theft Auto V là một trò chơi điện tử hành động phiêu lưu năm 2013','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1004','3','Hero Siege','120000','','3.2',N'Hero Siege là một trò chơi Slash của Hack với các yếu tố roguelike- & RPG','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1005','1','Rainbow Six Siege','300000','','3.5',N'là một trò chơi điện tử bắn súng chiến thuật','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1006','4','Mario Kart Wii','90000','','5',N'là một trò chơi đua xe kart được phát triển và xuất bản bởi Nintendo cho Wii','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1007','3','Pokémon Unite','12000','','4',N'là một trò chơi điện tử đấu trường trực tuyến nhiều người chơi','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1008','1','Left 4 dead 2','120000','','3.5',N'là một trò chơi bắn súng góc nhìn thứ nhất','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1009','1','Left 4 dead 2','120000','','3.5',N'là một trò chơi bắn súng góc nhìn thứ nhất','0','Console');
SET IDENTITY_INSERT game OFF;


SET IDENTITY_INSERT loaigame ON;
Go
insert into loaigame  (Game_type,Type_Name)
values ('1','fps');
insert into loaigame  (Game_Type, Type_Name)
values ('2','Third-Person shooter');
insert into loaigame  (Game_Type, Type_Name)
values ('3','Simulation');
insert into loaigame  (Game_Type, Type_Name)
values ('4','Racing');
insert into loaigame  (Game_Type, Type_Name)
values ('5','PVP');
SET IDENTITY_INSERT loaigame OFF;


SET IDENTITY_INSERT Account ON;
GO
insert into Account (UserID, UserName, Phone,PWD,Email,RealName)
values ('1','admin','036182673','123456','lmao@gmail.com','abcxyz');
insert into Account (UserID, UserName, Phone,PWD,Email,RealName)
values ('2','phuc','036182673','123456','lmao@gmail.com',N'Phúc');
SET IDENTITY_INSERT Account OFF;

SET IDENTITY_INSERT Don_Hang ON
insert into Don_Hang (SoDH,UserID,Ngay_Mua,Tinh_Trang_Don_Hang)
values ('1','2','3/5/2022','1');
SET IDENTITY_INSERT Don_Hang OFF

SET IDENTITY_INSERT CTDonHang ON
insert into CTDonHang (Ma_CTDH,Ma_DH,ProductID,So_Luong,Price,Total)
values ('1','12354','3971273','1','120000','120000');
SET IDENTITY_INSERT CTDonHang OFF
select * from account