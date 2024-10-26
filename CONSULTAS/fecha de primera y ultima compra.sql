use asopros_ventas;
-- fecha de primera y ultima compra
SELECT c.name AS customer_name, MIN(o.order_date) AS first_order, MAX(o.order_date) AS last_order
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id
GROUP BY c.name;
