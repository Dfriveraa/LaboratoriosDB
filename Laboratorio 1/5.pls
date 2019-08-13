DECLARE
    numerito NUMBER(4);
    CURSOR productore IS
    SELECT productor.id as identificacion, productor.nombre as nombre,count(*) AS cantidad 
        FROM productor  inner join producto on producto.productor_id=productor.id
            group by    productor.id,productor.nombre;
BEGIN
    FOR p IN productore LOOP
        DBMS_OUTPUT.PUT_LINE (p.identificacion || ' ' || p.nombre || ' ' || p.cantidad);
    END LOOP;
END;