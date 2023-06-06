-- CREATE VIEW TrotiAvailability AS
-- SELECT Troti.id, Troti.battery, Troti.insurance_id, Troti.alarm_id, Troti.product_id, Troti.availability_status
-- FROM Troti
-- WHERE availability_status = 'Available';



-- CREATE VIEW UsersWithAuthentication AS
-- SELECT Users.id, Users.name, Users.phone, Users.email, Users.postalZip, Users.region, Users.country, 
--         UAuthentication.username, UAuthentication.upass, UAuthentication.utoken
-- FROM Users
-- INNER JOIN UAuthentication ON Users.id = UAuthentication.id;


CREATE VIEW Profile AS
SELECT Users.id, Users.name, Users.phone, Users.email, Users.postalZip, 
    Users.region, Users.country, UAuthentication.username, UAuthentication.utoken
FROM Users
INNER JOIN UAuthentication ON Users.id = UAuthentication.id;


-- CREATE VIEW AvailableTrotis AS
-- SELECT Troti.id, Troti.battery, Troti.insurance_id, Troti.alarm_id, Troti.product_id
-- FROM Troti
-- WHERE availability_status = 'Available';



-- Create indexes for region, country, and name
-- CREATE INDEX idx_region ON Users(region); 
-- CREATE INDEX idx_country ON Users(country);
-- CREATE INDEX idx_name ON Users(name);
