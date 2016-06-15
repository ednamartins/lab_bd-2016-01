-- Lista os estudantes (RA) que fazem atividade complementares e ordena (EaD e Presencial)

CREATE OR REPLACE VIEW view_estudanteatividadecomp
AS
SELECT e.ra as "Estudante", r.AtComp_nome AS "Atividade", e.presencial "Presencial"
FROM Estudante AS e, RealizaACE AS r
WHERE r.Estudante_ra = e.ra
ORDER BY e.presencial;