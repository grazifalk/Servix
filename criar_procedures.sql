CREATE PROCEDURE sp_TotalOrdensPorCliente
AS
BEGIN
    SELECT 
        c.Nome AS NomeCliente,
        COUNT(o.OrdemID) AS TotalOrdens
    FROM 
        Clientes c
    LEFT JOIN 
        Ordens o ON c.ClienteID = o.ClienteID
    GROUP BY 
        c.Nome
    ORDER BY 
        TotalOrdens DESC;
END;

---

CREATE PROCEDURE sp_ServicosMaisUtilizadosPorMes
    @Ano INT,
    @Mes INT
AS
BEGIN
    SELECT 
        p.Nome AS Produto,
        COUNT(s.ServicoID) AS TotalUtilizacoes
    FROM 
        Servicos s
    JOIN 
        Produtos p ON s.ProdutoID = p.ProdutoID
    JOIN 
        Ordens o ON s.OrdemID = o.OrdemID
    WHERE 
        YEAR(o.DataConclusao) = @Ano
        AND MONTH(o.DataConclusao) = @Mes
        AND o.Status = 'Concluída'
    GROUP BY 
        p.Nome
    ORDER BY 
        TotalUtilizacoes DESC;
END;

---

CREATE PROCEDURE sp_RelatorioOrdensConcluidasPorMes
    @Ano INT,
    @Mes INT
AS
BEGIN
    SELECT 
        c.Nome AS NomeCliente,
        t.Nome AS NomeTecnico,
        o.DataAbertura,
        o.DataConclusao,
        COUNT(s.ServicoID) AS TotalServicos,
        o.Status
    FROM 
        Ordens o
    INNER JOIN 
        Clientes c ON o.ClienteID = c.ClienteID
    INNER JOIN 
        Tecnicos t ON o.TecnicoID = t.TecnicoID
    LEFT JOIN 
        Servicos s ON o.OrdemID = s.OrdemID
    WHERE 
        o.Status = 'Concluída'
        AND YEAR(o.DataConclusao) = @Ano
        AND MONTH(o.DataConclusao) = @Mes
    GROUP BY 
        c.Nome, t.Nome, o.DataAbertura, o.DataConclusao, o.Status
    ORDER BY 
        o.DataConclusao;
END;

---

CREATE PROCEDURE sp_OrdensEmAndamentoPorTecnico
AS
BEGIN
    SELECT 
        t.Nome AS NomeTecnico,
        COUNT(o.OrdemID) AS TotalOrdensEmAndamento
    FROM 
        Tecnicos t
    JOIN 
        Ordens o ON t.TecnicoID = o.TecnicoID
    WHERE 
        o.Status = 'Em Andamento'
    GROUP BY 
        t.Nome
    ORDER BY 
        TotalOrdensEmAndamento DESC;
END;
