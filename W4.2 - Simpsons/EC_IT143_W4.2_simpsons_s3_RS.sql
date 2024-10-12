SELECT 
    (SELECT COALESCE(SUM(Debit), 0) 
     FROM dbo.FBS_Viza_Costmo 
     WHERE Member_Name LIKE '%Homer Simpson%') +
    (SELECT COALESCE(SUM(Amount), 0) 
     FROM dbo.Planet_Express 
     WHERE Card_Member LIKE '%Homer Simpson%') AS total_spent;