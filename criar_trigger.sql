-- Trigger para atualizar status automaticamente:
CREATE TRIGGER trg_AtualizarStatusConclusao
ON Ordens
AFTER UPDATE
AS
BEGIN
    UPDATE o
    SET o.Status = 'Concluída'
    FROM Ordens o
    JOIN inserted i ON o.OrdemID = i.OrdemID
    WHERE 
        i.DataConclusao IS NOT NULL
        AND i.Status <> 'Concluída';
END;

-- Trigger para registrar log de alteração de status:

/* Verificar se já foi criada a tabela de log:
	CREATE TABLE LogAlteracaoStatus (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    OrdemID INT,
    StatusAntigo VARCHAR(20),
    StatusNovo VARCHAR(20),
    DataAlteracao DATETIME DEFAULT GETDATE()
);*/

CREATE TRIGGER trg_LogStatusAlterado
ON Ordens
AFTER UPDATE
AS
BEGIN
    INSERT INTO LogAlteracaoStatus (OrdemID, StatusAntigo, StatusNovo)
    SELECT 
        i.OrdemID,
        d.Status,
        i.Status
    FROM 
        inserted i
    JOIN 
        deleted d ON i.OrdemID = d.OrdemID
    WHERE 
        d.Status <> i.Status;
END;
