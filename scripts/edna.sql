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