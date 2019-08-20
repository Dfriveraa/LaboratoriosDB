--9.5
DECLARE
    sinProductos exception;
    CURSOR productore IS
    SELECT productor.id as identificacion, productor.nombre as nombre,count(producto.id) AS cantidad 
        FROM productor  left join producto on producto.productor_id=productor.id
            group by    productor.id,productor.nombre;
BEGIN
    FOR p IN productore LOOP
        DBMS_OUTPUT.PUT_LINE (p.identificacion || ' ' || p.nombre || ' ' || p.cantidad);
        if p.cantidad=0 then
            raise sinProductos; 
        end if;
    END LOOP;
    EXCEPTION
    WHEN sinProductos THEN
        DBMS_OUTPUT.PUT_LINE('No tiene disponibles');
END;


--9.6
DECLARE
excepNombre exception;
BEGIN
    FOR orden IN (SELECT id, nombre FROM producto ORDER BY id)
    LOOP
        if orden.nombre is null then
            raise excepNombre; 
        end if;
        DBMS_OUTPUT.PUT_LINE(orden.id || ' ' || orden.nombre);
    END LOOP;
    EXCEPTION
    WHEN excepNombre THEN
        DBMS_OUTPUT.PUT_LINE('No todos tienen nombre');
END;
--9.7
DECLARE
fail Exception;
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
        if total=0 then
            raise fail; 
        END IF;
        DBMS_OUTPUT.PUT_LINE('Total de productos: ' || total);
    END LOOP;
Exception
    when fail then
        DBMS_OUTPUT.PUT_LINE('Hay productores que no tienen productos asociados');
END;

--9.8
DECLARE
nuevos number(4);
exceptCantidad exception;
    CURSOR product IS 
        SELECT id,precio,cantidad FROM producto FOR UPDATE;
BEGIN
    nuevos:=0;
    FOR pro IN product LOOP
        IF pro.cantidad < 10 THEN
            UPDATE producto SET precio= precio+ precio*0.05
                WHERE CURRENT OF product;
                nuevos:=nuevos+1;
        END IF;
    END LOOP;
        if nuevos=0 then
            raise exceptCantidad; 
        END IF;
EXCEPTION
    WHEN exceptCantidad THEN
        DBMS_OUTPUT.PUT_LINE('No se actualizó ningún precio');
END;
