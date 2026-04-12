CREATE DATABASE PI;
USE PI;

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    nome_empresa VARCHAR(45),
    email_corporativo VARCHAR(60),
    telefone CHAR(11),
    cnpj CHAR(14) NOT NULL UNIQUE
);

CREATE TABLE estufa (
    idEstufa INT PRIMARY KEY AUTO_INCREMENT,
    cidadeEstufa VARCHAR(45),
    estadoEstufa CHAR(2),
    fkEmpresa INT,
    CONSTRAINT cFkEmpresaEstufa FOREIGN KEY (fkEmpresa)
        REFERENCES empresa (idEmpresa)
);

CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    modeloSensor VARCHAR(35) DEFAULT 'Sensor de Gás MQ-2',
    statusSensor VARCHAR(9) DEFAULT 'Ativo',
    fkEstufa INT,
    dtInstalacao DATE,
    CONSTRAINT cFkEstufaSensor FOREIGN KEY (fkEstufa)
        REFERENCES estufa (idEstufa)
);


CREATE TABLE funcionario (
    idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50),
    email VARCHAR(80),
    telefone CHAR(11),
    senha VARCHAR(60) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    cargo VARCHAR(30),
    fkEmpresa INT,
    fkEstufa INT,
    CONSTRAINT cFkEmpresa FOREIGN KEY (fkEmpresa)
        REFERENCES empresa (idEmpresa),
    CONSTRAINT cFkEstufa FOREIGN KEY (fkEstufa)
        REFERENCES estufas (idEstufa)
);

CREATE TABLE leituraGas (
    idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    fkSensor INT,
    PPM INT,
    dtHrLeitura DATETIME DEFAULT CURRENT_TIMESTAMP,
    fkEstufa INT,
    CONSTRAINT cFkSensor FOREIGN KEY (fkSensor)
        REFERENCES sensor (idSensor),
    CONSTRAINT cFkEstufaLeitura FOREIGN KEY (fkEstufa)
        REFERENCES estufa (idEstufa)
);