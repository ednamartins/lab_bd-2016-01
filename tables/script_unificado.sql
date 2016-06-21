DROP TABLE ProjetoPoliticoPedagogico;
DROP TABLE PertenceDND;
DROP TABLE TecADM;
DROP TABLE Docente;
DROP TABLE Fase;
DROP TABLE Visita;
DROP TABLE Reconhecimento_De_Curso;
DROP TABLE Enade;
DROP TABLE Pessoa_Contato;
DROP TABLE Pessoa_Endereco;
DROP TABLE Pessoa;
DROP TABLE Inscreve;
DROP TABLE PossuiRCF;
DROP TABLE PossuiCCND;
DROP TABLE Cursa;
DROP TABLE Realiza_CC_Re;
DROP TABLE Matriculado;
DROP TABLE Efetua;
DROP TABLE Compoe;
DROP TABLE Atividade;
DROP TABLE DisciplinaPreReq;
DROP TABLE Disciplina;
DROP TABLE TelefonePolo;
DROP TABLE FotoPolo;
DROP TABLE PoloDistancia;
DROP TABLE Estudante;
DROP TABLE Estagia;
DROP TABLE Empresa;
DROP TABLE Curso;
DROP TABLE Sala;
DROP TABLE Turma;
DROP TABLE PertenceDD;
DROP TABLE RealizaACE;
DROP TABLE AtComp;
DROP TABLE Departamento;
DROP TABLE Centro;
DROP TABLE Campus;
DROP TABLE Evento;
DROP TABLE Calendario;
DROP TABLE Reuniao;

---------------
---- PEDRO ---- OK
---------------

-- reunião
CREATE TABLE Reuniao (
	numero integer not null unique,
	pauta text,
	data_inicio date,

	CONSTRAINT Reuniao_pk PRIMARY KEY (numero)
);

-- calendários
CREATE TABLE Calendario (
	data_inicio date not null,
	data_fim date,
	dias_letivos integer not null,
	tipo character varying(1) not null, -- atributo discriminatório Graduação Presencial (p), EaD (e) ou Administrativo (a)
	aprovado boolean default false,
	reuniao_numero integer,
	anterior_data date,	-- data de início do calendário anterior ao referente
	anterior_tipo character varying (1), -- tipo do calendário anterior ao referente

	CONSTRAINT Calendario_Reuniao_fk FOREIGN KEY (reuniao_numero) REFERENCES Reuniao(numero)
		ON DELETE RESTRICT,
	CONSTRAINT Calendario_pk PRIMARY KEY (data_inicio, tipo)
);

-- eventos -> dependem de calendário
CREATE TABLE Evento (
	id_evento serial not null unique,
	data_inicio date not null,
	data_fim date,
	descricao text,
	calendario_data date not null, -- data de início do calendario ao qual o evento pertence
	calendario_tipo character varying(1), -- tipo do calendario ao qual o eento pertence

	CONSTRAINT Evento_Calendario_fk FOREIGN KEY (calendario_data, calendario_tipo) REFERENCES Calendario(data_inicio, tipo)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT Evento_pk PRIMARY KEY (calendario_data, calendario_tipo, id_evento)
);

-- define o auto-relacionamento entre Calendário "anterior" e Calendário "posterior"
ALTER TABLE Calendario ADD FOREIGN KEY (anterior_data, anterior_tipo) REFERENCES Calendario(data_inicio, tipo);

-- trigger para calcular data_fim
CREATE FUNCTION calcula_data_fim_proc() RETURNS trigger AS '
BEGIN 
	NEW.data_fim = NEW.data_inicio + INTERVAL ''1'' DAY * NEW.dias_letivos;
	RETURN NEW;
END;
' LANGUAGE plpgsql;

CREATE TRIGGER calcula_data_fim_trigger BEFORE INSERT OR UPDATE
	ON Calendario FOR EACH ROW
	EXECUTE PROCEDURE calcula_data_fim_proc ();

--------------------
---- JÉSSICA D. ---- OK
--------------------

CREATE TABLE Campus
(
  nome character varying(50),
  website character varying(100),
  sigla character varying(10) NOT NULL,
  telefone1 character varying(20) NOT NULL,
  telefone2 character varying(20),
  endereco character varying(100) NOT NULL,

  CONSTRAINT Campus_pk PRIMARY KEY (sigla)
);

CREATE TABLE Centro
(
  nome character varying(50),
  website character varying(100),
  geo character varying(50),
  sigla character varying(10) NOT NULL,
  telefone1 character varying(20) NOT NULL,
  telefone2 character varying(20),

  CONSTRAINT Centro_pk PRIMARY KEY (sigla)
);

CREATE TABLE Departamento
(
  nome character varying(50),
  website character varying(100),
  sigla character varying(10) NOT NULL,
  telefone1 character varying(20) NOT NULL,
  telefone2 character varying(20),
  endereco character varying (100) NOT NULL,
  Campus_sigla character varying(10),

  CONSTRAINT Departamento_pk PRIMARY KEY (sigla),
  CONSTRAINT Departamento_Campus_fk FOREIGN KEY (Campus_sigla) REFERENCES Campus (sigla)
);

-- Atividade complementar
CREATE TABLE AtComp
(
  creditos integer,
  nome character varying(100) NOT NULL,

  CONSTRAINT AtComp_pk PRIMARY KEY (nome)
);

-- Relacionamento Realiza (Atividade_Complementar x Estudante)
CREATE TABLE RealizaACE
(
  RA_estudante integer,
  nome_At character varying(100),
 
  CONSTRAINT RealizaACE_pk PRIMARY KEY (RA_estudante, nome_At),
  CONSTRAINT RealizaACE_Estudante_fk FOREIGN KEY (RA_estudante) REFERENCES Estudante (RA),
  CONSTRAINT RealizaACE_AtComp_fk FOREIGN KEY (nome_At) REFERENCES AtComp (nome)
);

-----------------
---- GABRIEL ----
-----------------

CREATE TABLE PertenceDD (
	sigla_departamento character varying(100),
	codigo_disciplina character varying(10),

	CONSTRAINT PertenceDD_Departamento_fk foreign key (sigla_departamento) references Departamento (sigla),
	CONSTRAINT PertenceDD_Disciplina_fk foreign key (codigo_disciplina) references Disciplina (codigo),
	CONSTRAINT PertenceDD_pk PRIMARY KEY (sigla_departamento, codigo_disciplina)
 );
 
 CREATE TABLE Turma (
 	id_turma character varying(1),
 	vagas integer,
 	codigo_disciplina character varying(10),
 	codigo_docente integer,

 	CONSTRAINT turma_codigo_disciplina foreign key (codigo_disciplina) references Disciplina (Codigo),
 	CONSTRAINT turma_codigo_docente foreign key (codigo_docente) references Docente (RG),
 	CONSTRAINT turma_pk primary key (codigo_disciplina, id_turma)
 );

 CREATE TABLE Sala (
 	id_turma character varying(1),
 	codigo_disciplina character varying(10),
 	sala character varying(20),

 	CONSTRAINT sala_turma_fk foreign key (id_turma, codigo_disciplina) references Turma (id_turma, codigo_disciplina),
 	CONSTRAINT sala_pk PRIMARY KEY (id_turma, codigo_disciplina, sala)
 );

----------------
---- ARTHUR ----	OK
----------------

CREATE TYPE tel AS (
    Origem character varying(20),
    Tipo character varying(20),
    Ramal integer,
    DDD integer,
    Fone bigint 
);

CREATE TYPE coord AS (
    Nome character varying(40),
    Telefone tel 
);

CREATE TYPE endereco AS (
    Rua character varying(50),
    Complemento character varying(20),
    Bairro character varying(20),
    Cidade character varying(20),
    UF character varying(2),
    Pais character varying(20),
    CEP bigint 
);


CREATE TYPE supervisor AS (
    CPF bigint,
    Nome character varying(30)
);


CREATE TABLE Curso (
    codigo integer constraint Curso_pk primary key,
    website character varying(40),
    nome character varying(40),
    coordenador coord 
);

CREATE TABLE Empresa (
    cnpj bigint constraint Empresa_pk primary key,
    nome integer,
    endereco endereco
);

CREATE TABLE Estagia (
    dtInicio date,
    dtTermino date,
    estudante_cpf character varying(15),
    supEmpresa supervisor,
    supUniversidade supervisor,
    cartaAvaliacao text,
    termoCompromisso text,
    constraint Estagia_Estudante_fk FOREIGN KEY (estudante_cpf) references Estudante (CPF),
    constraint Estagia_pk PRIMARY KEY (estudante_cpf)
);

----------------
---- RAFAEL ----	OK
----------------

CREATE TABLE Estudante (
	RA integer CONSTRAINT Estudante_PK  primary key,
	CPF character varying(15) NOT NULL UNIQUE,
	AnoConcEM character varying(4),
	IRA integer NOT NULL,
	Presencial character varying(1), -- atributo descriminatório: Presencial(s) ou Distancia(n) (7.2.1 - C Elmasri)
	Graduando boolean, -- Flag de reconhecimento Estudante Graduando
	PosGraduando boolean -- Flag de reconhecimento Estudante Pós Graduando(7.2.1 - D Elmasri)
);

CREATE TABLE PoloDistancia(
	Nome character varying(12) CONSTRAINT PoloDistancia_PK primary key,
	RA_estudante integer,
	CEP character varying(10),
	Rua character varying(40),
	Complemento character varying(20),
	Bairro character varying(20),
	Cidade character varying(20),
	UF character varying(2),
	Pais character varying(10),
	PontoGeoreferenciado character varying(50),
	Coordenador_PreNome character varying(12),
	Coordenador_SobreNome character varying (20),
	Coordenador_email1 character varying(20),
	Coordenador_email2 character varying(20),
	Coordenador_telefone1 character varying(20),
	Coordenador_telefone2 character varying(20),
	Tutor_PreNome character varying(12),
	Tutor_SobreNome character varying(20),
	Tutor_email1 character varying(20),
	Tutor_email2 character varying(20),
	Tutor_telefone1 character varying(20),
	Tutor_telefone2 character varying(20),
	CONSTRAINT PoloDistancia_Estudante_fk foreign key (RA_estudante) references Estudante (RA)
 );
 
CREATE TABLE FotoPolo (
	Num_foto integer CONSTRAINT FotoPolo_PK primary key,
	Nome character varying(12),
	Imagem character varying(20),
	CONSTRAINT FotoPolo_PoloDistancia_FK foreign key (Nome) references PoloDistancia (Nome)
);

CREATE TABLE TelefonePolo (
	Tipo character varying(10) CONSTRAINT TelefonePolo_PK primary key,
	Nome character varying(12),
	DDD character varying(3),
	Fone character varying(10),
	Ramal character varying(5),
	Origem character varying(10),
	CONSTRAINT TelefonePolo_PoloDistancia_FK foreign key (Nome) references PoloDistancia (Nome)
);

CREATE TABLE Disciplina (
	Codigo character varying(10) CONSTRAINT Disciplina_PK primary key,
	Sigla character varying(7),
	Nro_creditos integer,
	Vezes_Realizadas integer,
	Categoria character varying(20)	
);

---------------
---- LUCAS ----
---------------

CREATE TABLE DisciplinaPreReq(
	Codigo CHAR(10) CONSTRAINT Disciplina_PK primary key,
	Sigla CHAR(7),
	Nro_creditos INT,
	Categoria CHAR(20),
	CodigoPreRequisito CHAR (10),
	CONSTRAINT Disciplina_FK foreing key (CodigoPreRequisito) references Disciplina
);

-----------------
---- THALLES ----
-----------------

CREATE TABLE Atividade(
 	Data_Inicio date CONSTRAINT atividade_PK PRIMARY KEY,
 	Data_Fim date,
 	Atributo CHAR(1) -- atributo descriminatório sobre tipo de atividade
 );

CREATE TABLE Compoe(
	Codigo_Disciplina CHAR(10),
	Codigo_Curso CHAR(10),
	Obrigatoriedade BOOLEAN,
	Perfil CHAR(1), -- atributo descriminatório sobre perfil
	FOREIGN KEY (Codigo_Disciplina) REFERENCES Disciplina (Codigo),
	FOREIGN KEY (Codigo_Curso) REFERENCES Curso (Codigo_Curso),
	CONSTRAINT compoe_PK PRIMARY KEY (Codigo_Disciplina, Codigo_Curso)
);

CREATE TABLE Efetua(
	Codigo_NDocente CHAR(10),
	Codigo_Reuniao CHAR(10),
	FOREIGN KEY (Codigo_NDocente) REFERENCES Nucleo_Docente (Codigo_NDocente),
	FOREIGN KEY (Codigo_Reuniao) REFERENCES Reuniao (Codigo_Reuniao),
	CONSTRAINT efetua_PK PRIMARY KEY (Codigo_NDocente, Codigo_Reuniao)
);

CREATE TABLE Matriculado(
	RA INT,
	Codigo_Curso CHAR(10),
	Grade CHAR(15), 
	Periodo CHAR(1), -- atributo descriminatório sobre periodo
	Status BOOLEAN,
	Perfil CHAR(1), -- atributo descriminatório sobre perfil
	Ano_Ingresso date,
	Ano_Termino date,
	FOREIGN KEY (RA) REFERENCES Estudante (RA),
	FOREIGN KEY (Codigo_Curso) REFERENCES Curso (Codigo_Curso),
	CONSTRAINT matriculado_PK PRIMARY KEY (RA, Codigo_Curso)
);

---------------
---- TIAGO ----
---------------

CREATE TABLE Realiza_CC_Re(
    ID_conselho      INT NOT NULL,
    Codigo_Reuniao   CHAR (10)  NOT NULL,
    FOREIGN KEY (ID_conselho) REFERENCES Conselho_Curso (ID_conselho),
	FOREIGN KEY (Codigo_Reuniao) REFERENCES Reuniao (Codigo_Reuniao),
	CONSTRAINT Realiza_CC_Re_PK PRIMARY KEY (ID_conselho, Codigo_Reuniao) 
 );
 
 CREATE TABLE Cursa(
    RA          INT NOT NULL,
    Id_Turma    INT NOT NULL,
    Semestre    INT ,
    Media       FLOAT,
    Frenquencia FLOAT,
    Status      CHAR(1),
    FOREIGN KEY (RA) REFERENCES Estudante (RA),
	FOREIGN KEY (Id_Turma) REFERENCES Turma(Id_Turma),
	CONSTRAINT Cursa_PK PRIMARY KEY (RA,Id_Turma) 
 );

---------------
---- TOMAS ----
---------------

--Possui (Conselho_Curso x Nucleo_Docente) - possuiCCND 
CREATE TABLE PossuiCCND
(
	conselho_id VARCHAR(10),
	nucleo_docente_codigo VARCHAR(10),

	CONSTRAINT possuiccnd_pk PRIMARY KEY (conselho_id, nucleo_docente_codigo),
	CONSTRAINT possuiccnd_conselho_fk FOREIGN KEY (conselho_id) REFERENCES Conselho_curso (id_conselho),
	CONSTRAINT possuiccnd_nucleodocente_fk FOREIGN KEY (nucleo_docente_codigo) REFERENCES Nucleo_Docente (Codigo_NDocente) 
);

--Possui (Reconhecimento_Curso x Fase)  - possuiRCF
CREATE TABLE PossuiRCF
(
	data DATE NOT NULL,
	rec_cod_curso VARCHAR(10),
	id_fase VARCHAR(10),

	CONSTRAINT possuircf_pk PRIMARY KEY (rec_cod_curso, id_fase),
	CONSTRAINT possuircf_reccurso_fk FOREIGN KEY (rec_cod_curso) REFERENCES Reconhecimento_curso (rec_cod_curso),
	CONSTRAINT possuircf_fase_fk FOREIGN KEY (id_fase) REFERENCES Fase (id_fase) 

);

--Inscreve (Estudante x Turma)
CREATE TABLE Inscreve
(
	data DATE,
	deferimento BOOLEAN,
	prioridade_inscricao INT,
	id_turma VARCHAR(1),
	ra INT,

	CONSTRAINT inscreve_pk PRIMARY KEY (ra, id_turma),
	CONSTRAINT inscreve_estudante_fk FOREIGN KEY (ra) REFERENCES Estudante (ra),
	CONSTRAINT inscreve_turma_fk FOREIGN KEY (id_turma) REFERENCES Turma (id_turma) 

);

--------------
---- EDNA ----
--------------

create table Pessoa
(
  rg varchar(9) not null,
  pre_nome varchar(20),
  meio_nome varchar(20),
  ultimo_nome varchar(20),
  email varchar(20),
  email_Institucional varchar(20),
  etnia varchar(15),
  sexo char,
  dataNascimento date,
  nome_mae varchar(20),
  nome_pai varchar(20),
  cidadeNata_nome varchar(20),
  pais_origem varchar(20),
  nacionalidade varchar(15),
     CONSTRAINT pessoa_pk PRIMARY KEY (rg)
     );

create table Pessoa_Endereco
(
     num_casa int not null,
     rg  varchar(9) not null,
     rua varchar(15),
     complemento varchar(15),
     bairro varchar(15),
     uf varchar(2),
     cep int, 
     CONSTRAINT pessoa_fk FOREIGN KEY (rg)
	REFERENCES public.pessoa (rg) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION,
        constraint  Pessoa_endereco_pk primary key (rg,num_casa,cep)

     );
create table Pessoa_Contato(
     ddd int not null, 
     numero int not null,
     tipo varchar(6) not null,
     ramal int not null,
     rg varchar(9) not null,
    
      CONSTRAINT pessoa_fk FOREIGN KEY (rg)
	REFERENCES public.pessoa (rg) MATCH SIMPLE
	ON UPDATE NO ACTION ON DELETE NO ACTION,
 constraint  contato_pk primary key (rg,ddd,numero,ramal,tipo)
    );

----------------
---- ILGNER ----
----------------

CREATE TABLE Enade (
	Realizacao DATE DEFAULT SYSDATE CONSTRAINT Enade_PK primary key,
	Nota       NUMBER(2,2),
	Estudante_RA INTEGER,
	Curso_codigo  INTEGER,
	CONSTRAINT Enade_Estudante_fk Foreign key (Estudante_RA) references Estudante (RA),
	CONSTRAINT Enade_Curso_fk Foreign key (Curso_codigo) references Curso (codigo)
);

-------------------
---- GUILHERME ----
-------------------

CREATE TABLE Reconhecimento_De_Curso (
	cod_rec_curso varchar(10) PRIMARY KEY
);

CREATE TABLE Visita (
	data date NOT NULL,
	cod_rec_curso varchar(10) REFERENCES reconhecimento_de_curso(cod_rec_curso),
	comite_avaliador varchar(400),
	itens varchar(400),
	PRIMARY KEY(data, cod_rec_curso)
);

CREATE TABLE Fase (
	documentos varchar(400),
	data date,
	fase_id varchar(10) NOT NULL,
	cod_rec_curso varchar(10) REFERENCES  reconhecimento_de_curso(cod_rec_curso),
	PRIMARY KEY(fase_id)
);

-----------------
---- OSIRES -----
-----------------

CREATE TABLE Docente (
    Pessoa_RG character varying(9) not null,
    codigo integer not null,

    CONSTRAINT Docente_Pessoa_FK FOREIGN KEY (Pessoa_RG) REFERENCES Pessoa(RG),
    CONSTRAINT Docente_PK PRIMARY KEY (RG, codigo)
);



CREATE TABLE TecAdm (
    Pessoa_RG varchar(9) not null,
    codigo integer not null,

    CONSTRAINT TecAdm_Pessoa_FK FOREIGN KEY (Pessoa_RG) REFERENCES Pessoa (RG), 
    CONSTRAINT TecAdm_PK PRIMARY KEY (RG, codigo)
);


CREATE TABLE PertenceDND
  (
    rg varchar(9) not null,
    CodNDocente varchar(10) not null,
    CodDocente integer not null,
    CONSTRAINT Docente_PertenceDND_FK FOREIGN KEY (rg, CodDocente ) REFERENCES Docente(rg, CodDocente),
    CONSTRAINT Nucleo_Docente_PertenceDND_FK FOREIGN KEY (CodNDocente ) REFERENCES Nucleo_Docente(CodNDocente),    
    Data date not null, 
    CONSTRAINT PertenceDND_PK PRIMARY KEY (rg, CodDocentes, CodNDocente, Data)
	
  );

--------------------
---- ALEXANDRE -----
--------------------

CREATE TYPE gradecurricular AS (
	Optativa BOOLEAN,
	Obrigatoria BOOLEAN,
	Eletiva BOOLEAN
);

CREATE TABLE ProjetoPoliticoPedagogico (
	grade gradecurricular
	FOREIGN KEY (Codigo_curso) REFERENCES Curso(Codigo_curso)
);