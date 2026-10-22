SELECT
    CO_PAIS,
    sum(VL_FOB) AS total_exportado_usd
FROM exportacoes
WHERE CO_ANO = 2020
GROUP BY CO_PAIS
ORDER BY total_exportado_usd DESC
LIMIT 10;