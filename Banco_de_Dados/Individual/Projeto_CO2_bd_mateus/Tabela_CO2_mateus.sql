CREATE DATABASE projeto_sprint;
USE projeto_sprint;

-- =====================================================
-- TABELA: cadastros
-- =====================================================

CREATE TABLE cadastros (
    id_cadastros INT AUTO_INCREMENT,
    nome VARCHAR(45),
    telefone VARCHAR(20),
    email VARCHAR(45),
    senha VARCHAR(255),

    CONSTRAINT ctpk_cadastros
        PRIMARY KEY (id_cadastros)
);

-- Inserts

INSERT INTO cadastros (nome, telefone, email, senha) VALUES
('Mateus', '11999990001', 'mateus@email.com', 'hash123'),
('Amanda', '11999990002', 'amanda@email.com', 'hash456'),
('Arthur', '11999990003', 'arthur@email.com', 'hash789');



-- =====================================================
-- TABELA: empresas
-- =====================================================

CREATE TABLE empresas (
    id_empresas INT AUTO_INCREMENT,
    nome VARCHAR(45),
    email VARCHAR(45),
    fk_cadastros INT,

    CONSTRAINT ctpk_empresas
        PRIMARY KEY (id_empresas),

    CONSTRAINT ctfk_empresas_cadastros
        FOREIGN KEY (fk_cadastros)
        REFERENCES cadastros(id_cadastros)
);

-- Inserts

INSERT INTO empresas (nome, email, fk_cadastros) VALUES
('AgroTech', 'contato@agrotech.com', 1),
('GreenFarm', 'contato@greenfarm.com', 2),
('BioPlant', 'contato@bioplant.com', 3);



-- =====================================================
-- TABELA: estufas
-- =====================================================

CREATE TABLE estufas (
    id_estufas INT AUTO_INCREMENT,
    identificacao VARCHAR(45),
    fk_empresas INT,

    CONSTRAINT ctpk_estufas
        PRIMARY KEY (id_estufas),

    CONSTRAINT ctfk_estufas_empresas
        FOREIGN KEY (fk_empresas)
        REFERENCES empresas(id_empresas)
);

-- Inserts

INSERT INTO estufas (identificacao, fk_empresas) VALUES
('Estufa A', 1),
('Estufa B', 2),
('Estufa C', 3);



-- =====================================================
-- TABELA: sensor
-- =====================================================

CREATE TABLE sensor (
    id_sensor INT AUTO_INCREMENT,
    fk_estufas INT,

    CONSTRAINT ctpk_sensor
        PRIMARY KEY (id_sensor),

    CONSTRAINT ctfk_sensor_estufas
        FOREIGN KEY (fk_estufas)
        REFERENCES estufas(id_estufas)
);

-- Inserts

INSERT INTO sensor (fk_estufas) VALUES
(1),
(2),
(3);



-- =====================================================
-- TABELA: registros
-- =====================================================

CREATE TABLE registros (
    id_registros INT AUTO_INCREMENT,
    gas_ppm INT,
    horario DATETIME,
    fk_sensor INT,

    CONSTRAINT ctpk_registros
        PRIMARY KEY (id_registros),

    CONSTRAINT ctfk_registros_sensor
        FOREIGN KEY (fk_sensor)
        REFERENCES sensor(id_sensor)
);

-- Inserts

INSERT INTO registros (gas_ppm, horario, fk_sensor) VALUES
(450, '2026-03-27 10:00:00', 1),
(780, '2026-03-27 10:05:00', 2),
(920, '2026-03-27 10:10:00', 3);



-- =====================================================
-- TABELA: alertas
-- =====================================================

CREATE TABLE alertas (
    id_alertas INT AUTO_INCREMENT,
    horario DATETIME,
    fk_estufas INT,

    CONSTRAINT ctpk_alertas
        PRIMARY KEY (id_alertas),

    CONSTRAINT ctfk_alertas_estufas
        FOREIGN KEY (fk_estufas)
        REFERENCES estufas(id_estufas)
);

-- Inserts

INSERT INTO alertas (horario, fk_estufas) VALUES
('2026-03-27 10:10:00', 1),
('2026-03-27 10:20:00', 2),
('2026-03-27 10:30:00', 3);


-- Visão Geral
SELECT
    e.nome AS empresa,
    es.identificacao AS estufa,
    s.id_sensor,
    r.gas_ppm,
    r.horario
FROM registros r
JOIN sensor s
    ON r.fk_sensor = s.id_sensor
JOIN estufas es
    ON s.fk_estufas = es.id_estufas
JOIN empresas e
    ON es.fk_empresas = e.id_empresas
ORDER BY r.horario DESC;

-- Alertas, estufas e empresas
SELECT
    a.id_alertas,
    a.horario,
    es.identificacao AS estufa,
    e.nome AS empresa
FROM alertas a
JOIN estufas es
    ON a.fk_estufas = es.id_estufas
JOIN empresas e
    ON es.fk_empresas = e.id_empresas;
    
-- Sensores e registros
SELECT
    r.id_registros,
    r.gas_ppm,
    r.horario,
    s.id_sensor
FROM registros r
JOIN sensor s
    ON r.fk_sensor = s.id_sensor;
    
-- Empresas e estufas
SELECT
    s.id_sensor,
    es.identificacao AS estufa,
    e.nome AS empresa
FROM sensor s
JOIN estufas es
    ON s.fk_estufas = es.id_estufas
JOIN empresas e
    ON es.fk_empresas = e.id_empresas;
    
-- Empresas e cadastros
SELECT
    e.id_empresas,
    e.nome AS empresa,
    c.nome AS cadastro,
    c.email
FROM empresas e
JOIN cadastros c
    ON e.fk_cadastros = c.id_cadastros;