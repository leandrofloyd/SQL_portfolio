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

-- Revenue by country
SELECT
    c.country,
    COUNT(DISTINCT c.customer_id) AS number_of_customers,
    COUNT(DISTINCT o.order_id) AS completed_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY c.country
ORDER BY revenue DESC;

-- Customer segmentation by total spending
WITH customer_spending AS (
    SELECT
        c.customer_id,
        c.customer_name,
        ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_spent
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_spent,
    CASE
        WHEN total_spent >= 2000 THEN 'High value'
        WHEN total_spent >= 750 THEN 'Medium value'
        ELSE 'Low value'
    END AS customer_segment
FROM customer_spending
ORDER BY total_spent DESC;
