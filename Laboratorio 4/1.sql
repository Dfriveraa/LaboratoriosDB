create or replace TRIGGER control_cliente BEFORE INSERT or Update or delete ON cliente
BEGIN
    case
        when inserting then
            insert into auditoria values(SYSDATE,'cliente','insert');
        when updating then
            insert into auditoria values(SYSDATE,'cliente','update');
        when deleting then
            insert into auditoria values(SYSDATE,'cliente','delete');
    end case;
END;

create or replace TRIGGER control_gasto BEFORE INSERT or Update or delete ON GASTO
BEGIN
    case
        when inserting then
            insert into auditoria values(SYSDATE,'gasto','insert');
        when updating then
            insert into auditoria values(SYSDATE,'gasto','update');
        when deleting then
            insert into auditoria values(SYSDATE,'gasto','delete');
    end case;
END;

create or replace TRIGGER control_empleo BEFORE INSERT or Update or delete ON EMPLEO
BEGIN
    case
        when inserting then
            insert into auditoria values(SYSDATE,'empleo','insert');
        when updating then
            insert into auditoria values(SYSDATE,'empleo','update');
        when deleting then
            insert into auditoria values(SYSDATE,'empleo','delete');
    end case;
END;