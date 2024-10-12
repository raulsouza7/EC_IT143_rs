DROP TABLE IF EXISTS dbo.t_myfc_total_players;
GO

CREATE TABLE dbo.t_myfc_total_players
(
    total_players INT NOT NULL,
    last_updated DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT PK_t_myfc_total_players PRIMARY KEY CLUSTERED (last_updated ASC)
);
GO