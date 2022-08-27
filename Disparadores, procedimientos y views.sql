# Disminuir Stock cuando se realice una compra

delimiter &
create trigger trg_disminuir_stock after insert on compra
for each row
begin 
	update producto_en_venta set stock=stock - new.cantidad where new.IdProductoVenta = IdProductoVenta;
end &
delimiter ;

# View de las ventas del mes

create view view_ventas_del_mes as
-- Se presenta El nombre del cliente producto, cantidad, precio, descuento y precio final
select cl.Nombre as Cliente,p.Nombre as Producto, c.cantidad as Cantidad, pv.precio_venta as Precio,
 c.descuento as Descuento, (Precio-Descuento) as Precio_final
from producto p
inner join (producto_en_venta pv, compra c, cliente cl)
on p.IdProducto = pv.IdProducto and pv.IdProductoVenta = c.IdProductoVenta and c.IdCliente = cl.IdCliente
group by c.IdCompra;

# View de los pedidos del mes

create view view_pedidos_del_mes as
select s.Numero_Pedido Npedido, pr.Nombre Producto, p.Precio_compra Precio
from producto pr 
inner join (pedidos p,seguimiento s)
on pr.IdProducto = p.IdProducto and p.IdSeguimiento = s.IdSeguimiento 
	and s.Numero_Pedido =p.Numero_Pedido
where extract(month FROM s.Fecha_pedido) = extract(month FROM now())
group by p.IdPedidos;

# View ganancias 