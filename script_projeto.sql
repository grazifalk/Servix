-- Criação do Banco de Dados
CREATE DATABASE Servix;
GO
USE Servix;
GO

-- Tabela de Clientes
CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100),
    Email VARCHAR(100),
    Telefone VARCHAR(20)
);
GO

-- Tabela de Técnicos
CREATE TABLE Tecnicos (
    TecnicoID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100),
    Especialidade VARCHAR(50)
);
GO

-- Tabela de Produtos
CREATE TABLE Produtos (
    ProdutoID INT PRIMARY KEY IDENTITY(1,1),
    Nome VARCHAR(100),
    Descricao VARCHAR(200)
);
GO

-- Tabela de Ordens
CREATE TABLE Ordens (
    OrdemID INT PRIMARY KEY IDENTITY(1,1),
    ClienteID INT,
    TecnicoID INT,
    DataAbertura DATE,
    DataConclusao DATE,
    Status VARCHAR(20),
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID),
    FOREIGN KEY (TecnicoID) REFERENCES Tecnicos(TecnicoID)
);
GO

-- Tabela de Serviços
CREATE TABLE Servicos (
    ServicoID INT PRIMARY KEY IDENTITY(1,1),
    OrdemID INT,
    ProdutoID INT,
    Descricao VARCHAR(200),
    FOREIGN KEY (OrdemID) REFERENCES Ordens(OrdemID),
    FOREIGN KEY (ProdutoID) REFERENCES Produtos(ProdutoID)
);
GO

--Tabela de log
CREATE TABLE LogAlteracaoStatus (
    LogID INT IDENTITY(1,1) PRIMARY KEY,
    OrdemID INT,
    StatusAntigo VARCHAR(20),
    StatusNovo VARCHAR(20),
    DataAlteracao DATETIME DEFAULT GETDATE()
);
