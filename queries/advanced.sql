-- Monthly revenue and month-over-month growth
WITH monthly_revenue AS (
    SELECT
        DATE_TRUNC('month', o.order_date)::date AS month,
        ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    WHERE o.status = 'completed'
    GROUP BY month
),
revenue_with_lag AS (
    SELECT
        month,
        revenue,
        LAG(revenue) OVER (ORDER BY month) AS previous_month_revenue
    FROM monthly_revenue
)
SELECT
    month,
    revenue,
    previous_month_revenue,
    ROUND(
        100.0 * (revenue - previous_month_revenue) / NULLIF(previous_month_revenue, 0),
        2
    ) AS month_over_month_growth_percent
FROM revenue_with_lag
ORDER BY month;
