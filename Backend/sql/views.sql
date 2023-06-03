-- CREATE VIEW TrotiAvailability AS
-- SELECT Troti.id, Troti.battery, Troti.insurance_id, Troti.alarm_id, Troti.product_id,
--        CASE WHEN TrotiRentals.troti_id IS NULL THEN 'Available' ELSE 'Rented' END AS availability_status
-- FROM Troti
-- LEFT JOIN TrotiRentals ON Troti.id = TrotiRentals.troti_id;


-- CREATE VIEW UsersWithAuthentication AS
-- SELECT Users.id, Users.name, Users.phone, Users.email, Users.postalZip, Users.region, Users.country, 
--         UAuthentication.username, UAuthentication.upass, UAuthentication.utoken
-- FROM Users
-- INNER JOIN UAuthentication ON Users.id = UAuthentication.id;

-- CREATE VIEW AvailableTrotis AS
-- SELECT Troti.id, Troti.battery, Troti.insurance_id, Troti.alarm_id, Troti.product_id
-- FROM Troti
-- WHERE availability_status = 'Available';



-- -- -- Create indexes for region, country, and name
-- -- -- CREATE INDEX idx_region ON Users(region); -- Dropdown for districts
-- -- -- CREATE INDEX idx_country ON Users(country);
-- -- -- CREATE INDEX idx_name ON Users(name);
