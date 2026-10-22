SELECT
    e.CO_PAIS,
    p.NO_PAIS,
    round(sum(e.VL_FOB) / 1000000000.0, 2) AS exportacoes_bilhoes_usd
FROM exportacoes AS e
INNER JOIN paises AS p
    ON e.CO_PAIS = p.CO_PAIS
WHERE e.CO_ANO = 2020
GROUP BY
    e.CO_PAIS,
    p.NO_PAIS
ORDER BY exportacoes_bilhoes_usd DESC
LIMIT 10;