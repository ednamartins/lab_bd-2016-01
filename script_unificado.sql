DROP TABLE ProjetoPoliticoPedagogico;
DROP TABLE PertenceDND;
DROP TABLE TecADM;
DROP TABLE Docente;
DROP TABLE Fase;
DROP TABLE Visita;
DROP TABLE Reconhecimento_De_Curso;
DROP TABLE Enade;
DROP TABLE Pessoa_Telefone;
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
DROP TABLE PoloDistancia_Telefone;
DROP TABLE PoloDistancia_Foto;
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
CREATE TABLE Reuniao 
(
	numero integer not null unique,
	pauta text,
	data_inicio date,

	CONSTRAINT Reuniao_pk PRIMARY KEY (numero)
);

-- calendários
CREATE TABLE Calendario 
(
	data_inicio date not null,
	data_fim date,
	dias_letivos integer not null,
	tipo char not null, -- atributo discriminatório Graduação Presencial (p), EaD (e) ou Administrativo (a)
	aprovado boolean default false,
	reuniao_numero integer,
	anterior_data date,	-- data de início do calendário anterior ao referente
	anterior_tipo char, -- tipo do calendário anterior ao referente

	CONSTRAINT Calendario_Reuniao_fk FOREIGN KEY (reuniao_numero) REFERENCES Reuniao(numero)
		ON DELETE RESTRICT,
	CONSTRAINT Calendario_pk PRIMARY KEY (data_inicio, tipo)
);

-- eventos -> dependem de calendário
CREATE TABLE Evento 
(
	id_evento serial not null unique,
	data_inicio date not null,
	data_fim date,
	descricao text,
	calendario_data date not null, -- data de início do calendario ao qual o evento pertence
	calendario_tipo char, -- tipo do calendario ao qual o eento pertence

	CONSTRAINT Evento_Calendario_fk FOREIGN KEY (calendario_data, calendario_tipo) REFERENCES Calendario(data_inicio, tipo)
		ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT Evento_pk PRIMARY KEY (calendario_data, calendario_tipo, id_evento)
);

-- define o auto-relacionamento entre Calendário "anterior" e Calendário "posterior"
ALTER TABLE Calendario ADD FOREIGN KEY (anterior_data, anterior_tipo) REFERENCES Calendario(data_inicio, tipo);

-- trigger para calcular data_fim
CREATE OR REPLACE FUNCTION calcula_data_fim_proc() RETURNS trigger
AS $$
BEGIN 
	NEW.data_fim = NEW.data_inicio + INTERVAL '1' DAY * NEW.dias_letivos;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

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
  	Estudante_ra integer not null,
  	AtComp_nome character varying(100) not null,
 
  	CONSTRAINT RealizaACE_pk PRIMARY KEY (Estudante_RA, AtComp_nome),
  	CONSTRAINT RealizaACE_Estudante_fk FOREIGN KEY (Estudante_RA) REFERENCES Estudante (ra),
  	CONSTRAINT RealizaACE_AtComp_fk FOREIGN KEY (AtComp_nome) REFERENCES AtComp (nome)
);

-----------------
---- GABRIEL ---- OK
-----------------

CREATE TABLE PertenceDD 
(
	Departamento_sigla character varying(100) not null,
	Disciplina_codigo char not null,

	CONSTRAINT PertenceDD_Departamento_fk foreign key (Departamento_sigla) references Departamento (sigla),
	CONSTRAINT PertenceDD_Disciplina_fk foreign key (Disciplina_codigo) references Disciplina (codigo),
	CONSTRAINT PertenceDD_pk PRIMARY KEY (Departamento_sigla, Disciplina_codigo)
 );
 
CREATE TABLE Turma 
(
 	id char not null unique,
 	vagas integer,
 	Disciplina_codigo character varying(10),
 	Docente_codigo integer,

 	CONSTRAINT Turma_Disciplina_fk foreign key (Disciplina_codigo) references Disciplina (codigo),
 	CONSTRAINT Turma_Docente_fk foreign key (Docente_codigo) references Docente (codigo),
 	CONSTRAINT Turma_pk primary key (Disciplina_codigo, id)
);

CREATE TABLE Sala 
(
 	Turma_id char,
 	Turma_Disciplina_codigo character varying(10),
 	sala character varying(20),

 	CONSTRAINT sala_turma_fk foreign key (Turma_id, Turma_Disciplina_codigo) references Turma (id, Disciplina_codigo),
 	CONSTRAINT sala_pk PRIMARY KEY (Turma_id, Turma_Disciplina_codigo, sala)
);

----------------
---- ARTHUR ---- OK
----------------

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

CREATE TYPE endereco AS 
(
    rua character varying(50),
    complemento character varying(20),
    bairro character varying(20),
    cidade character varying(20),
    uf character varying(2),
    pais character varying(20),
    cep bigint 
);


CREATE TYPE supervisor AS 
(
    cpf bigint,
    nome character varying(30)
);


CREATE TABLE Curso 
(
    codigo integer constraint Curso_pk primary key,
    website character varying(40),
    nome character varying(40),
    coordenador coord 
);

CREATE TABLE Empresa 
(
    cnpj bigint constraint Empresa_pk primary key,
    nome integer,
    endereco endereco
);

CREATE TABLE Estagia 
(
    dtInicio date,
    dtTermino date,
    Estudante_cpf character varying(15),
    supEmpresa supervisor,
    supUniversidade supervisor,
    cartaAvaliacao text,
    termoCompromisso text,

    constraint Estagia_Estudante_fk FOREIGN KEY (Estudante_cpf) references Estudante (cpf),
    constraint Estagia_pk PRIMARY KEY (Estudante_cpf)
);

----------------
---- RAFAEL ---- OK
----------------

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

CREATE TABLE PoloDistancia
(
	nome character varying(12) CONSTRAINT PoloDistancia_PK primary key,
	Estudante_ra integer,
	cep character varying(10),
	rua character varying(40),
	complemento character varying(20),
	bairro character varying(20),
	cidade character varying(20),
	uf character varying(2),
	pais character varying(10),
	pontoGeoreferenciado character varying(50),
	coordenador_PreNome character varying(12),
	coordenador_SobreNome character varying (20),
	coordenador_email1 character varying(20),
	coordenador_email2 character varying(20),
	coordenador_telefone1 character varying(20),
	coordenador_telefone2 character varying(20),
	tutor_PreNome character varying(12),
	tutor_SobreNome character varying(20),
	tutor_email1 character varying(20),
	tutor_email2 character varying(20),
	tutor_telefone1 character varying(20),
	tutor_telefone2 character varying(20),

	CONSTRAINT PoloDistancia_Estudante_fk foreign key (Estudante_ra) references Estudante (RA)
 );
 
CREATE TABLE PoloDistancia_Foto 
(
	numero integer CONSTRAINT PoloDistancia_Foto_PK primary key,
	PoloDistancia_nome character varying(12),
	imagem character varying(20),

	CONSTRAINT Foto_PoloDistancia_FK foreign key (PoloDistancia_nome) references PoloDistancia (nome)
);

CREATE TABLE PoloDistancia_Telefone 
(
	tipo character varying(10) CONSTRAINT PoloDistancia_Telefone_PK primary key,
	PoloDistancia_nome character varying(12),
	ddd character varying(3),
	fone character varying(10),
	ramal character varying(5),
	origem character varying(10),
	CONSTRAINT Telefone_PoloDistancia_FK foreign key (PoloDistancia_nome) references PoloDistancia (nome)
);

CREATE TABLE Disciplina 
(
	codigo character varying(10) CONSTRAINT Disciplina_PK primary key,
	sigla character varying(7),
	nro_creditos integer,
	vezes_Realizadas integer,
	categoria character varying(20)	
);

---------------
---- LUCAS ---- OK
---------------

CREATE TABLE DisciplinaPreReq
(
	codigo character varying(10) CONSTRAINT DisciplinaPreReq_PK primary key,
	sigla character varying(7),
	nro_creditos integer,
	categoria character varying(20),
	codigoPreRequisito character varying (10),
	CONSTRAINT Disciplina_FK foreign key (CodigoPreRequisito) references Disciplina
);

-----------------
---- THALLES ---- OK
-----------------

CREATE TABLE Atividade
(
 	data_inicio date not null,
 	data_fim date,
 	atributo char, -- atributo descriminatório sobre tipo de atividade

 	CONSTRAINT Atividade_PK PRIMARY KEY (data_inicio)
);

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

CREATE TABLE Efetua
(
	Nucleo_Docente_codigo integer,
	Reuniao_numero integer,

	CONSTRAINT Efetua_Nucleo_Docente_fk FOREIGN KEY (Nucleo_Docente_codigo) REFERENCES NucleoDocente (codigo),
	CONSTRAINT Efetua_Reuniao_fk FOREIGN KEY (Reuniao_numero) REFERENCES Reuniao (numero),
	CONSTRAINT Efetua_pk PRIMARY KEY (Nucleo_Docente_codigo, Reuniao_numero)
);

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

---------------
---- TIAGO ----	OK
---------------

CREATE TABLE RealizaCCRe
(
	Conselho_id integer not null,
	Reuniao_numero integer not null,

	CONSTRAINT RealizaCCRe_ConselhoCurso_fk FOREIGN KEY (Conselho_id) REFERENCES ConselhoCurso (id),
	CONSTRAINT RealizaCCRe_Reuniao_fk FOREIGN KEY (Reuniao_numero) REFERENCES Reuniao (numero),
	CONSTRAINT RealizaCCRe_pk PRIMARY KEY (Conselho_id, Reuniao_numero) 
);


CREATE TABLE Cursa(
	Estudante_ra integer not null,
	Turma_id char NOT NULL,
	semestre integer,
	media numeric(2,2),
	frenquencia numeric(2,2),
	status char,

	CONSTRAINT Cursa_Estudante_fk FOREIGN KEY (Estudante_ra) REFERENCES Estudante (ra),
	CONSTRAINT Cursa_Turma_fk FOREIGN KEY (Turma_id) REFERENCES Turma (id),
	CONSTRAINT Cursa_PK PRIMARY KEY (Estudante_ra,Turma_id) 
);

---------------
---- TOMAS ----	OK
---------------

--Possui (Conselho_Curso x Nucleo_Docente) - possuiCCND 
CREATE TABLE PossuiCCND
(
	ConselhoCurso_id integer not null,
	NucleoDocente_codigo integer not null,

	CONSTRAINT PossuiCCND_pk PRIMARY KEY (ConselhoCurso_id, NucleoDocente_codigo),
	CONSTRAINT PossuiCCND_ConselhoCurso_fk FOREIGN KEY (ConselhoCurso_id) REFERENCES ConselhoCurso (id),
	CONSTRAINT PossuiCCND_NucleoDocente_fk FOREIGN KEY (NucleoDocente_codigo) REFERENCES NucleoDocente (codigo) 
);

--Possui (Reconhecimento_Curso x Fase)  - possuiRCF
CREATE TABLE PossuiRCF
(
	periodo date NOT NULL,
	ReconhecimentoDeCurso_codigo character varying(10) not null,
	Fase_id character varying(10) not null,

	CONSTRAINT PossuiRCF_pk PRIMARY KEY (ReconhecimentoDeCurso_codigo, Fase_id),
	CONSTRAINT PossuiRCF_ReconhecimentoDeCurso_fk FOREIGN KEY (ReconhecimentoDeCurso_codigo) REFERENCES ReconhecimentoDeCurso (codigo),
	CONSTRAINT PossuiRCF_Fase_fk FOREIGN KEY (Fase_id) REFERENCES Fase (id) 

);

--Inscreve (Estudante x Turma)
CREATE TABLE Inscreve
(
	periodo date,
	deferimento boolean,
	prioridade_inscricao integer,
	Turma_id character varying(1),
	Estudante_ra integer,

	CONSTRAINT Inscreve_pk PRIMARY KEY (Estudante_ra, Turma_id),
	CONSTRAINT Inscreve_Estudante_fk FOREIGN KEY (Estudante_ra) REFERENCES Estudante (ra),
	CONSTRAINT Inscreve_Turma_fk FOREIGN KEY (Turma_id) REFERENCES Turma (id) 

);

--------------
---- EDNA ---- OK
--------------

CREATE TABLE Pessoa 
(
	rg character varying(9) not null,
	pre_nome character varying(20),
	meio_nome character varying(20),
	ultimo_nome character varying(20),
	email character varying(20),
	email_institucional character varying(20),
	etnia character varying(15),
	sexo char,
	data_nascimento date,
	nome_mae character varying(20),
	nome_pai character varying(20),
	origem_cidade character varying(20),
	origem_estado character varying(20),
	origem_pais character varying(20),
	nacionalidade character varying(15),
	endereco endereco,
	telefone telefone,
  
  CONSTRAINT Pessoa_pk PRIMARY KEY (rg)
);

CREATE TABLE Pessoa_Endereco
(
    num_casa integer not null,
    Pessoa_rg  character varying(9) not null,
    rua character varying(15),
    complemento character varying(15),
    bairro character varying(15),
    uf character varying(2),
    cep integer,

    CONSTRAINT pessoa_fk FOREIGN KEY (Pessoa_rg) REFERENCES Pessoa (rg),
    CONSTRAINT Pessoa_endereco_pk PRIMARY KEY (Pessoa_rg, num_casa, cep)
);

CREATE TABLE Pessoa_Telefone
(
    ddd integer not null, 
    numero integer not null,
    tipo character varying(6) not null,
    ramal integer not null,
    Pessoa_rg character varying(9) not null,
    
    CONSTRAINT pessoa_fk FOREIGN KEY (Pessoa_rg) REFERENCES Pessoa (rg),
 	constraint  contato_pk PRIMARY KEY (Pessoa_rg, ddd, numero, ramal, tipo)
); 

----------------
---- ILGNER ---- OK
----------------

CREATE TABLE Enade (
	data_realizacao date not null default 'now()',
	nota numeric(2,2),
	Estudante_ra integer,
	Curso_codigo integer,

	CONSTRAINT Enade_Estudante_fk foreign key (Estudante_ra) references Estudante (ra),
	CONSTRAINT Enade_Curso_fk foreign key (Curso_codigo) references Curso (codigo),
	CONSTRAINT Enade_pk primary key (Estudante_ra, Curso_codigo, data_realizacao)
);

-------------------
---- GUILHERME ----	OK
-------------------

CREATE TABLE ReconhecimentoDeCurso 
(
	codigo character varying(10) not null,

	CONSTRAINT ReconhecimentoDeCurso_pk PRIMARY KEY (codigo)
);

CREATE TABLE Visita 
(
	periodo date not null,
	comite_avaliador character varying(400),
	itens character varying(400),
	ReconhecimentoDeCurso_codigo character varying(10),

	CONSTRAINT Visita_ReconhecimentoDeCurso_fk FOREIGN KEY (ReconhecimentoDeCurso_codigo) REFERENCES ReconhecimentoDeCurso (codigo),
	CONSTRAINT Visita_pk PRIMARY KEY (periodo, ReconhecimentoDeCurso_codigo)
);

CREATE TABLE Fase 
(
	id character varying(10) not null,
	documentos character varying(400),
	periodo date,
	ReconhecimentoDeCurso_codigo character varying(10), 

	CONSTRAINT Fase_ReconhecimentoDeCurso_fk FOREIGN KEY (ReconhecimentoDeCurso_codigo) REFERENCES ReconhecimentoDeCurso (codigo),
	CONSTRAINT Fase_pk PRIMARY KEY (id)
);

-----------------
---- OSIRES ----- OK
-----------------

CREATE TABLE Docente 
(
    Pessoa_rg character varying(9) not null,
    codigo integer not null unique,

    CONSTRAINT Docente_Pessoa_FK FOREIGN KEY (Pessoa_rg) REFERENCES Pessoa(rg),
    CONSTRAINT Docente_PK PRIMARY KEY (Pessoa_rg, codigo)
);



CREATE TABLE TecAdm 
(
    Pessoa_rg character varying(9) not null,
    codigo integer not null,

    CONSTRAINT TecAdm_Pessoa_FK FOREIGN KEY (Pessoa_rg) REFERENCES Pessoa (rg), 
    CONSTRAINT TecAdm_PK PRIMARY KEY (Pessoa_rg, codigo)
);


CREATE TABLE PertenceDND
(
    Docente_Pessoa_rg character varying(9) not null,
    Nucleo_Docente_codigo integer not null,
    Docente_codigo integer not null,
    periodo date not null, 

    CONSTRAINT Docente_PertenceDND_FK FOREIGN KEY (Docente_Pessoa_rg, Docente_codigo) REFERENCES Docente (Pessoa_rg, codigo),
    CONSTRAINT Nucleo_Docente_PertenceDND_FK FOREIGN KEY (Nucleo_Docente_codigo) REFERENCES Nucleo_Docente (codigo),    
    CONSTRAINT PertenceDND_PK PRIMARY KEY (Docente_Pessoa_rg, Docente_codigo, Nucleo_Docente_codigo, periodo)
);

--------------------
---- ALEXANDRE ----- OK
--------------------

CREATE TYPE gradecurricular AS 
(
	Optativa boolean,
	Obrigatoria boolean,
	Eletiva boolean
);

CREATE TABLE ProjetoPoliticoPedagogico 
(
	grade gradecurricular,
	Curso_codigo integer,

	CONSTRAINT ProjetoPoliticoPedagogico_Curso_fk FOREIGN KEY (Curso_codigo) REFERENCES Curso (codigo),
	CONSTRAINT ProjetoPoliticoPedagogico_pk PRIMARY KEY (Curso_codigo, grade)
);

------------------
---- LUCIANO ----- OK
------------------

CREATE TABLE ConselhoCurso
(  
	representante character varying(20),
	id integer not null,

	CONSTRAINT ConselhoCurso_pk PRIMARY KEY (id) 
);


CREATE TABLE PertenceCCP 
( 
	categoria character varying(20), 
	periodo date,
	Pessoa_rg character varying(9) not null,
	ConselhoCurso_id integer not null,

	CONSTRAINT PertenceCP_Pessoa_fk FOREIGN KEY (Pessoa_rg) REFERENCES Pessoa (rg),
	CONSTRAINT PertenceCP_ConselhoCurso_fk FOREIGN KEY (ConselhoCurso_id) REFERENCES ConselhoCurso (id),
	CONSTRAINT pertence_PK PRIMARY KEY(Pessoa_rg, ConselhoCurso_id)
);



----------------
-- TEMPORARIO --
----------------
CREATE TABLE NucleoDocente 
(
	codigo integer,

	CONSTRAINT Nucleo_Docente_pk PRIMARY KEY (codigo),
)