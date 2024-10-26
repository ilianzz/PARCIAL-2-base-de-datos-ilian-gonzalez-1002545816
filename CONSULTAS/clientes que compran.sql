use asopros_ventas;
-- los clientes que compran
SELECT c.name AS customer_name, COUNT(o.id) AS total_orders
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id
GROUP BY c.name;
