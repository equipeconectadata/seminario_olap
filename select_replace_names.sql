SELECT 
    id_projeto_sk, 
    id_projeto, 
    REGEXP_REPLACE(nome_projeto, '[^a-zA-Z0-9 ]', '', 'g') AS nome_projeto_corrigido,
    edital
FROM dim_projeto;
