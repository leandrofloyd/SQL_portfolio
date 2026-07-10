-- Best-selling products by revenue
SELECT
    p.product_name,
    p.category,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.product_name, p.category
ORDER BY revenue DESC
LIMIT 10;

-- Revenue by category
SELECT
    p.category,
    SUM(oi.quantity) AS units_sold,
    ROUND(SUM(oi.quantity * oi.unit_price), 2) AS revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'completed'
GROUP BY p.category
ORDER BY revenue DESC;

-- Products with low sales volume
SELECT
    p.product_id,
    p.product_name,
    p.category,
    COALESCE(SUM(oi.quantity), 0) AS units_sold
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.order_id AND o.status = 'completed'
GROUP BY p.product_id, p.product_name, p.category
ORDER BY units_sold ASC;
