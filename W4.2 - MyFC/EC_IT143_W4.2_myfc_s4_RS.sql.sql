DROP VIEW IF EXISTS dbo.v_myfc_total_players;
GO

CREATE VIEW dbo.v_myfc_total_players
AS
/*****************************************************************************************************************
NAME:    dbo.v_myfc_total_players
PURPOSE: Create the MyFC Total Players View

MODIFICATION LOG:
Ver      Date        Author        Description
-----   ----------   -----------   -------------------------------------------------------------------------------
1.0     10/12/2024   YOURINITIALS       1. Built this script for EC IT143

RUNTIME: 
1s

NOTES: 
This script exists to help me learn step 4 of 8 in the Answer Focused Approach for T-SQL Data Manipulation
 
******************************************************************************************************************/

SELECT COUNT(*) AS total_players
FROM dbo.tblPlayerDim;