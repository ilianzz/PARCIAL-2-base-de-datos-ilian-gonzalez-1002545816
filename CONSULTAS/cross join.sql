use asopros_ventas;
-- una combinación de todos los productos con todos los clientes
SELECT p.name AS product_name, c.name AS customer_name
FROM products p
CROSS JOIN customers c;
