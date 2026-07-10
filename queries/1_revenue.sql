-- Monthly revenue from completed orders
SELECT
    DATE_TRUNC('month', o.order_date)::date AS month,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS monthly_revenue
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed'
GROUP BY month
ORDER BY month;

-- Average order value
SELECT
    ROUND(SUM(oi.quantity * oi.unit_price) / COUNT(DISTINCT o.order_id), 2) AS average_order_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
WHERE o.status = 'completed';

-- Revenue by order status
SELECT
    o.status,
    COUNT(DISTINCT o.order_id) AS number_of_orders,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS total_value
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY o.status
ORDER BY total_value DESC;
