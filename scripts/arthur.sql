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


INSERT INTO estagia VALUES(“10/05/2016”, “10/11/2016”, 06562165849, ROW(Ronaldo, 25145885696), ROW(Ademar, 154448556225), “Carta Avaliacao”, “Termo Compromisso”);

INSERT INTO empresa VALUES(2566856, Samsung, ROW(“Rua da Pamonha”, “Sem complemento”, “Cidade Jardim”, “Jaguariúna”, “SP”, “Brasil”, 13654987));

INSERT INTO turma VALUES(0258, ‘{212, 235}’, 120);

INSERT INTO curso VALUES(0212, “www.dc.ufscar.br”, “Ciência da Computação”, ROW(“Joao Silva”, ROW(“Sala”, “Fixo”, 05, 16, 34521443)));
