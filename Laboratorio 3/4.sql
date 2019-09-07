CREATE OR REPLACE PACKAGE laboratorio IS
    FUNCTION masGaston RETURN gasto.ced%Type;
    FUNCTION mejorPagado RETURN empleo.ced%Type;
END;
/
CREATE OR REPLACE PACKAGE BODY laboratorio IS
    function masGaston 
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
    function mejorPagado
        return empleo.ced%Type
        IS
        mejorPago empleo.ced%Type;
        BEGIN 
            SELECT ced into mejorPago FROM empleo group by ced having Sum(valor_mensual)=(SELECT max(x.sum) FROM (SELECT sum(valor_mensual) as sum FROM empleo  group by ced)x);
            return mejorPago;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN 
                DBMS_OUTPUT.PUT_LINE('No hay ningún empleo');
            WHEN TOO_MANY_ROWS THEN
                DBMS_OUTPUT.PUT_LINE('Existen varios empleados con el mismo valor mensual');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Error ' || SQLERRM);
     END;
END;

--Ejecución
Declare
    a gasto.ced%Type;
begin
    a:=laboratorio.masGaston;
    DBMS_OUTPUT.PUT_LINE('El mas gaston es el cliente con cédula ' || a);
end;

Declare
    a empleo.ced%Type;
begin
    a:=laboratorio.mejorPagado;
    DBMS_OUTPUT.PUT_LINE('El mejor pagado es el ' || a);
end;