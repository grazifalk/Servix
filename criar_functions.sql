-- Criação de Função escalar

-- Tempo médio de atendimento por técnico:
CREATE FUNCTION fn_TempoMedioPorTecnico (@TecnicoID INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Media FLOAT;

    SELECT 
        @Media = AVG(DATEDIFF(DAY, o.DataAbertura, o.DataConclusao))
    FROM 
        Ordens o
    WHERE 
        o.TecnicoID = @TecnicoID
        AND o.Status = 'Concluída';

    RETURN @Media;
END;

-- Tempo médio de atendimento por cliente:
CREATE FUNCTION fn_TempoMedioPorCliente (@ClienteID INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @Media FLOAT;

    SELECT 
        @Media = AVG(DATEDIFF(DAY, o.DataAbertura, o.DataConclusao))
    FROM 
        Ordens o
    WHERE 
        o.ClienteID = @ClienteID
        AND o.Status = 'Concluída';

    RETURN @Media;
END;

-- Retornar o status de conclusão de uma ordem baseado em uma data de conclusão.
-- Se tiver data, está "Concluída", se não, está "Pendente".
CREATE FUNCTION dbo.fn_StatusOrdem (@DataConclusao DATE)
RETURNS VARCHAR(20)
AS
BEGIN
    RETURN (
        CASE 
            WHEN @DataConclusao IS NOT NULL THEN 'Concluída'
            ELSE 'Pendente'
        END
    );
END
