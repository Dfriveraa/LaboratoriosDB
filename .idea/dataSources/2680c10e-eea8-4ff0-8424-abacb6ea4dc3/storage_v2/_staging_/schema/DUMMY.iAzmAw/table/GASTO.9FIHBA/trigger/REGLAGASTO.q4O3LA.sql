create trigger REGLAGASTO
    before insert or update
    on GASTO
    for each row
declare
        ganancias empleo.valor_mensual%type;
        gastos gasto.valor_mensual%type;
    BEGIN
        ganancias:=ganancias_mensuales(:NEW.CED);
        gastos:=gastos_mensuales(:NEW.CED);
        gastos:=gastos+:NEW.valor_mensual;
        DBMS_OUTPUT.PUT_LINE('las ganancias son'|| ganancias);
        IF gastos>ganancias THEN

            DBMS_OUTPUT.PUT_LINE('las ganancias son'|| ganancias || 'los gastos son' || gastos);
            RAISE_APPLICATION_ERROR(-205096,'El valor de gastos mensual supera al de ganancias');
        end if;
END;
/

