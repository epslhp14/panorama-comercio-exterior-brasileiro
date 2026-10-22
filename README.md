# Panorama do Comércio Exterior Brasileiro | 2020–2025

### Análise de Dados | SQL | SQLite | Power BI

Projeto de análise das exportações brasileiras entre 2020 e 2025, desenvolvido para explorar a evolução do comércio exterior, identificar os principais mercados internacionais e analisar a participação dos produtos exportados.

O trabalho contempla organização e consolidação de dados, consultas SQL, modelagem relacional, construção de indicadores e desenvolvimento de dashboards no Power BI.

## 1. Objetivo

Transformar dados de exportações brasileiras em informações estruturadas para análise e apoio à tomada de decisão.

**Principais questões analisadas:**

- Como evoluíram as exportações brasileiras entre 2020 e 2025?
- Quais países representam os principais destinos?
- Quais produtos apresentam maior participação no valor exportado?
- Como variaram os valores exportados em relação ao ano anterior?
- Qual é a concentração das exportações nos principais mercados e produtos?

## 2. Ferramentas utilizadas

| Ferramenta | Aplicação |
|---|---|
| SQL | Consultas, agregações e consolidação de dados |
| SQLite 3 | Armazenamento e organização do banco de dados |
| Letos 4.0.4 | Execução e validação das consultas SQL |
| Power BI Desktop | Modelagem, indicadores e visualização de dados |
| DAX | Cálculo de indicadores e variações anuais |

## 3. Estrutura dos dados

O banco SQLite utilizado no projeto contém as seguintes tabelas:

- `exportacoes`: dados das operações de exportação.
- `exportacoes_consolidadas`: base consolidada utilizada nas análises SQL.
- `ncm`: informações de classificação dos produtos.
- `paises`: informações dos países de destino.

A tabela `exportacoes_consolidadas` possui aproximadamente **4,25 milhões de registros**.

No Power BI, foi desenvolvido um modelo com relacionamentos muitos-para-um entre a tabela de exportações e as tabelas de referência de países e produtos.

## 4. Exemplo de consulta SQL

A consulta abaixo apresenta a evolução anual do valor exportado, em bilhões de dólares.

```sql
SELECT
    CO_ANO AS Ano,
    ROUND(SUM(Valor_Exportado_USD) / 1000000000.0, 2)
        AS Exportacoes_Bilhoes_USD
FROM exportacoes_consolidadas
GROUP BY CO_ANO
ORDER BY CO_ANO;
```

**Resultado:**

| Ano | Exportações (US$ bilhões) |
|---|---:|
| 2020 | 209,18 |
| 2021 | 280,81 |
| 2022 | 334,14 |
| 2023 | 339,70 |
| 2024 | 337,05 |
| 2025 | 348,28 |

## 5. Indicadores desenvolvidos

- Valor total exportado em dólares.
- Peso líquido exportado.
- Valor médio por quilograma.
- Crescimento anual das exportações.
- Valor exportado no ano anterior.
- Participação dos países de destino.
- Participação dos produtos exportados.
- Variação anual em percentual e valor.
- Concentração dos dez principais mercados e produtos.

## 6. Dashboard Power BI

O relatório está organizado em três páginas.

### Visão Executiva

Apresenta os indicadores gerais, a evolução histórica das exportações e os dez principais países de destino.

### Mercados Internacionais

Permite analisar os países de destino, suas participações, variações anuais e evolução histórica.

### Produtos Exportados

Apresenta os principais produtos exportados, participação no valor total, variações anuais e concentração das exportações.

O dashboard permite selecionar o ano de referência e explorar os dados por meio de filtros e interações.

## 7. Principais resultados — 2025

| Indicador | Resultado |
|---|---:|
| Valor exportado | US$ 348,28 bilhões |
| Crescimento em relação a 2024 | +3,33% |
| Peso líquido exportado | 859,83 bilhões de kg |
| Valor médio | US$ 0,41/kg |
| Participação dos 10 principais destinos | 61,05% |
| Concentração dos 10 principais produtos | 53,43% |

**Destaques identificados:**

- A China foi o principal destino das exportações brasileiras, com aproximadamente US$ 99,94 bilhões em 2025.
- Óleos brutos de petróleo lideraram o ranking de produtos exportados, com aproximadamente US$ 44,54 bilhões.
- As exportações brasileiras cresceram 3,33% em relação a 2024.

## 8. Materiais do projeto

### Vídeo demonstrativo

[![Assistir à demonstração do projeto](https://img.youtube.com/vi/dm3gn_GoKV8/hqdefault.jpg)](https://youtu.be/dm3gn_GoKV8)

▶️ **[Assistir ao vídeo no YouTube](https://youtu.be/dm3gn_GoKV8)**

Demonstração prática do banco de dados SQLite, execução de consultas SQL no Letos, modelagem relacional e navegação pelas três páginas do dashboard no Power BI.

### Documentação e arquivos

- 📊 [Visualizar o relatório Power BI em PDF](Panorama_Comercio_Exterior_Brasileiro_2025.pdf)
- 💻 [Consultar as 14 consultas SQL](sql/)
- 📚 [Documentação das consultas SQL](sql/README.md)
- 🎬 [Arquivo MP4 do vídeo](video/Portfolio_Comercio_Exterior_SQL_PowerBI.mp4)

## 9. Competências aplicadas

- Consultas SQL e agregação de dados.
- Organização de banco de dados relacional.
- Tratamento e consolidação de informações.
- Modelagem de dados no Power BI.
- Desenvolvimento de indicadores com DAX.
- Construção de dashboards.
- Análise exploratória e interpretação de indicadores.
- Comunicação visual de resultados.

---

**Projeto de portfólio profissional desenvolvido para demonstrar competências práticas em análise de dados, SQL, modelagem e Business Intelligence.**
