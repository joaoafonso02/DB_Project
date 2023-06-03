CREATE TRIGGER HashPassword
ON UAuthentication
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE U
    SET U.upass = HASHBYTES('SHA2_256', U.upass)
    FROM UAuthentication AS U
    INNER JOIN inserted ON U.id = inserted.id;
END;
