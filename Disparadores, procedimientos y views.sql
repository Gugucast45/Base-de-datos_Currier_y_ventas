# Disminuir Stock cuando se realice una compra

delimiter &
create trigger trg_disminuir_stock after insert on compra
for each row
begin 
	set @buscar_stock = (Select distinct(s.IdStock) from compra c 
						inner join (producto_en_venta pv, Stock s)
                        on c.IdProductoVenta = pv.IdProductoVenta and pv.IdStock = s.IdStock
                        where pv.IdProductoVenta= new.IdProductoVenta);
	update stock set cantidad=cantidad - new.cantidad where @buscar_stock = IdStock;
end &
delimiter ;

# View de las ventas del mes

create view view_ventas_del_mes as
-- Se presenta El nombre del cliente producto, cantidad, precio, descuento y precio final
select cl.Nombre as Cliente,p.Nombre as Producto, c.cantidad as Cantidad, pv.precio_venta as Precio,
 c.descuento as Descuento,c.gasto_entrega as Gasto_entrega, (Precio-Descuento-Gasto_entrega) as Precio_final
from producto p
inner join (pedidos pe, producto_en_venta pv, compra c, cliente cl)
on p.IdProducto = pe.IdProducto and pe.IdPedidos = pv.IdPedidos and 
pv.IdProductoVenta = c.IdProductoVenta and c.IdCliente = cl.IdCliente
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

# View ganancias del mes

create view view_ganancias_del_mes as 
select sum(pv.precio_venta*c.cantidad - c.descuento - c.gasto_entrega-e.Precio*c.cantidad) as Ganancia_mes from compra c
inner join (producto_en_venta pv, pedidos pe, envio e)
on c.IdProductoVenta =pv.IdProductoVenta and pv.IdPedidos = pe.IdPedidos
and pe.IdPedidos = e.IdPedidos
where extract(month FROM c.Fecha_venta) = extract(month FROM now())
group by c.IdCompra; 

#

