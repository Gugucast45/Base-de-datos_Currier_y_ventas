use currier_ventas;
# Inserts de Estados
insert into estado (Nombre)
values("En reparto");
insert into estado (Nombre)
values("Disponible");
insert into estado (Nombre)
values("Vendido");
insert into estado (Nombre)
values("Cancelado");
#Inserts de Clientes
insert into cliente (Nombre, Ciudad, Telefono)
values("Gustavo Guzmán","Guayaquil","0963226586");


insert into currier (Nombre, Telefono)
values("JD",1);
insert into pedidos(Numero_Pedido,Pagina_compra,Precio_venta)
values("123123123","amazon",41);
insert into envio (Peso, Precio, IdCurrier, IdPedidos)
values(1,1,1,1);
