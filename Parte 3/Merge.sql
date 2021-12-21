CREATE TABLE empleadoActual (
  codigo_empleado INTEGER NOT NULL,
  nombre VARCHAR(50) NOT NULL,
  apellido1 VARCHAR(50) NOT NULL,
  apellido2 VARCHAR(50) DEFAULT NULL,
  extension VARCHAR(10) NOT NULL,
  email VARCHAR(100) NOT NULL,
  codigo_oficina VARCHAR(10) NOT NULL,
  codigo_jefe INTEGER DEFAULT NULL,
  puesto VARCHAR(50) DEFAULT NULL,
  PRIMARY KEY (codigo_empleado)
);


INSERT INTO empleadoActual VALUES (1,'Marcos','Magaña','Perez','3897','marcos@jardineria.es','TAL-ES',NULL,'Director General');
INSERT INTO empleadoActual VALUES (2,'Ruben','López','Martinez','2899','rlopez@jardineria.es','TAL-ES',1,'Subdirector Marketing');
INSERT INTO empleadoActual VALUES (3,'Alberto','Soria','Carrasco','2837','asoria@jardineria.es','TAL-ES',2,'Subdirector Ventas');
INSERT INTO empleadoActual VALUES (4,'Maria','Solís','Jerez','2847','msolis@jardineria.es','TAL-ES',2,'Secretaria');
INSERT INTO empleadoActual VALUES (5,'Felipe','Rosas','Marquez','2844','frosas@jardineria.es','TAL-ES',3,'Representante Ventas');
INSERT INTO empleadoActual VALUES (6,'Juan Carlos','Ortiz','Serrano','2845','cortiz@jardineria.es','TAL-ES',3,'Representante Ventas');
INSERT INTO empleadoActual VALUES (7,'Carlos','Soria','Jimenez','2444','csoria@jardineria.es','MAD-ES',3,'Director Oficina');
INSERT INTO empleadoActual VALUES (8,'Mariano','López','Murcia','2442','mlopez@jardineria.es','MAD-ES',7,'Representante Ventas');
INSERT INTO empleadoActual VALUES (9,'Lucio','Campoamor','Martín','2442','lcampoamor@jardineria.es','MAD-ES',7,'Representante Ventas');
INSERT INTO empleadoActual VALUES (10,'Hilario','Rodriguez','Huertas','2444','hrodriguez@jardineria.es','MAD-ES',7,'Representante Ventas');
INSERT INTO empleadoActual VALUES (11,'Emmanuel','Magaña','Perez','2518','manu@jardineria.es','BCN-ES',3,'Director Oficina');
INSERT INTO empleadoActual VALUES (12,'José Manuel','Martinez','De la Osa','2519','jmmart@hotmail.es','BCN-ES',11,'Representante Ventas');
INSERT INTO empleadoActual VALUES (13,'David','Palma','Aceituno','2519','dpalma@jardineria.es','BCN-ES',11,'Representante Ventas');
INSERT INTO empleadoActual VALUES (14,'Oscar','Palma','Aceituno','2519','opalma@jardineria.es','BCN-ES',11,'Representante Ventas');
INSERT INTO empleadoActual VALUES (19,'Walter Santiago','Sanchez','Lopez','7454','wssanchez@gardening.com','SFC-USA',18,'Representante Ventas');
INSERT INTO empleadoActual VALUES (20,'Hilary','Washington','','7565','hwashington@gardening.com','BOS-USA',3,'Director Oficina');
INSERT INTO empleadoActual VALUES (21,'Marcus','Paxton','','7565','mpaxton@gardening.com','BOS-USA',20,'Representante Ventas');
INSERT INTO empleadoActual VALUES (22,'Lorena','Paxton','','7665','lpaxton@gardening.com','BOS-USA',20,'Representante Ventas');
INSERT INTO empleadoActual VALUES (23,'Nei','Nishikori','','8734','nnishikori@gardening.com','TOK-JP',3,'Director Oficina');
INSERT INTO empleadoActual VALUES (24,'Narumi','Riko','','8734','nriko@gardening.com','TOK-JP',23,'Representante Ventas');
INSERT INTO empleadoActual VALUES (25,'Takuma','Nomura','','8735','tnomura@gardening.com','TOK-JP',23,'Representante Ventas');
INSERT INTO empleadoActual VALUES (26,'Amy','Johnson','','3321','ajohnson@gardening.com','LON-UK',3,'Director Oficina');
INSERT INTO empleadoActual VALUES (27,'Larry','Westfalls','','3322','lwestfalls@gardening.com','LON-UK',26,'Representante Ventas');
INSERT INTO empleadoActual VALUES (28,'John','Walton','','3322','jwalton@gardening.com','LON-UK',26,'Representante Ventas');
INSERT INTO empleadoActual VALUES (29,'Kevin','Fallmer','','3210','kfalmer@gardening.com','SYD-AU',3,'Director Oficina');
INSERT INTO empleadoActual VALUES (30,'Julian','Bellinelli','','3211','jbellinelli@gardening.com','SYD-AU',29,'Representante Ventas');
INSERT INTO empleadoActual VALUES (31,'Mariko','Kishi','','3211','mkishi@gardening.com','SYD-AU',29,'Representante Ventas');
INSERT INTO empleadoActual VALUES (32,'Juan','Perez','','8735','jperez@gardening.com','LON-UK',30,'Representante Ventas');
INSERT INTO empleadoActual VALUES (33,'Pablo','Nardon','','3322','pnardon@gardening.com','BCN-ES',30,'Representante Ventas');
INSERT INTO empleadoActual VALUES (34,'Pedro','Melo','','2444','pmelo@gardening.com','MAD-ES',30,'Representante Ventas');


SELECT * FROM empleado;
SELECT * FROM empleadoActual;





--Sincronizar la tabla TARGET con
--los datos actuales de la tabla SOURCE
MERGE empleado AS TARGET
USING empleadoActual AS SOURCE 
   ON (TARGET.codigo_empleado = SOURCE.codigo_empleado) 
--Cuandos los registros concuerdan con por la llave
--se actualizan los registros si tienen alguna variación
 WHEN MATCHED AND TARGET.nombre <> SOURCE.nombre 
   OR TARGET.codigo_oficina <> SOURCE.codigo_oficina 
   OR TARGET.puesto <> SOURCE.puesto 
   OR TARGET.codigo_jefe <> SOURCE.codigo_jefe THEN 
   UPDATE SET TARGET.nombre = SOURCE.nombre, 
              TARGET.codigo_oficina = SOURCE.codigo_oficina, 
              TARGET.puesto = SOURCE.puesto, 
              TARGET.codigo_jefe = SOURCE.codigo_jefe
--Cuando los registros no concuerdan por la llave
--indica que es un dato nuevo, se inserta el registro
--en la tabla TARGET proveniente de la tabla SOURCE
 WHEN NOT MATCHED BY TARGET THEN 
   INSERT (codigo_empleado, nombre, apellido1 , apellido2, extension, email, codigo_oficina , codigo_jefe, puesto) 
   VALUES (SOURCE.codigo_empleado, SOURCE.nombre, SOURCE.apellido1, SOURCE.apellido2, SOURCE.extension, SOURCE.email, SOURCE.codigo_oficina, SOURCE.codigo_jefe, SOURCE.puesto)
--Cuando el registro existe en TARGET y no existe en SOURCE
--se borra el registro en TARGET
 WHEN NOT MATCHED BY SOURCE THEN 
   DELETE;
 
 
SELECT * FROM empleado;
SELECT * FROM empleadoActual;