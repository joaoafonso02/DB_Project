CREATE PROCEDURE CreateChat
    @cname VARCHAR(50),
    @arrayUsernames NVARCHAR(MAX)
AS
BEGIN
    DECLARE @tableUsernames TABLE (value NVARCHAR(MAX));
    DECLARE @lastId INT;
    
    -- Split the input string into rows
    INSERT INTO @tableUsernames (value)
    SELECT value FROM STRING_SPLIT(@arrayUsernames, ',');

    -- Insert rows from the array into the target table
    INSERT INTO TGroups (gname) VALUES (@cname);
    SET @lastId = SCOPE_IDENTITY();

    -- Insert group members into the TGroupMembers table
    INSERT INTO TGroupMembers (user_id, group_id)
    SELECT UAuthentication.id, @lastId
    FROM UAuthentication
    INNER JOIN @tableUsernames AS usernames ON UAuthentication.username = usernames.value;

    -- Retrieve the list of usernames and the last identity value used
    SELECT value AS Username FROM @tableUsernames;
    SELECT @lastId AS LastIdentityValue;
END;

