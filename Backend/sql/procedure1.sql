-- EXEC CheckPasswordValidity @username='username', @pass='pass';
CREATE PROCEDURE CheckPasswordValidity
    @pass VARCHAR(50),
    @username VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @hashed VARCHAR(50) = HASHBYTES('SHA2_256', @pass);
    
    IF EXISTS (
        SELECT 1
        FROM UAuthentication
        WHERE username=@username and upass=@hashed
    )
    BEGIN
        PRINT 'valid';
        UPDATE UAuthentication
        SET utoken=CONVERT(varchar(50), NEWID())
        WHERE username=@username;
        select utoken from UAuthentication where username=@username;
    END
    ELSE
    BEGIN
        PRINT 'invalid';
    END;
END;
