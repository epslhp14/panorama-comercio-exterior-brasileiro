WITH comparativo AS (
    SELECT
        p.NO_PAIS AS pais,

        SUM(CASE
            WHEN e.CO_ANO = 2020 THEN e.VL_FOB
            ELSE 0
        END) AS valor_2020,

        SUM(CASE
            WHEN e.CO_ANO = 2025 THEN e.VL_FOB
            ELSE 0
        END) AS valor_2025

    FROM exportacoes AS e

    INNER JOIN paises AS p
        ON e.CO_PAIS = p.CO_PAIS

    WHERE e.CO_ANO IN (2020, 2025)
        AND e.CO_PAIS IN ('160', '249', '063')

    GROUP BY
        e.CO_PAIS,
        p.NO_PAIS
)

SELECT
    pais,

    ROUND(valor_2020 / 1000000000.0, 2)
        AS exportacoes_2020_bilhoes_usd,

    ROUND(valor_2025 / 1000000000.0, 2)
        AS exportacoes_2025_bilhoes_usd,

    ROUND((valor_2025 - valor_2020) / 1000000000.0, 2)
        AS crescimento_bilhoes_usd,

    ROUND(
        (valor_2025 - valor_2020) * 100.0 /
        NULLIF(valor_2020, 0),
        2
    ) AS crescimento_percentual

FROM comparativo
ORDER BY crescimento_percentual DESC;