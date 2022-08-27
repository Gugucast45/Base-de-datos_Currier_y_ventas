# Disminuir Stock cuando se realice una compra
delimiter &
create trigger trg_disminuir_stock after insert on compra
for each row
begin 
	update producto_en_venta set stock=stock - new.cantidad where new.IdProductoVenta = IdProductoVenta;
end &
delimiter ;