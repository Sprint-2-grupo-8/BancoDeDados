CREATE DATABASE PI;
USE PI;

CREATE TABLE empresa (
    idempresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    cnpj CHAR(14) NOT NULL,
    telefone VARCHAR(20),
    emailCorporativo VARCHAR(220),
    senha VARCHAR(255)
);

CREATE TABLE setor (
    idSetor INT PRIMARY KEY AUTO_INCREMENT,
    identificador VARCHAR(45)
);

CREATE TABLE funcionario (
    idfuncionario INT PRIMARY KEY AUTO_INCREMENT,
    fkEmpresa INT,
    nome VARCHAR(45),
    cpf CHAR(11),
    email VARCHAR(220),
    senha VARCHAR(255),
    fkSetor INT,
    CONSTRAINT cFkEmpresa_func FOREIGN KEY (fkEmpresa)
        REFERENCES empresa (idempresa),
    CONSTRAINT cFkSetor_func FOREIGN KEY (fkSetor)
        REFERENCES setor (idSetor),
	cargo VARCHAR(45),
    CONSTRAINT ckcargo CHECK (cargo IN('Funcionario Comum', 'Administrador', 'Supervisor'))
);

CREATE TABLE estufa (
    idestufa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    gasMinimo INT,
    gasMaximo INT,
    fkEmpresa INT,
    fkSetor INT,
    CONSTRAINT cFkEmpresa_estuf FOREIGN KEY (fkEmpresa)
        REFERENCES empresa (idempresa),
    CONSTRAINT cFkSetor_estuf FOREIGN KEY (fkSetor)
        REFERENCES setor (idSetor)
);

CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    modelo VARCHAR(45),
    dtInstalacao DATE,
    sensor_status VARCHAR(45),
    fkEstufa INT,
    CONSTRAINT cFkEstufa FOREIGN KEY (fkEstufa)
        REFERENCES estufa (idestufa),
    CONSTRAINT cStatus CHECK (sensor_status IN ('Ativo' , 'Inativo'))
);

CREATE TABLE registro (
    idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    fkSensor INT,
    PPM float,
    dtHrRegistro DATETIME DEFAULT (NOW()),
    CONSTRAINT cFkSensor FOREIGN KEY (fkSensor)
        REFERENCES sensor (idSensor)
);

INSERT INTO empresa (nome, cnpj, telefone, emailCorporativo, senha) VALUES
('Red Berry Company', '45083604000187', '11975519892', 'redberrycompanyy@gmail.com', 'RB_C6ompany@fru74');

INSERT INTO setor (identificador) VALUES
('Setor 1A RBC');

INSERT INTO funcionario (fkEmpresa, nome, cpf, email, senha, fkSetor, cargo) VALUES
(1, 'Arthur Lima Azevedo', 96255467802,'arthur.lazev@redberry.com.br', 'l4am0Pr@_01', 1, 'Supervisor');

INSERT INTO estufa (nome, fkEmpresa, fkSetor, gasMinimo, gasMaximo) VALUES
('Estufa M01', 1, 1, 300, 900);

INSERT INTO sensor (modelo, dtInstalacao, sensor_status, fkEstufa) VALUES
('Arduino MQ-2 UNO', '2026-04-22', 'Ativo', 1);
