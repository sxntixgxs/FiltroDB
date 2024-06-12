-- Procedimientos
--Crea un procedimiento almacenado llamado AgregarProducto que reciba como parámetros el nombre, descripción y precio de un nuevo producto y lo inserte en la tabla Productos 
DELIMITER $$
CREATE PROCEDURE AgregarProducto(
    IN nnombre VARCHAR(100),
    IN ndescripcion TEXT,
    IN nprecio DECIMAL(10,2)
)BEGIN
    INSERT INTO productos(nombre,descripcion,precio) VALUES
    (nnombre,ndescripcion,nprecio);
    SELECT 'Producto agregado correctamente';
END $$
DELIMITER ;
CALL AgregarProducto('Bad Bunny','Conejo malvado',66.6);

-- Crea un procedimiento almacenado llamado ObtenerDetallesPedido que reciba como parámetro el ID del pedido y devuelva los detalles del pedido, incluyendo el nombre del producto, cantidad y precio unitario

DELIMITER $$
CREATE PROCEDURE ObtenerDetallesPedido(
    IN pedidoABuscar INT
)BEGIN
    SELECT PR.nombre AS Producto, DP.cantidad AS Cantidad, DP.precio_unitario AS PrecioUnit
    FROM detallespedidos DP
    INNER JOIN productos PR ON DP.id_producto = PR.id
    WHERE DP.id_pedido = pedidoABuscar;
END $$
DELIMITER ;
CALL ObtenerDetallesPedido(1);

-- Crea un procedimiento almacenado llamado ActualizarPrecioProducto que reciba como parámetros el ID del producto y el nuevo precio, y actualice el precio del producto en la tabla Productos
DELIMITER $$
CREATE PROCEDURE ActualizarPrecioProducto(
    IN idProductoActualizar INT,
    IN nuevoPrecio DECIMAL(10,2)
)BEGIN
    UPDATE productos
    SET precio = nuevoPrecio
    WHERE id = idProductoActualizar;
    SELECT 'Producto Actualizado';
END $$
DELIMITER ;
CALL ActualizarPrecioProducto(13,999.99);

-- Crea un procedimiento almacenado llamado EliminarProducto que reciba como parámetro el ID del producto y lo elimine de la tabla Productos

DELIMITER $$
CREATE PROCEDURE EliminarProducto(
    IN idAborrar INT
)BEGIN
    DELETE FROM productos WHERE id = idAborrar;
    SELECT 'Producto Eliminado Correctamente';
END $$
DELIMITER ;
CALL EliminarProducto(13);
-- Crea un procedimiento almacenado llamado TotalGastadoPorUsuario que reciba como parámetro el ID del usuario y devuelva el total gastado por ese usuario en todos sus pedidos.

DELIMITER $$
CREATE PROCEDURE TotalGastadoPorUsuario(
    IN userAConsultar INT
)BEGIN
    SELECT U.nombre AS Usuario, SUM(P.total) AS TotalGastado
    FROM pedidos P
    INNER JOIN usuarios U ON P.id_usuario = U.id
    WHERE P.id_usuario = userAConsultar
    GROUP BY P.id_usuario;
END $$
DELIMITER ;
CALL TotalGastadoPorUsuario(1);