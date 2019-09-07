

BEGIN 
    EXECUTE IMMEDIATE 
    'CREATE TABLE productor(id NUMBER(8)
    ,nombre VARCHAR(20)
    ,direccion VARCHAR(20)
    ,PRIMARY KEY(id))'; 
END;
BEGIN
    EXECUTE IMMEDIATE
    'CREATE TABLE producto(id NUMBER(8)
    ,nombre VARCHAR(20)
    ,descripcion VARCHAR(20)
    ,productor_id NUMBER(8)
    ,cantidad NUMBER(4)
    ,precio NUMBER(8)
    ,PRIMARY KEY(id)
    ,FOREIGN KEY(productor_id) REFERENCES PRODUCTOR)';
END;
BEGIN 
    EXECUTE IMMEDIATE 
    'CREATE TABLE venta(id NUMBER(8)
    ,producto_id NUMBER(8)
    ,cantidad NUMBER(4)
    ,fecha DATE
    ,PRIMARY KEY(id)
    ,FOREIGN KEY(producto_id) REFERENCES PRODUCTO)'; 
END;