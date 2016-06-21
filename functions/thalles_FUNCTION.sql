create or replace function nroCreditosAprovados (ra_estudante in integer, status_materia in char)
return number
is
		nroCreditos number;
		CURSOR c1 IS
		SELECT 	SUM(nro_creditos)
		FROM	Disciplina, Estudante, Turma, Cursa
		WHERE 	Estudante.ra = ra_estudante
		AND		Cursa.Estudante_ra = ra_esturante
		AND		Cursa.status = status_materia
		AND		Cursa.Turma_id = Turma.id
		AND		Turma.Disciplina_codigo = Disciplina.codigo;

begin
	OPEN c1;
	FETCH c1 INTO nroCreditos;
return nroCreditos;
end nroCreditosAprovados;


/*  Tabelas ligadas

-- DISCIPLINA
CREATE TABLE Disciplina 
(
	codigo character varying(10) CONSTRAINT Disciplina_PK primary key,
	nro_creditos integer,
);

-- ESTUDANTE
CREATE TABLE Estudante 
(
	ra integer CONSTRAINT Estudante_PK  primary key,
);

-- TURMA
CREATE TABLE Turma 
(
 	id char not null unique,
 	Disciplina_codigo character varying(10),

 	CONSTRAINT Turma_Disciplina_fk foreign key (Disciplina_codigo) references Disciplina (codigo),
 	CONSTRAINT Turma_Docente_fk foreign key (Docente_codigo) references Docente (codigo),
 	CONSTRAINT Turma_pk primary key (Disciplina_codigo, id, ano, semestre)
);

-- Cursa (Estudante x Turma)
CREATE TABLE Cursa
(
	Estudante_ra integer not null,
	Turma_id char not null,
	status char, -- "c" cancelado, "t" trancado, "r" reprovado, "a" aprovado

	CONSTRAINT Cursa_Estudante_fk FOREIGN KEY (Estudante_ra) REFERENCES Estudante (ra),
	CONSTRAINT Cursa_Turma_fk FOREIGN KEY (Turma_id) REFERENCES Turma (id),
	CONSTRAINT Cursa_PK PRIMARY KEY (Estudante_ra,Turma_id) 
);

*/
