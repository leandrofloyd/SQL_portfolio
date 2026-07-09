-- Top 10 customers by revenue
SELECT
    c.customer_id,
    c.customer_name,
    c.country,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY c.customer_id, c.customer_name, c.country
ORDER BY total_revenue DESC
LIMIT 10;
