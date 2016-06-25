--	Esta procedure faz inserções nas tabelas Calendário e EhAnterior (se aplicável).
--	A distinção do tipo de calendário (Presencial, EaD ou Administrativo),
--		é feita por meio do parâmetro "Calendario_tipo".
--	Calendario_tipo: 'p' -> presencial, 'e' -> EaD, 'a' -> Administrativo.
CREATE OR REPLACE FUNCTION insereCalendario
	(p_Calendario_tipo character,
	 p_dataInicio date, 
	 p_diasLetivos integer,
	 p_Reuniao_numero integer,
	 p_aprovado boolean DEFAULT FALSE,  
	 p_Anterior_dataInicio date DEFAULT NULL)
RETURNS void AS $$
BEGIN
	IF p_Calendario_tipo <> 'p' OR p_Calendario_tipo <> 'e' OR p_Calendario_tipo <> 'a' THEN
		RAISE EXCEPTION 'Tipo de Calendario inexistente --> %', p_Calendario_tipo
			USING HINT = 'Deve ser ''p'' para Presencial, ''e'' para EaD ou ''a'' para Administrativo.';
		RETURN;
	END IF;

	INSERT INTO Calendario (dataInicio, diasLetivos, tipo, aprovado, Reuniao_numero)
		VALUES (
			p_dataInicio,
			p_diasLetivos,
			p_Calendario_tipo,
			p_aprovado,
			p_Reuniao_numero
		);

	IF p_Anterior_dataInicio IS NOT NULL THEN
		INSERT INTO EhAnterior (Anterior_dataInicio, Anterior_tipo, Posterior_dataInicio, Posterior_tipo)
		VALUES (
			p_Anterior_dataInicio,
			p_Calendario_tipo,
			p_dataInicio,
			p_Calendario_tipo
		);
	END IF;
END;
$$ LANGUAGE plpgsql CALLED ON NULL INPUT;


-- TESTES
--INSERT INTO Reuniao VALUES (6, 'Pauta Reuniao 6', '2011-12-09');
--INSERT INTO Reuniao VALUES (7, 'Pauta Reuniao 7', '2010-12-09');
--INSERT INTO Reuniao VALUES (8, 'Pauta Reuniao 8', '2011-01-10');
--SELECT insereCalendarioPresencial('p', '2012-03-16'::date, 120, TRUE, 6);
--SELECT insereCalendarioPresencial('p', '2011-02-20'::date, 120, FALSE, 7);
--SELECT insereCalendarioPresencial('p', '2011-03-01'::date, 100, TRUE, 8, '2011-02-20'::date);