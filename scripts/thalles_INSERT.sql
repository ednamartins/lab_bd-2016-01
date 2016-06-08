-- População das Tabelas

--------------------------------------------------
--------------------------------------------------
-- População das Tabelas auxiliares (dependência)
--------------------------------------------------
--------------------------------------------------

-- Curso
INSERT INTO Curso VALUES(
    10, -- código Curso
    'www.bcc.dc.ufscar.br', -- website
    'Ciência da Computação', -- nome
    ('Joao', ('Sao Carlos', 'Celular', 11, 16, 991234567)) -- coordenador (telefone)
);

INSERT INTO Curso VALUES(
    2, -- código Curso
    'www.enc.dc.ufscar.br', -- website
    'Engenharia de Computação', -- nome
    ('Jose', ('Sao Carlos', 'Celular', 13, 16, 1567865456)) -- coordenador (telefone)
);

INSERT INTO Curso VALUES(
    4, -- código Curso
    'www.ep.dep.ufscar.br', -- website
    'Engenharia de Produção', -- nome
    ('Valdivia', ('Sao Carlos', 'Celular', 11, 16, 6668888999)) -- coordenador (telefone)
);

INSERT INTO Curso VALUES(
    1, -- código Curso
    'www.ec.dec.ufscar.br', -- website
    'Engenharia Civil', -- nome
    ('Joao', ('Sao Carlos', 'Celular', 11, 16, 1122334455)) -- coordenador (telefone)
);

INSERT INTO Curso VALUES(
    10, -- código Curso
    'www.gastro.comida.ufscar.br', -- website
    'Gastronomia', -- nome
    ('Fogaça', ('Sao Carlos', 'Celular', 11, 16, 123121233)) -- coordenador (telefone)
);
------------------------------------------------------------------------------------------------

-- Disciplina
INSERT INTO Disciplina VALUES(
    '1010', -- codigo
    'CAP', -- sigla
    8, -- nro de creditos
    1, -- vezes realizada
    'a' -- categoria
);

INSERT INTO Disciplina VALUES(
    '2020', -- codigo
    'CC1', -- sigla
    4, -- nro de creditos
    1, -- vezes realizada
    'a' -- categoria
);
INSERT INTO Disciplina VALUES(
    '3030', -- codigo
    'SO1', -- sigla
    4, -- nro de creditos
    1, -- vezes realizada
    'a' -- categoria
);
INSERT INTO Disciplina VALUES(
    '4040', -- codigo
    'ES2', -- sigla
    4, -- nro de creditos
    1, -- vezes realizada
    'a' -- categoria
);
INSERT INTO Disciplina VALUES(
    '5050', -- codigo
    'ADM', -- sigla
    4, -- nro de creditos
    1, -- vezes realizada
    'b' -- categoria
);
------------------------------------------------------------------------------------------------

-- Estudante
INSERT INTO Estudante VALUES(
    555555, -- ra
    '12345678900', -- cpf
    '2016', -- ano de conclusao
    15000, -- ira
    'p', -- presencial
    true, -- graduando
    false -- pos graduando
);

INSERT INTO Estudante VALUES(
    444444, -- ra
    '45678909938', -- cpf
    '2015', -- ano de conclusao
    11000, -- ira
    'p', -- presencial
    true, -- graduando
    false -- pos graduando
);

INSERT INTO Estudante VALUES(
    653243, -- ra
    '62547613783', -- cpf
    '2018', -- ano de conclusao
    13000, -- ira
    'p', -- presencial
    false, -- graduando
    false -- pos graduando
);

INSERT INTO Estudante VALUES(
    615273, -- ra
    '12345678900', -- cpf
    '2018', -- ano de conclusao
    15400, -- ira
    'p', -- presencial
    false, -- graduando
    false -- pos graduando
);

INSERT INTO Estudante VALUES(
    557218, -- ra
    '76283761111', -- cpf
    '2016', -- ano de conclusao
    15000, -- ira
    'p', -- presencial
    false, -- graduando
    false -- pos graduando
);
------------------------------------------------------------------------------------------------

-- Núcleo Docente
INSERT INTO NucleoDocente VALUES(
    1914
);

INSERT INTO NucleoDocente VALUES(
    1414
);

INSERT INTO NucleoDocente VALUES(
    5511
);

INSERT INTO NucleoDocente VALUES(
    2020
);

INSERT INTO NucleoDocente VALUES(
    0809
);
------------------------------------------------------------------------------------------------

-- Reunião
INSERT INTO Reuniao VALUES(
    1, -- codigo/numero
    'reuniao 1', -- pauta
    '2014-01-20' -- data inicio reuniao
);

INSERT INTO Reuniao VALUES(
    2, -- codigo/numero
    'reuniao 2', -- pauta
    '2014-02-20' -- data inicio reuniao
);

INSERT INTO Reuniao VALUES(
    3, -- codigo/numero
    'reuniao 3', -- pauta
    '2014-03-20' -- data inicio reuniao
);

INSERT INTO Reuniao VALUES(
    4, -- codigo/numero
    'reuniao 4', -- pauta
    '2014-04-20' -- data inicio reuniao
);

INSERT INTO Reuniao VALUES(
    5, -- codigo/numero
    'reuniao 5', -- pauta
    '2014-05-20' -- data inicio reuniao
);
------------------------------------------------------------------------------------------------

----------------------------------------------------
----------------------------------------------------
-- População das Tabelas feitas por Thalles Ferreira
----------------------------------------------------
----------------------------------------------------

-- Atividade
INSERT INTO Atividade VALUES(
    '2014-01-20', -- data inicio
    '2014-01-22', -- data fim
    'c', -- tipo de atividade
    '2014-01-20', -- data inicio Calendario
    'a' -- tipo Calendario
);

INSERT INTO Atividade VALUES(
    '2014-03-01', -- data inicio
    '2014-01-3', -- data fim
    'c', -- tipo de atividade
    '2014-01-20', -- data inicio Calendario
    'a' -- tipo Calendario
);

INSERT INTO Atividade VALUES(
    '2014-04-10', -- data inicio
    '2014-01-11', -- data fim
    'c', -- tipo de atividade
    '2014-01-20', -- data inicio Calendario
    'a' -- tipo Calendario
);

INSERT INTO Atividade VALUES(
    '2014-01-20', -- data inicio
    '2014-01-22', -- data fim
    'd', -- tipo de atividade
    '2014-01-20', -- data inicio Calendario
    'b' -- tipo Calendario
);

INSERT INTO Atividade VALUES(
    '2014-01-20', -- data inicio
    '2014-01-21', -- data fim
    'd', -- tipo de atividade
    '2014-01-20', -- data inicio Calendario
    'a' -- tipo Calendario
);
------------------------------------------------------------------------------------------------

-- Compoe
INSERT INTO Compoe VALUES(
    1010, -- disciplina codigo
    10, -- curso codigo
    true, -- obrigatoriedade
    '1' -- perfil
);

INSERT INTO Compoe VALUES(
    1010, -- disciplina codigo
    2, -- curso codigo
    true, -- obrigatoriedade
    '1' -- perfil
);

INSERT INTO Compoe VALUES(
    5050, -- disciplina codigo
    10, -- curso codigo
    true, -- obrigatoriedade
    '6' -- perfil
);

INSERT INTO Compoe VALUES(
    5050, -- disciplina codigo
    2, -- curso codigo
    true, -- obrigatoriedade
    '7' -- perfil
);

INSERT INTO Compoe VALUES(
    3030, -- disciplina codigo
    10, -- curso codigo
    true, -- obrigatoriedade
    '6' -- perfil
);
------------------------------------------------------------------------------------------------

-- Efetua
INSERT INTO Efetua VALUES(
    1914, -- codigo nucleo docente
    1 -- codigo reuniao
);

INSERT INTO Efetua VALUES(
    1914, -- codigo nucleo docente
    2 -- codigo reuniao
);

INSERT INTO Efetua VALUES(
    2020, -- codigo nucleo docente
    3 -- codigo reuniao
);

INSERT INTO Efetua VALUES(
    2020, -- codigo nucleo docente
    4 -- codigo reuniao
);

INSERT INTO Efetua VALUES(
    2020, -- codigo nucleo docente
    5 -- codigo reuniao
);
------------------------------------------------------------------------------------------------

-- Matriculado
INSERT INTO Matriculado VALUES(
    555555, -- estudante ra
    10, -- curso codigo
    'grade 1', -- grade curricular
    '6', -- periodo
    true, -- status
    '6', -- perfil
    '2013-03-01', -- ano inicio
    '2016-12-01' -- ano termino
);

INSERT INTO Matriculado VALUES(
    444444, -- estudante ra
    10, -- curso codigo
    'grade 1', -- grade curricular
    '8', -- periodo
    true, -- status
    '6', -- perfil
    '2012-03-01', -- ano inicio
    '2015-12-01' -- ano termino
);

INSERT INTO Matriculado VALUES(
    653243, -- estudante ra
    2, -- curso codigo
    'grade 1', -- grade curricular
    '2', -- periodo
    true, -- status
    '2', -- perfil
    '2016-03-01', -- ano inicio
    '2020-12-01' -- ano termino
);

INSERT INTO Matriculado VALUES(
    615273, -- estudante ra
    2, -- curso codigo
    'grade 1', -- grade curricular
    '2', -- periodo
    true, -- status
    '2', -- perfil
    '2016-03-01', -- ano inicio
    '2020-12-01' -- ano termino
);

INSERT INTO Matriculado VALUES(
    557218, -- estudante ra
    10, -- curso codigo
    'grade 1', -- grade curricular
    '6', -- periodo
    true, -- status
    '6', -- perfil
    '2013-03-01', -- ano inicio
    '2016-12-01' -- ano termino
);