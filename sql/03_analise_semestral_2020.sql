WITH totais AS (
    SELECT
        SUM(
            CASE
                WHEN CO_MES BETWEEN 1 AND 6
                THEN VL_FOB
                ELSE 0
            END
        ) AS primeiro_semestre,
        
        sum(
            CASE
                WHEN CO_MES BETWEEN 7 AND 12
                THEN VL_FOB
                ELSE 0
            END
        ) AS segundo_semestre
    FROM exportacoes
    WHERE CO_ANO = 2020
)

SELECT
    primeiro_semestre,
    segundo_semestre,
    
    (segundo_semestre - primeiro_semestre)
        AS diferenca_usd,
    
    round(
        (segundo_semestre - primeiro_semestre) * 100.0
        / nullif(primeiro_semestre, 0),
        2
    ) AS variação_percentual
FROM totais;