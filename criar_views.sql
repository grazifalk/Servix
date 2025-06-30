-- Criação de Views

-- Total de ordens por técnico:
CREATE VIEW vw_TotalOrdensPorTecnico AS
SELECT 
    t.TecnicoID,
    t.Nome AS NomeTecnico,
    COUNT(o.OrdemID) AS TotalOrdens
FROM 
    Tecnicos t
LEFT JOIN 
    Ordens o ON t.TecnicoID = o.TecnicoID
GROUP BY 
    t.TecnicoID, t.Nome;

-- Total de ordens concluídas por técnico:
CREATE VIEW vw_OrdensConcluidasPorTecnico AS
SELECT 
    t.TecnicoID,
    t.Nome AS NomeTecnico,
    COUNT(o.OrdemID) AS TotalConcluidas
FROM 
    Tecnicos t
JOIN 
    Ordens o ON t.TecnicoID = o.TecnicoID
WHERE 
    o.Status = 'Concluída'
GROUP BY 
    t.TecnicoID, t.Nome;

-- Tempo médio de atendimento por técnico (em dias):
CREATE VIEW vw_TempoMedioAtendimentoTecnico AS
SELECT 
    t.TecnicoID,
    t.Nome AS NomeTecnico,
    AVG(DATEDIFF(DAY, o.DataAbertura, o.DataConclusao)) AS MediaDiasAtendimento
FROM 
    Tecnicos t
JOIN 
    Ordens o ON t.TecnicoID = o.TecnicoID
WHERE 
    o.Status = 'Concluída'
GROUP BY 
    t.TecnicoID, t.Nome;
