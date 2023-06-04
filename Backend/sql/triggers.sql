-- CREATE TRIGGER HashPassword
-- ON UAuthentication
-- AFTER INSERT, UPDATE
-- AS
-- BEGIN
--     SET NOCOUNT ON;

--     UPDATE U
--     SET U.upass = HASHBYTES('SHA2_256', U.upass)
--     FROM UAuthentication AS U
--     INNER JOIN inserted ON U.id = inserted.id;
-- END;

-- CREATE TRIGGER TrotiConfirmationTrigger -- Executes SP UpdateTrotiStatus
-- ON ConfirmationTable  
-- AFTER INSERT
-- AS
-- BEGIN
--   DECLARE @troti_id INT
--   DECLARE @availability_status VARCHAR(50) 

--   SELECT @troti_id = troti_id,
--          @availability_status = 'unavailable'
--   FROM inserted

--   EXEC UpdateTrotiStatus @troti_id, @availability_status 
-- END
