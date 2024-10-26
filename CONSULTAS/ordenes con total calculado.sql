use asopros_ventas;
-- consulta de ordenes con total calculado
SELECT o.id AS order_id, SUM(od.subtotal) AS calculated_total
FROM orders o
INNER JOIN order_details od ON o.id = od.order_id
GROUP BY o.id;
