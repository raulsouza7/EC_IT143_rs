CREATE PROCEDURE dbo.usp_hello_world_load
AS
/*****************************************************************************************************************
NAME:    dbo.usp_hello_world_load
PURPOSE: Hello World - Load user stored procedure

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
    TRUNCATE TABLE dbo.t_hello_world;

    INSERT INTO dbo.t_hello_world
    SELECT v.my_message
         , v.current_date_time
    FROM dbo.v_hello_world_load AS v;

    -- 2) Review results
    SELECT t.*
    FROM dbo.t_hello_world AS t;
END;
GO