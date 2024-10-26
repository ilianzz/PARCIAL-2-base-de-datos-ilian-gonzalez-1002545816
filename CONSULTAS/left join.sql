use asopros_ventas;
-- devolverá todos los productos y si existen sus detalles en las órdenes realizadas
-- si no tienen ningun producto registrado en la tabla el valor sera null
SELECT p.name, od.quantity, od.subtotal
FROM products p
LEFT JOIN order_details od ON p.id = od.product_id;
