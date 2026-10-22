WITH exportacoes_anuais AS (
    SELECT
        CO_ANO AS ano,
        SUM(VL_FOB) AS valor_exportado
    FROM exportacoes
    WHERE CO_PAIS = (
        SELECT CO_PAIS
        FROM paises
        WHERE NO_PAIS = 'Índia'
    )
    AND CO_ANO BETWEEN 2020 AND 2025
    GROUP BY CO_ANO
),

comparativo AS (
    SELECT
        ano,
        valor_exportado,
        LAG(valor_exportado) OVER (
            ORDER BY ano
        ) AS valor_ano_anterior
    FROM exportacoes_anuais
)

SELECT
    SUM(CASE
        WHEN valor_exportado > valor_ano_anterior
        THEN 1 ELSE 0
    END) AS anos_crescimento,

    SUM(CASE
        WHEN valor_exportado < valor_ano_anterior
        THEN 1 ELSE 0
    END) AS anos_queda,

    SUM(CASE
        WHEN valor_exportado = valor_ano_anterior
        THEN 1 ELSE 0
    END) AS anos_estabilidade

FROM comparativo
WHERE valor_ano_anterior IS NOT NULL;