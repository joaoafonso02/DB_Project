-- Trigger for Users Table
CREATE TRIGGER Users_InsertTrigger
ON Users
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; -- Prevents extra result sets 

    DECLARE @GeneratedID INT;
    
    SELECT @GeneratedID = inserted.id
    FROM inserted;
    
    INSERT INTO UAuthentication (id, username, upass, utoken)
    VALUES (@GeneratedID, '${username}', '${password}', '${token}');
END


-- Trigger for UAuhentication Table
CREATE TRIGGER UAuthentication_InsertTrigger
ON UAuthentication
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @GeneratedID INT;
    
    SELECT @GeneratedID = inserted.id
    FROM inserted;
    
    INSERT INTO Users (id, email)
    VALUES (@GeneratedID, '${email}');
END


-- Trigger for Orders Table
CREATE TRIGGER Orders_InsertTrigger
ON Orders
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 

    DECLARE @GeneratedID INT;
    
    SELECT @GeneratedID = inserted.id
    FROM inserted;
    
    INSERT INTO Inventory (order_id, iname, idescription, stock, cost) 
    VALUES (@GeneratedID, '${iname}', '${idescription}', '${stock}', '${cost}');
END

-- Trigger for Inventory Table
CREATE TRIGGER Inventory_InsertTrigger
ON Inventory
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 

    DECLARE @GeneratedID INT;
    
    SELECT @GeneratedID = inserted.id
    FROM inserted;
    
    INSERT INTO Orders (id, oname, price, quantity, odate, users_id) 
    VALUES (@GeneratedID, '${oname}', '${price}', '${quantity}', '${odate}', '${users_id}');
END

-- Trigger for Supplier Table
CREATE TRIGGER Supplier_InsertTrigger
ON Supplier
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 

    DECLARE @GeneratedID INT;
    
    SELECT @GeneratedID = inserted.id
    FROM inserted;
    
    INSERT INTO Insurance (id, idescription, idate, iprice) 
    VALUES (@GeneratedID, '${idescription}', '${idate}', '${iprice}');
END

-- Trigger for Insurance Table
CREATE TRIGGER Insurance_InsertTrigger
ON Insurance
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON; 

    DECLARE @GeneratedID INT;
    
    SELECT @GeneratedID = inserted.id
    FROM inserted;
    
    INSERT INTO Supplier (nif, sname, phone, email, saddress, postalZip, country) 
    VALUES (@GeneratedID, '${sname}', '${phone}', '${email}', '${saddress}', '${postalZip}', '${country}');
END
