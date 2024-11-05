-- creacion de la base de datos y uso de la misma
create database dbGamarraMarket;
use dbGamarraMarket;

-- creacion de tablas
create table cliente (
    id int,
    tipo_documento char(3),
    numero_documento char(9),
    nombres varchar(60),
    apellidos varchar(90),
    email varchar(80),
    celular char(9),
    fecha_nacimiento date,
    activo bool,
    constraint cliente_pk primary key (id)
);

create table venta (
   id int,
   fecha_hora timestamp,
   activo bool,
   cliente_id int,
   vendedor_id int,
   constraint venta_pk primary key (id)
);

create table venta_detalle(
    id int,
    cantidad int,
    venta_id int,
    prenda_id int,
    constraint venta_detalles_pk primary key (id)
);

create table vendedor(
	id int,
    tipo_documento char(3),
    numero_documento char(15),
    nombres varchar(60),
    apellidos varchar(90),
    salario decimal(8,2),
    celular char(9),
    email varchar(80),
    activo bool,
    constraint vendedor_pk primary key (id)
);

create table prenda(
   id int,
   descripcion varchar(90),
   marca varchar(60),
   cantidad int,
   talla varchar(10),
   precio decimal(8,2),
   activo bool,
   constraint prenda_pk primary key (id)
);

-- listar tablas
show tables;
show columns in cliente;
show columns in prenda;
show columns in vendedor;
show columns in venta;
show columns in venta_detalle;

-- creacion de relaciones
alter table venta
   add constraint venta_cliente foreign key (cliente_id)
   references cliente (id)
   on update cascade
   on delete cascade
;

alter table venta
   add constraint venta_vendedor foreign key (vendedor_id)
   references vendedor (id)
   on update cascade
   on delete cascade
;

alter table venta_detalle
   add constraint ventaDetalle_venta foreign key (venta_id)
   references venta (id)
   on update cascade
   on delete cascade
;

alter table venta_detalle
   add constraint ventaDetalle_prenda foreign key (prenda_id)
   references prenda (id)
   on update cascade
   on delete cascade
;

SELECT
    i.constraint_name, 
    k.table_name, 
    k.column_name,
    k.referenced_table_name, 
    k.referenced_column_name 

--listar relaciones
FROM
    information_schema.table_constraints i
LEFT JOIN 
    information_schema.key_column_usage k
ON 
    i.constraint_name = k.constraint_name
WHERE 
    i.constraint_type = 'FOREIGN KEY'
AND 
    i.table_schema = DATABASE();
