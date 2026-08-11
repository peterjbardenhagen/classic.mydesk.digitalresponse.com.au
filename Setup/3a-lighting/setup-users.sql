-- =============================================================================
-- 3A Lighting - User Setup SQL
-- Creates user accounts for 3A Lighting deployment:
--   - Khim (primary operator)
--   - Peter (system administrator)
--   - Template users (20, 121, 122) for testing
-- =============================================================================

-- Clear existing users from previous runs (preserve template structure)
DELETE FROM UsersAccess WHERE UserId NOT IN (SELECT UserId FROM Users WHERE Code IN ('20', '121', '122', 'Khim', 'Peter'));
DELETE FROM Users WHERE Code NOT IN ('20', '121', '122', 'Khim', 'Peter');

-- ---------------------------------------------------------------------------
-- Khim - Primary 3A Lighting Operator
-- ---------------------------------------------------------------------------
-- Get the Division ID and Location ID that should have been created by mock-data.sql
DECLARE @DivisionId INT;
DECLARE @LocationId INT;
DECLARE @KhimUserId INT;

SELECT @DivisionId = DivisionId FROM Divisions WHERE DivisionCode = '3AL';
SELECT @LocationId = LocationId FROM Locations WHERE Company = '3A Lighting Pty Ltd';

-- Insert Khim (or update if exists)
INSERT INTO Users (Code, Name, Initials, PW, UserTypeId, DivisionId, LocationId, Active, LineManagerCode, HoursPerDay, DaysPerWeek, Email, Phone)
VALUES ('Khim', 'Khim', 'KH', 'password123', 2, @DivisionId, @LocationId, -1, NULL, 8, 5, 'khim@3a-lighting.com.au', '02 5550 1234');

SELECT @KhimUserId = @@IDENTITY;

-- Grant Khim access to all 3A Lighting divisions for all modules
INSERT INTO UsersAccess (UserId, DivisionId, Visible, Manager, Quotes, RFQ, PurchaseOrders, Payroll)
VALUES (@KhimUserId, @DivisionId, -1, -1, -1, -1, -1, 0);

-- ---------------------------------------------------------------------------
-- Peter - System Administrator
-- ---------------------------------------------------------------------------
DECLARE @PeterUserId INT;

INSERT INTO Users (Code, Name, Initials, PW, UserTypeId, DivisionId, LocationId, Active, LineManagerCode, HoursPerDay, DaysPerWeek, Email, Phone)
VALUES ('Peter', 'Peter Bardenhagen', 'PB', 'password123', 1, @DivisionId, @LocationId, -1, NULL, 8, 5, 'peter@bardenhagen.xyz', '02 5550 1234');

SELECT @PeterUserId = @@IDENTITY;

-- Grant Peter (admin) access to all divisions for all modules
INSERT INTO UsersAccess (UserId, DivisionId, Visible, Manager, Quotes, RFQ, PurchaseOrders, Payroll)
VALUES (@PeterUserId, @DivisionId, -1, -1, -1, -1, -1, -1);

-- ---------------------------------------------------------------------------
-- Template Users (preserved for testing)
-- ---------------------------------------------------------------------------
-- These users already exist from template setup; ensure they have access if missing
DECLARE @User20Id INT;
DECLARE @User121Id INT;
DECLARE @User122Id INT;

SELECT @User20Id = UserId FROM Users WHERE Code = '20';
SELECT @User121Id = UserId FROM Users WHERE Code = '121';
SELECT @User122Id = UserId FROM Users WHERE Code = '122';

-- Ensure template users have access to 3AL division
IF @User20Id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM UsersAccess WHERE UserId = @User20Id AND DivisionId = @DivisionId)
BEGIN
    INSERT INTO UsersAccess (UserId, DivisionId, Visible, Manager, Quotes, RFQ, PurchaseOrders, Payroll)
    VALUES (@User20Id, @DivisionId, -1, -1, -1, -1, -1, 0);
END

IF @User121Id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM UsersAccess WHERE UserId = @User121Id AND DivisionId = @DivisionId)
BEGIN
    INSERT INTO UsersAccess (UserId, DivisionId, Visible, Manager, Quotes, RFQ, PurchaseOrders, Payroll)
    VALUES (@User121Id, @DivisionId, -1, 0, -1, -1, -1, 0);
END

IF @User122Id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM UsersAccess WHERE UserId = @User122Id AND DivisionId = @DivisionId)
BEGIN
    INSERT INTO UsersAccess (UserId, DivisionId, Visible, Manager, Quotes, RFQ, PurchaseOrders, Payroll)
    VALUES (@User122Id, @DivisionId, -1, 0, -1, -1, -1, 0);
END
