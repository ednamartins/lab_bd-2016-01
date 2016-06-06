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

INSERT INTO ProjetoPoliticoPedagogico VALUES(
	ROW("true", "false", "false")
);

INSERT INTO ProjetoPoliticoPedagogico VALUES(
	ROW("false", "true", "false")
);

INSERT INTO ProjetoPoliticoPedagogico VALUES(
	ROW("false", "false", "true")
);