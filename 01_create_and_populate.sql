-- ============================================================
--  Projeto: Adoção de IA em Grandes Empresas (2019–2024)
--  Arquivo: 01_create_and_populate.sql
--  Descrição: Criação das tabelas e dados simulados
--  Compatível com: PostgreSQL, MySQL, SQLite
-- ============================================================


-- ─────────────────────────────────────────
-- TABELA 1: Empresas
-- ─────────────────────────────────────────
CREATE TABLE empresas (
    empresa_id      INTEGER PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    setor           VARCHAR(60)  NOT NULL,
    pais            VARCHAR(60)  NOT NULL,
    receita_bi_usd  DECIMAL(6,2) NOT NULL  -- receita anual em bilhões de USD
);

INSERT INTO empresas VALUES
(1,  'TechNova Corp',       'Tecnologia',          'EUA',         180.5),
(2,  'FinGroup International','Serviços Financeiros','Reino Unido', 95.2),
(3,  'RetailMax',           'Varejo',              'EUA',         210.0),
(4,  'HealthBridge',        'Saúde',               'Alemanha',    67.8),
(5,  'AutoDrive Systems',   'Automotivo',          'Japão',       143.3),
(6,  'CloudSphere',         'Tecnologia',          'EUA',         220.1),
(7,  'EnergyCore',          'Energia',             'França',      88.4),
(8,  'LogiChain',           'Logística',           'China',       54.6),
(9,  'MediaStream',         'Entretenimento',      'EUA',         39.7),
(10, 'PharmaNext',          'Farmacêutica',        'Suíça',       112.9);


-- ─────────────────────────────────────────
-- TABELA 2: Ferramentas de IA disponíveis
-- ─────────────────────────────────────────
CREATE TABLE ferramentas_ia (
    ferramenta_id   INTEGER PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    categoria       VARCHAR(60)  NOT NULL,
    fornecedor      VARCHAR(80)  NOT NULL
);

INSERT INTO ferramentas_ia VALUES
(1,  'GitHub Copilot',        'Assistente de Código',     'Microsoft / GitHub'),
(2,  'ChatGPT Enterprise',    'LLM Corporativo',          'OpenAI'),
(3,  'Google Gemini Pro',     'LLM Corporativo',          'Google'),
(4,  'Amazon CodeWhisperer',  'Assistente de Código',     'Amazon'),
(5,  'Salesforce Einstein',   'IA para CRM',              'Salesforce'),
(6,  'Azure AI Services',     'Plataforma de IA',         'Microsoft'),
(7,  'Vertex AI',             'Plataforma de IA',         'Google'),
(8,  'IBM Watson',            'IA para Negócios',         'IBM'),
(9,  'DataRobot',             'AutoML',                   'DataRobot Inc.'),
(10, 'Anthropic Claude API',  'LLM Corporativo',          'Anthropic');


-- ─────────────────────────────────────────
-- TABELA 3: Adoção por empresa/ano
-- ─────────────────────────────────────────
CREATE TABLE adocao_ia (
    adocao_id             INTEGER PRIMARY KEY,
    empresa_id            INTEGER NOT NULL,
    ferramenta_id         INTEGER NOT NULL,
    ano                   INTEGER NOT NULL,
    usuarios_ativos       INTEGER NOT NULL,   -- nº de funcionários usando a ferramenta
    investimento_mil_usd  DECIMAL(10,2) NOT NULL,
    produtividade_ganho_pct DECIMAL(5,2),     -- ganho de produtividade estimado (%)
    FOREIGN KEY (empresa_id)   REFERENCES empresas(empresa_id),
    FOREIGN KEY (ferramenta_id) REFERENCES ferramentas_ia(ferramenta_id)
);

-- TechNova Corp (empresa 1) — alta adoção, pioneira
INSERT INTO adocao_ia VALUES
(1,  1, 1, 2019,  200,   120.00,  5.0),
(2,  1, 1, 2020,  800,   380.00,  8.5),
(3,  1, 1, 2021, 2200,   940.00, 12.0),
(4,  1, 1, 2022, 5100,  2200.00, 18.0),
(5,  1, 1, 2023, 9800,  4100.00, 24.5),
(6,  1, 1, 2024,15200,  6800.00, 31.0),
(7,  1, 2, 2022, 1200,   800.00,  9.0),
(8,  1, 2, 2023, 4500,  2900.00, 15.0),
(9,  1, 2, 2024, 8900,  5400.00, 22.0),
(10, 1, 6, 2023, 3100,  1800.00, 11.0),
(11, 1, 6, 2024, 7200,  4200.00, 19.5);

-- FinGroup International (empresa 2) — adoção moderada, foco em compliance
INSERT INTO adocao_ia VALUES
(12, 2, 8, 2019,  150,   200.00,  4.0),
(13, 2, 8, 2020,  420,   520.00,  6.5),
(14, 2, 8, 2021,  980,  1100.00,  9.0),
(15, 2, 8, 2022, 1900,  2400.00, 12.5),
(16, 2, 8, 2023, 3400,  4100.00, 16.0),
(17, 2, 8, 2024, 5200,  6300.00, 20.0),
(18, 2, 2, 2023,  800,   950.00,  8.0),
(19, 2, 2, 2024, 2100,  2400.00, 13.5);

-- RetailMax (empresa 3) — crescimento rápido em IA de CRM e logística
INSERT INTO adocao_ia VALUES
(20, 3, 5, 2020,  500,   300.00,  6.0),
(21, 3, 5, 2021, 1800,   980.00, 10.5),
(22, 3, 5, 2022, 4200,  2100.00, 15.0),
(23, 3, 5, 2023, 7900,  3800.00, 21.0),
(24, 3, 5, 2024,13100,  6200.00, 28.5),
(25, 3, 9, 2021,  300,   450.00,  7.0),
(26, 3, 9, 2022,  900,  1200.00, 11.0),
(27, 3, 9, 2023, 2100,  2700.00, 16.0),
(28, 3, 9, 2024, 4400,  5100.00, 22.5);

-- HealthBridge (empresa 4) — adoção cautelosa, regulatório pesado
INSERT INTO adocao_ia VALUES
(29, 4, 8, 2020,  100,   180.00,  3.5),
(30, 4, 8, 2021,  280,   420.00,  6.0),
(31, 4, 8, 2022,  650,   900.00,  9.5),
(32, 4, 8, 2023, 1400,  1900.00, 13.0),
(33, 4, 8, 2024, 2800,  3600.00, 18.0),
(34, 4,10, 2024,  600,   950.00, 10.0);

-- AutoDrive Systems (empresa 5) — IA para engenharia e manufatura
INSERT INTO adocao_ia VALUES
(35, 5, 1, 2020,  400,   280.00,  7.0),
(36, 5, 1, 2021, 1200,   780.00, 11.5),
(37, 5, 1, 2022, 3100,  1900.00, 16.0),
(38, 5, 1, 2023, 6400,  3700.00, 22.0),
(39, 5, 1, 2024,10800,  6100.00, 29.0),
(40, 5, 7, 2022,  800,   600.00,  8.5),
(41, 5, 7, 2023, 2200,  1600.00, 14.0),
(42, 5, 7, 2024, 5100,  3400.00, 20.5);

-- CloudSphere (empresa 6) — líder em adoção, empresa nativa em nuvem
INSERT INTO adocao_ia VALUES
(43, 6, 1, 2019,  500,   200.00,  7.5),
(44, 6, 1, 2020, 2100,   800.00, 13.0),
(45, 6, 1, 2021, 5500,  2100.00, 19.5),
(46, 6, 1, 2022,10200,  4500.00, 26.0),
(47, 6, 1, 2023,17400,  7800.00, 33.0),
(48, 6, 1, 2024,24100, 11200.00, 40.0),
(49, 6, 6, 2020, 1800,   600.00, 10.0),
(50, 6, 6, 2021, 4200,  1400.00, 16.0),
(51, 6, 6, 2022, 8100,  2900.00, 23.0),
(52, 6, 6, 2023,14200,  5100.00, 31.0),
(53, 6, 6, 2024,21000,  8900.00, 39.5),
(54, 6, 2, 2023, 5200,  3100.00, 18.0),
(55, 6, 2, 2024,10800,  6400.00, 26.5);

-- EnergyCore (empresa 7)
INSERT INTO adocao_ia VALUES
(56, 7, 7, 2021,  350,   480.00,  6.5),
(57, 7, 7, 2022,  900,  1200.00, 10.0),
(58, 7, 7, 2023, 2100,  2700.00, 14.5),
(59, 7, 7, 2024, 4200,  5100.00, 19.0),
(60, 7, 9, 2022,  200,   380.00,  5.5),
(61, 7, 9, 2023,  700,  1200.00,  9.0),
(62, 7, 9, 2024, 1600,  2600.00, 13.5);

-- LogiChain (empresa 8)
INSERT INTO adocao_ia VALUES
(63, 8, 5, 2020,  300,   180.00,  5.0),
(64, 8, 5, 2021,  800,   460.00,  8.5),
(65, 8, 5, 2022, 1900,  1100.00, 12.5),
(66, 8, 5, 2023, 3800,  2200.00, 17.0),
(67, 8, 5, 2024, 6900,  4100.00, 22.5),
(68, 8, 4, 2022,  500,   320.00,  6.0),
(69, 8, 4, 2023, 1400,   880.00, 10.0),
(70, 8, 4, 2024, 3200,  2000.00, 15.5);

-- MediaStream (empresa 9)
INSERT INTO adocao_ia VALUES
(71, 9, 2, 2021,  600,   350.00,  8.0),
(72, 9, 2, 2022, 1800,   980.00, 13.5),
(73, 9, 2, 2023, 4100,  2200.00, 20.0),
(74, 9, 2, 2024, 7800,  4100.00, 27.5),
(75, 9,10, 2024, 1200,  1400.00, 12.0);

-- PharmaNext (empresa 10)
INSERT INTO adocao_ia VALUES
(76,10, 8, 2019,   80,   250.00,  3.0),
(77,10, 8, 2020,  220,   600.00,  5.5),
(78,10, 8, 2021,  580,  1400.00,  8.5),
(79,10, 8, 2022, 1300,  3100.00, 12.0),
(80,10, 8, 2023, 2600,  5800.00, 16.5),
(81,10, 8, 2024, 4800, 10200.00, 22.0),
(82,10, 9, 2023,  400,  1100.00,  7.5),
(83,10, 9, 2024, 1100,  2900.00, 13.0),
(84,10,10, 2024,  500,   800.00,  9.5);
