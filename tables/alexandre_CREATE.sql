DROP TABLE ProjetoPoliticoPedagogico;

CREATE TYPE gradecurricular AS (
	Optativa BOOLEAN,
	Obrigatoria BOOLEAN,
	Eletiva BOOLEAN
);

CREATE TABLE ProjetoPoliticoPedagogico(
	grade gradecurricular
	FOREIGN KEY (Codigo_curso) REFERENCES Curso(Codigo_curso)
);
