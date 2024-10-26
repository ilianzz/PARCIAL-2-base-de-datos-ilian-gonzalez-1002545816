use asopros_ventas;
-- ventas totales por cada cliente
SELECT c.name AS customer_name, SUM(o.total) AS total_spent
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id
GROUP BY c.name;
