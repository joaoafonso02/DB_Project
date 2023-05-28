CREATE TABLE Users (
  id INTEGER NOT NULL IDENTITY(1, 1),
  name VARCHAR(64),
  phone VARCHAR(15),
  email VARCHAR(64),
  postalZip VARCHAR(15),
  region VARCHAR(128),
  country VARCHAR(32),
  PRIMARY KEY (id)
);

CREATE TABLE UAuthentication (
  id INTEGER NOT NULL,
  username VARCHAR(32) NOT NULL,
  upass VARCHAR(64) NOT NULL,
  utoken VARCHAR(64) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (id) REFERENCES Users(id)
)

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

/* drop TABLE Inventory; */
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