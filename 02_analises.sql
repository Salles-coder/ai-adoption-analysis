-- ============================================================
--  Projeto: Adoção de IA em Grandes Empresas (2019–2024)
--  Arquivo: 02_analises.sql
--  Descrição: Queries de análise respondendo perguntas de negócio
-- ============================================================


-- ═══════════════════════════════════════════════════════════
-- PERGUNTA 1
-- Qual foi o crescimento total de usuários de IA entre 2019 e 2024?
-- ═══════════════════════════════════════════════════════════

SELECT
    ano,
    SUM(usuarios_ativos)                                      AS total_usuarios,
    SUM(investimento_mil_usd)                                 AS investimento_total_mil,
    ROUND(AVG(produtividade_ganho_pct), 1)                    AS ganho_produtividade_medio_pct
FROM adocao_ia
GROUP BY ano
ORDER BY ano;

/*
  INSIGHT ESPERADO:
  O total de usuários ativos salta de ~930 em 2019 para mais de 130.000 em 2024,
  representando um crescimento de ~140x em 5 anos. O investimento acompanha
  proporcionalmente, indicando que a escala de adoção é sustentada por budget real.
*/


-- ═══════════════════════════════════════════════════════════
-- PERGUNTA 2
-- Quais empresas lideram em adoção de IA em 2024?
-- ═══════════════════════════════════════════════════════════

SELECT
    e.nome                              AS empresa,
    e.setor,
    SUM(a.usuarios_ativos)              AS usuarios_2024,
    SUM(a.investimento_mil_usd)         AS investimento_2024_mil,
    ROUND(AVG(a.produtividade_ganho_pct), 1) AS ganho_medio_pct
FROM adocao_ia a
JOIN empresas e ON a.empresa_id = e.empresa_id
WHERE a.ano = 2024
GROUP BY e.empresa_id, e.nome, e.setor
ORDER BY usuarios_2024 DESC;

/*
  INSIGHT ESPERADO:
  CloudSphere (Tecnologia/EUA) lidera com ~55.900 usuários e quase $26M investidos.
  Empresas de tecnologia e varejo encabeçam a lista, enquanto saúde e farmacêutica
  ficam atrás — reflexo de barreiras regulatórias, não de falta de interesse.
*/


-- ═══════════════════════════════════════════════════════════
-- PERGUNTA 3
-- Qual ferramenta de IA cresceu mais rápido entre 2022 e 2024?
-- ═══════════════════════════════════════════════════════════

WITH usuarios_por_ano AS (
    SELECT
        ferramenta_id,
        SUM(CASE WHEN ano = 2022 THEN usuarios_ativos ELSE 0 END) AS usuarios_2022,
        SUM(CASE WHEN ano = 2024 THEN usuarios_ativos ELSE 0 END) AS usuarios_2024
    FROM adocao_ia
    GROUP BY ferramenta_id
    HAVING usuarios_2022 > 0
)
SELECT
    f.nome                          AS ferramenta,
    f.categoria,
    u.usuarios_2022,
    u.usuarios_2024,
    ROUND(
        (u.usuarios_2024 - u.usuarios_2022) * 100.0 / u.usuarios_2022, 1
    )                               AS crescimento_pct
FROM usuarios_por_ano u
JOIN ferramentas_ia f ON u.ferramenta_id = f.ferramenta_id
ORDER BY crescimento_pct DESC;

/*
  INSIGHT ESPERADO:
  LLMs Corporativos (ChatGPT Enterprise, Claude API) mostram os maiores
  crescimentos percentuais no período 2022–2024 — validando a narrativa de
  que o lançamento de grandes modelos de linguagem (GPT-4, Claude, Gemini)
  foi um ponto de inflexão na adoção empresarial.
*/


-- ═══════════════════════════════════════════════════════════
-- PERGUNTA 4
-- Existe correlação entre investimento em IA e ganho de produtividade?
-- ═══════════════════════════════════════════════════════════

SELECT
    e.nome                                  AS empresa,
    e.setor,
    SUM(a.investimento_mil_usd)             AS investimento_total_mil,
    ROUND(AVG(a.produtividade_ganho_pct),1) AS ganho_medio_pct,
    SUM(a.usuarios_ativos)                  AS total_usuarios_acumulado
FROM adocao_ia a
JOIN empresas e ON a.empresa_id = e.empresa_id
GROUP BY e.empresa_id, e.nome, e.setor
ORDER BY investimento_total_mil DESC;

/*
  INSIGHT ESPERADO:
  Empresas com maior investimento acumulado tendem a ter maiores ganhos de
  produtividade, mas a relação não é linear: empresas como PharmaNext investem
  muito com ganhos moderados (barreiras regulatórias), enquanto empresas de
  tecnologia extraem mais valor por dólar investido.
*/


-- ═══════════════════════════════════════════════════════════
-- PERGUNTA 5
-- Como o setor de tecnologia se compara aos outros setores em adoção?
-- ═══════════════════════════════════════════════════════════

SELECT
    e.setor,
    COUNT(DISTINCT a.empresa_id)            AS qtd_empresas,
    SUM(a.usuarios_ativos)                  AS total_usuarios,
    ROUND(SUM(a.investimento_mil_usd), 0)   AS investimento_total_mil,
    ROUND(AVG(a.produtividade_ganho_pct),1) AS ganho_medio_pct,
    COUNT(DISTINCT a.ferramenta_id)         AS ferramentas_distintas_usadas
FROM adocao_ia a
JOIN empresas e ON a.empresa_id = e.empresa_id
GROUP BY e.setor
ORDER BY total_usuarios DESC;

/*
  INSIGHT ESPERADO:
  O setor de Tecnologia concentra mais de 50% de todos os usuários ativos
  e usa a maior variedade de ferramentas. Isso indica não apenas adoção maior,
  mas também experimentação mais ampla — característica de empresas que usam
  IA tanto para produto quanto para operações internas.
*/


-- ═══════════════════════════════════════════════════════════
-- PERGUNTA 6
-- Taxa de crescimento anual por empresa (YoY Growth)
-- ═══════════════════════════════════════════════════════════

WITH usuarios_ano AS (
    SELECT
        empresa_id,
        ano,
        SUM(usuarios_ativos) AS usuarios
    FROM adocao_ia
    GROUP BY empresa_id, ano
),
com_anterior AS (
    SELECT
        u.empresa_id,
        u.ano,
        u.usuarios                                              AS usuarios_atual,
        LAG(u.usuarios) OVER (
            PARTITION BY u.empresa_id ORDER BY u.ano
        )                                                       AS usuarios_ano_anterior
    FROM usuarios_ano u
)
SELECT
    e.nome                  AS empresa,
    c.ano,
    c.usuarios_atual,
    c.usuarios_ano_anterior,
    ROUND(
        (c.usuarios_atual - c.usuarios_ano_anterior) * 100.0
        / NULLIF(c.usuarios_ano_anterior, 0), 1
    )                       AS crescimento_yoy_pct
FROM com_anterior c
JOIN empresas e ON c.empresa_id = e.empresa_id
WHERE c.usuarios_ano_anterior IS NOT NULL
ORDER BY c.ano, crescimento_yoy_pct DESC;

/*
  INSIGHT ESPERADO:
  Os maiores crescimentos YoY ocorrem entre 2022 e 2023 — coincidindo com
  o lançamento de ferramentas baseadas em LLMs. CloudSphere e TechNova
  sustentam crescimentos acima de 50% por múltiplos anos consecutivos,
  indicando que a adoção não é um evento pontual, mas uma estratégia contínua.
*/


-- ═══════════════════════════════════════════════════════════
-- PERGUNTA 7
-- Qual categoria de ferramenta gera mais ganho de produtividade?
-- ═══════════════════════════════════════════════════════════

SELECT
    f.categoria,
    COUNT(DISTINCT a.empresa_id)            AS empresas_que_usam,
    SUM(a.usuarios_ativos)                  AS total_usuarios,
    ROUND(AVG(a.produtividade_ganho_pct),1) AS ganho_medio_pct,
    ROUND(SUM(a.investimento_mil_usd), 0)   AS investimento_total_mil
FROM adocao_ia a
JOIN ferramentas_ia f ON a.ferramenta_id = f.ferramenta_id
GROUP BY f.categoria
ORDER BY ganho_medio_pct DESC;

/*
  INSIGHT ESPERADO:
  Assistentes de código (GitHub Copilot, CodeWhisperer) apresentam os maiores
  ganhos de produtividade — corroborado por estudos reais (GitHub reportou
  ganhos de até 55% em velocidade de codificação). LLMs Corporativos surgem
  em segundo lugar, com ganhos crescentes à medida que as empresas aprendem
  a usá-los em workflows críticos.
*/
