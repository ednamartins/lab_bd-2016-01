--Database: "Prograd"
DROP TABLE Evento;
DROP TABLE Calendario;
DROP TABLE Reuniao;

--CREATE DATABASE "Prograd"
--	WITH OWNER = postgres
--		ENCODING = 'UTF8'	
--   		TABLESPACE = pg_default
--   		LC_COLLATE = 'Portuguese_Brazil.1252'
--   		LC_CTYPE = 'Portuguese_Brazil.1252'
--   		CONNECTION LIMIT = -1;

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