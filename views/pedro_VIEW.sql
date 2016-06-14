-- View de eventos do calendário presencial
CREATE OR REPLACE VIEW view_eventoscalendariopresencial
AS
SELECT e.data_inicio AS "Data de Início", e.data_fim AS "Data de Término", e.descricao AS "Descrição"
FROM Evento AS e, Calendario AS c
WHERE e.calendario_data = c.data_inicio AND
	  e.calendario_tipo = c.tipo AND
	  c.tipo = 'p'
ORDER BY e.data_inicio, e.data_fim;


-- View de eventos do calendario do Ensino à Distância
CREATE OR REPLACE VIEW view_eventoscalendarioead
AS
SELECT e.data_inicio AS "Data de Início", e.data_fim AS "Data de Término", e.descricao AS "Descrição"
FROM Evento AS e, Calendario AS c
WHERE e.calendario_data = c.data_inicio AND
	  e.calendario_tipo = c.tipo AND
	  c.tipo = 'e'
ORDER BY e.data_inicio, e.data_fim;


-- View de eventos do calendario Administrativo
CREATE OR REPLACE VIEW view_eventoscalendarioadministrativo
AS
SELECT e.data_inicio AS "Data de Início", e.data_fim AS "Data de Término", e.descricao AS "Descrição"
FROM Evento AS e, Calendario AS c
WHERE e.calendario_data = c.data_inicio AND
	  e.calendario_tipo = c.tipo AND
	  c.tipo = 'a'
ORDER BY e.data_inicio, e.data_fim;