CREATE DATABASE GAMESTORE
USE GAMESTORE
--TAO BANG--
CREATE TABLE PRODUCT
(
    Pro_Id INTEGER PRIMARY KEY  IDENTITY(1,1),
    Description VARCHAR(255) NOT NULL,
    Pro_name VARCHAR(255),
    Price MONEY,
);
SELECT * FROM PRODUCT;
	CREATE TABLE GAMES
	(
		Games_id INTEGER PRIMARY KEY,
		Games_Name VARCHAR (255),
		Games_Platform VARCHAR (255),
		Games_Details VARCHAR (255),
		Games_Min_Memory_Size INTEGER,
		Games_Status BIT,
		FOREIGN KEY (Games_id)
		REFERENCES PRODUCT (Pro_id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	);
	CREATE TABLE ACCESSORICES
	(
		Accessory_Id Integer PRIMARY KEY,
		Accessory_Name varchar(255),
		Details varchar(255),
		FOREIGN KEY (Accessory_id)
			REFERENCES PRODUCT (Pro_Id)
			ON DELETE CASCADE ON UPDATE CASCADE
	);
CREATE TABLE USERS
(
	User_id Integer PRIMARY KEY IDENTITY(1,1) ,
	Username varchar(25) NOT NULL,
	Password varchar(30) NOT NULL
);
CREATE TABLE User_orders
(
	order_id Integer PRIMARY KEY iDENTITY(1,1),
	date_order date,
	product Integer,
	product_count Integer,
	USERS Integer,
	order_status varchar(255),
	FOREIGN KEY (USERS)
		REFERENCES USERS (User_id)
		ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (PRODUCT)
		REFERENCES PRODUCT (Pro_id)
		ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE Product_inventory (
	Product_id INTEGER PRIMARY KEY,
	Product_count INTEGER CHECK(Product_count > 0),
	FOREIGN KEY (Product_id)
		REFERENCES PRODUCT (Pro_id)
		ON DELETE CASCADE ON UPDATE CASCADE
);


