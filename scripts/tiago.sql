--Database: "Prograd"
DROP TABLE Realiza_CC_Re;
DROP TABLE Cursa;

 CREATE DATABASE "Prograd"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Portuguese_Brazil.1252'
       LC_CTYPE = 'Portuguese_Brazil.1252'
       CONNECTION LIMIT = -1;
 
CREATE TABLE Realiza_CC_Re(
    ID_conselho      INT NOT NULL,
    Codigo_Reuniao   CHAR (10)  NOT NULL,
    FOREIGN KEY (ID_conselho) REFERENCES Conselho_Curso (ID_conselho),
	FOREIGN KEY (Codigo_Reuniao) REFERENCES Reuniao (Codigo_Reuniao),
	CONSTRAINT Realiza_CC_Re_PK PRIMARY KEY (ID_conselho, Codigo_Reuniao) 
 );
 
 CREATE TABLE Cursa(
    RA          INT NOT NULL,
    Id_Turma    INT NOT NULL,
    Semestre    INT ,
    Media       FLOAT,
    Frenquencia FLOAT,
    Status      CHAR(1),
    FOREIGN KEY (RA) REFERENCES Estudante (RA),
	FOREIGN KEY (Id_Turma) REFERENCES Turma(Id_Turma),
	CONSTRAINT Cursa_PK PRIMARY KEY (RA,Id_Turma) 
 );


