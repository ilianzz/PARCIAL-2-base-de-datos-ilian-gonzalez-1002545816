use asopros_ventas;
-- el total de ventas por producto
SELECT p.name AS product_name, SUM(od.quantity) AS total_sold, SUM(od.subtotal) AS total_sales
FROM order_details od
INNER JOIN products p ON od.product_id = p.id
GROUP BY p.name;
