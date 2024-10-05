/***********************************************************************************
******************************
NAME: EC_IT143_W3.4_RS
PURPOSE: To answer eight AdventureWorks questions using SQL queries
MODIFICATION LOG:
Ver Date Author Description
----- ---------- ----------- -------------------------------------------------------------------------------
1.0 10/05/2024 RaulSouza 1. Built this script for EC IT143 W3.4 Assignment

RUNTIME: 
Approx. 1m 30s

NOTES:
This script contains SQL queries to answer eight questions about the AdventureWorks database,
including business user questions of varying complexity and metadata questions.
***********************************************************************************
*******************************/

-- Q1: What are the 5 least sold products for last year? (My question)
-- A1: To answer this, we'll need to join the SalesOrderDetail and Product tables, 
-- and filter for the previous year's data. We'll then group by product and order by total quantity sold.

SELECT TOP 5
    p.ProductID,
    p.Name AS ProductName,
    SUM(ISNULL(sod.OrderQty, 0)) AS TotalQuantitySold
FROM 
    Production.Product p
    LEFT JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
    LEFT JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID
WHERE 
    YEAR(soh.OrderDate) = YEAR(GETDATE()) - 1 OR soh.OrderDate IS NULL
GROUP BY 
    p.ProductID, p.Name
ORDER BY 
    TotalQuantitySold ASC;

-- Q2: What is the cheapest product in terms of manufacturing cost? (My question)
-- A2: We'll query the Product table and order by StandardCost in ascending order, limiting to 1 result.

SELECT TOP 1
    ProductID,
    Name AS ProductName,
    StandardCost
FROM 
    Production.Product
WHERE 
    StandardCost > 0
ORDER BY 
    StandardCost ASC;

-- Q3: Which sales territories have the highest total sales revenue, and how does the average order value compare across these territories? (Ikechukwu Francis Ugwu)
-- A3: We'll join SalesOrderHeader with SalesTerritory, calculate total revenue and average order value per territory, and order by total revenue.

SELECT TOP 5
    st.TerritoryID,
    st.Name AS TerritoryName,
    SUM(soh.TotalDue) AS TotalRevenue,
    AVG(soh.TotalDue) AS AvgOrderValue
FROM 
    Sales.SalesOrderHeader soh
    JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
GROUP BY 
    st.TerritoryID, st.Name
ORDER BY 
    TotalRevenue DESC;

-- Q4: From the sales forecast on revenue generated in quarter 4, what is the most sold product? (LAMIDI OLATUNJI MICHEAL ELESHIN)
-- A4: We'll join SalesOrderHeader, SalesOrderDetail, and Product tables, filter for Q4, and group by product to find the most sold.

SELECT TOP 1
    p.ProductID,
    p.Name AS ProductName,
    SUM(sod.OrderQty) AS TotalQuantitySold,
    SUM(sod.LineTotal) AS TotalRevenue
FROM 
    Sales.SalesOrderHeader soh
    JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
    JOIN Production.Product p ON sod.ProductID = p.ProductID
WHERE 
    YEAR(soh.OrderDate) = (SELECT MAX(YEAR(OrderDate)) FROM Sales.SalesOrderHeader)
GROUP BY 
    p.ProductID, p.Name
ORDER BY 
    TotalQuantitySold DESC;

-- Q5: I'm analyzing customer orders from the United States in Q1 2022. Could you provide a breakdown of the top 5 customers from the U.S. by total spending during this period? Please include the total amount spent, the number of orders placed, and their state of residence. (Logan Waters)
-- A5: We'll join multiple tables to get customer information, filter for US customers in the most recent year's Q1, and calculate the requested metrics.

SELECT TOP 5
    c.CustomerID,
    p.FirstName + ' ' + p.LastName AS CustomerName,
    sp.Name AS StateProvince,
    SUM(soh.TotalDue) AS TotalAmountSpent,
    COUNT(DISTINCT soh.SalesOrderID) AS NumberOfOrders
FROM 
    Sales.Customer c
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
    JOIN Person.Address a ON soh.ShipToAddressID = a.AddressID
    JOIN Person.StateProvince sp ON a.StateProvinceID = sp.StateProvinceID
WHERE 
    DATEPART(QUARTER, soh.OrderDate) = 1
    AND YEAR(soh.OrderDate) = (SELECT MAX(YEAR(OrderDate)) FROM Sales.SalesOrderHeader)
    AND sp.CountryRegionCode = 'US'
GROUP BY 
    c.CustomerID, p.FirstName, p.LastName, sp.Name
ORDER BY 
    TotalAmountSpent DESC;

-- Q6: I am interested in net revenue. Which product is the most profitable considering both its cost and sales revenue? (Elio Canda Canda Murillo)
-- A6: We'll calculate the net revenue (sales revenue - cost) for each product and order by net revenue.

SELECT TOP 1
    p.ProductID,
    p.Name AS ProductName,
    SUM(sod.LineTotal) AS TotalRevenue,
    SUM(sod.OrderQty * p.StandardCost) AS TotalCost,
    SUM(sod.LineTotal) - SUM(sod.OrderQty * p.StandardCost) AS NetRevenue
FROM 
    Production.Product p
    JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY 
    p.ProductID, p.Name
ORDER BY 
    NetRevenue DESC;

-- Q7: Which tables in the AdventureWorks database have a foreign key relationship with the "SalesOrderHeader" table? (Elio Canda Canda Murillo)
-- A7: We'll query the system tables to find foreign key relationships with SalesOrderHeader.

SELECT 
    OBJECT_NAME(f.parent_object_id) AS TableName,
    COL_NAME(fc.parent_object_id, fc.parent_column_id) AS ColumnName
FROM 
    sys.foreign_keys AS f
    INNER JOIN sys.foreign_key_columns AS fc ON f.object_id = fc.constraint_object_id
WHERE 
    OBJECT_NAME(f.referenced_object_id) = 'SalesOrderHeader';

-- Q8: How many tables exist in the AdventureWorks database, and what are the schemas they belong to? (MUTUMBA MUTUMBA)
-- A8: We'll query the system tables to get a count of tables per schema.

SELECT 
    s.name AS SchemaName,
    COUNT(*) AS TableCount
FROM 
    sys.tables t
    JOIN sys.schemas s ON t.schema_id = s.schema_id
GROUP BY 
    s.name
ORDER BY 
    TableCount DESC;