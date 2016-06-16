-- Mostra os nomes das empresas nas quais existem alunos estagiando

CREATE OR REPLACE VIEW view_empresasAlunosEstagiam
AS
SELECT nome as "Empresa"
FROM Empresa, Estudante, Estagia
WHERE Empresa.cnpj = Estagia.empresa_cnpj 
AND Estudante.cpf = Estagia.estudante_cpf;
