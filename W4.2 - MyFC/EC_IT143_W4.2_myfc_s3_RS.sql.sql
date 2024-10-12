-- Q: What is the total number of players in the MyFC database?
-- A: Let's count the rows in tblPlayerDim to find out.

SELECT COUNT(*) AS total_players
FROM dbo.tblPlayerDim;