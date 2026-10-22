
-- AULA 14 - CONCENTRAÇÃO DAS EXPORTAÇÕES POR PAÍS
-- Objetivo: comparar a participação dos três
-- principais produtos em cada mercado em 2025.

-- ETAPA 1: calcular as exportações por país e produto.
WITH produtos AS (

    SELECT
        -- Nome do país de destino.
        p.NO_PAIS AS pais,

        -- Código NCM do produto.
        e.CO_NCM AS codigo_ncm,

        -- Valor total exportado por produto.
        SUM(e.VL_FOB) AS valor_exportado

    -- Tabela principal.
    FROM exportacoes AS e

    -- Relaciona o código ao nome do país.
    INNER JOIN paises AS p
        ON e.CO_PAIS = p.CO_PAIS

    -- Seleciona os três mercados.
    WHERE p.NO_PAIS IN (
        'Filipinas',
        'Índia',
        'Panamá'
    )

    -- Considera o ano completo de 2025.
    AND e.CO_ANO = 2025

    -- Agrupa por país e código NCM.
    GROUP BY p.NO_PAIS, e.CO_NCM
),

-- ETAPA 2: criar um ranking dentro de cada país.
ranking AS (

    SELECT
        pais,
        codigo_ncm,
        valor_exportado,

        -- Numera os produtos do maior para o menor.
        -- PARTITION BY reinicia o ranking por país.
        ROW_NUMBER() OVER (
            PARTITION BY pais
            ORDER BY valor_exportado DESC, codigo_ncm
        ) AS posicao

    FROM produtos
)

-- ETAPA 3: calcular a concentração por país.
SELECT
    -- Nome do país.
    pais,

    -- Valor total exportado em bilhões de dólares.
    ROUND(
        SUM(valor_exportado) / 1000000000.0,
        2
    ) AS exportacoes_totais_bilhoes_usd,

    -- Soma somente os três primeiros produtos.
    ROUND(
        SUM(
            CASE
                WHEN posicao <= 3 THEN valor_exportado
                ELSE 0
            END
        ) / 1000000000.0,
        2
    ) AS exportacoes_top3_bilhoes_usd,

    -- Calcula a participação dos três principais.
    ROUND(
        SUM(
            CASE
                WHEN posicao <= 3 THEN valor_exportado
                ELSE 0
            END
        ) * 100.0
        / NULLIF(SUM(valor_exportado), 0),
        2
    ) AS concentracao_top3_percentual

-- Utiliza os dados classificados por produto.
FROM ranking

-- Calcula os indicadores separadamente por país.
GROUP BY pais

-- Mostra primeiro o mercado mais concentrado.
ORDER BY concentracao_top3_percentual DESC;
