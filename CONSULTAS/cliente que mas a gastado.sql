use asopros_ventas;
-- cliente que mas a gastado
SELECT c.name AS customer_name, MAX(total_spent) AS max_spent
FROM (SELECT c.name, SUM(o.total) AS total_spent
      FROM customers c
      INNER JOIN orders o ON c.id = o.customer_id
      GROUP BY c.name) AS customer_spending
ORDER BY max_spent DESC
LIMIT 1;
