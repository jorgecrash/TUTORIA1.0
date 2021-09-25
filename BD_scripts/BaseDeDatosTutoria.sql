/* ********************************************************************
      CREACION DE LA BASE DE DATOS TUTORIAS
 ******************************************************************** */
USE MASTER
GO
IF EXISTS (SELECT * FROM SYSDATABASES WHERE NAME = 'Tutorias')
BEGIN
	DROP DATABASE Tutorias
END
GO
CREATE DATABASE Tutorias
GO
USE Tutorias
GO
-- ************************************************TABLA DOCENTE************************************************************
create table Docente(
	IdDocente varchar(10),
	Nombres varchar(30),
	Apellidos varchar(30),
	TituloAcademico varchar (70),
	Facultad varchar(90),
	EscuelaProfesional varchar(70),
	Categoria varchar (60),
	PRIMARY KEY (IdDocente)
);
go
---------------------
---Procedimientos almacenados para Docente

CREATE PROC SP_BUSCARDOCENTE
@BUSCAR varchar(20)
as
select * from Docente
where Nombres like @BUSCAR + '%' or  Apellidos like @BUSCAR + '%' or  Categoria like @BUSCAR + '%' or  EscuelaProfesional like @BUSCAR + '%'
go
---Stored Procedures for insert Docente

create proc SP_INSERTARDOCENTE
@IDDOCENTE varchar(10),
@NOMBRES varchar(30),
@APELLIDOS varchar(30),
@TITULO varchar(70),
@FACULTAD varchar(90),
@EPROFESIONAL varchar(70),
@CATEGORIA varchar (60)
as
insert into Docente values(@IDDOCENTE,@NOMBRES,@APELLIDOS,@TITULO,@FACULTAD,@EPROFESIONAL,@CATEGORIA)
go
------- Stored Procedures for update Docente

create proc SP_EDITARDOCENTE
@IDDOCENTE varchar(10),
@NOMBRES varchar(30),
@APELLIDOS varchar(30),
@TITULO varchar(70),
@FACULTAD varchar(90),
@EPROFESIONAL varchar(70),
@CATEGORIA varchar (60)
as 
update Docente set Nombres=@NOMBRES,Apellidos=@APELLIDOS,TituloAcademico=@TITULO,Facultad=@FACULTAD,EscuelaProfesional=@EPROFESIONAL,Categoria=@CATEGORIA
where IdDocente =@IDDOCENTE
go
---------Stored Procedures for delete docente
create proc SP_ELIMINARDOCENTE
@IDDOCENTE varchar(10)
as
delete Docente
where IdDocente=@IDDOCENTE
go
------Stored Procedured for listing Docente (Listar Docente)
create proc SP_LISTARDOCENTE
as
select top 100 
Docente.IdDocente,
Docente.Nombres,
Docente.Apellidos,
Docente.TituloAcademico,
Docente.Facultad,
Docente.EscuelaProfesional,
Docente.Categoria
from Docente
order by IdDocente asc
go

-- *************************************************TABLA ESTUDIANTE****************************************************
create table Estudiante(
	IdEstudiante varchar(10),
	Nombres varchar(100),
	Apellidos varchar(100),
	SemestreActivo varchar(20),
	EscuelaProfesional varchar (100),
	codigoEP varchar(50),
	AIngreso varchar(20),
	PRIMARY KEY (IdEstudiante)
);
go
--Procedimiento insertar Estudiante
create proc SP_INSERTARESTUDIANTE
@IDESTUDIANTE varchar(10),
@NOMBRES varchar(100),
@APELLIDOS varchar(100),
@ESCUELAPROFESIONAL varchar(100),
@SEMESTREACTIVO varchar(20),
@CODIGOEP varchar(50),
@AINGRESO varchar(120)
as 
insert into Estudiante values (@IDESTUDIANTE,@NOMBRES,@APELLIDOS,@SEMESTREACTIVO,@ESCUELAPROFESIONAL,@CODIGOEP,@AINGRESO)
GO
--Procedimiento Editar Estudiante
create proc SP_EDITARESTUDIANTE
@IDESTUDIANTE varchar(10),
@NOMBRES varchar(100),
@APELLIDOS varchar(100),
@ESCUELAPROFESIONAL varchar(100),
@SEMESTREACTIVO varchar(20),
@CODIGOEP varchar(50),
@AINGRESO varchar(120)
as 
update Estudiante set Nombres=@NOMBRES,Apellidos=@APELLIDOS,SemestreActivo=@SemestreActivo, EscuelaProfesional=@ESCUELAPROFESIONAL,codigoEP=@CODIGOEP,
AIngreso=@AINGRESO
where IdEstudiante =@IDESTUDIANTE
GO
--Procedimiento eliminar estudiante
CREATE PROC SP_ELIMINARESTUDIANTE
@IDESTUDIANTE varchar(10)
as 
delete Estudiante
Where IDEstudiante =@IDESTUDIANTE
go
--Procedimiento Listar Docente

create proc SP_LISTARESTUDIANTE
as
select IdEstudiante, Nombres,Apellidos,SemestreActivo,EscuelaProfesional,codigoEP,AIngreso from Estudiante

go
--Procedimiento Buscar estudiante
create proc SP_BUSCARESTUDIANTE
@BUSCAR nvarchar(20)
as
select IdEstudiante ,Nombres,Apellidos,SemestreActivo,EscuelaProfesional,codigoEP,AIngreso
from Estudiante
where Nombres like @BUSCAR + '%' or Apellidos like @BUSCAR + '%' or codigoEP like @BUSCAR + '%' or AIngreso like @BUSCAR + '%' or EscuelaProfesional like @BUSCAR + '%'
go
--
--*************************************************TABLA LOGINS***********************************************************

create table Logins(
	Usuario varchar(40) not null,
	Contraseña varchar(40) not null,
	CategoriaLogin varchar (40),
	IdDocente varchar(10) ,
	primary key(IdDocente),
	FOREIGN KEY (IdDocente) REFERENCES Docente(IdDocente) ON DELETE CASCADE ON UPDATE CASCADE
);
go

--*************************************************TABLA TUTORIA***********************************************************
go
create table Tutoria(
	IdTutoria varchar(10) ,
	IdDocente varchar(10),
	Horario varchar(200),
	PRIMARY KEY (IdTutoria),
	FOREIGN KEY (IdDocente) REFERENCES Docente(IdDocente) ON DELETE CASCADE ON UPDATE CASCADE
);
go

--------------------------------------------
----Stored Procedures for search Tutoria

CREATE PROC SP_BUSCARTUTORIA
@BUSCAR varchar(30)
as
select IdTutoria, T.IdDocente, Nombres, Apellidos, Horario
from Tutoria T inner join Docente D 
ON T.IdDocente = D.IdDocente
where Nombres like @BUSCAR + '%' or Apellidos like @BUSCAR + '%' or  Horario like @BUSCAR +'%'or  IdTutoria like @BUSCAR +'%' or  T.IdDocente like @BUSCAR +'%'

select top 100 IdTutoria, T.IdDocente, Nombres, Apellidos, Horario
from Tutoria T inner join Docente D 
ON T.IdDocente = D.IdDocente
order by IdTutoria asc
go
---PROCEDIMIENTO ALMACENADO INSERTAR TUTORIA
create proc SP_INSERTARTUTORIA
@IDTUTORIA varchar(10),
@IDDOCENTE varchar(10),
@HORARIO varchar(200)
as 
insert into Tutoria values (@IDTUTORIA,@IDDOCENTE,@HORARIO)
go

---PROCEDIMIENTO ALMACENADO EDITAR TUTORIA

create proc SP_EDITARTUTORIA
@IDTUTORIA varchar(10),
@IDDOCENTE varchar(10),
@HORARIO varchar(200)
as 
update Tutoria set IdDocente=@IDDOCENTE, Horario = @HORARIO
where IdTutoria =@IDTUTORIA
go
---PROCEDIMIENTO ALMACENADO ELiminar TUTORIA
CREATE PROC SP_ELIMINARTUTORIA
@IDTUTORIA varchar(10)
as 
delete Tutoria
Where IdTutoria=@IDTUTORIA
go
----PROCEDIMIENTO ALMACENADO LISTAR  TUTORIAS

create proc SP_LISTARTUTORIA
as
select top 100 IdTutoria,T.IdDocente, Nombres, Apellidos, Horario
from Tutoria T inner join Docente D 
ON T.IdDocente = D.IdDocente
order by IdTutoria asc
go


--*************************************************TABLA REGISTRO***********************************************************

create table Registro(
	IdTutoria varchar(10),
	IdEstudiante varchar(10),
	PRIMARY KEY (IdTutoria, IdEstudiante),
	FOREIGN KEY (IdTutoria) REFERENCES Tutoria(IdTutoria) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (IdEstudiante) REFERENCES Estudiante(IdEstudiante) ON DELETE CASCADE ON UPDATE CASCADE
);
go
---PROCEDIMIENTO ALMACENADO BUSCARTUTORADO

CREATE PROC SP_BUSCARTUTORADO
@BUSCAR varchar(50)
as
select top 100 R.IdTutoria,D.Nombres, R.IdEstudiante, E.Nombres, E.Apellidos, 
	SemestreActivo, AIngreso, E.EscuelaProfesional, CodigoEP
	from Registro R inner join Estudiante E 
	ON R.IdEstudiante = E.IdEstudiante inner join Tutoria T on R.IdTutoria=T.IdTutoria
	inner join Docente D on T.IdDocente= D.IdDocente
	where E.Nombres like @BUSCAR + '%' or E.Apellidos like @BUSCAR + '%' or D.Nombres like @BUSCAR + '%'
	order by R.IdTutoria asc
go
---PROCEDIMIENTO ALMACENADO INSERTAR TUTORADO
create proc SP_INSERTARTUTORADO
@IDTUTORIA varchar(10),
@IDESTUDIANTE varchar(10)
as 
insert into Registro values (@IDTUTORIA, @IDESTUDIANTE)
go
---PROCEDIMIENTO ALMACENADO EDITARESTUDIANTE

create proc SP_EDITARTUTORADO
@IDTUTORIA varchar(10),
@IDESTUDIANTE varchar(10)
as 
update Registro set IdTutoria=@IDTUTORIA
where IdEstudiante =@IDESTUDIANTE
go

---PROCEDIMIENTO ALMACENADO ELiminarESTUDIANTE
CREATE PROC SP_ELIMINARTUTORADO
@IDESTUDIANTE varchar(10)
as 
delete Registro
Where IdEstudiante=@IDESTUDIANTE
go


----Listing Student
create proc SP_LISTARTUTORADO
as
select top 100 R.IdTutoria,D.Nombres, R.IdEstudiante, E.Nombres, E.Apellidos, 
	SemestreActivo, AIngreso, E.EscuelaProfesional, CodigoEP
	from Registro R inner join Estudiante E 
	ON R.IdEstudiante = E.IdEstudiante inner join Tutoria T on R.IdTutoria=T.IdTutoria
	inner join Docente D on T.IdDocente= D.IdDocente
	order by R.IdTutoria asc
go

-- --*************************************************TABLA REGISTROFICHA***********************************************************

create table RegistroFicha(
	IdFichaTutoria varchar(10),
	IdTutoria varchar(10),
	IdEstudiante varchar(10),
	NroCelular varchar(10),
	Direccion varchar(1000),
	Email varchar(50),
	PersonaReferencia varchar(100),
	CelularReferencia varchar(10),
	Fecha date,
	TipoTutoria varchar(20),
	Descripcion varchar(1000),
	PRIMARY KEY (IdFichaTutoria),
	FOREIGN KEY (IdTutoria, IdEstudiante) REFERENCES Registro(IdTutoria, IdEstudiante) ON DELETE CASCADE ON UPDATE CASCADE
);
go
--------------------------------------------
---PROCEDIMIENTO ALMACENADO BUSCARFICHA

CREATE PROC SP_BUSCARFICHA
@BUSCAR varchar(20)
as
select T.IdTutoria, R.IdEstudiante, E.Nombres, E.Apellidos, NroCelular, Direccion, 
	Email, PersonaReferencia, CelularReferencia, Fecha, TipoTutoria, Descripcion
	from RegistroFicha R INNER JOIN Estudiante E
	ON R.IdEstudiante = E.IdEstudiante inner join Tutoria T on R.IdTutoria=T.IdTutoria
	inner join Docente D on T.IdDocente= D.IdDocente inner join Logins L on D.IdDocente=L.IdDocente
	where E.Nombres like @BUSCAR + '%' or E.Apellidos like @BUSCAR + '%'
	order by IdFichaTutoria asc
go
---PROCEDIMIENTO ALMACENADO INSERTAR FICHA
create proc SP_INSERTARFICHA
@IDFICHATUTORIA varchar(10),
@IDTUTORIA varchar(10),
@IDESTUDIANTE varchar(10),
@NROCELULAR varchar(10),
@DIRECCION varchar(1000),
@EMAIL varchar(50),
@PERSONAREFERENCIA varchar(100),
@CELULARREFERENCIA varchar(10),
@FECHA date,
@TIPOTUTORIA varchar(10),
@DESCRIPCION varchar(1000)
as 
insert into RegistroFicha values (@IDFICHATUTORIA ,@IDTUTORIA, @IDESTUDIANTE, @NROCELULAR, @DIRECCION, @EMAIL, 
									@PERSONAREFERENCIA, @CELULARREFERENCIA, @FECHA, @TIPOTUTORIA, @DESCRIPCION)

go
---PROCEDIMIENTO ALMACENADO EDITAR FICHA

create proc SP_EDITARFICHA
@IDFICHATUTORIA varchar(10),
@IDTUTORIA varchar(10),
@IDESTUDIANTE varchar(10),
@NROCELULAR varchar(10),
@DIRECCION varchar(1000),
@EMAIL varchar(50),
@PERSONAREFERENCIA varchar(100),
@CELULARREFERENCIA varchar(10),
@FECHA date,
@TIPOTUTORIA varchar(10),
@DESCRIPCION varchar(1000)
as 
update RegistroFicha set IdTutoria = @IDTUTORIA, IdEstudiante = @IDESTUDIANTE, NroCelular = @NROCELULAR,
					Direccion = @DIRECCION, Email = @EMAIL, PersonaReferencia = @PERSONAREFERENCIA,
					CelularReferencia = @CELULARREFERENCIA, Fecha = @FECHA, TipoTutoria = @TIPOTUTORIA, Descripcion = @DESCRIPCION
where IdFichaTutoria =@IDFICHATUTORIA
go
---PROCEDIMIENTO ALMACENADO ELiminar Ficha
CREATE PROC SP_ELIMINARFICHA
@IDFICHATUTORIA varchar(10)
as 
delete RegistroFicha
Where IdFichaTutoria = @IDFICHATUTORIA
go
---Listar ficha
--drop proc SP_LISTARFICHA
go
create proc SP_LISTARFICHA
@USUARIO varchar(40)
as
select R.IdFichaTutoria,R.IdTutoria, R.IdEstudiante, E.Nombres, E.Apellidos, NroCelular, Direccion, 
	Email, PersonaReferencia, CelularReferencia, Fecha, TipoTutoria, Descripcion
	from RegistroFicha R INNER JOIN Estudiante E
	ON R.IdEstudiante = E.IdEstudiante inner join Tutoria T on R.IdTutoria=T.IdTutoria
	inner join Docente D on T.IdDocente= D.IdDocente inner join Logins L on D.IdDocente=L.IdDocente
	where L.Usuario=@USUARIO
	order by IdFichaTutoria asc
go

-- ***************************************PROCEDIMIENTOS ALMACENADOS EXTRAS ***********************************************************
create proc SP_ListarDocenteTutoria
as
select IdDocente,Apellidos,Nombres from Docente
go
CREATE PROC SP_BuscarDocenteTutoria
@BUSCAR varchar(20)
as
select IdDocente,Apellidos,Nombres
	from Docente
	where Nombres like @BUSCAR + '%'or Apellidos like @BUSCAR + '%'

-- 
GO
create proc SP_LISTAREGISTROESTUDIANTETUTORIA
as
select IdEstudiante, Apellidos + ' , ' + Nombres AS NOMBRES from Estudiante
go
create proc SP_LISTAREGISTRODOCENTETUTORIA
as
	select Tu.IdTutoria, D.Apellidos + ' , ' + D.Nombres as Tutor , Tu.Horario from Tutoria Tu inner join Docente D on Tu.IdDocente=D.IdDocente 
go
-- buscar
CREATE PROC SP_BUSCAR_REGISTRO_TUTOR
@BUSCAR varchar(20)
as
	select Tu.IdTutoria, D.Apellidos + ' , ' + D.Nombres as Tutor , Tu.Horario
	from Tutoria Tu inner join Docente D on Tu.IdDocente=D.IdDocente 
	where D.Apellidos like @BUSCAR + '%' or D.Nombres like @BUSCAR + '%'

go
CREATE PROC SP_BUSCAR_REGISTRO_ESTUDIANTE
@BUSCAR varchar(20)
as
	select IdEstudiante, Apellidos + ' , ' + Nombres AS NOMBRES
	from Estudiante
	where Apellidos like @BUSCAR + '%' or  Nombres like @BUSCAR + '%'

GO
-- procedimiento para buscar estudiante y su tutoria
CREATE PROC SP_LISTAR_ESTUDIANTE_TUTORIA
@USUARIO varchar(20)
as
select T.IdTutoria, R.IdEstudiante, E.Apellidos, E.Nombres
	from RegistroFicha R INNER JOIN Estudiante E
	ON R.IdEstudiante = E.IdEstudiante inner join Tutoria T on R.IdTutoria=T.IdTutoria
	inner join Docente D on T.IdDocente= D.IdDocente inner join Logins L on D.IdDocente=L.IdDocente
	where L.Usuario=@USUARIO
	order by IdFichaTutoria asc

GO

CREATE PROC SP_BUSCAR_ESTUDIANTE_TUTORIA
@BUSCAR varchar(20),
@USUARIO varchar(40)	
as
select T.IdTutoria, R.IdEstudiante, E.Apellidos, E.Nombres
	from RegistroFicha R INNER JOIN Estudiante E
	ON R.IdEstudiante = E.IdEstudiante inner join Tutoria T on R.IdTutoria=T.IdTutoria
	inner join Docente D on T.IdDocente= D.IdDocente inner join Logins L on D.IdDocente=L.IdDocente
	where (L.Usuario=@USUARIO) and (E.Apellidos like @BUSCAR + '%' or E.Nombres like @BUSCAR + '%')  
	order by IdFichaTutoria asc
select * from Logins

--procedimiento para listar las tutorias de un estudiante 
go
CREATE PROC SP_HISTORIAL_ESTUDIANTE_TUTORIA
@IDESTUDIANTE varchar(10)
as
	select TipoTutoria ,Fecha, Descripcion
		from RegistroFicha
		where IdEstudiante=@IDESTUDIANTE


go
-- procedimiento para generar codigo
CREATE FUNCTION NuevoDocente()
RETURNS varchar(5)
AS
BEGIN
	declare @Codigo varchar(5)
	
	set @Codigo=((select MAX(IdDocente)  from Docente))
	set @Codigo='D' + RIGHT('0000' + LTRIM(right(isnull(@Codigo,'0000'),4)+1 ),4)
   RETURN (@codigo)
END
go

--NUEVO PARA FICHA TUTORIA

CREATE FUNCTION NuevoFichaTutoria()
RETURNS varchar(10)
AS
begin
	declare @Codigo varchar(6)
	
	set @Codigo=((select MAX(IdFichaTutoria)  from RegistroFicha))
	set @Codigo='RF' + RIGHT('0000' + LTRIM(right(isnull(@Codigo,'0000'),4)+1 ),4)
    RETURN (@codigo)
end 


go
CREATE FUNCTION NuevoTutoria()
RETURNS varchar(10)
AS
begin
	declare @Codigo varchar(6)
	
	set @Codigo=((select MAX(IdTutoria)  from Tutoria))
	set @Codigo='TU' + RIGHT('0000' + LTRIM(right(isnull(@Codigo,'0000'),4)+1 ),4)
    RETURN (@codigo)
end 
go

select * from Docente
