use asopros_ventas;
-- SUBCONSULTA CON LA CLAUSULA WHERE
-- 1: Productos que tienen stock mayor que el stock promedio de todos los productos
SELECT name, stock
FROM products
WHERE stock > (SELECT AVG(stock) FROM products);

-- 2: Órdenes donde el total es mayor al total promedio de todas las órdenes
use asopros_ventas;
SELECT id, total
FROM orders
WHERE total > (SELECT AVG(total) FROM orders);

-- 3: Clientes que tienen más de una orden
use asopros_ventas;
SELECT name, address_id
FROM customers
WHERE id IN (SELECT customer_id 
             FROM orders 
             GROUP BY customer_id 
             HAVING COUNT(*) > 1);
-- ------------------------------------------------------------
-- SUBCONSULTA CON LA CLAUSULA FROM
-- 1: Promedio de ventas por cliente
use asopros_ventas;
SELECT c.name, avg_orders.total_avg
FROM customers as c
JOIN (SELECT customer_id, AVG(total) AS total_avg
      FROM orders
      GROUP BY customer_id) avg_orders
ON c.id = avg_orders.customer_id;

-- 2: Productos con ventas totales por encima del promedio
use asopros_ventas;
SELECT p.name, total_sales.total
FROM products as p
JOIN (SELECT product_id, SUM(subtotal) AS total
      FROM order_details
      GROUP BY product_id) as total_sales
ON p.id = total_sales.product_id
WHERE total_sales.total > (SELECT AVG(total)
                           FROM (SELECT product_id, SUM(subtotal) AS total 
                                 FROM order_details 
                                 GROUP BY product_id) as avg_sales);

-- 3: Clientes con el total de pagos realizados
use asopros_ventas;
SELECT c.name, payments_total.paid
FROM customers as c
JOIN (SELECT o.customer_id, SUM(p.paid_amount) AS paid
      FROM payments as p
      JOIN orders as o ON p.order_id = o.id
      GROUP BY o.customer_id) as payments_total
ON c.id = payments_total.customer_id;
-- --------------------------------------------------------------
-- SUBCONSULTA CON LA CLAUSULA SELECT
-- 1: Nombre del cliente junto con el total de órdenes realizadas
use asopros_ventas;
SELECT name, (SELECT COUNT(*) 
              FROM orders 
              WHERE customer_id = customers.id) AS total_orders
FROM customers;

-- 2: Nombre de productos junto con el stock restante tras todas las ventas
use asopros_ventas;
SELECT name, stock - (SELECT SUM(quantity) 
                      FROM order_details 
                      WHERE product_id = products.id) AS stock_remaining
FROM products;

-- 3: Órdenes junto con el total de pagos realizados
use asopros_ventas;
SELECT o.id, (SELECT SUM(paid_amount) 
              FROM payments 
              WHERE order_id = o.id) AS total_paid
FROM orders as o;
-- --------------------------------------------------------------
-- SUBCNSULTA CON LA CLAUSULA IN 
-- 1: Productos que han sido comprados
use asopros_ventas;
SELECT name
FROM products
WHERE id IN (SELECT product_id FROM order_details);

-- 2: Órdenes que han sido completamente pagadas
use asopros_ventas;
SELECT id, total
FROM orders
WHERE id IN (SELECT order_id 
             FROM payments 
             GROUP BY order_id 
             HAVING SUM(paid_amount) >= (SELECT total FROM orders WHERE id = order_id));

-- 3: Clientes que han realizado pagos
use asopros_ventas;
SELECT name, address_id
FROM customers
WHERE id IN (SELECT o.customer_id 
             FROM orders as o 
             JOIN payments as p ON o.id = p.order_id);
-- --------------------------------------------------------------
-- SUBCONSULTA CON LA CLAUSULA EXISTS
-- 1: Productos que han sido comprados en al menos una orden
use asopros_ventas;
SELECT name
FROM products as p
WHERE EXISTS (SELECT 1 
              FROM order_details AS od 
              WHERE od.product_id = p.id);

-- 2: Clientes que han realizado alguna orden
use asopros_ventas;
SELECT name, address_id
FROM customers as c
WHERE EXISTS (SELECT 1 
              FROM orders as o 
              WHERE o.customer_id = c.id);

-- 3: Órdenes que tienen pagos asociadosuse asopros_ventas;
SELECT id, total
FROM orders as o
WHERE EXISTS (SELECT 1 
              FROM payments as p 
              WHERE p.order_id = o.id);
-- --------------------------------------------------------------
-- SUBCONSULTAS CON LA CLAUSULA ANY O ALL
-- 1: Órdenes donde el total es mayor que el total de cualquier orden del cliente con id 1
use asopros_ventas;
SELECT id, total
FROM orders
WHERE total > ANY (SELECT total FROM orders WHERE customer_id = 1);

-- 2: Productos cuyo precio es menor que el precio de todos los productos comprados por el cliente con id 2
use asopros_ventas;
SELECT name, price
FROM products
WHERE price < ALL (SELECT p.price 
                   FROM products as p 
                   JOIN order_details as od ON p.id = od.product_id 
                   JOIN orders o ON o.id = od.order_id 
                   WHERE o.customer_id = 2);

-- 3: Pagos cuyo monto es mayor al pago promedio de cualquier cliente
use asopros_ventas;
SELECT paid_amount
FROM payments
WHERE paid_amount > ANY (SELECT AVG(paid_amount) 
                         FROM payments 
                         GROUP BY order_id);
