-- Customers with more than one completed order
WITH completed_orders AS (
    SELECT
        customer_id,
        COUNT(*) AS completed_order_count
    FROM orders
    WHERE status = 'completed'
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS customers_with_completed_orders,
    SUM(CASE WHEN completed_order_count > 1 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(
        100.0 * SUM(CASE WHEN completed_order_count > 1 THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS repeat_customer_rate_percent
FROM completed_orders;
