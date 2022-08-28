# View de productos y sus stock

create view view_stock_de_productos as
select p.Nombre as Producto, count(pv.IdProductoVenta) Cantidad from producto p 
inner join (pedidos pe, producto_en_venta pv)
on p.IdProducto = pe.IdProducto and pe.IdPedidos = pv.IdPedidos
where pv.IdProductoVenta not in (select c.IdProductoVenta from compra c) #Comprueba los productos que no hayan sido comprados
group by p.IdProducto;

# View de las ventas del mes

create view view_ventas_del_mes as
select c.Nombre Cliente, pr.Nombre Producto, cp.Fecha_venta Fecha,(pv.precio_venta -cp.descuento - cp.gasto_entrega) Precio
from cliente c
inner join (compra cp, producto_en_venta pv, pedidos p, producto pr)
on c.IdCliente = cp.IdCliente and cp.IdProductoVenta = pv.IdProductoVenta 
	and pv.IdPedidos = p.IdPedidos and p.IdProducto = pr.IdProducto
where extract(month FROM cp.Fecha_venta) = extract(month FROM now())
group by cp.IdCompra
;

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

create view view_ganancias_mes as
select sum(pv.precio_venta-c.descuento-c.gasto_entrega-e.Precio) Ganancia_total from compra c
inner join (producto_en_venta pv, pedidos pe, envio e)
on c.IdProductoVenta = pv.IdProductoVenta and pv.IdPedidos = pe.IdPedidos and pe.IdPedidos = e.IdPedidos
where extract(month FROM c.Fecha_venta) = extract(month FROM now())
group by c.IdCompra;





