-- Cria��o de Fun��o escalar

-- Tempo m�dio de atendimento por t�cnico:
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
        AND o.Status = 'Conclu�da';

    RETURN @Media;
END;

-- Tempo m�dio de atendimento por cliente:
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
        AND o.Status = 'Conclu�da';

    RETURN @Media;
END;

-- Retornar o status de conclus�o de uma ordem baseado em uma data de conclus�o.
-- Se tiver data, est� "Conclu�da", se n�o, est� "Pendente".
CREATE FUNCTION dbo.fn_StatusOrdem (@DataConclusao DATE)
RETURNS VARCHAR(20)
AS
BEGIN
    RETURN (
        CASE 
            WHEN @DataConclusao IS NOT NULL THEN 'Conclu�da'
            ELSE 'Pendente'
        END
    );
END
