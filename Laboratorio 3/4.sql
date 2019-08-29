CREATE OR REPLACE PACKAGE laboratorio IS
    FUNCTION masGaston RETURN NUMBER;
    FUNCTION mejorPagado RETURN NUMBER;
END;
/
CREATE OR REPLACE PACKAGE BODY laboratorio IS
    function masGaston 
        return gasto.ced%Type 
        IS 
        masGaston gasto.ced%Type; 
        BEGIN  
            SELECT ced into masGaston FROM gasto where valor_mensual=(SELECT max(valor_mensual) FROM gasto); 
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
END;

