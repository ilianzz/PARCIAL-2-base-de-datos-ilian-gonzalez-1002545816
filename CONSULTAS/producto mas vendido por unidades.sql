use asopros_ventas;
-- producto mas vendido por unidades
SELECT p.name AS product_name, MAX(total_sold) AS max_units_sold
FROM (SELECT p.name, SUM(od.quantity) AS total_sold
      FROM order_details od
      INNER JOIN products p ON od.product_id = p.id
      GROUP BY p.name) AS product_sales
ORDER BY max_units_sold DESC
LIMIT 1;
