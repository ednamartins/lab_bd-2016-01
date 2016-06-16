CREATE TYPE tel AS (
    Origem char(20),
    Tipo char(20),
    Ramal INTEGER,
    DDD INTEGER,
    Fone BIGINT 
);

CREATE TYPE coord AS (
    Nome char(40),
    Telefone tel 
);

CREATE TYPE end AS (
    Rua char(50),
    Complemento char(20),
    Bairro char(20),
    Cidade char(20),
    UF char(2),
    Pais char(20),
    CEP BIGINT 
);


CREATE TYPE supervisor AS (
    CPF BIGINT,
    Nome char(30)
);


CREATE TABLE Curso(
    codigo INTEGER constraint curso_pk primary key,
    website char(40),
    nome char(40),
    coordenador coord 
);

CREATE TABLE Turma(
    id INTEGER constraint turma_pk primary key,
    salas integer ARRAY,     
    vagas INTEGER
);

CREATE TABLE Empresa(
    cnpj BIGINT constraint empresa_pk primary key,
    nome INTEGER,
    endereco end
);

CREATE TABLE Estagia
    dtInicio DATE,
    dtTermino DATE,
    cpf BIGINT,
    supEmpresa supervisor,
    supUniversidade supervisor,
    cartaAvaliacao TEXT,
    termoCompromisso TEXT,
    constraint estagia_fk FOREIGN KEY references estudante cpf,
    constraint estagia_pk PRIMARY KEY cpf
);


---------------
-- Estudante --
---------------
-- Entidade do Kyioto , porem necessario devido à dependencia de tabelas

INSERT INTO Estudante VALUES(407704,'41879402866','2010','10000','s', true, false);

INSERT INTO Estudante VALUES(564898,'65423215899','1999','16000','s', false, true);

INSERT INTO Estudante VALUES(985589,'84565878502','2005','12335','n',false, true);

INSERT INTO Estudante VALUES(379409,'84565878504','2005','12335','n',false, true);

INSERT INTO Estudante VALUES(408000,'84565878503','2005','12335','n',false, true);


-------------
-- Empresa --
-------------

INSERT INTO empresa VALUES(2566856, 'Samsung', ROW('Rua da Samsung', 'Sem complemento', 'Centro', 'Jaguariúna', 'SP', 'Brasil', 13654987));

INSERT INTO empresa VALUES(2566855, 'Sony', ROW('Rua da Sony', 'Sem complemento', 'Centro', 'Campinas', 'SP', 'Brasil', 13654986));

INSERT INTO empresa VALUES(2566854, 'Panasonic', ROW('Rua da Panasonic', 'Sem complemento', 'Tijuco Preto', 'Sao Carlos', 'SP', 'Brasil', 13654985));

INSERT INTO empresa VALUES(2566853, 'Geico', ROW('Rua da Geico', 'Sem complemento', 'Ita', 'Jaguariúna', 'SP', 'Brasil', 13654984));

INSERT INTO empresa VALUES(2566852, 'Toshiba', ROW('Rua da Toshiba', 'Sem complemento', 'Centro', 'Jaguariúna', 'SP', 'Brasil', 13654983));

-------------
-- Estagia --
-------------

INSERT INTO estagia VALUES('2016-02-20', '2016-06-21', '41879402866', 2566856, ROW(25145885696, 'Ronaldo'), ROW(154448556225, 'Ademar'), 'Carta Avaliacao', 'Termo Compromisso');

INSERT INTO estagia VALUES('2016-04-28', '2016-10-09', '65423215899', 2566855, ROW(25145885697, 'Jose'), ROW(154448556225, 'Ademar'), 'Carta Avaliacao1', 'Termo Compromisso1');

INSERT INTO estagia VALUES('2016-04-10', '2015-12-13', '84565878502', 2566854, ROW(25145885695, 'Carlos'), ROW(154448556225, 'Ademar'), 'Carta Avaliacao2', 'Termo Compromisso2');

INSERT INTO estagia VALUES('2016-02-20', '2016-10-07', '84565878504', 2566853, ROW(25145885694, 'Arthur'), ROW(154448556225, 'Ademar'), 'Carta Avaliacao3', 'Termo Compromisso3');

INSERT INTO estagia VALUES('2016-02-03', '2016-12-11', '84565878503', 2566852, ROW(25145885693, 'Joaquina'), ROW(154448556225, 'Ademar'), 'Carta Avaliacao4', 'Termo Compromisso4');


-------------
--- Curso ---
-------------
INSERT INTO curso VALUES(0212, 'www.dc.ufscar.br/~bcc', 'Ciência da Computação', ROW('Indiana Jones', ROW('Sala1', 'Fixo', 05, 16, 34521452)));

INSERT INTO curso VALUES(0213, 'www2.dc.ufscar.br/~enc', 'Engenharia da Computação', ROW('He-man', ROW('Sala2', 'Fixo', 04, 16, 34521443)));

INSERT INTO curso VALUES(0214, 'www.dm.ufscar.br', 'Matematica', ROW('Aristoteles', ROW('Sala8', 'Fixo', 06, 16, 34521474)));

INSERT INTO curso VALUES(0215, 'www.dep.ufscar.br', 'Engenharia de Producao', ROW('Mario Bros', ROW('Sala', 'Fixo', 01, 16, 34521485)));

INSERT INTO curso VALUES(0216, 'www.dpsi.ufscar.br', 'Psicologia', ROW('James Bond', ROW('Sala007', 'Fixo', 02, 16, 34521007)));
