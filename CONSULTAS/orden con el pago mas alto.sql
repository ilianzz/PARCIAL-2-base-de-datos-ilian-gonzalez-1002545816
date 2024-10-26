use asopros_ventas;
-- orden con el pago mas alto
SELECT o.id AS order_id, MAX(p.paid_amount) AS max_payment
FROM orders o
INNER JOIN payments p ON o.id = p.order_id
GROUP BY o.id
ORDER BY max_payment DESC
LIMIT 1;
