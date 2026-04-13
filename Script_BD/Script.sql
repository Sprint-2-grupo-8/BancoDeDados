
CREATE TABLE empresa (
    idempresa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    cnpj CHAR(14) NOT NULL,
    telefone VARCHAR(20),
    emailCorporativo VARCHAR(220),
    senha VARCHAR(255)
);

CREATE TABLE Setor (
    idSetor INT PRIMARY KEY AUTO_INCREMENT,
    identificador VARCHAR(45)
);

CREATE TABLE funcionario (
    idfuncionario INT AUTO_INCREMENT,
    fkEmpresa INT,
    nome VARCHAR(45),
    cpf CHAR(11),
    fkSupervisor INT,
    email VARCHAR(220),
    senha VARCHAR(255),
    fkSetor INT,
    PRIMARY KEY (idfuncionario , fkSupervisor),
    CONSTRAINT cFkEmpresa FOREIGN KEY (fkEmpresa)
        REFERENCES empresa (idempresa),
    CONSTRAINT cFkSupervisor FOREIGN KEY (fkSupervisor)
        REFERENCES mydb.funcionario (idfuncionario),
    CONSTRAINT FkSetor FOREIGN KEY (fkSetor)
        REFERENCES mydb.Setor (idSetor)
);

CREATE TABLE estufa (
    idestufa INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    fkEmpresa INT,
    gasMinimo INT,
    gasMaximo INT,
    fkSetor INT,
    CONSTRAINT cFkEmpresa FOREIGN KEY (fkEmpresa)
        REFERENCES empresa (idempresa),
    CONSTRAINT cFkSetor FOREIGN KEY (fkSetor)
        REFERENCES Setor (idSetor)
);

CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    fabricante VARCHAR(45),
    dtInstalacao DATE,
    status VARCHAR(45),
    fkEstufa INT,
    CONSTRAINT cFkEstufa FOREIGN KEY (fkEstufa)
        REFERENCES estufa (idestufa)
);

CREATE TABLE Registro (
    idRegistro INT PRIMARY KEY AUTO_INCREMENT,
    fkSensor INT,
    gas INT,
    horario DATETIME,
    CONSTRAINT cFkSensor FOREIGN KEY (fkSensor)
        REFERENCES sensor (idSensor)
);
