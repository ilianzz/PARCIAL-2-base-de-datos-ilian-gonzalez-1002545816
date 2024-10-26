use asopros_ventas;
-- cantidad minima, maxima y total vendida por producto
SELECT p.name AS product_name, MIN(od.quantity) AS min_quantity_sold, 
       MAX(od.quantity) AS max_quantity_sold, SUM(od.quantity) AS total_quantity_sold
FROM order_details od
INNER JOIN products p ON od.product_id = p.id
GROUP BY p.name;
