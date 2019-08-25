--Procedimiento
CREATE OR REPLACE PROCEDURE ejercicioDos(mejorPago OUT empleo.ced%Type)
    IS
    BEGIN
        SELECT ced into mejorPago FROM empleo where valor_mensual=(SELECT max(valor_mensual) FROM empleo);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            DBMS_OUTPUT.PUT_LINE('No hay ningún empleo');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Existen varios empleados con el mismo valor mensual');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error ' || SQLERRM);
END;

--Ejecución
Declare
    mejorPago empleo.ced%type;
BEGIN
    ejercicioDos(mejorPago);
    DBMS_OUTPUT.PUT_LINE(mejorPago);
END;