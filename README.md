# Crescimento da Adoção de IA em Grandes Empresas (2019–2024)

> **Análise SQL exploratória** sobre como as maiores empresas do mundo estão incorporando ferramentas de Inteligência Artificial em seus softwares e operações — e o que isso significa para produtividade e investimento.

---

## Contexto e motivação

Nos últimos cinco anos, o mercado de IA corporativa passou por uma transformação sem precedentes. O lançamento de modelos como GPT-4, Claude e Gemini marcou um ponto de inflexão: a IA deixou de ser um projeto de P&D e passou a ser parte central da estratégia de negócios de empresas globais.

Este projeto analisa **dados simulados** de 10 grandes corporações de diferentes setores e países, cobrindo o período de 2019 a 2024, para responder perguntas concretas de negócio usando SQL puro.

---

## Perguntas de negócio respondidas

| # | Pergunta | Técnica SQL |
|---|----------|-------------|
| 1 | Qual foi o crescimento total de usuários de IA entre 2019 e 2024? | `GROUP BY`, `SUM`, `AVG` |
| 2 | Quais empresas lideram em adoção em 2024? | `JOIN`, `GROUP BY`, filtro por ano |
| 3 | Qual ferramenta cresceu mais rápido entre 2022 e 2024? | `CTE`, `CASE WHEN`, cálculo de variação % |
| 4 | Existe relação entre investimento e ganho de produtividade? | `JOIN`, `SUM`, `AVG` |
| 5 | Como o setor de tecnologia se compara aos outros setores? | `GROUP BY setor`, `COUNT DISTINCT` |
| 6 | Qual é a taxa de crescimento anual (YoY) por empresa? | `CTE`, `LAG()` (Window Function) |
| 7 | Qual categoria de ferramenta gera mais produtividade? | `JOIN`, `AVG`, `GROUP BY` |

---

## Principais insights

### Crescimento explosivo a partir de 2022

O total de usuários ativos saltou de ~930 em 2019 para mais de 130.000 em 2024 — um crescimento de aproximadamente **140x em cinco anos**. O ponto de inflexão mais claro ocorre entre 2022 e 2023, coincidindo com a chegada de LLMs acessíveis ao mercado corporativo.

### Tecnologia lidera, mas outros setores aceleram

Empresas do setor de tecnologia concentram mais de 50% dos usuários e usam a maior variedade de ferramentas. Contudo, os setores de varejo, automotivo e farmacêutico apresentam as maiores taxas de crescimento relativo no período 2023–2024, sugerindo que a adoção está se tornando transversal.

### Assistentes de código geram os maiores ganhos de produtividade

Ferramentas como GitHub Copilot e Amazon CodeWhisperer registram os maiores ganhos médios de produtividade (~30%), seguidas por LLMs corporativos (ChatGPT Enterprise, Claude API). Isso corrobora estudos reais: o GitHub reportou ganhos de até 55% em velocidade de codificação em experimentos controlados.

### Investimento e produtividade: relação real, mas não linear

Empresas que mais investem tendem a ter maiores ganhos — mas há exceções importantes. Setores com forte regulação (saúde, farmacêutica) investem proporcionalmente mais para obter ganhos menores, enquanto empresas nativas em nuvem extraem mais valor por dólar investido.

---

## Estrutura do projeto

```
ai-adoption-analysis/
├── sql/
│   ├── 01_create_and_populate.sql   # Criação das tabelas e dados
│   └── 02_analises.sql              # 7 queries de análise com insights
└── README.md
```

---

## Modelo de dados

```
empresas          ferramentas_ia
───────────       ──────────────
empresa_id   ←┐  ferramenta_id  ←┐
nome           │  nome             │
setor          │  categoria        │
pais           │  fornecedor       │
receita_bi_usd │                   │
               │  adocao_ia        │
               └─ empresa_id       │
                  ferramenta_id  ──┘
                  ano
                  usuarios_ativos
                  investimento_mil_usd
                  produtividade_ganho_pct
```

**3 tabelas · 84 registros de adoção · 6 anos · 10 empresas · 10 ferramentas**

---

## Como rodar localmente

**Opção 1 — No navegador (sem instalar nada):**
1. Acesse [db-fiddle.com](https://www.db-fiddle.com) ou [sqliteonline.com](https://sqliteonline.com)
2. Cole o conteúdo de `01_create_and_populate.sql` no painel esquerdo e execute
3. Cole as queries de `02_analises.sql` no painel direito e explore

**Opção 2 — PostgreSQL local:**
```bash
psql -U seu_usuario -d seu_banco -f sql/01_create_and_populate.sql
psql -U seu_usuario -d seu_banco -f sql/02_analises.sql
```

**Opção 3 — SQLite:**
```bash
sqlite3 ai_adoption.db < sql/01_create_and_populate.sql
sqlite3 ai_adoption.db < sql/02_analises.sql
```

---

## Técnicas SQL utilizadas

- `JOIN` entre múltiplas tabelas (INNER JOIN)
- Funções de agregação: `SUM`, `AVG`, `COUNT`, `ROUND`
- Filtros com `WHERE` e `HAVING`
- `GROUP BY` com múltiplas colunas
- `CTE` com `WITH` para queries complexas
- `CASE WHEN` para pivotamento de dados
- **Window Function**: `LAG()` com `PARTITION BY` para crescimento YoY
- `NULLIF` para evitar divisão por zero

---

## Sobre os dados

Os dados são **simulados** com base em tendências reportadas por fontes como:
- McKinsey Global Institute — *The State of AI in 2023*
- GitHub — *Octoverse & Copilot Impact Report 2023*
- Gartner — *AI Adoption in Enterprise Software 2024*
- IDC — *Worldwide AI and GenAI Spending Guide 2024*

Os valores refletem ordens de magnitude plausíveis para grandes corporações globais, mas não representam dados reais de nenhuma empresa específica.

---

## Autor

**Léo Sales**
Analista de Dados em formação · Manaus, Brasil

(https://www.linkedin.com/in/léo-sales-5b8a9b2b3/)
[![GitHub](https://img.shields.io/badge/GitHub-black?style=flat&logo=github)](https://github.com/seu-usuario)

---

*Projeto desenvolvido como parte do portfólio de análise de dados. Feedbacks são bem-vindos via Issues ou Pull Requests.*
