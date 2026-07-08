CREATE DATABASE PropertyManagementDB;
USE PropertyManagementDB;

-- 1. PROPERTIES TABLE
CREATE TABLE Properties (
    Property_ID INT PRIMARY KEY AUTO_INCREMENT,
    Property_Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    City VARCHAR(50) DEFAULT 'Vadodara',
    Property_Type ENUM('Apartment', 'Commercial', 'Condo', 'Residential') NOT NULL,
    Total_Units INT NOT NULLCHECK (Total_Units > 0)
);

-- 2. UNITS TABLE
CREATE TABLE Units (
    Unit_ID INT PRIMARY KEY AUTO_INCREMENT,
    Property_ID INT NOT NULL,
    Unit_Number VARCHAR(20) NOT NULL,
    Bedrooms INT INT DEFAULT 1,
    Bathrooms INT DEFAULT 1,
    Monthly_Rent DECIMAL(10, 2) NOT NULL CHECK (Monthly_Rent > 0),
    Availability_Status ENUM('Available', 'Occupied', 'Maintenance') DEFAULT 'Available',
    FOREIGN KEY (Property_ID) REFERENCES Properties(Property_ID) ON DELETE CASCADE
);

-- 3. TENANTS TABLE
CREATE TABLE Tenants (
    Tenant_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    Move_In_Date DATE NOT NULL
);

-- 4. LEASES TABLE
CREATE TABLE Leases (
    Lease_ID INT PRIMARY KEY AUTO_INCREMENT,
    Unit_ID INT NOT NULL,
    Tenant_ID INT NOT NULL,
    Start_Date DATE NOT NULL,
    End_Date DATE NOT NULL,
    Lease_Status ENUM('Active', 'Expired', 'Terminated') DEFAULT 'Active',
    CHECK (End_Date > Start_Date),
    FOREIGN KEY (Unit_ID) REFERENCES Units(Unit_ID),
    FOREIGN KEY (Tenant_ID) REFERENCES Tenants(Tenant_ID)
);

-- 5. PAYMENTS TABLE
CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Lease_ID INT NOT NULL,
    Payment_Date DATE NOT NULL,
    Amount_Paid DECIMAL(10, 2) NOT NULL CHECK (Amount_Paid >= 0),
    Payment_Status ENUM('Paid', 'Late', 'Pending') DEFAULT 'Paid',
    FOREIGN KEY (Lease_ID) REFERENCES Leases(Lease_ID) ON DELETE CASCADE
);

-- 6. MAINTENANCE REQUESTS TABLE
CREATE TABLE Maintenance_Requests (
    Request_ID INT PRIMARY KEY AUTO_INCREMENT,
    Property_ID INT NOT NULL,
    Unit_ID INT NOT NULL,
    Description TEXT NOT NULL,
    Request_Date DATE NOT NULL,
    Status ENUM('Open', 'In Progress', 'Resolved') DEFAULT 'Open',
    Estimated_Cost DECIMAL(10, 2) DEFAULT 0.00 CHECK (Estimated_Cost >= 0),
    FOREIGN KEY (Property_ID) REFERENCES Properties(Property_ID),
    FOREIGN KEY (Unit_ID) REFERENCES Units(Unit_ID)
);
