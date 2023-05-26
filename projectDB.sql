/* DROP TABLE IF EXISTS "TrotiNet"; */

use TrotiNet;

/* drop all tables */
drop table Messages;
drop table TGroups;
drop table Alarm;
drop table Product;

drop table Inventory;
drop table Orders;
drop table Users;

drop table Supplier;
drop table Insurance;
drop table Payment;


CREATE TABLE Users (
  [id] INTEGER NOT NULL IDENTITY(1, 1),
  [name] VARCHAR(64) NOT NULL,
  [phone] VARCHAR(15) NOT NULL,
  [email] VARCHAR(64) NOT NULL,
  [postalZip] VARCHAR(15) NOT NULL,
  [region] VARCHAR(128) NOT NULL,
  [country] VARCHAR(32) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE Orders (
	id INTEGER NOT NULL IDENTITY(1,1),
	oname VARCHAR(255) NOT NULL,
	price REAL NOT NULL,
	quantity INTEGER NOT NULL,
	odate date NOT NULL,
	users_id INTEGER NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (users_id) REFERENCES Users(id)
);

/* drop table Troti_Inventory; */
CREATE TABLE Inventory (
	id INTEGER NOT NULL IDENTITY(1, 1),
	iname VARCHAR(255) NOT NULL,
	idescription VARCHAR(255) NOT NULL,
	stock INTEGER NOT NULL,
	cost REAL NOT NULL,
	order_id INTEGER NOT NULL,
	PRIMARY KEY(id),
	FOREIGN KEY(order_id) REFERENCES Orders(id),
);


CREATE TABLE Supplier (
	nif INTEGER NOT NULL,
	sname VARCHAR(255) NOT NULL,
	phone VARCHAR(20) NOT NULL,
	email VARCHAR(255) NOT NULL,
	saddress VARCHAR(255) NOT NULL,
	postalZip VARCHAR(10) NOT NULL,
	country VARCHAR(255) NOT NULL,
	PRIMARY KEY (nif)
);

CREATE TABLE Insurance(
	id INTEGER NOT NULL IDENTITY(1,1),
  idescription VARCHAR(255) NOT NULL,
  idate DATE NOT NULL,
  iprice REAL NOT NULL,
  productId INTEGER,
  -- FOREIGN KEY (productId) REFERENCES Product(productId),
  PRIMARY KEY(id)
);

CREATE TABLE Payment (
  id INTEGER NOT NULL IDENTITY(1,1),
  pdescription VARCHAR(255) NOT NULL,
  subtotal REAL NOT NULL,
  pdate DATE NOT NULL,
  productId INTEGER NOT NULL,
  -- FOREIGN KEY (productId) REFERENCES product(productId),
  PRIMARY KEY(id)
);

CREATE TABLE Product (
	id INTEGER NOT NULL IDENTITY(1,1),
	pname VARCHAR(255) NOT NULL,
	price REAL NOT NULL,
	insurance_id INTEGER NOT NULL,
	orders_id INTEGER NOT NULL,
	supplier_nif INTEGER NOT NULL,
	payment_id INTEGER NOT NULL,
	FOREIGN KEY(supplier_nif) REFERENCES Supplier(nif),
	FOREIGN KEY(orders_id) REFERENCES Orders(id),
	FOREIGN KEY(insurance_id) REFERENCES Insurance(id),
	FOREIGN KEY(payment_id) REFERENCES Payment(id),
	PRIMARY KEY(id)
);

CREATE TABLE Alarm (
  id INTEGER NOT NULL IDENTITY(1, 1),
  alarm_name VARCHAR(255) NOT NULL,
  alarm_description VARCHAR(255),
  alarm_date DATE,
  alarm_time TIME,
  product_id INTEGER NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (product_id) REFERENCES Product(id)
);

CREATE TABLE TGroups (
  group_id INTEGER NOT NULL  IDENTITY(1, 1),
  group_name VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT GETDATE(),
  PRIMARY KEY (group_id)
);


CREATE TABLE Messages (
  message_id INTEGER NOT NULL IDENTITY(1, 1),
  message_text VARCHAR(255) NOT NULL,
  sent_at DATETIME DEFAULT GETDATE(),
  user_id INT NOT NULL,
  group_id INT NOT NULL,
  PRIMARY KEY (message_id),
  FOREIGN KEY (user_id) REFERENCES Users(id),
  FOREIGN KEY (group_id) REFERENCES TGroups(group_id)
);

INSERT INTO Users 
  (name,phone,email,postalZip,region,country)
VALUES
  ('Myra Nieves','(926) 370-4452','pede.cras@google.couk','5954 QQ','South Jeolla','Nigeria'),
  ('Teegan Hampton','1-221-123-4255','phasellus.vitae@google.org','4625','Rio Grande do Sul','Mexico'),
  ('Elizabeth Hutchinson','(877) 956-7839','at.arcu.vestibulum@yahoo.com','6774','Gauteng','Spain'),
  ('Talon Hart','1-306-752-3160','a@outlook.ca','829577','Galicia','Canada'),
  ('Sydney Stanton','1-430-371-3838','sit@hotmail.edu','11963','Maryland','Australia'),
  ('Ciaran Clements','(584) 564-0443','magna.suspendisse@google.couk','1618','North Island','Spain'),
  ('Solomon Osborne','1-138-810-3831','varius.ultrices@protonmail.edu','8675 TL','Stockholms län','Peru'),
  ('Tatum Thomas','1-906-717-3213','semper.rutrum@aol.ca','1036 VA','Free State','Norway'),
  ('Mona Cameron','1-861-573-7956','arcu.vestibulum@aol.com','03485','Kano','Russian Federation'),
  ('Maxwell Bender','(761) 485-3209','montes.nascetur.ridiculus@icloud.couk','2021','Xīnán','Belgium');
INSERT INTO Users (name,phone,email,postalZip,region,country)
VALUES
  ('Catherine Dickerson','1-673-121-4815','eleifend.cras.sed@google.edu','330335','North Kalimantan','New Zealand'),
  ('Mufutau Head','1-931-518-4223','INTEGER.aliquam@icloud.com','6658','South Gyeongsang','Nigeria'),
  ('Imogene Roth','(815) 828-4523','at.auctor@yahoo.com','87-140','Sutherland','Pakistan'),
  ('Diana Barron','(426) 360-4534','nec@protonmail.couk','2535','Ivanovo Oblast','Belgium'),
  ('Hu Branch','1-562-616-6921','urna.nullam.lobortis@hotmail.com','72166','Cartago','Netherlands'),
  ('Madison Benson','(946) 864-4412','pede.nonummy.ut@protonmail.edu','68352','Kogi','Colombia'),
  ('Emery Frazier','1-161-324-0572','imperdiet.ornare@protonmail.couk','S1M 8T3','Chernihiv oblast','Sweden'),
  ('Brett Wise','(591) 811-1632','enim.consequat@outlook.net','601758','Zuid Holland','South Africa'),
  ('Damian Shannon','(960) 374-5532','proin.nisl.sem@protonmail.com','9781','Kentucky','Pakistan'),
  ('Harriet Reed','(858) 840-6043','feugiat.metus.sit@hotmail.net','690652','Guerrero','Peru');
INSERT INTO Users (name,phone,email,postalZip,region,country)
VALUES
  ('Caesar Medina','(627) 261-1467','in@protonmail.com','55212','Zuid Holland','New Zealand'),
  ('Elliott Bright','1-794-608-7740','vitae.risus.duis@icloud.net','635113','West Region','India'),
  ('Scott Mathews','1-898-812-3584','nascetur.ridiculus.mus@outlook.com','183143','Friesland','Brazil'),
  ('Tobias Webb','1-625-614-2231','elit.erat@hotmail.ca','0534','Zhōngnán','Turkey'),
  ('Amos Blevins','1-368-734-4808','nisi@outlook.org','12S 2B2','Arequipa','Philippines'),
  ('MacKensie Reynolds','(720) 682-1741','pulvinar@google.com','3146','Zakarpattia oblast','Spain'),
  ('Cecilia Carlson','1-957-453-3805','dictum.proin@outlook.com','78415','Munster','Brazil'),
  ('Gage Velasquez','(233) 960-3319','eget.metus@outlook.couk','6647','Katsina','Austria'),
  ('Maryam Cooper','(325) 877-3887','fermentum.convallis.ligula@hotmail.org','341644','Zhōngnán','Vietnam'),
  ('Dieter Booth','(786) 633-1156','adipiscing.non.luctus@outlook.com','86645','South Chungcheong','Indonesia');
INSERT INTO Users (name,phone,email,postalZip,region,country)
VALUES
  ('Macaulay Wall','(838) 346-3220','pellentesque@yahoo.couk','S59 1KN','Odessa oblast','Australia'),
  ('Kaseem Gomez','1-610-568-8731','ullamcorper@icloud.edu','76T 4X4','Hidalgo','Indonesia'),
  ('Isaac Grimes','1-459-743-6636','odio.aliquam@hotmail.couk','29735','Vestland','Peru'),
  ('Elaine Hodge','(327) 523-7473','congue.a@outlook.net','289982','Mykolaiv oblast','Austria'),
  ('Brenden Hardin','(843) 576-5136','nam@yahoo.couk','3954','Ivano-Frankivsk oblast','Russian Federation'),
  ('Merritt Burke','1-588-336-6763','turpis.aliquam@hotmail.ca','873877','Virginia','South Korea'),
  ('Yvonne Hughes','(312) 116-7878','erat@outlook.ca','845933','Devon','Singapore'),
  ('Kevyn Reilly','(596) 538-5557','sociis.natoque@outlook.ca','181246','Aydın','Australia'),
  ('Alec Kent','(555) 231-7849','risus.odio@google.couk','72577','South Island','Philippines'),
  ('Basil Stephenson','(335) 124-0642','luctus.ut.pellentesque@yahoo.edu','35088','Zhōngnán','Mexico');
INSERT INTO Users (name,phone,email,postalZip,region,country)
VALUES
  ('John Howard','(835) 451-8435','eleifend@protonmail.couk','722273','Angus','South Korea'),
  ('Emma Turner','(290) 723-2506','ligula@hotmail.net','TG8N 7CY','Santa Catarina','Italy'),
  ('Jade Kerr','(245) 187-6151','vitae@hotmail.com','33-42','Viken','Indonesia'),
  ('Astra Nielsen','1-437-245-1206','penatibus@yahoo.edu','3574','Cartago','Norway'),
  ('Sandra Cherry','(481) 621-6113','dignissim.magna@hotmail.net','4967-6766','Victoria','South Korea'),
  ('Benjamin Guerrero','1-529-734-3377','risus@google.ca','37508','Berwickshire','New Zealand'),
  ('Rebecca Griffin','1-295-648-7843','odio.nam@hotmail.edu','6378','Luik','Chile'),
  ('Noble Velasquez','(918) 852-5648','at.auctor.ullamcorper@outlook.com','28-407','Wyoming','Austria'),
  ('Kylynn Thompson','1-866-286-8493','ut.tincidunt@yahoo.org','87584','Diyarbakır','India'),
  ('Lane Mcmahon','1-281-468-7193','eleifend.nunc@outlook.couk','65108-128','Luxemburg','Germany');