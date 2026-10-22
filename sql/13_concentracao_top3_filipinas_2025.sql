
-- AULA 13 - CONCENTRAÇÃO DAS EXPORTAÇÕES
-- Objetivo: calcular a participação dos 3 principais
-- produtos nas exportações para as Filipinas em 2025.

-- ETAPA 1: calcular o valor exportado por produto.
WITH produtos AS (

    SELECT
        -- Código NCM do produto.
        e.CO_NCM AS codigo_ncm,

        -- Soma o valor exportado de cada produto.
        SUM(e.VL_FOB) AS valor_exportado

    -- Tabela de exportações.
    FROM exportacoes AS e

    -- Relaciona o código do país ao nome.
    INNER JOIN paises AS p
        ON e.CO_PAIS = p.CO_PAIS

    -- Seleciona as Filipinas.
    WHERE p.NO_PAIS = 'Filipinas'

    -- Considera somente 2025.
    AND e.CO_ANO = 2025

    -- Agrupa os registros por código NCM.
    GROUP BY e.CO_NCM
),

-- ETAPA 2: selecionar os três maiores produtos.
top_3 AS (

    SELECT
        codigo_ncm,
        valor_exportado

    FROM produtos

    -- Coloca os maiores valores primeiro.
    ORDER BY valor_exportado DESC

    -- Seleciona somente três produtos.
    LIMIT 3
)

-- ETAPA 3: calcular a concentração.
SELECT

    -- Soma o valor dos três principais produtos.
    ROUND(
        (SELECT SUM(valor_exportado) FROM top_3)
        / 1000000000.0,
        2
    ) AS exportacoes_top_3_bilhoes_usd,

    -- Soma o valor de todos os produtos.
    ROUND(
        (SELECT SUM(valor_exportado) FROM produtos)
        / 1000000000.0,
        2
    ) AS exportacoes_totais_bilhoes_usd,

    -- Calcula a participação dos três principais.
    ROUND(
        (SELECT SUM(valor_exportado) FROM top_3)
        * 100.0
        / NULLIF(
            (SELECT SUM(valor_exportado) FROM produtos),
            0
        ),
        2
    ) AS concentracao_top_3_percentual;
