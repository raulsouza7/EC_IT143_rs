DROP VIEW IF EXISTS dbo.v_simpsons_homer_total_spent;
GO

CREATE VIEW dbo.v_simpsons_homer_total_spent
AS
/*****************************************************************************************************************
NAME:    dbo.v_simpsons_homer_total_spent
PURPOSE: Create the Simpsons Homer Total Spent View

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/12/2024   RAULSOUZA7       1. Built this script for EC IT143

RUNTIME: 
1s

NOTES: 
This script is for step 4 of 8 in the Answer Focused Approach for T-SQL Data Manipulation
 
******************************************************************************************************************/

SELECT 
    (SELECT COALESCE(SUM(Debit), 0) 
     FROM dbo.FBS_Viza_Costmo 
     WHERE Member_Name LIKE '%Homer Simpson%') +
    (SELECT COALESCE(SUM(Amount), 0) 
     FROM dbo.Planet_Express 
     WHERE Card_Member LIKE '%Homer Simpson%') AS total_spent;