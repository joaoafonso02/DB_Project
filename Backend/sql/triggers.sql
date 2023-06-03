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

CREATE TRIGGER UpdateTrotiAvailability
ON TrotiRentals
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
  SET NOCOUNT ON;

  UPDATE Troti
  SET availability_status = CASE
    WHEN TrotiRentals.troti_id IS NULL THEN 'Available'
    ELSE 'Rented'
  END
  FROM Troti
  LEFT JOIN TrotiRentals ON Troti.id = TrotiRentals.troti_id;
END;