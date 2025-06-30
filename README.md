# Servix
Servix é um sistema de banco de dados projetado para gerenciar e analisar ordens de serviço de forma eficiente, simulando um ambiente real com clientes, técnicos, produtos e atendimentos, aplicando recursos avançados de SQL.

## Descrição
Este projeto foi desenvolvido como parte do meu Plano de Desenvolvimento Individual, com o objetivo de consolidar meus conhecimentos em SQL avançado.

O banco de dados simula um sistema de controle de ordens de serviço, contendo informações sobre clientes, técnicos, produtos e ordens. Durante o projeto, foram aplicadas técnicas avançadas como Stored Procedures, Funções, Triggers, Views, CTEs e Window Functions.

## Estrutura
O projeto contém os seguintes arquivos:
- `script_projeto.sql`: Criação do banco de dados e tabelas.
- `script_dados.sql`: Inserção de dados simulados nas tabelas.
- `criar_procedures.sql`: Script para criação de Stored Procedures.
- `criar_views.sql`: Script para criação de Views.
- `criar_functions.sql`: Script para criação de Functions.
- `criar_trigger.sql`: Script para criação de Trigger.
- `consultas.sql`: Consultas avançadas, procedimentos, triggers e exemplos práticos.

## Estrutura do Banco de Dados
O banco contém as seguintes tabelas:
- **Clientes**: Informações dos clientes.
- **Técnicos**: Informações dos técnicos responsáveis pelos atendimentos.
- **Produtos**: Produtos utilizados nos serviços.
- **Ordens**: Registro das ordens de serviço.
- **Serviços**: Descrição dos serviços executados em cada ordem.
- **LogAlteracaoStatus**: Log para registrar alteração de status.

![image](https://github.com/user-attachments/assets/a993176c-4dd0-4ae1-8d99-5cdb553fccf6)

## Tecnologias
- SQL Server

## Recursos Aplicados
- Criação de **Views** para relatórios resumidos.
- **Stored Procedures** para geração de relatórios automáticos.
- **Triggers** para atualização de status de ordens.
- **Funções** para cálculo de tempo médio de atendimento.
- Consultas utilizando **CTEs** e **Window Functions**.
- Índices para otimização de consultas.

## Exemplos de Consultas
1. Ranking de técnicos por quantidade de ordens finalizadas.
2. Tempo médio de atendimento por cliente.
3. Total de ordens e produtos utilizados por mês.
4. CTE para contagem de produtos por ordem.
5. Window Function para ranking de clientes.
6. Trigger para atualização automática de status.

## Como Executar
1. Execute o arquivo `script_projeto.sql` para criar o banco de dados e as tabelas.
2. Execute o arquivo `script_dados.sql` para inserir dados simulados nas tabelas.
3. Execute o arquivo `criar_procedures.sql` para criar Stored Procedures.
4. Execute o arquivo `criar_views.sql` para criar Views.
5. Execute o arquivo `criar_functions.sql` para criar Functions.
6. Execute o arquivo `criar_trigger.sql` para criar Triggers.
7. Consulte o arquivo `consultas.sql` para exemplos práticos.
