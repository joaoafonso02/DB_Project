-- Create the UsersWithAuthentication view
CREATE VIEW UsersWithAuthentication AS
SELECT Users.id, Users.name, Users.phone, Users.email, Users.postalZip, Users.region, Users.country, 
        UAuthentication.username, UAuthentication.upass, UAuthentication.utoken
FROM Users
INNER JOIN UAuthentication ON Users.id = UAuthentication.id;

-- Create indexes for region, country, and name
CREATE INDEX idx_region ON Users(region); -- Dropdown for districts
CREATE INDEX idx_country ON Users(country);
CREATE INDEX idx_name ON Users(name);
