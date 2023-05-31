-- CREATE PROCEDURE InsertUserWithAuthentication
--     @Email NVARCHAR(255),
--     @Username NVARCHAR(255),
--     @Password NVARCHAR(255),
--     @Token NVARCHAR(255)
-- AS
-- BEGIN
--     SET NOCOUNT ON;
    
--     BEGIN TRANSACTION;

--     DECLARE @GeneratedID INT;
    
--     INSERT INTO Users (email)
--     VALUES (@Email);
    
--     SET @GeneratedID = SCOPE_IDENTITY();
    
--     INSERT INTO UAuthentication (id, username, upass, utoken)
--     VALUES (@GeneratedID, @Username, @Password, @Token);
    
--     COMMIT;
-- END