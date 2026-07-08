## Project Overview
This repository contains an end-to-end SQL database project designed for real estate and property management analytics. The objective is to transform raw property, leasing, and financial records into actionable business insights—such as evaluating revenue leakage, tracking property occupancy rates, and optimizing maintenance operations. 

This project demonstrates advanced SQL capabilities including **Complex Multi-Table Joins, Common Table Expressions (CTEs), Window Functions, and Data Aggregations**.

---

## Database Schema & Architecture

Below is the structured breakdown of the relational database design, enforcing strict data integrity using Primary Keys (PK), Foreign Keys (FK), and conditional check constraints.

### 1. Properties Table
Stores macro-level information about each real estate property asset.
* `Property_ID` (INT, PK): Unique identifier for each property.
* `Property_Name` (VARCHAR): Name of the building or estate.
* `Address` & `City` (VARCHAR): Location tracking.
* `Property_Type` (ENUM): Classifies asset type ('Apartment', 'Commercial', 'Condo', 'Residential').
* `Total_Units` (INT): Capacity check to evaluate scaling.

### 2. Units Table
Tracks individual units or spaces available within each property.
* `Unit_ID` (INT, PK): Unique identifier for each individual door/space.
* `Property_ID` (INT, FK): Links back to the parent property.
* `Unit_Number` (VARCHAR): Room/Suite number.
* `Bedrooms` & `Bathrooms` (INT): Config details.
* `Monthly_Rent` (DECIMAL): Base pricing asset standard.
* `Availability_Status` (ENUM): Operational tracking ('Available', 'Occupied', 'Maintenance').

### 3. Tenants Table
Maintains historical and current record profiles of consumers renting the units.
* `Tenant_ID` (INT, PK): Unique identifier for each client.
* `First_Name` & `Last_Name` (VARCHAR): Tenant name identification.
* `Email` (VARCHAR, Unique) & `Phone` (VARCHAR): Contact coordinates.
* `Move_In_Date` (DATE): Tracks historical tenure timelines.

### 4. Leases Table
The core transactional contract bridge binding tenants to units.
* `Lease_ID` (INT, PK): Contract tracking system key.
* `Unit_ID` (INT, FK) & `Tenant_ID` (INT, FK): Structural relationship linkages.
* `Start_Date` & `End_Date` (DATE): Contract life intervals (Enforces End_Date > Start_Date).
* `Lease_Status` (ENUM): Contract lifecycle context ('Active', 'Expired', 'Terminated').

### 5. Payments Table
Financial tracking system monitoring transactional cash inflows.
* `Payment_ID` (INT, PK): Transaction receipt identifier.
* `Lease_ID` (INT, FK): Maps financial payments directly back to a valid lease contract.
* `Payment_Date` (DATE): Time tracking for operational liquidity checks.
* `Amount_Paid` (DECIMAL): Absolute currency collection values.
* `Payment_Status` (ENUM): Operational health indicators ('Paid', 'Late', 'Pending').

### 6. Maintenance Requests Table
The primary cost center ledger managing property upkeep expenses.
* `Request_ID` (INT, PK): Maintenance event ticket number.
* `Property_ID` (INT, FK) & `Unit_ID` (INT, FK): Root location tracking for the issues.
* `Description` (TEXT): Text metadata outlining structural or utility defects.
* `Request_Date` (DATE): Incident reporting metrics timeline.
* `Status` (ENUM): Operational triage phases ('Open', 'In Progress', 'Resolved').
* `Estimated_Cost` (DECIMAL): Financial liability metrics for the maintenance tasks.

---

## Business Analysis: 10 Problem Statements

The analytical suite in this project is built around solving these 10 distinct operational and financial scenarios. The corresponding SQL file contains production-grade queries mapped to solve these problems:

1. **Global Occupancy Rate Analysis:** Calculate the total number of units, occupied units, and the exact occupancy rate percentage across all properties combined.
2. **Property-Wise Performance Metrics:** Group data by individual property names to find their unique total unit count, active occupancies, and specific vacancy distributions.
3. **Month-on-Month (MoM) Revenue Streams:** Analyze cumulative rental cash flows received on a month-by-month basis to evaluate seasonal financial volatility.
4. **Revenue Leakage Tracking:** Extract a list of all current tenants who hold an 'Active' lease status but have their most recent payment recorded as 'Late' or 'Pending'.
5. **High-Value Rent Brackets:** Identify the top 3 highest-rent paying units within each distinct `Property_Type` classification utilizing dense rank evaluations.
6. **Maintenance Liability Outliers:** List out any properties where cumulative maintenance expenses have scaled out to exceed 30% of that property's total potential monthly rental yield.
7. **Lease Expiry Pipeline Risk:** Generate a proactive operational risk pipeline listing all leases expiring within the next 60 days to plan targeted marketing campaigns.
8. **Average Turnover Velocities:** Measure the historical average duration of active lease contracts segmented cleanly by different property categories.
9. **Tenant Loyalty Standouts:** Isolate premium historical tenants who have renewed contracts or managed continuous active tenancy timelines exceeding 2 consecutive years.
10. **Chronic Property Maintenance Defects:** Identify properties that generate more than 5 critical maintenance requests within a single quarter, isolating systemic underlying infrastructure failures.

---
## 📂 Project Deliverables & File Explanations

Each file in this repository has a clear role in the data engineering and analytics pipeline:

### 🛠️ 1. `Schema_Setup.sql` (Database Design)
* **What it does:** Builds the structural backbone by creating the **6 relational tables** (`Properties`, `Units`, `Tenants`, `Leases`, `Payments`, and `Maintenance_Requests`).
* **Key Features:** Implements strict data integrity rules using `PRIMARY KEY`, `FOREIGN KEY` constraints, cascading deletes, and `CHECK` rules to ensure accurate data tracking.

### 📊 2. `Sample_Data_Inserts.sql` (Data Ingestion)
* **What it does:** Populates the blank tables with realistic, mathematically consistent mock records.
* **Key Features:** Maintains perfect parent-child relationships across a realistic business timeline, modeling diverse lease cycles, rent adjustments, and tenant payment habits.

### 📈 3. `Business_Analysis_Queries.sql` (Analytics Engine)
* **What it does:** Contains production-grade SQL code written to solve **10 advanced real-world business problems**.
* **Key Features:** Uses powerful data analysis tools like **Window Functions** (`SUM() OVER`, `LAG()`), **CTEs (Common Table Expressions)**, and complex multi-table `JOIN` operations to trace revenue leakage and rolling growth.

### 📕 4. [`Property_Management_SQL_Portfolio.pdf`](https://github.com/ajay-jadeja/Property-Management-Data-Analytics-SQL-/blob/main/Property_Management_SQL_Portfolio.pdf) (Executive Report)
* **What it does:** A comprehensive, presentation-ready compilation of the entire project for quick review.
* **Key Features:** Includes all 10 business problem statements, original source codes, expected output grids, and actionable management insights—no live database connection required to view.

---

## 👤 Author & Copyright

* **Developer:** Ajaysinh Jadeja
* **Role:** Data Analyst / Computer Engineering Graduate
* **Location:** Vadodara, Gujarat, India

Copyright © 2026 Ajaysinh Jadeja. All rights reserved.  
*This project is a part of my professional data analytics portfolio. The code, database design, and analytical documentation are free to be reviewed for evaluation and educational purposes.*
