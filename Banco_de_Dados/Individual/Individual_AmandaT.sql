CREATE DATABASE individual_gasControl;
USE individual_gasControl;

CREATE TABLE empresa(
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome_empresa VARCHAR(45),
email_corporativo VARCHAR(60),
telefone CHAR(11),
senha VARCHAR(60) 
);

CREATE TABLE Permissaocargo(
idCargo INT PRIMARY KEY AUTO_INCREMENT,
Cargo VARCHAR(45)
);

CREATE TABLE estufas(
idEstufa INT PRIMARY KEY AUTO_INCREMENT,
Gasppm INT
);

CREATE TABLE funcionario(
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50),
cpf CHAR(11) NOT NULL UNIQUE,
fkEmpresa INT,
fkCargo INT,
fkEstufa INT,
CONSTRAINT cFkEmpresa FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
CONSTRAINT cFkEstufa FOREIGN KEY (fkEstufa) REFERENCES estufas(idEstufa),
CONSTRAINT cfkCargo FOREIGN KEY (fkCargo) REFERENCES cargo(idCargo)
);