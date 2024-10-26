use asopros_ventas;
-- promedio de cantidad de productos por orden
SELECT o.id AS order_id, AVG(od.quantity) AS average_quantity_per_order
FROM orders o
INNER JOIN order_details od ON o.id = od.order_id
GROUP BY o.id;
