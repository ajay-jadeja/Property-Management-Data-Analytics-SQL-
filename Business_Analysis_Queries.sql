-- ========================================================
-- PROPERTY MANAGEMENT SYSTEM: ADVANCED ANALYTICS ENGINE
-- Contains 10 production-ready queries mapped to the portfolio README.
-- Built using Window Functions, CTEs, Multi-Table Joins, and Aggregations.
-- ========================================================

-- USE PropertyManagementDB;

-- --------------------------------------------------------
-- 1. Global Occupancy Rate Analysis
-- Objective: Calculate total units, active occupied units, and portfolio occupancy rate.
-- --------------------------------------------------------
SELECT 
    COUNT(Unit_ID) AS Total_Portfolio_Units,
    SUM(CASE WHEN Availability_Status = 'Occupied' THEN 1 ELSE 0 END) AS Occupied_Units,
    ROUND(
        (SUM(CASE WHEN Availability_Status = 'Occupied' THEN 1 ELSE 0 END) * 100.0) / COUNT(Unit_ID), 
        2
    ) AS Occupancy_Rate_Percentage
FROM 
    Units;


-- --------------------------------------------------------
-- 2. Property-Wise Performance Metrics
-- Objective: Evaluate capacity, active tenant counts, and specific status distributions per asset.
-- --------------------------------------------------------
SELECT 
    p.Property_Name,
    p.Property_Type,
    COUNT(u.Unit_ID) AS Total_Units,
    SUM(CASE WHEN u.Availability_Status = 'Occupied' THEN 1 ELSE 0 END) AS Active_Occupancies,
    SUM(CASE WHEN u.Availability_Status = 'Available' THEN 1 ELSE 0 END) AS Vacant_Units,
    SUM(CASE WHEN u.Availability_Status = 'Maintenance' THEN 1 ELSE 0 END) AS Under_Maintenance,
    ROUND(
        (SUM(CASE WHEN u.Availability_Status = 'Occupied' THEN 1 ELSE 0 END) * 100.0) / COUNT(u.Unit_ID), 
        2
    ) AS Property_Occupancy_Rate_Percentage
FROM 
    Properties p
LEFT JOIN 
    Units u ON p.Property_ID = u.Property_ID
GROUP BY 
    p.Property_ID, p.Property_Name, p.Property_Type
ORDER BY 
    Property_Occupancy_Rate_Percentage DESC;


-- --------------------------------------------------------
-- 3. Month-on-Month (MoM) Revenue Streams
-- Objective: Tracks cumulative cash inflows month-by-month to capture variations.
-- --------------------------------------------------------
WITH Monthly_Revenue AS (
    SELECT 
        DATE_FORMAT(Payment_Date, '%Y-%m') AS Payment_Month,
        SUM(Amount_Paid) AS Current_Month_Revenue
    FROM 
        Payments
    WHERE 
        Payment_Status = 'Paid'
    GROUP BY 
        DATE_FORMAT(Payment_Date, '%Y-%m')
),
Revenue_Comparison AS (
    SELECT 
        Payment_Month,
        Current_Month_Revenue,
        LAG(Current_Month_Revenue, 1) OVER (ORDER BY Payment_Month) AS Previous_Month_Revenue
    FROM 
        Monthly_Revenue
)
SELECT 
    Payment_Month,
    Current_Month_Revenue,
    COALESCE(Previous_Month_Revenue, 0.00) AS Previous_Month_Revenue,
    ROUND(Current_Month_Revenue - COALESCE(Previous_Month_Revenue, Current_Month_Revenue), 2) AS Net_Change,
    CASE 
        WHEN Previous_Month_Revenue IS NULL THEN '0.00%'
        ELSE CONCAT(ROUND(((Current_Month_Revenue - Previous_Month_Revenue) / Previous_Month_Revenue) * 100.0, 2), '%')
    END AS MoM_Growth_Percentage
FROM 
    Revenue_Comparison;


-- --------------------------------------------------------
-- 4. Revenue Leakage Tracking
-- Objective: Extract active leases whose latest payment status is delinquent.
-- --------------------------------------------------------
WITH RankedPayments AS (
    SELECT 
        l.Lease_ID,
        l.Tenant_ID,
        l.Unit_ID,
        p.Payment_Date,
        p.Amount_Paid,
        p.Payment_Status,
        ROW_NUMBER() OVER(PARTITION BY l.Lease_ID ORDER BY p.Payment_Date DESC) as rn
    FROM 
        Leases l
    JOIN 
        Payments p ON l.Lease_ID = p.Lease_ID
    WHERE 
        l.Lease_Status = 'Active'
)
SELECT 
    CONCAT(t.First_Name, ' ', t.Last_Name) AS Tenant_Name,
    pr.Property_Name,
    u.Unit_Number,
    u.Monthly_Rent AS Expected_Rent,
    rp.Payment_Status AS Latest_Payment_Status,
    rp.Payment_Date AS Last_Transaction_Date
FROM 
    RankedPayments rp
JOIN 
    Tenants t ON rp.Tenant_ID = t.Tenant_ID
JOIN 
    Units u ON rp.Unit_ID = u.Unit_ID
JOIN 
    Properties pr ON u.Property_ID = pr.Property_ID
WHERE 
    rp.rn = 1 
    AND rp.Payment_Status IN ('Late', 'Pending')
ORDER BY 
    Expected_Rent DESC;


-- --------------------------------------------------------
-- 5. High-Value Rent Brackets
-- Objective: Rank the top 3 highest-paying units within each specific Property_Type category.
-- --------------------------------------------------------
WITH Ranked_Rentals AS (
    SELECT 
        p.Property_Type,
        p.Property_Name,
        u.Unit_Number,
        u.Monthly_Rent,
        DENSE_RANK() OVER (
            PARTITION BY p.Property_Type 
            ORDER BY u.Monthly_Rent DESC
        ) AS Rent_Rank
    FROM 
        Properties p
    JOIN 
        Units u ON p.Property_ID = u.Property_ID
)
SELECT 
    Property_Type,
    Property_Name,
    Unit_Number,
    Monthly_Rent,
    Rent_Rank
FROM 
    Ranked_Rentals
WHERE 
    Rent_Rank <= 3
ORDER BY 
    Property_Type ASC, 
    Rent_Rank ASC;


-- --------------------------------------------------------
-- 6. Maintenance Liability Outliers
-- Objective: Highlight locations where repair costs cross 30% of max potential yields.
-- --------------------------------------------------------
WITH Property_Yields AS (
    SELECT 
        p.Property_ID,
        p.Property_Name,
        SUM(u.Monthly_Rent) AS Potential_Monthly_Yield
    FROM 
        Properties p
    JOIN 
        Units u ON p.Property_ID = u.Property_ID
    GROUP BY 
        p.Property_ID, p.Property_Name
),
Property_Maintenance AS (
    SELECT 
        Property_ID,
        SUM(Estimated_Cost) AS Total_Maintenance_Cost
    FROM 
        Maintenance_Requests
    GROUP BY 
        Property_ID
)
SELECT 
    py.Property_Name,
    py.Potential_Monthly_Yield,
    COALESCE(pm.Total_Maintenance_Cost, 0.00) AS Total_Maintenance_Cost,
    ROUND(
        (COALESCE(pm.Total_Maintenance_Cost, 0.00) * 100.0) / py.Potential_Monthly_Yield, 
        2
    ) AS Cost_To_Yield_Percentage
FROM 
    Property_Yields py
JOIN 
    Property_Maintenance pm ON py.Property_ID = pm.Property_ID
WHERE 
    (COALESCE(pm.Total_Maintenance_Cost, 0.00) * 100.0) / py.Potential_Monthly_Yield > 30.00
ORDER BY 
    Cost_To_Yield_Percentage DESC;


-- --------------------------------------------------------
-- 7. Lease Expiry Pipeline Risk
-- Objective: Proactive early-warning report for agreements ending within 60 days of anchor date.
-- --------------------------------------------------------
SELECT 
    l.Lease_ID,
    p.Property_Name,
    u.Unit_Number,
    CONCAT(t.First_Name, ' ', t.Last_Name) AS Tenant_Name,
    t.Phone AS Tenant_Contact,
    l.End_Date AS Lease_Expiry_Date,
    DATEDIFF(l.End_Date, '2026-07-01') AS Days_Until_Expiry,
    u.Monthly_Rent AS Revenue_At_Risk
FROM 
    Leases l
JOIN 
    Units u ON l.Unit_ID = u.Unit_ID
JOIN 
    Properties p ON u.Property_ID = p.Property_ID
JOIN 
    Tenants t ON l.Tenant_ID = t.Tenant_ID
WHERE 
    l.Lease_Status = 'Active'
    AND l.End_Date BETWEEN '2026-07-01' AND DATE_ADD('2026-07-01', INTERVAL 60 DAY)
ORDER BY 
    l.End_Date ASC;


-- --------------------------------------------------------
-- 8. Average Turnover Velocities
-- Objective: Measure baseline running lease timelines segmented cleanly by property classes.
-- --------------------------------------------------------
SELECT 
    p.Property_Type,
    COUNT(l.Lease_ID) AS Total_Active_Leases,
    ROUND(AVG(DATEDIFF(l.End_Date, l.Start_Date)), 0) AS Avg_Lease_Duration_Days,
    ROUND(AVG(DATEDIFF(l.End_Date, l.Start_Date)) / 30.4, 1) AS Avg_Lease_Duration_Months
FROM 
    Properties p
JOIN 
    Units u ON p.Property_ID = u.Property_ID
JOIN 
    Leases l ON u.Unit_ID = l.Unit_ID
WHERE 
    l.Lease_Status = 'Active'
GROUP BY 
    p.Property_Type
ORDER BY 
    Avg_Lease_Duration_Days DESC;


-- --------------------------------------------------------
-- 9. Tenant Loyalty Standouts
-- Objective: Pull core reliable client accounts crossing the 2 consecutive year milestone.
-- --------------------------------------------------------
SELECT 
    t.Tenant_ID,
    CONCAT(t.First_Name, ' ', t.Last_Name) AS Tenant_Name,
    p.Property_Name,
    p.Property_Type,
    u.Unit_Number,
    l.Start_Date AS Original_Move_In,
    l.End_Date AS Current_Lease_Expiry,
    DATEDIFF(l.End_Date, l.Start_Date) AS Total_Continuous_Days,
    ROUND(DATEDIFF(l.End_Date, l.Start_Date) / 365.0, 1) AS Continuous_Years
FROM 
    Tenants t
JOIN 
    Leases l ON t.Tenant_ID = l.Tenant_ID
JOIN 
    Units u ON l.Unit_ID = u.Unit_ID
JOIN 
    Properties p ON u.Property_ID = p.Property_ID
WHERE 
    l.Lease_Status = 'Active'
    AND DATEDIFF(l.End_Date, l.Start_Date) >= 730
ORDER BY 
    Total_Continuous_Days DESC;


-- --------------------------------------------------------
-- 10. Chronic Property Maintenance Defects
-- Objective: Isolate systemic hardware flaws hitting > 5 major incident reports within a quarter.
-- --------------------------------------------------------
SELECT 
    p.Property_Name,
    p.Property_Type,
    CONCAT('Q', QUARTER(mr.Request_Date), '-', YEAR(mr.Request_Date)) AS Calendar_Quarter,
    COUNT(mr.Request_ID) AS Critical_Request_Count,
    SUM(mr.Estimated_Cost) AS Quarter_Maintenance_Cost,
    ROUND(AVG(mr.Estimated_Cost), 2) AS Avg_Cost_Per_Ticket
FROM 
    Maintenance_Requests mr
JOIN 
    Properties p ON mr.Property_ID = p.Property_ID
WHERE 
    mr.Request_Date BETWEEN '2026-01-01' AND '2026-06-30'
GROUP BY 
    p.Property_ID, 
    p.Property_Name, 
    p.Property_Type, 
    YEAR(mr.Request_Date), 
    QUARTER(mr.Request_Date)
HAVING 
    COUNT(mr.Request_ID) > 5
ORDER BY 
    Critical_Request_Count DESC;
