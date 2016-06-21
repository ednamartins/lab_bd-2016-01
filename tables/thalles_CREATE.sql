--Database: "Prograd"
DROP TABLE Atividade;
DROP TABLE Compoe;
DROP TABLE Efetua;
DROP TABLE Matriculado;
/*
DROP TABLE Curso;
DROP TABLE Disciplina;
DROP TABLE Estudante;
DROP TABLE NucleoDocente;
DROP TABLE Reuniao;
DROP TABLE Calendario;
*/

CREATE DATABASE "Prograd"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Portuguese_Brazil.1252'
       LC_CTYPE = 'Portuguese_Brazil.1252'
       CONNECTION LIMIT = -1;

CREATE TYPE telefone AS 
(
    origem character varying(20),
    tipo character varying(20),
    ramal integer,
    ddd integer,
    fone bigint 
);

CREATE TYPE coord AS 
(
    nome character varying(40),
    telefone telefone
);

-----------------------------------------
-- Tabelas usadas para suprir dependência
-----------------------------------------
/*
-- CURSO
CREATE TABLE Curso 
(
    codigo integer constraint Curso_pk primary key,
    website character varying(40),
    nome character varying(40),
    coordenador coord 
);

-- DISCIPLINA
CREATE TABLE Disciplina 
(
    codigo character varying(10) CONSTRAINT Disciplina_PK primary key,
    sigla character varying(7),
    nro_creditos integer,
    vezes_Realizadas integer,
    categoria character varying(20) 
);

-- ESTUDANTE
CREATE TABLE Estudante 
(
    ra integer CONSTRAINT Estudante_PK  primary key,
    cpf character varying(15) NOT NULL UNIQUE,
    anoConcEM character varying(4),
    ira integer NOT NULL,
    presencial char, -- atributo descriminatório: Presencial(s) ou Distancia(n) (7.2.1 - C Elmasri)
    graduando boolean, -- Flag de reconhecimento Estudante Graduando
    posGraduando boolean -- Flag de reconhecimento Estudante Pós Graduando(7.2.1 - D Elmasri)
);

-- NUCLEO DOCENTE
CREATE TABLE NucleoDocente 
(
    codigo integer,

    CONSTRAINT Nucleo_Docente_pk PRIMARY KEY (codigo)
);


-- REUNIÃO
CREATE TABLE Reuniao 
(
    numero integer not null unique,
    pauta text,
    data_inicio date,

    CONSTRAINT Reuniao_pk PRIMARY KEY (numero)
);

CREATE TABLE Calendario 
(
    data_inicio date not null,
    data_fim date,
    dias_letivos integer not null,
    tipo char not null, -- atributo discriminatório Graduação Presencial (p), EaD (e) ou Administrativo (a)
    aprovado boolean default false,
    reuniao_numero integer,
    anterior_data date, -- data de início do calendário anterior ao referente
    anterior_tipo char, -- tipo do calendário anterior ao referente

    CONSTRAINT Calendario_Reuniao_fk FOREIGN KEY (reuniao_numero) REFERENCES Reuniao(numero)
        ON DELETE RESTRICT,
    CONSTRAINT Calendario_pk PRIMARY KEY (data_inicio, tipo)
);
*/

--------------------------------------
-- Tabelas feitas por Thalles Ferreira
--------------------------------------

-- ATIVIDADE
CREATE TABLE Atividade
(
    data_inicio date not null,
    data_fim date,
    atributo char, -- atributo descriminatório sobre tipo de atividade
    Calendario_data_inicio date not null,
    Calendario_tipo char not null default 'a',

    CONSTRAINT Atividade_Calendario_FK FOREIGN KEY (Calendario_data_inicio, Calendario_tipo) REFERENCES Calendario (data_inicio, tipo),
    CONSTRAINT Atividade_PK PRIMARY KEY (data_inicio)
);

-- Compoe (Disciplina x Curso)
CREATE TABLE Compoe
(
    Disciplina_codigo character varying(10),
    Curso_codigo integer,
    obrigatoriedade boolean,
    perfil char, -- atributo descriminatório sobre perfil

    CONSTRAINT Compoe_Disciplina_fk FOREIGN KEY (Disciplina_codigo) REFERENCES Disciplina (codigo),
    CONSTRAINT Compoe_Curso_fk FOREIGN KEY (Curso_codigo) REFERENCES Curso (codigo),
    CONSTRAINT Compoe_pk PRIMARY KEY (Disciplina_codigo, Curso_codigo)
);

-- Efetua (NucleoDocente x Reuniao)
CREATE TABLE Efetua
(
    NucleoDocente_codigo integer,
    Reuniao_numero integer,

    CONSTRAINT Efetua_NucleoDocente_fk FOREIGN KEY (NucleoDocente_codigo) REFERENCES NucleoDocente (codigo),
    CONSTRAINT Efetua_Reuniao_fk FOREIGN KEY (Reuniao_numero) REFERENCES Reuniao (numero),
    CONSTRAINT Efetua_pk PRIMARY KEY (NucleoDocente_codigo, Reuniao_numero)
);

-- Matriculado (Estudante x Curso)
CREATE TABLE Matriculado
(
    Estudante_ra integer not null,
    Curso_codigo integer not null,
    grade character varying(15), 
    periodo char, -- atributo descriminatório sobre periodo
    status boolean,
    perfil char, -- atributo descriminatório sobre perfil
    ano_ingresso date,
    ano_termino date,

    CONSTRAINT Matriculado_Estudante_fk FOREIGN KEY (Estudante_ra) REFERENCES Estudante (ra),
    CONSTRAINT Matriculado_Curso_fk FOREIGN KEY (Curso_codigo) REFERENCES Curso (codigo),
    CONSTRAINT Matriculado_pk PRIMARY KEY (Estudante_ra, Curso_codigo)
);
