DECLARE
    numerito NUMBER(4);
    CURSOR productore IS
    SELECT productor.id, productor.nombre,count(*) AS numerito 
        FROM productor  inner join producto on producto.productor_id=productor.id
            group by productor.id,productor.nombre;
    codi productor.id%TYPE;
    nombre productor.nombre%TYPE;
    numero numerito%TYPE;
BEGIN
    OPEN productore;
        LOOP
            FETCH productore INTO codi, nombre, numero;
            EXIT WHEN productore%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(codi || ' ' || nombre || ' ' || numero);
        END LOOP;
    CLOSE productore;
END;