-- -- Consultas
-- 1. Obtener la lista de todos los productos con sus precio
SELECT nombre AS Producto, precio AS Precio
FROM productos;
-- 2. Encontrar todos los pedidos realizados por un usuario específico, por ejemplo, Juan Perez
SELECT P.id, P.fecha AS FechaPedido, P.total AS Total
FROM usuarios U 
INNER JOIN pedidos P ON U.id = P.id_usuario
WHERE U.nombre = 'Juan Perez';

-- 3. Listar los detalles de todos los pedidos, incluyendo el nombre del producto, cantidad y precio unitario
SELECT DP.id_pedido AS PedidoID, PR.nombre AS Producto, DP.cantidad, DP.precio_unitario
FROM productos AS PR
INNER JOIN detallespedidos DP ON PR.id = DP.id_producto
INNER JOIN pedidos P ON DP.id_pedido = P.id;

-- 4. Calcular el total gastado por cada usuario en todos sus pedidos
SELECT U.nombre AS Usuario, SUM(DP.cantidad * DP.precio_unitario) AS TotalGastado
FROM detallespedidos DP
INNER JOIN pedidos P ON DP.id_pedido = P.id
INNER JOIN usuarios U ON P.id_usuario = U.id
GROUP BY P.id_usuario;

-- 5. Encontrar los productos más caros (precio mayor a $500)

SELECT nombre, precio
FROM productos 
WHERE precio > 500;

-- 6. Listar los pedidos realizados en una fecha específica, por ejemplo, 2024-03-10

SELECT id, id_usuario, fecha, total
FROM pedidos
WHERE fecha = '2024-03-10';

--7. Obtener el número total de pedidos realizados por cada usuario

SELECT U.nombre AS Nombre, COUNT(P.id_usuario) AS NroPedidos
FROM usuarios U
INNER JOIN pedidos P ON U.id = P.id_usuario
GROUP BY P.id_usuario;

-- 8. Encontrar el nombre del producto más vendido (mayor cantidad total vendida)

SELECT PR.nombre AS Producto, SUM(DP.cantidad) AS CantidadTotal
FROM detallespedidos DP
INNER JOIN productos PR ON DP.id_producto = PR.id
GROUP BY DP.id_producto
ORDER BY CantidadTotal DESC LIMIT 1;

-- 9. Listar todos los usuarios que han realizado al menos un pedido

SELECT U.nombre AS Usuario, U.correo_electronico AS Email
FROM pedidos P
INNER JOIN usuarios U ON P.id_usuario = U.id;

-- 10. Obtener los detalles de un pedido específico,específico, incluyendo los productos y cantidades, porejemplo, pedido con id 1
SELECT DP.id_pedido AS PedidoID, U.nombre AS Usuario, PR.nombre AS Producto, DP.cantidad, DP.precio_unitario
FROM detallespedidos DP
INNER JOIN pedidos P ON DP.id_pedido = P.id
INNER JOIN usuarios U ON P.id_usuario = U.id
INNER JOIN productos PR ON DP.id_producto = PR.id
WHERE DP.id_pedido = 1;

-- Subconsultas
-- 1. Encontrar el nombre del usuario que ha gastado más en total

SELECT Usuario
FROM
(SELECT U.nombre AS Usuario, SUM(DP.cantidad * DP.precio_unitario) AS TotalGastado
FROM detallespedidos DP
INNER JOIN pedidos P ON DP.id_pedido = P.id
INNER JOIN usuarios U ON P.id_usuario = U.id
GROUP BY P.id_usuario
ORDER BY TotalGastado DESC LIMIT 1) AS S;


-- 2. Listar los productos que han sido pedidos al menos una vez

SELECT nombre AS Producto
FROM productos
WHERE id IN (
    SELECT id_producto
    FROM detallespedidos
);

-- 3. Obtener los detalles del pedido con el total más alto
SELECT id, id_usuario, fecha, total
FROM pedidos 
WHERE id = (
    SELECT P2.id
    FROM pedidos AS P2
    ORDER BY total DESC LIMIT 1
);

-- 4. Listar los usuarios que han realizado más de un pedido

SELECT nombre
FROM usuarios 
WHERE id IN(SELECT id_usuario
FROM pedidos
GROUP BY id
HAVING COUNT(id) > 1);

-- 5. Encontrar el producto más caro que ha sido pedido al menos una vez
SELECT nombre AS Producto, precio 
FROM productos
WHERE id IN (
    SELECT id_producto
    FROM detallespedidos
) AND precio = (
    SELECT MAX(precio)
    FROM productos
);