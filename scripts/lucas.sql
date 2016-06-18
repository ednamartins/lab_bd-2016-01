DROP TABLE DisciplinaPreReq;

CREATE TABLE DisciplinaPreReq(
	Codigo CHAR not null(10),
	Sigla CHAR(10),
	Nro_creditos INTEGER,
	Categoria CHAR(20),
	CodigoPreRequisito CHAR (10),
	CONSTRAINT Disciplina_PK primary key (Codigo),
	CONSTRAINT Disciplina_FK foreing key (CodigoPreRequisito) references Disciplina
);

INSERT INTO DisciplinaPreReq VALUES(
	'08801',
	'Calculo 1', 
	4,
	'Obrigatoria'
);

INSERT INTO DisciplinaPreReq VALUES(
	'08802',
	'Calculo 2', 
	4,
	'Obrigatoria',
	'08801'
);

INSERT INTO DisciplinaPreReq VALUES(
	'08803',
	'Calculo 3', 
	4,
	'Obrigatoria',
	'08802'
);

INSERT INTO DisciplinaPreReq VALUES(
	'08804',
	'Calculo 4', 
	4,
	'Obrigatoria',
	'08803'
);


