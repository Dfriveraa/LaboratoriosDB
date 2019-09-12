CREATE TABLE asiento (
    número           NUMBER(2) NOT NULL,
    letra            CHAR(1) NOT NULL,
    ta_cod           VARCHAR2(3) NOT NULL,
    sala_num         NUMBER(2) NOT NULL,
    s_sucursal_cod   VARCHAR2(5) NOT NULL
);

ALTER TABLE asiento
    ADD CONSTRAINT asiento_pk PRIMARY KEY ( número,
                                            letra,
                                            sala_num,
                                            s_sucursal_cod );

CREATE TABLE asiento_función (
    función_hora_inicio   TIMESTAMP NOT NULL,
    función_fecha         DATE NOT NULL,
    f_sala_num            NUMBER(2) NOT NULL,
    f_sucursal_cod        VARCHAR2(5) NOT NULL,
    f_pf_pelicula_cod     VARCHAR2(10) NOT NULL,
    f_pf_formato_cod      VARCHAR2(3) NOT NULL,
    asiento_num           NUMBER(2) NOT NULL,
    asiento_letra         CHAR(1) NOT NULL,
    estado                VARCHAR2(12) NOT NULL check(estado in('Reservado','Vendido','Inactivo')),
    r_cliente_doc         VARCHAR2(10),
    r_cliente_td          VARCHAR2(4),
    reserva_hora          TIMESTAMP,
    precio                NUMBER(6, 3) NOT NULL
);

ALTER TABLE asiento_función
    ADD CONSTRAINT asiento_función_pk PRIMARY KEY ( función_hora_inicio,
                                                    función_fecha,
                                                    f_sala_num,
                                                    f_sucursal_cod,
                                                    f_pf_pelicula_cod,
                                                    f_pf_formato_cod,
                                                    asiento_num,
                                                    asiento_letra );

CREATE TABLE boleta (
    hora                     TIMESTAMP NOT NULL,
    taquilla_num             NUMBER(2) NOT NULL,
    af_función_hora_inicio   TIMESTAMP NOT NULL,
    af_función_fecha         DATE NOT NULL,
    af_f_sala_número         NUMBER(2) NOT NULL,
    af_s_sucursal_cod        VARCHAR2(5) NOT NULL,
    af_pf_pelicula_cod       VARCHAR2(10) NOT NULL,
    af_pf_formato_cod        VARCHAR2(3) NOT NULL,
    af_asiento_num           NUMBER(2) NOT NULL,
    af_asiento_letra         CHAR(1) NOT NULL,
    t_sucursal_cod           VARCHAR2(5) NOT NULL,
    pc_promoción_cod         VARCHAR2(5),
    pc_cliente_doc           VARCHAR2(10),
    pc_cliente_td            VARCHAR2(4)
);

CREATE UNIQUE INDEX boleta__idx ON
    boleta (
        af_función_hora_inicio
    ASC,
        af_función_fechataquilla
    ASC,
        af_f_sala_número
    ASC,
        af_s_sucursal_cod
    ASC,
        af_pf_pelicula_cod
    ASC,
        af_pf_formato_cod
    ASC,
        af_asiento_num
    ASC,
        af_asiento_letra
    ASC );

ALTER TABLE boleta
    ADD CONSTRAINT boleta_pk PRIMARY KEY ( af_función_hora_inicio,
                                           af_función_fecha,
                                           af_f_sala_número,
                                           af_s_sucursal_cod,
                                           af_pf_pelicula_cod,
                                           af_pf_formato_cod,
                                           af_asiento_num,
                                           af_asiento_letra,
                                           t_sucursal_cod );

CREATE TABLE cargo (
    código        VARCHAR2(4) NOT NULL,
    descripción   VARCHAR2(15) NOT NULL
);

ALTER TABLE cargo ADD CONSTRAINT cargo_pk PRIMARY KEY ( código );

CREATE TABLE cliente (
    documento    VARCHAR2(10) NOT NULL,
    nombre       VARCHAR2(20) NOT NULL,
    fecha_naci   DATE NOT NULL,
    teléfono     VARCHAR2(7) NOT NULL,
    estado       VARCHAR2(10) NOT NULL check(estado in('Activo','Inactivo','Sancionado')),
    celular      VARCHAR2(10),
    email        VARCHAR2(15),
    tipo_doc     VARCHAR2(4) NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( documento,
                                                            tipo_doc );

CREATE TABLE cuenta (
    usuario             VARCHAR2(10) NOT NULL,
    contraseña          VARCHAR2(8) NOT NULL,
    cliente_documento   VARCHAR2(10) NOT NULL,
    cliente_td          VARCHAR2(4) NOT NULL
);

ALTER TABLE cuenta ADD CONSTRAINT cuenta_pk PRIMARY KEY ( cliente_documento,
                                                          cliente_td );

CREATE TABLE empleado (
    código         VARCHAR2(5) NOT NULL,
    nombre         VARCHAR2(10) NOT NULL,
    documento      VARCHAR2(10) NOT NULL,
    tipo_doc       VARCHAR2(4) NOT NULL,
    jefe_código    VARCHAR2(5) NOT NULL,
    sucursal_cod   VARCHAR2(5) NOT NULL,
    cargo_cod      VARCHAR2(4) NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( código );

CREATE TABLE empleado_sala (
    fecha                  DATE NOT NULL,
    sala_número            NUMBER(2) NOT NULL,
    sala_sucursal_código   VARCHAR2(5) NOT NULL,
    empleado_código        VARCHAR2(5) NOT NULL,
    hora_inicio            TIMESTAMP NOT NULL,
    hora_fin               TIMESTAMP NOT NULL check(hora_fin>hora_inicio)
);

ALTER TABLE empleado_sala
    ADD CONSTRAINT empleado_sala_pk PRIMARY KEY ( fecha,
                                                  sala_número,
                                                  sala_sucursal_código,
                                                  empleado_código );

CREATE TABLE empleado_taquilla (
    fecha            DATE NOT NULL,
    taquilla_num     NUMBER(2) NOT NULL
    check(taquilla_num>0),
    t_sucursal_cod   VARCHAR2(5) NOT NULL,
    empleado_cod     VARCHAR2(5) NOT NULL,
    hora_inicio      TIMESTAMP NOT NULL,
    hora_fin         TIMESTAMP NOT NULL check(hora_fin>hora_inicio)
);

ALTER TABLE empleados_taquilla
    ADD CONSTRAINT empleados_taquilla_pk PRIMARY KEY ( fecha,
                                                       taquilla_num,
                                                       t_sucursal_cod,
                                                       empleado_cod );

CREATE TABLE evento (
    código            VARCHAR2(4) NOT NULL,
    fecha             DATE NOT NULL,
    valor             NUMBER NOT NULL check(duración>=0),
    duración          NUMBER(2) NOT NULL check(duración>0),
    cliente_doc       VARCHAR2(10) NOT NULL,
    sala_num          NUMBER(2) NOT NULL,
    s_sucursal_cod    VARCHAR2(5) NOT NULL,
    pf_pelicula_cod   VARCHAR2(10) NOT NULL,
    pf_formato_cod    VARCHAR2(3) NOT NULL,
    cliente_td        VARCHAR2(4) NOT NULL
);

ALTER TABLE evento
    ADD CONSTRAINT evento_pk PRIMARY KEY ( código,
                                           sala_num,
                                           s_sucursal_cod );

CREATE TABLE formato (
    código   VARCHAR2(3) NOT NULL,
    nombre   VARCHAR2(10) NOT NULL
);

ALTER TABLE formato ADD CONSTRAINT formato_pk PRIMARY KEY ( código );

CREATE TABLE función (
    fecha             DATE NOT NULL,
    hora_inicio       TIMESTAMP NOT NULL,
    hora_fin          TIMESTAMP NOT NULL check(hora_fin>hora_inicio),
    precio_regular    NUMBER(6, 3) NOT NULL check(precio_regular>0),
    sala_num          NUMBER(2) NOT NULL,
    s_sucursal_cod    VARCHAR2(5) NOT NULL,
    pf_pelicula_cod   VARCHAR2(10) NOT NULL,
    pf_formato_cod    VARCHAR2(3) NOT NULL,
    empleado_cod      VARCHAR2(5) NOT NULL
);

ALTER TABLE función
    ADD CONSTRAINT función_pk PRIMARY KEY ( hora_inicio,
                                            fecha,
                                            sala_num,
                                            s_sucursal_cod,
                                            pf_pelicula_cod,
                                            pf_formato_cod );

CREATE TABLE género (
    código   VARCHAR2(5) NOT NULL,
    nombre   VARCHAR2(10) NOT NULL
);

ALTER TABLE género ADD CONSTRAINT género_pk PRIMARY KEY ( código );

CREATE TABLE genero_película (
    género_cod     VARCHAR2(5)
        CONSTRAINT nnc_género_película_género_cod NOT NULL,
    pelicula_cod   VARCHAR2(10) 
        CONSTRAINT género_película_pelicula_cod NOT NULL
);

ALTER TABLE genero_película ADD CONSTRAINT género_película_pk PRIMARY KEY ( género_cod,
                                                                            pelicula_cod );

CREATE TABLE pelicula (
    código          VARCHAR2(10) NOT NULL,
    nombre          VARCHAR2(10) NOT NULL,
    sinopsis        VARCHAR2(100),
    productor_cod   VARCHAR2(5) NOT NULL,
    duración        NUMBER(3) NOT NULL
        check(duración>0+)
);

ALTER TABLE pelicula ADD CONSTRAINT pelicula_pk PRIMARY KEY ( código );

CREATE TABLE película_formato (
    pelicula_cod   VARCHAR2(10) NOT NULL,
    formato_cod    VARCHAR2(3) NOT NULL
);

ALTER TABLE película_formato ADD CONSTRAINT película_formato_pk PRIMARY KEY ( pelicula_cod,
                                                                              formato_cod );

CREATE TABLE productora (
    código   VARCHAR2(5) NOT NULL,
    nombre   VARCHAR2(10) NOT NULL
);

ALTER TABLE productora ADD CONSTRAINT productor_o_estudio_pk PRIMARY KEY ( código );

CREATE TABLE promoción (
    código        VARCHAR2(5) NOT NULL,
    valor         VARCHAR2(2) NOT NULL
    check (valor>0 and valor<1),
    descripción   VARCHAR2(15)
);

ALTER TABLE promoción ADD CONSTRAINT promoción_pk PRIMARY KEY ( código );

CREATE TABLE promocion_cliente (
    promoción_código   VARCHAR2(5) NOT NULL,
    cliente_doc        VARCHAR2(10) NOT NULL,
    cliente_td         VARCHAR2(4) NOT NULL
);

ALTER TABLE promocion_cliente
    ADD CONSTRAINT promocion_cliente_pk PRIMARY KEY ( promoción_código,
                                                      cliente_doc,
                                                      cliente_td );

CREATE TABLE reserva (
    hora                TIMESTAMP NOT NULL,
    fecha               DATE NOT NULL,
    estado              VARCHAR2(12) NOT NULL check( estado in ('Pago','Cancel','Activa')),
    cliente_doc         VARCHAR2(10) NOT NULL,
    plazo_cancelación   TIMESTAMP NOT NULL check(plazo_cancelación>hora),
    cliente_td          VARCHAR2(4) NOT NULL
);

ALTER TABLE reserva
    ADD CONSTRAINT reserva_pk PRIMARY KEY ( cliente_doc,
                                            cliente_td,
                                            hora );

CREATE TABLE sala (
    número              NUMBER(2) NOT NULL check(número>0),
    cantidad_asientos   NUMBER(3) NOT NULL check (cantidad_asientos)),
    tipo                VARCHAR2(8) NOT NULL,
    sucursal_cod        VARCHAR2(5) NOT NULL
);

ALTER TABLE sala ADD CONSTRAINT sala_pk PRIMARY KEY ( número,
                                                      sucursal_cod );

CREATE TABLE sucursal (
    código      VARCHAR2(5) NOT NULL,
    nombre      VARCHAR2(20) NOT NULL,
    dirección   VARCHAR2(15) NOT NULL
);

ALTER TABLE sucursal ADD CONSTRAINT sucursal_pk PRIMARY KEY ( código );

CREATE TABLE suscripción (
    inicio        DATE NOT NULL,
    fin           DATE NOT NULL check(fin>inicio),
    cliente_doc   VARCHAR2(10) NOT NULL,
    cliente_td    VARCHAR2(4) NOT NULL
);

ALTER TABLE suscripción ADD CONSTRAINT suscripción_pk PRIMARY KEY ( inicio,cliente_doc,
                                                                    cliente_td );

CREATE TABLE taquilla (
    número         NUMBER(2) NOT NULL,
    sucursal_cod   VARCHAR2(5) NOT NULL
);

ALTER TABLE taquilla ADD CONSTRAINT taquilla_pk PRIMARY KEY ( número,
                                                              sucursal_cod );

CREATE TABLE tipo_asiento (
    código        VARCHAR2(3) NOT NULL,
    descripción   VARCHAR2(10) NOT NULL
);

ALTER TABLE tipo_asiento ADD CONSTRAINT tipo_asiento_pk PRIMARY KEY ( código );

CREATE TABLE tipo_documento (
    código        VARCHAR2(4) NOT NULL,
    descripción   VARCHAR2(5) NOT NULL
);

ALTER TABLE tipo_documento ADD CONSTRAINT tipo_documento_pk PRIMARY KEY ( código );

ALTER TABLE asiento_función
    ADD CONSTRAINT asiento_función_asiento_fk FOREIGN KEY ( asiento_num,
                                                            asiento_letra,
                                                            f_sala_num,
                                                            f_sucursal_cod )
        REFERENCES asiento ( número,
                             letra,
                             sala_num,
                             s_sucursal_cod );

ALTER TABLE asiento_función
    ADD CONSTRAINT asiento_función_función_fk FOREIGN KEY ( función_hora_inicio,
                                                            función_fecha,
                                                            f_sala_num,
                                                            f_sucursal_cod,
                                                            f_pf_pelicula_cod,
                                                            f_pf_formato_cod )
        REFERENCES función ( hora_inicio,
                             fecha,
                             sala_num,
                             s_sucursal_cod,
                             pf_pelicula_cod,
                             pf_formato_cod );

ALTER TABLE asiento_función
    ADD CONSTRAINT asiento_función_reserva_fk FOREIGN KEY ( r_cliente_doc,
                                                            r_cliente_td,
                                                            reserva_hora )
        REFERENCES reserva ( cliente_doc,
                             cliente_td,
                             hora );

ALTER TABLE asiento
    ADD CONSTRAINT asiento_sala_fk FOREIGN KEY ( sala_num,
                                                 s_sucursal_cod )
        REFERENCES sala ( número,
                          sucursal_cod );

ALTER TABLE asiento
    ADD CONSTRAINT asiento_tipo_asiento_fk FOREIGN KEY ( ta_cod )
        REFERENCES tipo_asiento ( código );

ALTER TABLE boleta
    ADD CONSTRAINT boleta_asiento_función_fk FOREIGN KEY ( af_función_hora_inicio,
                                                           af_función_fecha,
                                                           af_f_sala_número,
                                                           af_s_sucursal_cod,
                                                           af_pf_pelicula_cod,
                                                           af_pf_formato_cod,
                                                           af_asiento_num,
                                                           af_asiento_letra )
        REFERENCES asiento_función ( función_hora_inicio,
                                     función_fecha,
                                     f_sala_num,
                                     f_sucursal_cod,
                                     f_pf_pelicula_cod,
                                     f_pf_formato_cod,
                                     asiento_num,
                                     asiento_letra );

ALTER TABLE boleta
    ADD CONSTRAINT boleta_promocion_cliente_fk FOREIGN KEY ( pc_promoción_cod,
                                                             pc_cliente_doc,
                                                             pc_cliente_td )
        REFERENCES promocion_cliente ( promoción_código,
                                       cliente_doc,
                                       cliente_td );

ALTER TABLE boleta
    ADD CONSTRAINT boleta_taquilla_fk FOREIGN KEY ( taquilla_num,
                                                    t_sucursal_cod )
        REFERENCES taquilla ( número,
                              sucursal_cod );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_tipo_documento_fk FOREIGN KEY ( tipo_doc )
        REFERENCES tipo_documento ( código );

ALTER TABLE cuenta
    ADD CONSTRAINT cuenta_cliente_fk FOREIGN KEY ( cliente_documento,
                                                   cliente_td )
        REFERENCES cliente ( documento,
                             tipo_doc );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_cargo_fk FOREIGN KEY ( cargo_cod )
        REFERENCES cargo ( código );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_empleado_fk FOREIGN KEY ( jefe_código )
        REFERENCES empleado ( código );

ALTER TABLE empleado_sala
    ADD CONSTRAINT empleado_sala_empleado_fk FOREIGN KEY ( empleado_código )
        REFERENCES empleado ( código );

ALTER TABLE empleado_sala
    ADD CONSTRAINT empleado_sala_sala_fk FOREIGN KEY ( sala_número,
                                                       sala_sucursal_código )
        REFERENCES sala ( número,
                          sucursal_cod );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_sucursal_fk FOREIGN KEY ( sucursal_cod )
        REFERENCES sucursal ( código );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_tipo_documento_fk FOREIGN KEY ( tipo_doc )
        REFERENCES tipo_documento ( código );

ALTER TABLE empleados_taquilla
    ADD CONSTRAINT empleados_taquilla_empleado_fk FOREIGN KEY ( empleado_cod )
        REFERENCES empleado ( código );

ALTER TABLE empleados_taquilla
    ADD CONSTRAINT empleados_taquilla_taquilla_fk FOREIGN KEY ( taquilla_num,
                                                                t_sucursal_cod )
        REFERENCES taquilla ( número,
                              sucursal_cod );

ALTER TABLE evento
    ADD CONSTRAINT evento_cliente_fk FOREIGN KEY ( cliente_doc,
                                                   cliente_td )
        REFERENCES cliente ( documento,
                             tipo_doc );

ALTER TABLE evento
    ADD CONSTRAINT evento_película_formato_fk FOREIGN KEY ( pf_pelicula_cod,
                                                            pf_formato_cod )
        REFERENCES película_formato ( pelicula_cod,
                                      formato_cod );

ALTER TABLE evento
    ADD CONSTRAINT evento_sala_fk FOREIGN KEY ( sala_num,
                                                s_sucursal_cod )
        REFERENCES sala ( número,
                          sucursal_cod );

ALTER TABLE función
    ADD CONSTRAINT función_empleado_fk FOREIGN KEY ( empleado_cod )
        REFERENCES empleado ( código );

ALTER TABLE función
    ADD CONSTRAINT función_película_formato_fk FOREIGN KEY ( pf_pelicula_cod,
                                                             pf_formato_cod )
        REFERENCES película_formato ( pelicula_cod,
                                      formato_cod );

ALTER TABLE función
    ADD CONSTRAINT función_sala_fk FOREIGN KEY ( sala_num,
                                                 s_sucursal_cod )
        REFERENCES sala ( número,
                          sucursal_cod );

ALTER TABLE genero_película
    ADD CONSTRAINT gen_pel_género_fk FOREIGN KEY ( género_cod )
        REFERENCES género ( código );

ALTER TABLE genero_película
    ADD CONSTRAINT gen_pel_pelicula_fk FOREIGN KEY ( pelicula_cod )
        REFERENCES pelicula ( código );

ALTER TABLE película_formato
    ADD CONSTRAINT película_formato_formato_fk FOREIGN KEY ( formato_cod )
        REFERENCES formato ( código );

ALTER TABLE película_formato
    ADD CONSTRAINT película_formato_pelicula_fk FOREIGN KEY ( pelicula_cod )
        REFERENCES pelicula ( código );

ALTER TABLE pelicula
    ADD CONSTRAINT pelicula_productora_fk FOREIGN KEY ( productor_cod )
        REFERENCES productora ( código );

ALTER TABLE promocion_cliente
    ADD CONSTRAINT promocion_cliente_cliente_fk FOREIGN KEY ( cliente_doc,
                                                              cliente_td )
        REFERENCES cliente ( documento,
                             tipo_doc );

ALTER TABLE promocion_cliente
    ADD CONSTRAINT promocion_cliente_promoción_fk FOREIGN KEY ( promoción_código )
        REFERENCES promoción ( código );

ALTER TABLE reserva
    ADD CONSTRAINT reserva_cliente_fk FOREIGN KEY ( cliente_doc,
                                                    cliente_td )
        REFERENCES cliente ( documento,
                             tipo_doc );

ALTER TABLE sala
    ADD CONSTRAINT sala_sucursal_fk FOREIGN KEY ( sucursal_cod )
        REFERENCES sucursal ( código );

ALTER TABLE suscripción
    ADD CONSTRAINT suscripción_cliente_fk FOREIGN KEY ( cliente_doc,
                                                        cliente_td )
        REFERENCES cliente ( documento,
                             tipo_doc );

ALTER TABLE taquilla
    ADD CONSTRAINT taquilla_sucursal_fk FOREIGN KEY ( sucursal_cod )
        REFERENCES sucursal ( código );
