create or replace procedure "TrocaIRA" (nRa in integer, novoIra in integer)
is erro EXCEPTION;
BEGIN
UPDATE ira
SET ira = novoIra;
WHERE ra = nRa;
EXCEPTION WHEN erro THEN RAISE_APPLICATION_ERROR(123, 'Formato incorreto', FALSE);
commit;
END TrocaIRA;
/
exec TrocaIRA (555555, 15000);
