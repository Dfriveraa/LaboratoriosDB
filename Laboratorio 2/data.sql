--Tablas
CREATE TABLE cliente( ced NUMBER(8) PRIMARY KEY,
nom VARCHAR2(10) NOT NULL);

CREATE TABLE empleo( ced NUMBER(8) REFERENCES cliente,
nit_empresa INTEGER,
valor_mensual NUMBER(6) NOT NULL,
PRIMARY KEY (ced, nit_empresa));

CREATE TABLE gasto( cod_gasto NUMBER(8) PRIMARY KEY,
ced NUMBER(8) REFERENCES cliente,
valor_mensual NUMBER(6),
desc_gasto VARCHAR2(10));

--Datos
INSERT INTO cliente (ced, nom) values (1, 'Karol');
INSERT INTO cliente (ced, nom) values (2, 'Mattius');
INSERT INTO cliente (ced, nom) values (3, 'Jairo');
INSERT INTO cliente (ced, nom) values (4, 'Carlos');

INSERT INTO empleo (ced, nit_empresa, valor_mensual) values (1, 1, 1500);
INSERT INTO empleo (ced, nit_empresa, valor_mensual) values (2, 2, 800);
INSERT INTO empleo (ced, nit_empresa, valor_mensual) values (3, 3, 456);
INSERT INTO empleo (ced, nit_empresa, valor_mensual) values (2, 4, 1000);

INSERT INTO GASTO  values (1, 1, 900,'cion');
INSERT INTO GASTO  values (2, 2, 5000,'crip');
INSERT INTO GASTO  values (3, 3, 800,'des');
INSERT INTO GASTO  values (4, 2, 4500,'crip');
INSERT INTO GASTO  values (5, 1, 9000,'cion');

