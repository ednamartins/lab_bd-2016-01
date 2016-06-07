--Database: "Prograd"
DROP TABLE Atividade
DROP TABLE Compoe
DROP TABLE Efetua
DROP TABLE Matriculado

CREATE DATABASE "Prograd"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Portuguese_Brazil.1252'
       LC_CTYPE = 'Portuguese_Brazil.1252'
       CONNECTION LIMIT = -1;


 CREATE TABLE Atividade(
 	Data_Inicio date CONSTRAINT atividade_PK PRIMARY KEY,
 	Data_Fim date,
 	Atributo CHAR(1) -- atributo descriminatório sobre tipo de atividade
 );

CREATE TABLE Compoe(
	Codigo_Disciplina CHAR(10),
	Codigo_Curso CHAR(10),
	Obrigatoriedade BOOLEAN,
	Perfil CHAR(1), -- atributo descriminatório sobre perfil
	FOREIGN KEY (Codigo_Disciplina) REFERENCES Disciplina (Codigo),
	FOREIGN KEY (Codigo_Curso) REFERENCES Curso (Codigo_Curso),
	CONSTRAINT compoe_PK PRIMARY KEY (Codigo_Disciplina, Codigo_Curso)
);

CREATE TABLE Efetua(
	Codigo_NDocente CHAR(10),
	Codigo_Reuniao CHAR(10),
	FOREIGN KEY (Codigo_NDocente) REFERENCES Nucleo_Docente (Codigo_NDocente),
	FOREIGN KEY (Codigo_Reuniao) REFERENCES Reuniao (Codigo_Reuniao),
	CONSTRAINT efetua_PK PRIMARY KEY (Codigo_NDocente, Codigo_Reuniao)
);

CREATE TABLE Matriculado(
	RA INT,
	Codigo_Curso CHAR(10),
	Grade CHAR(15), 
	Periodo CHAR(1), -- atributo descriminatório sobre periodo
	Status BOOLEAN,
	Perfil CHAR(1), -- atributo descriminatório sobre perfil
	Ano_Ingresso date,
	Ano_Termino date,
	FOREIGN KEY (RA) REFERENCES Estudante (RA),
	FOREIGN KEY (Codigo_Curso) REFERENCES Curso (Codigo_Curso),
	CONSTRAINT matriculado_PK PRIMARY KEY (RA, Codigo_Curso)
);

INSERT INTO Atividade VALUES(
	2016-01-01,
	2016-01-03,
	'1'
);

INSERT INTO Atividade VALUES(
	2016-05-25,
	2016-01-26,
	'2'
);

INSERT INTO Atividade VALUES(
	2016-10-10,
	2016-01-12,
	'1'
);

INSERT INTO Compoe VALUES(
	-- Codigo_Disciplina,
	-- Codigo_Curso,
	true,
	'3'
);

INSERT INTO Compoe VALUES(
	-- Codigo_Disciplina,
	-- Codigo_Curso,
	false,
	'8'
);

INSERT INTO Compoe VALUES(
	-- Codigo_Disciplina,
	-- Codigo_Curso,
	false,
	'2'
);

INSERT INTO Efetua VALUES(
	-- Codigo_NDocente,
	-- Codigo_Reuniao,
);

INSERT INTO Efetua VALUES(
	-- Codigo_NDocente,
	-- Codigo_Reuniao,
);

INSERT INTO Efetua VALUES(
	-- Codigo_NDocente,
	-- Codigo_Reuniao,
);

INSERT INTO Matriculado VALUES(
	-- RA,
	-- Codigo_Curso,
	'grade1',
	'5',
	true,
	'4',
	2016-01-01,
	2021-01-01
);

INSERT INTO Matriculado VALUES(
	-- RA,
	-- Codigo_Curso,
	'grade2',
	'4',
	false,
	'5',
	2013-01-01,
	2017-01-01
);

INSERT INTO Matriculado VALUES(
	-- RA,
	-- Codigo_Curso,
	'grade3',
	'6',
	true,
	'6',
	2012-01-01,
	2016-01-01
);
