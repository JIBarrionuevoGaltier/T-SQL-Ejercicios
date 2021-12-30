--Create Login
USE master
GO
CREATE LOGIN Academia WITH PASSWORD = '123456';

--Crear los usuarios para el login
USE jardineria
GO
CREATE USER Pepito FOR LOGIN Academia WITH DEFAULT_SCHEMA = Academia_Sch;
GO

--Asociar Esquema al usuario
CREATE SCHEMA Academia_Sch AUTHORIZATION Pepito;
GO
--Otra forma
ALTER AUTHORIZATION ON SCHEMA::Academia_Sch TO Pepito2;

--Dar permisos a Pepito sobre el esquema de dbo
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO Pepito;

--Otorgar Roles o Permisos a un usuario en específico
GRANT CREATE TABLE TO Pepito;	--Pepito tiene permisos para crear tablas
GO
GRANT CREATE VIEW TO Pepito;	--Pepito tiene permisos para crear vistas
GO

--Otorgar todos los privilegios (mirar documentación)
GRANT ALL PRIVILEGES TO Pepito;

--Crear Roles
CREATE ROLE profesor;	--Paso 1: Crear el rol
GO
GRANT CREATE TABLE TO profesor;	--Paso 2: Otorgar permisos al rol
GO
ALTER ROLE profesor ADD MEMBER Pepito;	--Paso 3: Incluir a Pepito dentro del grupo de roles del profesor
GO
--Borrar ROL
EXECUTE sp_droprolemember profesor, Pepito; -- Borrar miembros
DROP ROLE profesor;	--Extra: Se borra un rol (NO SE BORRA EL USUARIO, solo se quita el miembro)
GO

--Heredar ROLES
ALTER ROLE db_datareader ADD MEMBER Ben;  
GO