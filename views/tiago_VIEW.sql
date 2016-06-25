CREATE VIEW mostraInfoEstudante as

SELECT 	ra, nro_creditos, status
FROM 	Estudante, Cursa, Turma, Disciplina
WHERE	Estudante.ra = Cursa.Estudante_ra AND
	Cursa.Turma_id = Turma.id AND
	Turma.Disciplina_codigo = Disciplina.codigo
ORDER BY Disciplina.codigo;


