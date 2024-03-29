--Función para calcular los gastos mensuales
CREATE OR REPLACE function gastos_mensuales(cedula empleo.ced%type)
    return empleo.VALOR_MENSUAL%Type
    IS
    gastos empleo.VALOR_MENSUAL%Type;
    BEGIN
        
        SELECT sum(VALOR_MENSUAL) into gastos from GASTO where CED = cedula;
        if gastos is null then
            gastos:=0;
            return gastos;
        end if;
        return gastos;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        gastos:=0;
        return gastos;
    END;
    
--Función para calcular las ganancias mensuales
create or  replace function ganancias_mensuales(cedula empleo.ced%type)
    return empleo.VALOR_MENSUAL%Type
    IS
    ganancias empleo.VALOR_MENSUAL%Type;
    BEGIN
        SELECT sum(VALOR_MENSUAL) into ganancias from EMPLEO where CED = cedula;
        if ganancias is null then
            ganancias:=0;
            return ganancias;
        end if;
        return ganancias;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
        ganancias:=0;
        return ganancias;
    END;
--Reglas de gastos para cuando se inserta o modifica un gasto
create or replace TRIGGER REGLAGASTO_insert  BEFORE INSERT ON gasto
    for each row
    declare
        ganancias empleo.valor_mensual%type;
        gastos gasto.valor_mensual%type;
    BEGIN
        ganancias:=ganancias_mensuales(:NEW.CED);
        gastos:=gastos_mensuales(:NEW.CED);
        gastos:=gastos+:NEW.valor_mensual;
        IF gastos>ganancias THEN
            RAISE_APPLICATION_ERROR(-20505,'El valor de gastos mensual supera al de ganancias');
        end if;

END;
create or replace TRIGGER REGLAGASTO_update  before update ON gasto
    for each row
    declare
        ganancias empleo.valor_mensual%type;
        gastos gasto.valor_mensual%type;
        
    BEGIN
        gastos:=gastos_mensuales(:NEW.CED);
        ganancias:=ganancias_mensuales(:NEW.CED);
        gastos:=gastos-:old.valor_mensual;
        gastos:=gastos+:NEW.valor_mensual;
        
        IF gastos>ganancias THEN
            RAISE_APPLICATION_ERROR(-20505,'El valor de gastos mensual supera al de ganancias');
        end if;

END;
--Reglas en empleo para cuando se elimina o modifica un dato
create or replace TRIGGER REGLAEMPLEO_delete before delete on EMPLEO
    for each row
    declare
        ganancias empleo.valor_mensual%type;
        gastos gasto.valor_mensual%type;
    begin
        gastos:=gastos_mensuales(:NEW.CED);
        ganancias:=ganancias_mensuales(:NEW.CED);
        ganancias:=ganancias-:OLD.valor_mensual;
        IF gastos>ganancias THEN
            RAISE_APPLICATION_ERROR(-20505,'El valor de gastos mensual supera al de ganancias');
        end if;
    end;

create or replace TRIGGER REGLAEMPLEO_update before delete on EMPLEO
    for each row
    declare
        ganancias empleo.valor_mensual%type;
        gastos gasto.valor_mensual%type;
    begin
        gastos:=gastos_mensuales(:NEW.CED);
        ganancias:=ganancias_mensuales(:NEW.CED);
        ganancias:=ganancias-:OLD.valor_mensual;
        ganancias:=ganancias+:NEW.valor_mensual;
        IF gastos>ganancias THEN
            RAISE_APPLICATION_ERROR(-20505,'El valor de gastos mensual supera al de ganancias');
        end if;
    end;

