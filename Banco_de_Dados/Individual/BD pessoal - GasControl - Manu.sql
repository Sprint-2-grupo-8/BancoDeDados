CREATE DATABASE gascontrol;
USE gascontrol;

--  USUÁRIOS
CREATE TABLE usuarios (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

--  CULTIVO
CREATE TABLE cultivo (
    id_cultivo INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    co2_ideal_min INT,
    co2_ideal_max INT
);

--  ESTUFAS
CREATE TABLE estufas (
    id_estufa INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario INT,
    id_cultivo INT,
    nome VARCHAR(100),
    area_m2 DECIMAL(10,2),
    altura_m DECIMAL(5,2),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_cultivo) REFERENCES culturas(id_cultivo)
);

--  SENSORES
CREATE TABLE sensores (
    id_sensor INT PRIMARY KEY AUTO_INCREMENT,
    id_estufa INT,
    tipo VARCHAR(50),
    localizacao VARCHAR(100),
    FOREIGN KEY (id_estufa) REFERENCES estufas(id_estufa)
);

-- LEITURAS DO SENSOR
CREATE TABLE leituras (
    id_leitura INT PRIMARY KEY AUTO_INCREMENT,
    id_sensor INT,
    valor DECIMAL(10,2),
    data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_sensor) REFERENCES sensores(id_sensor)
);

--  PRODUÇÃO
CREATE TABLE producoes (
    id_producao INT PRIMARY KEY AUTO_INCREMENT,
    id_estufa INT,
    mes DATE,
    quantidade_kg DECIMAL(10,2),
    preco_kg DECIMAL(10,2),
    FOREIGN KEY (id_estufa) REFERENCES estufas(id_estufa)
);

-- SIMULAÇÕES 
CREATE TABLE simulacoes (
    id_simulacao INT PRIMARY KEY AUTO_INCREMENT,
    id_producao INT,
    tipo_simulacao VARCHAR(50), -- conservadora, otimista, real
    ganho_percentual DECIMAL(5,2),
    nova_producao DECIMAL(10,2),
    nova_receita DECIMAL(10,2),
    lucro_adicional DECIMAL(10,2),
    FOREIGN KEY (id_producao) REFERENCES producoes(id_producao)
);

-- Usuário
INSERT INTO usuarios (nome, email)
VALUES ('Manuella', 'manu@email.com');

-- Cultivo
INSERT INTO cultivo (nome, co2_ideal_min, co2_ideal_max)
VALUES ('Morango', 600, 800);

-- Estufa
INSERT INTO estufas (id_usuario, id_cultivo, nome, area_m2, altura_m)
VALUES (1, 1, 'Estufa Principal', 500, 3);

-- Sensores
INSERT INTO sensores (id_estufa, tipo, localizacao)
VALUES 
(1, 'CO2', 'Centro'),
(1, 'CO2', 'Entrada');

-- Leituras
INSERT INTO leituras (id_sensor, valor)
VALUES
(1, 350),
(1, 420),
(2, 380);

-- Produção
INSERT INTO producoes (id_estufa, mes, quantidade_kg, preco_kg)
VALUES (1, '2026-03-01', 1000, 20);

-- Simulações múltiplas (AGORA FAZ SENTIDO)
INSERT INTO simulacoes (
    id_producao,
    tipo_simulacao,
    ganho_percentual,
    nova_producao,
    nova_receita,
    lucro_adicional
)
VALUES
(1, 'conservadora', 20, 1200, 24000, 4000),
(1, 'realista', 25, 1250, 25000, 5000),
(1, 'otimista', 30, 1300, 26000, 6000);


-- Comparar
SELECT 
    p.mes,
    s.tipo_simulacao,
    s.ganho_percentual,
    s.nova_receita,
    s.lucro_adicional
FROM simulacoes s
JOIN producoes p ON s.id_producao = p.id_producao
ORDER BY s.ganho_percentual;


