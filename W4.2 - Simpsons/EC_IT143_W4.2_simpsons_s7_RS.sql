CREATE PROCEDURE dbo.usp_simpsons_homer_total_spent_load
AS
/*****************************************************************************************************************
NAME:    dbo.usp_simpsons_homer_total_spent_load
PURPOSE: Simpsons Homer Total Spent - Load user stored procedure

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/12/2024   RAULSOUZA7       1. Built this script for EC IT143

RUNTIME: 
1s

NOTES: 
This script is for step 7 of 8 in the Answer Focused Approach for T-SQL Data Manipulation
 
******************************************************************************************************************/

BEGIN
    -- 1) Reload data
    TRUNCATE TABLE dbo.t_simpsons_homer_total_spent;

    INSERT INTO dbo.t_simpsons_homer_total_spent (total_spent)
    SELECT v.total_spent
    FROM dbo.v_simpsons_homer_total_spent AS v;

    -- 2) Review results
    SELECT t.*
    FROM dbo.t_simpsons_homer_total_spent AS t;
END;
GO