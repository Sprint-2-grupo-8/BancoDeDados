CREATE DATABASE monitoramento_estufas;
USE monitoramento_estufas;

CREATE TABLE empresa (
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20),
    telefone VARCHAR(20),
    email VARCHAR(100),
    cidade VARCHAR(100),
    estado VARCHAR(50),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE responsavel (
    id_responsavel INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    cpf VARCHAR(20),
    telefone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE estufa (
    id_estufa INT AUTO_INCREMENT PRIMARY KEY,
    id_empresa INT,
    id_responsavel INT,
    nome VARCHAR(100),
    tipo_cultivo VARCHAR(50),
    latitude DECIMAL(10,6),
    longitude DECIMAL(10,6),
    tamanho_m2 DECIMAL(10,2),
    data_ativacao DATE,
    status VARCHAR(20),
    FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa),
    FOREIGN KEY (id_responsavel) REFERENCES responsavel(id_responsavel)
);

CREATE TABLE gas (
    id_gas INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    unidade VARCHAR(20),
    limite_min DECIMAL(10,2),
    limite_max DECIMAL(10,2)
);

CREATE TABLE sensor (
    id_sensor INT AUTO_INCREMENT PRIMARY KEY,
    id_estufa INT,
    modelo VARCHAR(100),
    fabricante VARCHAR(100),
    precisao DECIMAL(5,2),
    data_instalacao DATE,
    status VARCHAR(20),
    FOREIGN KEY (id_estufa) REFERENCES estufa(id_estufa)
);

CREATE TABLE leitura (
    id_leitura INT AUTO_INCREMENT PRIMARY KEY,
    id_sensor INT,
    id_gas INT,
    valor DECIMAL(10,2),
    temperatura DECIMAL(5,2),
    umidade DECIMAL(5,2),
    data_hora DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_sensor) REFERENCES sensor(id_sensor),
    FOREIGN KEY (id_gas) REFERENCES gas(id_gas)
);

CREATE TABLE alerta (
    id_alerta INT AUTO_INCREMENT PRIMARY KEY,
    id_leitura INT,
    tipo VARCHAR(50),
    descricao TEXT,
    data_alerta DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_leitura) REFERENCES leitura(id_leitura)
);
