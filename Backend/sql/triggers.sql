-- CREATE TRIGGER HashPasswordTrigger
-- ON UAuthentication
-- AFTER INSERT, UPDATE
-- AS
-- BEGIN
--     SET NOCOUNT ON;

--     UPDATE UAuthentication
--     SET UAuthentication.upass = HASHBYTES('SHA2_256', UAuthentication.upass),
--         UAuthentication.utoken = CONVERT(VARCHAR(50), NEWID())
--     FROM UAuthentication
--     INNER JOIN inserted
--     ON UAuthentication.id=inserted.id;

--     SELECT UAuthentication.utoken 
--     FROM UAuthentication
--     INNER JOIN inserted
--     ON UAuthentication.id=inserted.id;
-- END;

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
-- ON Orders  
-- AFTER INSERT
-- AS
-- BEGIN
--   DECLARE @troti_id INT
--   DECLARE @availability_status VARCHAR(50) 

--   SELECT @troti_id = product,
--          @availability_status = 'unavailable'
--   FROM inserted

--   EXEC UpdateTrotiStatus @troti_id, @availability_status 
-- END
