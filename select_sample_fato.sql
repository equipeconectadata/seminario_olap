SELECT 
    fpb.valor_pago,
    fpb.quantidade_meses_pago,
    fpb.numero_parcela,
    fpb.status_pagamento,
    dpro.nome_projeto,
    dbol.descricao_bolsa,
    dp.nome AS nome_pessoa,
    dd.data_completa AS data_ocorrencia
FROM fato_pagamento_bolsa fpb
JOIN dim_pessoa dp ON fpb.id_pessoa_sk = dp.id_pessoa_sk
JOIN dim_projeto dpro ON fpb.id_projeto_sk = dpro.id_projeto_sk
JOIN dim_bolsa dbol ON fpb.id_bolsa_sk = dbol.id_bolsa_sk
JOIN dim_data dd ON fpb.id_data_sk = dd.id_data
ORDER BY fpb.valor_pago DESC
LIMIT 5;
