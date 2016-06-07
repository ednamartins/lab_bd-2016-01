------ População da Tabela
-- Reuniao
INSERT INTO Reuniao (numero, pauta, data_inicio)
	VALUES (
		1,
		'Pauta Reuniao 1',
		'2013-09-10'
	);

INSERT INTO Reuniao (numero, pauta, data_inicio)
	VALUES (
		2,
		'Pauta Reuniao 2',
		'2013-10-01'
	);

INSERT INTO Reuniao (numero, pauta, data_inicio)
	VALUES (
		3,
		'Pauta Reuniao 3',
		'2013-10-12'
	);

-- Calendario
INSERT INTO Calendario (data_inicio, dias_letivos, tipo, reuniao_numero) 
	VALUES (
		'2014-01-20',
		138,
		'p',
		1
	);

INSERT INTO Calendario (data_inicio, dias_letivos, tipo, reuniao_numero, anterior_data, anterior_tipo) 
	VALUES (
		'2014-02-01',
		128,
		'p',
		2,
		'2014-01-20',
		'p'
	);

INSERT INTO Calendario (data_inicio, dias_letivos, tipo, aprovado, reuniao_numero, anterior_data, anterior_tipo) 
	VALUES (
		'2014-02-28',
		100,
		'p',
		TRUE,
		3,
		'2014-02-01',
		'p'
	);

INSERT INTO Calendario (data_inicio, dias_letivos, tipo, aprovado, reuniao_numero) 
	VALUES (
		'2014-02-28',
		100,
		'e',
		TRUE,
		3
	);

INSERT INTO Calendario (data_inicio, dias_letivos, tipo, aprovado, reuniao_numero) 
	VALUES (
		'2014-02-28',
		100,
		'a',
		TRUE,
		2
	);

-- Eventos
INSERT INTO Evento (data_inicio, data_fim, descricao, calendario_data, calendario_tipo)
	VALUES (
		'2014-02-01',
		'2014-02-03',
		'Inscrição em disciplinas',
		'2014-02-28',
		'p'
	);

INSERT INTO Evento (data_inicio, data_fim, descricao, calendario_data, calendario_tipo)
	VALUES (
		'2014-03-07',
		'2014-03-07',
		'Início das aulas',
		'2014-02-28',
		'p'
	);

INSERT INTO Evento (data_inicio, data_fim, descricao, calendario_data, calendario_tipo)
	VALUES (
		'2014-02-14',
		'2014-02-28',
		'Período para digitação das notas referente a 2015/2',
		'2014-02-28',
		'e'
	);

INSERT INTO Evento (data_inicio, data_fim, descricao, calendario_data, calendario_tipo)
	VALUES (
		'2014-03-22',
		'2014-03-22',
		'Prazo máximo para digitação das notas REC referente a 2015/2',
		'2014-02-28',
		'e'
	);

INSERT INTO Evento (data_inicio, data_fim, descricao, calendario_data, calendario_tipo)
	VALUES (
		'2014-03-12',
		'2014-03-12',
		'Prazo máximo para apresentação de recursos junto á ProGrad',
		'2014-02-28',
		'a'
	);

INSERT INTO Evento (data_inicio, data_fim, descricao, calendario_data, calendario_tipo)
	VALUES (
		'2014-04-25',
		'2014-04-25',
		'Prazo máximo para envio da Ficha de caracterização de Atividades curriculares/turmas referentes a 2015/2',
		'2014-02-28',
		'a'
	);