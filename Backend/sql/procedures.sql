CREATE PROCEDURE InsertUserWithAuthentication
    @Email NVARCHAR(255),
    @Username NVARCHAR(255),
    @Password NVARCHAR(255),
    @Token NVARCHAR(255)
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRANSACTION;

    DECLARE @GeneratedID INT;
    
    INSERT INTO Users (email)
    VALUES (@Email);
    
    SET @GeneratedID = SCOPE_IDENTITY();
    
    INSERT INTO UAuthentication (id, username, upass, utoken)
    VALUES (@GeneratedID, @Username, @Password, @Token);
    
    COMMIT;
END

-- Procedure for inserting a new supplier
-- CREATE PROCEDURE InsertSupplier
--     @NIF INTEGER,
--     @SName NVARCHAR(255),
--     @Phone NVARCHAR(20),
--     @Email NVARCHAR(255),
--     @SAddress NVARCHAR(255),
--     @PostalZip NVARCHAR(10),
--     @Country NVARCHAR(255)
-- AS
-- BEGIN
--     SET NOCOUNT ON;
    
--     INSERT INTO Supplier (nif, sname, phone, email, saddress, postalZip, country)
--     VALUES (@NIF, @SName, @Phone, @Email, @SAddress, @PostalZip, @Country);
-- END

-- --Procedure for inserting a new order
-- CREATE PROCEDURE InsertOrder
--     @OName NVARCHAR(255),
--     @Price REAL,
--     @Quantity INTEGER,
--     @ODate DATE,
--     @UsersID INTEGER
-- AS
-- BEGIN
--     SET NOCOUNT ON;
    
--     BEGIN TRANSACTION;

--     DECLARE @GeneratedID INT;
    
--     INSERT INTO Orders (oname, price, quantity, odate, users_id)
--     VALUES (@OName, @Price, @Quantity, @ODate, @UsersID);
    
--     SET @GeneratedID = SCOPE_IDENTITY();
    
--     INSERT INTO Inventory (order_id)
--     VALUES (@GeneratedID);
    
--     COMMIT;
-- END

-- Pr

-- Procedure for inserting a new user's order
-- CREATE PROCEDURE InsertUserOrder
--     @OName NVARCHAR(255),
--     @Price REAL,
--     @Quantity INTEGER,
--     @ODate DATE,
--     @UsersID INTEGER
-- AS
-- BEGIN
--     SET NOCOUNT ON;
    
--     INSERT INTO Orders (oname, price, quantity, odate, users_id)
--     VALUES (@OName, @Price, @Quantity, @ODate, @UsersID);
-- END
