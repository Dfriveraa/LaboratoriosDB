--PRODUCTOR
BEGIN 
    INSERT INTO PRODUCTOR VALUES (1,'Pablo', 'Calle 80b 72c 182'); 
    INSERT INTO PRODUCTOR VALUES (2,'karol', 'Calle 80b 72c 185');
    INSERT INTO PRODUCTOR VALUES (3,'Danielito', 'Calle 80b 72c 189');
END;

--PRODUCTO
/
BEGIN 
    INSERT INTO PRODUCTO VALUES (0,'Arroz', 'Roa',1,3,1300); 
    INSERT INTO PRODUCTO VALUES (1,'Papa', 'Criolla',1,10,800);
    INSERT INTO PRODUCTO VALUES (2,'Panela', 'Valluna',2,2,2000);
    INSERT INTO PRODUCTO VALUES (3,'Papel H', 'Family',2,1,1500);
    INSERT INTO PRODUCTO VALUES (4,'Yuca', 'Vidriosa',3,1,400);
    INSERT INTO PRODUCTO VALUES (5,'Galleta', 'Ducal',3,4,3000);
END;
/
--VENTA 
BEGIN 
    INSERT INTO VENTA VALUES (0,0, 1,date'2019-11-11'); 
    INSERT INTO VENTA VALUES (1,1, 1,date'2019-11-12');
    INSERT INTO VENTA VALUES (2,2, 1,date'2019-11-13');
    INSERT INTO VENTA VALUES (3,5, 1,date'2019-11-14');
END;