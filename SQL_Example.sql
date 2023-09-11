drop database ExamenDataScience2;
Create database ExamenDataScience2;
Use ExamenDataScience2;

-- Crear Tablas
create table Tb_TrackingTarjetas (IdTracking int,
									FechaRegistro datetime,
                                    TipoOpereacion varchar(1),
                                    IdCuenta int,
                                    Columna varchar(30),
                                    ValorAnterior varchar(30),
                                    ValorNuevo varchar(30),
                                    UsuarioDB varchar(30),
                                    IdUsuario varchar(30),
                                    IdTarjeta int
									);

create table Tb_Tarjetas (IdTarjeta int,
							FechaRegistro datetime,
                            FechaActualizacion datetime,
                            Tarjeta varchar(16),
                            Monto numeric(19,2),
                            ConfirmacionWS varchar(100),
                            MontoComision numeric(19,2),
                            ConfirmacionWSComision varchar(200),
                            IdUsuario int,
                            IdRegistraOrden int,
                            Token varchar (200),
                            Activo bit);
                            
Create table Tb_CatEstatus(IdEstatus int,
							Description varchar(30),
							Status bit
							);

create table Tb_RegistraOrden(IdRegistraOrden int,
								FechaRegistro datetime,
                                FechaActualizacion datetime,
                                IdOrden varchar(30),
                                IdUsuario int,
                                IdCuenta int,
                                Empresa varchar(15),
                                ClaveRastreo varchar(30),
                                ConceptoPago varchar(210),
                                Monto numeric (19,2),
                                ReferenciaNumerica varchar(7),
                                Firma varchar(7),
                                IdOperante int,
                                IdTipoCuenta int,
                                IdTipoPago int,
                                IdErrorRegistraOrden int,
                                Token varchar(200),
                                IdEstatus int
								);

create table TB_Beneficiarios (Id int,
								IdCuenta int, 
                                NombreBeneficiario nvarchar(1000),
                                correoElectronico varchar(100),
                                RFC varchar(13),
                                CURP varchar(20),
                                FechaRegistro datetime,
                                FechaActualizacion datetime,
                                Status bit);
                                
create table Tb_Cuentas (IdCuenta int,
							IdClabe varchar(5),
							ClabeInterbancaria varbinary(100),
                            Etiqueta varchar(50),
                            MontoMaximo float,
                            idUsuario int,
                            FechaRegistro datetime,
                            FechaActualizacion datetime,
                            Status bit,
                            HashCuenta varchar(100),
                            TipoCuenta int);

create table Tb_CatClabeBancos (Id int,
								FechaRegistro datetime,
                                FechaActualizacion datetime,
                                IdClabe varchar(5),
                                Participante varchar(30),
                                Status bit);

Create table Tb_CatErrorRegistraOrden(IdErrorRegistraOrden int,
								FechaRegistro datetime,
                                Clave int,
                                Descripcion varchar(80),
                                Status bit);
                                
create table Tb_CatTipoCuenta(IdTipoCuenta int,
								FechaRegistro datetime,
                                Clave int,
                                Descripcion varchar(50),
                                Status bit
								);

create table Tb_CatOperante (IdOperante int,
				CodigoOperante varchar(8));
                
create table Tb_CatTipoPago (IdTipoPago int,
							FechaRegistro datetime,
                            Clave int,
                            Descripcion varchar(5),
                            Status bit);
                            
Create table Tb_TrackingRegistraOrden (IdTracking INTEGER NOT NULL AUTO_INCREMENT,
										FechaRegistro datetime,
                                        IdRegistraOrden int,
                                        Tipo varchar(1),
                                        Columna varchar(50),
                                        ValorAnterior varchar (300),
                                        ValorNuevo varchar(300),
                                        Usuario int,
                                        UsuarioDB varchar (20),
                                        PRIMARY KEY (IdTracking));


-- Crear Primarykey                
Alter TABLE Tb_TrackingTarjetas ADD CONSTRAINT PK_IdTracking PRIMARY KEY (IdTracking);
Alter TABLE Tb_Tarjetas ADD CONSTRAINT PK_IdTarjetas PRIMARY KEY (IdTarjeta);
Alter TABLE Tb_CatEstatus ADD CONSTRAINT PK_IdEstatus PRIMARY KEY (IdEstatus);
Alter TABLE Tb_RegistraOrden ADD CONSTRAINT PK_IdRegistraOrden PRIMARY KEY (IdRegistraOrden); 
Alter TABLE Tb_Beneficiarios ADD CONSTRAINT PK_Id PRIMARY KEY (Id); 
Alter TABLE Tb_Cuentas ADD CONSTRAINT PK_IdCuenta PRIMARY KEY (IdCuenta); 
Alter TABLE Tb_CatClabeBancos ADD CONSTRAINT PK_IdCuenta PRIMARY KEY (IdClabe); 
Alter TABLE Tb_CatErrorRegistraOrden ADD CONSTRAINT PK_IdErrorRegistraOrden PRIMARY KEY (IdErrorRegistraOrden); 
Alter TABLE Tb_CatTipoCuenta ADD CONSTRAINT PK_IdTipoCuenta PRIMARY KEY (IdTipoCuenta); 
Alter TABLE Tb_CatOperante ADD CONSTRAINT PK_IdOperante PRIMARY KEY (IdOperante); 
Alter TABLE Tb_CatTipoPago ADD CONSTRAINT PK_IdTipoPago PRIMARY KEY (IdTipoPago); 

-- Crear ForeignKey
Alter TABLE Tb_TrackingTarjetas ADD CONSTRAINT FK_IdUsuario FOREIGN KEY (IdTarjeta)
REFERENCES Tb_Tarjetas(IdTarjeta);

Alter TABLE Tb_Tarjetas ADD CONSTRAINT FK_IdRegistraOrden_Tarjetas FOREIGN KEY (IdRegistraOrden)
REFERENCES Tb_RegistraOrden(IdRegistraOrden);

Alter TABLE Tb_Beneficiarios ADD CONSTRAINT FK_IdCuenta_Benefciarios FOREIGN KEY (IdCuenta)
REFERENCES Tb_Cuentas(IdCuenta);

Alter TABLE Tb_Cuentas ADD CONSTRAINT FK_IdClabe FOREIGN KEY (IdClabe)
REFERENCES Tb_CatClabeBancos(IdClabe);

Alter TABLE Tb_RegistraOrden ADD CONSTRAINT FK_IdEstatus FOREIGN KEY (IdEstatus)
REFERENCES Tb_CatEstatus (IdEstatus);

Alter TABLE Tb_RegistraOrden ADD CONSTRAINT FK_IdCuenta_RegistraOrden FOREIGN KEY (IdCuenta)
REFERENCES Tb_Cuentas(IdCuenta);

Alter TABLE Tb_RegistraOrden ADD CONSTRAINT FK_IdRegistraError FOREIGN KEY (IdErrorRegistraOrden)
REFERENCES Tb_CatErrorRegistraOrden(IdErrorRegistraOrden);

Alter TABLE Tb_RegistraOrden ADD CONSTRAINT FK_IdTipoPago FOREIGN KEY (IdTipoPago)
REFERENCES Tb_CatTipoPago(IdTipoPago);

Alter TABLE Tb_RegistraOrden ADD CONSTRAINT FK_IdTipoCuenta FOREIGN KEY (IdTipoCuenta)
REFERENCES Tb_CatTipoCuenta (IdTipoCuenta);

Alter TABLE Tb_RegistraOrden ADD CONSTRAINT FK_IdOperante FOREIGN KEY (IdOperante)
REFERENCES Tb_CatOperante (IdOperante);

Alter TABLE Tb_TrackingRegistraOrden ADD CONSTRAINT FK_IdRegistraOrden_Tracking FOREIGN KEY (IdRegistraOrden)
REFERENCES Tb_RegistraOrden (IdRegistraOrden);


-- Trigger Insert TB_RegistraOrden
DELIMITER $$
CREATE TRIGGER trigger_historico_insert_orden
AFTER INSERT ON TB_RegistraOrden
FOR EACH ROW
BEGIN
	INSERT INTO Tb_TrackingRegistraOrden(
										FechaRegistro,
                                        IdRegistraOrden,
                                        Tipo,
                                        Columna ,
                                        ValorAnterior,
                                        ValorNuevo,
                                        Usuario ,
                                        UsuarioDB)
	values (New.FechaRegistro,New.IdRegistraOrden,1,'Todas','N/A',
			Concat('Insertar valores: IdOrden:',
					new.IdOrden,' ClaveRastreo: ',
                    new.ClaveRastreo,' Referencia Numerica:',new.ReferenciaNumerica)
                    ,new.IdUsuario,'N/A');
END; $$

-- Trigger Update TB_RegistraOrden
DELIMITER $$
CREATE TRIGGER trigger_historico_Update_orden
AFTER Update ON TB_RegistraOrden
FOR EACH ROW
BEGIN
	INSERT INTO Tb_TrackingRegistraOrden(IdTracking,
										FechaRegistro,
                                        IdRegistraOrden,
                                        Tipo,
                                        Columna ,
                                        ValorAnterior,
                                        ValorNuevo,
                                        Usuario ,
                                        UsuarioDB)
	values (now(),New.IdRegistraOrden,1,'N/A En MYSQL',old.FechaRegistro,new.FechaRegistro,old.IdUsuario,'N/A');
END; $$

-- Trigger Delete TB_RegistraOrden
DELIMITER $$
CREATE TRIGGER trigger_historico_Delete_orden
AFTER Delete ON TB_RegistraOrden
FOR EACH ROW
BEGIN
	INSERT INTO Tb_TrackingRegistraOrden(IdTracking,
										FechaRegistro,
                                        IdRegistraOrden,
                                        Tipo,
                                        Columna ,
                                        ValorAnterior,
                                        ValorNuevo,
                                        Usuario ,
                                        UsuarioDB)
	values (now(),old.IdRegistraOrden,1,'N/A En MYSQL',old.FechaRegistro,old.FechaRegistro,old.IdUsuario,'N/A');
END; $$

-- Insert para Tb_CatEstatus
INSERT INTO Tb_CatEstatus (IdEstatus, Description, Status)
VALUES
    (1, 'Estatus1', 1),
    (2, 'Estatus2', 1),
    (3, 'Estatus3', 1),
    (4, 'Estatus4', 1),
    (5, 'Estatus5', 1),
    (6, 'Estatus6', 1);

-- Inserts para Tb_CatOperante
INSERT INTO Tb_CatOperante (IdOperante, CodigoOperante)
VALUES
    (1, 'Opr1'),
    (2, 'Opr2'),
    (3, 'Opr3'),
    (4, 'Opr3'),
    (5, 'Opr5'),
    (6, 'Opr6');

INSERT INTO Tb_CatClabeBancos (Id, FechaRegistro, FechaActualizacion, IdClabe, Participante, Status)
VALUES
    (1, now(), now(), '0001', 'Participante1', 1),
    (2, now(), now(), '0002', 'Participante2', 1),
    (3, now(), now(), '0003', 'Participante3', 1),
    (4, now(), now(), '0004', 'Participante4', 1),
    (5, now(), now(), '0005', 'Participante5', 1),
    (6, now(), now(), '0006', 'Participante6', 1);

-- Inserts para Tb_Cuentas
INSERT INTO Tb_Cuentas (IdCuenta, IdClabe, ClabeInterbancaria, Etiqueta, MontoMaximo, idUsuario, FechaRegistro, FechaActualizacion, Status, HashCuenta, TipoCuenta)
VALUES
    (1, '0001', 0x01, 'Cuenta1', 1000.00, 1, now(), now(), 1, 'Hash1', 1),
    (2, '0002', 0x02, 'Cuenta2', 2000.00, 2, now(), now(), 1, 'Hash2', 2),
    (3, '0003', 0x03, 'Cuenta3', 3000.00, 3, now(), now(), 1, 'Hash3', 3),
    (4, '0004', 0x04, 'Cuenta4', 4000.00, 4, now(), now(), 1, 'Hash4', 4),
    (5, '0005', 0x05, 'Cuenta5', 5000.00, 5, now(), now(), 1, 'Hash5', 5),
    (6, '0006', 0x06, 'Cuenta6', 6000.00, 6, now(), now(), 1, 'Hash6', 6);
    
-- Insert para Tb_CatErrorRegistraOrden
INSERT INTO Tb_CatErrorRegistraOrden (IdErrorRegistraOrden, FechaRegistro, Clave, Descripcion, Status)
VALUES
    (1, now(), 1, 'Error1', 1);

-- Insert para Tb_CatTipoPago
INSERT INTO Tb_CatTipoPago (IdTipoPago, FechaRegistro, Clave, Descripcion, Status)
VALUES
    (1, now(), 1, 'Tipo1', 1);

-- Insert para Tb_CatTipoCuenta
INSERT INTO Tb_CatTipoCuenta (IdTipoCuenta, FechaRegistro, Clave, Descripcion, Status)
VALUES
    (1, '2023-09-05', 1, 'TipoCuenta1', 1);


-- Inserts para Tb_RegistraOrden
INSERT INTO Tb_RegistraOrden (IdRegistraOrden,FechaRegistro,FechaActualizacion,IdOrden,IdUsuario,IdCuenta,Empresa,ClaveRastreo,ConceptoPago,Monto,ReferenciaNumerica,Firma,IdOperante,IdTipoCuenta,IdTipoPago,IdErrorRegistraOrden,Token,IdEstatus
)
VALUES
    (1, now(), now(), 'Orden1', 1, 1, 'Emp1', 'Clave1', 'Concepto1', 100.00, 'Ref1', 'Firma1', 1, 1, 1, 1, 'TokenOrden1', 1),
    (2, now(), now(), 'Orden2', 2, 2, 'Emp2', 'Clave2', 'Concepto2', 200.00, 'Ref2', 'Firma2', 2, 1, 1, 1, 'TokenOrden2', 1),
    (3, now(), now(), 'Orden3', 3, 3, 'Emp3', 'Clave3', 'Concepto3', 300.00, 'Ref3', 'Firma3', 3, 1, 1, 1, 'TokenOrden3', 1),
    (4, now(), now(), 'Orden4', 4, 4, 'Emp4', 'Clave4', 'Concepto4', 400.00, 'Ref4', 'Firma4', 4, 1, 1, 1, 'TokenOrden4', 1),
    (5, now(), now(), 'Orden5', 5, 5, 'Emp5', 'Clave5', 'Concepto5', 500.00, 'Ref5', 'Firma5', 5, 1, 1, 1, 'TokenOrden5', 1),
    (6, now(), now(), 'Orden6', 6, 6, 'Emp6', 'Clave6', 'Concepto6', 600.00, 'Ref6', 'Firma6', 6, 1, 1, 1, 'TokenOrden6', 1);
 

-- Insert para Tb_Tarjetas
INSERT INTO Tb_Tarjetas (IdTarjeta, FechaRegistro, FechaActualizacion, Tarjeta, Monto, ConfirmacionWS, MontoComision, ConfirmacionWSComision, IdUsuario, IdRegistraOrden, Token, Activo)
VALUES
    (1, now(), now(), 'Tarjeta1', 100.00, 'Confirmacion1', 10.00, 'ConfirmacionComision1', 1, 1, 'Token1', 1),
    (2, now(), now(), 'Tarjeta2', 200.00, 'Confirmacion2', 20.00, 'ConfirmacionComision2', 2, 2, 'Token2', 1),
    (3, now(), now(), 'Tarjeta3', 300.00, 'Confirmacion3', 30.00, 'ConfirmacionComision3', 3, 3, 'Token3', 1),
    (4, now(), now(), 'Tarjeta4', 400.00, 'Confirmacion4', 40.00, 'ConfirmacionComision4', 4, 4, 'Token4', 1),
    (5, now(), now(), 'Tarjeta5', 500.00, 'Confirmacion5', 50.00, 'ConfirmacionComision5', 5, 5, 'Token5', 1),
    (6, now(), now(), 'Tarjeta6', 600.00, 'Confirmacion6', 60.00, 'ConfirmacionComision6', 6, 6, 'Token6', 1);


-- Create Procesdure
DELIMITER $$
CREATE PROCEDURE INSERT_Tb_RegistraOrden (IdRegistraOrden int,
								FechaRegistro datetime,
                                FechaActualizacion datetime,
                                IdOrden varchar(30),
                                IdUsuario int,
                                IdCuenta int,
                                Empresa varchar(15),
                                ClaveRastreo varchar(30),
                                ConceptoPago varchar(210),
                                Monto numeric (19,2),
                                ReferenciaNumerica varchar(7),
                                Firma varchar(7),
                                IdOperante int,
                                IdTipoCuenta int,
                                IdTipoPago int,
                                IdErrorRegistraOrden int,
                                Token varchar(200),
                                IdEstatus int
								)
 BEGIN
 INSERT INTO TB_TarjetasSTP VALUES(IdRegistraOrden,
								FechaRegistro,
                                FechaActualizacion,
                                IdOrden,
                                IdUsuario,
                                IdCuenta,
                                Empresa,
                                ClaveRastreo,
                                ConceptoPago,
                                Monto,
                                ReferenciaNumerica,
                                Firma,
                                IdOperante,
                                IdTipoCuenta,
                                IdTipoPago,
                                IdErrorRegistraOrden,
                                Token,
                                IdEstatus);
 END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE INSERT_Tb_Tarjetas(
							IdTarjeta int,
							FechaRegistro datetime,
                            FechaActualizacion datetime,
                            Tarjeta varchar(16),
                            Monto numeric(19,2),
                            ConfirmacionWS varchar(100),
                            MontoComision numeric(19,2),
                            ConfirmacionWSComision varchar(200),
                            IdUsuario int,
                            IdRegistraOrden int,
                            Token varchar (200),
                            Activo bit)
 BEGIN 
 INSERT INTO Tb_Tarjetas VALUES(IdTarjeta,
							FechaRegistro,
                            FechaActualizacion,
                            Tarjeta,
                            Monto,
                            ConfirmacionWS,
                            MontoComision,
                            ConfirmacionWSComision,
                            IdUsuario,
                            IdRegistraOrden,
                            Token,
                            Activo);
 END$$
DELIMITER ;


-- Query1: Combinacion de Tablas
SELECT * From Tb_RegistraOrden
NATURAL left JOIN Tb_CatTipoPago
NATURAL left JOIN Tb_CatTipoCuenta
NATURAL left JOIN Tb_CatOperante
NATURAL left JOIN Tb_Cuentas;


-- Query2: Combinacion de tablas en un rango de ID_Orden
SELECT * FROM (SELECT IdRegistraOrden,IdOrden, IdCuenta,IdTipoCuenta FROM Tb_RegistraOrden) AS Registro
NATURAL  LEFT JOIN ( SELECT IdCuenta, ClabeInterbancaria FROM Tb_Cuentas) AS Cuenta 
LEFT JOIN (SELECT IdTipoCuenta, Descripcion FROM Tb_CatTipoCuenta) AS Tipo ON Registro.IdTipoCuenta = Tipo.IdTipoCuenta
WHERE  (Registro.IdRegistraOrden >= 3 ) AND (Registro.IdRegistraOrden <=6);

-- Query 3 Combinacion de tablas agrupadas por cuentas y su total de registros
SELECT Tb_Cuentas.IdCuenta,Count(*) as Total_OrdenesRegistro
FROM tb_cuentas
    INNER JOIN Tb_RegistraOrden ON TB_Cuentas.IdCuenta = Tb_RegistraOrden.IdCuenta
GROUP BY Tb_Cuentas.IDCuenta;

-- Query 4 
CREATE INDEX idx_Id_Orden_ASC ON Tb_RegistraOrden (IdOrden ASC,IdCuenta);

-- Query 5 Crear tabla temporal de Tb_RegistraOrden
Drop TEMPORARY TABLE Registros;
CREATE TEMPORARY TABLE Registros AS SELECT * FROM Tb_RegistraOrden;
SELECT * FROM Registros;