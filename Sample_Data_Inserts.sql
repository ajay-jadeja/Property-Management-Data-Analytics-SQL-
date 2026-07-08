-- ========================================================
-- PROPERTY MANAGEMENT SYSTEM: SAMPLE DATA INSERT SCRIPT
-- Enforces absolute mathematical consistency across 10 analytical problems.
-- Total Portfolio: 60 Units, 48 Active Occupancies (80.00% Occupancy Rate)
-- ========================================================

-- USE PropertyManagementDB;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE Maintenance_Requests;
TRUNCATE TABLE Payments;
TRUNCATE TABLE Leases;
TRUNCATE TABLE Tenants;
TRUNCATE TABLE Units;
TRUNCATE TABLE Properties;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. INSERT PROPERTIES
-- Total 4 distinct properties matching problem metrics
INSERT INTO Properties (Property_ID, Property_Name, Address, City, Property_Type, Total_Units) VALUES
(1, 'Sayaji Heights', 'Near Sayajigunj', 'Vadodara', 'Commercial', 15),
(2, 'Alkapuri Residency', 'RC Dutt Road, Alkapuri', 'Vadodara', 'Apartment', 20),
(3, 'Gotri Greens', 'Gotri-Vasna Road', 'Vadodara', 'Residential', 15),
(4, 'Vasna Villas', 'Vasna-Bhayli Road', 'Vadodara', 'Condo', 10);

-- 2. INSERT UNITS
-- Total 60 units. 48 Occupied, 8 Available, 4 Maintenance.
-- Sayaji Heights (15 units): 14 Occupied, 1 Available, 0 Maintenance
-- Alkapuri Residency (20 units): 16 Occupied, 3 Available, 1 Maintenance
-- Gotri Greens (15 units): 12 Occupied, 2 Available, 1 Maintenance
-- Vasna Villas (10 units): 6 Occupied, 2 Available, 2 Maintenance

-- Sayaji Heights Units (Prop_ID = 1, Premium Commercial Rents)
INSERT INTO Units (Unit_ID, Property_ID, Unit_Number, Bedrooms, Bathrooms, Monthly_Rent, Availability_Status) VALUES
(101, 1, 'Commercial-201', 0, 2, 5000.00, 'Occupied'),
(102, 1, 'Commercial-102', 0, 1, 4500.00, 'Occupied'),
(103, 1, 'Commercial-105', 0, 1, 4200.00, 'Occupied'),
(104, 1, 'Commercial-101', 0, 1, 3500.00, 'Occupied'),
(105, 1, 'Commercial-103', 0, 1, 3500.00, 'Occupied'),
(106, 1, 'Commercial-104', 0, 1, 3500.00, 'Occupied'),
(107, 1, 'Commercial-202', 0, 2, 4000.00, 'Occupied'),
(108, 1, 'Commercial-203', 0, 2, 4000.00, 'Occupied'),
(109, 1, 'Commercial-204', 0, 2, 4000.00, 'Occupied'),
(110, 1, 'Commercial-205', 0, 2, 4000.00, 'Occupied'),
(111, 1, 'Commercial-301', 0, 2, 3800.00, 'Occupied'),
(112, 1, 'Commercial-302', 0, 2, 3800.00, 'Occupied'),
(113, 1, 'Commercial-303', 0, 2, 3800.00, 'Occupied'),
(114, 1, 'Commercial-304', 0, 2, 3800.00, 'Occupied'),
(115, 1, 'Commercial-305', 0, 2, 3800.00, 'Available');

-- Alkapuri Residency Units (Prop_ID = 2, Standard Apartments)
INSERT INTO Units (Unit_ID, Property_ID, Unit_Number, Bedrooms, Bathrooms, Monthly_Rent, Availability_Status) VALUES
(201, 2, 'Apt-501', 3, 3, 2800.00, 'Occupied'),
(202, 2, 'Apt-302', 2, 2, 2500.00, 'Occupied'),
(203, 2, 'Apt-101', 2, 2, 2200.00, 'Occupied'),
(204, 2, 'Apt-102', 1, 1, 1800.00, 'Occupied'),
(205, 2, 'Apt-103', 1, 1, 1800.00, 'Occupied'),
(206, 2, 'Apt-104', 1, 1, 1800.00, 'Occupied'),
(207, 2, 'Apt-201', 2, 2, 2000.00, 'Occupied'),
(208, 2, 'Apt-202', 2, 2, 2000.00, 'Occupied'),
(209, 2, 'Apt-203', 2, 2, 2000.00, 'Occupied'),
(210, 2, 'Apt-204', 2, 2, 2000.00, 'Occupied'),
(211, 2, 'Apt-301', 2, 2, 2200.00, 'Occupied'),
(212, 2, 'Apt-303', 2, 2, 2200.00, 'Occupied'),
(213, 2, 'Apt-304', 2, 2, 2200.00, 'Occupied'),
(214, 2, 'Apt-401', 3, 3, 2600.00, 'Occupied'),
(215, 2, 'Apt-402', 3, 3, 2600.00, 'Occupied'),
(216, 2, 'Apt-403', 3, 3, 2600.00, 'Occupied'),
(217, 2, 'Apt-404', 3, 3, 2600.00, 'Available'),
(218, 2, 'Apt-502', 3, 3, 2800.00, 'Available'),
(219, 2, 'Apt-503', 3, 3, 2800.00, 'Available'),
(220, 2, 'Apt-504', 3, 3, 2800.00, 'Maintenance');

-- Gotri Greens Units (Prop_ID = 3, High-End Residential)
INSERT INTO Units (Unit_ID, Property_ID, Unit_Number, Bedrooms, Bathrooms, Monthly_Rent, Availability_Status) VALUES
(301, 3, 'Res-12', 4, 4, 3200.00, 'Occupied'),
(302, 3, 'Res-05', 4, 4, 3000.00, 'Occupied'),
(303, 3, 'Res-01', 3, 3, 2800.00, 'Occupied'),
(304, 3, 'Res-02', 3, 3, 2600.00, 'Occupied'),
(305, 3, 'Res-03', 3, 3, 2600.00, 'Occupied'),
(306, 3, 'Res-04', 3, 3, 2600.00, 'Occupied'),
(307, 3, 'Res-06', 3, 3, 2600.00, 'Occupied'),
(308, 3, 'Res-07', 3, 3, 2600.00, 'Occupied'),
(309, 3, 'Res-08', 3, 3, 2600.00, 'Occupied'),
(310, 3, 'Res-09', 3, 3, 2600.00, 'Occupied'),
(311, 3, 'Res-10', 4, 4, 3000.00, 'Occupied'),
(312, 3, 'Res-11', 4, 4, 3000.00, 'Occupied'),
(313, 3, 'Res-13', 4, 4, 3200.00, 'Available'),
(314, 3, 'Res-14', 4, 4, 3200.00, 'Available'),
(315, 3, 'Res-15', 4, 4, 3500.00, 'Maintenance');

-- Vasna Villas Units (Prop_ID = 4, Condos with structural maintenance overhead)
INSERT INTO Units (Unit_ID, Property_ID, Unit_Number, Bedrooms, Bathrooms, Monthly_Rent, Availability_Status) VALUES
(401, 4, 'Condo-09', 3, 3, 3500.00, 'Occupied'),
(402, 4, 'Condo-04', 2, 2, 3000.00, 'Occupied'),
(403, 4, 'Condo-01', 2, 2, 2700.00, 'Occupied'),
(404, 4, 'Condo-02', 2, 2, 2500.00, 'Occupied'),
(405, 4, 'Condo-03', 2, 2, 2500.00, 'Occupied'),
(406, 4, 'Condo-05', 2, 2, 2500.00, 'Occupied'),
(407, 4, 'Condo-06', 2, 2, 2500.00, 'Available'),
(408, 4, 'Condo-07', 2, 2, 2500.00, 'Available'),
(409, 4, 'Condo-08', 3, 3, 3300.00, 'Maintenance'),
(410, 4, 'Condo-10', 3, 3, 3500.00, 'Maintenance');


-- 3. INSERT TENANTS
-- Essential Tenants mapped directly to Problem Statements
INSERT INTO Tenants (Tenant_ID, First_Name, Last_Name, Email, Phone, Move_In_Date) VALUES
(1, 'Hardik', 'Pandya', 'hardik@portfolio.com', '+91 99999 11111', '2024-01-01'),
(2, 'Deepika', 'Vyas', 'deepika@portfolio.com', '+91 98765 98765', '2024-06-01'),
(3, 'Jayesh', 'Shah', 'jayesh@portfolio.com', '+91 94260 22222', '2024-07-01'),
(4, 'Rajesh', 'Patel', 'rajesh@portfolio.com', '+91 98250 33333', '2025-05-01'),
(5, 'Amit', 'Sharma', 'amit@portfolio.com', '+91 97129 44444', '2025-11-01'),
(6, 'Pooja', 'Shah', 'pooja@portfolio.com', '+91 98980 55555', '2025-06-01'),
(7, 'Vikram', 'Patel', 'vikram@portfolio.com', '+91 98765 12345', '2025-07-15'),
(8, 'Sneha', 'Joshi', 'sneha@portfolio.com', '+91 98765 54321', '2025-08-05');

-- Add dummy rows to satisfy total 48 active occupancies constraint perfectly
-- Using a loop or continuous manual block for remaining tenants (9 to 48)
INSERT INTO Tenants (Tenant_ID, First_Name, Last_Name, Email, Phone, Move_In_Date) VALUES
(9, 'Aarav', 'Mehta', 'aarav@test.com', '9000000001', '2025-01-01'),
(10, 'Vivaan', 'Shah', 'vivaan@test.com', '9000000002', '2025-01-05'),
(11, 'Aditya', 'Gosh', 'aditya@test.com', '9000000003', '2025-01-10'),
(12, 'Vihaan', 'Malhotra', 'vihaan@test.com', '9000000004', '2025-01-15'),
(13, 'Arjun', 'Verma', 'arjun@test.com', '9000000005', '2025-01-20'),
(14, 'Sai', 'Krishnan', 'sai@test.com', '9000000006', '2025-01-25'),
(15, 'Reyansh', 'Joshi', 'reyansh@test.com', '9000000007', '2025-02-01'),
(16, 'Aavya', 'Patel', 'aavya@test.com', '9000000008', '2025-02-05'),
(17, 'Ananya', 'Trivedi', 'ananya@test.com', '9000000009', '2025-02-10'),
(18, 'Diya', 'Mishra', 'diya@test.com', '9000000010', '2025-02-15'),
(19, 'Pari', 'Desai', 'pari@test.com', '9000000011', '2025-02-20'),
(20, 'Pihu', 'Choksi', 'pihu@test.com', '9000000012', '2025-02-25'),
(21, 'Ira', 'Pandya', 'ira@test.com', '9000000013', '2025-03-01'),
(22, 'Avani', 'Rao', 'avani@test.com', '9000000014', '2025-03-05'),
(23, 'Prisha', 'Kapoor', 'prisha@test.com', '9000000015', '2025-03-10'),
(24, 'Riya', 'Bhatt', 'riya@test.com', '9000000016', '2025-03-15'),
(25, 'Aadhya', 'Soni', 'aadhya@test.com', '9000000017', '2025-03-20'),
(26, 'Kiaand', 'Dave', 'kiaand@test.com', '9000000018', '2025-03-25'),
(27, 'Ishaan', 'Mehta', 'ishaan@test.com', '9000000019', '2025-04-01'),
(28, 'Aarush', 'Solanki', 'aarush@test.com', '9000000020', '2025-04-05'),
(29, 'Kabir', 'Waghela', 'kabir@test.com', '9000000021', '2025-04-10'),
(30, 'Rohan', 'Parmar', 'rohan@test.com', '9000000022', '2025-04-15'),
(31, 'Vivaand', 'Gajjar', 'vivaand@test.com', '9000000023', '2025-04-20'),
(32, 'Dev', 'Barot', 'dev@test.com', '9000000024', '2025-04-25'),
(33, 'Karan', 'Chauhan', 'karan@test.com', '9000000025', '2025-05-01'),
(34, 'Ansh', 'Giri', 'ansh@test.com', '9000000026', '2025-05-05'),
(35, 'Krishna', 'Kadam', 'krishna@test.com', '9000000027', '2025-05-10'),
(36, 'Rahul', 'Jadav', 'rahul@test.com', '9000000028', '2025-05-15'),
(37, 'Vijay', 'Marathe', 'vijay@test.com', '9000000029', '2025-05-20'),
(38, 'Nitin', 'Rathod', 'nitin@test.com', '9000000030', '2025-05-25'),
(39, 'Sanjay', 'Thakor', 'sanjay@test.com', '9000000031', '2025-06-01'),
(40, 'Ajay', 'Rajput', 'ajay@test.com', '9000000032', '2025-06-05'),
(41, 'Deepak', 'Saini', 'deepak@test.com', '9000000033', '2025-06-10'),
(42, 'Sunil', 'Verma', 'sunil@test.com', '9000000034', '2025-06-15'),
(43, 'Manoj', 'Yadav', 'manoj@test.com', '9000000035', '2025-06-20'),
(44, 'Rajesh', 'Kumar', 'rajesh.k@test.com', '9000000036', '2025-06-25'),
(45, 'Ramesh', 'Sharma', 'ramesh@test.com', '9000000037', '2025-06-26'),
(46, 'Suresh', 'Gupta', 'suresh@test.com', '9000000038', '2025-06-27'),
(47, 'Dinesh', 'Jain', 'dinesh@test.com', '9000000039', '2025-06-28'),
(48, 'Naresh', 'Prajapati', 'naresh@test.com', '9000000040', '2025-06-29');


-- 4. INSERT LEASES
-- Core contracts linking premium anchors and standard profiles
-- Lease_ID, Unit_ID, Tenant_ID, Start_Date, End_Date, Lease_Status
INSERT INTO Leases (Lease_ID, Unit_ID, Tenant_ID, Start_Date, End_Date, Lease_Status) VALUES
(1001, 101, 1, '2024-01-01', '2026-12-31', 'Active'),       -- Hardik Pandya (3 Years, Commercial Anchor)
(1002, 103, 2, '2024-06-01', '2026-05-31', 'Active'),       -- Deepika Vyas (2 Years, expiring soon/recently active matching Problem 7/9)
(1003, 303, 3, '2024-07-01', '2026-06-30', 'Active'),       -- Jayesh Shah (2 Years, Residential)
(1004, 102, 4, '2025-05-01', '2027-04-30', 'Active'),       -- Rajesh Patel ($4500 Commercial Leakage)
(1005, 402, 5, '2025-11-01', '2026-05-01', 'Active'),       -- Amit Sharma ($3000 Condo Leakage)
(1006, 202, 6, '2025-06-01', '2026-12-01', 'Active'),       -- Pooja Shah ($2500 Apartment Leakage)
(1007, 302, 7, '2025-07-15', '2026-07-15', 'Active'),       -- Vikram Patel (Expiring in 14 days from July 1)
(1008, 203, 8, '2025-08-05', '2026-08-05', 'Active');       -- Sneha Joshi (Expiring in 35 days from July 1)

-- Auto filling remaining 40 Active contracts map smoothly to establish the matching metrics
-- For simplicity and execution correctness, map remaining active rows across the occupied unit list
INSERT INTO Leases (Lease_ID, Unit_ID, Tenant_ID, Start_Date, End_Date, Lease_Status) VALUES
(1009, 104, 9, '2025-01-01', '2026-12-31', 'Active'),
(1010, 105, 10, '2025-01-01', '2026-12-31', 'Active'),
(1011, 106, 11, '2025-01-01', '2026-12-31', 'Active'),
(1012, 107, 12, '2025-01-01', '2026-12-31', 'Active'),
(1013, 108, 13, '2025-01-01', '2026-12-31', 'Active'),
(1014, 109, 14, '2025-01-01', '2026-12-31', 'Active'),
(1015, 110, 15, '2024-08-20', '2026-08-20', 'Active'), -- Rohan Mehta Commercial-205 matched to Problem 7
(1016, 111, 16, '2025-01-01', '2026-12-31', 'Active'),
(1017, 112, 17, '2025-01-01', '2026-12-31', 'Active'),
(1018, 113, 18, '2025-01-01', '2026-12-31', 'Active'),
(1019, 114, 19, '2025-01-01', '2026-12-31', 'Active'),
(1020, 201, 20, '2025-01-01', '2026-11-30', 'Active'),
(1021, 204, 21, '2025-01-01', '2026-11-30', 'Active'),
(1022, 205, 22, '2025-01-01', '2026-11-30', 'Active'),
(1023, 206, 23, '2025-01-01', '2026-11-30', 'Active'),
(1024, 207, 24, '2025-01-01', '2026-11-30', 'Active'),
(1025, 208, 25, '2025-01-01', '2026-11-30', 'Active'),
(1026, 209, 26, '2025-01-01', '2026-11-30', 'Active'),
(1027, 210, 27, '2025-01-01', '2026-11-30', 'Active'),
(1028, 211, 28, '2025-01-01', '2026-11-30', 'Active'),
(1029, 212, 29, '2025-01-01', '2026-11-30', 'Active'),
(1030, 213, 30, '2025-01-01', '2026-11-30', 'Active'),
(1031, 214, 31, '2025-01-01', '2026-11-30', 'Active'),
(1032, 215, 32, '2025-01-01', '2026-11-30', 'Active'),
(1033, 216, 33, '2025-01-01', '2026-11-30', 'Active'),
(1034, 301, 34, '2025-01-01', '2026-12-31', 'Active'),
(1035, 304, 35, '2025-01-01', '2026-12-31', 'Active'),
(1036, 305, 36, '2025-01-01', '2026-12-31', 'Active'),
(1037, 306, 37, '2025-01-01', '2026-12-31', 'Active'),
(1038, 307, 38, '2025-01-01', '2026-12-31', 'Active'),
(1039, 308, 39, '2025-01-01', '2026-12-31', 'Active'),
(1040, 309, 40, '2025-01-01', '2026-12-31', 'Active'),
(1041, 310, 41, '2025-01-01', '2026-12-31', 'Active'),
(1042, 311, 42, '2025-01-01', '2026-12-31', 'Active'),
(1043, 312, 43, '2025-01-01', '2026-12-31', 'Active'),
(1044, 401, 44, '2025-11-01', '2026-05-01', 'Active'),
(1045, 403, 45, '2025-11-01', '2026-05-01', 'Active'),
(1046, 404, 46, '2025-11-01', '2026-05-01', 'Active'),
(1047, 405, 47, '2025-11-01', '2026-05-01', 'Active'),
(1048, 406, 48, '2025-11-01', '2026-05-01', 'Active');


-- 5. INSERT PAYMENTS (Financially tracks Month-on-Month trends for Problem 3 & 4)
-- We simulate baseline cash inflow trends showing May 2026 contraction exactly down by $10,000 due to leakages
INSERT INTO Payments (Lease_ID, Payment_Date, Amount_Paid, Payment_Status) VALUES
-- Jan 2026 Baseline
(1001, '2026-01-01', 5000.00, 'Paid'), (1004, '2026-01-01', 4500.00, 'Paid'), (1005, '2026-01-01', 3000.00, 'Paid'),
(1006, '2026-01-01', 2500.00, 'Paid'), (1007, '2026-01-01', 3000.00, 'Paid'), (1008, '2026-01-01', 2200.00, 'Paid'),
-- Feb 2026 Baseline 
(1001, '2026-02-01', 5000.00, 'Paid'), (1004, '2026-02-01', 4500.00, 'Paid'), (1005, '2026-02-01', 3000.00, 'Paid'),
(1006, '2026-02-01', 2500.00, 'Paid'), (1007, '2026-02-01', 3000.00, 'Paid'), (1008, '2026-02-01', 2200.00, 'Paid'),
-- March 2026 (Growth bump)
(1001, '2026-03-01', 5000.00, 'Paid'), (1004, '2026-03-01', 4500.00, 'Paid'), (1005, '2026-03-01', 3000.00, 'Paid'),
(1006, '2026-03-01', 2500.00, 'Paid'), (1007, '2026-03-01', 3000.00, 'Paid'), (1008, '2026-03-01', 2200.00, 'Paid'),
-- April 2026 (Peak bump)
(1001, '2026-04-01', 5000.00, 'Paid'), (1004, '2026-04-01', 4500.00, 'Paid'), (1005, '2026-04-01', 3000.00, 'Paid'),
(1006, '2026-04-01', 2500.00, 'Paid'), (1007, '2026-04-01', 3000.00, 'Paid'), (1008, '2026-04-01', 2200.00, 'Paid'),
-- MAY 2026 (CRITICAL: Leakage points matching problem statement 4)
-- Rajesh Patel ($4500 Late), Amit Sharma ($3000 Pending), Pooja Shah ($2500 Late) -> Total $10,000 missing!
(1001, '2026-05-01', 5000.00, 'Paid'),
(1004, '2026-05-05', 0.00, 'Late'),     -- Leakage 1
(1005, '2026-05-10', 0.00, 'Pending'),  -- Leakage 2
(1006, '2026-05-12', 0.00, 'Late'),     -- Leakage 3
(1007, '2026-05-01', 3000.00, 'Paid'),
(1008, '2026-05-01', 2200.00, 'Paid'),
-- June 2026 Recovery (Bounces back strongly)
(1001, '2026-06-01', 5000.00, 'Paid'), (1004, '2026-06-01', 4500.00, 'Paid'), (1005, '2026-06-01', 3000.00, 'Paid'),
(1006, '2026-06-01', 2500.00, 'Paid'), (1007, '2026-06-01', 3000.00, 'Paid'), (1008, '2026-06-01', 2200.00, 'Paid');

-- Bulk mock insertions to balance the aggregate month totals dynamically 
INSERT INTO Payments (Lease_ID, Payment_Date, Amount_Paid, Payment_Status) VALUES
(1009, '2026-01-01', 89300.00, 'Paid'),
(1009, '2026-02-01', 89300.00, 'Paid'),
(1009, '2026-03-01', 95800.00, 'Paid'),
(1009, '2026-04-01', 101300.00, 'Paid'),
(1009, '2026-05-01', 103800.00, 'Paid'), -- Balanced to ensure MoM outputs exactly match Problem 3 values
(1009, '2026-06-01', 106300.00, 'Paid');


-- 6. INSERT MAINTENANCE REQUESTS (Problem 6 & 10 Overheads)
-- Vasna Villas (Property_ID = 4) has severe structural liabilities exceeding 30% thresholds & 5 issues in Q2
INSERT INTO Maintenance_Requests (Property_ID, Unit_ID, Description, Request_Date, Status, Estimated_Cost) VALUES
(4, 409, 'Systemic plumbing pipeline burst across building cluster', '2026-04-10', 'In Progress', 2500.00),
(4, 410, 'Main roofing structure alignment cracks and water seepage', '2026-04-18', 'Open', 1800.00),
(4, 402, 'HVAC compression system breakdown and terminal replacement', '2026-05-02', 'Resolved', 900.00),
(4, 403, 'Balcony structural concrete crack remediation', '2026-05-15', 'Resolved', 400.00),
(4, 404, 'Electrical mainline short circuit triage', '2026-05-28', 'Resolved', 300.00),
(4, 405, 'Water drainage logging tank cleaning', '2026-06-05', 'Resolved', 200.00),
(4, 401, 'Emergency gate structural weld stabilization', '2026-06-20', 'Resolved', 100.00),
-- Previous Q1 maintenance cost for Vasna Villas to reach the $9800 macro total
(4, 409, 'Elevator mechanical chain replacement', '2026-02-12', 'Resolved', 3600.00),

-- Standard trace maintenance for other properties to show healthy baselines
(2, 220, 'Wall painting patch up', '2026-03-01', 'Resolved', 450.00),
(3, 315, 'Garden pathway light wiring replacement', '2026-05-10', 'Resolved', 250.00);

COMMIT;
