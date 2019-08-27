CREATE OR REPLACE function mejorPagado
    return empleo.ced%Type
    IS
    mejorPago empleo.ced%Type;
    BEGIN 
        SELECT ced into mejorPago FROM empleo where valor_mensual=(SELECT max(valor_mensual) FROM empleo);
        return mejorPago;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            DBMS_OUTPUT.PUT_LINE('No hay ningún empleo');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Existen varios empleados con el mismo valor mensual');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error ' || SQLERRM);
END;
/
--Ejecución
Declare
    a empleo.ced%Type;
begin
    a:=mejorPagado;
    DBMS_OUTPUT.PUT_LINE('El mejor pagado es el ' || a);
end;

