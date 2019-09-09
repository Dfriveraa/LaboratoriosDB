--Función
CREATE OR REPLACE function masGaston
    return gasto.ced%Type
    IS
    masGaston gasto.ced%Type;
    BEGIN
        SELECT ced  into masGaston FROM gasto group by ced having Sum(valor_mensual)= (select max(x.sum) from (SELECT sum(valor_mensual) as sum FROM gasto group by ced)x);
        return masGaston;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No hay ningún gasto');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Existen varios empleados con el mismo gasto mensual');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error ' || SQLERRM);
END;
/

--Ejecución
Declare
    a gasto.ced%Type;
begin
    a:=masGaston;
    DBMS_OUTPUT.PUT_LINE('El mas gaston es el cliente con cédula ' || a);
end;