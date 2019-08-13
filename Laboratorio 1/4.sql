DECLARE
    CURSOR ordenados IS
    SELECT id, nombre FROM producto ORDER BY id;
    codi producto.id%TYPE;
    nombre producto.nombre%TYPE;
BEGIN
    OPEN ordenados;
        LOOP
            FETCH ordenados INTO codi, nombre;
            EXIT WHEN ordenados%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(codi || ' ' || nombre );
        END LOOP;
    CLOSE ordenados;
END;