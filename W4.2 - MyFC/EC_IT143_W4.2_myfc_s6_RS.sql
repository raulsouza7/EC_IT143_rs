-- Q: What is the total number of players in the MyFC database?
-- A: Let's load the data from our view into the table.

-- 1) Reload data
TRUNCATE TABLE dbo.t_myfc_total_players;

INSERT INTO dbo.t_myfc_total_players (total_players)
SELECT v.total_players
FROM dbo.v_myfc_total_players AS v;

-- 2) Review results
SELECT t.*
FROM dbo.t_myfc_total_players AS t;