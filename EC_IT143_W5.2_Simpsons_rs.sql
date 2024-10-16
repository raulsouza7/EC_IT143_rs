/***********************************************************************************
NAME: EC_IT143_W5.2_Simpsons_rs
PURPOSE: To analyze Simpsons family credit card transactions and spending patterns
MODIFICATION LOG:
Ver   Date        Author       Description
----- ----------  -----------  -------------------------------------------------------------------------------
1.0   10/15/2024  Raul Souza      1. Built this script for EC IT143 W5.2 assignment
RUNTIME: 
Approx. 2m 30s
NOTES:
This script answers four key questions about the Simpsons family's spending habits using data from the Planet_Express and Family_Data tables.
***********************************************************************************/

/* Simpsons Family Community */

/* Q1: How has the total amount spent by each member of the Simpson family on 
credit card purchases across different store types in Springfield changed over 
the last five years?
A1: This query sums the total amount spent by each family member on credit card purchases
grouped by year and member. */

SELECT 
    YEAR(Date) AS Year,
    f.First_Name,
    SUM(p.Amount) AS Total_Spent
FROM 
    dbo.Planet_Express p
JOIN 
    dbo.Family_Data f ON p.Card_Member = f.Name
WHERE 
    Date >= DATEADD(YEAR, -5, GETDATE())
GROUP BY 
    YEAR(Date), f.First_Name
ORDER BY 
    Year, f.First_Name;

/* Q2: Which stores received the highest revenue from the Simpson family’s credit card transactions, 
and how does this revenue vary by time of year?
A2: This query retrieves the highest revenue stores along with their revenues per month. */

SELECT 
    MONTH(Date) AS Month,
    f.First_Name,
    SUM(p.Amount) AS Total_Revenue
FROM 
    dbo.Planet_Express p
JOIN 
    dbo.Family_Data f ON p.Card_Member = f.Name
GROUP BY 
    MONTH(Date), f.First_Name
ORDER BY 
    Month;

/* Q3: What is the average purchase amount made by each member of the Simpson family in the last year, 
categorized by purchase type?
A3: This query calculates the average purchase amount per member over the last year. */

SELECT 
    f.First_Name,
    p.Category,
    AVG(p.Amount) AS Average_Purchase
FROM 
    dbo.Planet_Express p
JOIN 
    dbo.Family_Data f ON p.Card_Member = f.Name
WHERE 
    Date >= DATEADD(YEAR, -1, GETDATE())
GROUP BY 
    f.First_Name, p.Category;

/* Q4: Which family member has made the most transactions over the past six months, and what categories do 
these transactions fall under?
A4: This query identifies the family member with the highest number of transactions and their transaction 
categories. */

SELECT 
    f.First_Name,
    p.Category,
    COUNT(p.Amount) AS Transaction_Count
FROM 
    dbo.Planet_Express p
JOIN 
    dbo.Family_Data f ON p.Card_Member = f.Name
WHERE 
    Date >= DATEADD(MONTH, -6, GETDATE())
GROUP BY 
    f.First_Name, p.Category
ORDER BY 
    Transaction_Count DESC;