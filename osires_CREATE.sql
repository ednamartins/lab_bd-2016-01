

-- Laboratorio de Banco de Dados
-- Nome: Osires Fernando Ribeiro Nhaga     RA: 574430

Drop table Docente;
Drop table TecADM;
Drop table PertenceDND;


----- CREAÇÃO DAS TABELAS

CREATE TABLE Docente
  (
    rg varchar(9) not null,
    CONSTRAINT Pessoa_Docente_FK FOREIGN KEY (rg) REFERENCES Pessoa(rg),
    CodDocente integer not null,
    CONSTRAINT Docente_PK PRIMARY KEY (rg, CodDocente)
	
  );



CREATE TABLE TecADM
  (
    rg varchar(9) not null,
    CONSTRAINT Pessoa_TecADM_FK FOREIGN KEY (rg) REFERENCES Pessoa(rg),
    CodTA integer not null, 
    CONSTRAINT TecADM_PK PRIMARY KEY (rg, CodTA)

  );


CREATE TABLE PertenceDND
  (
    rg varchar(9) not null,
    CodNDocente varchar(10) not null,
    CodDocente integer not null,
    CONSTRAINT Docente_PertenceDND_FK FOREIGN KEY (rg, CodDocente ) REFERENCES Docente(rg, CodDocente),
    CONSTRAINT Nucleo_Docente_PertenceDND_FK FOREIGN KEY (CodNDocente ) REFERENCES Nucleo_Docente(CodNDocente),    
    Data date not null, 
    CONSTRAINT PertenceDND_PK PRIMARY KEY (rg, CodDocentes, CodNDocente, Data)
	
  );



