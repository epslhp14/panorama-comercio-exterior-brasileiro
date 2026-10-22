WITH totais_anuais AS (
    SELECT
        CO_ANO AS ano,
        sum(VL_FOB) AS total_exportado
    FROM exportacoes
    WHERE CO_ANO BETWEEN 2020 AND 2025
    GROUP BY CO_ANO
)
SELECT
    ano,
    round(total_exportado / 1000000000.0, 2) AS exportacoes_bilhoes_usd,
    round(
        lag(total_exportado) OVER (ORDER BY ano) / 1000000000.0,
        2
    ) AS ano_anterior_bilhoes_usd,
    round(
        (
            total_exportado - lag(total_exportado) OVER (ORDER BY ano)
        ) * 100.0 /
        nullif(
            lag(total_exportado) OVER (ORDER BY ano),
            0
        ),
        2
    ) AS variacao_percentual
FROM totais_anuais
ORDER BY ano;