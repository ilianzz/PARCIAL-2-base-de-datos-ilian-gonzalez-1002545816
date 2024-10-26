use asopros_ventas;
-- devolveremos todas las órdenes y si existen los clientes asociados.
SELECT o.id AS order_id, c.name AS customer_name, o.total
FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.id;
