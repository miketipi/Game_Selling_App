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
[Game_Img] [nvarchar](max) null,
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
/* Them the loai game */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[Add_Game_Type](@tenloai nvarchar(200),@CurrentID int output)
as
begin try

if(exists(select * from loaigame where Type_Name=@tenloai))
 begin
  set @CurrentID=0
  return
 end
insert into loaigame(Game_Type)values(@tenloai)
set @CurrentID=@@IDENTITY
end try
begin catch
 set @CurrentID=0
 end catch
GO
/* Them vao don hang */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Add_Cart](@usrID int,
@t Cart readonly,@Currentid int output)
as
begin try
declare @madh int
insert into Don_Hang([UserID] ,[Ngay_mua] ,[Tinh_Trang_Don_Hang])
values(@usrID,getdate(),1)
set @madh=@@IDENTITY
insert into [CTDonHang]([Ma_DH],[ProductID],[Price]  ,[Total])
select @madh,Product_ID  ,  Price , Total
from @t
set @Currentid=@madh
end try
begin catch
set @Currentid=-1
end catch
GO
/*Hien thi gio hang */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[LoadCart]
as
select * from Cart
GO

<<<<<<< HEAD
SET IDENTITY_INSERT game ON;
Go
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1000','1','Left 4 dead 2','120000','https://en.wikipedia.org/wiki/Left_4_Dead_2#/media/File:Left4Dead2.jpg','3.5',N'là một trò chơi bắn súng góc nhìn thứ nhất','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1001','1','Counter-strike Global Offensive',N'350000','https://didongviet.vn/dchannel/wp-content/uploads/2022/10/csgo-di-dong-viet-14.jpg','4.5',N'là một trò chơi bắn súng fps','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1002','2','Risk of rain 2','180000','https://upload.wikimedia.org/wikipedia/en/c/c1/Risk_of_Rain_2.jpg','4.0',N'bắn súng góc nhìn thứ ba giống người thật được phát triển bởi Hopoo Games','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1003','3','GTA V','500000','https://gamedva.com/wp-content/uploads/GTA-5-Grand-Theft-Auto-V.jpg','3.8',N'Grand Theft Auto V là một trò chơi điện tử hành động phiêu lưu năm 2013','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1004','3','Hero Siege','120000','https://cdn.cloudflare.steamstatic.com/steam/apps/269210/header.jpg?t=1669637809','3.2',N'Hero Siege là một trò chơi Slash của Hack với các yếu tố roguelike- & RPG','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1005','1','Rainbow Six Siege','300000','https://image.api.playstation.com/vulcan/ap/rnd/202209/2121/UlfMBx2yUHge8Vlz7eszqw13.png','3.5',N'là một trò chơi điện tử bắn súng chiến thuật','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1006','4','Mario Kart Wii','90000','https://m.media-amazon.com/images/M/MV5BNzQ1ZTZmMjctZjk0MS00YTdiLWE5MjEtYjVkZmY3Y2I5MTllXkEyXkFqcGdeQXVyMTAyNzc0MDkz._V1_FMjpg_UX1000_.jpg','5',N'là một trò chơi đua xe kart được phát triển và xuất bản bởi Nintendo cho Wii','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1007','3','Pokémon Unite','12000','https://image.thanhnien.vn/w2048/Uploaded/2023/fsmym/2021_08_21/moba-pokemon-unite-ra-mat-tren-android-ios02_eclv.jpg','4',N'là một trò chơi điện tử đấu trường trực tuyến nhiều người chơi','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1008','1','Left 4 dead 2','120000','https://en.wikipedia.org/wiki/Left_4_Dead_2#/media/File:Left4Dead2.jpg','3.5',N'là một trò chơi bắn súng góc nhìn thứ nhất','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1009','1','Left 4 dead 2','120000','https://en.wikipedia.org/wiki/Left_4_Dead_2#/media/File:Left4Dead2.jpg','3.5',N'là một trò chơi bắn súng góc nhìn thứ nhất','0','Console');
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
insert into loaigame  (Game_Type, Type_Name)
values ('6','Action');
insert into loaigame  (Game_Type, Type_Name)
values ('7','Puzzle');
insert into loaigame  (Game_Type, Type_Name)
values ('8','Sport');
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