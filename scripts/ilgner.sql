CREATE TABLE Enade (
	data_realizacao date not null default 'now()',
	nota numeric(2,2),
	Estudante_ra integer,
	Curso_codigo integer,

	CONSTRAINT Enade_Estudante_fk foreign key (Estudante_ra) references Estudante (ra),
	CONSTRAINT Enade_Curso_fk foreign key (Curso_codigo) references Curso (codigo),
	CONSTRAINT Enade_pk primary key (Estudante_ra, Curso_codigo, data_realizacao)
);