-- Cria��o de Views

-- Total de ordens por t�cnico:
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

-- Total de ordens conclu�das por t�cnico:
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
    o.Status = 'Conclu�da'
GROUP BY 
    t.TecnicoID, t.Nome;

-- Tempo m�dio de atendimento por t�cnico (em dias):
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
    o.Status = 'Conclu�da'
GROUP BY 
    t.TecnicoID, t.Nome;
