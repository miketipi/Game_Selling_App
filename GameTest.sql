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
      ,[Price]
      ,[Game_Img]
      ,[Description]
	  ,[Rating] from game
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
/*Cap Nhat Tai Khoan*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[Update_Account](@mand int, @dt nvarchar(10), @pwd nvarchar(100), @email nvarchar(100),@CurrentID int output)
as
begin try

if(exists(select * from Account where UserID<>@mand))
 begin
  set @CurrentID=-1
  return
 end
update account set Phone=@dt
where UserID=@mand
update account set PWD=@pwd
where UserID=@mand
update account set Email=@email
where UserID=@mand
set @CurrentID=@mand
end try
begin catch
 set @CurrentID=0
 end catch
GO
<<<<<<< HEAD
SET IDENTITY_INSERT game ON;
Go
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1000','1','Left 4 dead 2','120','https://cdn.cloudflare.steamstatic.com/steam/apps/550/header.jpg?t=1666824129','3.5',N'là một trò chơi bắn súng góc nhìn thứ nhất','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1001','1','Counter-strike Global Offensive',N'350','https://didongviet.vn/dchannel/wp-content/uploads/2022/10/csgo-di-dong-viet-14.jpg','4.5',N'là một trò chơi bắn súng fps','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1002','2','Risk of rain 2','180','https://upload.wikimedia.org/wikipedia/en/c/c1/Risk_of_Rain_2.jpg','4.0',N'bắn súng góc nhìn thứ ba giống người thật được phát triển bởi Hopoo Games','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1003','3','GTA V','500','https://gamedva.com/wp-content/uploads/GTA-5-Grand-Theft-Auto-V.jpg','3.8',N'Grand Theft Auto V là một trò chơi điện tử hành động phiêu lưu năm 2013','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1004','3','Hero Siege','120','https://cdn.cloudflare.steamstatic.com/steam/apps/269210/header.jpg?t=1669637809','3.2',N'Hero Siege là một trò chơi Slash của Hack với các yếu tố roguelike- & RPG','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1005','1','Rainbow Six Siege','300','https://image.api.playstation.com/vulcan/ap/rnd/202209/2121/UlfMBx2yUHge8Vlz7eszqw13.png','3.5',N'là một trò chơi điện tử bắn súng chiến thuật','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1006','4','Mario Kart Wii','90','https://m.media-amazon.com/images/M/MV5BNzQ1ZTZmMjctZjk0MS00YTdiLWE5MjEtYjVkZmY3Y2I5MTllXkEyXkFqcGdeQXVyMTAyNzc0MDkz._V1_FMjpg_UX1000_.jpg','5',N'là một trò chơi đua xe kart được phát triển và xuất bản bởi Nintendo cho Wii','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform)
values ('1007','3','Pokémon Unite','12','https://image.thanhnien.vn/w2048/Uploaded/2023/fsmym/2021_08_21/moba-pokemon-unite-ra-mat-tren-android-ios02_eclv.jpg','4',N'là một trò chơi điện tử đấu trường trực tuyến nhiều người chơi','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1008','6','Frontier Hunter: Erza’s Wheel of Fortune','198','https://cdn.cloudflare.steamstatic.com/steam/apps/1429500/header.jpg?t=1671299332','4.8',N'Sau khi đế chế phát minh ra khí cầu, con người cuối cùng đã có thể bay qua các lục địa và đảo nổi. Và nhờ đó, đế chế mở rộng nhanh chóng. Thợ săn hàng đầu, Erza, dẫn đầu một đội thám hiểm khám phá biên giới man rợ nơi đế chế không thể chạm tới.','0','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1009','6','Overcooked! 2','300','https://cdn.cloudflare.steamstatic.com/steam/apps/728880/header.jpg?t=1670442579','3.8',N'OverCooked 2 là một trò chơi video mô phỏng nấu ăn hợp tác được phát triển bởi Team17 cùng với Ghost Town Games và được xuất bản bởi Team17. Phần tiếp theo của OverCooked!','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1010','1','Call of Duty®: Modern Warfare® II','1800','https://cdn.cloudflare.steamstatic.com/steam/apps/1938090/header.jpg?t=1671472823','3',N'Call of Duty: Modern Warfare 2 là một trò chơi điện tử thể loại bắn súng góc nhìn thứ nhất, được phát triển bởi Infinity Ward và phát hành bởi Activision.','0','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1011','6','Borderlands 2','83','https://cdn.cloudflare.steamstatic.com/steam/apps/49520/header.jpg?t=1645058069','4.2',N'Borderlands 2 là video game hành động nhập vai, bắn súng góc nhìn thứ nhất được phát triển bởi Gearbox Software và được xuất bản bởi 2K Games. Đây là phần tiếp theo của Borderlands năm 2009','1','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1012','5','Pummel Party','165','https://cdn.cloudflare.steamstatic.com/steam/apps/880940/header.jpg?t=1670489597','3.9',N'Pummel Party sở hữu kho mini game cực kỳ đa dạng. Người chơi có thể khởi động bằng một trận chiến nảy lửa đấu phép thuật trên miệng núi lửa, hay tham gia cuộc chiến ném bom tại sở cảnh sát.','0','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1013','6','PICO PARK','70','https://cdn.cloudflare.steamstatic.com/steam/apps/1509960/header.jpg?t=1627200665','4.2',N'Pico Park là một trò chơi độc lập nhiều người chơi, hành động-giải đố hợp tác được phát triển bởi TECOPARK. Bản phát hành đầu tiên của Pico Park cho Microsoft Windows là vào năm 2016 thông qua nhà bán lẻ trò chơi điện tử Steam','1','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1014','3','Vampire Survivors','70','https://cdn.cloudflare.steamstatic.com/steam/apps/1794680/header.jpg?t=1671207503','3.5',N'Vampire Survivors là một trò chơi điện tử bắn súng roguelike được phát triển và phát hành bởi Luca Galante, còn được gọi là poncle.','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1015','2','Dying Light 2 Stay Human','990','https://cdn.cloudflare.steamstatic.com/steam/apps/534380/header.jpg?t=1672330001','4',N'Dying Light 2 Stay Human là một trò chơi nhập vai hành động năm 2022 được phát triển và phát hành bởi Techland. Phần tiếp theo của Dying Light, trò chơi được phát hành vào ngày 4 tháng 2 năm 2022','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1016','3','Tiny Civilization','30','https://cdn.cloudflare.steamstatic.com/steam/apps/2230280/header.jpg?t=1672557857','4.6',N'Đây là một game mô phỏng lịch sử nhằm thúc đẩy sự phát triển của nền văn minh dựa trên Game match-3. Bạn sẽ cần thu thập tài nguyên, sử dụng kỹ năng, khám phá công nghệ mới và dẫn dắt loài người vượt qua hành trình 10.000 năm tới vũ trụ.','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1017','9','Melatonin','205','https://cdn.cloudflare.steamstatic.com/steam/apps/1585220/header.jpg?t=1671915401','4.7',N'Melatonin là một trò chơi nhịp điệu về những giấc mơ và thực tế kết hợp với nhau. Nó sử dụng hình ảnh động và tín hiệu âm thanh để giúp bạn bắt nhịp mà không có bất kỳ lớp phủ hoặc giao diện đáng sợ nào. Hài hòa qua nhiều cấp độ mơ mộng chứa đựng những thử thách đáng ngạc nhiên, nghệ thuật vẽ tay và âm nhạc sôi động.','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1018','9','Chicken Invaders Universe','100','https://cdn.cloudflare.steamstatic.com/steam/apps/1510460/header.jpg?t=1671113704','3.5',N'Một cốt lõi gây nghiện tuyệt vời của hành động bắn súng bằng ngón tay, được bao quanh bởi những mảnh ghép thú vị về khám phá thiên hà, tùy chỉnh tàu vũ trụ và các cuộc thi cộng đồng.','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1019','3','X-Plane 12','480','https://cdn.cloudflare.steamstatic.com/steam/apps/2014780/header.jpg?t=1671633662','3.5',N'Mô phỏng chuyến bay siêu thực','0','VR');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1020','5','Brawlhalla','330','https://cdn.cloudflare.steamstatic.com/steam/apps/291550/header.jpg?t=1668629907','3.9',N'Một nền tảng chiến đấu hoành tráng cho tối đa 8 người chơi trực tuyến hoặc địa phương. Hãy thử các trận đấu xếp hạng, miễn phí thông thường hoặc mời bạn bè vào phòng riêng.','1','Nitendo Switch');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1021','6','Dota 2','10','https://cdn.cloudflare.steamstatic.com/steam/apps/570/header.jpg?t=1666237243','3.5',N'Mỗi ngày, hàng triệu người chơi trên toàn thế giới tham gia trận chiến với tư cách là một trong hơn một trăm anh hùng Dota. Và bất kể đó là giờ chơi thứ 10 hay thứ 1.000, luôn có điều gì đó mới mẻ để khám phá. Với các bản cập nhật thường xuyên đảm bảo sự phát triển liên tục của lối chơi, tính năng và anh hùng, Dota 2 đã có một cuộc sống của riêng mình.','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1022','2','SCUM','280','https://cdn.cloudflare.steamstatic.com/steam/apps/513710/header.jpg?t=1671208269','3',N'SCUM nhằm mục đích phát triển trò chơi sinh tồn thế giới mở nhiều người chơi với mức độ tùy biến, kiểm soát và phát triển nhân vật chưa từng có, trong đó kiến ​​thức và kỹ năng là vũ khí tối thượng để tồn tại lâu dài.','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1023','3','Terraria','120','https://cdn.cloudflare.steamstatic.com/steam/apps/105600/header.jpg?t=1666290860','4.9',N'Đào, chiến đấu, khám phá, xây dựng! Không có gì là không thể trong trò chơi phiêu lưu đầy hành động này. Bốn Gói cũng có sẵn!','1','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1024','10','Phasmophobia','160','https://cdn.cloudflare.steamstatic.com/steam/apps/739630/header.jpg?t=1672281192','4.4',N'Phasmophobia là game kinh dị tâm lý phối hợp trực tuyến 4 người chơi. Hoạt động huyền bí đang gia tăng và bạn và nhóm của mình phải sử dụng tất cả các thiết bị săn ma theo ý của bạn để thu thập càng nhiều bằng chứng càng tốt.','0','VR');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1025','9','Human: Fall Flat','198','https://cdn.cloudflare.steamstatic.com/steam/apps/477160/header.jpg?t=1668685016','3.9',N'Human: Fall Flat là một trò chơi platformer vui nhộn, nhẹ nhàng lấy bối cảnh là những khung cảnh mộng mơ trôi nổi có thể chơi một mình hoặc với tối đa 8 người chơi trực tuyến. Cấp độ mới miễn phí giữ cho cộng đồng sôi động của nó được khen thưởng.','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1026','6','Castle Crashers','165','https://cdn.cloudflare.steamstatic.com/steam/apps/204360/header.jpg?t=1671827960','4.9',N'Hack, chém và đập theo cách của bạn để giành chiến thắng trong cuộc phiêu lưu arcade 2D từng đoạt giải thưởng này từ The Behemoth!','0','Console');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1027','2','METAL SLUG','100','https://cdn.cloudflare.steamstatic.com/steam/apps/366250/header.jpg?t=1584641206','4.2',N'“METAL SLUG”, tựa game đầu tiên trong sê-ri game hành động bắn súng 2D huyền thoại của SNK, nơi tất cả bắt đầu, quay trở lại các nhiệm vụ trên nền tảng trò chơi Steam!','1','PC');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1028','9','Beat Saber','250','https://cdn.cloudflare.steamstatic.com/steam/apps/620980/header.jpg?t=1622461922','4.8',N'Beat Saber là một trò chơi nhịp điệu VR, trong đó bạn cắt theo nhịp điệu của âm nhạc kích thích adrenaline khi chúng bay về phía bạn, được bao quanh bởi một thế giới tương lai.','1','VR');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1029','1','Blood Trail','220','https://cdn.cloudflare.steamstatic.com/steam/apps/1032430/header.jpg?t=1657139427','4.1',N'Bạn là Wendigo. Một kẻ giết người theo hợp đồng cứng rắn được giao nhiệm vụ tiêu diệt một giáo phái cuồng tín. Với kho vũ khí đáng tin cậy của bạn đã sẵn sàng, hãy trải nghiệm thứ được gọi là "Trò chơi bạo lực nhất trong VR". TRUY CẬP SỚM bao gồm các chế độ RAID, ARENA và SANDBOX','0','VR');
insert into game (ProductID, Game_Type, Name, Price, Game_Img, Rating, Description, Status, Platform) 
values ('1030','6','Return to abyss','56','https://cdn.cloudflare.steamstatic.com/steam/apps/2185780/header.jpg?t=1673082640','3.2',N'Return to Abyss là game sinh tồn cắt cỏ với các yếu tố Rogue-Lite, nâng cấp vũ khí và sử dụng kỹ năng chiến đấu của bạn để chiến đấu với hơn 10.000 quái vật trên màn hình cho đến khi đánh bại thủ phạm gây ra hỗn loạn','1','PC');
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
insert into loaigame (Game_Type, Type_Name)
values ('9','Casual');
insert into loaigame (Game_Type, Type_Name)
values ('10', 'Horror');
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