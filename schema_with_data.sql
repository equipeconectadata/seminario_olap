DROP TABLE IF EXISTS fato_pagamento_bolsa;
DROP TABLE IF EXISTS dim_bolsa;
DROP TABLE IF EXISTS dim_projeto;
DROP TABLE IF EXISTS dim_pessoa;
DROP TABLE IF EXISTS dim_data;

-- Criando as Dimensões (SCD2)

-- Dimensão DATA
CREATE TABLE dim_data (
    id_data SERIAL PRIMARY KEY,
    data_completa DATE NOT NULL,
    dia INT NOT NULL,
    dia_semana VARCHAR(15) NOT NULL,
    mes_descricao VARCHAR(15) NOT NULL,
    mes_numero INT NOT NULL,
    ano INT NOT NULL,
    trimestre INT NOT NULL,
    semestre INT NOT NULL,
    is_feriado BOOLEAN NOT NULL,
    data_inicio TIMESTAMP DEFAULT NOW(),
    data_fim TIMESTAMP,
    is_atual BOOLEAN DEFAULT TRUE
);

INSERT INTO dim_data (data_completa, dia, dia_semana, mes_descricao, mes_numero, ano, trimestre, semestre, is_feriado)
VALUES 
('2025-01-01', 1, 'Quarta-feira', 'Janeiro', 1, 2025, 1, 1, TRUE),
('2025-02-10', 10, 'Segunda-feira', 'Fevereiro', 2, 2025, 1, 1, FALSE),
('2025-03-15', 15, 'Sábado', 'Março', 3, 2025, 1, 1, FALSE),
('2025-04-20', 20, 'Domingo', 'Abril', 4, 2025, 2, 1, FALSE),
('2025-05-05', 5, 'Segunda-feira', 'Maio', 5, 2025, 2, 1, FALSE),
('2025-06-30', 30, 'Segunda-feira', 'Junho', 6, 2025, 2, 1, FALSE),
('2025-07-04', 4, 'Sexta-feira', 'Julho', 7, 2025, 3, 2, FALSE),
('2025-08-15', 15, 'Quinta-feira', 'Agosto', 8, 2025, 3, 2, FALSE),
('2025-09-07', 7, 'Domingo', 'Setembro', 9, 2025, 3, 2, TRUE),
('2025-10-12', 12, 'Domingo', 'Outubro', 10, 2025, 4, 2, TRUE);

-- Dimensão PESSOA
CREATE TABLE dim_pessoa (
    id_pessoa_sk SERIAL PRIMARY KEY,
    id_pessoa INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE NOT NULL,
    data_inicio TIMESTAMP DEFAULT NOW(),
    data_fim TIMESTAMP,
    is_atual BOOLEAN DEFAULT TRUE
);

INSERT INTO dim_pessoa (id_pessoa, nome, data_nascimento)
VALUES 
(1, 'Carlos Silva', '1980-05-10'),
(2, 'Maria Santos', '1975-08-20'),
(3, 'João Pereira', '1982-11-25'),
(4, 'Ana Souza', '1978-03-30'),
(5, 'Paulo Mendes', '1985-07-15'),
(6, 'Fernanda Costa', '1972-09-05'),
(7, 'Ricardo Almeida', '1983-06-18'),
(8, 'Beatriz Ramos', '1981-04-27'),
(9, 'Gustavo Lima', '1976-12-09'),
(10, 'Luana Oliveira', '1984-02-14');

-- Dimensão PROJETO
CREATE TABLE dim_projeto (
    id_projeto_sk SERIAL PRIMARY KEY,
    id_projeto INT NOT NULL,
    nome_projeto VARCHAR(255) NOT NULL,
    edital VARCHAR(100) NOT NULL,
    data_inicio TIMESTAMP DEFAULT NOW(),
    data_fim TIMESTAMP,
    is_atual BOOLEAN DEFAULT TRUE
);

INSERT INTO dim_projeto (id_projeto, nome_projeto, edital)
VALUES 
(1, 'Pesquisa em IA', 'Edital 001/2025'),
(2, 'Projeto Saúde', 'Edital 002/2025'),
(3, 'Inovação Sustentável', 'Edital 003/2025'),
(4, 'Educação Digital', 'Edital 004/2025'),
(5, 'Mobilidade Urbana', 'Edital 005/2025'),
(6, 'Energia Renovável', 'Edital 006/2025'),
(7, 'Agricultura Inteligente', 'Edital 007/2025'),
(8, 'Big Data Analytics', 'Edital 008/2025'),
(9, 'Cidades Inteligentes', 'Edital 009/2025'),
(10, 'Medicina Personalizada', 'Edital 010/2025');

-- Dimensão BOLSA
CREATE TABLE dim_bolsa (
    id_bolsa_sk SERIAL PRIMARY KEY,
    id_bolsa INT NOT NULL,
    descricao_bolsa VARCHAR(255) NOT NULL,
    sigla VARCHAR(50) NOT NULL,
    valor NUMERIC(10,2) NOT NULL,
    data_inicio TIMESTAMP DEFAULT NOW(),
    data_fim TIMESTAMP,
    is_atual BOOLEAN DEFAULT TRUE
);

INSERT INTO dim_bolsa (id_bolsa, descricao_bolsa, sigla, valor)
VALUES 
(1, 'Bolsa Doutorado', 'BD', 3000.00),
(2, 'Bolsa Mestrado', 'BM', 2000.00),
(3, 'Bolsa Iniciação Científica', 'BIC', 1000.00),
(4, 'Bolsa Pós-Doutorado', 'BPD', 4000.00),
(5, 'Bolsa Desenvolvimento', 'BDEV', 2500.00);

-- Criando a Tabela Fato
CREATE TABLE fato_pagamento_bolsa (
    id_pessoa_sk INT NOT NULL,
    id_projeto_sk INT NOT NULL,
    id_bolsa_sk INT NOT NULL,
    id_data_sk INT NOT NULL,
    quantidade_meses_pago INT NOT NULL,
    valor_pago NUMERIC(10,2) NOT NULL,
    numero_parcela INT NOT NULL,
    status_pagamento VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_pessoa_sk) REFERENCES dim_pessoa(id_pessoa_sk),
    FOREIGN KEY (id_projeto_sk) REFERENCES dim_projeto(id_projeto_sk),
    FOREIGN KEY (id_bolsa_sk) REFERENCES dim_bolsa(id_bolsa_sk),
    FOREIGN KEY (id_data_sk) REFERENCES dim_data(id_data)
);

INSERT INTO fato_pagamento_bolsa (id_pessoa_sk, id_projeto_sk, id_bolsa_sk, id_data_sk, quantidade_meses_pago, valor_pago, numero_parcela, status_pagamento)
VALUES
(1, 1, 1, 1, 3, 9000.00, 1, 'Pago'),
(2, 2, 2, 2, 6, 12000.00, 2, 'Pago'),
(3, 3, 3, 3, 12, 12000.00, 3, 'Pago'),
(4, 4, 4, 4, 4, 16000.00, 1, 'Pendente'),
(5, 5, 5, 5, 2, 5000.00, 2, 'Pago'),
(6, 6, 1, 6, 8, 24000.00, 3, 'Pago'),
(7, 7, 2, 7, 5, 10000.00, 1, 'Atrasado'),
(8, 8, 3, 8, 7, 7000.00, 2, 'Pago'),
(9, 9, 4, 9, 6, 24000.00, 3, 'Pago'),
(10, 10, 5, 10, 3, 7500.00, 1, 'Cancelado'),
(1, 2, 1, 2, 4, 12000.00, 2, 'Pago'),
(2, 3, 2, 3, 9, 18000.00, 3, 'Pendente'),
(3, 4, 3, 4, 3, 3000.00, 1, 'Pago'),
(4, 5, 4, 5, 12, 48000.00, 2, 'Atrasado'),
(5, 6, 5, 6, 6, 15000.00, 3, 'Pago'),
(6, 7, 1, 7, 8, 24000.00, 1, 'Pago'),
(7, 8, 2, 8, 5, 10000.00, 2, 'Pago'),
(8, 9, 3, 9, 7, 7000.00, 3, 'Pendente'),
(9, 10, 4, 10, 6, 24000.00, 1, 'Pago'),
(10, 1, 5, 1, 3, 7500.00, 2, 'Atrasado'),
(1, 3, 1, 3, 12, 36000.00, 3, 'Pago'),
(2, 4, 2, 4, 6, 12000.00, 1, 'Cancelado'),
(3, 5, 3, 5, 4, 4000.00, 2, 'Pendente'),
(4, 6, 4, 6, 9, 36000.00, 3, 'Pago'),
(5, 7, 5, 7, 6, 15000.00, 1, 'Atrasado'),
(6, 8, 1, 8, 8, 24000.00, 2, 'Pago'),
(7, 9, 2, 9, 5, 10000.00, 3, 'Pago'),
(8, 10, 3, 10, 7, 7000.00, 1, 'Pendente'),
(9, 1, 4, 1, 6, 24000.00, 2, 'Pago'),
(10, 2, 5, 2, 3, 7500.00, 3, 'Cancelado'),
(1, 5, 1, 5, 12, 36000.00, 1, 'Pago'),
(2, 6, 2, 6, 6, 12000.00, 2, 'Pendente'),
(3, 7, 3, 7, 4, 4000.00, 3, 'Pago'),
(4, 8, 4, 8, 9, 36000.00, 1, 'Atrasado'),
(5, 9, 5, 9, 6, 15000.00, 2, 'Pago'),
(6, 10, 1, 10, 8, 24000.00, 3, 'Pago'),
(7, 1, 2, 1, 5, 10000.00, 1, 'Pendente'),
(8, 2, 3, 2, 7, 7000.00, 2, 'Pago'),
(9, 3, 4, 3, 6, 24000.00, 3, 'Atrasado'),
(10, 4, 5, 4, 3, 7500.00, 1, 'Pago'),
(1, 7, 1, 7, 12, 36000.00, 2, 'Pendente'),
(2, 8, 2, 8, 6, 12000.00, 3, 'Pago'),
(3, 9, 3, 9, 4, 4000.00, 1, 'Atrasado'),
(4, 10, 4, 10, 9, 36000.00, 2, 'Pago'),
(5, 1, 5, 1, 6, 15000.00, 3, 'Pendente'),
(6, 2, 1, 2, 8, 24000.00, 1, 'Pago'),
(7, 3, 2, 3, 5, 10000.00, 2, 'Pago'),
(8, 4, 3, 4, 7, 7000.00, 3, 'Cancelado');
