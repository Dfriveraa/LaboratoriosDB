--Verificar si el cliente existe.
create or replace procedure buscarCliente(cedula IN CLIENTE.CED%TYPE, existe OUT BOOLEAN)
    IS
        idCliente CLIENTE.CED%TYPE;
    Begin
        existe:=true;
        SELECT ced INTO idCliente FROM cliente WHERE ced=cedula;
    Exception
        WHEN NO_DATA_FOUND THEN 
            existe:=false;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error' || SQLERRM);
END;
/
 --Verificar si el empleo existe.
create or replace procedure buscarEmpleo(cedula IN CLIENTE.CED%TYPE,nit In EMPLEO.NIT_EMPRESA%TYPE, existe OUT BOOLEAN)
    IS
        idCliente empleo.CED%TYPE;
    Begin
        existe :=true;
        SELECT ced INTO idCliente FROM empleo WHERE ced=cedula and nit_empresa=nit;
    Exception
        WHEN NO_DATA_FOUND THEN 
            existe:=false;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error' || SQLERRM);
END;
/
--AccionesCliente
CREATE OR REPLACE PROCEDURE crearOModificarC(cedula IN CLIENTE.CED%TYPE,nombre IN CLIENTE.NOM%TYPE,accion IN BOOLEAN) 
    IS 
    BEGIN 
        if(accion=true) then 
            UPDATE cliente SET nom = nombre WHERE ced = cedula; 
            DBMS_OUTPUT.PUT_LINE('El nombre del cliente se ha modificado correctamente'); 
        else 
            INSERT INTO CLIENTE VALUES(cedula,nombre); 
            DBMS_OUTPUT.PUT_LINE('Se ha agregado el nuevo cliente'); 
        end if; 
    EXCEPTION 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('Error ' || SQLERRM); 
END; 
/
--AccionesEmpleo
CREATE OR REPLACE PROCEDURE crearOModificarE(cedula IN CLIENTE.CED%TYPE,nit IN EMPLEO.NIT_EMPRESA%TYPE,valor IN EMPLEO.VALOR_MENSUAL%TYPE,accion IN BOOLEAN)
    IS
    BEGIN
        if(accion=true) then
            UPDATE empleo SET valor_mensual=valor WHERE ced = cedula and nit_empresa=nit;
            DBMS_OUTPUT.PUT_LINE('El valor mensual ha sido modificado');
        else
            INSERT INTO empleo VALUES(cedula, nit, valor);
            DBMS_OUTPUT.PUT_LINE('Se ha creado el empleo.'); 
        end if;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error ' || SQLERRM);
END;
/
--Ejercicio
create or replace procedure ejercicioUno(cedula IN CLIENTE.CED%TYPE,nit In EMPLEO.NIT_EMPRESA%TYPE,nombre IN CLIENTE.NOM%TYPE,valor IN EMPLEO.VALOR_MENSUAL%TYPE)
    IS
    checkCliente BOOLEAN;
    checkEmpleo BOOLEAN;

    Begin
        buscarCliente(cedula,CheckCliente);
        buscarEmpleo(cedula,nit,checkEmpleo);
        crearOModificarC(cedula,nombre,checkCliente);
        crearOModificarE(cedula,nit,valor,checkEmpleo);
    EXCEPTION 
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error' || SQLERRM);
END;
/
--Ejecución
BEGIN
    ejercicioUno(115,456,'Daniel', 200);
END;
