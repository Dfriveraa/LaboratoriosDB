create or replace TRIGGER reglaGasto  BEFORE INSERT or Update or delete ON gasto
    for each row
    declare
        ganancias empleo.valor_mensual%type;
        gastos gasto.valor_mensual%type;
    BEGIN
        SELECT sum(VALOR_MENSUAL) into ganancias from EMPLEO where CED = :NEW.CED;
        Select sum(VALOR_MENSUAL) into gastos from GASTO where CED= :NEW.CED;
        gastos:=gastos+:new.valor_mensual;
        IF gastos>ganancias THEN
            RAISE_APPLICATION_ERROR(-205096,'El valor de gastos mensual supera al de ganancias');
        end if;
END;

