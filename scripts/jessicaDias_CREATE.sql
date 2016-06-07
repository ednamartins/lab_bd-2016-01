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