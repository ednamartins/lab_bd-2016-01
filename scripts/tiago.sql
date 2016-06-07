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

--Inserção na tabelas Realiza_CC_Re
insert into Realiza_CC_Re(ID_conselho,Codigo_Reuniao)
values (1, 'abc')

insert into Realiza_CC_Re(ID_conselho,Codigo_Reuniao)
values (2, 'abcd')

insert into Realiza_CC_Re(ID_conselho,Codigo_Reuniao)
values (3, 'abcde')

insert into Realiza_CC_Re(ID_conselho,Codigo_Reuniao)
values (4, 'abcdef')

insert into Realiza_CC_Re(ID_conselho,Codigo_Reuniao)
values (5, 'abcdefg')

--Inserção na tabelas Cursa
insert into Cursa(RA,Id_Turma,Semestre,Media,Frenquencia,Status)
values (551910,1,3,5.9,10,'P')

insert into Cursa(RA,Id_Turma,Semestre,Media,Frenquencia,Status)
values (551911,2,7,2.7,6,'A')

insert into Cursa(RA,Id_Turma,Semestre,Media,Frenquencia,Status)
values (551912,3,5,3.9,7,'A')

insert into Cursa(RA,Id_Turma,Semestre,Media,Frenquencia,Status)
values (551913,4,1,9.9,1,'P')

insert into Cursa(RA,Id_Turma,Semestre,Media,Frenquencia,Status)
values (551914,5,2,7.9,11,'P')
