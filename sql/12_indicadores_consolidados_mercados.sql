
-- AULA 12 - INDICADORES CONSOLIDADOS POR MERCADO
-- Objetivo: analisar tamanho, crescimento e consistência.

-- ETAPA 1: calcular exportações por país e ano.
WITH exportacoes_anuais AS (

    SELECT
        -- Nome do país.
        p.NO_PAIS AS pais,

        -- Ano da exportação.
        e.CO_ANO AS ano,

        -- Valor total exportado em dólares.
        SUM(e.VL_FOB) AS valor_exportado

    -- Tabela principal de exportações.
    FROM exportacoes AS e

    -- Relaciona os códigos aos nomes dos países.
    INNER JOIN paises AS p
        ON e.CO_PAIS = p.CO_PAIS

    -- Seleciona os três mercados.
    WHERE p.NO_PAIS IN (
        'Índia',
        'Filipinas',
        'Panamá'
    )

    -- Considera apenas os anos completos.
    AND e.CO_ANO BETWEEN 2020 AND 2025

    -- Consolida os valores por país e ano.
    GROUP BY e.CO_PAIS, p.NO_PAIS, e.CO_ANO
),

-- ETAPA 2: comparar cada ano com o anterior.
comparativo AS (

    SELECT
        pais,
        ano,
        valor_exportado,

        -- Recupera o valor do ano anterior.
        -- PARTITION BY separa os cálculos por país.
        LAG(valor_exportado) OVER (
            PARTITION BY pais
            ORDER BY ano
        ) AS valor_ano_anterior

    FROM exportacoes_anuais
),

-- ETAPA 3: calcular indicadores por mercado.
indicadores AS (

    SELECT
        pais,

        -- Obtém o valor exportado em 2020.
        MAX(CASE
            WHEN ano = 2020 THEN valor_exportado
        END) AS valor_2020,

        -- Obtém o valor exportado em 2025.
        MAX(CASE
            WHEN ano = 2025 THEN valor_exportado
        END) AS valor_2025,

        -- Conta os intervalos com crescimento.
        SUM(CASE
            WHEN valor_exportado > valor_ano_anterior
            THEN 1 ELSE 0
        END) AS anos_crescimento,

        -- Conta os intervalos com queda.
        SUM(CASE
            WHEN valor_exportado < valor_ano_anterior
            THEN 1 ELSE 0
        END) AS anos_queda,

        -- Conta os intervalos que possuem comparação.
        COUNT(valor_ano_anterior) AS anos_comparados

    FROM comparativo

    -- Produz indicadores separados por país.
    GROUP BY pais
)

-- ETAPA 4: apresentar os resultados consolidados.
SELECT
    pais,

    -- Exportações de 2025 em bilhões de dólares.
    ROUND(valor_2025 / 1000000000.0, 2)
        AS exportacoes_2025_bilhoes_usd,

    -- Crescimento acumulado entre 2020 e 2025.
    ROUND(
        (valor_2025 - valor_2020) * 100.0
        / NULLIF(valor_2020, 0),
        2
    ) AS crescimento_percentual,

    -- Quantidade de anos com crescimento.
    anos_crescimento,

    -- Quantidade de anos com queda.
    anos_queda,

    -- Percentual de intervalos com crescimento.
    ROUND(
        anos_crescimento * 100.0
        / NULLIF(anos_comparados, 0),
        2
    ) AS consistencia_percentual

FROM indicadores

-- Ordena pelo maior crescimento acumulado.
ORDER BY crescimento_percentual DESC;