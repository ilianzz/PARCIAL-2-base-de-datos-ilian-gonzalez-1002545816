use asopros_ventas;
-- monto total pagado por cada cliente
SELECT c.name AS customer_name, SUM(p.paid_amount) AS total_paid
FROM customers c
INNER JOIN orders o ON c.id = o.customer_id
INNER JOIN payments p ON o.id = p.order_id
GROUP BY c.name;
