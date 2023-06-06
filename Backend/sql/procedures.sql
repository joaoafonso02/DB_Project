-- EXEC CheckPasswordValidity @username='username', @pass='pass';
CREATE PROCEDURE CheckPasswordValidity
    @pass VARCHAR(50),
    @username VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    
    IF EXISTS (
        SELECT 1
        FROM UAuthentication
        WHERE username=@username and upass=HASHBYTES('SHA2_256', @pass)
    )
    BEGIN
        PRINT 'valid';
        UPDATE UAuthentication
        SET utoken=CONVERT(varchar(50), NEWID())
    END
    ELSE
    BEGIN
        PRINT 'invalid';
    END;
END;

-- CREATE PROCEDURE GetUsers
-- AS
-- BEGIN
--     SELECT name FROM Users;
-- END;
-- Create a procedure to filter group_name from TGroups

-- CREATE PROCEDURE FilterChats
--   @username NVARCHAR(50),
--   @searchInput NVARCHAR(100)
-- AS
-- BEGIN
--   SELECT Tgroups.group_name, Tgroups.group_id
--   FROM TGroups
--   INNER JOIN TGroupsMembers ON Tgroups.group_id = TGroupsMembers.group_id
--   INNER JOIN UAuthentication ON TGroupsMembers.user_id = UAuthentication.id
--   WHERE UAuthentication.username = @username
--   AND Tgroups.group_name LIKE '%' + @searchInput + '%'
-- END


-- CREATE PROCEDURE UpdateTrotiStatus
--   @troti_id INT,
--   @availability_status VARCHAR(50) 
-- AS
-- BEGIN
--   UPDATE Troti
--   SET availability_status = @availability_status 
--   WHERE id = @troti_id
-- END


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