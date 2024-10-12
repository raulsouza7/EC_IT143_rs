CREATE PROCEDURE dbo.usp_myfc_total_players_load
AS
/*****************************************************************************************************************
NAME:    dbo.usp_myfc_total_players_load
PURPOSE: MyFC Total Players - Load user stored procedure

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/12/2024   YOURINITIALS       1. Built this script for EC IT143

RUNTIME: 
1s

NOTES: 
This script exists to help me learn step 7 of 8 in the Answer Focused Approach for T-SQL Data Manipulation
 
******************************************************************************************************************/

BEGIN
    -- 1) Reload data
    TRUNCATE TABLE dbo.t_myfc_total_players;

    INSERT INTO dbo.t_myfc_total_players (total_players)
    SELECT v.total_players
    FROM dbo.v_myfc_total_players AS v;

    -- 2) Review results
    SELECT t.*
    FROM dbo.t_myfc_total_players AS t;
END;
GO