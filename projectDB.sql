/* DROP TABLE IF EXISTS `TrotiNet`; */

use p1g7;
go

/* drop table Troti_Users; */
CREATE TABLE [Troti_Users] (
  [id] INTEGER NOT NULL IDENTITY(1, 1),
  [name] VARCHAR(255) NOT NULL,
  [phone] VARCHAR(15) NOT NULL,
  [email] VARCHAR(255) NOT NULL,
	[postalZip] VARCHAR(10) NOT NULL,
  [region] VARCHAR(50) NOT NULL,
  [country] VARCHAR(100) NOT NULL,
  PRIMARY KEY (id)
);
GO

/* drop table Troti_Inventory; */
create table Troti_Inventory (
	id integer not null IDENTITY(1, 1),
	iname varchar(255) not null,
	idescription varchar(255) not null,
	stock integer not null,
	cost real not null,
	primary key(id)
);
GO


create table Troti_Supplier (
	nif int not null,
	sname varchar(255) not null,
	phone varchar(20) not null,
	email varchar(255) not null,
	saddress varchar(255) not null,
	postalZip varchar(10) not null,
	country varchar(255) not null,
	primary key (nif)
);
GO

create table Troti_Orders (
	id integer not null identity(1,1),
	oname varchar(255) not null,
	price real not null,
	quantity int not null,
	odate date not null,
	users_id int not null,
	primary key (id),
	foreign key (users_id) references Troti_Users(id)
);
GO

create table Troti_Insurance(
	id integer not null identity(1,1),
  idescription varchar(255) not null,
  idate date not null,
  iprice real not null,
  productId integer,
  FOREIGN KEY (productId) REFERENCES product(productId),
  PRIMARY KEY(id)
);
GO

create table Troti_Product (
	id int not null identity(1,1),
	pname varchar(255) not null,
	price real not null,
	insurance_id int not null,
	orders_id int not null,
	supplier_nif int not null,
	payment_id int not null,
	foreign key(supplier_nif) references Troti_Supplier(nif),
	foreign key(order_id) references Troti_Orders(id),
	foreign key(insurance_id) references Troti_Insurance(id),
	foreign key(payment_id) references Troti_Payment(id),
	primary key(id)
);
GO

create table Troti_Payment (
  id int not null identity(1,1),
  pdescription varchar(255) not null,
  subtotal real not null,
  pdate date not null,
  productId integer not null,
  FOREIGN KEY (productId) REFERENCES product(productId)
  PRIMARY KEY(id)
);
GO

/*

CREATE TABLE if not exists Supplier (
  SupplierNIF INT PRIMARY KEY,
  SuppplierName VARCHAR(255),
  SupplierPhone VARCHAR(20),
  SupplierEmail VARCHAR(255),  
  SupplierAddress VARCHAR(255)
  SupplierPostalZip VARCHAR(10),
  SupplierCountry VARCHAR(100),
);

CREATE TABLE if not exists Product (
  productId INT PRIMARY KEY,
  productName VARCHAR(255),
  price DOUBLE,
  orderId INT,
  quantity INT,
  supplierNIF INT,
  FOREIGN KEY (supplierNIF) REFERENCES supplier(NIF)
  FOREIGN KEY (orderId) REFERENCES orders(orderId),
  FOREIGN KEY (insuranceId) REFERENCES insurance(id),
  FOREIGN KEY (paymentId) REFERENCES payment(id)
);

CREATE TABLE if not exists Insurance (
  id INT PRIMARY KEY,
  description TEXT,
  time INT,
  date DATE,
  price DECIMAL(10, 2),
  productId INT,
  FOREIGN KEY (productId) REFERENCES product(productId)
);

CREATE TABLE if not exists Payment (
  id INT PRIMARY KEY,
  description TEXT,
  subTotal DOUBLE,
  tax DECIMAL(10, 2), 
  date DATE,
  productId INT,
  FOREIGN KEY (productId) REFERENCES product(productId)
);





INSERT INTO `User` (`name`,`phone`,`email`,`postalZip`,`region`,`country`)
VALUES
  ("Myra Nieves","(926) 370-4452","pede.cras@google.couk","5954 QQ","South Jeolla","Nigeria"),
  ("Teegan Hampton","1-221-123-4255","phasellus.vitae@google.org","4625","Rio Grande do Sul","Mexico"),
  ("Elizabeth Hutchinson","(877) 956-7839","at.arcu.vestibulum@yahoo.com","6774","Gauteng","Spain"),
  ("Talon Hart","1-306-752-3160","a@outlook.ca","829577","Galicia","Canada"),
  ("Sydney Stanton","1-430-371-3838","sit@hotmail.edu","11963","Maryland","Australia"),
  ("Ciaran Clements","(584) 564-0443","magna.suspendisse@google.couk","1618","North Island","Spain"),
  ("Solomon Osborne","1-138-810-3831","varius.ultrices@protonmail.edu","8675 TL","Stockholms län","Peru"),
  ("Tatum Thomas","1-906-717-3213","semper.rutrum@aol.ca","1036 VA","Free State","Norway"),
  ("Mona Cameron","1-861-573-7956","arcu.vestibulum@aol.com","03485","Kano","Russian Federation"),
  ("Maxwell Bender","(761) 485-3209","montes.nascetur.ridiculus@icloud.couk","2021","Xīnán","Belgium");
INSERT INTO `User` (`name`,`phone`,`email`,`postalZip`,`region`,`country`)
VALUES
  ("Catherine Dickerson","1-673-121-4815","eleifend.cras.sed@google.edu","330335","North Kalimantan","New Zealand"),
  ("Mufutau Head","1-931-518-4223","integer.aliquam@icloud.com","6658","South Gyeongsang","Nigeria"),
  ("Imogene Roth","(815) 828-4523","at.auctor@yahoo.com","87-140","Sutherland","Pakistan"),
  ("Diana Barron","(426) 360-4534","nec@protonmail.couk","2535","Ivanovo Oblast","Belgium"),
  ("Hu Branch","1-562-616-6921","urna.nullam.lobortis@hotmail.com","72166","Cartago","Netherlands"),
  ("Madison Benson","(946) 864-4412","pede.nonummy.ut@protonmail.edu","68352","Kogi","Colombia"),
  ("Emery Frazier","1-161-324-0572","imperdiet.ornare@protonmail.couk","S1M 8T3","Chernihiv oblast","Sweden"),
  ("Brett Wise","(591) 811-1632","enim.consequat@outlook.net","601758","Zuid Holland","South Africa"),
  ("Damian Shannon","(960) 374-5532","proin.nisl.sem@protonmail.com","9781","Kentucky","Pakistan"),
  ("Harriet Reed","(858) 840-6043","feugiat.metus.sit@hotmail.net","690652","Guerrero","Peru");
INSERT INTO `User` (`name`,`phone`,`email`,`postalZip`,`region`,`country`)
VALUES
  ("Caesar Medina","(627) 261-1467","in@protonmail.com","55212","Zuid Holland","New Zealand"),
  ("Elliott Bright","1-794-608-7740","vitae.risus.duis@icloud.net","635113","West Region","India"),
  ("Scott Mathews","1-898-812-3584","nascetur.ridiculus.mus@outlook.com","183143","Friesland","Brazil"),
  ("Tobias Webb","1-625-614-2231","elit.erat@hotmail.ca","0534","Zhōngnán","Turkey"),
  ("Amos Blevins","1-368-734-4808","nisi@outlook.org","12S 2B2","Arequipa","Philippines"),
  ("MacKensie Reynolds","(720) 682-1741","pulvinar@google.com","3146","Zakarpattia oblast","Spain"),
  ("Cecilia Carlson","1-957-453-3805","dictum.proin@outlook.com","78415","Munster","Brazil"),
  ("Gage Velasquez","(233) 960-3319","eget.metus@outlook.couk","6647","Katsina","Austria"),
  ("Maryam Cooper","(325) 877-3887","fermentum.convallis.ligula@hotmail.org","341644","Zhōngnán","Vietnam"),
  ("Dieter Booth","(786) 633-1156","adipiscing.non.luctus@outlook.com","86645","South Chungcheong","Indonesia");
INSERT INTO `User` (`name`,`phone`,`email`,`postalZip`,`region`,`country`)
VALUES
  ("Macaulay Wall","(838) 346-3220","pellentesque@yahoo.couk","S59 1KN","Odessa oblast","Australia"),
  ("Kaseem Gomez","1-610-568-8731","ullamcorper@icloud.edu","76T 4X4","Hidalgo","Indonesia"),
  ("Isaac Grimes","1-459-743-6636","odio.aliquam@hotmail.couk","29735","Vestland","Peru"),
  ("Elaine Hodge","(327) 523-7473","congue.a@outlook.net","289982","Mykolaiv oblast","Austria"),
  ("Brenden Hardin","(843) 576-5136","nam@yahoo.couk","3954","Ivano-Frankivsk oblast","Russian Federation"),
  ("Merritt Burke","1-588-336-6763","turpis.aliquam@hotmail.ca","873877","Virginia","South Korea"),
  ("Yvonne Hughes","(312) 116-7878","erat@outlook.ca","845933","Devon","Singapore"),
  ("Kevyn Reilly","(596) 538-5557","sociis.natoque@outlook.ca","181246","Aydın","Australia"),
  ("Alec Kent","(555) 231-7849","risus.odio@google.couk","72577","South Island","Philippines"),
  ("Basil Stephenson","(335) 124-0642","luctus.ut.pellentesque@yahoo.edu","35088","Zhōngnán","Mexico");
INSERT INTO `User` (`name`,`phone`,`email`,`postalZip`,`region`,`country`)
VALUES
  ("John Howard","(835) 451-8435","eleifend@protonmail.couk","722273","Angus","South Korea"),
  ("Emma Turner","(290) 723-2506","ligula@hotmail.net","TG8N 7CY","Santa Catarina","Italy"),
  ("Jade Kerr","(245) 187-6151","vitae@hotmail.com","33-42","Viken","Indonesia"),
  ("Astra Nielsen","1-437-245-1206","penatibus@yahoo.edu","3574","Cartago","Norway"),
  ("Sandra Cherry","(481) 621-6113","dignissim.magna@hotmail.net","4967-6766","Victoria","South Korea"),
  ("Benjamin Guerrero","1-529-734-3377","risus@google.ca","37508","Berwickshire","New Zealand"),
  ("Rebecca Griffin","1-295-648-7843","odio.nam@hotmail.edu","6378","Luik","Chile"),
  ("Noble Velasquez","(918) 852-5648","at.auctor.ullamcorper@outlook.com","28-407","Wyoming","Austria"),
  ("Kylynn Thompson","1-866-286-8493","ut.tincidunt@yahoo.org","87584","Diyarbakır","India"),
  ("Lane Mcmahon","1-281-468-7193","eleifend.nunc@outlook.couk","65108-128","Luxemburg","Germany");
*/