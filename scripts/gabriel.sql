DROP TABLE PertenceDD;
DROP TABLE Sala;
DROP TABLE Turma;


CREATE TABLE PertenceDD(
	sigla_departamento character varying(100),
	codigo_disciplina character varying(10),
	CONSTRAINT pertencedd_sigla_departamento foreign key (sigla_departamento) references Departamento(sigla),
	CONSTRAINT pertencedd_codigo_disciplina foreign key (codigo_disciplina) references Disciplina(Codigo),
	CONSTRAINT pertencedd_pk PRIMARY KEY (sigla_departamento,codigo_disciplina_disciplina)
 );
 
 CREATE TABLE Turma(
 	id_turma character varying(1),
 	vagas integer,
 	codigo_disciplina character varying(10),
 	codigo_docente integer,
 	CONSTRAINT turma_codigo_disciplina foreign key (codigo_disciplina) references Disciplina(Codigo),
 	CONSTRAINT turma_codigo_docente foreign key (codigo_docente) references Docente(CodDocente),
 	CONSTRAINT turma_pk primary key (codigo_disciplina, id_turma)
 );

 CREATE TABLE Sala(
 	id_turma character varying(1),
 	codigo_disciplina character varying(10),
 	sala character varying(20),
 	CONSTRAINT sala_turma_fk foreign key (id_turma, codigo_disciplina) references Turma(id_turma, codigo_disciplina),
 	CONSTRAINT sala_pk PRIMARY KEY (id_turma, codigo_disciplina, sala)
 );

INSERT INTO PertenceDD VALUES(
	'DC',--sigla_departamnto
	'08806'--cod_disciplina
);

INSERT INTO PertenceDD VALUES(
	'DC',--sigla_departamnto
	'562312'--cod_disciplina
);

INSERT INTO Turma VALUES(
	'A',--id_turma
	30,--vagas
	'08806',--cod_disciplina
	5286001623--cod_docente
);

INSERT INTO Turma VALUES(
	'B',--id_turma
	25,--vagas
	'08806',--cod_disciplina
	5286001623--cod_docente
);

INSERT INTO Turma VALUES(
	'A',--id_turma
	60,--vagas
	'562312',--cod_disciplina
	0058962587--cod_docente
);

INSERT INTO Sala VALUES(
	'A',--id_turma
	'08806',--cod_disciplina
	'AT9-129'--sala
);

INSERT INTO Sala VALUES(
	'B',--id_turma
	'08806',--cod_disciplina
	'AT5-100'--sala
);

INSERT INTO Sala VALUES(
	'A',--id_turma
	'562312',--cod_disciplina
	'AT9-131'--sala
);
