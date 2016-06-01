---------------
---- PEDRO ----
---------------

-- reunião
CREATE TABLE Reuniao (
	numero INTEGER NOT NULL UNIQUE,
	pauta TEXT,
	data_inicio DATE,

	CONSTRAINT Reuniao_pk PRIMARY KEY (numero)
);

-- calendários
CREATE TABLE Calendario (
	data_inicio DATE NOT NULL,
	data_fim DATE,
	dias_letivos INTEGER NOT NULL,
	tipo CHAR NOT NULL, -- atributo discriminatório Graduação Presencial (p), EaD (e) ou Administrativo (a)
	aprovado BOOLEAN DEFAULT FALSE,
	reuniao_numero INTEGER,
	anterior_data DATE,	-- data de início do calendário anterior ao referente
	anterior_tipo CHAR, -- tipo do calendário anterior ao referente

	CONSTRAINT Calendario_Reuniao_fk FOREIGN KEY (reuniao_numero) REFERENCES Reuniao(numero)
		ON DELETE RESTRICT,
	CONSTRAINT Calendario_pk PRIMARY KEY (data_inicio, tipo)
);

-- eventos -> dependem de calendário
CREATE TABLE Evento (
	id_evento SERIAL NOT NULL UNIQUE,
	data_inicio DATE NOT NULL,
	data_fim DATE,
	descricao TEXT,
	calendario_data DATE NOT NULL, -- data de início do calendario ao qual o evento pertence
	calendario_tipo CHAR NOT NULL, -- tipo do calendario ao qual o eento pertence

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
---- JÉSSICA D. ----
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
  CONSTRAINT Campus_fk FOREIGN KEY (Campus_sigla) REFERENCES Campus (sigla)
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
 
  CONSTRAINT realizaace_pk PRIMARY KEY (RA_estudante, nome_At),
  CONSTRAINT realizaace_estudante_fk FOREIGN KEY (RA_estudante) REFERENCES estudante (RA),
  CONSTRAINT realizaace_atcomp_fk FOREIGN KEY (nome_At) REFERENCES AtComp (nome)
);

-----------------
---- GABRIEL ----
-----------------

CREATE TABLE PertenceDD (
	sigla_departamento character varying(100),
	codigo_disciplina character varying(10),
	CONSTRAINT pertencedd_sigla_departamento foreign key (sigla_departamento) references Departamento(sigla),
	CONSTRAINT pertencedd_codigo_disciplina foreign key (codigo_disciplina) references Disciplina(Codigo),
	CONSTRAINT pertencedd_pk PRIMARY KEY (sigla_departamento,codigo_disciplina_disciplina)
 );
 
 CREATE TABLE Turma (
 	id_turma character varying(1),
 	vagas integer,
 	codigo_disciplina character varying(10),
 	codigo_docente integer,
 	CONSTRAINT turma_codigo_disciplina foreign key (codigo_disciplina) references Disciplina(Codigo),
 	CONSTRAINT turma_codigo_docente foreign key (codigo_docente) references Docente(Codigo),
 	CONSTRAINT turma_pk primary key (codigo_disciplina, id_turma)
 );

 CREATE TABLE Sala (
 	id_turma character varying(1),
 	codigo_disciplina character varying(10),
 	sala character varying(20),
 	CONSTRAINT sala_turma_fk foreign key (id_turma, codigo_disciplina) references Turma(id_turma, codigo_disciplina),
 	CONSTRAINT sala_pk PRIMARY KEY (id_turma, codigo_disciplina, sala)
 );

----------------
---- ARTHUR ----
----------------

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

----------------
---- RAFAEL ----
----------------

CREATE TABLE Estudante(
	RA INT CONSTRAINT estudante_PK  primary key,
	CPF CHAR(15) NOT NULL,
	AnoConcEM CHAR(4),
	IRA INT NOT NULL,
	Presencial CHAR(1), -- atributo descriminatório: Presencial(s) ou Distancia(n) (7.2.1 - C Elmasri)
	Graduando BOOLEAN, -- Flag de reconhecimento Estudante Graduando
	PosGraduando BOOLEAN -- Flag de reconhecimento Estudante Pós Graduando(7.2.1 - D Elmasri)
 );

 CREATE TABLE PoloDistancia(
	Nome CHAR(12) CONSTRAINT Polo_PK primary key,
	RA_estudante INT,
	CEP CHAR(10),
	Rua CHAR(40),
	Complemento CHAR(20),
	Bairro CHAR(20),
	Cidade CHAR(20),
	UF CHAR(2),
	Pais CHAR(10),
	PontoGeoreferenciado CHAR(50),
	Coordenador_PreNome CHAR(12),
	Coordenador_SobreNome CHAR (20),
	Coordenador_email1 CHAR(20),
	Coordenador_email2 CHAR(20),
	Coordenador_telefone1 CHAR(20),
	Coordenador_telefone2 CHAR(20),
	Tutor_PreNome CHAR(12),
	Tutor_SobreNome CHAR(20),
	Tutor_email1 CHAR(20),
	Tutor_email2 CHAR(20),
	Tutor_telefone1 CHAR(20),
	Tutor_telefone2 CHAR(20),
	CONSTRAINT polo_FK foreign key (RA_estudante) references Estudante(RA)
 );
 
CREATE TABLE FotoPolo(
	Num_foto INT CONSTRAINT foto_PK primary key,
	Nome CHAR(12),
	Imagem CHAR(20),
	CONSTRAINT foto_FK foreign key (Nome) references PoloDistancia(Nome)
);

CREATE TABLE TelefonePolo(
	Tipo CHAR(10) CONSTRAINT Telefone_PK primary key,
	Nome CHAR(12),
	DDD CHAR(3),
	Fone CHAR(10),
	Ramal CHAR(5),
	Origem CHAR(10),
	CONSTRAINT Telefone_FK foreign key (Nome) references PoloDistancia(Nome)
);

CREATE TABLE Disciplina(
	Codigo CHAR(10) CONSTRAINT Disciplina_PK primary key,
	Sigla CHAR(7),
	Nro_creditos INT,
	Vezes_Realizadas INT,
	Categoria CHAR(20)	
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

create table pessoa
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

create table pessoa_endereco
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
create table pessoa_contato(
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
	Cod_Curso  INTEGER,
	CONSTRAINT Enade_FK_Estudante  Foreign key (RA)        references Estudante (RA),
	CONSTRAINT Enade_FK_Curso      Foreign key (Cod_Curso) references Curso     (codigo),
);

-------------------
---- GUILHERME ----
-------------------

CREATE TABLE reconhecimento_de_curso(
	cod_rec_curso varchar(10) PRIMARY KEY
);

CREATE TABLE visita(
	data date NOT NULL,
	cod_rec_curso varchar(10) REFERENCES reconhecimento_de_curso(cod_rec_curso),
	comite_avaliador varchar(400),
	itens varchar(400),
	PRIMARY KEY(data, cod_rec_curso)
);

CREATE TABLE fase(
	documentos varchar(400),
	data date,
	fase_id varchar(10) NOT NULL,
	cod_rec_curso varchar(10) REFERENCES  reconhecimento_de_curso(cod_rec_curso),
	PRIMARY KEY(fase_id)
);