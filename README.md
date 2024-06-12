# Santiago Sandoval Torres
## Consultas
1. Obtener la lista de todos los productos con sus precio
```SQL
SELECT nombre AS Producto, precio AS Precio
FROM productos;
```
```
+-------------------------+---------+
| Producto                | Precio  |
+-------------------------+---------+
| iPhone 13               |  799.99 |
| Samsung Galaxy S21      |  699.99 |
| Sony WH-1000XM4         |  349.99 |
| MacBoock Pro            | 1299.99 |
| Dell XPS 13             |  999.99 |
| GoPro HERO9             |  399.99 |
| Amazon Echo Dot         |   49.99 |
| Kindle Paperwhite       |  129.99 |
| Apple Watch Series 7    |  399.99 |
| Bose QuietComfort 35 II |  299.99 |
| Nintendo Switch         |  299.99 |
| Fibit Charge 5          |  179.95 |
+-------------------------+---------+
12 rows in set (0,01 sec)
```
2. Encontrar todos los pedidos realizados por un usuario específico, por ejemplo, Juan Perez
```SQL
SELECT P.id, P.fecha AS FechaPedido, P.total AS Total
FROM usuarios U 
INNER JOIN pedidos P ON U.id = P.id_usuario
WHERE U.nombre = 'Juan Perez';
```
```
+----+-------------+---------+
| id | FechaPedido | Total   |
+----+-------------+---------+
|  1 | 2024-02-25  | 1049.98 |
+----+-------------+---------+
1 row in set (0,00 sec)
```
3. Listar los detalles de todos los pedidos, incluyendo el nombre del producto, cantidad y precio unitario
```SQL
SELECT DP.id_pedido AS PedidoID, PR.nombre AS Producto, DP.cantidad, DP.precio_unitario
FROM productos AS PR
INNER JOIN detallespedidos DP ON PR.id = DP.id_producto
INNER JOIN pedidos P ON DP.id_pedido = P.id;
```
```
+----------+-------------------------+----------+-----------------+
| PedidoID | Producto                | cantidad | precio_unitario |
+----------+-------------------------+----------+-----------------+
|        1 | iPhone 13               |        1 |          799.99 |
|        1 | Amazon Echo Dot         |        5 |           49.99 |
|        2 | MacBoock Pro            |        1 |         1299.99 |
|        2 | Kindle Paperwhite       |        1 |          129.99 |
|        3 | Samsung Galaxy S21      |        1 |          699.99 |
|        3 | Apple Watch Series 7    |        1 |          399.99 |
|        4 | Dell XPS 13             |        1 |          999.99 |
|        4 | Bose QuietComfort 35 II |        1 |          299.99 |
|        5 | Sony WH-1000XM4         |        1 |          349.99 |
|        5 | Nintendo Switch         |        1 |          299.99 |
|        6 | GoPro HERO9             |        1 |          399.99 |
+----------+-------------------------+----------+-----------------+
11 rows in set (0,00 sec)
```
4. Calcular el total gastado por cada usuario en todos sus pedidos
```SQL
SELECT U.nombre AS Usuario, SUM(DP.cantidad * DP.precio_unitario) AS TotalGastado
FROM detallespedidos DP
INNER JOIN pedidos P ON DP.id_pedido = P.id
INNER JOIN usuarios U ON P.id_usuario = U.id
GROUP BY P.id_usuario;
```
```
+----------------+--------------+
| Usuario        | TotalGastado |
+----------------+--------------+
| Juan Perez     |      1049.94 |
| Maria Lopez    |      1429.98 |
| Carlos Mendoza |      1099.98 |
| Ana Gonzalez   |      1299.98 |
| Luis Torres    |       649.98 |
| Laura Rivera   |       399.99 |
+----------------+--------------+
6 rows in set (0,00 sec)
```
5. Encontrar los productos más caros (precio mayor a $500)
```SQL
SELECT nombre, precio
FROM productos 
WHERE precio > 500;
```
```
+--------------------+---------+
| nombre             | precio  |
+--------------------+---------+
| iPhone 13          |  799.99 |
| Samsung Galaxy S21 |  699.99 |
| MacBoock Pro       | 1299.99 |
| Dell XPS 13        |  999.99 |
+--------------------+---------+
4 rows in set (0,01 sec)
```
6. Listar los pedidos realizados en una fecha específica, por ejemplo, 2024-03-10
```SQL
SELECT id, id_usuario, fecha, total
FROM pedidos
WHERE fecha = '2024-03-10';
```
```
+----+------------+------------+---------+
| id | id_usuario | fecha      | total   |
+----+------------+------------+---------+
|  2 |          2 | 2024-03-10 | 1349.98 |
+----+------------+------------+---------+
1 row in set (0,00 sec)
```
7. Obtener el número total de pedidos realizados por cada usuario
```SQL
SELECT U.nombre AS Nombre, COUNT(P.id_usuario) AS NroPedidos
FROM usuarios U
INNER JOIN pedidos P ON U.id = P.id_usuario
GROUP BY P.id_usuario;
```
```
+----------------+------------+
| Nombre         | NroPedidos |
+----------------+------------+
| Juan Perez     |          1 |
| Maria Lopez    |          1 |
| Carlos Mendoza |          1 |
| Ana Gonzalez   |          1 |
| Luis Torres    |          1 |
| Laura Rivera   |          1 |
+----------------+------------+
6 rows in set (0,00 sec)
```
8. Encontrar el nombre del producto más vendido (mayor cantidad total vendida)
```SQL
SELECT PR.nombre AS Producto, SUM(DP.cantidad) AS CantidadTotal
FROM detallespedidos DP
INNER JOIN productos PR ON DP.id_producto = PR.id
GROUP BY DP.id_producto
ORDER BY CantidadTotal DESC LIMIT 1;
```
```
+-----------------+---------------+
| Producto        | CantidadTotal |
+-----------------+---------------+
| Amazon Echo Dot |             5 |
+-----------------+---------------+
1 row in set (0,00 sec)
```

9. Listar todos los usuarios que han realizado al menos un pedido
```SQL
SELECT U.nombre AS Usuario, U.correo_electronico AS Email
FROM pedidos P
INNER JOIN usuarios U ON P.id_usuario = U.id;
```
```
+----------------+----------------------------+
| Usuario        | Email                      |
+----------------+----------------------------+
| Juan Perez     | juan.perez@example.com     |
| Maria Lopez    | maria.lopez@example.com    |
| Carlos Mendoza | carlos.mendoza@example.com |
| Ana Gonzalez   | ana.gonzalez@example.com   |
| Luis Torres    | luis.torres@example.com    |
| Laura Rivera   | laura.rivera@example.com   |
+----------------+----------------------------+
6 rows in set (0,00 sec)
```
10. Obtener los detalles de un pedido específico,específico, incluyendo los productos y cantidades, porejemplo, pedido con id 1
```SQL
SELECT DP.id_pedido AS PedidoID, U.nombre AS Usuario, PR.nombre AS Producto, DP.cantidad, DP.precio_unitario
FROM detallespedidos DP
INNER JOIN pedidos P ON DP.id_pedido = P.id
INNER JOIN usuarios U ON P.id_usuario = U.id
INNER JOIN productos PR ON DP.id_producto = PR.id
WHERE DP.id_pedido = 1;
```
```
+----------+------------+-----------------+----------+-----------------+
| PedidoID | Usuario    | Producto        | cantidad | precio_unitario |
+----------+------------+-----------------+----------+-----------------+
|        1 | Juan Perez | iPhone 13       |        1 |          799.99 |
|        1 | Juan Perez | Amazon Echo Dot |        5 |           49.99 |
+----------+------------+-----------------+----------+-----------------+
2 rows in set (0,00 sec)
```
## Subconsultas
1. Encontrar el nombre del usuario que ha gastado más en total
```SQL
SELECT Usuario
FROM
(SELECT U.nombre AS Usuario, SUM(DP.cantidad * DP.precio_unitario) AS TotalGastado
FROM detallespedidos DP
INNER JOIN pedidos P ON DP.id_pedido = P.id
INNER JOIN usuarios U ON P.id_usuario = U.id
GROUP BY P.id_usuario
ORDER BY TotalGastado DESC LIMIT 1) AS S;
```
```
+-------------+
| Usuario     |
+-------------+
| Maria Lopez |
+-------------+
1 row in set (0,00 sec)
```
2. Listar los productos que han sido pedidos al menos una vez
```SQL
SELECT nombre AS Producto
FROM productos
WHERE id IN (
    SELECT id_producto
    FROM detallespedidos
);
```
```
+-------------------------+
| Producto                |
+-------------------------+
| iPhone 13               |
| Samsung Galaxy S21      |
| Sony WH-1000XM4         |
| MacBoock Pro            |
| Dell XPS 13             |
| GoPro HERO9             |
| Amazon Echo Dot         |
| Kindle Paperwhite       |
| Apple Watch Series 7    |
| Bose QuietComfort 35 II |
| Nintendo Switch         |
+-------------------------+
11 rows in set (0,00 sec)
```
3. Obtener los detalles del pedido con el total más alto
```SQL
SELECT id, id_usuario, fecha, total
FROM pedidos 
WHERE id = (
    SELECT P2.id
    FROM pedidos AS P2
    ORDER BY total DESC LIMIT 1
);
```
```
+----+------------+------------+---------+
| id | id_usuario | fecha      | total   |
+----+------------+------------+---------+
|  2 |          2 | 2024-03-10 | 1349.98 |
+----+------------+------------+---------+
1 row in set (0,00 sec)
```

4. Listar los usuarios que han realizado más de un pedido
```SQL
SELECT nombre
FROM usuarios 
WHERE id IN(SELECT id_usuario
FROM pedidos
GROUP BY id
HAVING COUNT(id) > 1);
```
```
Empty set (0,00 sec)
```
5. Encontrar el producto más caro que ha sido pedido al menos una vez
```SQL
SELECT nombre AS Producto, precio 
FROM productos
WHERE id IN (
    SELECT id_producto
    FROM detallespedidos
) AND precio = (
    SELECT MAX(precio)
    FROM productos
);
```
```
+--------------+---------+
| Producto     | precio  |
+--------------+---------+
| MacBoock Pro | 1299.99 |
+--------------+---------+
1 row in set (0,00 sec)
```
## Procedimientos Almacenados
### Crear un procedimiento almacenado para agregar un nuevo producto
***Enunciado: Crea un procedimiento almacenado llamado AgregarProducto que reciba como parámetros el nombre, descripción y precio de un nuevo producto y lo inserte en la tabla Productos .***

```SQL
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
```

### Crear un procedimiento almacenado para obtener los detalles de un pedido
***Enunciado: Crea un procedimiento almacenado llamado ObtenerDetallesPedido que reciba como parámetro el ID del pedido y devuelva los detalles del pedido, incluyendo el nombre del producto, cantidad y precio unitario***

```SQL
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
```


### Crear un procedimiento almacenado para actualizar el precio de un producto
***Enunciado: Crea un procedimiento almacenado llamado ActualizarPrecioProducto que reciba como parámetros el ID del producto y el nuevo precio, y actualice el precio del producto en la tabla Productos***
```SQL
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
```

### Crear un procedimiento almacenado para eliminar un producto
***Enunciado: Crea un procedimiento almacenado llamado EliminarProducto que reciba como parámetro el ID del producto y lo elimine de la tabla Productos***
```SQL
DELIMITER $$
CREATE PROCEDURE EliminarProducto(
    IN idAborrar INT
)BEGIN
    DELETE FROM productos WHERE id = idAborrar;
    SELECT 'Producto Eliminado Correctamente';
END $$
DELIMITER ;
```
### Crear un procedimiento almacenado para obtener el total gastado por un usuario
***Enunciado: Crea un procedimiento almacenado llamado TotalGastadoPorUsuario que reciba como parámetro el ID del usuario y devuelva el total gastado por ese usuario en todos sus pedidos.***
```SQL
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
```