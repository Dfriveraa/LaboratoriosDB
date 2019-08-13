BEGIN
    FOR orden IN (SELECT id, nombre FROM producto ORDER BY id)
    LOOP
        DBMS_OUTPUT.PUT_LINE(orden.id || ' ' || orden.nombre);
    END LOOP;
END;