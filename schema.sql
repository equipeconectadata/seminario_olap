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
