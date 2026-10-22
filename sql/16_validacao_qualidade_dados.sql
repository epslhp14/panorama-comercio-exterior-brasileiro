
-- AULA 16 - VALIDAÇÃO DA QUALIDADE DOS DADOS
-- Objetivo: verificar quantidade de registros,
-- informações ausentes e valores negativos por ano.

SELECT
    -- Ano de referência.
    CO_ANO AS ano,

    -- Quantidade total de registros no ano.
    COUNT(*) AS total_registros,

    -- Conta registros sem código de país.
    SUM(
        CASE
            WHEN CO_PAIS IS NULL OR TRIM(CO_PAIS) = ''
            THEN 1 ELSE 0
        END
    ) AS registros_sem_pais,

    -- Conta registros sem código NCM.
    SUM(
        CASE
            WHEN CO_NCM IS NULL OR TRIM(CO_NCM) = ''
            THEN 1 ELSE 0
        END
    ) AS registros_sem_ncm,

    -- Conta registros com valor FOB negativo.
    SUM(
        CASE
            WHEN VL_FOB < 0
            THEN 1 ELSE 0
        END
    ) AS valores_fob_negativos,

    -- Soma as exportações em bilhões de dólares.
    ROUND(
        SUM(VL_FOB) / 1000000000.0,
        2
    ) AS exportacoes_bilhoes_usd

-- Consulta a tabela principal do projeto.
FROM exportacoes

-- Seleciona o período completo da base.
WHERE CO_ANO BETWEEN 2020 AND 2026

-- Agrupa os resultados por ano.
GROUP BY CO_ANO

-- Apresenta os anos em ordem cronológica.
ORDER BY CO_ANO;
