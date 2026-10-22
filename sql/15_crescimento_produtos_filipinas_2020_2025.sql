
-- AULA 15 - CRESCIMENTO DAS EXPORTAÇÕES POR PRODUTO
-- Objetivo: identificar os cinco produtos NCM com
-- maior aumento absoluto nas exportações brasileiras
-- para as Filipinas entre 2020 e 2025.

-- ETAPA 1: consolidar os valores por produto.
WITH comparativo AS (

    SELECT
        -- Código NCM do produto.
        e.CO_NCM AS codigo_ncm,

        -- Descrição do produto em português.
        n.NO_NCM_POR AS produto,

        -- Valor exportado em 2020.
        SUM(
            CASE
                WHEN e.CO_ANO = 2020 THEN e.VL_FOB
                ELSE 0
            END
        ) AS valor_2020,

        -- Valor exportado em 2025.
        SUM(
            CASE
                WHEN e.CO_ANO = 2025 THEN e.VL_FOB
                ELSE 0
            END
        ) AS valor_2025

    -- Tabela principal de exportações.
    FROM exportacoes AS e

    -- Relaciona o código ao nome do país.
    INNER JOIN paises AS p
        ON e.CO_PAIS = p.CO_PAIS

    -- Relaciona o código NCM à descrição.
    INNER JOIN ncm AS n
        ON e.CO_NCM = n.CO_NCM

    -- Seleciona somente as Filipinas.
    WHERE p.NO_PAIS = 'Filipinas'

    -- Compara os dois anos completos.
    AND e.CO_ANO IN (2020, 2025)

    -- Agrupa os registros por produto.
    GROUP BY e.CO_NCM, n.NO_NCM_POR
)

-- ETAPA 2: calcular a variação absoluta.
SELECT
    -- Código do produto.
    codigo_ncm,

    -- Descrição do produto.
    produto,

    -- Exportações em 2020, em milhões de dólares.
    ROUND(valor_2020 / 1000000.0, 2)
        AS exportacoes_2020_milhoes_usd,

    -- Exportações em 2025, em milhões de dólares.
    ROUND(valor_2025 / 1000000.0, 2)
        AS exportacoes_2025_milhoes_usd,

    -- Diferença entre os valores dos dois anos.
    ROUND(
        (valor_2025 - valor_2020) / 1000000.0,
        2
    ) AS aumento_milhoes_usd

-- Utiliza os valores calculados na CTE.
FROM comparativo

-- Ordena pelo maior aumento absoluto.
ORDER BY (valor_2025 - valor_2020) DESC

-- Mostra somente os cinco maiores aumentos.
LIMIT 5;
