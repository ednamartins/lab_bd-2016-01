CREATE TABLE ReconhecimentoDeCurso 
(
	codigo character varying(10) not null,

	CONSTRAINT ReconhecimentoDeCurso_pk PRIMARY KEY (codigo)
);

CREATE TABLE Visita 
(
	periodo date not null,
	comite_avaliador character varying(400),
	itens character varying(400),
	ReconhecimentoDeCurso_codigo character varying(10),

	CONSTRAINT Visita_ReconhecimentoDeCurso_fk FOREIGN KEY (ReconhecimentoDeCurso_codigo) REFERENCES ReconhecimentoDeCurso (codigo),
	CONSTRAINT Visita_pk PRIMARY KEY (periodo, ReconhecimentoDeCurso_codigo)
);

CREATE TABLE Fase 
(
	id character varying(10) not null,
	documentos character varying(400),
	periodo date,
	ReconhecimentoDeCurso_codigo character varying(10), 

	CONSTRAINT Fase_ReconhecimentoDeCurso_fk FOREIGN KEY (ReconhecimentoDeCurso_codigo) REFERENCES ReconhecimentoDeCurso (codigo),
	CONSTRAINT Fase_pk PRIMARY KEY (id)
);

INSERT INTO reconhecimento_de_curso VALUES('EC20152312');
INSERT INTO reconhecimento_de_curso VALUES('EM20112334');
INSERT INTO reconhecimento_de_curso VALUES('CC20160001');

INSERT INTO visita VALUES('2016-10-13','EM20112334','COMITe1','item');

INSERT INTO fase VALUES('DOC...', '2012-01-01','EM1F12012A', 'CC20160001');