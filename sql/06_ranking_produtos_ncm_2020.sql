SELECT
    e.CO_NCM,
    n.NO_NCM_POR AS produto,
    round(sum(e.VL_FOB) / 1000000000.0, 2) AS exportacoes_bilhoes_usd
FROM exportacoes AS e
INNER JOIN ncm AS n
    ON e.CO_NCM = n.CO_NCM
WHERE e.CO_ANO = 2020
GROUP BY
    e.CO_NCM,
    n.NO_NCM_POR
ORDER BY sum(e.VL_FOB) DESC
LIMIT 10;