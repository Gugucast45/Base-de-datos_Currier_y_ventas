drop database if exists emprendimiento;
create database if not exists emprendimiento ;
use emprendimiento;

-- Creacion de las tablas

create table if not exists Cliente(
	IdCliente int primary key not null auto_increment,
    Nombre varchar(100) not null,
    Telefono char(10) not null
);

create table if not exists Producto(
	IdProducto int not null auto_increment,
    Nombre varchar(80) not null,
    primary key (IdProducto)
);
create table if not exists Stock(
	IdStock int primary key not null auto_increment,
    cantidad int not null,
    check(cantidad>=0)
);
create table if not exists Producto_en_venta(
	IdProductoVenta int primary key not null auto_increment,
	IdPedidos int not null,
    precio_venta decimal(5,2) not null,
    IdStock int not null,
    foreign key (IdPedidos) references Pedidos(IdPedidos),
    foreign key (IdStock) references Stock(IdStock),
    check(precio_venta>=0)
);

create table if not exists Compra(
	IdCompra int primary key not null auto_increment,
    IdCliente int not null,
    IdProductoVenta int not null,
    Fecha_venta date not null,
    cantidad int not null,
    descuento decimal(4,2) not null default(0),
    gasto_entrega decimal(4,2) not null default(0),
    foreign key (IdCliente) References Cliente(IdCliente),
    foreign key (IdProductoVenta) References Producto_en_venta(IdProductoVenta),
    check(cantidad>0)
);

create table if not exists Currier(
	IdCurrier int not null auto_increment,
    Nombre varchar(50),
    Telefono char(10),
    primary key (IdCurrier)
);

create table if not exists Seguimiento(
	IdSeguimiento int not null auto_increment,
    Numero_Pedido varchar(20) not null,
    Fecha_pedido date not null,
    Fecha_entrega_USA date,
    Fecha_entrega_ECU date,
    primary key (IdSeguimiento,Numero_Pedido)
);
create table if not exists Inconveniente(
	IdInconveniente int not null auto_increment,
    Descripcion varchar(200) not null,
    IdSeguimiento int not null,
    Numero_Pedido varchar(20) not null,
    primary key (IdInconveniente),
    foreign key (IdSeguimiento,Numero_Pedido) References Seguimiento(IdSeguimiento,Numero_Pedido)
);

create table if not exists Pagina(
	Nombre varchar(30) primary key not null
);

create table if not exists Pedidos(
	IdPedidos int not null auto_increment,
    Precio_compra decimal(5,2) not null,
    IdProducto int not null,
    IdSeguimiento int not null,
	Numero_Pedido varchar(20) not null,
    Nombre_Pagina varchar(30) not null,
    primary key (IdPedidos),
    foreign key (IdSeguimiento,Numero_Pedido) References Seguimiento(IdSeguimiento,Numero_Pedido),
    foreign key (IdProducto) References Producto(IdProducto),
    foreign key (Nombre_Pagina) References Pagina(Nombre),
    check (Precio_compra >0)
);

create table if not exists Envio(
	IdEnvio int not null auto_increment,
    Peso decimal(4,2) not null,
    Precio decimal(5,2) not null,
    IdCurrier int not null,
    IdPedidos int not null,
    primary key (IdEnvio),
    foreign key (IdPedidos) References Pedidos(IdPedidos),
    foreign key (IdCurrier) References Currier(IdCurrier),
    check (Peso>=0 and Precio>=0)
);

			
    





