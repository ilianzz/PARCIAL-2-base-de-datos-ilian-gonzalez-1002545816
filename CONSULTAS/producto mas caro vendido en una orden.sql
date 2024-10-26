use asopros_ventas;
-- producto mas caro vendido en una orden
SELECT p.name AS product_name, MAX(od.price) AS highest_price
FROM order_details od
INNER JOIN products p ON od.product_id = p.id
GROUP BY p.name
ORDER BY highest_price DESC
LIMIT 1;
