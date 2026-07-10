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

-- Interval (days) between first and second completed order
WITH customer_orders AS (
    SELECT
        customer_id,
        order_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS order_number
    FROM orders
    WHERE status = 'completed'
),
first_second AS (
    SELECT
        customer_id,
        MAX(CASE WHEN order_number = 1 THEN order_date END) AS first_order_date,
        MAX(CASE WHEN order_number = 2 THEN order_date END) AS second_order_date
    FROM customer_orders
    WHERE order_number <= 2
    GROUP BY customer_id
)
SELECT
    customer_id,
    first_order_date,
    second_order_date,
    second_order_date - first_order_date AS days_to_second_order
FROM first_second
WHERE second_order_date IS NOT NULL
ORDER BY days_to_second_order;
