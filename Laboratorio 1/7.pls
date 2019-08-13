DECLARE
total NUMBER(5);
    CURSOR productore IS 
        SELECT id, nombre  FROM productor ORDER BY id;
    CURSOR product (pr producto.productor_id%TYPE) IS
        SELECT id, nombre, precio FROM producto WHERE productor_id = pr;
BEGIN
    FOR productores IN productore LOOP
        DBMS_OUTPUT.PUT_LINE('Productor ' || productores.nombre);
        total := 0;
            FOR pro IN product(productores.id) LOOP
                DBMS_OUTPUT.PUT_LINE('Id Producto: '|| pro.id || ' '|| 'Nombre: '|| pro.nombre|| ' '|| 'Precio: '|| pro.precio);
                total := total + 1;
            END LOOP;
        DBMS_OUTPUT.PUT_LINE('Total de productos: ' || total);
    END LOOP;
END;