-- View de eventos do calendário presencial
CREATE OR REPLACE VIEW view_eventoscalendariopresencial
AS
SELECT e.data_inicio AS "Data de Início", e.data_fim AS "Data de Término", e.descricao AS "Descrição"
FROM Evento AS e, Calendario AS c
WHERE e.calendario_data = c.data_inicio AND
	  e.calendario_tipo = c.tipo AND
	  c.tipo = 'p'
GROUP BY e.data_inicio;


-- View de eventos do calendario do Ensino à Distância
CREATE OR REPLACE VIEW view_eventoscalendariopresencial
AS
SELECT e.data_inicio AS "Data de Início", e.data_fim AS "Data de Término", e.descricao AS "Descrição"
FROM Evento AS e, Calendario AS c
WHERE e.calendario_data = c.data_inicio AND
	  e.calendario_tipo = c.tipo AND
	  c.tipo = 'e'
GROUP BY e.data_inicio;


-- View de eventos do calendario Administrativo
CREATE OR REPLACE VIEW view_eventoscalendariopresencial
AS
SELECT e.data_inicio AS "Data de Início", e.data_fim AS "Data de Término", e.descricao AS "Descrição"
FROM Evento AS e, Calendario AS c
WHERE e.calendario_data = c.data_inicio AND
	  e.calendario_tipo = c.tipo AND
	  c.tipo = 'a'
GROUP BY e.data_inicio;
