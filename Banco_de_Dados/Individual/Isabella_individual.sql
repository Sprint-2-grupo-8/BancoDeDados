SHOW DATABASES;
USE gascontrol_db;

CREATE TABLE sensor(
id_sensor INT PRIMARY KEY AUTO_INCREMENT,
fabricante VARCHAR(45),
modelo VARCHAR(45),
num_serie INT,
dt_fabricacao DATE,
dt_instalacao DATE
);

CREATE TABLE registro(
id_registro INT PRIMARY KEY AUTO_INCREMENT,
dt_registro DATETIME,
nivel_co2 FLOAT,
faixa_min FLOAT,
faixa_max FLOAT,
fk_sensor INT,
CONSTRAINT cFkSensor FOREIGN KEY (fk_sensor) REFERENCES sensor(id_sensor)
);

CREATE TABLE empresa(
id_empresa INT PRIMARY KEY AUTO_INCREMENT,
razao_social VARCHAR(60) UNIQUE NOT NULL,
cnpj CHAR(14) UNIQUE NOT NULL,
email VARCHAR(50),
telefone CHAR(9),
endereco VARCHAR(60)
);

CREATE TABLE usuario(
id_usuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
sobrenome VARCHAR(45),
email VARCHAR(50),
telefone CHAR(9),
senha VARCHAR(255),
fk_empresa INT,
CONSTRAINT cFkEmpresa FOREIGN KEY (fk_empresa) REFERENCES empresa(id_empresa)
);



