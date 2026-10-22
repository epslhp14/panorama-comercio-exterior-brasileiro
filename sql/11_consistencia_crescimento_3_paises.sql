
-- AULA 11 - CONSISTÊNCIA DE CRESCIMENTO POR PAÍS
-- Objetivo: contar os anos de crescimento e queda
-- das exportações brasileiras para três mercados.

-- ETAPA 1: calcular o total exportado por país e ano.
WITH exportacoes_anuais AS (

    SELECT
        -- Nome do país.
        p.NO_PAIS AS pais,

        -- Ano da exportação.
        e.CO_ANO AS ano,

        -- Soma das exportações em dólares.
        SUM(e.VL_FOB) AS valor_exportado

    -- Tabela que contém os registros de exportações.
    FROM exportacoes AS e

    -- Relaciona cada exportação ao nome do país.
    INNER JOIN paises AS p
        ON e.CO_PAIS = p.CO_PAIS

    -- Seleciona os três mercados estudados.
    WHERE p.NO_PAIS IN ('Índia', 'Filipinas', 'Panamá')

    -- Considera somente os anos completos.
    AND e.CO_ANO BETWEEN 2020 AND 2025

    -- Consolida os valores por país e ano.
    GROUP BY e.CO_PAIS, p.NO_PAIS, e.CO_ANO
),

-- ETAPA 2: recuperar o valor do ano anterior.
comparativo AS (

    SELECT
        pais,
        ano,
        valor_exportado,

        -- LAG recupera o valor do ano anterior.
        -- PARTITION BY reinicia a comparação para cada país.
        LAG(valor_exportado) OVER (
            PARTITION BY pais
            ORDER BY ano
        ) AS valor_ano_anterior

    FROM exportacoes_anuais
)

-- ETAPA 3: calcular os indicadores de consistência.
SELECT
    -- Apresenta uma linha para cada país.
    pais,

    -- Conta os anos em que houve crescimento.
    SUM(CASE
        WHEN valor_exportado > valor_ano_anterior
        THEN 1 ELSE 0
    END) AS anos_crescimento,

    -- Conta os anos em que houve queda.
    SUM(CASE
        WHEN valor_exportado < valor_ano_anterior
        THEN 1 ELSE 0
    END) AS anos_queda,

    -- Calcula a proporção de anos com crescimento.
    ROUND(
        100.0 * SUM(CASE
            WHEN valor_exportado > valor_ano_anterior
            THEN 1 ELSE 0
        END)
        / NULLIF(COUNT(valor_ano_anterior), 0),
        2
    ) AS consistencia_percentual

-- Utiliza os valores anuais já comparados.
FROM comparativo

-- Garante um resultado separado para cada país.
GROUP BY pais

-- Coloca os países mais consistentes primeiro.
ORDER BY consistencia_percentual DESC;
