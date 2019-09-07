
--Ejecución
Declare
    a empleo.ced%Type;
begin
    a:=mejorPagado;
    DBMS_OUTPUT.PUT_LINE('El mejor pagado es el ' || a);
end;

