/***********************************************************************************
NAME: EC_IT143_W5.2_MyFC_rs
PURPOSE: To analyze MyFC team player performance, consistency, and salary distribution
MODIFICATION LOG:
Ver   Date        Author       Description
----- ----------  -----------  -------------------------------------------------------------------------------
1.0   10/15/2024  Raul Souza      1. Built this script for EC IT143 W5.2 assignment
RUNTIME: 
Approx. 3m 0s
NOTES:
This script answers four key questions about MyFC team player performance and salary trends using data from the tblPlayerDim, tblPlayerFact, tblPositionDim, and DateDim tables. It also created
2 new table, (dbo.tblInjury and dbo.tblTournament), populates them with random valid information so we can answer the last question.
***********************************************************************************/

/* MyFC Team Community */

/* Create tblInjury table */
CREATE TABLE dbo.tblInjury (
    injury_id INT PRIMARY KEY,
    player_id INT,
    injury_date DATE,
    FOREIGN KEY (player_id) REFERENCES dbo.tblPlayerDim(pl_id)
);

/* Insert sample data into tblInjury */
INSERT INTO dbo.tblInjury (injury_id, player_id, injury_date) VALUES
(1, 1, '2023-01-10'),
(2, 1, '2023-03-15'),
(3, 2, '2022-07-20'),
(4, 3, '2024-01-05');

/* Create tblTournament table */
CREATE TABLE dbo.tblTournament (
    t_id INT PRIMARY KEY,
    performance_score INT
);

/* Insert sample data into tblTournament */
INSERT INTO dbo.tblTournament (t_id, performance_score) VALUES
(1, 85),
(2, 90),
(3, 80);

/* Q1: How do our players' performance metrics (salary, etc.) compare 
to those of top players in the league over the past three seasons?
A1: This query compares player performance metrics with top league players. */

SELECT 
    p.pl_name AS Player_Name,
    pf.mtd_salary AS Salary,
    ROW_NUMBER() OVER (ORDER BY pf.mtd_salary DESC) AS Rank
FROM 
    dbo.tblPlayerDim p
JOIN 
    dbo.tblPlayerFact pf ON p.pl_id = pf.pl_id
WHERE 
    pf.as_of_date >= DATEADD(YEAR, -3, GETDATE())
ORDER BY 
    pf.mtd_salary DESC;

/* Q2: Which players have had the most consistent performance over the past five years, 
considering their salaries?
A2: This query identifies players with consistent performance based on average salary. */

SELECT 
    p.pl_name AS Player_Name,
    AVG(pf.mtd_salary) AS Avg_Salary
FROM 
    dbo.tblPlayerDim p
JOIN 
    dbo.tblPlayerFact pf ON p.pl_id = pf.pl_id
WHERE 
    pf.as_of_date >= DATEADD(YEAR, -5, GETDATE())
GROUP BY 
    p.pl_name
ORDER BY 
    Avg_Salary DESC;

/* Q3: How many players have had their salary increased over the last three seasons?
A3: This query counts players with a salary increase compared to three seasons ago. */

SELECT 
    COUNT(DISTINCT p.pl_id) AS Players_With_Salary_Increase
FROM 
    dbo.tblPlayerDim p
JOIN 
    dbo.tblPlayerFact pf_current ON p.pl_id = pf_current.pl_id
JOIN 
    dbo.tblPlayerFact pf_previous ON p.pl_id = pf_previous.pl_id
WHERE 
    pf_current.as_of_date >= DATEADD(YEAR, -3, GETDATE())
    AND pf_previous.as_of_date < DATEADD(YEAR, -3, GETDATE())
    AND pf_current.mtd_salary > pf_previous.mtd_salary;

/* Q4: How have players' injury patterns impacted team performance during major tournaments?
A4: This query analyzes injury data in relation to team performance metrics during tournaments. */

SELECT 
    p.pl_name AS Player_Name,
    COUNT(i.injury_id) AS Total_Injuries,
    SUM(t.performance_score) AS Team_Performance
FROM 
    dbo.tblPlayerDim p
JOIN 
    dbo.tblInjury i ON p.pl_id = i.player_id
JOIN 
    dbo.tblTournament t ON i.injury_id = t.t_id  -- Assuming a relationship here for demonstration
WHERE 
    i.injury_date >= DATEADD(YEAR, -5, GETDATE())
GROUP BY 
    p.pl_name
ORDER BY 
    Total_Injuries DESC;
