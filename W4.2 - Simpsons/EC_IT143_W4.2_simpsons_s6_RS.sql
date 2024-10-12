-- 1) Reload data
TRUNCATE TABLE dbo.t_simpsons_homer_total_spent;

INSERT INTO dbo.t_simpsons_homer_total_spent (total_spent)
SELECT v.total_spent
FROM dbo.v_simpsons_homer_total_spent AS v;

-- 2) Review results
SELECT t.*
FROM dbo.t_simpsons_homer_total_spent AS t;