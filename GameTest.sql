create database QLGAME
use QLGAME
Go
/*Tạo Game*/
set ansi_nulls on
go
create table [dbo].[game](
[ProductID] [int] identity(1,1),
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
	[Game_Type] [int] IDENTITY(1,1),
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
	[UserID] [int] IDENTITY(1,1),
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
/*Tạo CT DonHang */
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTDonHang](
	[Ma_CTDH] [int] IDENTITY(1,1),
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
	[SoDH] [int] IDENTITY(1,1),
	[UserID] [int] NULL,
	[Ngay_Mua] [datetime] NULL,
	[Tinh_Trang_Don_Hang] [bit] NULL,
 CONSTRAINT [PK_Don_Hang] PRIMARY KEY CLUSTERED 
(
	[SoDH] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
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

insert into game values ('1000','fps','Left 4 dead 2','120000','','3.5','là một trò chơi bắn súng góc nhìn thứ nhất','1','PC');
insert into game values ('null','fps','Counter-strike Global Offensive','350000','','4.5','là một trò chơi bắn súng fps','1','PC');
insert into game values ('null','Third-Person shooter','Risk of rain 2','180000','','4.0','bắn súng góc nhìn thứ ba giống người thật được phát triển bởi Hopoo Games','1','PC');
insert into game values ('null','Simulation','GTA V','500000','','3.8','Grand Theft Auto V là một trò chơi điện tử hành động phiêu lưu năm 2013','1','PC');
insert into game values ('null','Simulation','Hero Siege','120000','','3.2','Hero Siege là một trò chơi Slash của Hack với các yếu tố roguelike- & RPG','0','Console');
insert into game values ('null','FPS','Rainbow Six Siege','300000','','3.5','là một trò chơi điện tử bắn súng chiến thuật','0','Console');
insert into game values ('null','Racing','Mario Kart Wii','90000','','5','là một trò chơi đua xe kart được phát triển và xuất bản bởi Nintendo cho Wii','0','Console');
insert into game values ('null','Simulation','Pokémon Unite','12000','','4',' là một trò chơi điện tử đấu trường trực tuyến nhiều người chơi','0','Console');
insert into game values ('null','fps','Left 4 dead 2','120000','','3.5','là một trò chơi bắn súng góc nhìn thứ nhất','0','Console');
insert into game values ('null','fps','Left 4 dead 2','120000','','3.5','là một trò chơi bắn súng góc nhìn thứ nhất','0','Console');

insert into loaigame values ('1','fps');
insert into loaigame values ('null','Third-Person shooter');
insert into loaigame values ('null','Simulation');
insert into loaigame values ('null','Racing');
insert into loaigame values ('null','PVP');

insert into Account values ('1','admin','036182673','123456','lmao@gmail.com');
insert into Account values ('null','phuc','036182673','123456','lmao@gmail.com');

insert into Don_Hang values ('1','2','3/5/2022','1');

insert into CTDonHang values ('1','12354','3971273','1','120000','120000');
