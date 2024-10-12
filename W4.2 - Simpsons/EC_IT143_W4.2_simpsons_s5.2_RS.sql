DROP TABLE IF EXISTS dbo.t_simpsons_homer_total_spent;
GO

CREATE TABLE dbo.t_simpsons_homer_total_spent
(
    total_spent DECIMAL(10, 2) NOT NULL,
    last_updated DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_t_simpsons_homer_total_spent PRIMARY KEY CLUSTERED (last_updated ASC)
);
GO