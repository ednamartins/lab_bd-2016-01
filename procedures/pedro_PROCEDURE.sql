CREATE OR REPLACE FUNCTION insere_CalendarioPresencial (dataInicio date, diasLetivos integer, aprovado boolean, Reuniao_numero integer, Anterior_dataInicio date, Anterior_tipo char)
RETURNS void AS $$
BEGIN
	IF (Anterior_dataInicio IS NULL AND Anterior_tipo IS NULL)
	-- todo
END;
$$ LANGUAGE plpgsql;