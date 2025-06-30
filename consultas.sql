-- 01. Ranking de t�cnicos por quantidade de ordens conclu�das:
SELECT t.Nome, COUNT(o.OrdemID) AS TotalOrdens
FROM Tecnicos t
JOIN Ordens o ON t.TecnicoID = o.TecnicoID
WHERE o.Status = 'Conclu�da'
GROUP BY t.Nome
ORDER BY TotalOrdens DESC;

-- 02. Tempo m�dio de atendimento por cliente:
SELECT c.Nome, AVG(DATEDIFF(DAY, o.DataConclusao, o.DataAbertura)) AS TempoMedioDias
FROM Clientes c
JOIN Ordens o ON c.ClienteID = o.ClienteID
WHERE o.Status = 'Conclu�da'
GROUP BY c.Nome;

-- 03. CTE - Quantidade de produtos utilizados por ordem:
WITH ProdutosPorOrdem AS (
    SELECT o.OrdemID, COUNT(s.ProdutoID) AS TotalProdutos
    FROM Ordens o
    JOIN Servicos s ON o.OrdemID = s.OrdemID
    GROUP BY o.OrdemID
)
SELECT * FROM ProdutosPorOrdem;

-- 04. Window Function: Quantas ordens cada cliente j� teve:
SELECT
  OrdemID,
  ClienteID,
  TecnicoID,
  DataAbertura,
  COUNT(*) OVER (PARTITION BY ClienteID) AS TotalOrdensPorCliente
FROM Ordens;

-- 05. Testar Stored Procedures:
EXEC sp_RelatorioOrdensConcluidasPorMes @Ano = 2024, @Mes = 2;

EXEC sp_OrdensEmAndamentoPorTecnico;

EXEC sp_TotalOrdensPorCliente;

EXEC sp_ServicosMaisUtilizadosPorMes @Ano = 2024, @Mes = 2;

-- 06. CTE - Ranking de t�cnicos por n�mero de ordens conclu�das:
WITH OrdensConcluidasPorTecnico AS (
    SELECT 
        t.TecnicoID,
        t.Nome AS NomeTecnico,
        COUNT(o.OrdemID) AS TotalOrdensConcluidas
    FROM 
        Tecnicos t
    JOIN 
        Ordens o ON t.TecnicoID = o.TecnicoID
    WHERE 
        o.Status = 'Conclu�da'
    GROUP BY 
        t.TecnicoID, t.Nome
) SELECT 
    NomeTecnico,
    TotalOrdensConcluidas,
    RANK() OVER (ORDER BY TotalOrdensConcluidas DESC) AS Ranking
FROM 
    OrdensConcluidasPorTecnico;

-- 07. CTE - Ranking mensal de t�cnicos (compara��o m�s a m�s):
WITH OrdensPorMes AS (
    SELECT 
        t.Nome AS NomeTecnico,
        YEAR(o.DataConclusao) AS Ano,
        MONTH(o.DataConclusao) AS Mes,
        COUNT(o.OrdemID) AS TotalOrdens
    FROM 
        Tecnicos t
    JOIN 
        Ordens o ON t.TecnicoID = o.TecnicoID
    WHERE 
        o.Status = 'Conclu�da'
    GROUP BY 
        t.Nome, YEAR(o.DataConclusao), MONTH(o.DataConclusao)
) SELECT 
    NomeTecnico,
    Ano,
    Mes,
    TotalOrdens,
    RANK() OVER (PARTITION BY Ano, Mes ORDER BY TotalOrdens DESC) AS RankingMensal
FROM 
    OrdensPorMes
ORDER BY 
    Ano, Mes, RankingMensal;

-- 08. Usando as Views:
SELECT * FROM vw_TotalOrdensPorTecnico;
SELECT * FROM vw_OrdensConcluidasPorTecnico;
SELECT * FROM vw_TempoMedioAtendimentoTecnico;

-- 09. Usando Fun��o escalar:
	-- Tempo m�dio de atendimento por t�cnico:
	SELECT dbo.fn_TempoMedioPorTecnico(3) AS MediaDias;

	-- Tempo m�dio de atendimento por cliente:
	SELECT dbo.fn_TempoMedioPorCliente(5) AS MediaDias;

	-- Retornar o status de conclus�o de uma ordem baseado em uma data de conclus�o:
		SELECT
		  OrdemID,
		  DataConclusao,
		  dbo.fn_StatusOrdem(DataConclusao) AS StatusCalculado
		FROM Ordens;

-- 10. Trigger para atualizar status automaticamente
SELECT * FROM ORDENS WHERE ORDEMID = 21;
UPDATE Ordens SET DataConclusao = '2025-06-30' WHERE OrdemID = 21 AND Status = 'Em andamento';
SELECT * FROM ORDENS WHERE ORDEMID = 21;

-- 11. Trigger para registrar log de altera��o de status
SELECT OrdemID, Status FROM Ordens WHERE OrdemID = 23;
SELECT * FROM LogAlteracaoStatus WHERE OrdemID = 23;

UPDATE Ordens
SET Status = 'Em andamento'
WHERE OrdemID = 23;

SELECT * FROM LogAlteracaoStatus WHERE OrdemID = 23;
