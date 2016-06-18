DROP TABLE DisciplinaPreReq;
DROP TABLE Disciplina;

CREATE TABLE Disciplina 
(
	codigo character varying(10) CONSTRAINT Disciplina_PK primary key,
	nome character varying(50),
	nro_creditos integer,
	vezes_Realizadas integer,
	categoria character varying(20)	
);

CREATE TABLE DisciplinaPreReq
(
	Disciplina_codigo character varying(10) not null,
	codigoPreRequisito character varying (10) not null,

	CONSTRAINT Disciplina_FK foreign key (Disciplina_codigo) references Disciplina (codigo),
	CONSTRAINT PreReq_FK foreign key (codigoPreRequisito) references Disciplina(codigo),
	CONSTRAINT DisciplinaPreReq_pk primary key (Disciplina_codigo, codigoPreRequisito)
);

INSERT INTO Disciplina VALUES(
	'08806',
	'Calculo 1',
	4,
	0,
	'Obrigatoria'
	
);

INSERT INTO Disciplina VALUES(
	'08807',
	'Calculo 2',
	4,
	0,
	--Vezes_Realizadas INT,
	--DataHorario DateTime, --(Não é atributo de turma?)
	'Obrigatoria'
	
);

INSERT INTO Disciplina VALUES(
	'08808',
	'Calculo 3',
	4,
	0,
	'Obrigatoria'
	
);

INSERT INTO Disciplina VALUES(
	'08809',
	'Calculo 4',
	4,
	0,
	'Obrigatoria'
	
);

INSERT INTO Disciplina VALUES(
	'08810',
	'Calculo Numerico',
	4,
	0,
	'Obrigatoria'
	
);

INSERT INTO Disciplina VALUES(
	'562311',
	'BD',
	2,
	0,
	'Obrigatoria'
	
);

INSERT INTO Disciplina VALUES(
	'562312',
	'LabBD',
	2,
	0,
	'Obrigatoria'
	
);

INSERT INTO DisciplinaPreReq VALUES(
	'08807',
	'08806'
);

INSERT INTO DisciplinaPreReq VALUES(
	'08808',
	'08807'
);

INSERT INTO DisciplinaPreReq VALUES(
	'08809',
	'08808'
);

INSERT INTO DisciplinaPreReq VALUES(
	'08810',
	'08806'
);

INSERT INTO DisciplinaPreReq VALUES(
	'562312',
	'562311'
);
