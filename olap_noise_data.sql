-- Inserindo dados ruidosos na dimensão PESSOA
INSERT INTO dim_pessoa (id_pessoa_sk, id_pessoa, nome, data_nascimento)
VALUES 
(11, 10, 'João@123', '1985-05-15'), -- Nome com caracteres inválidos e id_pessoa NULL
(12, 21, 'Maria', '1899-12-31'), -- Data de nascimento improvável
(13, 22, 'José Silva', '2030-07-20'); -- Data de nascimento no futuro

-- Inserindo dados ruidosos na dimensão PROJETO
INSERT INTO dim_projeto (id_projeto_sk, id_projeto, nome_projeto, edital)
VALUES 
(11, 11, 'Pesquisa#AI', 'Edital 999/9999'), -- Nome do projeto com caracteres estranhos
(12, 12, 'Projeto Antigo', 'Edital 002/1900'); -- Edital muito antigo

-- Inserindo dados ruidosos na dimensão BOLSA
INSERT INTO dim_bolsa (id_bolsa_sk, id_bolsa, descricao_bolsa, sigla, valor)
VALUES 
(6, 6, 'Bols@ PHD', 'BPHD', -5000.00), -- Valor negativo
(7, 7, 'Bolsa???', '??', 0.00); -- Nome e sigla inválidos, valor zero

-- Inserindo dados ruidosos na dimensão DATA
INSERT INTO dim_data (id_data, data_completa, dia, dia_semana, mes_descricao, mes_numero, ano, trimestre, semestre, is_feriado)
VALUES 
(11, '2025-11-25', 45, 'Quarta-f', 'Mês Descido', 13, 2025, 5, 3, FALSE), -- 
(12, '2020-02-28', 30, 'Domingo', 'Fever', 2, 2020, 1, 1, FALSE); --
