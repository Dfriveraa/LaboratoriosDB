create table auditoria(
fecha date,
nombre_tabla varchar(10),
operacion varchar(10),
PRIMARY KEY (fecha,nombre_tabla,operacion)
);
