use asopros_ventas;
SELECT o.id AS order_id, c.name AS customer_name, o.total
FROM orders o
RIGHT JOIN customers c ON o.customer_id = c.id;
