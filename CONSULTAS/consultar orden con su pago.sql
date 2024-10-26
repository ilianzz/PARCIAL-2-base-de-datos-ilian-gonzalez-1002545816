use asopros_ventas;
-- consulta ordenes con sus pagos
SELECT o.id AS order_id, p.payment_method, p.paid_amount
FROM orders o
INNER JOIN payments p ON o.id = p.order_id;
